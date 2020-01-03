#!/bin/sh

try_unload() {
	sudo modprobe -r snd_soc_pisound > /dev/null 2>&1
	while lsmod | grep -q pisound; do
		read -p "Unselect pisound as the default device in the volume widget, press any key to retry or Ctrl+C to exit." _
		sudo modprobe -r snd_soc_pisound > /dev/null 2>&1
	done
}

set +e
sudo systemctl stop pisound-btn 2> /dev/null
sudo systemctl stop pisound-ctl 2> /dev/null
sudo systemctl stop alsa-state 2> /dev/null || true
aconnect -x
pulseaudio -k > /dev/null 2>&1 || true
try_unload
# Pull SS pin low.
if [ ! -e /sys/class/gpio/gpio8 ]; then
	sudo sh -c "echo 8 > /sys/class/gpio/export"
fi
sudo sh -c "echo out > /sys/class/gpio/gpio8/direction"
sudo sh -c "echo 0 > /sys/class/gpio/gpio8/value"
sudo avrdude -c linuxspi -p t841 -b 150000 -P /dev/spidev0.1 -U flash:w:pisound.hex
# Restore SS pin.
sudo sh -c "echo 1 > /sys/class/gpio/gpio8/value"
sudo modprobe snd_soc_pisound
sleep 1
sudo systemctl start alsa-state || true
sudo systemctl start pisound-btn 2> /dev/null
sudo systemctl start pisound-ctl 2> /dev/null
echo
echo "Please reboot your system now (sudo reboot). Thank you!"
