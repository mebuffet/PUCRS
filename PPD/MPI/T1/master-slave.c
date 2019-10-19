/*
    O objetivo do trabalho é implementar, usando a biblioteca MPI, uma versão paralela, usando o modelo mestre-escravo, do algoritmo de ordenação RankSort.
    O programa deverá receber como parâmetros de entrada um número N, representando o número de valores a serem testados e o nome de um arquivo, que conterá a lista de valores inteiros a serem ordenados.
    Utilizar 3 casos de teste para realização das medições no cluster (20k, 40k e 80k).
    A saída que deve ser gerada é a lista ordenada (crescente) dos valores de entrada (1 valor por linha) e também o tempo de execução da aplicação.
*/

//COMPILE: mpicc -o master_slave master_slave.c -Wall -Wextra
//EXECUTE: mpirun -np (3 - 5 - 9) master_slave (20k - 40k - 80k) FILE_WITH_INTEGERS_TO_SORT

//Autor: Maiki Buffet
//Data: 24/08/2016

#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

#define MASTER 0
#define SEQUENTIAL 1
#define STOP -1

//Preenche o vetor 'v_start' com 'size' valores a partir do arquivo 'f_name'
void fillVector(int size, int v_start[], char *f_name) {
    int i;
    FILE *filepointer;
    filepointer = fopen(f_name, "r");
    for(i = 0; i < size; i++)
        fscanf(filepointer, "%d", &v_start[i]);
    fclose(filepointer);
}

//Imprime na tela a ordenação atual dos valores presentes no vetor 'vector'
void printVector(int size, int vector[]) {
    int i;
    for(i = 0; i < size; i++)
        printf("%d: %d\n", i+1, vector[i]);
}

//Realiza o RankSort num vetor de entrada 'v' e armazena o vetor ordenado em 'v_sort'
void rankSort(int size, int v[], int v_sort[]) {
    int i, j, rank;
    for(i = 0; i < size; i++) {
        rank = 0;
        for(j = 0; j < size; j++) {
            if(v[i] > v[j])
                rank++;
        }
        v_sort[rank] = v[i];
    }
}

//Realiza o "merge" de duas partes de um vetor 'array' e armazena o resultado no próprio vetor 'array'
void mergeSort(int array[], int begin, int mid, int end) {
    int ib = begin, im = mid, size = end - begin;
    int i, b[size];
    for(i = 0; i < size; i++) {
        if(ib < mid && (im >= end || array[ib] <= array[im])) {
            b[i] = array[ib];
            ib++;
        } else {
            b[i] = array[im];
            im++;
        }
    }
    for(i = 0, ib = begin; ib < end; i++, ib++)
        array[ib] = b[i];
}

