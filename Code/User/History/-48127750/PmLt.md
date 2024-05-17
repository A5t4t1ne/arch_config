# SYSSEC Assignment 3 Report

## 64 Bit ohne Optimierung

Der Assembly Code ist sehr equivalent zum C-Code. Nach dem Initialisieren am Anfang der Funktionen, kann der dazugehörige C-Code meistens fast 1:1 abgeleitet werden. Zum Beispiel die Fibonacci Funktion:

```armasm
; init

; equivalent zu "if (n < 2)"
cmpq   $0x1,-0x18(%rbp) ; compare value '1' with 'n'
ja     1b <fibonacci+0x1b> ; jump over the following 2 Lines if %rbp/n was greater than 1 in above comparison

; equivalent to "return 1";
mov    $0x1,%eax ; prepare return value (1)
jmp    41 <fibonacci+0x41> ; jump to end of function


; equivalent to "fibonacci(n - 1)"
sub    $0x1,%rax ; subtract 1 from n
mov    %rax,%rdi ; store function paramater in designated register
call   2b <fibonacci+0x2b> ; call recursively with n-1

; same for "fibonacci(n-2)" ...
```

Aber auch die Main Funktion ist sehr ähnlich / einfach nachzuvollziehen, vor allem mit gdb, da dort bei den `call`'s noch der Funktionsname, der aufzurufenden Funktion angezeigt wird. Der folgende Ausschnit ist für den Aufruf (und Ausgabe) der einzelnen Funktionen

```armasm
; l = atoi(argv[1])
mov    %rax,%rdi
call   b9 <main+0x41> 
mov    %rax,-0x10(%rbp)

cmpq   $0x0,-0x10(%rbp) ; if (l > 0) / compare l & 0
jle    13b <main+0xc3> ; jump to end of main if l is lesser or equal to 0

; the following few lines are the only ones I don't really get
mov    -0x10(%rbp),%rax
mov    %rax,-0x8(%rbp)
mov    -0x8(%rbp),%rax
mov    %rax,%rsi
lea    0x0(%rip),%rax        
mov    %rax,%rdi
mov    $0x0,%eax
call   e7 <main+0x6f> ; printf()
mov    -0x8(%rbp),%rax
mov    %rax,%rdi ; write l into reg (which will be n in "factorial()")
call   f3 <main+0x7b> ; factorial()
```

## 32 Bit ohne Optimierungen

Die 32bit Version des unobtimierten Codes ist, nebst den offensichtlichen Unterschieden wie Word-Grösse, Register-Grössen, Jump-Offsets etc., sehr ähnlich zur 64bit Version. Die Statements sind oftmals die Gleichen, mit den gleichen Abläufen, Vergleichen und die Proportionen der einzelnen Funktionenslängen stimmen auch überein. Die Bit32 Funktionen sind aber alle ein wenig länger, was mehrheitlich and den zusätzlichen load/save-operationen liegt. Was anders ist, ist die Art wie Funktions-Argumente übergeben werden (ob Stack oder direkt mit Register). Zum Vergleich, der Start der jeweiligen Fibonacci Funktionen:

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



## Optimierungen

Zusammengefasst: Big cluster of fancy magic.

Was ich soweit verstanden habe (zumindest glaube ich das) ist, dass der Compiler den rekursiven Aufruf der Fibonacci-Methode verringern will und daher (somewhat) identischischen Code ausschreibt. Ich verstehe aber nicht warum so oft und warum jetzt plötzlich xor Berechnungen und 'and' Operationen auf gewissen Registern angewendet werden.


Im völligen Gegensatz dazu beinhaltet d


Zusätzlich wird viel mehr mit dem Stack gearbeitet. Während im unoptimierten Code keine 'push' und 'pop' Statements waren, wurden diese immer mal wieder in der optimierten Version verwendet. Was Sinn macht um Memory Zugriffe zu reduzieren


## Source Code

Nur als Referenz

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
