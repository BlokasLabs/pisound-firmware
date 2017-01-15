#!/bin/sh

try_unload() {
	sudo modprobe -r snd_soc_pisound > /dev/null 2>&1
	while lsmod | grep -q pisound; do
		read -p "Unselect pisound as the default device in the volume widget, press any key to retry or Ctrl+C to exit." _
		sudo modprobe -r snd_soc_pisound > /dev/null 2>&1
	done
}

set +e
pulseaudio -k > /dev/null 2>&1 || true
try_unload
sudo avrdude -c linuxspi -p t841 -b 150000 -P /dev/spidev0.1 -U flash:w:pisound.hex
sudo modprobe snd_soc_pisound
sleep 1
sh -c "pisound-btn >> ~/.pisound.log" &
