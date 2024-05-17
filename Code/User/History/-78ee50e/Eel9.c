#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <stdbool.h>

void get_filename(char *dest);
void abort_if_not_owner(char *filename);
void print_rand_line(char* filename);




int main(int argc, char **argv)
{


    get_filename(argv[1]);

    print_rand_line(argv[1]);

    return 0;
}


void get_filename(char *dest)
{
    char name[30];

    printf("Enter the filename: ");
    gets(name);

    abort_if_not_owner(name);


    return;
}



void abort_if_not_owner(char *filename)
{
    uid_t user_id = getuid();
    struct stat file_stat;

    if (stat(filename, &file_stat) == -1) {
        perror("Error getting file information");
        exit(1);
    }

    // Check if the file owner matches the current user
    if (file_stat.st_uid != user_id) {
        printf("Error: You do not have permission to read the file.\n");
        exit(1);
    }
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