Armbian_5.38_Cubieboard2_Ubuntu_xenial_default_3.4.113_desktop
funguje root 1234
jak na LCD:
sudo bin2fex /boot/script.bin /home/pavelr/script.fex
sudo nano /home/pavelr/script.fex

upravit
https://haarer.github.io/lcd/cubieboard/2015/11/29/connect-lvds-lcd-panel-to-cubieboard2.html
https://linux-sunxi.org/Cubieboard/LVDS
zafungovalo nastaveni podle mysite ale 800x480 a Vertical dle linux-sunxi

sudo fex2bin /home/pavelr/script.fex /boot/script.bin
uplne vypnout

