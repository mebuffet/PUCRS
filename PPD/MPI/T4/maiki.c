/*
    O objetivo do trabalho é implementar, usando a biblioteca MPI, uma versão paralela, usando o modelo Fases Paralelas, do algoritmo de ordenação BubbleSort.
    O programa deverá receber como parâmetros de entrada um número N, representando o número de valores a serem testados, o nome de um arquivo, que conterá a lista de valores inteiros a serem ordenados, e o número de inteiros conectados entre as fases.
    Utilizar 3 casos de teste para realização das medições no cluster (20k, 40k e 80k).
    A saída que deve ser gerada é a lista ordenada (crescente) dos valores de entrada (1 valor por linha) e também o tempo de execução da aplicação.
*/

//COMPILE: mpicc -o fp fp.c -Wall -Wextra
//EXECUTE: mpirun -np (2 - 4 - 8) fp (20k - 40k - 80k) FILE_WITH_INTEGERS_TO_SORT NUMBER_OF_CONNECTED_INTEGER_BETWEEN_PHASES

//Autor: Maiki Buffet
//Data: 07/11/2016

#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include <time.h>
#include <unistd.h>

#define SEQUENTIAL 1
#define FIRST_PHASE 0
#define REMAINING_PHASE (np-1)

//Preenche o vetor 'v_start' com 'size' valores a partir do arquivo 'f_name'
void fillVector(int size, int v_start[], char *f_name) {
    int i;
    FILE *filepointer;
    filepointer = fopen(f_name, "r");
    for(i = 0; i < size; i++)
        fscanf(filepointer, "%d", &v_start[i]);
    fclose(filepointer);
}

//Rotina de ordenação Odd-Even Transportation
void oetSort(int vector[], int size) {
	int i, aux, sorted = 0;
	while(!sorted) {
		sorted = 1;
		for(i = 1; i < size-1; i += 2) {
			if(vector[i] > vector[i+1]) {
				aux = vector[i];
				vector[i] = vector[i+1];
				vector[i+1] = aux;
				sorted = 0;
			}
		}
		for(i = 0; i < size; i += 2) {
			if(vector[i] > vector[i+1]) {
				aux = vector[i];
				vector[i] = vector[i+1];
				vector[i+1] = aux;
				sorted = 0;
			}
		}
	}
}

//Rotina BubbleSort para Fases Paralelas
int bubbleSort(int vector[], int size) {
	int i, aux, sorted = 0, return_sorted = 1;
	while(!sorted) {
		sorted = 1;
		for(i = 0; i < size; i++)
			if(vector[i] > vector[i + 1]) {
				aux = vector[i];
				vector[i] = vector[i + 1]; 
				vector[i + 1] = aux;
				sorted = 0;
				return_sorted = 0;
			}
	}
	return return_sorted;
}

