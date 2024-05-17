/*
 * Filename: main.c
 * Author: David Jäggli
 * Date: 14.3.2023
 * Description: Standard functions for reading, editing and data collection of
 *              password manager files.
 */

/**********************************************************************************************
 * Includes
 **********************************************************************************************/
/* external libraries */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <openssl/sha.h>
#include <unistd.h>
#include <sodium.h>
#include <ctype.h>
#include <signal.h>

/* custom imports */
#include "files.h"
#include "main.h"
#include "password.h"

/**********************************************************************************************
 * Private function Headers
 **********************************************************************************************/
/* user interaction */
static void get_db_name(unsigned char *name);
static bool unlock_database(pw_list_t *pwList);
static void request_master_password(unsigned char *output, bool new);
static void cleanup(pw_list_t *pwList);
static void get_n_chars(char *dest, size_t n, char *prompt);
static bool is_printable(const unsigned char *str);
static void int_handler(int sig);

/**********************************************************************************************
 * Global variables
 **********************************************************************************************/
static volatile sig_atomic_t running = 1; // flag for signal handler

/**********************************************************************************************
 * Main function
 **********************************************************************************************/
int main()
{
    signal(SIGINT, int_handler); // ensure proper cleanup on SIGINT (Ctrl+C)

    if (sodium_init() < 0)
    {
        printf("\033[31m"); // set text color to red
        printf("[!] Error initializing libsodium\n");
        printf("\033[0m"); // reset text color to default
        return 1;
    }

    pw_list_t pwList = {
        .file = NULL,
        .filename = malloc(sizeof(char) * MAX_DB_NAME_LEN),
        .master_pw = malloc(sizeof(char) * MAX_MASTER_PW_LEN),
        .entries = (unsigned char *)calloc(ENTRIES_BLOCK_SIZE, sizeof(char)),
        .entry_count = 0,
        .size = 1,
    };

    /* startup sequence */
    char inp;
    while (pwList.file == NULL && running)
    {
        /* Clear input until whitespace */
        printf("Enter 'o' for opening a database, 'c' for creating one or 'q' to quit:\n> ");
        inp = getchar();

        fflush(stdin); // clear input buffer

        switch (inp)
        {
        case 'o':
            get_db_name(pwList.filename);
            if (unlock_database(&pwList) == false)
            {
                continue;
            }
            break;

        case 'c':
            get_db_name(pwList.filename);

            /* check if file already exists */
            pwList.file = fopen(pwList.filename, "r");
            if (pwList.file != NULL)
            {
                printf("\033[31m"); // set text color to red
                printf("[!] File already exists\n");
                printf("\033[0m"); // reset text color to default
                fclose(pwList.file);
                pwList.file = NULL;
                pwList.filename = NULL;
                continue;
            }

            /* create new file */
            pwList.file = fopen(pwList.filename, "w+");
            if (pwList.file == NULL)
            {
                printf("\033[31m"); // set text color to red
                perror("\n[!] Error creating file\n");
                printf("\033[0m"); // reset text color to default
                continue;
            }

            request_master_password(pwList.master_pw, true);
            save_master_pw(&pwList, pwList.master_pw);
            save_to_file(&pwList); // initial creation of file
            printf("\033[32m");    // set text color to green
            printf("\n[*] Database created successfully\n\n");
            printf("\033[0m"); // reset text color to default
            break;

        case 'q':
            printf("\n[*] quitting...\n");
            cleanup(&pwList);
            return 0;

        default:
            printf("\033[31m"); // set text color to red
            printf("[!] Invalid option\n");
            printf("\033[0m"); // reset text color to default
        }
    }

    /* main sequence */
    printf("Enter a command. 'h' for help\n");
    while (running)
    {
        printf("> ");
        inp = getchar();
        fflush(stdin); // clear input buffer
        switch (inp)
        {
        case 'e':
        {
            unsigned char key[MAX_KEY_LEN] = {0};
            unsigned char val[MAX_VAL_LEN] = {0};

            get_n_chars(key, MAX_KEY_LEN, "Enter the key: ");
            if (key[0] == '\0')
            {
                printf("\033[31m"); // set text color to red
                printf("[!] Key cannot be empty\n");
                printf("\033[0m"); // reset text color to default
                break;
            }

            /*  Generate password or let user set manually */
            bool inp_valid = false;
            while (!inp_valid)
            {
                printf("Choose one of the following:\n1 - set password manually\n2 - generate password\n> ");
                inp = getchar();
                fflush(stdin); // clear input buffer

                if (inp < '1' || inp > '2')
                {
                    printf("[*] not a valid option\n");
                    continue;
                }

                switch (inp)
                {
                case '1':
                    get_n_chars(val, MAX_VAL_LEN, "Enter the new value: ");
                    inp_valid = true;
                    break;
                case '2':
                {
                    printf("Choose the charset complexity:\n1 - weak\n2 - medium\n3 - strong\n> ");
                    inp = getchar();
                    fflush(stdin); // clear input buffer

                    if (inp < '1' || inp > '3')
                    {
                        printf("\033[31m"); // set text color to red
                        printf("[!] not a valid option\n");
                        printf("\033[0m"); // reset text color to default
                        continue;
                    }

                    unsigned char *len_inp = malloc(sizeof(char) * 3);
                    get_n_chars(len_inp, 3, "Enter length of password: ");
                    int len = atoi(len_inp);
                    if (len > MAX_VAL_LEN || len < 1)
                    {
                        printf("\033[31m"); // set text color to red
                        printf("[!] Password len not valid (max: %d)\n", MAX_VAL_LEN);
                        printf("\033[0m"); // reset text color to default
                        break;
                    }
                    switch (inp)
                    {
                    case '1':
                        generate_passwd(val, WEAK, len);
                        inp_valid = true;
                        break;
                    case '2':
                        generate_passwd(val, MEDIUM, len);
                        inp_valid = true;
                        break;
                    case '3':
                        generate_passwd(val, STRONG, len);
                        inp_valid = true;
                        break;
                    default:
                        printf("\033[31m"); // set text color to red
                        printf("not a valid option\n");
                        printf("\033[0m"); // reset text color to default
                        break;
                    }
                    break;
                }
                case 'q':
                    printf("\n[*] quitting...\n");
                    running = false;
                    inp_valid = true;
                    break;
                default:
                    printf("\033[31m"); // set text color to red
                    printf("[!] not a valid option\n");
                    printf("\033[0m"); // reset text color to default
                    break;
                }
            }
            if (!set_entry(&pwList, key, val))
            {
                printf("\033[31m"); // set text color to red
                printf("[!] Error setting entry\n");
                printf("\033[0m"); // reset text color to default
            }
            break;
        }
        case 'q':
            printf("\n[*] quitting...\n");
            running = false;
            break;
        case 'd':
        case 'r':
        {
            unsigned char *key = malloc(sizeof(char) * MAX_KEY_LEN);
            get_n_chars(key, MAX_KEY_LEN, "Enter the key: ");
            remove_entry(&pwList, key);
            break;
        }
        case 'g':
        {
            unsigned char *key = malloc(sizeof(char) * MAX_KEY_LEN);
            get_n_chars(key, MAX_KEY_LEN, "Enter the key: ");
            unsigned char *val = calloc(MAX_VAL_LEN, sizeof(unsigned char));
            long offset = get_entry_value(&pwList, val, key);
            if (offset == -1)
            {
                printf("Entry not found\n");
            }
            else
            {
                copy_to_clipboard(val);
            }
            break;
        }
        case 'l':
            printf("All entries:\n----------------\n");
            list_all_entries(&pwList);
            printf("----------------\n");
            break;
        case 'h':
            printf("Summary of valid character inputs:\ne - edit entry\nd - delete entry\ng - get/search for entry & copy to clipboard\nl - list all entries\nq - quit application\nh - help\n");
            break;
        case '\n':
            break;
        default:
            printf("\033[31m"); // set text color to red
            printf("[!] Invalid option enter 'h' for help\n");
            printf("\033[0m"); // reset text color to default
        }
    }

    cleanup(&pwList);

    return 0;
}

