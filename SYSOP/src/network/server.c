#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <netdb.h>
#include <sys/wait.h>
#include <signal.h>
#include <string.h>
#include <sys/types.h>
#include <time.h>
#include <ctype.h>
#define SIZE 20
#define BYTES 1024
#define PORT 5000
int getFileSize(char *fileName);
int min(int x1,int x2);
int main(int argc,char *argv[])
{
	int listenfd=0,connfd=0;
	struct sockaddr_in serv_addr;
	char sendBuff[BYTES],sendBuff10[10],recvBuff[SIZE];
	/* Get the Socket file descriptor */
	listenfd=socket(AF_INET,SOCK_STREAM,0);
	if(listenfd==-1)
	{
		printf("[Server] Failed to obtain socket descriptor.\n");
		return 1;
	}
	else
		printf("[Server] Obtaining socket descriptor successfully.\n");
	memset(&serv_addr,'0',sizeof(serv_addr));
	memset(sendBuff,'0',sizeof(sendBuff));
	serv_addr.sin_family=AF_INET;
	serv_addr.sin_addr.s_addr=htonl(INADDR_ANY);
	serv_addr.sin_port=htons(PORT);
	/* Bind a special Port */
	if(bind(listenfd,(struct sockaddr*)&serv_addr,sizeof(serv_addr))==-1)
	{
		printf("[Server] Failed to bind port.\n");
		return 1;
	}
	else
		printf("[Server] Binded tcp port %d sucessfully.\n",PORT);
	/* Listen remote connect/calling */
	if(listen(listenfd,10)==-1)
	{
		printf("[Server] Failed to listen port.\n");
		return 1;
	}
	else
		printf ("[Server] Listening the port %d successfully.\n", PORT);
	while(1)
	{
		connfd=accept(listenfd,(struct sockaddr*)NULL,NULL);
		if(connfd==-1)
		{
			printf("[Server] Failed to obtain new socket descriptor.\n");
			return 1;
		}
		else
			printf("[Server] Server has got connected.\n");
		int count=0,numberBytes=SIZE,contador=0,loop=0;
		//get file name from client
		while(contador<numberBytes-1)
		{
			count=recv(connfd,recvBuff,sizeof(recvBuff)-1,0);
			contador+=count;
			printf("[Server] File name to be opened:\t%s\n",recvBuff);
			fflush(stdout);
		}
		numberBytes=10;
		contador=0;
		count=0;
		int fileSize=getFileSize(recvBuff);
		sprintf(sendBuff10,"%d",fileSize);
		//send file size to client
		while(numberBytes>contador-1)
		{
			count=send(connfd,sendBuff10,sizeof(sendBuff10),0);
			contador+=count;
			fflush(stdout);
			break;
		}
		FILE* arq=fopen(recvBuff,"r");
		if(!arq)
		{
			printf("[Server] File %s cannot be opened on server.\n",recvBuff);
			return 1;
		}
		numberBytes=BYTES;
		contador=0;
		count=0;
		while(fileSize>contador)
		{
			int bytesLeft=fileSize-loop*numberBytes;
			fread(sendBuff,1,min(sizeof(sendBuff),bytesLeft),arq);
			count=send(connfd,sendBuff,sizeof(sendBuff),0);
			contador+=count;
			fflush(stdout);
			loop++;
		}
		fclose(arq);
		close(connfd);
		printf("[Server] Connection with client closed. Server will wait now...\n");
	}
	printf("[Server] File was sent to client!\n");
}
int getFileSize(char *fileName)
{
	FILE* filePointer=fopen(fileName,"r");
	if(!filePointer)
	{
		printf("[Server] File %s cannot be opened on server.\n",fileName);
		return -1;
	}
	fseek(filePointer,0,SEEK_END);
	int size=ftell(filePointer);
	fseek(filePointer,0,SEEK_SET);
	fclose(filePointer);
	return size;
}
int min(int x1,int x2)
{
	if(x1<x2)
		return x1;
		return x2;
}
