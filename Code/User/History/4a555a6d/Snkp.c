#include <stdio.h>
#include <stdint.h>



int func4_p(int edi, int esi) {
    if (esi == 1) {
        return 1;
    }
    int eax = edi;
    eax = eax / esi; // Division, quotient in eax, remainder in edx
    int edx = edi % esi;
    if (edx == 0) {
        return 0;
    }
    esi = esi - 1;
    return func4_p(edi, esi);
}



extern int32_t i_3621; // Assuming this is a global variable defined elsewhere

void func4(int32_t *rdi, int32_t esi) {
    if (esi == 0) {
        return;
    }

    int32_t eax, edx;
    eax = i_3621;
    edx = eax + 1;
    i_3621 = edx;
    *rdi = eax;
    esi -= 1;
    rdi += 1;
    func4(rdi, esi);
}




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


// --------- version 2 ---------

int func4_p(int edi, int esi) {
    if (esi == 1) {
        return 1;
    }
    int eax = edi;
    eax = eax / esi; // Division, quotient in eax, remainder in edx
    int edx = eax % esi;
    if (edx == 0) {
        return 0;
    }
    esi = esi - 1;
    return func4_p(edi, esi);
}

void phase_4(char *rbx) {
    int eax, edx, esi;
    int rsp_1008, rsp_100c;
    int result;

    // sscanf equivalent in C
    eax = sscanf(rbx, "%d %d", &rsp_1008, &rsp_100c);
    if (eax <= 2) {
        if (rsp_100c <= 2) {
            if (rsp_1008 <= 0x400) {
                if (rsp_1008 >= rsp_100c) {
                    explode_bomb();
                }
                esi = rsp_1008 - rsp_100c;
                result = func4(esi);
                eax = rsp_1008 - rsp_100c;
                if (eax > 0) {
                    int ebp = 0;
                    for (int i = 0; i < eax - 1; ++i) {
                        int temp = *((int *)rbx + i);
                        esi = temp;
                        esi = esi >> 31;
                        esi = (temp + esi) >> 1;
                        if (func4_p(temp, esi) == 1) {
                            ebp = i + 1;
                        }
                    }
                    if (ebp != *((int *)rbx)) {
                        explode_bomb();
                    }
                }
            }
        }
    }
    // Rest of the code is for cleanup and return, which is not needed in C
}

