# pictris
A tetris clone for PIC16F877

Written in Mikroelektronika MikroC for PIC. Not the most common compiler I 
think. Nowadays I would to it in ASM for such a small micro and most likely 
the code is far from  being optimized I think... But hey, these were my first 
steps into the world of microcontrollers.. And MikroC did a nice job here ;-)

Most stuff is written by hand (especially the KS0108 display driver). 
Proprietary libraries (coming with MikroC) were used for the delay as well as
the EEPROM stuff afair. These should be possible to port easily to other
environment which makes porting the code not to hard I think.

Some information:
tetris.c: main gameplay routines
mukke.c/.h: the music stuff (music is done using PWM with specific note 
frequency and volume decay by modulating the duty of the PWM
ks0108.c/.h: low and higher level functions for driving the KS0108 type display
the .h file contains some documentation about the displays memory organization
font5x7.h: the bitmap font used within the game
bitmaps.h: the title screen bitmap
