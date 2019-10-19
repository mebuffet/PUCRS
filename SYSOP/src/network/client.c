#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <netdb.h>
#include <stdio.h>
#include <string.h>
#include <signal.h>
#include <ctype.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <arpa/inet.h>
#define SIZE 20
#define BYTES 1024
#define PORT 5000
int min(int x1,int x2);
int main(int argc,char *argv[])
{
	int sockfd=0,count=0,cont=0,nBytes=SIZE,loop=0;;
	char recvBuff[BYTES],recvBuff10[10],sendBuff[SIZE]="pedido.txt";
	struct sockaddr_in serv_addr;
	if(argc!=2)
	{
		printf("[Client] Usage: %s <ip of server>\n",argv[0]);
		return 1 ;
	}
	memset(recvBuff,'0',sizeof(recvBuff));
	if((sockfd=socket(AF_INET,SOCK_STREAM,0))<0)
	{
		printf("[Client] Failed to obtain socket descriptor.\n");
		return 1;
	}
	else
		printf("[Client] Obtaining socket descriptor successfully.\n");
	memset(&serv_addr,'0',sizeof(serv_addr));
	serv_addr.sin_family=AF_INET;
	serv_addr.sin_port=htons(PORT);
	if(inet_pton(AF_INET,argv[1],&serv_addr.sin_addr)<=0)
	{
		printf("[Client] Error occurred: inet_pton.\n");
		return 1;
	}
	if(connect(sockfd,(struct sockaddr*)&serv_addr,sizeof(serv_addr))<0)
	{
		printf("[Client] Failed to connect to the host!\n");
		return 1;
	}
	else
		printf("[Client] Connected to server at port %d and address %s.\n",PORT,argv[1]);
	/* Send File Name to Server */
	while(nBytes>cont)
	{
		count=send(sockfd,sendBuff,sizeof(sendBuff)-1,0);
		cont+=count;
	}
	nBytes=10;
	cont=0;
	count=0;
	/* Get File Size from Server */
	while(nBytes>cont-1)
	{
		count=recv(sockfd,recvBuff10,sizeof(recvBuff10),0);
		cont+=count;
		fflush(stdout);
		break;
	}
	char arq_final[SIZE]="entrega.txt";
	FILE* arq=fopen(arq_final,"w");
	if(!arq)
	{
		printf("[Client] File %s cannot be created on client.\n",arq_final);
			return 1;
	}
	int fileSize=atoi(recvBuff10);
	nBytes=BYTES;
	cont=0;
	count=0;
	while(fileSize>cont)
	{
		int bytesLeft=fileSize-loop*nBytes,i;
		count=recv(sockfd,recvBuff,sizeof(recvBuff),0);
		cont+=count;
		fflush(stdout);
		for(i=0.;i<sizeof(recvBuff);i++)
		{
			if(recvBuff[i]=='\0')
			{
				recvBuff[i]='#';
			}
		}
		fwrite(recvBuff,1,min(sizeof(recvBuff),bytesLeft),arq);
		loop++;
	}
	printf("[Client] File received from server!\n");
	fclose(arq);
	close (sockfd);
	printf("[Client] Connection lost.\n");
	return 0;
}
int min(int x1,int x2)
{
	if(x1<x2)
		return x1;
		return x2;
}
