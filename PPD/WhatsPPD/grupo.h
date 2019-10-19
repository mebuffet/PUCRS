#ifndef GRUPO_HEADER
#define GRUPO_HEADER

#include <stdio.h>

#include "contato.h"

typedef struct group {
	char _name[16];
	char file_name[26];
	int nContatos;
	struct contact contatos[8];
} group;

void _createGroup(struct group* new, char* name, char to[7][16], char to_ip[7][16], int size);
void _createGroupRcv(struct group* new, char* name, char to[7][16], char to_ip[7][16], int size, char* from, char* ip, char* username);
void saveGroup(FILE* file, struct  group* grupo);
void loadGroup(FILE* file ,struct group* grupo);

#endif
