převodník na hovno, lze obejít:
https://chiptron.cz/news.php?readmore=1271
-----Funkčnost----------------------------
Termočlánky	ok
Multiplixer	ok
Napětí		OK max nějaká kapacita
teplota		OK funguje 
https://create.arduino.cc/projecthub/Marcazzan_M/how-easy-is-it-to-use-a-thermistor-e39321
https://navody.dratek.cz/arduino-projekty/mereni-teploty-s-termistorem.html
https://e-manuel.cz/kapitoly/polovodice/praktika/termistorovy-teplomer-s-arduinem/

tlak	  	čekám na rovnici
problém s 5V, ale něco naměřím, chce to vyzkoušet v práci, esp32 + lcd + redukce npt na g

hladina   OK, stejné jako teplota - odporové, pouze rovnice křivky - až vyzkouším podle litrů
HALL      STM8 ??
https://makersportal.com/blog/2018/10/3/arduino-tachometer-using-a-hall-effect-sensor-to-measure-rotations-from-a-fan

BMP280		OK ale teplota +- asi 3°C??
EEPROM 1	adresa OK, takže asi budu umět zapisovat
EEPROM 2	adresa taky OK
CAN		    ??
WIFI Updater  NOK - tak změna, při použití wifi přijdeš o mnoho pinů, pro mě nepoužitelné
pozor, program má moc, musíš dát dev module a without issfts nebo tak nějak
https://iotespresso.com/how-to-set-partitions-in-esp32/


-----Layout svorkovnice-----------------------
tlak olej
tlak paliva
všechny 3 vedle sebe -> 
nebo dám 2x 3v3, 2x gnd, a 4 tlaky

teplota olej
teplota vody
měl by stačit jeden, gnd je motor
nebo dám 4x teplota + 2x gnd + 2x 3v3

hladina - poťák - 2x S

termočlánky výfuku -2x  zaberou 4/8


otáčky motoru -> asi i2c ale externí halluv sensor -> +, -, S, S
https://www.instructables.com/Arduino-Software-debouncing-in-interrupt-function/

-------Výsledek layoutu----------------
tlaky - 8pinu
4xS 2xGND 2x3V3

teploty   - 6pinu
4xS + 2xGND + 2x3V3

termo - 4piny
2x+, 2x-

napájení + HALL + hladina
12v, gnd, 2x H, +, -, HL, HL -> 8pin

lepší----------------------------------
4 tlaky  - 8pinu
4xS + 2x GND + 2x3V3

termo - 4piny + teplota (1 pin, gnd je k motoru)  - 8pin
2x+, 2x- + 4xS

napájení + HALL + hladina
12v, gnd, 2x H, 3V3, GND, HL, HL -> 8pin

konektory do U


---------programovani ESP32-------------------------------------------------------
http://www.useasydocs.com/theory/ntc.htm

EN musí být pořád na 10k 3V3 - přes uzemnění dám na nulu = reset
io0 musím na gnd = bootloader
a při nahrávání uzemnit - asi nemusí??? stačil jen boot režim na gnd

doit esp32 -> na přímo usb
io0 na gnd a zmáčknout reset nebo zapnout napájení

(esp32 dev module, 10k mezi EN a +3,3v když čeká tak to uzemnit)
uzemnit en a když čeka odzemnit, 10k mezi + a en
This message normally means that the ESP32 can't talk to its attached flash chip (the flash chip may be in the module). Check the GPIO pins 6,7,8,9,10 & 11 (which are shared with the flash chip) are not connected to anything external or shorted together, etc.

=====================
asi poslední verze - normálně EN přes 10k odpor na 3V3 celou dobu uzemněn a když hledá tak sundat gnd
- další pokus a funguje, dělám to tak pořád
======================
