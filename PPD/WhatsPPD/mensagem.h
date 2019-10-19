#ifndef MENSAGEM_HEADER
#define MENSAGEM_HEADER

#include <stdio.h>

#include "contato.h"

#define TAM_MAX_MSG 33

/** STATUS DA MSG **/
#define CRIADA 0
#define ENVIADA 1
#define LIDA 2

/** TIPOS DE MSG **/
#define MSG_TXT 0
#define MSG_TXT_GROUP 1
#define ADD_CONTACT 2
#define ADD_GROUP 3
#define READ_MSGS 4
#define READ_MSGS_GROUP 5
#define RET_MSG_OK 6
#define RET_MSG_FAIL 7
#define RET_MSG_GROUP_OK 8
#define RET_MSG_GROUP_FAIL 9

typedef struct message {
	int tipo;
	char msg[TAM_MAX_MSG];
	char from[16];
	char to[7][16];
	char to_ip[7][16];
	char group_name[16];
	int nro_contatos;
	int estado;
} message;

void _createTxtMessage(struct message* new, char* from, char* phrase);
void _createGroupTxtMessage(struct message* new, char* from, char* phrase, int nro_contatos, char* group_name);
void _createAddContactMessage(struct message* new, char* from);
void _createAddGroupMessage(struct message* new, char* from, int nro_contatos, char to[7][16], char to_ip[7][16], char* group_name);
void _createResponseMessage(struct message* new, char* from, int status, char* phrase);
void _createResponseMessageGroup(struct message* new, char* from, int status, char* phrase);
void _createListMessage(struct message* new, char* from);
void _createListMessageGroup(struct message* new, char* from, char* group_name);

#endif
