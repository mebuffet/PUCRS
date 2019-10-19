//Bibliotecas utilizadas para implementação
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


//Restrições do trabalho
#define NUM_MAX_TAREFAS 26
#define NUM_MAX_TEMPO 100000


//Definições para clareza de funcionalidade
#define IDLE '.'


//Definição da estrutura periódica
typedef struct {
    unsigned c, p, d, a, to_process;
    char id;
    bool want_to_process, is_aperiodic;
} PERIODIC;


//Definição da estrutura aperiódica
typedef struct {
    unsigned c, a, to_process;
    char id;
    bool want_to_process;
} APERIODIC;


//Coloca o vetor das tarefas em ordem de prioridade (período)
void sortPeriod(PERIODIC *tasks, unsigned number_of_tasks) {
    unsigned i, j;
    PERIODIC aux;

    for(i = 0; i < number_of_tasks-1; i++)
        for(j = 0; j < number_of_tasks-1-i; j++)
            if(tasks[j].p > tasks[j+1].p || (tasks[j].p == tasks[j+1].p && tasks[j].id > tasks[j+1].id)) {
                aux = tasks[j];
                tasks[j] = tasks[j+1];
                tasks[j+1] = aux;
            }
}


//Verifica o início de um novo período para cada tarefa e sinaliza quantas computações serão feitas
void verifyPeriod(PERIODIC *tasks, unsigned number_of_tasks, unsigned present_time) {
    unsigned i;
    
    for(i = 0; i < number_of_tasks; i++)
        if((!tasks[i].is_aperiodic && (!(present_time % tasks[i].p) && present_time)) || tasks[i].a == present_time)
            tasks[i].to_process = tasks[i].c;
}


//Verifica se as tarefas possuem alguma computação a ser realizada no período atual
unsigned wantProcess(PERIODIC *tasks, unsigned number_of_tasks, unsigned present_time) {
    unsigned i, count = 0;
        
    for(i = 0; i < number_of_tasks; i++) {
        tasks[i].want_to_process = false;
        if((tasks[i].is_aperiodic && tasks[i].a <= present_time && tasks[i].to_process && !(present_time % tasks[i].p)) || (!tasks[i].is_aperiodic && tasks[i].to_process)) {
            tasks[i].want_to_process = true;
            count++;
        }
    }

    return count;
}


//Verifica se a tarefa executada anteriormente já terminou o processamento
unsigned previousWantProcess(PERIODIC *tasks, unsigned number_of_tasks, char previous_task) {
    unsigned i;
    
    for(i = 0; i < number_of_tasks; i++)        
        if(tasks[i].is_aperiodic && tasks[i].id == previous_task && tasks[i].to_process)
            return true;
        else if(tasks[i].id == previous_task)
            return tasks[i].to_process == tasks[i].c ? false : tasks[i].want_to_process;
        
    return false;
}


//Verifica se a tarefa anterior é diferente da atual, e se a anterior não terminou sua computação, preemptará
void doPreemptions(PERIODIC *tasks, unsigned number_of_tasks, unsigned present_time, unsigned *preemption, char task_to_process, char *scheduler_result) {
    if(present_time) {
        char previous_task = scheduler_result[present_time-1];
        
        if((task_to_process != previous_task && (previousWantProcess(tasks, number_of_tasks, previous_task))) || previous_task == IDLE)
            *preemption += 1;
    }
}


//Verifica a prioridade da tarefa (período) para definir quem será computado
char chooseTask(PERIODIC *tasks, unsigned number_of_tasks, unsigned present_time, unsigned *preemption, char *scheduler_result) {
    unsigned i;
    char task_to_process = NULL;
    
    //Seleciona primeiro as tarefas aperiódicas
    for(i = 0; i < number_of_tasks; i++)
        if(tasks[i].is_aperiodic && !(present_time % tasks[i].p) && tasks[i].want_to_process) {
            tasks[i].to_process--;
            task_to_process = tasks[i].id;
            doPreemptions(tasks, number_of_tasks, present_time, preemption, task_to_process, scheduler_result);
            goto exit;
        }
    
    //Após checar as aperiódicas, checa pelas periódicas de maior prioridade (período)
    for(i = 0; i < number_of_tasks; i++)
        if(tasks[i].want_to_process) {
            tasks[i].to_process--;
            task_to_process = tasks[i].id;
            doPreemptions(tasks, number_of_tasks, present_time, preemption, task_to_process, scheduler_result);
            goto exit;
        }
        
    exit:
    return task_to_process;
}


