#import os
#os.chdir('C:\\Users\\prozp\\Dropbox\\Python\\pristroje_3')
import math

class Vstupy:
    def analog_hodnoty():
        pocet_analogu = 8
        analog_vstupy = [0,0,0,0,0,0,0,0]
        try:
            from gpiozero import MCP3008
            print("Podařilo se připojit k MCP3008.....\nZačínám cist......")
            for i in (range(pocet_analogu)): 
                with MCP3008(channel=i) as reading:  
                    analog_vstupy[i] = round(reading.value * 3.3, 2)
            print(analog_vstupy)    
                        
        except:       
            import random        
            print("Nepodařilo se připojit k MCP3008......\nZačínám generovat náhodně......")
            for i in range(pocet_analogu):   
                analog_vstupy[i] = round(random.uniform(0,1) * 3.3,2)
            print(analog_vstupy)    
        return analog_vstupy       

if __name__ == "__main__":
    Vstupy.analog_hodnoty()