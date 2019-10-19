#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<netinet/ip_icmp.h>
#include<netinet/tcp.h>
#include<netinet/if_ether.h>
#include<arpa/inet.h>
#include<unistd.h>

struct sockaddr_in source, dest;

void sniff_tcp_packet(unsigned char* buffer) {
    struct iphdr *iph = (struct iphdr*)(buffer + sizeof(struct ethhdr));
    struct tcphdr *tcph=(struct tcphdr*)(buffer + (iph->ihl*4) + sizeof(struct ethhdr));
    struct ethhdr *eth = (struct ethhdr*)buffer;
    memset(&source, 0, sizeof(source));
    source.sin_addr.s_addr = iph->saddr;
    memset(&dest, 0, sizeof(dest));
    dest.sin_addr.s_addr = iph->daddr;
    printf("\n\n***********************TCP Packet*************************\n");
    printf("\nEthernet Header\n");
    printf("   |-Destination Address : %.2X-%.2X-%.2X-%.2X-%.2X-%.2X\n", eth->h_dest[0], eth->h_dest[1], eth->h_dest[2], eth->h_dest[3], eth->h_dest[4], eth->h_dest[5]);
    printf("   |-Source Address      : %.2X-%.2X-%.2X-%.2X-%.2X-%.2X\n", eth->h_source[0], eth->h_source[1], eth->h_source[2], eth->h_source[3], eth->h_source[4], eth->h_source[5]);
    printf("   |-Protocol            : %u\n", (unsigned short)eth->h_proto);
    printf("\nIP Header\n");
    printf("   |-IP Version        : %d\n", (unsigned int)iph->version);
    printf("   |-IP Header Length  : %d DWORDS or %d Bytes\n", (unsigned int)iph->ihl,((unsigned int)(iph->ihl))*4);
    printf("   |-Type Of Service   : %d\n", (unsigned int)iph->tos);
    printf("   |-IP Total Length   : %d  Bytes(Size of Packet)\n", ntohs(iph->tot_len));
    printf("   |-Identification    : %d\n", ntohs(iph->id));
    printf("   |-TTL      : %d\n", (unsigned int)iph->ttl);
    printf("   |-Protocol : %d\n", (unsigned int)iph->protocol);
    printf("   |-Checksum : %d\n", ntohs(iph->check));
    printf("   |-Source IP        : %s\n", inet_ntoa(source.sin_addr));
    printf("   |-Destination IP   : %s\n", inet_ntoa(dest.sin_addr));
    printf("\nTCP Header\n");
    printf("   |-Source Port      : %u\n", ntohs(tcph->source));
    printf("   |-Destination Port : %u\n", ntohs(tcph->dest));
    printf("   |-Sequence Number    : %u\n", ntohl(tcph->seq));
    printf("   |-Acknowledge Number : %u\n", ntohl(tcph->ack_seq));
    printf("   |-Header Length      : %d DWORDS or %d BYTES\n" , (unsigned int)tcph->doff, (unsigned int)tcph->doff*4);
    printf("   |-Urgent Flag          : %d\n", (unsigned int)tcph->urg);
    printf("   |-Acknowledgement Flag : %d\n", (unsigned int)tcph->ack);
    printf("   |-Push Flag            : %d\n", (unsigned int)tcph->psh);
    printf("   |-Reset Flag           : %d\n", (unsigned int)tcph->rst);
    printf("   |-Synchronise Flag     : %d\n", (unsigned int)tcph->syn);
    printf("   |-Finish Flag          : %d\n", (unsigned int)tcph->fin);
    printf("   |-Window         : %d\n", ntohs(tcph->window));
    printf("   |-Checksum       : %d\n", ntohs(tcph->check));
    printf("   |-Urgent Pointer : %d\n", tcph->urg_ptr);
    printf("\n###########################################################");
}
 
int main() {
    int saddr_size , data_size;
    struct sockaddr saddr;
    unsigned char *buffer = (unsigned char*)malloc(65536);
    int sock_raw = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
    setsockopt(sock_raw, SOL_SOCKET, SO_BINDTODEVICE, "eth0", strlen("eth0")+1);
    while(1) {
        saddr_size = sizeof saddr;
        data_size = recvfrom(sock_raw, buffer, 65536, 0, &saddr, (socklen_t*)&saddr_size);
        if(data_size < 0) {
            printf("Recvfrom error , failed to get packets\n");
            return 1;
        }
        sniff_tcp_packet(buffer);
    }
    close(sock_raw);
    return 0;
}
