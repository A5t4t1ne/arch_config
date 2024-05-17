#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>



int main(int argc, char **argv) {
    char *username = getenv("USER");
    
    if (username == NULL) {
        fprintf(stderr, "Error: Unable to retrieve username.\n");
        return 1;
    }
    if (strncmp(username, "Gamora", 6) == 0 && argc != 2)
    {
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    char *exec_args[argc];
    for (int i = 1; i < argc; i++) {
        exec_args[i-1] = argv[i];
    }    
    exec_args[argc-1] = NULL;

    if (execvp(argv[1], exec_args) == -1) {
        perror("command execution failed\n");
        return 1;
    }




    // char inp[100];
    // strcpy(inp, argv[1]);
    
    // // open file and read lines
    // FILE *file = fopen(inp, "r");
    // if (file == NULL) {
    //     fprintf(stderr, "Error: Unable to open file.\n");
    //     return 1;
    // }
    // char line[256];
    // while (fgets(line, sizeof(line), file)) {
    //     vulnerable_function(line);
    // }

    return 0;
}

