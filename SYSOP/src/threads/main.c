#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

#define COMER 30
#define PENSAR 200

typedef struct {
    int comeu, pensou, tentou;
} Relatorio;
typedef struct {
    pthread_mutex_t *garfo;
    pthread_t *filosofo;
    int id;
    Relatorio relatorio;
} Filosofo;

int numeroFilosofos, tempoExecucao, fim;
sem_t liberador;
Filosofo *filosofo;

void setNumeroFilosofos();
void setTempoExecucao();
int getNumeroFilosofos();
int getTempoExecucao();
void criarFilosofo(Filosofo *fil, pthread_mutex_t *g, pthread_t *f, int i);
void pensarAleatorio(Filosofo *fil);
void Pensar(Filosofo *fil);
void Comer(Filosofo *fil);
void Imprimir(Filosofo *fil);
void Destruidor(int *id, Filosofo *filosofo, sem_t *liberador);
void *Verificar(Filosofo *fid, Filosofo *fd);
void *Testar(void *Convite);

void setNumeroFilosofos() {
    printf("Digite o numero de filosofos para o jantar:\t");
    scanf("%d",&numeroFilosofos);
}
void setTempoExecucao() {
    printf("Digite o tempo para o jantar:\t");
    scanf("%d",&tempoExecucao);
}
int getNumeroFilosofos() {
    return numeroFilosofos;
}
int getTempoExecucao() {
    return tempoExecucao;
}
void criarFilosofo(Filosofo *fil, pthread_mutex_t *g, pthread_t *f, int i) {
    (*fil).garfo = g;
    (*fil).filosofo = f;
    (*fil).id = i;
    (*fil).relatorio.comeu = 0;
    (*fil).relatorio.pensou = 0;
    (*fil).relatorio.tentou = 0;
}
void pensarAleatorio(Filosofo *fil) {
    srand(time(NULL));
    int time = rand() % 21;
    usleep(time);
    (*fil).relatorio.tentou++;
}
void Pensar(Filosofo *fil) {
    usleep(PENSAR);
    (*fil).relatorio.pensou++;
}
void Comer(Filosofo *fil) {
    usleep(COMER);
    (*fil).relatorio.comeu++;
}
void Imprimir(Filosofo *fil) {
    printf("Filosofo[%d]:", (*fil).id);
    printf("\tComeu:\t%d", (*fil).relatorio.comeu);
    printf("\tPensou:\t%d", (*fil).relatorio.pensou);
    printf("\tTentou:\t%d\n", (*fil).relatorio.tentou);
}
void Destruidor(int *id, Filosofo *filosofo, sem_t *liberador) {
    free(id);
    free(filosofo);
    id = 0;
    filosofo = NULL;
    sem_destroy(liberador);
    pthread_exit(NULL);
}
void *Verificar(Filosofo *fid, Filosofo *fd) {
    if(pthread_mutex_trylock((*fid).garfo))
        pensarAleatorio(fid);
    else if(pthread_mutex_trylock((*fd).garfo)) {
        pthread_mutex_unlock((*fid).garfo);
        pensarAleatorio(fid);
    } else {
        Comer(fid);
        pthread_mutex_unlock((*fid).garfo);
        pthread_mutex_unlock((*fd).garfo);
        Pensar(fid);
    }
    return 0;
}
void *Testar(void *Convite) {
    sem_wait(&liberador);
    int id = *((int*)Convite), DIREITA = ((id + 1) % numeroFilosofos);
    Filosofo *fid = &filosofo[id], *fd = &filosofo[DIREITA];
    while(fim == 1)
        Verificar(fid, fd);
    return 0;
}

int main() {
    setNumeroFilosofos();
    setTempoExecucao();
    if((getNumeroFilosofos() > 0) && (getTempoExecucao() > 0)) {
        fim = 1;
        sem_init(&liberador, 0, 0);
        filosofo = malloc(sizeof(Filosofo)*numeroFilosofos);
        int i, *id = malloc(sizeof(int)*numeroFilosofos);
        for(i = 0; i < numeroFilosofos; i++) {
            id[i] = i;
            pthread_mutex_t *mutex = malloc(sizeof(pthread_mutex_t));
            pthread_t *thread = malloc(sizeof(pthread_t));
            pthread_mutex_init(mutex, NULL);
            if(pthread_create(thread, NULL, Testar, (void*)&id[i])) {
                printf("Thread[%d] nao foi criada devido a um erro.\n", i);
                return i;
            }
            criarFilosofo(&filosofo[i], mutex, thread, id[i]);
        }
        for(i = 0; i < numeroFilosofos; i++)
            sem_post(&liberador);
        sleep(tempoExecucao);
        printf("O jantar dos filosofos terminou.\n");
        fim = 0;
        for(i = 0; i < numeroFilosofos; i++)
            Imprimir(&filosofo[i]);
        for(i = 0; i < numeroFilosofos; i++)
            if(pthread_join(*(filosofo[i].filosofo), NULL)) {
                printf("Join[%d] nao foi finalizado com sucesso.\n", i);
                return 1;
            }
        for(i = 0; i < numeroFilosofos; i++) {
            pthread_mutex_destroy(filosofo[i].garfo);
            free(filosofo[i].garfo);
            free(filosofo[i].filosofo);
            filosofo[i].garfo = NULL;
            filosofo[i].filosofo = NULL;
        }
        Destruidor(id, filosofo, &liberador);
    } else {
        printf("Programa encerrado.\nMotivo: o numero de filosofos e do tempo de execucao devem ser maiores que ZERO.\n");
    }
    return 0;
}