int main(int argc, char *argv[]) {
    //Se não atender aos requisitos mínimos de execução encerra o programa
    if(argc != 4) {
        printf("execução: mpirun -np processos binário elementos arquivo conexões\n");
        exit(1);
    }
    
    //Verifica se o arquivo com os valores existe, e em caso afirmativo, executa o programa
    else if(access(argv[2], F_OK) != -1) {
	    //Inicialização de variáveis
	    int np, rank, i, previous, next, result, task_size, sorted = 0, finished = 0, sort_size = atoi(argv[1]), connected_integers = atoi(argv[3]), vector_start[sort_size];
	    char *filename = argv[2];
	    struct timeval ti, tf;
	    double time_spent;
	    MPI_Status status;

	    //Inicialização do MPI
	    MPI_Init(&argc, &argv);
	    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	    MPI_Comm_size(MPI_COMM_WORLD, &np);

        //Cálculo do tamanho de cada tarefa e quantas tarefas serão necessárias para o arranjo do vetor de entrada
        task_size = sort_size / np;
        previous = rank - 1;
        next = rank + 1;
	    int buffer[task_size + connected_integers];

	    //Aguarda pela chegada de todos os processos
	    MPI_Barrier(MPI_COMM_WORLD);
	    
	    //Executa a parte sequencial
        if(np == SEQUENTIAL) {            
            //Preenche o vetor 'vector_start' com 'sort_size' elementos através do arquivo 'filename'
            fillVector(sort_size, vector_start, filename);

            //Inicia a contagem do desempenho da versão sequencial
            gettimeofday(&ti, NULL);

            //Algoritmo Sort
            oetSort(vector_start, sort_size);
            
            //Encerra a contagem do desempenho da versão sequencial
            gettimeofday(&tf, NULL);

            //Computa o tempo gasto na tarefa sequencial
            time_spent = (double)(tf.tv_usec - ti.tv_usec) / CLOCKS_PER_SEC + (double)(tf.tv_sec - ti.tv_sec);

            //Imprime o vetor de saída e o tempo de execução na versão sequencial
            for(i = 0; i < sort_size; i++)
                printf("%d: %d\n", i + 1, vector_start[i]);
            printf("A versão sequencial demorou %f segundos para concluir a tarefa.\n", time_spent);
        }

	    //O primeiro processo lê o arquivo, preenche o vetor 'vector_start' e o envia para ser processado
	    else if(rank == FIRST_PHASE) {
		    //Preenche o vetor 'vector_start' com 'sort_size' elementos através do arquivo 'filename'
            fillVector(sort_size, vector_start, filename);

		    //Inicia a contagem do desempenho da versão sequencial
            gettimeofday(&ti, NULL);

		    //Cópia da tarefa mais as conexões para o vetor auxiliar 'buffer'
		    memcpy(buffer, vector_start, (task_size * sizeof(int)) + (connected_integers * sizeof(int)));

		    //Envia todos vetores para serem processados
		    for (i = 1; i < REMAINING_PHASE; i++)
			    MPI_Send(vector_start + (task_size * i), task_size + connected_integers, MPI_INT, i, 0, MPI_COMM_WORLD);

		    //O último processo não possui conexões à direita
		    MPI_Send(vector_start + (task_size * REMAINING_PHASE), task_size, MPI_INT, REMAINING_PHASE, 0, MPI_COMM_WORLD);

		    //Aguarda pela chegada de todos os processos para receber os vetores processados
		    MPI_Barrier(MPI_COMM_WORLD);
	    }
	    
	    //Fases restantes
	    else {
		    //Recebe os vetores para processar
		    if(rank != REMAINING_PHASE)
			    MPI_Recv(buffer, task_size + connected_integers, MPI_INT, FIRST_PHASE, 0, MPI_COMM_WORLD, &status);
		    else
			    MPI_Recv(buffer, task_size, MPI_INT, FIRST_PHASE, 0, MPI_COMM_WORLD, &status);

		    //Aguarda pela chegada de todos os processos para receber os vetores processados
		    MPI_Barrier(MPI_COMM_WORLD);	
	    }

	    //Fase par
	    if((!(rank % 2)) && (np != SEQUENTIAL)) {
		    while(1) {
			    //Executa a rotina BubbleSort
			    sorted = bubbleSort(buffer, task_size + connected_integers - 1);
			
			    //Envia os inteiros conectados
			    if(rank)
				    MPI_Send(&buffer[0], connected_integers, MPI_INT, previous, 0, MPI_COMM_WORLD);
			
			    MPI_Send(&buffer[task_size], connected_integers, MPI_INT, next, 0, MPI_COMM_WORLD);

			    //Aguarda o envio e/ou recebimento de todos os processos
			    MPI_Barrier(MPI_COMM_WORLD);

			    //Checa se todas as fases estão ordenadas
			    MPI_Allreduce(&sorted, &result, 1, MPI_INT, MPI_SUM, MPI_COMM_WORLD);

			    //Se estiverem se encerra o loop
			    if(result == np)
				    break;

			    // Receive connected integers
			    if(rank)
				    MPI_Recv(&buffer[0], connected_integers, MPI_INT, previous, 0, MPI_COMM_WORLD, &status);

			    MPI_Recv(&buffer[task_size], connected_integers, MPI_INT, next, 0, MPI_COMM_WORLD, &status);	

		        //Aguarda pela chegada de todos os processos para receber os vetores processados
			    MPI_Barrier(MPI_COMM_WORLD);	
		    }

		    //Encerra a contagem do desempenho da versão sequencial
		    gettimeofday(&tf, NULL);

		    //Computa o tempo gasto na versão fp
		    time_spent = (double)(tf.tv_usec - ti.tv_usec) / CLOCKS_PER_SEC + (double)(tf.tv_sec - ti.tv_sec);

		    //Imprime o vetor de saída e o tempo de execução na versão fp
		    if(rank == FIRST_PHASE) {
			    for(i = 0; i < task_size; i++)
				    printf("%d: %d\n", i + (task_size * rank) + 1, buffer[i]);

			    //Envia sinal de conclusão ao próximo processo e o tempo gasto para o último processo
			    finished = 1;
			    MPI_Send(&finished, 1, MPI_INT, next, 0, MPI_COMM_WORLD);
			    MPI_Send(&time_spent, 1, MPI_DOUBLE, REMAINING_PHASE, 0, MPI_COMM_WORLD);
		    } else {
			    //Aguarda o sinal de conclusão
			    MPI_Recv(&finished, 1, MPI_INT, previous, 0, MPI_COMM_WORLD, &status);

			    if(finished) {
				    for(i = 0; i < task_size; i++)
					    printf("%d: %d\n", i + (task_size * rank) + 1, buffer[i]);

				    //Envia sinal de conclusão ao próximo processo
				    MPI_Send(&finished, 1, MPI_INT, next, 0, MPI_COMM_WORLD);
			    }
		    }
	    }

	    //Fase ímpar
	    else if(np != SEQUENTIAL) {
		    while(1) {
			    //Recebe os inteiros conectados
			    if(rank != REMAINING_PHASE)
				    MPI_Recv(&buffer[task_size], connected_integers, MPI_INT, next, 0, MPI_COMM_WORLD, &status);

			    MPI_Recv(&buffer[0], connected_integers, MPI_INT, previous, 0, MPI_COMM_WORLD, &status);	

			    //Espera todos os processos finalizarem o envio e/ou recebimento
			    MPI_Barrier(MPI_COMM_WORLD);

			    //Executa a rotina BubbleSort
			    if(rank != REMAINING_PHASE)
				    sorted = bubbleSort(buffer, task_size + connected_integers - 1);
			    else
				    sorted = bubbleSort(buffer, task_size - 1);

			    //Checa se todas as fases estão ordenadas
			    MPI_Allreduce(&sorted, &result, 1, MPI_INT, MPI_SUM, MPI_COMM_WORLD);

			    //Se ja foram encerra o loop
			    if(result == np)
				    break;

			    //Envia os inteiros conectados
			    if(rank != REMAINING_PHASE)
				    MPI_Send(&buffer[task_size], connected_integers, MPI_INT, next, 0, MPI_COMM_WORLD);

			    MPI_Send(&buffer[0], connected_integers, MPI_INT, previous, 0, MPI_COMM_WORLD);	

			    //Aguarda todos os processos finalizarem o seu envio e/ou recebimento
			    MPI_Barrier(MPI_COMM_WORLD);

		    }
		
		    //Recebe o sinal de conclusão das fases anteriores
		    MPI_Recv(&finished, 1, MPI_INT, previous, 0, MPI_COMM_WORLD, &status);

		    if(finished) {
			    for (i = 0; i < task_size; i++)
				    printf("%d: %d\n", i + (task_size * rank) + 1, buffer[i]);

			    //Envia o sinal de conclusão para a próxima fase
			    if(rank != REMAINING_PHASE) {
				    finished = 1;
				    MPI_Send(&finished, 1, MPI_INT, next, 0, MPI_COMM_WORLD);
			    } else { //Última fase
				    //Recebe o total do tempo gasto e o imprime
				    MPI_Recv(&time_spent, 1, MPI_DOUBLE, FIRST_PHASE, 0, MPI_COMM_WORLD, &status);
				    printf("A versão fases paralelas demorou %f segundos para concluir a tarefa.\n", time_spent);
			    }
		    }
	    }
        
        //Finaliza o MPI
	    MPI_Finalize();
    }
    
    //Caso o arquivo com os inteiros não exista, esteja com o nome errado ou em outro diretório, encerra o programa
    else {
        printf("Arquivo inexistente no diretório atual.\n");
        exit(1);
    }
    
	return EXIT_SUCCESS;
}

