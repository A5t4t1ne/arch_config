#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>


static const int global1 = 1;
static const int global2 = 2;
static const int global3 = 3;

int main(int argc, char *argv[])
{
  //
  // C library functions required for this puzzle:
  //   printf(), fprintf(), or puts()
  //
  // Remember: placing the cursor under a function name and pressing Shift-k 
  // in command mode brings up the C programmer's manual for that function.
  //

  const int local1 = 4;
  const int local2 = 5;
  const int local3 = 6;

  printf("%p\n%p\n%p\n%p\n%p\n%p\n", &global1, &global2, &global3, &local1, &local2, &local3);
  printf("%p", &main);
  
  return EXIT_SUCCESS;
}
