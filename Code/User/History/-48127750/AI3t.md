# SYSSEC Assignment 3 Report

## 64 Bit ohne Optimierung

Der Assembly Code ist sehr equivalent zum C-Code. Nach dem Initialisieren am Anfang der Funktionen, kann der dazugehörige C-Code meistens fast 1:1 abgeleitet werden. Zum Beispiel die Fibonacci Funktion:

```armasm
; equivalent zu if (n < 2)
cmpq   $0x1,-0x18(%rbp) ; compare value '1' with 'n'
ja     1b <fibonacci+0x1b> ; jump if above to addr 1b, which means jump over the following 2 Lines if n is greater 


mov    $0x1,%eax
jmp    41 <fibonacci+0x41>
```

## 64 Bit mit Optimierungen (lvl 3)

## 32 Bit ohne Optimierungen

Die 32bit Version des unobtimierten Codes ist, nebst den offensichtlichen Unterschieden wie Word-Grösse, Register-Grössen, Jump-Offsets etc., sehr ähnlich zur 64bit Version. Die Statements sind oftmals die Gleichen, mit den gleichen Abläufen, Vergleichen und die Proportionen der einzelnen Funktionen stimmen auch überein. Was auch anders ist, ist die Art wie Funktions-Argumente übergeben werden (ob Stack oder direkt mit Register). Zum Vergleich, der Start der jeweiligen Fibonacci Funktionen

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
