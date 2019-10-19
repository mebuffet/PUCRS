/*
    O objetivo do trabalho é implementar, usando a biblioteca MPI, uma versão paralela usando o modelo divisão e conquista do algoritmo de ordenação MergeSort.
    O programa deverá receber como parâmetros de entrada um número N, representando o número de valores a serem testados, e o nome de um arquivo, que conterá a lista de valores inteiros a serem ordenados.
    Utilizar 3 casos de teste para realização das medições no cluster.
    A saída que deve ser gerada é a lista ordenada (crescente) dos valores de entrada (1 valor por linha) e também o tempo de execução da aplicação.
*/

//COMPILE: mpicc -o dc dc.c -Wall -Wextra
//EXECUTE: mpirun -np (2 - 4 - 8 - 16) dc (500k - 1kk - 2kk) FILE_WITH_INTEGERS_TO_SORT

//Autor: Maiki Buffet
//Data: 20/09/2016

#include <math.h>
#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include <time.h>
#include <unistd.h>

#define TRUE 1
#define FALSE 0
#define SEQUENTIAL 1
#define ROOT 0

//Preenche o vetor 'v_start' com 'size' valores a partir do arquivo 'f_name'
void fillVector(int size, int v_start[], char *f_name) {
    int i;
    FILE *filepointer;
    filepointer = fopen(f_name, "r");
    for(i = 0; i < size; i++)
        fscanf(filepointer, "%d", &v_start[i]);
    fclose(filepointer);
}

//Rotina Merge
void merge(int array[], int begin, int mid, int end) {
    int ib = begin, im = mid, size = end - begin;
    int j, b[size];
    for(j = 0; j < size; j++) {
        if(ib < mid && (im >= end || array[ib] <= array[im])) {
            b[j] = array[ib];
            ib++;
        } else {
            b[j] = array[im];
            im++;
        }
    }
    for(j = 0, ib = begin; ib < end; j++, ib++)
        array[ib] = b[j];
}

//Rotina recursiva para ordenamento
void sort(int array[], int begin, int end) {
    int mid;
    if(begin == end)
        return;
    if(begin == end - 1)
        return;
    mid = (begin + end) / 2 ;
    sort(array, begin, mid);
    sort(array, mid, end);
    merge(array, begin, mid, end);
}

//Função que envia os valores para os próximos níveis
void processD(int *send_size, int *actual_size, int *rank, int *actual_level, int vector_aux[], int vector_work[]) {
    int destination;
    *send_size = *actual_size / 2;
    destination = (*rank + pow(2, *actual_level));
    memcpy(vector_aux, vector_work + *send_size, *send_size * sizeof(int));
    MPI_Send(vector_aux, *send_size, MPI_INT, destination, 0, MPI_COMM_WORLD);
    *actual_size = *send_size;
    (*actual_level)++;
    MPI_Send(actual_level, 1, MPI_INT, destination, 0, MPI_COMM_WORLD);
}

//Função que recebe e ordena os vetores conquistados
void processC(int vector_aux[], int *sort_size, MPI_Status *status, int vector_work[], int *actual_size, int *send_size) {
    MPI_Recv(vector_aux, *sort_size, MPI_INT, MPI_ANY_SOURCE, 0, MPI_COMM_WORLD, status);
    MPI_Get_count(status, MPI_INT, send_size);
    memcpy(vector_work + *actual_size, vector_aux, *send_size * sizeof(int));
    merge(vector_work, 0, *actual_size, *actual_size + *send_size);
    *actual_size += *send_size;
}

