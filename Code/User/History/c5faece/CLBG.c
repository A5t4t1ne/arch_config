#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

#define ull unsigned long long
#define LINE_LEN 50
#define SYNTAX "\
Usage:\n\n\
\tfibonacci <n>"

unsigned int fib_r(int n){
  unsigned int i = n >= 2 ? fib_r(n-2) + fib_r(n-1) : 1;
  return i;
}


unsigned int fib_i(int n){
  unsigned int a = 0, b = 2, c = 1;
  if (n <= 2)
  {
    return 1;
  }

  for (size_t i = 0; i < n - 2; i++)
  {
    a = b + c;
    c = b;
    b = a;
  }
  
  return a;
}


void read_tsc(unsigned int *hi, unsigned int *lo)
{
  asm volatile("rdtsc; movl %%edx, %0; movl %%eax, %1"
  : "=r" (*hi), "=r" (*lo)
  :
  : "%edx", "%eax");
}


int main(int argc, char *argv[])
{
  //
  // C library functions required for this puzzle:
  //   printf(), fprintf(), or puts()
  //   atoi()
  //
  // Remember: placing the cursor under a function name and pressing Shift-k 
  // in command mode brings up the C programmer's manual for that function.
  //

  if (argc < 2)
  {
    printf("To little argument count\n%s\n", SYNTAX);
    return EXIT_FAILURE;
  }
  

  unsigned int s_lo, s_hi, e_lo, e_hi, res;
  unsigned long long diff;
  int n = atoi(argv[1]);

  read_tsc(&s_hi, &s_lo);
  res = fib_r(n);
  read_tsc(&e_hi, &e_lo);
  diff =  (((ull)e_hi << 32) | (ull)e_lo) -
          (((ull)s_hi << 32) | (ull)s_lo);

  /* format string based on Method, number and time, right aligned and always with a line length of 32*/
  char *fmt_str = "| %-10s | %-6s | %-11s | %11s |\n";
  
  char *header_trailer = malloc((LINE_LEN+2) * sizeof(char));
  memset(header_trailer, '-', LINE_LEN);
  printf("%s\n", header_trailer);
  printf(fmt_str, "Type", "n", "f-num", "Time");
  printf("%s\n", header_trailer);
  fmt_str = "| %-10s | %-6u | %-11u | %11ld |\n";
  printf(fmt_str, "recursive", n, res, diff);

  read_tsc(&s_hi, &s_lo);
  res = fib_i(n);
  read_tsc(&e_hi, &e_lo);
  diff =  (((ull)e_hi << 32) | (ull)e_lo) -
          (((ull)s_hi << 32) | (ull)s_lo);
  
  printf(fmt_str, "iterative", n, res, diff);
  printf("%s\n", header_trailer);
  
  return EXIT_SUCCESS;
}
