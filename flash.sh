#!/bin/sh

try_unload() {
	sudo modprobe -r snd_soc_pisound > /dev/null 2>&1
	while lsmod | grep -q pisound; do
		read -p "Unselect pisound as the default device in the volume widget, press any key to retry or Ctrl+C to exit." _
		sudo modprobe -r snd_soc_pisound > /dev/null 2>&1
	done
}

set +e
sudo systemctl stop pisound-btn
sudo systemctl stop pisound-ctl
sudo systemctl stop alsa-state || true
pulseaudio -k > /dev/null 2>&1 || true
try_unload
# Pull SS pin low.
sudo sh -c "echo 8 > /sys/class/gpio/export"
sudo sh -c "echo out > /sys/class/gpio/gpio8/direction"
sudo sh -c "echo 0 > /sys/class/gpio/gpio8/value"
sudo avrdude -c linuxspi -p t841 -b 150000 -P /dev/spidev0.1 -U flash:w:pisound.hex
# Restore SS pin.
sudo sh -c "echo 8 > /sys/class/gpio/unexport"
sudo modprobe snd_soc_pisound
sleep 1
sudo systemctl start alsa-state || true
sudo systemctl start pisound-btn
sudo systemctl start pisound-ctl
