Termočlánky	ok
Multiplixer	ok
Napětí		??
teplota		??
tlak		??
BMP280		??
EEPROM 1	??
EEPROM 2	??
CAN		??



ESP32-------------------------------------------------------
http://www.useasydocs.com/theory/ntc.htm

EN musí být pořád na 10k 3V3 - přes uzemnění dám na nulu = reset
io0 musím na gnd = bootloader
a při nahrávání uzemnit - asi nemusí??? stačil jen boot režim na gnd


doit esp32 -> na přímo usb
io0 na gnd a zmáčknout reset nebo zapnout napájení

(esp32 dev module, 10k mezi EN a +3,3v když čeká tak to uzemnit)
uzemnit en a když čeka odzemnit, 10k mezi + a en
This message normally means that the ESP32 can't talk to its attached flash chip (the flash chip may be in the module). Check the GPIO pins 6,7,8,9,10 & 11 (which are shared with the flash chip) are not connected to anything external or shorted together, etc.





asi poslední verze - normálně EN přes odpor na 3V3 celou dobu uzemněn a když hledá tak sundat gnd
- další pokus a funguje
