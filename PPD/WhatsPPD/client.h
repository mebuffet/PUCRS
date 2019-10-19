#ifndef CLIENT_HEADER
#define CLIENT_HEADER

#include <netdb.h>
#include <netinet/in.h>
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/types.h>

#include "utils.h"
#include "mensagem.h"

typedef struct clientInfo {
	char host_ip[16];
	struct message *msg;
} clientInfo;

int allocInfo(struct clientInfo *new, char* ip, struct message* ptr);
int initClient(struct clientInfo* info);

#endif
