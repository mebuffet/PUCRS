#ifndef CONTATO_HEADER
#define CONTATO_HEADER

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct contact {
	char _name[16];
	char _ip[16];
	char file_name[26];
} contact;

void _createContact(struct contact* new, char* name, char* ip);
void saveContact(FILE* file ,struct contact* contato);
void loadContact(FILE* file ,struct contact* contato);
void _listMsgs(struct contact* contact_list, char* name, int nContatos);

#endif
