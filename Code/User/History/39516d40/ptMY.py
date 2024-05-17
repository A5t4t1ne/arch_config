#!/usr/bin/python3

import json
import argparse
import enum
import os
import stat
import hashlib


# database dictionary structure:
# {
#    "/path/to/file/file1.txt" :
#    {
#        "type": "f",
#        "uid": 1234,
#        "gid": 1234,
#        "mode": 0o644,
#        "size": 1440000,
#        "hash": "0123456789ABCDEF"
#    },
#    "/path/to/dir1" :
#    {
#        "type": "d",
#        "uid": 1234,
#        "gid": 1234,
#        "mode": 0o755
#    },
#    ...
# }


Actions = ['count', 'add', 'hash', 'check', 'verify', 'update']


# --- Action 1: count ---

# print the number of files and directories in the specified path and/or database
def count(data, files, directories):
    # count files in database, skip if no database given
    if data != None:
        f=0
        d=0
        for entry in data:
            if data[entry]['type'] == 'f':
                f+=1
            elif data[entry]['type'] == 'd':
                d+=1
        print(f'database contains {f} files and {d} directories')
    # count files and dirs, skip if no files and no directories given (empty list = boolean False)
    if files or directories:
        # get the number of items in the list of files
        f=len(files)
        d=len(directories)
        print(f'path contains {f} files and {d} directories')
    # success
    return True


# --- Action 2: add ---

# add files and directories that are not in the database yet to the database
def add(data, files, directories):
    # handle list of files
    for fpath in files:
        # check whether file is already in the database
        if not fpath in data:
            # add the properties of the file to the database
            data[fpath] = filedata(fpath)
        # if a file path is already in the database, you should use check or update
        else:
            print(f'file already in database: {fpath}')
            print('use check or update action')
            return False
    # handle list of directories
    for dpath in directories:
        # check whether directory is already in the database
        if not dpath in data:
            # add the properties of the directory to the database
            data[dpath] = dirdata(dpath)
        # if a directory path is already in the database, you should use check or update
        else:
            print(f'directory already in database: {dpath}')
            print('use check or update action')
            return False
    print('add: success')
    # output file count in database
    count(data, None, None)
    return True

# return a dictionary with information about a directory
def dirdata(dpath):
    assert os.path.isdir(dpath)

    # initialize new empty dictionary for the directory's properties.
    dir_properties = {}

    # type for directory is 'd'
    dir_properties['type'] = 'd'

    # TODO: add further information to the dictionary
    dstat = os.stat(dpath)
    dir_properties['uid'] = dstat.st_uid
    dir_properties['gid'] = dstat.st_gid
    dir_properties['mode'] = dstat.st_mode

    # finally, return the dictionary
    return dir_properties

# return a dictionary with information about a file
def filedata(fpath):
    assert os.path.isfile(fpath)

    # initialize new empty dictionary for the file's properties.
    file_properties = {}

    # type for file is 'f'
    file_properties['type'] = 'f'

    # TODO: add further information to the dictionary
    fstat = os.stat(fpath)
    file_properties['uid'] = fstat.st_uid
    file_properties['gid'] = fstat.st_gid
    file_properties['mode'] = fstat.st_mode
    file_properties['size'] = fstat.st_size
    file_properties['hash'] = sha256file(fpath)

    # finally, return the dictionary
    return file_properties


# --- Action 3: hash ---

# add checksum for files (not directories) to database entries
# this function is not called "hash" because python has a built-in function with that name
def cksum(data, files, directories):
    # HINT: use the sha256file() function for getting the hash
    for f in files:
        if f in data:
            data[f]['hash'] = sha256file(f)
        else:
            print(f'file {f} not in database')
            return False


# --- Action 4: update ---

# update database entries that have changed
def update(data, files, directories):
    for f in files:
        fstat = os.stat(f)

        if f in data:
            # check if file has changed
            if data[f]['hash'] != sha256file(f):
                data[f]['hash'] = sha256file(f)
            if data[f]['uid'] != fstat.st_uid:
                data[f]['uid'] = fstat.st_uid
            if data[f]['gid'] != fstat.st_gid:
                data[f]['gid'] = fstat.st_gid
            if data[f]['mode'] != fstat.st_mode:
                data[f]['mode'] = fstat.st_mode
            if data[f]['size'] != fstat.st_size:
                data[f]['size'] = fstat.st_size
        else:
            print(f'file {f} not in database')
            return False
        
    for d in directories:
        dstat = os.stat(d)

        if d in data:
            if data[d]['uid'] != dstat.st_uid:
                data[d]['uid'] = dstat.st_uid
            if data[d]['gid'] != dstat.st_gid:
                data[d]['gid'] = dstat.st_gid
            if data[d]['mode'] != dstat.st_mode:
                data[d]['mode'] = dstat.st_mode
        else:
            print(f'directory {d} not in database')
            return False


# --- Action 5: verify ---

