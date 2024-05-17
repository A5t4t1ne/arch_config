# SYSSEC Assignment 3 Report

## 64bit

Decompilation of 64bit version of the [Source Code](#source-code)

### Ohne Optimierung

Der Assembly Code ist 

### Mit Optimierungen (lvl 3)

## 32bit

### Ohne Optimierungen

Die 32bit Version des (unobtimierten) Codes ist sehr ähnlich zur 64bit Version (abgesehen von der Word Grösse natürlich). Die Statements sind oftmals die gleichen, mit den gleichen Abläufen, Vergleichen und die Proportionen der einzelnen Funktionen stimmen auch überein. Aber alle Funktionen in der 32bit Version sind ein wenig länger. Der Unterschied liegt dabei hauptsächlich an den zusätzlichen load Instruktionen am Anfang der Funktionen. Zum Vergleich ein Ausschnitt der Fibonacci Funktion:

| 32 Bit Fibonacci | 64 Bit Fibonacci | 
|-|-|
| ```0:	push   %ebp <br> 
 1:	mov    %esp,%ebp
 3:	push   %ebx
 4:	sub    $0x4,%esp
 7:	call   8 <fibonacci+0x8>
 c:	add    $0x1,%eax
11:	cmpl   $0x1,0x8(%ebp)``` 

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
