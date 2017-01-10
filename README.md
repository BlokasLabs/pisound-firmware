# pisound-firmware
This repository contains firmware for pisound boards.

## Prerequisities
Make sure you have installed the pisound software as described at http://wiki.blokas.io/index.php/pisound#Linux_Driver.

Also, make sure that you have our customized 'avrdude' installed, https://github.com/BlokasLabs/avrdude. Running:

```
avrdude --version
```

in a terminal should display '6.1-svn-20130917-blokas' near the bottom.

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
