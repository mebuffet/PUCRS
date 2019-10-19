#include "server.h"

/** Callback para interceptação de sinais ^C **/
void CtrlC(int dummy) {
	printf("CTRL+C\n");
	printf("Close main_socket return value: %d\n",close(main_socket));
	printf("Close send_socket return value: %d\n",close(send_socket));
	exit(0);
}

/** Método de inicialização da Thread do servidor **/
void initServerThread(pthread_t *id) {
	int err;
	err = pthread_create(&id, NULL, &serverThread, NULL);
}

/** Execução do servidor **/
void* serverThread(void) {    
	extern struct user usuario;
	char file_name[26], msg_received[40];
	char ip[16];
	int err, i, id, contact_index, len; 
	int port = 1024;    
	int bytes_received;                                     
	struct sockaddr_in server; 
	struct sockaddr client;
	socklen_t socket_length = sizeof(struct sockaddr);   

	int ret, enable = 1, strlength = 0;

	FILE* msgfile;

	struct message msg, ret_msg;   

	/** Atribuição do Callback para sinais de ^C **/
	signal(SIGINT, CtrlC);  

	/** Limpeza das strings **/
	memset(ip, '\0', 16);
	memset(msg_received, '\0', 40);

	/** Criação do Socket principal do servidor **/
	main_socket = socket(AF_INET, SOCK_STREAM, 0);
	if(main_socket < 0) {                                            
		fprintf(stderr,"Erro ao abrir stream socket\n");                 
		return(1);                                           
	} 

	/** Definindo configurações do socket principal **/
	if(setsockopt(main_socket, SOL_SOCKET, SO_REUSEADDR, &enable, sizeof(int)) < 0) {
		errn = 4;    	
		exit(0);
	}

	/** Atribuindo endereço de IP ao servidor **/
	server.sin_family = AF_INET;
	server.sin_addr.s_addr = INADDR_ANY;                         
	server.sin_port = htons(port); 
	if((ret = bind(main_socket, (struct sockaddr *)&server, sizeof server)) < 0) {
		fprintf(stderr,"Binding stream socket %d\n", errno);                 
		return(1);
	}
 
	/** Esperando requisições de conexão **/
	listen(main_socket, 5);
	while(1) {
		/** Aceitando uma conexão e criando socket de comunicação **/
		send_socket = accept(main_socket, &client, &socket_length);
		if(send_socket == -1)
			break;
		sprintf(ip, "%d.%d.%d.%d\0",client.sa_data[2]&0x000000ff,\
								    client.sa_data[3]&0x000000ff,\
									client.sa_data[4]&0x000000ff,\
									client.sa_data[5]&0x000000ff);
		/** Recebendo pacote **/
		bytes_received = recv(send_socket, &msg, sizeof(struct message), 0);
		pthread_mutex_lock(&lock);
		/** Tratando mensagens de texto recebidas **/
		if(msg.tipo == MSG_TXT) {
			/** Se contato com nome e ip não existe na lista de contatos do usuario **/			
			if(ContactExist(&usuario, msg.from, ip) >= 0) {
				/** Salva a mensagem **/
				sprintf(file_name,"Messages/%s.msg",msg.from);
				msgfile = fopen(file_name, "ab");
				sprintf(msg_received, "<-- %s",msg.msg);
				/** Insere o identificador de mensagem não lida **/
				strlength = strlen(msg_received);
				msg_received[strlength] = ' ';
				msg_received[strlength+1] = '*';
				msg_received[strlength+2] = '\n';
				/** Escreve no arquivo de mensagem correspondente **/
				fwrite(msg_received, sizeof(msg_received), 1, msgfile);
				fflush(msgfile);
				close(msgfile);
				/** e responde que a operação foi bem sucedida **/
				_createResponseMessage(&ret_msg, usuario.userName, 1, "");
				send(send_socket, &ret_msg, sizeof(struct message), 0);
				memset(msg_received, '\0', TAM_MAX_MSG); 
			}
			/** Senão envia reposta com mensagem de erro **/	
			else {
				printf("Mensagem de contato desconhecido\n");
				_createResponseMessage(&ret_msg, usuario.userName, 0, "Mensagem de contato desconhecido\n");
				send(send_socket, &ret_msg, sizeof(struct message), 0);
			}
		}
		if(msg.tipo == MSG_TXT_GROUP) {
			/** Se contato com nome e ip não existe na lista de contatos do usuario **/			
			if(GroupwithNameExist(&usuario, msg.group_name) >= 0) {
				/** Salva a mensagem **/
				sprintf(file_name,"Messages/%s.msg",msg.group_name);
				msgfile = fopen(file_name, "ab");
				sprintf(msg_received, "<-- %s",msg.msg);
				/** Insere o identificador de mensagem não lida **/
				strlength = strlen(msg_received);
				msg_received[strlength] = ' ';
				msg_received[strlength+1] = '*';
				msg_received[strlength+2] = '\n';
				/** Escreve no arquivo de mensagem correspondente **/
				fwrite(msg_received, sizeof(msg_received), 1, msgfile);
				fflush(msgfile);
				close(msgfile);
				/** e responde que a operação foi bem sucedida **/
				_createResponseMessageGroup(&ret_msg, usuario.userName, 1, "");
				send(send_socket, &ret_msg, sizeof(struct message), 0);
				memset(msg_received, '\0', TAM_MAX_MSG); 
			}
			/** Senão envia reposta com mensagem de erro **/	
			else {
				printf("Mensagem de grupo desconhecido\n");
				_createResponseMessageGroup(&ret_msg, usuario.userName, 0, "Mensagem de grupo desconhecido\n");
				send(send_socket, &ret_msg, sizeof(struct message), 0);
			}
		}
		/** Tratando mensagens de inserção de contato **/
		else if(msg.tipo == ADD_CONTACT) {
			/** Se contato com nome e ip não existe na lista de contatos do usuario **/	
			if(ContactExist(&usuario, msg.from, ip) < 0) {
				/** e há espaço para a adição de mais um contato **/	
				if((contact_index = usuario.nContatos) < 8) {
					/** adiciona o contato **/
					printf("Contato novo\n");
	 				AddContact(&usuario, msg.from, ip);
					printf("%s\n",msg.from);
					saveUser(&usuario, usuario.file_name);
					/** e responde que a operação foi bem sucedida **/
					_createResponseMessage(&ret_msg, usuario.userName, 1, "");
					send(send_socket, &ret_msg, sizeof(struct message), 0);
				}
				/** Senão envia reposta com mensagem de erro **/
				else {
					printf("Total de contatos ja atingido\n");
					_createResponseMessage(&ret_msg, usuario.userName, 0, "Total de contatos ja atingido\n");
					send(send_socket, &ret_msg, sizeof(struct message), 0);
				}
			}
			/** Senão envia reposta com mensagem de erro **/
			else { 
				printf("Contato com este nome ou ip ja existe em sua lista de de contatos\n");
				_createResponseMessage(&ret_msg, usuario.userName, 0, "Contato com este nome ou ip ja existe\n");
				send(send_socket, &ret_msg, sizeof(struct message), 0);
			}
		}
		/** Tratando mensagens de inserção de grupo **/
		else if(msg.tipo == ADD_GROUP) {
			if(ContactExist(&usuario, msg.from, ip) >= 0) {
				for(i = 0; i < msg.nro_contatos; i++) {
					if(!strcmp(msg.to[i], usuario.userName))
						continue;
					if(ContactExist(&usuario, msg.to[i], msg.to_ip[i]) < 0) {
						if((contact_index = usuario.nContatos) < 8) {
							printf("Contato novo\n");
			 				AddContact(&usuario, msg.to[i], msg.to_ip[i]);
							printf("%s\n",msg.to[i]);
							saveUser(&usuario, usuario.file_name);
						}
						else {
							printf("Total de contatos ja atingido\n");
							_createResponseMessageGroup(&ret_msg, usuario.userName, 0, "Total de contatos ja atingido\n");
							send(send_socket, &ret_msg, sizeof(struct message), 0);
						}
					}
				}
				AddGroupRcv(&usuario, msg.group_name, msg.to, msg.to_ip, msg.nro_contatos, msg.from, ip);
				if(!saveUser(&usuario, usuario.file_name)) {
					errn = 2;
					atexit(exitWithERROR);
				}
				_createResponseMessageGroup(&ret_msg, usuario.userName, 1, "");
				send(send_socket, &ret_msg, sizeof(struct message), 0);
			}
			else {
				printf("Tentativa de criacao de grupo falhou. O administrador do grupo nao esta na lista de contatos\n");
				_createResponseMessageGroup(&ret_msg, usuario.userName, 0, "O administrador do grupo nao esta na lista de contatos\n");
				send(send_socket, &ret_msg, sizeof(struct message), 0);
			}
		}
		else if(msg.tipo == READ_MSGS) {
			if(ContactExist(&usuario, msg.from, ip) >= 0) {
				sprintf(file_name,"Messages/%s.msg",msg.from);
				msgfile = fopen(file_name, "rb+");
				while(fread(msg_received, 40, 1, msgfile) > 0) {
					/** verifica se é uma mensagem recebida **/
					if(msg_received[0] == '-') {
						len = strlen(msg_received);
						/** verifica se é uma mensagem que já foi lida **/
						if(msg_received[len-2] == '*' && msg_received[len-3] == '*')
							continue;
						else {
							/** adiciona o 2° '*' ao final da mensagem **/
							msg_received[len-1] = '*';
							msg_received[len] = '\n';
							msg_received[len+1] = '\0';
							fseek(msgfile, (-40*sizeof(char)), SEEK_CUR);
							fwrite(msg_received, sizeof(msg_received), 1, msgfile);
						}
					}
					memset(msg_received,'\0',40);
					if(feof(msgfile))
						break;
				}
				memset(msg_received,'\0',40);
				close(msgfile);
			}

		}
		else if(msg.tipo == READ_MSGS_GROUP) {
			if(GroupwithNameExist(&usuario, msg.group_name) >= 0) {
				sprintf(file_name,"Messages/%s.msg",msg.group_name);
				msgfile = fopen(file_name, "rb+");
				while(fread(msg_received, 40, 1, msgfile) > 0) {
					/** verifica se é uma mensagem recebida **/
					if(msg_received[0] == '-') {
						len = strlen(msg_received);
						/** verifica se é uma mensagem que já foi lida **/
						if(msg_received[len-2] == '*' && msg_received[len-3] == '*')
							continue;
						else {
							/** adiciona o 2° '*' ao final da mensagem **/
							msg_received[len-1] = '*';
							msg_received[len] = '\n';
							msg_received[len+1] = '\0';
							fseek(msgfile, (-40*sizeof(char)), SEEK_CUR);
							fwrite(msg_received, sizeof(msg_received), 1, msgfile);
						}
					}
					memset(msg_received,'\0',40);
					if(feof(msgfile))
						break;
				}
				memset(msg_received,'\0',40);
				close(msgfile);
			}

		}
		pthread_mutex_unlock(&lock);
		/** Fecha socket de comunicação **/
		close(send_socket);
	}
	/** Fecha socket principal **/
	close(main_socket);
	return(0);
} 
