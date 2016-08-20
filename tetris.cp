#line 1 "C:/PIC/tetris/tetris.c"
#line 1 "c:/pic/tetris/ks0108.h"
#line 75 "c:/pic/tetris/ks0108.h"
void ks0108_enable(void);
void ks0108_init(void);
void ks0108_fill(unsigned char);
void ks0108_locate(unsigned char, unsigned char);
void ks0108_command(unsigned char, unsigned char);
unsigned char ks0108_data_read();
void ks0108_data_write(unsigned char);

void ks0108_pset(unsigned short, unsigned short, unsigned short);
void ks0108_rect(unsigned short, unsigned short, unsigned short, unsigned short, unsigned short);
void ks0108_char(unsigned short, unsigned short, unsigned char, unsigned char);
void ks0108_char_portrait(unsigned short, unsigned short, unsigned char, unsigned char);
void ks0108_title(unsigned short, unsigned short);
#line 12 "C:/PIC/tetris/tetris.c"
unsigned int playfield[20];
unsigned char curr_shape_matrix[5];

char rotation;
unsigned short key_flags;
unsigned short block_pos_x;
unsigned short block_pos_y;
unsigned int score;
unsigned int round_delay;
unsigned short level;
unsigned int removed_rows;


const char shapes_matrix[4][5][7] = {
 {
 { 0b00100, 0b00000, 0b00000, 0b00000, 0b00000, 0b00000, 0b00000 },
 { 0b00100, 0b00100, 0b00100, 0b00110, 0b00100, 0b00100, 0b00100 },
 { 0b00100, 0b00100, 0b00100, 0b00110, 0b00110, 0b01100, 0b01100 },
 { 0b00100, 0b01100, 0b00110, 0b00000, 0b00010, 0b00100, 0b01000 },
 { 0b00000, 0b00000, 0b00000, 0b00000, 0b00000, 0b00000, 0b00000 },
 },
 {
 { 0b00000, 0b00000, 0b00000, 0b00000, 0b00000, 0b00000, 0b00000 },
 { 0b00000, 0b00000, 0b00010, 0b00110, 0b00110, 0b00000, 0b00000 },
 { 0b11110, 0b01110, 0b01110, 0b00110, 0b01100, 0b01110, 0b01100 },
 { 0b00000, 0b00010, 0b00000, 0b00000, 0b00000, 0b00100, 0b00110 },
 { 0b00000, 0b00000, 0b00000, 0b00000, 0b00000, 0b00000, 0b00000 },
 },
 {
 { 0b00000, 0b00000, 0b00000, 0b00000, 0b00000, 0b00000, 0b00000 },
 { 0b00100, 0b00110, 0b01100, 0b00110, 0b01000, 0b00100, 0b00010 },
 { 0b00100, 0b00100, 0b00100, 0b00110, 0b01100, 0b00110, 0b00110 },
 { 0b00100, 0b00100, 0b00100, 0b00000, 0b00100, 0b00100, 0b00100 },
 { 0b00100, 0b00000, 0b00000, 0b00000, 0b00000, 0b00000, 0b00000 },
 },
 {
 { 0b00000, 0b00000, 0b00000, 0b00000, 0b00000, 0b00000, 0b00000 },
 { 0b00000, 0b01000, 0b00000, 0b00110, 0b00000, 0b00100, 0b01100 },
 { 0b11110, 0b01110, 0b01110, 0b00110, 0b00110, 0b01110, 0b00110 },
 { 0b00000, 0b00000, 0b01000, 0b00000, 0b01100, 0b00000, 0b00000 },
 { 0b00000, 0b00000, 0b00000, 0b00000, 0b00000, 0b00000, 0b00000 },
 }

};


void interrupt();
void mukke_start();
void mukke_stop();


void itoa(char *target, unsigned int value, char i, unsigned int base)
{
 const char digits[] = "01234567689abcdef";

 do {
 i--;
 target[i] = digits[value % base];
 value /= base;
 } while (value && i);
}

void strcpy(char *target, char *source, char length) {
 int i;
 for (i=0;i<length;i++)
 target[i] = source[i];
 return;
}

void draw_quad(unsigned short x, unsigned short y, unsigned short c, unsigned short addsingle)
{
 int i,j, screen_x, screen_y;
 unsigned char display_data;
 unsigned char box_data;
#line 96 "C:/PIC/tetris/tetris.c"
 x = ((x+1)*4);
 y = ((y+1)*4)-2;
 y += addsingle;


 screen_x = y;
 screen_y = 60-x;

 ks0108_locate(screen_x, screen_y);
 for (i=0; i<4; i++) {

 if (screen_x+i==64)
 ks0108_locate(screen_x+i,screen_y);


 ks0108_data_read();
 display_data = ks0108_data_read();

 if (i==1||i==2)
 box_data =0b1001;
 else
 box_data = 0b1111;

 if (c) {
 display_data &= ~(0b1111 << ( screen_y % 8 ));
 display_data |= (box_data << ( screen_y % 8 ));
 } else {
 display_data &= ~(0b1111 << ( screen_y % 8 ));
 }

 ks0108_data_write(display_data);
 }






}


