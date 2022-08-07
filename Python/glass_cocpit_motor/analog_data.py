#import os
#os.chdir('C:\\Users\\prozp\\Dropbox\\Python\\pristroje_3')
import math

class Vstupy:
    def analog_hodnoty():
        pocet_analogu = 8
        analog_vstupy = [0,0,0,0,0,0,0,0]
#        try:
 #           from gpiozero import MCP3008, Button
  #          #print("Podařilo se připojit k MCP3008.....\nZačínám cist......")
   #         for i in (range(pocet_analogu)): 
    #            with MCP3008(channel=i) as reading:  
     #               analog_vstupy[i] = round((reading.value * 3.3), 2)
      #      for j in [5, 6]:
       #         button = Button(j)
        #        analog_vstupy.append(button.value)
         #   print(analog_vstupy)    
    #    try:
             import serial
             arduino = serial.Serial('/dev/ttyACM0', 9600, timeout=.1)
             time.sleep(1)
             data = arduino.readline()
             if data:
                    print(data.read())  #strip out the new lines for now
        # (better to do .read() in the long run for this reason
             
             
             
             
     #   except:       
   #         import random        
    #        #print("Nepodařilo se připojit k MCP3008......\nZačínám generovat náhodně......")
     #       for i in range(pocet_analogu):   
      #          analog_vstupy[i] = round((random.uniform(0,1)),2)
       #     for j in [5, 6, 12, 13, 16, 19, 20, 21]:
        #        analog_vstupy.append(random.choice([1, 0]))
            #print(analog_vstupy)
    #    return analog_vstupy       

if __name__ == "__main__":
    for a in range(100):
        Vstupy.analog_hodnoty()