#include "ks0108.h"
#include "font5x7.h"
#include "bitmaps.h"

unsigned short ks0108_x;
unsigned short ks0108_y;
unsigned short ks0108_page;


// invoke action on display by enabling and disabling the EN line
void ks0108_enable(void)
{
     int i;
     
     PORT_CTL |= CTL_EN;
     // wait 1 cycle to let the ks0108 recognize the flag
     asm nop;
     asm nop;
     asm nop;
     asm nop;

     PORT_CTL &= ~CTL_EN;
     // wait 1 cycle letting the ks0108 being busy
     // polling busy flag is for wimps and slow :)
     asm nop;
     asm nop;
     asm nop;
     asm nop;
     
}

// initialize driver - turn on controllers, etc...
void ks0108_init(void)
{
     // initialize variables
     ks0108_x = 0;
     ks0108_y = 0;
     ks0108_page = 0;

     // data input by default
     REG_DATA = 0xff;

     // control output by default
     REG_CTL = 0x00;
     
     // reset all flags on control port except RST line
     PORT_CTL = CTL_RST;
     
     // turn on both controllers
     ks0108_command(CMD_ON, KS0108_CONTROLLER0);
     ks0108_command(CMD_ON, KS0108_CONTROLLER1);

     // enable display on both controllers
     ks0108_command(CMD_DISP_START, KS0108_CONTROLLER0);
     ks0108_command(CMD_DISP_START, KS0108_CONTROLLER1);

}

// fill (clear screen) with specific pattern - 0xff or 0x00 for complete fill
void ks0108_fill(unsigned char pattern)
{
     unsigned short i, j;
     for (i=0; i<8; i++) {
         ks0108_locate(0, i<<3);
         for (j=0; j<128; j++)
             ks0108_data_write(pattern);

     }
}

// locate position on display
void ks0108_locate(unsigned short x, unsigned short y)
{
     unsigned short controller;

     ks0108_x = x;
     ks0108_y = y;
     
     // page = y/8 - done fast by a bitshift, due to lack of multiply/division
     ks0108_page = (y >> 3);

     // select the controller dependent on x location
     if (x >= 64) {
        controller = KS0108_CONTROLLER1;
        x -= 64;
     } else {
        controller = KS0108_CONTROLLER0;
     }
     
     // select page dependent on y location on both controllers
     ks0108_command(CMD_SET_PAGE | ks0108_page, KS0108_CONTROLLER0);
     ks0108_command(CMD_SET_PAGE | ks0108_page, KS0108_CONTROLLER1);
     
     // set pointer in page dependent on x location
     ks0108_command(CMD_SET_ADD | x, controller);


}

// invoke command on display
void ks0108_command(unsigned char cmd, unsigned char controller)
{
     // reset D/I and R/W so that the display is ready for receiving a command
     PORT_CTL = CTL_RST;
     
     // select receipient controller
     if (controller == KS0108_CONTROLLER0) {
        PORT_CTL |= CTL_C0;
     } else {
        PORT_CTL |= CTL_C1;
     }
     
     // set data register for output and put command to data port
     REG_DATA = 0x00;
     PORT_DATA = cmd;
     
     // cycle enable flag
     ks0108_enable();
}

// set a dot on display at location x/y, color c
void ks0108_pset(unsigned short x, unsigned short y, unsigned short c)
{
     char display_data;
     
     ks0108_locate(x,y);

     // data is contained in the second read
     ks0108_data_read();
     display_data = ks0108_data_read();

     // set or reset the specific bit in page (shifted by the offset in the page)
     if (c)
        display_data |= 1 << (y % 8);
     else
        display_data &= ~(1 << (y % 8));
        
     // write data back to display
     ks0108_data_write(display_data);
}

// draw a rectangle - TO BE OPTIMIZED!!

void ks0108_rect(unsigned short x, unsigned short y, unsigned short width, unsigned short height, unsigned short c)
{

     unsigned short i,j;
     for (j=y; j<y+height;j++) {
     
       if ( (j==y) || (j==(y+(height-1))) ) {
         // draw top/bottom of box TODO: make use of the fact that the controller automatically increases X
         for (i=x; i<x+width;i++) {
             ks0108_pset(i, j, c);
         }
       } else {
         // draw sides
         ks0108_pset(x,j,c);
         ks0108_pset(x+(width-1),j,c);
       }
     }

}

