//TODO use threads to compute number, compare existing numbers (to avoid duplicate numbers) and to save them

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

int main(int argc, char *argv[]) {

    if(argc != 3)
        exit(0);

    int number, size, i;
    char *filename;
    FILE *filepointer;

    size = atoi(argv[2]);
    filename = argv[1];

    filepointer = fopen(argv[1], "w+");
    srand(time(NULL));

    printf("[%s] [%d] [0, %d]\n", filename, size, RAND_MAX);


    for(i = 0; i < size; i++) {
        number = rand() % size;
        fprintf(filepointer, "%d\n", number);
    }

    fclose(filepointer);

    return 0;
}
