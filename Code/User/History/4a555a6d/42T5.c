#include <stdio.h>

void phase_4(const char *input) {
    int var_1004, var_1008, var_100c;
    int eax, edx, esi;
    int *rsp, *rbx, *r12;
    int rbp = 0;

    // Simulating the stack space allocation
    int simulated_stack[0x1010 / sizeof(int)];
    rsp = simulated_stack;

    // phase_init() equivalent in C is not provided, assuming it's an external function.
    phase_init();

    // Equivalent of sscanf in C
    eax = sscanf(input, "%d %d", &var_1008, &var_100c);

    if (eax <= 2) {
        explode_bomb();
    }

    eax = var_100c;
    if (eax <= 2) {
        explode_bomb();
    }

    edx = var_1008;
    if (edx > 0x400) {
        explode_bomb();
    }

    if (edx >= eax) {
        explode_bomb();
    }

    esi = var_1008 - var_100c;
    // func4() equivalent in C is not provided, assuming it's an external function.
    func4(rsp, esi);

    eax = var_1008 - var_100c;
    if (eax <= 0) {
        explode_bomb();
    }

    rbx = rsp;
    eax = eax - 1;
    r12 = rsp + eax;

    do {
        esi = *rbx;
        esi = (esi >> 31) + esi;
        esi = esi >> 1;
        // func4_p() equivalent in C is not provided, assuming it's an external function.
        eax = func4_p(esi);

        if (eax == 1) {
            rbp++;
        }

        rbx += 1;
    } while (rbx != r12);

    if (rbp != var_1004) {
        explode_bomb();
    }
}

