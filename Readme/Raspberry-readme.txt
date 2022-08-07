1) rozlišení, tlačítka, CAN
	terminál-------------------------------
	sudo nano /boot/config.txt
	HDMI------------------------------------
	disable_overscan=1
	hdmi_group=2
	hdmi_mode=87
	hdmi_cvt=1024 600 60 1 0 0 0
	hdmi_drive=1
	#hdmi_force_hotplug=1
	na konec display_lcd_rotate=1
	CAN------------------------------------------
	dtoverlay=mcp2515-can0,oscillator=12000000,interrupt=25,spimaxfrequency=2000000
	tlačítka na konec------------------------------
	bez can: "1-12v-červený, 2-gpio-21-zelená, 3-gpio-20-žlutý, 4-gnd-černý"
	s can: "1-12v-červený, 2-gpio-21-zelená, 3-CANH-hnědá, 4-CANL-zlutobílá, 5-gpio-20-žlutý, 6-gnd-černý
	napětí na 20 - nech zaplé, když spadne, mlžeš vypnout -> pro relé
	dtoverlay=gpio-poweroff,gpiopin=20,active_low="y"
	vypínání, zmáčknu začne se vypínat tl.21
	dtoverlay=gpio-shutdown,gpio_pin=21
	vypnout--------------------------------------
	ctrl + o,  enter, ctrl + x

2) instalovat
	sudo apt-get update && upgrade 
	sudo apt-get install arduino python3 python3-pip python3-pyqt5 python3-pyqt5.qtquick qtcreator
	sudo pip3 install pyqt5 python-can



6) auto start xcsoar
	sudo nano /etc/rc.local
	před exit su - pi -c xcsoar



8) 1-12v-červený, 2-gpio-21-zelená, 3-gpio-20-žlutý, 4-gnd-černý
	na kabelu:  modrá bílá hnědá černá
s can: "1-12v-červený, 2-gpio-21-zelená, 3-CANH-hnědá, 4-CANL-zlutobílá, 5-gpio-20-žlutý, 6-gnd-černý
kabel :    modrá   zelená   hnědá   bílá   zlutá   šedá


4 konektro z vypínání

+12  canh hnědá   canl  bílá   gnd šedá
