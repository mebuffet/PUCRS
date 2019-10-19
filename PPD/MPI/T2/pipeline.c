/*
    O objetivo do trabalho é implementar, usando a biblioteca MPI, uma versão paralela usando o modelo pipeline do algoritmo de ordenação Insertion Sort.
    O programa deverá receber como parâmetros de entrada um número N, representando o número de valores a serem testados, e o nome de um arquivo, que conterá a lista de valores inteiros a serem ordenados.
    Utilizar 3 casos de teste para realização das medições no cluster (20k, 40k e 80k).
    A saída que deve ser gerada é a lista ordenada (crescente) dos valores de entrada (1 valor por linha) e também o tempo de execução da aplicação.
*/

//COMPILE: mpicc -o pipeline pipeline.c -Wall -Wextra
//EXECUTE: mpirun -np (2 - 4 - 8) pipeline (20k - 40k - 80k) FILE_WITH_INTEGERS_TO_SORT

//Autor: Maiki Buffet
//Data: 04/09/2016

#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

#define TRUE 1
#define FALSE 0
#define SEQUENTIAL 1
#define FIRST_STAGE 0
#define LAST_STAGE (np - 1)

//Preenche o vetor 'v_start' com 'size' valores a partir do arquivo 'f_name'
void fillVector(int size, int v_start[], char *f_name) {
    int i;
    FILE *filepointer;
    filepointer = fopen(f_name, "r");
    for(i = 0; i < size; i++)
        fscanf(filepointer, "%d", &v_start[i]);
    fclose(filepointer);
}

