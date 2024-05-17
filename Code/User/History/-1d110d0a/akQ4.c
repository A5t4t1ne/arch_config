#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define HELLO_STR "Hello, REVE1!"


int main(int argc, char *argv[])
{
  //
  // C library functions required for this puzzle:
  //   printf(), fprintf(), or puts()
  //
  // Remember: placing the cursor under a function name and pressing Shift-k 
  // in command mode brings up the C programmer's manual for that function.
  //

  char *str[18];

  int count = 10;
  for (size_t i = 0; i < count; i++)
  {
    i < 10 ? printf(" ");
    printf("%d: %s", i, HELLO_STR);
  }
  

  return EXIT_SUCCESS;
}
