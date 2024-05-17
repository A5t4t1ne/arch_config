#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
  //
  // C library functions required for this puzzle:
  //   printf(), fprintf(), or puts()
  //
  // The format string to output a string is '%s'. The command line arguments are
  // stored in array 'argv'. The parameter 'argc' containts the number of parameters.
  // By convention, argv[0] always containts the name of the executed program.
  //
  // Remember: placing the cursor under a function name and pressing Shift-k 
  // in command mode brings up the C programmer's manual for that function.
  //

  for (size_t i = 0; i < argc; i++)
  {
    printf("argv[%d] = \"%s\"\n", i, argv[i]);
  }
  

  return EXIT_SUCCESS;
}
