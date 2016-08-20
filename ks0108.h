#ifndef __KS0108_H
#define __KS0108_H

/*

some facts on ks0108 display

- Memory is organized in 8 pages, each representing a horizontal 1/8 portion
  of the display, sized 8x128 bit. pages are selected with the CMD_SET_PAGE
  command + the page number in the LSBs
- 8 bits (1 byte) of the page represent a vertical line. the byte in the page
  is being selected by the CMD_SET_ADD command + the X position in LSBs
- The controller automatically increases the X location when reading/writing
  from /to a display memory page.
- there are 2 separate controllers, each responsible for a 64x64 portion of
  the display, selected by the specific control lines of the control port.
  
                X/SET_ADD value >
                00000000000...444...
                0123456789A...012...
               +-----------...---...
             / |00000000000...000...
             | |11111111111...111...
             | |22222222222...222...
page 0       | |33333333333...333...
bit numbers  | |44444444444...444...
             | |55555555555...555...
             | |66666666666...666...
             \ |77777777777...777...
             / |00000000000...000...
             | |11111111111...111...
             | |22222222222...222...
page 1       | |33333333333...333...
bit numbers  | |44444444444...444...
             | |55555555555...555...
             | |66666666666...666...
             \ |77777777777...777...
               .....................
               .....................
               .....................
               \___________...\__...
                Controller 0   Controller 1



*/

// Display Registers and ports - change these if the display is connected to
// other ports
#define PORT_CTL        PORTB
#define PORT_DATA       PORTD
#define REG_CTL         TRISB
#define REG_DATA        TRISD

// Control Port flags - change these if control port is wired differently to display
#define CTL_DI          0b00000100      // command (0) or data (1) transfer
#define CTL_RW          0b00001000      // read (0) or write (1) access
#define CTL_EN          0b00010000      // Enable Flag
#define CTL_C0          0b00000010      // Select Controller 0
#define CTL_C1          0b00000001      // Select Controller 1
#define CTL_RST         0b00100000      // should be logical 1, 0 resets the display

// Commands
#define CMD_ON          0x3f
#define CMD_OFF         0x3e
#define CMD_SET_ADD     0x40
#define CMD_SET_PAGE    0xB8
#define CMD_DISP_START  0xC0

// Controllers
#define KS0108_CONTROLLER0  0x00
#define KS0108_CONTROLLER1  0x01

// Prototypes
void ks0108_enable(void);                             // invoke command
void ks0108_init(void);                               // Initialize ks0108 controller
void ks0108_fill(unsigned char);                      // fill screen
void ks0108_locate(unsigned char, unsigned char);     // locate pos on display
void ks0108_command(unsigned char, unsigned char);    // run command
unsigned char ks0108_data_read();                     // read data from display memory
void ks0108_data_write(unsigned char);                // write data to display memory

void ks0108_pset(unsigned short, unsigned short, unsigned short);
void ks0108_rect(unsigned short, unsigned short, unsigned short, unsigned short, unsigned short);
void ks0108_char(unsigned short, unsigned short, unsigned char, unsigned char);
void ks0108_char_portrait(unsigned short, unsigned short, unsigned char, unsigned char);
void ks0108_title(unsigned short, unsigned short);

#endif
