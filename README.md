# pisound-firmware
This repository contains firmware for pisound boards.

## Prerequisities

Make sure you have the following prerequisities installed and up-to-date:

1. pisound software, http://wiki.blokas.io/index.php/pisound#Linux_Driver.
 * Running ```pisound-btn --version``` should output its version.
2. customized avrdude
 * Running ```avrdude --version``` should display ```6.1-svn-20130917-blokas``` near the bottom.

<b>Additionally pisound must not be selected as the default card for the flashing to succeed!</b> Otherwise, snd_soc_pisound kernel module will not be able to unload, as it will still be in use!

## Instructions
Once you have pisound software and avrdude installed, just clone the repository and run flash.sh:

```bash
git clone https://github.com/BlokasLabs/pisound-firmware
cd pisound-firmware
./flash.sh
```

You should see the output similar to the one below, indicating success:

```
avrdude: verifying ...
avrdude: 1386 bytes of flash verified

avrdude: safemode: Fuses OK (E:FF, H:D7, L:EF)

avrdude done.  Thank you.
```

## Any Questions?
Head on over to our community forums at http://community.blokas.io/ for support.

## Done!
Thank you!