void destroy_row(unsigned short row)
{ int y;
 int x;
 int i;
#line 166 "C:/PIC/tetris/tetris.c"
 y = (row + 3) * 4;
 x = 5;
 for (i=0; i<14; i++) {
 if ((playfield[row] & (1 << i) ) ) {

 draw_quad(i,row,0,0);
 Delay_ms(50);




 }

 x += 4;

 }

}

void lower_rows(unsigned short start, unsigned short end)
{
 unsigned char i,j,k;
 for (k=1;k<5;k++) {
 for (i=start;i<end;i++) {
 for (j=0; j<14; j++) {
 if (playfield[i] & (1<<j)) {
 draw_quad(j, i, 1, k);
 } else {
 draw_quad(j, i, 0, k);
 }
 }
 }

 }
}


void draw_shape(unsigned short c, unsigned short x, unsigned short y)
{

 char i,j;

 for (i=0; i<5; i++) {
 for (j=0; j<5; j++) {
 if (curr_shape_matrix[i] & 1 << j)
 draw_quad(x + (j-2), y + (i-2), c, 0);
 }
 }
}

void build_shape_matrix(unsigned char *matrix, unsigned char type, unsigned char rotation)
{
 unsigned char i;
 for (i=0;i<5;i++)
 matrix[i] = shapes_matrix[rotation][i][type];

}



char check_and_update_position(unsigned short x, unsigned short y, unsigned char type, unsigned char rot)
{
 char drawflag;
 char i,j;

 unsigned char tmp_matrix[5];

 build_shape_matrix(tmp_matrix, type, rot);

 for (i=0; i<5; i++) {

 for (j=0; j<5; j++) {
#line 248 "C:/PIC/tetris/tetris.c"
 if (tmp_matrix[i] & (1 << j) ) {




 if ( ((unsigned short)x + (j - 2)) < 0 )
 return 0;


 if ( ((unsigned short)x + (j - 2)) > 13 )
 return 0;


 if ( ((unsigned short)y + (i - 2)) > 19 )
 return 0;


 if ( playfield[y + (i-2) ] & (1 << x + (j-2) ) )
 return 0;


 }

 }
 }






 for (i=0; i<5;i++)
 curr_shape_matrix[i] = tmp_matrix[i];

 block_pos_x = x;
 block_pos_y = y;
 rotation = rot;





 return 1;

}

void show_highscore(void)
{

 unsigned int addr;
 unsigned char i,j;
 unsigned char x,y;

 unsigned int hiscore;

 unsigned char namechar;
 unsigned char scorestr[5];

 ks0108_fill(0);

 y=0;
 addr =0;

 for(i=0; i<8; i++) {
 x=0;

 ks0108_char(x,y,i+17,0);
 x+=6;
 ks0108_char(x,y,14,0);
 x+=12;


 for (j=0;j<14;j++) {
 namechar = EEPROM_Read(addr++);
 if (namechar > 0x7f)
 continue;
 ks0108_char(x,y,namechar-32,0);
 x+=6;
 }
 Delay_ms(20);

 hiscore = EEPROM_Read(addr++);
 hiscore |= EEPROM_Read(addr++) << 8;

 strcpy(scorestr,"     ",5);
 itoa(scorestr, hiscore, 5, 10);

 x=99;
 for (j=0;j<5;j++) {
 ks0108_char(x,y,scorestr[j]-32,0);
 x+=6;
 }

 y+=8;

 }

 while(PORTC & 0xf0);
 while(!(PORTC & 0xf0));

}

