#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void swap(int *a, int*b);

int main(int argc, char *argv[])
{
  //
  // C library functions required for this puzzle:
  //   printf(), fprintf(), or puts()
  //
  // Remember: placing the cursor under a function name and pressing Shift-k 
  // in command mode brings up the C programmer's manual for that function.
  //

  int a = 1, b = 2;
  printf("a = %d, b = %d\n", a, b);    // result: a = 1, b = 2
  swap( ... );
  printf("a = %d, b = %d\n", a, b);    // result: a = 2, b = 1


  return EXIT_SUCCESS;
}
