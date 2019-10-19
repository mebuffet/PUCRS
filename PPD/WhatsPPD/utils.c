#include "utils.h"

/** Login de usuario **/
void Login(char* user_fileName) {
	extern int errn;
	extern struct user usuario;
	char login[16];

	/** Leitura do nome do usuario pelo terminal **/
	printf("\t\t\tWhatsPPD\nUsuario:");
	fgets(login,sizeof(login),stdin);
	login[strlen(login)-1] = '\0'; // Adiciona caracter nulo no final do nome do usuario
	/** Verifica se usuario já existe **/
	sprintf(user_fileName,"%s.u",login);
	if(searchUser(user_fileName)) {
		/** Carrega o usuario **/
		if(!loadUser(&usuario, user_fileName)) {
			errn = 1;
			atexit(exitWithERROR);
			return;	
		}
		sprintf(user_fileName,"Users/%s.u",login);
	}
	/** Senão cria usuario **/
	else {
		sprintf(user_fileName,"Users/%s.u",login);
		_createUser(&usuario,login);
		if(!saveUser(&usuario, user_fileName)) {
			errn = 2;
			atexit(exitWithERROR);
		}
	}
}

/** Executa comando de listar mensagens de um contato **/
int executeCommandList(struct user* usuario, char* string) {
	FILE* file;
	int index, i, len;
	char RX[40],name[16];
	struct message msg;
	struct clientInfo info;

	memset(RX,'\0',40);

	/** Identifica o nome do contato **/
	for(i=3;i<strlen(string);i++) {
		if(string[i] != '\n')
			name[i-3] = string[i];
		else {
			name[i-3] = '\0';
			break;
		}
	}
	if(name[0] == '#') {
		/** Se contato existe **/
		if((index = GroupwithNameExist(usuario,name)) >=0 ) {
			/** Abre o arquivo de mensagens **/
			if((file = fopen(usuario->grupos[index].file_name, "rb+")) == NULL)
				return 1;
			while(fread(RX, 40, 1, file) > 0) {
				/** e escreve as mensagens no terminal **/
				printf("%s",RX);
				memset(RX,'\0',40);
				if(feof(file))
					break;
			}
			/** volta para o inicio do arquivo **/
			fseek(file, 0, SEEK_SET);
			while(fread(RX, 40, 1, file) > 0) {
				/** verifica se é uma mensagem recebida **/
				if(RX[0] == '<') {
					len = strlen(RX);
					/** verifica se é uma mensagem que já foi lida **/
					if(RX[len-2] == '*' && RX[len-3] == '*')
						continue;
					else {
						/** adiciona o 2° '*' ao final da mensagem **/
						RX[len-1] = '*';
						RX[len] = '\n';
						RX[len+1] = '\0';
						fseek(file, (-40*sizeof(char)), SEEK_CUR);
						fwrite(RX, sizeof(RX), 1, file);
					}
				}
				memset(RX,'\0',40);
				if(feof(file))
					break;
			}
			close(file);
			printf("\n");
			/** envia para o contato sinal para atualizar os '*' do arquivo dele **/
			_createListMessageGroup(&msg, usuario->userName, usuario->grupos[index]._name);
			for(i = 0; i < usuario->grupos[index].nContatos;i++) {
				allocInfo(&info, usuario->grupos[index].contatos[i]._ip, &msg);
				initClient(&info);
			}
		}
		/** Senão informa que contato não existe **/
		else printf("Grupo inexistente\n");
		return 0;
	}
	else {
		/** Se contato existe **/
		if((index = ContactwithNameExist(usuario,name)) >=0 ) {
			/** Abre o arquivo de mensagens **/
			if((file = fopen(usuario->contatos[index].file_name, "rb+")) == NULL)
				return 1;
			while(fread(RX, 40, 1, file) > 0) {
				/** e escreve as mensagens no terminal **/
				printf("%s",RX);	
				memset(RX,'\0',40);
				if(feof(file))
					break;
			}
			/** volta para o inicio do arquivo **/
			fseek(file, 0, SEEK_SET);
			while(fread(RX, 40, 1, file) > 0) {
				/** verifica se é uma mensagem recebida **/
				if(RX[0] == '<') {
					len = strlen(RX);
					/** verifica se é uma mensagem que já foi lida **/
					if(RX[len-2] == '*' && RX[len-3] == '*')
						continue;
					else {
						/** adiciona o 2° '*' ao final da mensagem **/
						RX[len-1] = '*';
						RX[len] = '\n';
						RX[len+1] = '\0';
						fseek(file, (-40*sizeof(char)), SEEK_CUR);
						fwrite(RX, sizeof(RX), 1, file);
					}
				}
				memset(RX,'\0',40);
				if(feof(file))
					break;
			}
			close(file);
			printf("\n");
			/** envia para o contato sinal para atualizar os '*' do arquivo dele **/
			_createListMessage(&msg, usuario->userName);
			allocInfo(&info, usuario->contatos[index]._ip, &msg);
			initClient(&info);
		}
		/** Senão informa que contato não existe **/
		else printf("Contato inexistente\n");
		return 0;
	}
}