//Verifica se existem tarefas aperiódicas para serem computadas, caso fosse executado algum idle
char getIdleProcess(PERIODIC *tasks, unsigned number_of_tasks, unsigned period) {
    unsigned i;
    char task_to_process = NULL;
    
    //Checa se existe alguma tarefa aperiódica para ser executada, se atender aos critérios de chegada da mesma
    for(i = 0; i < number_of_tasks; i++)
        if(tasks[i].is_aperiodic && tasks[i].to_process && tasks[i].a <= period)
            tasks[i].want_to_process = true;

    //Seleciona a tarefa aperiódica de maior prioridade (período) para ser computada
    for(i = 0; i < number_of_tasks; i++)
        if(tasks[i].is_aperiodic && tasks[i].want_to_process) {
            tasks[i].to_process--;
            task_to_process = tasks[i].id;
            break;
        }

    //Se não existe mais nenhuma tarefa a ser computada, desde que atinja os critérios necessários, o idle executa
    if(!task_to_process)
        return IDLE;
        
    return task_to_process;
}


//Conta todas as trocas de contexto ocorridas no escalonador
unsigned getContextSwitch(unsigned execution_time, char *scheduler_result) {
    unsigned i, cs = 0;
    
    for(i = 0; i < execution_time-1; i++)
        if(scheduler_result[i] != scheduler_result[i+1])
            cs++;
    cs++;
    
    return cs;
}

//Retorna o valor das métricas (preempções e trocas de contexto) além do resultado final do escalonador
void calculateMetrics(unsigned execution_time, unsigned preemption, char *scheduler_result) {
    unsigned i;

    for(i = 0; i < execution_time; i++)
        printf("%c", scheduler_result[i]);
        
    printf("\n%d %d\n\n", preemption, getContextSwitch(execution_time, scheduler_result));
}

int main(void) {
    //Declaração das variáveis das tarefas periódicas, aperiódicas, polling server, etc...
    unsigned execution_time, total_p, total_a, c_ps, p_ps, d_ps, i, j, number_of_tasks, arrival, preemption;
    char id, *scheduler_result = (char*)calloc(NUM_MAX_TAREFAS+1, (NUM_MAX_TAREFAS+1)*sizeof(char));
    PERIODIC *tasks = (PERIODIC*)calloc(NUM_MAX_TAREFAS, (NUM_MAX_TAREFAS)*sizeof(PERIODIC));
    APERIODIC *aperiodics = (APERIODIC*)calloc(NUM_MAX_TAREFAS, (NUM_MAX_TAREFAS)*sizeof(APERIODIC));
    
    //Processamento do polling server
    do {
        id = 'A';
        preemption = 0;
        scanf("%u %u %u", &execution_time, &total_p, &total_a);
        if(!execution_time || !total_p || !total_a)
            break;
        number_of_tasks = total_p+total_a;
        scanf("%u %u %u", &c_ps, &p_ps, &d_ps);

        if(number_of_tasks && execution_time) {
            //Leitura das tarefas periódicas
            for(i = 0; i < total_p; i++) {
                scanf("%u %u %u", &tasks[i].c, &tasks[i].p, &tasks[i].d);
                tasks[i].id = id;
                tasks[i].is_aperiodic = false;
                tasks[i].a = 0;
                tasks[i].want_to_process = false;
                tasks[i].to_process = tasks[i].c;
                id++;
            }
            
            //Leitura das tarefas aperiódicas
            for(i = 0; i < total_a; i++) {
                scanf("%u %u", &(aperiodics[i].a), &(aperiodics[i].c));
                aperiodics[i].id = id;
                aperiodics[i].want_to_process = false;
                aperiodics[i].to_process = 0;
                id++;
            }
            
            //Como o polling server age como uma tarefa periódica, as tarefas aperiódicas são "transformadas" em periódicas, para atendimento dos requisitos de implementação
            for(i = total_p, j = 0; i < number_of_tasks; i++, j++) {
                tasks[i].id = aperiodics[j].id;
                tasks[i].is_aperiodic = true;
                tasks[i].a = aperiodics[j].a;
                tasks[i].c = aperiodics[j].c;
                tasks[i].p = p_ps;
                tasks[i].d = d_ps;
                tasks[i].want_to_process = false;
                tasks[i].to_process = 0;
            }
            
            sortPeriod(tasks, number_of_tasks);

            //Início do escalonador 
            for(i = 0; i < execution_time; i++) {                
                //Verifica e atualiza quantas computações a tarefa atual possui
                verifyPeriod(tasks, number_of_tasks, i);
                
                //Verifica qual tarefa deseja assumir o processamento
                arrival = wantProcess(tasks, number_of_tasks, i);
                
                //Verifica quem possui a maior prioridade e retorna a próxima tarefa, caso contrário verifica se alguma tarefa aperiódica que pode ser executada ou se deve ser chamado o idle
                scheduler_result[i] = arrival ? chooseTask(tasks, number_of_tasks, i, &preemption, scheduler_result) : getIdleProcess(tasks, number_of_tasks, i);
            }
            
            if(scheduler_result[execution_time-1] == IDLE)
                preemption++;
                
            //Exibe resultado do processamento, além das preempções e trocas de contexto
            calculateMetrics(execution_time, preemption, scheduler_result);
        }
    } while(number_of_tasks);
    
    return EXIT_SUCCESS;
}
