#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <dirent.h>
#include <string.h>

/**
 * Travel Unix file system recursively and count the number of files and directories
 * @return the number of files and directories
 */
int travel_dir(char *full_path)
{

}



int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s <path>\n", argv[0]);
        exit(1);
    }

    char *path = argv[1];
    int file_count = 0;
    int dir_count = 0;

    // Open the directory
    DIR *dir = opendir(path);
    if (dir == NULL) {
        perror("opendir");
        exit(1);
    }


    printf("File count: %d\n", file_count);
    printf("Directory count: %d\n", dir_count);

    closedir(dir);
    return 0;
}


// Read the directory
    struct dirent *entry;
    while ((entry = readdir(dir)) != NULL) {
        if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) {
            continue;
        }

        char full_path[1024];
        snprintf(full_path, sizeof(full_path), "%s/%s", path, entry->d_name);

        // Check if the entry is a directory
        if (entry->d_type == DT_DIR) {
            dir_count++;
            // Recursively travel the directory
            file_count += travel_dir(full_path);
        } else {
            file_count++;
        }
    }