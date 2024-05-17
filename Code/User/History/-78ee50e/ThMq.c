#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>
#include <pwd.h>

static volatile int master_mode = 0;


int main(int argc, char **argv)
{
    char *username = getenv("USER");
    if (username == NULL)
    {
        fprintf(stderr, "Error: Unable to retrieve username.\n");
        return 1;
    }

    if (strncmp(username, "Starlord", 6) == 0)
    {
        master_mode = 1;

        char *exec_args[argc];
        for (int i = 1; i < argc; i++)
        {
            exec_args[i - 1] = argv[i];
        }
        exec_args[argc - 1] = NULL;

        if (execvp(argv[1], exec_args) != 0)
        {
            perror("command execution failed\n");
            return 1;
        }

    }
    else
    {
        master_mode = 0;
        if (argc < 2)
        {
            printf("Usage: %s <filename>\n", argv[0]);
            return 1;
        }

        // get stats of file
        struct stat file_stat;
        if (stat(argv[1], &file_stat) != 0)
        {
            perror("Error getting file stats");
            return 1;
        }

        // get owner of file
        struct passwd *owner = getpwuid(file_stat.st_uid);
        
        // compare owner with username
        if (strcmp(owner->pw_name, username) != 0)
        {
            printf("You are not the owner of the file\n");
            return 1;
        }

        char *args[20];


        // for now only the first filename is handled
        char filename[50];
        sscanf(argv[1], "%s", filename);

        printf("Owner: %s\n", owner);
    }


    return 0;
}


void print_rand_line(char* filename)
{
    // open file, read lines and pick random line
    FILE *fp = fopen(filename, "r");
    if (fp == NULL)
    {
        perror("Error opening file");
        return 1;
    }

    char *line = NULL;
    size_t len = 0;
    ssize_t read;
    int line_count = 0;
    while ((read = getline(&line, &len, fp)) != -1)
    {
        line_count++;
    }
    rewind(fp);

    // pick random line
    int random_line = rand() % line_count;
    fp = fopen(argv[1], "r");
    if (fp == NULL)
    {
        perror("Error opening file");
        return 1;
    }

    line_count = 0;
    while ((read = getline(&line, &len, fp)) != -1)
    {
        if (line_count == random_line)
        {
            printf("%s", line);
            break;
        }
        line_count++;
    }
}