/**********************************************************************************************
 * private functions
 **********************************************************************************************/
/**
 * Requests a valid database filename from the user
 * @param name variable where the name gets stored to
 */
static void get_db_name(unsigned char *name)
{
    printf("Max DB name length: %d\n", MAX_DB_NAME_LEN);

    bool name_valid = false;
    while (!name_valid)
    {
        get_n_chars(name, MAX_DB_NAME_LEN, "Enter DB name: ");
        int file_extension_offset = strlen(name) - strlen(FILE_EXTENSION);
        if (strncmp(FILE_EXTENSION, name + file_extension_offset, strlen(FILE_EXTENSION)) != 0 ||
            name[file_extension_offset - 1] != '.')
        {
            printf("Not a pw file (.%s)\n", FILE_EXTENSION);
        }
        else if (is_printable(name) == false)
        {
            printf("String contains invalid characters\n");
        }
        else
        {
            name_valid = true;
        }
    }
}

/**
 * Check if string is printable.
 * @param str string to check
 */
static bool is_printable(const unsigned char *str)
{
    for (size_t i = 0; i < strlen(str); i++)
    {
        if (!isprint(str[i]))
        {
            return false;
        }
    }
    return true;
}

/** Unlocks the database by requesting the master password from the user.
 * Asks the user for the master password and makes use of load_pw_file_content().
 * @param pwList
 */
