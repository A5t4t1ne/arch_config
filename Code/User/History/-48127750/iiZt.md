# SYSSEC Assignment 3 Report

## 64 Bit ohne Optimierung

Der Assembly Code ist sehr equivalent zum C-Code.

## 64 Bit mit Optimierungen (lvl 3)

## 32 Bit ohne Optimierungen

Die 32bit Version des (unobtimierten) Codes ist sehr ähnlich zur 64bit Version (abgesehen von der Word Grösse natürlich). Die Statements sind oftmals die gleichen (mit dem Unterschied, dass bei 64 Bit natürlich die Jump-Offsets grössen sind), mit den gleichen Abläufen, Vergleichen und die Proportionen der einzelnen Funktionen stimmen auch überein. Aber alle Funktionen in der 32bit Version sind ein wenig länger. Der Unterschied liegt dabei hauptsächlich an den zusätzlichen load Instruktionen am Anfang der Funktionenen. Zum Vergleich die Anfänge der jeweiligen Fibonacci Funktion:

**32 Bit:**
```armasm
push   %ebp
mov    %esp,%ebp
push   %ebx
sub    $0x4,%esp
call   8
add    $0x1,%eax
cmpl   $0x1,0x8(%ebp)
```


**64 Bit:**

```armasm
push   %rbp
mov    %rsp,%rbp
push   %rbx
sub    $0x18,%rsp
mov    %rdi,-0x18(%rbp)
cmpq   $0x1,-0x18(%rbp)
```


### Mit Optimierung (lvl 3)



## Source Code

```c
#include <stdio.h>
#include <stdlib.h>

unsigned long fibonacci(unsigned long n)
{
  if (n < 2) return 1;
  else return fibonacci(n-1) + fibonacci(n-2);
}

unsigned long factorial(unsigned long n)
{
  if (n < 2) return 1;
  else return n*factorial(n-1);
}

int main(int argc, char *argv[])
{
  if (argc < 2) {
    printf("Argument expected.\n");
    return EXIT_FAILURE;
  }

  long l = atol(argv[1]);
  if (l > 0) {
    unsigned long ul = (unsigned long)l;
    printf("Argument: %lu\n", ul);
    printf("  factorial(%lu) = %lu\n", ul, factorial(ul));
    printf("  fibonacci(%lu) = %lu\n", ul, fibonacci(ul));
  }

  return EXIT_SUCCESS;
}
```
