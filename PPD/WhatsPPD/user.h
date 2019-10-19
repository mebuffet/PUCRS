#ifndef USER_HEADER
#define USER_HEADER

#include <stdio.h>
#include <string.h>

#include "grupo.h"

typedef struct user {
	char userName[16];
	char file_name[26];
	int nContatos;
	int nGrupos;
	struct contact contatos[8];
	struct group grupos[8];
} user;

void _createUser(struct user* new, char* name);
int ContactExist(struct user* u, char* name, char* ip);
int ContactwithNameExist(struct user* u, char* name);
int ContactwithNameIP(struct user* u, char* ip);
int GroupwithNameExist(struct user* u, char* name);
void AddGroup(struct user* u, char* name, char to[7][16], char to_ip[7][16], int size);
void AddGroupRcv(struct user* u, char* name, char to[7][16], char to_ip[7][16], int size, char *from, char* ip);
void AddContact(struct user* u, char* name, char* ip);
int loadUser(struct user *usuario, char* user_fileName);
int saveUser(struct user *usuario, char* user_fileName);
void printUserContacts(struct user *usuario);
void DEBUG_printUser(struct user *usuario);

#endif
