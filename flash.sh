#!/bin/sh

pulseaudio -k
sudo modprobe -r snd_soc_pisound
sudo avrdude -c linuxspi -p t841 -b 150000 -P /dev/spidev0.1 -U flash:w:pisound.hex
sudo modprobe snd_soc_pisound
sh -c "pisound-btn >> ~/.pisound.log" &

