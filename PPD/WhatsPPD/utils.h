#ifndef UTILS_HEADER
#define UTILS_HEADER

#include <ctype.h>
#include <dirent.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "user.h"
#include "client.h"
#include "mensagem.h"

void clearMSG(char* phrase, int tam);
void Login(char* user_fileName);
void executeCommandInsertion(struct user* usuario, char* string, int nArgs, char* fileName);
void executeCommandInsertionGroup(struct user* usuario, char* string, int nArgs, char* fileName);
void executeCommandSend(struct user* usuario, char* string, int nArgs, char* fileName);
int executeCommandList(struct user* usuario, char* name);
void closeWHATS(void);
void exitWithERROR(void);
int searchUser(char* username);

#endif
