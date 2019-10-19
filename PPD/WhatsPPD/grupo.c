#include "grupo.h"

void _createGroup(struct group* new, char* name, char to[7][16], char to_ip[7][16], int size) {
	int i;
	sprintf(new->_name,"#%s",name);
	sprintf(new->file_name, "Messages/%s.msg", new->_name);
	for(i = 0; i < size; i++)
		_createContact(&(new->contatos[i]), to[i], to_ip[i]);
	new->nContatos = size;
}

void _createGroupRcv(struct group* new, char* name, char to[7][16], char to_ip[7][16], int size, char* from, char* ip, char* username) {
	int i , j = 1;
	sprintf(new->_name,"#%s",name);
	sprintf(new->file_name, "Messages/%s.msg", new->_name);
	_createContact(&(new->contatos[0]), from, ip);
	for(i = 0; i < size; i++) {
		if(!strcmp(username,to[i]))
			continue;
		_createContact(&(new->contatos[j]), to[i], to_ip[i]);
		j++;
	}
	new->nContatos = size;
}

void saveGroup(FILE* file, struct group* grupo) {
	int i;
	fwrite(grupo->_name, sizeof(grupo->_name), 1, file);
	fwrite(grupo->file_name, sizeof(grupo->file_name), 1, file);
	fwrite(&(grupo->nContatos), sizeof(int), 1, file);
	for(i = 0; i < grupo->nContatos; i++)
		saveContact(file, &(grupo->contatos[i]));
}

void loadGroup(FILE* file , struct group* grupo) {
	int i;
	fread(grupo->_name, sizeof(grupo->_name), 1, file);
	fread(grupo->file_name, sizeof(grupo->file_name), 1, file);
	fread(&(grupo->nContatos), sizeof(int), 1, file);
	for(i = 0; i < grupo->nContatos; i++)
		loadContact(file, &(grupo->contatos[i]));
}
