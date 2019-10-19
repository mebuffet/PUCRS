#include <reg51.h>
#include <stdio.h>

#define DIM 2

char matrixA[DIM][DIM]={
  {2,2},
  {2,2}
};
char matrixB[DIM][DIM]={
  {2,2},
  {2,2}
};
char matrixC[DIM][DIM]={
  {0,0},
  {0,0}
};

char i = 0, j = 0, k = 0, tmp1, tmp2;

void main(void) {
  P0=0x00;
  matrixA[0][0] = 2;
  matrixA[0][1] = 2;
  matrixA[1][0] = 2;
  matrixA[1][1] = 2;
  matrixB[0][0] = 2;
  matrixB[0][1] = 2;
  matrixB[1][0] = 2;
  matrixB[1][1] = 2;
  matrixC[0][0] = 0;
  matrixC[0][1] = 0;
  matrixC[1][0] = 0;
  matrixC[1][1] = 0;
  i = 0;
  j = 0;
  k = 0;

  for (i = 0; i < DIM; i++)
    for (j = 0; j < DIM; j++)
      for (k = 0; k < DIM; k++)
        tmp1 = matrixA[i][k];
        tmp2 = matrixB[k][j];
        matrixC[i][j] += tmp1 * tmp2;
  P0=0x01;
}
