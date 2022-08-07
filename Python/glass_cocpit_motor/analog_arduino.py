#import os
#os.chdir('C:\\Users\\prozp\\Dropbox\\Python\\pristroje_3')
import math
import serial
import time
arduino = serial.Serial(port='/dev/ttyACM0', baudrate=9600)
time.sleep(1)

class Vstupy:
    def analog_hodnoty():
        analog_vstupy = [0,0,0,0,0,0,0,0]
        arduino.write(1)
        pocet_analogu = int(arduino.readline(8).strip().decode('utf-8'))
        for i in (range(pocet_analogu)):
            analog_vstupy[i] = int(arduino.readline(8).strip().decode('utf-8'))
        return analog_vstupy

if __name__ == "__main__":
    while True:
        print(Vstupy.analog_hodnoty())
