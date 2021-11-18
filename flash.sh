#!/bin/sh

try_unload() {
	sudo modprobe -r snd_soc_pisound > /dev/null 2>&1
	while lsmod | grep -q pisound; do
		read -p "Unselect pisound as the default device in the volume widget, press any key to retry or Ctrl+C to exit." _
		sudo modprobe -r snd_soc_pisound > /dev/null 2>&1
	done
}

set +e
sudo systemctl stop jack 2> /dev/null || true
sudo systemctl stop pisound-btn 2> /dev/null
sudo systemctl stop pisound-ctl 2> /dev/null
sudo systemctl stop alsa-state 2> /dev/null || true
aconnect -x
pulseaudio -k > /dev/null 2>&1 || true
try_unload
sudo dtoverlay pisound_spidev0_on.dtbo
sudo avrdude -c linuxspi -p t841 -b 150000 -P /dev/spidev0.0 -U flash:w:pisound.hex
sudo dtoverlay -r
sudo modprobe -r snd_soc_pisound
sudo modprobe snd_soc_pisound
sleep 1
sudo systemctl start alsa-state || true
sudo systemctl start pisound-btn 2> /dev/null
sudo systemctl start pisound-ctl 2> /dev/null
sudo systemctl start jack 2> /dev/null || true
echo
echo "Please reboot your system now (sudo reboot). Thank you!"