int main(int argc, char *argv[]) {
    //Se não atender aos requisitos mínimos de execução, encerra o programa
    if(argc < 3) {
        printf("execução: mpirun -np numero_processos_a_serem_escalonados main_mpi numero_elementos_para_ordenar arquivo_com_valores_a_serem_ordenados\n");
        exit(1);
    }
    
    //Verifica se o arquivo com os valores existe, e em caso afirmativo, executa o programa
    if(access(argv[2], F_OK) != -1) {
        //Inicialização de variáveis
        int size=atoi(argv[1]);
        int rank, np, tasks_size, tasks, vector_start[size], vector_sort[size];
        char *filename = argv[2];
        clock_t time;
        double time_spent;
        MPI_Status status;
        
        //Inicialização do MPI
        MPI_Init(&argc, &argv);
        MPI_Comm_rank(MPI_COMM_WORLD, &rank);
        MPI_Comm_size(MPI_COMM_WORLD, &np);
        
        //Cálculo do tamanho de cada tarefa e quantas tarefas serão necessárias para o arranjo do vetor de entrada
        tasks_size = size / (4*np);
        tasks = 4 * np; //Equivalente: size / task_size
        
        //Verifica se o vetor será totalmente divisível, caso contrário encerra o programa
        //TODO arrumar para qualquer tamanho
        if((size % tasks) != 0) {
            if(rank == MASTER)
                printf("Vetor não é divisível exatamente pelo número de processos.\nFavor escolher outros valores.\n");
            MPI_Finalize();
            exit(1);
        }
        
        //Executa a parte sequencial
        if(np == SEQUENTIAL) {
            //Preenche o vetor 'vector_start' com 'size' elementos através do arquivo 'filename'
            fillVector(size, vector_start, filename);

            //Inicia a contagem do desempenho da versão sequencial
            time = clock();
            
            //Chama a função RankSort para ordenar de forma crescente o vetor 'vector_start[size]', retornando o vetor ordenado em 'vector_sort'
            rankSort(size, vector_start, vector_sort);
            
            //Encerra a contagem do desempenho da versão sequencial
            time = clock() - time;
            
            //Computa o tempo gasto na tarefa sequencial
            time_spent = ((double) time) / CLOCKS_PER_SEC;
            
            //Imprime o vetor de saída e o tempo de execução na versão sequencial
            printVector(size, vector_sort);
            printf("A versão sequencial demorou %f segundos para concluir a tarefa.\n", time_spent);
        }
        
        //Código executado apenas pelo MASTER
        else if (rank == MASTER) {
            int actual_index = 0, tasks_to_receive = 0, tasks_sent = 0, tasks_received = 0, first_time = 1;
            int slave, slave_to_master[tasks_size];
            
            //Preenche o vetor 'vector_start' com 'size' elementos através do arquivo 'filename'
            fillVector(size, vector_start, filename);

            //Inicia a contagem do desempenho da versão Master-Slave
            time = clock();
            
            //Manda uma tarefa para cada slave para ordenação
            for(slave = 1; slave < np; slave++) {
                MPI_Send(vector_start + (tasks_sent * tasks_size), tasks_size, MPI_INT, slave, 0, MPI_COMM_WORLD);
                tasks_sent++;
                tasks_to_receive++;
            }
    
            //Enquanto tiver tarefas a serem executadas, o MASTER espera pelo retorno de algum slave, verifica o slave que retornou a tarefa, manda uma nova tarefa, e atualiza o número de "tarefas pendentes"
            while(tasks_to_receive > 0) {
                MPI_Recv(slave_to_master, tasks_size, MPI_INT, MPI_ANY_SOURCE, 0, MPI_COMM_WORLD, &status);
                slave = status.MPI_SOURCE;
                tasks_to_receive--;

                //Copia as informações recebidas do slave para 'vector_sort', cujo índice avança
                memcpy(vector_sort + actual_index, slave_to_master, tasks_size*sizeof(int));

                actual_index += tasks_size;
                if(first_time == 1)
                    first_time = 0;
                else
                    mergeSort(vector_sort, 0, tasks_received * tasks_size, actual_index);
                tasks_received++;
                if(tasks_sent < tasks) {
                    MPI_Send(vector_start + (tasks_sent * tasks_size), tasks_size, MPI_INT, slave, 0, MPI_COMM_WORLD);
                    tasks_sent++;
                    tasks_to_receive++;
                }
            }

            //Encerra a contagem do desempenho da versão Master-Slave
            time = clock() - time;

            //Caso todas as tarefas tenham sido concluídas, o MASTER manda um sinal de encerramento aos slaves
            vector_start[0] = STOP;
            for(slave = 1; slave < np; slave++)
                MPI_Send(vector_start, tasks_size, MPI_INT, slave, 0, MPI_COMM_WORLD);
    
            //Computa o tempo gasto na tarefa sequencial
            time_spent = ((double) time) / CLOCKS_PER_SEC;
            
            //Imprime o vetor de saída e o tempo de execução na versão sequencial
            printVector(size, vector_sort);
            printf("A versão Master-Slave demorou %f segundos para concluir a tarefa.\n", time_spent);
        }
        
        //Código executado apenas pelos slaves
        else {
            int end = 0;
            int slave_to_master[tasks_size], master_to_slave[tasks_size];
            
            //Enquanto tiverem tarefas a serem executadas, recebe do MASTER a tarefa, executa o metodo RankSort, e envia o resultado ao MASTER
            while(!end) {
                MPI_Recv(master_to_slave, tasks_size, MPI_INT, 0, 0, MPI_COMM_WORLD, &status);
                if(master_to_slave[0] > STOP) {
                    rankSort(tasks_size, master_to_slave, slave_to_master);
                    MPI_Send(slave_to_master, tasks_size, MPI_INT, 0, 0, MPI_COMM_WORLD);
                }
                else
                    end = 1;
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
    
    return 0;
}
