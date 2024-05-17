1 #!/usr/bin/python
2
3 import RPi.GPIO as GPIO
4 import serial
5 import time
6
7 ser = serial.Serial("/dev/ttyUSB3",115200)
8 ser.flushInput()
9
10 phone_number = '**********' # ********** change it
11 text_message = 'Viele Gruesse!!'
12 power_key = 6
13 rec_buff = ''
14
15 def send_at(command,back,timeout):
16 rec_buff = ''
17 ser.write((command+'\r\n').encode())
18 time.sleep(timeout)
19 if ser.inWaiting():
20 time.sleep(0.01 )
21 rec_buff = ser.read(ser.inWaiting())
22 if back not in rec_buff.decode():
23 print(command + ' ERROR')
24 print(command + ' back:\t' + rec_buff.decode())
25 return 0
26 else:
27 print(rec_buff.decode())
28 return 1
29
30 def SendShortMessage(phone_number,text_message):
31
32 print("Setting SMS mode...")
33 send_at("AT+CMGF=1","OK",1)
34 print("Sending Short Message")
35 answer = send_at("AT+CMGS=\""+phone_number+"\"",">",2)
36 if 1 == answer:
37 ser.write(text_message.encode())
38 ser.write(b'\x1A')
39 answer = send_at('','OK',20)
40 if 1 == answer:
41 print('send successfully')
42 else:
43 print('error')
44 else:
45 print('error%d'%answer)