/*
void ks0108_rect(unsigned short x, unsigned short y, unsigned short width, unsigned short height, unsigned short c)
{

     unsigned short i,j;
     char display_data;

     
     for (j=y; j<y+height;j++) {

       if ( (j==y) || (j==(y+(height-1))) ) {
         // draw top/bottom of box TODO: make use of the fact that the controller automatically increases X
         for (i=x; i<x+width;i++) {
//             ks0108_pset(i, j, c);
             

             ks0108_locate(i,j);

             // data is contained in the second read
             ks0108_data_read();
             display_data = ks0108_data_read();

             // set or reset the specific bit in page (shifted by the offset in the page)
             if (c)
                display_data |= 1 << (j % 8);
             else
                display_data &= ~(1 << (j % 8));

             // write data back to display
             ks0108_data_write(display_data);
             
         }
       } else {
         // draw sides
         //ks0108_pset(x,j,c);
         //ks0108_pset(x+(width-1),j,c);
       }
     }

}
*/

void ks0108_char(unsigned short x, unsigned short y, unsigned char c, unsigned char invert)
{

     unsigned char i,d;
     int j;
     
     j = c * 5;
     ks0108_locate(x,y);
     for (i=0;i<5;i++) {
         ks0108_data_read();
         d = ks0108_data_read();
         d = (font5x7[j] << (y % 8));
         if (invert)
            d = ~d;
         ks0108_data_write(d);
         j++;
     }
}

void ks0108_char_portrait(unsigned short x, unsigned short y, unsigned short c, unsigned char invert)
{
     unsigned char i,k,d,e,f;
     int j;

     j = (c * 5) + 4;
     for (i=0;i<5;i++) {
//         ks0108_data_read();
//         d = ks0108_data_read();
         //d = (font5x7[j] << (y % 8));
         d = (font5x7[j]);
         if (invert)
            d = ~d;

         ks0108_locate(x,y);
         for (k=0; k<7; k++) {
             ks0108_data_read();
             e = ks0108_data_read();
             f = ((d & (1<<k)) >> k) << (i + (y % 8));
             if (i == 0)
               e = f;
             else
               e |= f;
             ks0108_data_write(e);
         }


         if (y % 8) {
           ks0108_locate(x,y+8);
           for (k=0; k<7; k++) {
               ks0108_data_read();
               e = ks0108_data_read();
               e |=  (((d & (1<<k)) >> k) << i) >> (8 - (y % 8));
               ks0108_data_write(e);
           }
         }

         //ks0108_data_write(d);
         j--;
     }
}

void ks0108_title(unsigned short width, unsigned short hpages)
{

     int i,j,k;
     k=0;
     for (i=0; i<hpages; i++) {
         ks0108_locate(0,i<<3);
         for (j=0;j<width;j++) {
             if (j==64)
                ks0108_locate(j,i<<3);
             ks0108_data_write(title_bitmap[k++]);
         }
     }
}

// read data from display memory
unsigned char ks0108_data_read()
{
         unsigned char display_data;
         unsigned short i;

         // setup port for read
         PORT_DATA = 0x00;
         REG_DATA = 0xff;

         // reset control port
         PORT_CTL = CTL_RST;
         
         // select controller dependent un x location
         if (ks0108_x >= 64) {
            PORT_CTL |= CTL_C1;
         } else {
            PORT_CTL |= CTL_C0;
         }

         // set D/I to retrieve data, set R/W to 1 (W) since data is being received
         PORT_CTL |= CTL_DI;
         PORT_CTL |= CTL_RW;

         // pull up EN line
         PORT_CTL |= CTL_EN;
         asm nop;
         asm nop;
         asm nop;
         asm nop;

         // get the data
         display_data = PORT_DATA;
         
         // down the EN line again
         PORT_CTL &= ~CTL_EN;
         asm nop;
         asm nop;
         asm nop;
         asm nop;
         
         // relocate to last position, eliminating the auto-increment-x feature
         ks0108_locate(ks0108_x, ks0108_y);
         
         // return the read data
         return display_data;

}


// write data to display memory
void ks0108_data_write(unsigned char d)
{

     // reset control port
     PORT_CTL = CTL_RST;
     
     // select controller
     if (ks0108_x >= 64) {
        PORT_CTL |= CTL_C1;
     } else {
        PORT_CTL |= CTL_C0;
     }
     
     // flag D/I to transfer data
     PORT_CTL |= CTL_DI;

     // set data register for output and push the data
     REG_DATA = 0x00;
     PORT_DATA = d;

     // cycle EN flag
     ks0108_enable();
     
     // increase x, since it got automatically increased by the controller
     ks0108_x++;

}
