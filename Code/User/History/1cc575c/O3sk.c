#include <stdio.h>
#include <stdlib.h>

void explode_bomb() {
    // Placeholder for the bomb explosion logic
    printf("Boom!\n");
    exit(EXIT_FAILURE);
}

void phase_3(const char *input) {
    int var_8, var_4, var_C;
    int eax, ecx, edx, esi = 0;

    // phase_init() equivalent in C
    // Placeholder for the phase initialization logic

    if (sscanf(input, "%d %d %d", &var_8, &var_4, &var_C) <= 2) {
        explode_bomb();
    }

    if (var_C > 8) {
        explode_bomb();
    }

    switch (var_C) {
        case 0:
            eax = 0;
            ecx = var_C;
            do {
                ecx--;
                edx = ecx >= 0 ? ecx : 0;
                esi += edx + 1;
                ecx -= edx;
            } while (ecx > 0);
            var_C = ecx;
            break;
        case 1:
            eax = 0x315;
            ecx = var_C;
            do {
                ecx--;
                edx = ecx >= 0 ? ecx : 0;
                esi += edx + 1;
                ecx -= edx;
            } while (ecx > 0);
            var_C = ecx;
            break;
        case 2:
            eax = 0;
            edx = -0x1a3;
            break;
        case 3:
            eax = 0;
            edx = 0x1a3;
            ecx = var_C;
            do {
                ecx--;
                eax = ecx >= 0 ? ecx : 0;
                esi += eax + 1;
                ecx -= eax;
            } while (ecx > 0);
            var_C = ecx;
            break;
        case 4:
            eax = 0;
            edx = -0x1a3;
            break;
        case 5:
            eax = 0;
            edx = 0x1a3;
            ecx = var_C;
            do {
                ecx--;
                eax = ecx >= 0 ? ecx : 0;
                esi += eax + 1;
                ecx -= eax;
            } while (ecx > 0);
            var_C = ecx;
            break;
        case 6:
            eax = 0;
            edx = -0x1a3;
            break;
        case 7:
            eax = 0;
            edx = 0x1a3;
            break;
        default:
            explode_bomb();
            break;
    }

    if (var_C > 7) {
        explode_bomb();
    }

    if (var_8 != edx || var_4 != esi) {
        explode_bomb();
    }
}