/** Executa comando de inserção de contato **/
void executeCommandInsertion(struct user* usuario, char* string, int nArgs, char* fileName) {
	extern int errn;
	struct message msg;
	struct clientInfo info;
	char name[16],ip[16];
	int blank_location = 0, i =0;

	memset(ip,'\0',sizeof(ip));
	memset(name,'\0',sizeof(name));

	/** Identifica nome e ip do contato **/
	if(nArgs == 1) {
		for(i=3;i<strlen(string);i++) {
			if(string[i] == ' ')
				blank_location = i;
			else {
				if(blank_location > 0) {
					ip[i-blank_location-1] = string[i];
					if(string[i] == '\n'){ 
						ip[i-blank_location-1] = '\0';
						break;
					}
				}
				else
					name[i-3] = string[i];
			}
		}
		/** Verifica existência de contato com este nome ou IP **/
		if(!((ContactExist(usuario,name,ip)) > -1 )) {
			/** Envia mensagem de inserção de contato para o contato **/
			_createAddContactMessage(&msg, usuario->userName);
			allocInfo(&info, ip, &msg);
			/** Se o contato permitir a inserção **/
			if(initClient(&info)) {
				//TODO: verificar se retorno é 2 salvar em arquivo de pendentes, se for 1 faz oq esta abaixo
				/** contato é adicionado **/
				AddContact(usuario, name, ip);
				if(!saveUser(usuario, fileName)) {
					errn = 2;
					atexit(exitWithERROR);
				}
			}
		}
	}
	else printf("\t\t    Comando Invalido\n");
	blank_location = 0;
}

/** Executa comando de inserção de grupo **/
void executeCommandInsertionGroup(struct user* usuario, char* string, int nArgs, char* fileName) {
	extern int errn;
	struct message msg;
	struct clientInfo info;
	char name[7][16], ip[7][16], group_name[16];
	int blank_location = 0, i, cont = 0, aux = 0, stopped = 0, index;

	memset(ip,'\0',sizeof(ip));
	memset(name,'\0',sizeof(name));
	memset(group_name,'\0',sizeof(group_name));

	/** Identifica nome e ip do contato **/
	if(nArgs <= 8) {
		for(i = 3; i < strlen(string); i++) {
			if(string[i] != ' ')
				group_name[i-3] = string[i];
			else
				break;
		}
		stopped = i + 1;
		for(i = stopped; i < strlen(string); i++) {
			if(string[i] == '\n')
				break;
			if(string[i] == ' ') {
				blank_location = i;
				cont++;
			}
			else {
				if(!cont)
					name[cont][i-stopped] = string[i];
				else
					name[cont][i-blank_location-1] = string[i];
			}
		}
		cont = 0;
		for(i = 0; i < nArgs; i++) {
			/** Verifica existência de contato com este nome **/
			if(((index = ContactwithNameExist(usuario,name[i]))) < 0) {
				printf("O usuario %s nao esta na lista de contatos, favor adiciona-lo.\n", name[i]);
				return 0;
			}
			else {
				strcpy(ip[i], usuario->contatos[index]._ip);
				cont++;
			}
		}
		if(cont == nArgs) {
			aux = 0;
			for(i = 0; i < nArgs; i++) {
				_createAddGroupMessage(&msg, usuario->userName, nArgs, name, ip, group_name);
				allocInfo(&info, ip[i], &msg);
				aux = aux + initClient(&info);
			}
			if(aux == nArgs) {
				AddGroup(usuario, group_name, name, ip, nArgs);
				if(!saveUser(usuario, fileName)){
					errn = 2;
					atexit(exitWithERROR);
				}
			}
		}	
	}
}

