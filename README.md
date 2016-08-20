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
