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
#include <pwd.h>

void get_filename(char *dest);
void abort_if_not_owner(char *filename);
void print_rand_line(char *filename);

int main(int argc, char **argv)
{
    printf("%d", getuid());
    struct passwd *pw = getpwuid(getuid());

    if (pw == NULL)
    {
        perror("Error getting user info");
        return 1;
    }

    char name[] = "EGO";
    if (pw->pw_uid == 0 || strncmp(pw->pw_name, name, sizeof(name)) == 0)
    {
        printf("Nope\n");
        return 1;
    }

    // char *filename;
    // get_filename(filename);
    // print_rand_line(filename);

    return 0;
}

void get_filename(char *dest)
{
    char tmp_name[200];

    printf("Enter the filename: ");
    fgets(tmp_name, sizeof(tmp_name) - 1, stdin);

    if (*dest != NULL)
    {
        free(dest);
    }

    asprintf(&dest, "%s", tmp_name);

    return;
}

void print_rand_line(char *filename)
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