# check files in path against database entries
# check correct hash for files that have a hash in the database
def verify(data, files, directories):
    for path, attr in data.items():
        if path in files and path not in directories:
            print(f'[WARNING] missing: {path}')
        
        stat = os.stat(path)
        if stat.st_uid != attr['uid']:
            print(f'[WARNING] mismatch: {path}')

    missmatched_attr = dict()
    for f in files:
        if f in data:
            cur_hash = sha256file(f)
            if data[f]['uid'] != stat.st_uid:
                missmatched_attr['uid'] = stat.st_uid
            if data[f]['gid'] != stat.st_gid:
                missmatched_attr['gid'] = stat.st_gid
            if data[f]['mode'] != stat.st_mode:
                missmatched_attr['mode'] = stat.st_mode
            if data[f]['size'] != stat.st_size:
                missmatched_attr['size'] = stat.st_size
            if data[f]['hash'] != cur_hash:
                print(f'[WARNING] hash changed: {f}')
                print(f"  - old hash: " + data[f]['hash'])
                print(f"  - new hash: " + cur_hash)
            
            missmatch(f, data, missmatched_attr)
            missmatched_attr.clear()
        else:
            print(f'[WARNING] new file: {f}')

    for d in directories:
        if d not in data:
            print(f'[WARNING] new directory: {d}')
            
    return True


def missmatch(path: str, data, missmatched_attr: dict):
    if len(missmatched_attr) > 0:
        print(f'[WARNING] missmatch: {path}')
        for key, value in missmatched_attr.items():
            print(f"  - old: {data[path][key]}")
            print(f"  - new: {value}")

    data['last_it_file_err'] = dict()


# --- helper functions ---

# return the SHA256 hash of a file
def sha256file(fpath):
    # only works with files, not directories
    assert os.path.isfile(fpath)
    # read file in 16k blocks
    BUFSIZE = 16384
    # initialize sha256 hash object
    s256 = hashlib.sha256()
    # open file for reading and read first block
    f = open(fpath, 'rb')
    buffer = f.read(BUFSIZE)
    # read block and update hash
    while len(buffer) > 0:
        s256.update(buffer)
        buffer = f.read(BUFSIZE)
    f.close()
    # return string containing hexdigit representation of hash
    return s256.hexdigest()


# --- database functions ---

# save database from dictionary to file
def save_db(dbfile, dict):
    jsondata = json.dumps(dict, indent=4)
    f = open(dbfile,"w")
    f.write(jsondata)
    f.close()

# read database from file into dictionary
def read_db(dbfile):
    f = open(dbfile,"r")
    dict = json.loads(f.read())
    f.close()
    return dict


# --- main function ---

def main():
    # parse commandline arguments
    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--database')
    parser.add_argument('-p', '--path')
    parser.add_argument('action', choices=Actions)
    args = parser.parse_args()

    # --- database directory setup ---

    # database is needed for add,hash,check/verify,update
    if args.action in ['add','hash','check','verify','update'] and args.database == None:
        print(f'action {args.action} needs database argument')
        return 1

    # load existing contents from database file
    data = None
    # if database is given but not a file, it's created later when writing back
    if args.database != None and os.path.isfile(args.database):
        data = read_db(args.database)

    # initialize empty dictionary if database is given
    if data == None and args.database != None:
        data = {}


    # --- file and directories list setup ---

    path = None
    file_list = []
    directory_list = []

    if args.path == None:
        # path is needed for add,hash,check/verify,update
        if args.action in ['add','hash','check','verify','update']:
            print(f'action {args.action} needs path argument')
            return 1
    else:
        # verify path is a file or directory
        if not os.path.isdir(args.path) and not os.path.isfile(args.path):
            raise argparse.ArgumentTypeError(f'{args.path} is not a valid file or directory')
        # normalize path
        path = os.path.abspath(args.path)

        # single file => add to file list
        if os.path.isfile(path):
            file_list.append(path)
        else:
            # add root directory
            directory_list.append(path)
            # get list of subdirectories and files
            for root,dirs,files in os.walk(path):
                for item in dirs:
                    # get full path
                    dpath = os.path.join(root,item)
                    directory_list.append(dpath)
                for item in files:
                    # get full path
                    fpath = os.path.join(root,item)
                    # could be link or special device instead of file, we ignore those
                    if os.path.isfile(fpath):
                        file_list.append(fpath)

    # --- run desired action ---

    r = False
    if args.action == 'count':
        r = count(data, file_list, directory_list)
    elif args.action == 'add':
        r = add(data, file_list, directory_list)
    elif args.action == 'hash':
        r = cksum(data, file_list, directory_list)
    elif args.action == 'verify' or args.action == 'check':
        r = verify(data, file_list, directory_list)
    elif args.action == 'update':
        r = update(data, file_list, directory_list)

    if not r:
        print(f'there was a problem running action {args.action}')
        return 1

    # save (possibly changed) database again
    if data != None and args.database != None:
        save_db(args.database, data)
    
    return 0

if __name__ == "__main__":
    main()
