#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
  if (fork() == 0) {
    for (size_t i = 0 ; i < 2; i++) {
      printf("i: %ul, ", i);
      printf("ppid: %d\n", getppid()); usleep(200000); 
      printf("after\n");
    }
  }else{
    usleep(100000);
  }

  return EXIT_SUCCESS;
}
