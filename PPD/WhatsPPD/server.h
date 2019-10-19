#ifndef SERVER_HEADER
#define SERVER_HEADER 

#include <errno.h>
#include <netdb.h>
#include <netinet/in.h>
#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h> 
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>

#include "utils.h"
#include "user.h"
#include "contato.h"
#include "mensagem.h"

int main_socket, send_socket;
extern pthread_mutex_t lock;
extern int errn;

void CtrlC(int dummy);
void initServerThread(pthread_t *id);
void* serverThread(void);

#endif
