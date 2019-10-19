#include "mensagem.h"

/** Construtor de mensagem de texto **/
void _createTxtMessage(struct message* new, char* from, char* phrase) {
	new->tipo = MSG_TXT;
	sprintf(new->from, "%s", from);
	sprintf(new->msg, "%s", phrase);
	new->estado = CRIADA;
}

void _createGroupTxtMessage(struct message* new, char* from, char* phrase, int nro_contatos, char* group_name) {
	new->tipo = MSG_TXT_GROUP;
	sprintf(new->from, "%s", from);
	sprintf(new->msg, "%s", phrase);
	new->nro_contatos = nro_contatos;
	sprintf(new->group_name, "%s", group_name);
	new->estado = CRIADA;
}

/** Construtor de mensagem de inserção de contato **/
void _createAddContactMessage(struct message* new, char* from) {
	new->tipo = ADD_CONTACT;
	sprintf(new->from, "%s", from);
	new->estado = CRIADA;
}

/** Construtor de mensagem de inserção de contato **/
void _createAddGroupMessage(struct message* new, char* from, int nro_contatos, char to[7][16], char to_ip[7][16], char* group_name) {
	int i;
	new->tipo = ADD_GROUP;
	sprintf(new->from, "%s", from);
	new->nro_contatos = nro_contatos;
	sprintf(new->group_name, "%s", group_name);
	for(i=0;i<nro_contatos;i++) {
		sprintf(new->to[i], "%s", to[i]);
		sprintf(new->to_ip[i], "%s", to_ip[i]);
	}
	new->estado = CRIADA;
}

/** Construtor de mensagem de retorno **/
void _createResponseMessage(struct message* new, char* from, int status, char* phrase) {
	if(status) new->tipo = RET_MSG_OK;
	else new->tipo = RET_MSG_FAIL;
	sprintf(new->from, "%s", from);
	sprintf(new->msg, "%s", phrase);
	new->estado = CRIADA;
}

void _createResponseMessageGroup(struct message* new, char* from, int status, char* phrase) {
	if(status) new->tipo = RET_MSG_GROUP_OK;
	else new->tipo = RET_MSG_GROUP_FAIL;
	sprintf(new->from, "%s", from);
	sprintf(new->msg, "%s", phrase);
	new->estado = CRIADA;
}

void _createListMessage(struct message* new, char* from) {
	new->tipo = READ_MSGS;
	sprintf(new->from, "%s", from);
	new->estado = CRIADA;
}

void _createListMessageGroup(struct message* new, char* from, char* group_name) {
	new->tipo = READ_MSGS_GROUP;
	sprintf(new->from, "%s", from);
	sprintf(new->group_name, "%s", group_name);
	new->estado = CRIADA;
}
