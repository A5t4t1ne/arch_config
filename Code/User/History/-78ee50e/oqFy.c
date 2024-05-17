#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>



int main(int argc, char **argv) {
    printf("1\n");
    if (argc < 2)
    {
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }
    char *username = getenv("USER");
    printf("Hello, %s!\n", username);
    if (username == NULL) {
        fprintf(stderr, "Error: Unable to retrieve username.\n");
        return 1;
    }

    // execute arguments as commands with arguments with execvp
    char *args[] = {argv[1], NULL};
    execvp(args[0], args);



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