int main(int argc, char *argv[]) {
    //Se não atender aos requisitos mínimos de execução encerra o programa
    if(argc != 3) {
        printf("execução: mpirun -np processos binário elementos arquivo\n");
        exit(1);
    }
    
    //Verifica se o arquivo com os valores existe, e em caso afirmativo, executa o programa
    if(access(argv[2], F_OK) != -1) {
        //Inicialização de variáveis
        int np, rank, task_size, i, send_size, actual_size, actual_level, sort_size = atoi(argv[1]), *vector_aux = (int*)malloc(sizeof(int)*sort_size);
        char *filename = argv[2];
        struct timeval ti, tf;
        double time_spent;
        MPI_Status status;
        
        //Verifica se a allocação de memória está correta
        if(vector_aux == NULL) {
            printf("Can't allocate memory using malloc.\n");
            exit(1);
        }

        //Inicialização do MPI
        MPI_Init(&argc, &argv);
        MPI_Comm_rank(MPI_COMM_WORLD, &rank);
        MPI_Comm_size(MPI_COMM_WORLD, &np);
        
        //Cálculo do tamanho de cada tarefa e quantas tarefas serão necessárias para o arranjo do vetor de entrada
        task_size = sort_size / np;
        
        //Aguarda pela chegada de todos os processos
        MPI_Barrier(MPI_COMM_WORLD);
        
        //Verifica se o vetor será totalmente divisível, caso contrário encerra o programa
        //TODO arrumar para qualquer tamanho
        if((sort_size % np) != 0) {
            if(rank == ROOT)
                printf("Vetor não é divisível exatamente pelo número de processos.\nFavor escolher outros valores.\n");
            MPI_Finalize();
            exit(1);
        }
        
        //Executa a parte sequencial
        if(np == SEQUENTIAL) {            
            //Preenche o vetor 'vector_aux' com 'sort_size' elementos através do arquivo 'filename'
            fillVector(sort_size, vector_aux, filename);

            //Inicia a contagem do desempenho da versão sequencial
            gettimeofday(&ti, NULL);

            //Algoritmo Sort
            sort(vector_aux, 0, sort_size);
            
            //Encerra a contagem do desempenho da versão sequencial
            gettimeofday(&tf, NULL);

            //Computa o tempo gasto na tarefa sequencial
            time_spent = (double)(tf.tv_usec - ti.tv_usec) / CLOCKS_PER_SEC + (double)(tf.tv_sec - ti.tv_sec);

            //Imprime o vetor de saída e o tempo de execução na versão sequencial
            for(i = 0; i < sort_size; i++)
                printf("%d: %d\n", i + 1, vector_aux[i]);
            printf("A versão sequencial demorou %f segundos para concluir a tarefa.\n", time_spent);
            
            //Libera memória utilizada para manipulação dos valores
            free(vector_aux);
        }
        
        //Processo "raíz"
        else if(rank == ROOT) {
            int *vector_start = (int*)malloc(sizeof(int)*sort_size), *vector_sort = (int*)malloc(sizeof(int)*sort_size);

            //Verifica se a allocação de memória está correta
            if(vector_start == NULL || vector_sort == NULL) {
                printf("Can't allocate memory using malloc.\n");
                exit(1);
            }

            //Preenche o vetor 'vector_start' com 'sort_size' elementos através do arquivo 'filename'
            fillVector(sort_size, vector_start, filename);
            
            //Armazena tamanho e o nível atual
            actual_size = sort_size;
            actual_level = 0;
            
            //Inicia a contagem do desempenho da versão sequencial
            gettimeofday(&ti, NULL);

            //Inicia o envia das tarefas as transmitindo aos próximos níveis, além de armazenar o resultado no vetor ordenado
            while(actual_size > task_size)
                processD(&send_size, &actual_size, &rank, &actual_level, vector_aux, vector_start);
            
            //Ordena a própria tarefa
            sort(vector_start, 0, actual_size);
            
            //Copia o resultado para o vetor ordenado
            memcpy(vector_sort, vector_start, actual_size * sizeof(int));
            
            //Recebe e faz o merge dos vetores ordenados pelos outros níveis
            while(actual_size < sort_size)
                processC(vector_aux, &sort_size, &status, vector_sort, &actual_size, &send_size);
            
            //Encerra a contagem do desempenho da versão sequencial
            gettimeofday(&tf, NULL);
            
            //Computa o tempo gasto na versão dc
            time_spent = (double)(tf.tv_usec - ti.tv_usec) / CLOCKS_PER_SEC + (double)(tf.tv_sec - ti.tv_sec);

            //Imprime o vetor de saída e o tempo de execução na versão dc
            for(i = 0; i < sort_size; i++)
                printf("%d: %d\n", i + 1, vector_sort[i]);
            printf("A versão divisão e conquista demorou %f segundos para concluir a tarefa.\n", time_spent);
            
            //Libera memória utilizada para manipulação dos valores
            free(vector_aux);
            free(vector_start);
            free(vector_sort);
        }
        
        //Outros processos
        else {
            int source, leaf = 1, process = 0, *vector_process = (int*)malloc(sizeof(int)*sort_size);
            
            //Verifica se a allocação de memória está correta
            if(vector_process == NULL) {
                printf("Can't allocate memory using malloc.\n");
                exit(1);
            }
            
            //Aguarda a tarefa
            MPI_Recv(vector_aux, sort_size, MPI_INT, MPI_ANY_SOURCE, 0, MPI_COMM_WORLD, &status);
            
            //Define a fonte
            source = status.MPI_SOURCE;
            
            //Checa o tamanho recebido e grava o tamanho atual
            MPI_Get_count(&status, MPI_INT, &send_size);
            actual_size = send_size;
            
            //Copia o resultado para o vetor do processos
            memcpy(vector_process, vector_aux, send_size * sizeof(int));
            
            //Recebe e armazena o nível do processo
            MPI_Recv(&actual_level, 1, MPI_INT, source, 0, MPI_COMM_WORLD, &status);
            
            //Inicia o envia das tarefas as transmitindo aos próximos níveis, além de armazenar o resultado no vetor ordenado
            while(actual_size > task_size) {
                leaf = 0;
                process++;
                processD(&send_size, &actual_size, &rank, &actual_level, vector_aux, vector_process);
            }
            
            //Ordenado o próprio vetor
            sort(vector_process, 0, actual_size);
            
            //Se for o processo "folha", aguarda os outros processos
            if(!leaf) {
                //Recebe e ordena os vetores de todos os processos "folhas"
                while(process) {
                    processC(vector_aux, &sort_size, &status, vector_process, &actual_size, &send_size);
                    process--;
                }
            }
            
            //Envia de volta o vetor ordenado ao fonte
            MPI_Send(vector_process, actual_size, MPI_INT, source, 0, MPI_COMM_WORLD);
            
            //Libera memória utilizada para manipulação dos valores
            free(vector_process);
        }
        
        //Finaliza o MPI
        MPI_Finalize();
    }
    
    //Caso o arquivo com os inteiros não exista, esteja com o nome errado ou em outro diretório, encerra o programa
    else {
        printf("Arquivo inexistente no diretório atual.\n");
        exit(1);
    }
    
    return 0;
}