static bool unlock_database(pw_list_t *pwList)
{
    char pw[MAX_MASTER_PW_LEN + 1] = {0};

    if (pwList->file != NULL)
    {
        fclose(pwList->file);
    }

    pwList->file = fopen(pwList->filename, "r+");
    if (pwList->file == NULL)
    {
        printf("\033[31m"); // set text color to red
        printf("[!] Failed to open file\n");
        printf("\033[0m"); // reset text color to default
        return false;
    }

    request_master_password(pw, false);

    if (check_master_pw(pwList, pw) == true)
    {
        printf("\033[32m"); // set text color to green
        printf("\n[*] Password accepted\n");
        printf("\033[0m"); // reset text color to default
        strncpy(pwList->master_pw, pw, MAX_MASTER_PW_LEN);
        load_pw_file_content(pwList);
        return true;
    }
    else
    {
        printf("\033[31m"); // set text color to red
        printf("[!] Password incorrect\n");
        printf("\033[0m"); // reset text color to default
        fclose(pwList->file);
        pwList->file = NULL;
        return false;
    }
}

/**
 * Request up to n characters from the cli.
 * Requests the input until the user enters a string with the the maximum length specified and
 * writes it to the dest variable. Before requesting input it prints `prompt` to the cli.
 * @param dest pointer to the variable where the input gets written to
 * @param n number of characters to request
 * @param prompt string to print before requesting input
 */
static void get_n_chars(char *dest, size_t n, char *prompt)
{
    char buf[n + 2]; // +2 for newline and null terminator

    while (true)
    {
        clear_inp_buffer();
        memset(buf, 0, sizeof(buf));
        printf("%s", prompt);
        fgets(buf, sizeof(buf), stdin);

        int c;
        if (buf[sizeof(buf) - 2] != 0)
        {
            printf("\033[31m"); // set text color to red
            printf("[!] Input too long\n");
            printf("\033[0m"); // reset text color to default

            /* Clear input until whitespace */
            while ((c = getchar()) != '\n' && c != EOF)
                ;
        }
        else
        {
            int newline_pos = strcspn(buf, "\n");
            buf[newline_pos] = 0;
            strncpy(dest, buf, newline_pos + 1);
            return;
        }
    }
}

/**
 * Requests a password from the user over cli.
 * With the `new` flag set to true, the user will be asked to enter the password twice.
 * @param output pointer to the variable where the password gets written to
 * @param new if true, the user will be asked to enter the password twice
 */
static void request_master_password(unsigned char *output, bool new)
{
    bool pw_accepted = false;

    while (!pw_accepted)
    {
        char buf[MAX_MASTER_PW_LEN + 1] = {0};
        char prompt[100] = {0};

        // forge prompt message
        sprintf(prompt, "Enter master password (extended ASCII only, no spaces, max %d chars):", MAX_MASTER_PW_LEN);
        get_n_chars(buf, MAX_MASTER_PW_LEN, prompt);

        // if a new password is requested, ask the user to enter to confirm it
        if (new)
        {
            char buf2[MAX_MASTER_PW_LEN + 1] = {0};

            strncpy(prompt, "Repeat:", sizeof(prompt));
            get_n_chars(buf2, MAX_MASTER_PW_LEN, prompt);

            if (strncmp(buf, buf2, MAX_MASTER_PW_LEN + 1) != 0)
            {
                printf("[*] different passwords entered\n");
                continue;
            }
            else
            {
                strncpy(output, buf, MAX_MASTER_PW_LEN + 1);
                return;
            }
        }
        strncpy(output, buf, MAX_MASTER_PW_LEN + 1);
        return;
    }
}

/** Clean up function for freeing memory and closing files.
 * @param pwList pointer to pwList struct
 */
static void cleanup(pw_list_t *pwList)
{
    sodium_memzero(pwList->entries, pwList->size * ENTRIES_BLOCK_SIZE); // securely erase memory
    free(pwList->entries);
    if (pwList->file != NULL)
    {
        fclose(pwList->file);
        pwList->file = NULL;
    }
    printf("\033[32m"); // set text color to green
    printf("[*] Cleanup done\n");
    printf("\033[0m"); // reset text color to default
    running = 0;
}

static void int_handler(int sig)
{
    printf("\033[31m"); // set text color to red
    printf("\n[!] Aborted by user\n");
    printf("\033[0m"); // reset text color to default
    running = 0;
    exit(0);
}

void clear_inp_buffer()
{
    int c;
    while ((c = getchar()) != '\n' && c != EOF)
        ;
}