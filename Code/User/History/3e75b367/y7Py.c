#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <vector.h>

#define N 1000

int main(int argc, char *argv[])
{
  //
  // read 'n' from command line or initialize to N
  //
  int n = argc > 1 ? atoi(argv[1]) : 0;
  if (n <= 0) n = N;

  //
  // allocate memory for three vectors
  //
  int *A = malloc(n*sizeof(int));
  int *B = malloc(n*sizeof(int));
  int *C = malloc(n*sizeof(int));
  if (!A || !B || !C) {
    fprintf(stderr, "Error: cannot allocate memory.\n");
    return EXIT_FAILURE;
  }

  //
  // initialize A,B vectors with random numbers
  //
  srand(time(NULL));   // initialize random generator

  for (int i=0; i<n; i++) {
    A[i] = rand() % 8192;
    B[i] = rand() % 8192;
  }

  //
  // use vector library to add vectors
  //
  vector_add(C, A, B, n);

  //
  // compute dot product
  //
  long long dot = vector_dot(A, B, n);

  //
  // print result (partially)
  //
  printf("vector addition\n");
  printf("  A: ");
  for (int i=0; i<10; i++) printf("%5d  ", A[i]);
  printf("\n");
  printf("  B: ");
  for (int i=0; i<10; i++) printf("%5d  ", B[i]);
  printf("\n");
  printf("  C: ");
  for (int i=0; i<10; i++) printf("%5d  ", C[i]);
  printf("\n\n\n");

  printf("dot product\n");
  printf("  dot(A, B) = %lld\n", dot);

  //
  // free memory
  //
  free(A);
  free(B);
  free(C);

  return EXIT_SUCCESS;
}