/** Executa comando de envio de mensagem **/
void executeCommandSend(struct user* usuario, char* string, int nArgs, char* fileName) {
	extern int errn;
	struct message msg;
	struct clientInfo info;
	char name[16], phrase[TAM_MAX_MSG], file_name[26];
	char msg_received[40];
	int blank_location = 0, i, loc = -1, maxout=0, len, aux = 0;

	FILE* msgfile;
		
	memset(name,'\0',sizeof(name));
	memset(msg_received,'\0',sizeof(msg_received));
	memset(phrase,'\0',sizeof(phrase));

	/** Identifica nome do contato e mensagem a ser enviada **/
	if(nArgs >= 1) {
		for(i=3;i<strlen(string);i++) {
			if(string[i] == ' ' && blank_location == 0)
				blank_location = i;
			else {
				if(blank_location > 0) {
					if(maxout < TAM_MAX_MSG-1) {
						phrase[i-blank_location-1] = string[i];
						maxout ++;
					}
					else {
						phrase[31] = '\n';
						phrase[32] = '\0';
						break;
					}
					if(string[i] == '\n') {
						phrase[i-blank_location-1] = '\0';
						break;
					}
				}
				else
					name[i-3] = string[i];
			}
		}
		if(name[0] == '#') {
			if((loc = GroupwithNameExist(usuario, name)) >= 0) {
				for(i = 0; i < usuario->grupos[loc].nContatos; i++) {
					_createGroupTxtMessage(&msg, usuario->userName, phrase, usuario->grupos[loc].nContatos, name);
					allocInfo(&info, usuario->grupos[loc].contatos[i]._ip, &msg);
					aux = aux + initClient(&info);
				}
				if(aux == usuario->grupos[loc].nContatos) {
					sprintf(file_name,"Messages/%s.msg",name);
					msgfile = fopen(file_name, "ab");
					sprintf(msg_received, "--> %s",msg.msg);
					len = strlen(msg_received);
					msg_received[len] = ' ';
					msg_received[len+1] = '*';
					msg_received[len+2] = '\n';
					fwrite(msg_received, sizeof(msg_received), 1, msgfile);
					fflush(msgfile);
					close(msgfile);
					memset(msg_received,'\0',sizeof(msg_received));
				}
			}
		}
		else {
			/** Verifica existencia de contato com nome dado **/
			if((loc = ContactwithNameExist(usuario, name)) >= 0) {
				/** Envia mensagem de texto para o contato **/
				_createTxtMessage(&msg, usuario->userName, phrase);
				allocInfo(&info, usuario->contatos[loc]._ip, &msg);
				/** Se contato recebeu a mensagem **/
				if(initClient(&info)) {
					//TODO: veridficar se retorno é 2 salvar em arquivo de pendentes, se for 1 faz oq esta abaixo
					/** Salva a mensagem enviada no arquivo de mensagens do contato **/
					sprintf(file_name,"Messages/%s.msg",name);
					msgfile = fopen(file_name, "ab");
					sprintf(msg_received, "--> %s",msg.msg);
					len = strlen(msg_received);
					msg_received[len] = ' ';
					msg_received[len+1] = '*';
					msg_received[len+2] = '\n';
					fwrite(msg_received, sizeof(msg_received), 1, msgfile);
					fflush(msgfile);
					close(msgfile);
					memset(msg_received,'\0',sizeof(msg_received));
				}
			}
		}
	}
	blank_location = 0;
}

/** Método que encerra a thread do servidor **/
void closeWHATS(void) {
	extern pthread_t id;
	pthread_join(id, NULL);
	system("clear");
	exitWithERROR();
}

/** Procura arquivo de usuario **/
int searchUser(char* username) {
	DIR *d;
	struct dirent *dir;
	d = opendir("Users");
	if(d) {
		while((dir = readdir(d)) != NULL) {
			if(!strcmp(dir->d_name,username))
				return 1;
		}
		closedir(d);
	}
	return 0;
}

/** Método de finalização do programa **/
void exitWithERROR(void) {
	extern int errn;
	printf("\t\tProgram terminated\n");
	switch(errn) {
		case 0:
			printf("\t      Finalized successfully\n");
			break;
		case 1:
			printf("\t\t     ERROR n:%d\n",errn);
			printf("\tUser file exist, but couldn't be opened.\n");
			break;
		case 2:
			printf("\t\t     ERROR n:%d\n",errn);
			printf("\tUser file couldn't be created for some reason.\n");
			break;
		case 3:
			printf("\t\t     ERROR n:%d\n",errn);
			printf("\t   Error connecting stream socket\n");
			break;
		case 4:
			printf("\t\t     ERROR n:%d\n",errn);
			printf("\t    Error setting sockets options\n");
			break;
		case 5:
			printf("\t\t     ERROR n:%d\n",errn);
			printf("\t   Error accepting socket connection\n");
			break;			
		default:
			printf("\tUndefined error occurred.\n\tPlease, contact developers.");
			break;
	}
}