unsigned char check_highscore(void)
{
 unsigned char hiscore_record[16];
 unsigned char player_name[10];

 unsigned char i, j, k, x, addr;
 unsigned int hiscore;

 const unsigned char *msg1 = "Congratulations!   ";
 const unsigned char *msg2 = "You are placed     ";
 const unsigned char *msg3 = "Enter name:        ";
 const unsigned char suffix[4][2] = { { 's', 't' }, { 'n', 'd' }, { 'r', 'd' }, { 't', 'h' } };


 addr = 0;
 for (i=0; i<8; i++) {
 Delay_ms(20);
 for (j=0; j<16; j++) {
 hiscore_record[addr % 16] = EEPROM_Read(addr);
 addr++;
 }
 Delay_ms(20);
 hiscore = hiscore_record[14];
 hiscore |= hiscore_record[15] << 8;
 if (score > hiscore) {

 addr = 0x80;
 Delay_ms(20);
 for (k=0;k<10;k++) {
 player_name[k] = EEPROM_Read(addr++);
 }
 Delay_ms(20);

 ks0108_fill(0);
 x = 0;
 for (j=0; j<16; j++) {
 ks0108_char(x,0,msg1[j]-32,0);
 ks0108_char(x,8,msg2[j]-32,0);
 ks0108_char(x,16,msg3[j]-32,0);
 x+=6;
 }
 ks0108_char(95,8,i+17,0);
 j = (i > 3) ? 3 : i;
 ks0108_char(101,8,suffix[j][0]-32,0);
 ks0108_char(107,8,suffix[j][1]-32,0);

 addr = 0;
 j = 1;
 x = 1;
 while (PORTC & 0xf0);
 while (1) {

 if (PORTC || j) {
 if (PORTC &  128 ) {
 if (player_name[addr] == 0)
 player_name[addr] = 58;
 else
 player_name[addr]--;
 }

 if (PORTC &  64 ) {
 player_name[addr] = (player_name[addr] + 1) % 59;
 }

 if (PORTC &  32 ) {
 addr = (addr + 1) % 10;
 }

 if (PORTC &  16 )
 break;


 x = 0;
 for (j=0; j<10; j++) {
 if (player_name[j] > 58)
 player_name[j] = 0;
 if (j == addr)
 ks0108_char(x,32,player_name[j],1);
 else
 ks0108_char(x,32,player_name[j],0);
 x+=6;
 }
 j = 0;

 while (PORTC & 0xf0) {
 if (k>=20) {
 if ( !(PORTC &  32 ) && (player_name[addr] == 0) )
 Delay_ms(500);
 else
 Delay_ms(50);
 break;
 } else {
 k++;
 Delay_ms(50);
 }
 }
 } else {
 k=0;
 }
 }

 j=7;
 do {
 j--;
 addr = j<<4;
 for (k=0;k<16;k++) {
 hiscore_record[k] = EEPROM_Read(addr + k);
 }
 Delay_ms(20);
 addr += 16;
 for (k=0;k<16;k++) {
 EEPROM_Write(addr + k, hiscore_record[k]);
 }
 Delay_ms(20);
 } while (j>i);

 hiscore_record[14] = score & 255;
 hiscore_record[15] = score >> 8;

 addr = i<<4;
 for (j=0; j<16; j++) {
 if (j<10)
 hiscore_record[j] = player_name[j] + 32;
 EEPROM_Write(addr++, hiscore_record[j]);
 }
 Delay_ms(20);
 addr = 0x80;
 for(k=0;k<10;k++) {
 EEPROM_Write(addr++, player_name[k]);
 }
 Delay_ms(20);

 return 1;
 }
 }
 return 0;
}

void init_gamescreen(void)
{
 unsigned char i, y;
 const char *tmp = "Next :";

 ks0108_fill(0);


 ks0108_rect(1,3, 82, 58,1);


 y = 56;
 for (i=0; i<6; i++) {
 ks0108_char_portrait(90, y, tmp[i]-32,0);
 y -= 6;
 }





}

void update_scoreboard(void) {

 char tmp0[10];
 char tmp1[10];
 char tmp2[10];
 unsigned short y,i;

 strcpy(tmp0, "Row:      ", 10);
 strcpy(tmp1, "Lev:      ", 10);
 strcpy(tmp2, "Scr:      ", 10);

 itoa(&(tmp0[5]), removed_rows, 5, 10);
 itoa(&(tmp1[5]), level, 5, 10);
 itoa(&(tmp2[5]), score, 5, 10);

 y = 56;
 for (i=0; i<10; i++) {
 ks0108_char_portrait(104, y, tmp0[i]-32,0);
 ks0108_char_portrait(112, y, tmp1[i]-32,0);
 ks0108_char_portrait(120, y, tmp2[i]-32,0);
 y -= 6;
 }

}

void game_over()
{
 const char tmp[2][4] = { {'G','A','M','E' }, {'O','V','E','R'} };

 unsigned short i;
 int x = 11;
 for (i=0; i<4; i++) {
 ks0108_char(x, 24, tmp[0][i]-32,0);
 ks0108_char(x, 32, tmp[1][i]-32,0);
 x += 6;
 }

 while (PORTC & 0xf0);
 while (!(PORTC & 0xf0));

}


