#import os
#os.chdir('C:\\Users\\prozp\\Dropbox\\Python\\pristroje_3')
import math
import serial
import time
#ls -l /dev  zjistit serial port
arduino = serial.Serial(port='/dev/ttyS0', baudrate=9600)
#pockam na pripojeni
time.sleep(1)


class Vstupy:
    def analog_hodnoty():
        arduino.reset_input_buffer()
        analog_vstupy = list(range(16))
        arduino.read_until(b"a$", 100)
        arduino.readline()
        pocet_analogu = int(arduino.readline().strip().decode('utf-8'))
        for i in (range(pocet_analogu)):
                analog_vstupy[i] = arduino.readline().strip().decode('utf-8')
        print(arduino.in_waiting)
              #else:
         #   print("problem")
        return analog_vstupy

if __name__ == "__main__":
    while True:
       print(Vstupy.analog_hodnoty())
