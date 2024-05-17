//
// Created by dave on 14.03.23.
//

#ifndef PW_MANAGER_FILES_H
#define PW_MANAGER_FILES_H

/**********************************************************************************************
 * Includes
 **********************************************************************************************/
#include <stdio.h>
#include <stdbool.h>

/**********************************************************************************************
 * Constants
 **********************************************************************************************/
#define MAX_KEY_LEN 30                              //!< Maximum entry key length
#define MAX_VAL_LEN 50                              //!< Maximum password length
#define MAX_DB_NAME_LEN 100                         //!< Maximum file name length
#define MAX_LINE_LEN 82                             //!< Key + Value + ':' + '\n'
#define SALT_BYTES 8                                //!< Number of bytes used for salt
#define ENTRIES_BLOCK_SIZE 256                      //!< Size of memory block used for storing the decrypted data
#define FILE_EXTENSION (const unsigned char *)"bbw" //!< Name of file extension for password files

/**********************************************************************************************
 * Types
 **********************************************************************************************/
typedef struct pw_list
{
    unsigned char *filename;  //!< Name of password file
    FILE *file;               //!< File pointer to the original file
    unsigned char *master_pw; //!< Master password from this file
    unsigned int entry_count; //!< Number of entries in pw file including master
    unsigned char *entries;   //!< All unencrypted entries
    unsigned int size;        //!< Size of entries in ENTRIES_BLOCK_SIZE blocks
} pw_list_t;

/**********************************************************************************************
 * Function Headers
 **********************************************************************************************/
int get_entry_count(const pw_list_t *pwList);
long get_entry_value(const pw_list_t *pwList, unsigned char *str, const unsigned char *key);
bool set_entry(pw_list_t *pw_list, const unsigned char *key, const unsigned char *val);
void save_master_pw(pw_list_t *pwList, char *new_pw);
bool check_master_pw(const pw_list_t *pwList, const char *master_pw);
int load_pw_file_content(pw_list_t *pwList);
int save_to_file(pw_list_t *pwList);
void list_all_entries(const pw_list_t *pwList);
bool remove_entry(pw_list_t *pwList, const unsigned char *key);
long search_entry(const pw_list_t *pwList, const unsigned char *key);

#endif // PW_MANAGER_FILES_H