void main() {
 unsigned int i,j,tmp;
 unsigned short random_seed;
 char round_finished ;

 unsigned short round_removed_rows;
 char block_type_current;
 char block_type_next;


 const char *menu1 = "RC7: New Game  ";
 const char *menu2 = "RC6: Highscores";
 unsigned char menuleft = 0;

mostevilrestart:



 block_type_next = random_seed;
 key_flags=0;

 score = 0;
 level = 1;
 removed_rows = 0;
 round_delay = 1000;



 TRISC = 0xF0;



 ks0108_init();


 while (menuleft == 0) {
 ks0108_fill(0);



 ks0108_title(128, 6);

 for(i=0; i<15; i++) {
 ks0108_char(i*6,48, menu1[i]-32,0);
 ks0108_char(i*6,56, menu2[i]-32,0);
 }

 while (PORTC & 0xf0);

 while (1) {

 if (PORTC & 0xf0) {
 block_type_next = (block_type_next + 1) % 7;
 }

 if (PORTC &  128 ) {
 menuleft=1;
 break;
 }

 if (PORTC &  64 ) {
 show_highscore();
 break;
 }

 }

 }

 menuleft = 0;

 while (PORTC & 0xf0) {
 random_seed = (random_seed + 1) % 7;
 }



 init_gamescreen();


 for (i=0; i<20; i++)
 playfield[i] = 0;

 update_scoreboard();

 mukke_start();

 while(1) {

 rotation=0;
 block_pos_y=2;
 block_pos_x=6;
 round_finished = 0;

 block_type_current = block_type_next;
 block_type_next = random_seed;

 build_shape_matrix(curr_shape_matrix, block_type_current, 0);
 draw_shape(0,13,23);
 build_shape_matrix(curr_shape_matrix, block_type_next, 0);
 draw_shape(1,13,23);






 if ( ! check_and_update_position(block_pos_x, block_pos_y, block_type_current, rotation) ) {
 i=20;
 do {
 i--;
 destroy_row(i);
 } while (i > 0);

 game_over();
 mukke_stop();

 if ( check_highscore() ) {
 show_highscore();
 }

 goto mostevilrestart
 }

 while (! round_finished) {
 if (block_pos_y > 0) {
 draw_shape(0, block_pos_x, block_pos_y);
 }
 draw_shape(1, block_pos_x, block_pos_y);

 for (i=0; i<(round_delay); i++) {

 if ( (PORTC &  32 ) && (! (key_flags &  32 )) ) {
 key_flags |=  32 ;
 draw_shape(0, block_pos_x, block_pos_y);
 check_and_update_position(block_pos_x, block_pos_y, block_type_current, (rotation + 1) % 4);
 draw_shape(1, block_pos_x, block_pos_y);
 }

 if ( (PORTC &  128 ) && (! (key_flags &  128 )) ) {
 key_flags |=  128 ;
 draw_shape(0, block_pos_x, block_pos_y);
 check_and_update_position(block_pos_x - 1, block_pos_y, block_type_current, rotation);
 draw_shape(1, block_pos_x, block_pos_y);
 }

 if ( (PORTC &  64 ) && (! (key_flags &  64 )) ) {
 key_flags |=  64 ;
 draw_shape(0, block_pos_x, block_pos_y);
 check_and_update_position(block_pos_x + 1, block_pos_y, block_type_current, rotation);
 draw_shape(1, block_pos_x, block_pos_y);
 }


 if ( PORTC &  16  ) {
 random_seed = (random_seed + block_pos_y ) % 7;
 if (i >= 100)
 continue;
 } else {
 if (PORTC & 0xf0) {
 random_seed = i % 7;
 } else {
 random_seed = (random_seed + block_pos_y ) % 7;
 }
 }

 key_flags &= PORTC &0xf0;

 Delay_ms(1);
 }


 draw_shape(0, block_pos_x, block_pos_y);
 if ( ! check_and_update_position(block_pos_x, block_pos_y + 1, block_type_current, rotation) ) {
 draw_shape(1, block_pos_x, block_pos_y);
 round_finished = 1;
 for (i=0; i < 5; i++) {
 tmp = (unsigned int)curr_shape_matrix[i] << block_pos_x;
 playfield[i + (block_pos_y-2)] |= ( tmp >> 2 );
 }


 i=20;
 round_removed_rows = 0;
 do {
 i--;
 if (playfield[i] >= 16383) {
 destroy_row(i);
 lower_rows(0,i);
 for (j=i; j>0; j--) {
 playfield[j] = playfield[j-1];
 }
 i++;
 removed_rows++;
 round_removed_rows++;
 score += (20 * level) * round_removed_rows;
 if (level < 10) {
 if ((removed_rows % 10) == 0) {
 level++;
 round_delay -= 90;
 }
 }
 }

 } while (i > 0);

 if (round_removed_rows > 0) {
 update_scoreboard();
 }

 } else {
 draw_shape(1, block_pos_x, block_pos_y);
 }


 }

 }
}
