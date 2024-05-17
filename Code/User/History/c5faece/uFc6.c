#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

#define ull unsigned long long

#define TYPE_COL_WIDTH 11
#define N_COL_WIDTH 6
#define F_NUM_COL_WIDTH 11
#define TIME_COL_WIDTH 11
#define LINE_LEN TYPE_COL_WIDTH + N_COL_WIDTH + F_NUM_COL_WIDTH + TIME_COL_WIDTH + 4*3 + 2 // col sizes, col separators, new-line + \0

#define SYNTAX "Usage:\n\
\tfibonacci <n>\n\n\
Note:\n\
\tOutput is formatted statically. Which means that if some numbers exceed a certain amount of digits, output is formatted poorly.\n\
\tMax digits:\n\
\t - Type: %d\n\
\t - N: %d\n\
\t - Fibonacci Num: %d\n\
\t - Time: %d\n"


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

  if (argc < 2 || strncmp(argv[1], "-h", 2) == 0 || strncmp(argv[1], "--help", 6) == 0)
  {
    char *err_msg;
    asprintf(&err_msg, SYNTAX, TYPE_COL_WIDTH, N_COL_WIDTH, F_NUM_COL_WIDTH, TIME_COL_WIDTH);
    printf("%s", err_msg);
    return EXIT_FAILURE;
  }

  /* format string for header*/
  char *fmt_str;
  asprintf(&fmt_str, "| %%-%ds | %%-%ds | %%-%ds | %%%ds |\n", 
            TYPE_COL_WIDTH, 
            N_COL_WIDTH, 
            F_NUM_COL_WIDTH, 
            TIME_COL_WIDTH);
  
  /* Print header */
  char *header_trailer = malloc(LINE_LEN * sizeof(char));
  memset(header_trailer, '-', LINE_LEN - 1);
  printf("%s\n", header_trailer);
  printf(fmt_str, "Type", "n", "f-num", "Time");
  printf("%s\n", header_trailer);

  /* need to craft the format string again, change from strings to numbers */
  asprintf(&fmt_str, "| %%-%ds | %%-%dd | %%-%dd | %%%dlu |\n", 
          TYPE_COL_WIDTH, 
          N_COL_WIDTH, 
          F_NUM_COL_WIDTH, 
          TIME_COL_WIDTH);


  unsigned int s_lo, s_hi, e_lo, e_hi, res;
  unsigned long long diff;
  int *invalid_nums = calloc(argc, sizeof(int));
  for (size_t i = 1; i < argc; i++)
  {
    int n = atoi(argv[i]);
    if (n < 1)
    {
      invalid_nums[i] = 1;
      continue;
    }

    read_tsc(&s_hi, &s_lo);
    res = fib_r(n);
    read_tsc(&e_hi, &e_lo);
    diff =  (((ull)e_hi << 32) | (ull)e_lo) -
            (((ull)s_hi << 32) | (ull)s_lo);
    printf(fmt_str, "recursive", n, res, diff);

    read_tsc(&s_hi, &s_lo);
    res = fib_i(n);
    read_tsc(&e_hi, &e_lo);
    diff =  (((ull)e_hi << 32) | (ull)e_lo) -
            (((ull)s_hi << 32) | (ull)s_lo);
    
    printf(fmt_str, "iterative", n, res, diff);
  }

  printf("%s\n", header_trailer);

  for (size_t i = 1; i < argc; i++)
  {
    if (invalid_nums[i] != 0)
    {
      fprintf(stderr, "Could not parse string: %s\n", argv[i]);
    }
  }
  

  return EXIT_SUCCESS;
}