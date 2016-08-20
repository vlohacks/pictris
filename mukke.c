
volatile unsigned char beatcount;
volatile unsigned char current_note_delay;
volatile unsigned char song_position;


code const char notes[][2] = {

{ 0xee, 0x2c},
{ 0xe1, 0x3c},
{ 0xd4, 0x2c},
{ 0xc8, 0x2c},
{ 0xbd, 0x3c},
{ 0xb2, 0x2c},
{ 0xa8, 0x2c},
{ 0x9e, 0x3c},
{ 0x96, 0x1c},
{ 0x8d, 0x0c},
{ 0x85, 0x0c},
{ 0x7e, 0x1c},


{ 0x76, 0x3c},
{ 0x70, 0x2c},
{ 0x69, 0x1c},
{ 0x63, 0x1c},
{ 0x5e, 0x2c},
{ 0x58, 0x3c},
{ 0x53, 0x1c},
{ 0x4f, 0x0c},
{ 0x4a, 0x3c},
{ 0x46, 0x2c},
{ 0x42, 0x2c},
{ 0x3e, 0x3c}


};


#define SONG_LENGTH 78
code const char song[][2] = {
      {9, 4}, {4, 2}, {5, 2},
      {7, 4}, {5, 2}, {4, 2},
      {2, 4}, {2, 2}, {5, 2},
      {9, 4}, {7, 2}, {5, 2},

      {4, 6}, {5, 2},
      {7, 4}, {9, 2}, {5, 2},
      {5, 4}, {2, 4},
      {2, 6}, {2, 2},

      {7, 4}, {2, 2}, {7, 2},     //24
      {14,4}, {12,2}, {10,2},
      {9, 4}, {5, 4},
      {9, 4}, {10,4},              //31

      {16,2}, {14,2}, {16,2}, {14,2},
      {16,2}, {14,2}, {17,2}, {19,2},
      {17,2}, {16,2}, {16,4},
      {14,6}, {4, 2},                //44

      {4, 4}, {4, 2}, {5, 2},
      {7, 4}, {7, 2}, {9, 2},
      {5, 4}, {2, 4},
      {2, 8},                        //53

      {9, 4}, {9 ,4},
      {5, 4}, {9 ,4},
      {7, 4}, {9 ,4},
      {4, 4}, {9 ,4},

      {2, 4}, {5, 4},
      {9, 4}, {13,4},
      {4, 8},

      {10,4}, {14,4},
      {7, 4}, {17,4},
      {9, 4}, {10,4},
      {5, 4}, {4, 4},

      {9, 4}, {7, 4},
      {5, 4}, {4, 4},
      {2, 16}

};


void interrupt() {

     if (INTCON.TMR0IF) {
        INTCON.TMR0IF = 0;

        if (current_note_delay == 0) {
           current_note_delay = song[song_position][1];
           PR2 = notes[song[song_position][0]][0];
           CCPR1L  = 0x28;
           CCP1CON = notes[song[song_position][0]][1];
           if (song_position == SONG_LENGTH)
              song_position = 0;
           else
              song_position++;
        }

        if (CCPR1L && (beatcount % 16) == 0) {
                CCPR1L-=1;
        }

        if (beatcount == 128) {
           beatcount = 0;
           current_note_delay--;
        }  else {
           beatcount = (beatcount + 1);
        }
     }

}

void mukke_start()
{
     INTCON = 0;
     INTCON.GIE = 1;
     INTCON.TMR0IE = 1;
     
     song_position = 0;
     current_note_delay = 0;
     beatcount = 0;
     
     OPTION_REG  = 0b11000011;
     T2CON   = 0b00001111;
     

}

void mukke_stop()
{
     INTCON.TMR0IE = 0;
     T2CON = 0;
}