int main(int argc, char *argv[]) {
    //Se não atender aos requisitos mínimos de execução, encerra o programa
    if(argc != 3) {
        printf("execução: mpirun -np processos binário elementos arquivo\n");
        exit(1);
    }
    
    //Verifica se o arquivo com os valores existe, e em caso afirmativo, executa o programa
    if(access(argv[2], F_OK) != -1) {
        //Inicialização de variáveis
        int sort_size = atoi(argv[1]);
        int np, rank, task_size, i, j, value, aux, actual_value, vector_start[sort_size], vector_sort[sort_size];
        char *filename = argv[2];
        clock_t time;
        double time_spent;
        MPI_Status status;
        
        //Inicialização do MPI
        MPI_Init(&argc, &argv);
        MPI_Comm_rank(MPI_COMM_WORLD, &rank);
        MPI_Comm_size(MPI_COMM_WORLD, &np);
        
        //Cálculo do tamanho de cada tarefa e quantas tarefas serão necessárias para o arranjo do vetor de entrada
        task_size = sort_size / np;
        
        //Vetor utilizado para o Insertion Sort entre os pipes
        int vector_aux[task_size];
        
        //Aguarda pela chegada de todos os processos
        MPI_Barrier(MPI_COMM_WORLD);
        
        //Verifica se o vetor será totalmente divisível, caso contrário encerra o programa
        //TODO arrumar para qualquer tamanho
        if((sort_size % np) != 0) {
            if(rank == FIRST_STAGE)
                printf("Vetor não é divisível exatamente pelo número de processos.\nFavor escolher outros valores.\n");
            MPI_Finalize();
            exit(1);
        }
        
        //Executa a parte sequencial
        if(np == SEQUENTIAL) {
            //Preenche o vetor 'vector_start' com 'sort_size' elementos através do arquivo 'filename'
            fillVector(sort_size, vector_start, filename);

            //Inicia a contagem do desempenho da versão sequencial
            time = clock();
            
            //Algoritmo Insertion Sort
            for(i = 0; i < sort_size; i++) {
                value = vector_start[i];
                for(j = 0; j < i; j++) {
                    if(value < vector_sort[j]) {
                        aux = vector_sort[j];
                        vector_sort[j] = value;
                        value = aux;
                    }
                }
                vector_sort[i] = value;
            }
            
            //Encerra a contagem do desempenho da versão sequencial
            time = clock() - time;
            
            //Computa o tempo gasto na tarefa sequencial
            time_spent = ((double) time) / CLOCKS_PER_SEC;
            
            //Imprime o vetor de saída e o tempo de execução na versão sequencial
            for(i = 0; i < sort_size; i++)
                printf("%d: %d\n", i + 1, vector_sort[i]);
                
            printf("A versão sequencial demorou %.2f segundos para concluir a tarefa.\n", time_spent);
        }
        
        //Primeiro estágio do pipe
        else if (rank == FIRST_STAGE) {
            //Preenche o vetor 'vector_start' com 'sort_size' elementos através do arquivo 'filename'
            fillVector(sort_size, vector_start, filename);
            
            //Inicia a contagem do desempenho da versão sequencial
            time = clock();
            
            //Algoritmo Insertion Sort
            for(i = 0; i < sort_size; i++) {
                value = vector_start[i];
                for(j = 0; j < i; j++) {
                    //Não corrige o vetor do pipe se for maior que o tamanho da tarefa
                    if(j == task_size)
                        break;
                    //Corrige o vetor do pipe
                    if(value < vector_aux[j]) {
                        aux = vector_aux[j];
                        vector_aux[j] = value;
                        value = aux;
                    }
                }
                //Insere o valor atual no vetor do pipe
                if(i < task_size)
                    vector_aux[i] = value;
                //Vetor do pipe cheio, envia os elementos para o próximo pipe
                else {
                    actual_value = value;
                    MPI_Send(&actual_value, 1, MPI_INT, 1, 0, MPI_COMM_WORLD);
                }
            }
            
            //Aguarda pelo sinal de término do último estágio
            MPI_Recv(&actual_value, 1, MPI_INT, LAST_STAGE, 0 , MPI_COMM_WORLD, &status);
            
            //Se o último estágio terminou o ordenamento
            if(actual_value == -1) {
                //Encerra a contagem do desempenho da versão sequencial
                time = clock() - time;
                
                //Imprime o vetor ordenado do primeiro estágio
                for(i = 0; i < task_size; i++)
                    printf("%d: %d\n", i + 1, vector_aux[i]);
                
                //Envia o sinal de término para o próximo estágio
                actual_value = -1;
                MPI_Send(&actual_value, 1, MPI_INT, 1, 0, MPI_COMM_WORLD);
            }
            
            //Computa o tempo gasto na tarefa pipeline
            time_spent = ((double) time) / CLOCKS_PER_SEC;
            MPI_Send(&time_spent, 1, MPI_DOUBLE, LAST_STAGE, 0, MPI_COMM_WORLD); 
        }
        
        //Estágios intermediários do pipe
        else if(rank != LAST_STAGE) {
            //Algoritmo Insertion Sort
            for(i = 0; i < sort_size - (task_size * rank); i++) {
                //Aguarda elementos a serem ordenados do estágio anterior
                MPI_Recv(&actual_value, 1, MPI_INT, rank - 1, 0, MPI_COMM_WORLD, &status);
                value = actual_value;
                for(j = 0; j < i; j++) {
                    //Não corrige o vetor do pipe se for maior que o tamanho da tarefa
                    if(j == task_size)
                        break;
                    //Corrige o vetor do pipe
                    if(value < vector_aux[j]) {
                        aux = vector_aux[j];
                        vector_aux[j] = value;
                        value = aux;
                    }
                }
                //Insere o valor atual no vetor do pipe
                if(i < task_size)
                    vector_aux[i] = value;
                //Vetor do pipe cheio, envia os elementos para o próximo pipe
                else {
                    actual_value = value;
                    MPI_Send(&actual_value, 1, MPI_INT, rank + 1, 0, MPI_COMM_WORLD);
                }
            }
            
            //Aguarda pelo sinal de término do estágio anterior
            MPI_Recv(&actual_value, 1, MPI_INT, rank - 1, 0 , MPI_COMM_WORLD, &status);
            
            //Se o estágio anterior terminou o ordenamento
            if(actual_value == -1) {
                //Imprime o vetor ordenado dos estágios intermediários
                for(i = 0; i < task_size; i++)
                    printf("%d: %d\n", i + 1 + (task_size * rank), vector_aux[i]);
                
                //Envia o sinal de término para o próximo estágio
                actual_value = -1;
                MPI_Send(&actual_value, 1, MPI_INT, rank + 1, 0, MPI_COMM_WORLD);
            }
        }
        
        //Último estágio do pipe
        else {
            //Algoritmo Insertion Sort
            for(i = 0; i < task_size; i++) {
                //Aguarda elementos a serem ordenados do estágio anterior
                MPI_Recv(&actual_value, 1, MPI_INT, rank - 1, 0, MPI_COMM_WORLD, &status);
                value = actual_value;
                for(j = 0; j < i; j++) {
                    //Corrige o vetor do pipe
                    if(value < vector_aux[j]) {
                        aux = vector_aux[j];
                        vector_aux[j] = value;
                        value = aux;
                    }
                }
                //Insere o valor atual no vetor do pipe
                vector_aux[i] = value;
            }
            
            //Envia o sinal de término para o primeiro estágio
            actual_value = -1;
            MPI_Send(&actual_value, 1, MPI_INT, FIRST_STAGE, 0, MPI_COMM_WORLD);
            
            //Aguarda pelo sinal de término do estágio anterior
            MPI_Recv(&actual_value, 1, MPI_INT, rank - 1, 0 , MPI_COMM_WORLD, &status);
            
            //Se o estágio anterior terminou o ordenamento
            if(actual_value == -1)
                //Imprime o vetor ordenado do último estágio
                for(i = 0; i < task_size; i++)
                    printf("%d: %d\n", i + 1 + (task_size * LAST_STAGE), vector_aux[i]);    
            
            //Aguarda o tempo computado na tarefa pipeline e o imprime
            MPI_Recv(&time_spent, 1, MPI_DOUBLE, FIRST_STAGE, 0, MPI_COMM_WORLD, &status);
            
            printf("A versão pipeline demorou %.2f segundos para concluir a tarefa.\n", time_spent);
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
