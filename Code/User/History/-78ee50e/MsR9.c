#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>


static volatile int master_mode = 0;
void not_owner();
void print_rand_line(char *filename);


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

        struct uid_t user_id = getuid();

        // Check if the file exists and get its owner
        if (stat(FILENAME, &file_stat) == -1) {
            perror("Error getting file information");
            exit(1);
        }

        // Check if the file owner matches the current user
        if (file_stat.st_uid != user_id) {
            printf("Error: You do not have permission to read the file.\n");
            exit(1);
        }
        char filename[50];
        strcpy(filename, argv[1]);

        // compare owner with username
        if (strcmp(owner->pw_name, username) != 0)
        {
            not_owner();
            return 1;
        }

        // for now only the first filename is handled
        sscanf(argv[1], "%s", filename);

    }


    return 0;
}



void not_owner()
{
    printf("You are not the owner of the file\n");
}


void print_rand_line(char* filename)
{
    // open file, read lines and pick random line
    FILE *fp = fopen(filename, "r");
    if (fp == NULL)
    {
        perror("Error opening file");
        return;
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
    fp = fopen(filename, "r");
    if (fp == NULL)
    {
        perror("Error opening file");
        return;
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