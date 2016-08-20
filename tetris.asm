
_itoa:

;tetris.c,63 :: 		void itoa(char *target, unsigned int value, char i, unsigned int base)
;tetris.c,67 :: 		do {
L_itoa0:
;tetris.c,68 :: 		i--;
	DECF       FARG_itoa_i+0, 1
;tetris.c,69 :: 		target[i] = digits[value % base];
	MOVF       FARG_itoa_i+0, 0
	ADDWF      FARG_itoa_target+0, 0
	MOVWF      FLOC__itoa+0
	MOVF       FARG_itoa_base+0, 0
	MOVWF      R4+0
	MOVF       FARG_itoa_base+1, 0
	MOVWF      R4+1
	MOVF       FARG_itoa_value+0, 0
	MOVWF      R0+0
	MOVF       FARG_itoa_value+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      itoa_digits_L0+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(itoa_digits_L0+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       FLOC__itoa+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;tetris.c,70 :: 		value /= base;
	MOVF       FARG_itoa_base+0, 0
	MOVWF      R4+0
	MOVF       FARG_itoa_base+1, 0
	MOVWF      R4+1
	MOVF       FARG_itoa_value+0, 0
	MOVWF      R0+0
	MOVF       FARG_itoa_value+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_itoa_value+0
	MOVF       R0+1, 0
	MOVWF      FARG_itoa_value+1
;tetris.c,71 :: 		} while (value && i);
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L__itoa216
	MOVF       FARG_itoa_i+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__itoa216
	GOTO       L_itoa0
L__itoa216:
;tetris.c,72 :: 		}
	RETURN
; end of _itoa

_strcpy:

;tetris.c,74 :: 		void strcpy(char *target, char *source, char length) {
;tetris.c,76 :: 		for (i=0;i<length;i++)
	CLRF       R2+0
	CLRF       R2+1
L_strcpy5:
	MOVLW      128
	XORWF      R2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__strcpy223
	MOVF       FARG_strcpy_length+0, 0
	SUBWF      R2+0, 0
L__strcpy223:
	BTFSC      STATUS+0, 0
	GOTO       L_strcpy6
;tetris.c,77 :: 		target[i] = source[i];
	MOVF       R2+0, 0
	ADDWF      FARG_strcpy_target+0, 0
	MOVWF      R1+0
	MOVF       R2+0, 0
	ADDWF      FARG_strcpy_source+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;tetris.c,76 :: 		for (i=0;i<length;i++)
	INCF       R2+0, 1
	BTFSC      STATUS+0, 2
	INCF       R2+1, 1
;tetris.c,77 :: 		target[i] = source[i];
	GOTO       L_strcpy5
L_strcpy6:
;tetris.c,78 :: 		return;
;tetris.c,79 :: 		}
	RETURN
; end of _strcpy

_draw_quad:

;tetris.c,81 :: 		void draw_quad(unsigned short x, unsigned short y, unsigned short c, unsigned short addsingle)
;tetris.c,96 :: 		x = ((x+1)*4);
	INCF       FARG_draw_quad_x+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      R3+0
	RLF        R3+0, 1
	BCF        R3+0, 0
	RLF        R3+0, 1
	BCF        R3+0, 0
	MOVF       R3+0, 0
	MOVWF      FARG_draw_quad_x+0
;tetris.c,97 :: 		y = ((y+1)*4)-2;
	INCF       FARG_draw_quad_y+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      2
	SUBWF      R0+0, 1
	MOVF       R0+0, 0
	MOVWF      FARG_draw_quad_y+0
;tetris.c,98 :: 		y += addsingle;
	MOVF       FARG_draw_quad_addsingle+0, 0
	ADDWF      R0+0, 1
	MOVF       R0+0, 0
	MOVWF      FARG_draw_quad_y+0
;tetris.c,101 :: 		screen_x = y;
	MOVF       R0+0, 0
	MOVWF      draw_quad_screen_x_L0+0
	CLRF       draw_quad_screen_x_L0+1
;tetris.c,102 :: 		screen_y = 60-x;
	MOVF       R3+0, 0
	SUBLW      60
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      draw_quad_screen_y_L0+0
	MOVF       R0+1, 0
	MOVWF      draw_quad_screen_y_L0+1
;tetris.c,104 :: 		ks0108_locate(screen_x, screen_y);
	MOVF       draw_quad_screen_x_L0+0, 0
	MOVWF      FARG_ks0108_locate+0
	MOVF       R0+0, 0
	MOVWF      FARG_ks0108_locate+0
	CALL       _ks0108_locate+0
;tetris.c,105 :: 		for (i=0; i<4; i++) {
	CLRF       draw_quad_i_L0+0
	CLRF       draw_quad_i_L0+1
L_draw_quad8:
	MOVLW      128
	XORWF      draw_quad_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_quad224
	MOVLW      4
	SUBWF      draw_quad_i_L0+0, 0
L__draw_quad224:
	BTFSC      STATUS+0, 0
	GOTO       L_draw_quad9
;tetris.c,107 :: 		if (screen_x+i==64)
	MOVF       draw_quad_i_L0+0, 0
	ADDWF      draw_quad_screen_x_L0+0, 0
	MOVWF      R1+0
	MOVF       draw_quad_screen_x_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      draw_quad_i_L0+1, 0
	MOVWF      R1+1
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_quad225
	MOVLW      64
	XORWF      R1+0, 0
L__draw_quad225:
	BTFSS      STATUS+0, 2
	GOTO       L_draw_quad11
;tetris.c,108 :: 		ks0108_locate(screen_x+i,screen_y);
	MOVF       draw_quad_i_L0+0, 0
	ADDWF      draw_quad_screen_x_L0+0, 0
	MOVWF      FARG_ks0108_locate+0
	MOVF       draw_quad_screen_y_L0+0, 0
	MOVWF      FARG_ks0108_locate+0
	CALL       _ks0108_locate+0
L_draw_quad11:
;tetris.c,111 :: 		ks0108_data_read();
	CALL       _ks0108_data_read+0
;tetris.c,112 :: 		display_data = ks0108_data_read();
	CALL       _ks0108_data_read+0
	MOVF       R0+0, 0
	MOVWF      draw_quad_display_data_L0+0
;tetris.c,114 :: 		if (i==1||i==2)
	MOVLW      0
	XORWF      draw_quad_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_quad226
	MOVLW      1
	XORWF      draw_quad_i_L0+0, 0
L__draw_quad226:
	BTFSC      STATUS+0, 2
	GOTO       L__draw_quad217
	MOVLW      0
	XORWF      draw_quad_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_quad227
	MOVLW      2
	XORWF      draw_quad_i_L0+0, 0
L__draw_quad227:
	BTFSC      STATUS+0, 2
	GOTO       L__draw_quad217
	GOTO       L_draw_quad14
L__draw_quad217:
;tetris.c,115 :: 		box_data =0b1001;
	MOVLW      9
	MOVWF      draw_quad_box_data_L0+0
	GOTO       L_draw_quad15
L_draw_quad14:
;tetris.c,117 :: 		box_data = 0b1111;
	MOVLW      15
	MOVWF      draw_quad_box_data_L0+0
L_draw_quad15:
;tetris.c,119 :: 		if (c) {
	MOVF       FARG_draw_quad_c+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_draw_quad16
;tetris.c,120 :: 		display_data &= ~(0b1111 << ( screen_y % 8 ));
	MOVLW      8
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       draw_quad_screen_y_L0+0, 0
	MOVWF      R0+0
	MOVF       draw_quad_screen_y_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      R3+0
	MOVLW      15
	MOVWF      R2+0
	MOVF       R3+0, 0
L__draw_quad228:
	BTFSC      STATUS+0, 2
	GOTO       L__draw_quad229
	RLF        R2+0, 1
	BCF        R2+0, 0
	ADDLW      255
	GOTO       L__draw_quad228
L__draw_quad229:
	COMF       R2+0, 1
	MOVF       R2+0, 0
	ANDWF      draw_quad_display_data_L0+0, 1
;tetris.c,121 :: 		display_data |= (box_data << ( screen_y % 8 ));
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVF       draw_quad_box_data_L0+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__draw_quad230:
	BTFSC      STATUS+0, 2
	GOTO       L__draw_quad231
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__draw_quad230
L__draw_quad231:
	MOVF       R0+0, 0
	IORWF      draw_quad_display_data_L0+0, 1
;tetris.c,122 :: 		} else {
	GOTO       L_draw_quad17
L_draw_quad16:
;tetris.c,123 :: 		display_data &= ~(0b1111 << ( screen_y % 8 ));
	MOVLW      8
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       draw_quad_screen_y_L0+0, 0
	MOVWF      R0+0
	MOVF       draw_quad_screen_y_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      15
	MOVWF      R0+0
	MOVF       R1+0, 0
L__draw_quad232:
	BTFSC      STATUS+0, 2
	GOTO       L__draw_quad233
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__draw_quad232
L__draw_quad233:
	COMF       R0+0, 1
	MOVF       R0+0, 0
	ANDWF      draw_quad_display_data_L0+0, 1
;tetris.c,124 :: 		}
L_draw_quad17:
;tetris.c,126 :: 		ks0108_data_write(display_data);
	MOVF       draw_quad_display_data_L0+0, 0
	MOVWF      FARG_ks0108_data_write+0
	CALL       _ks0108_data_write+0
;tetris.c,105 :: 		for (i=0; i<4; i++) {
	INCF       draw_quad_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       draw_quad_i_L0+1, 1
;tetris.c,127 :: 		}
	GOTO       L_draw_quad8
L_draw_quad9:
;tetris.c,134 :: 		}
	RETURN
; end of _draw_quad

_destroy_row:

;tetris.c,137 :: 		void destroy_row(unsigned short row)
;tetris.c,168 :: 		for (i=0; i<14; i++) {
	CLRF       destroy_row_i_L0+0
	CLRF       destroy_row_i_L0+1
L_destroy_row18:
	MOVLW      128
	XORWF      destroy_row_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__destroy_row234
	MOVLW      14
	SUBWF      destroy_row_i_L0+0, 0
L__destroy_row234:
	BTFSC      STATUS+0, 0
	GOTO       L_destroy_row19
;tetris.c,169 :: 		if ((playfield[row] & (1 << i) ) ) {
	MOVF       FARG_destroy_row_row+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _playfield+0
	MOVWF      FSR
	MOVF       destroy_row_i_L0+0, 0
	MOVWF      R2+0
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__destroy_row235:
	BTFSC      STATUS+0, 2
	GOTO       L__destroy_row236
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__destroy_row235
L__destroy_row236:
	MOVF       INDF+0, 0
	ANDWF      R0+0, 1
	INCF       FSR, 1
	MOVF       INDF+0, 0
	ANDWF      R0+1, 1
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_destroy_row21
;tetris.c,171 :: 		draw_quad(i,row,0,0);
	MOVF       destroy_row_i_L0+0, 0
	MOVWF      FARG_draw_quad_x+0
	MOVF       FARG_destroy_row_row+0, 0
	MOVWF      FARG_draw_quad_y+0
	CLRF       FARG_draw_quad_c+0
	CLRF       FARG_draw_quad_addsingle+0
	CALL       _draw_quad+0
;tetris.c,172 :: 		Delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_destroy_row22:
	DECFSZ     R13+0, 1
	GOTO       L_destroy_row22
	DECFSZ     R12+0, 1
	GOTO       L_destroy_row22
	DECFSZ     R11+0, 1
	GOTO       L_destroy_row22
	NOP
	NOP
;tetris.c,177 :: 		}
L_destroy_row21:
;tetris.c,168 :: 		for (i=0; i<14; i++) {
	INCF       destroy_row_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       destroy_row_i_L0+1, 1
;tetris.c,181 :: 		}
	GOTO       L_destroy_row18
L_destroy_row19:
;tetris.c,183 :: 		}
	RETURN
; end of _destroy_row

_lower_rows:

;tetris.c,185 :: 		void lower_rows(unsigned short start, unsigned short end)
;tetris.c,188 :: 		for (k=1;k<5;k++) {
	MOVLW      1
	MOVWF      lower_rows_k_L0+0
L_lower_rows23:
	MOVLW      5
	SUBWF      lower_rows_k_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_lower_rows24
;tetris.c,189 :: 		for (i=start;i<end;i++) {
	MOVF       FARG_lower_rows_start+0, 0
	MOVWF      lower_rows_i_L0+0
L_lower_rows26:
	MOVF       FARG_lower_rows_end+0, 0
	SUBWF      lower_rows_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_lower_rows27
;tetris.c,190 :: 		for (j=0; j<14; j++) {
	CLRF       lower_rows_j_L0+0
L_lower_rows29:
	MOVLW      14
	SUBWF      lower_rows_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_lower_rows30
;tetris.c,191 :: 		if (playfield[i] & (1<<j)) {
	MOVF       lower_rows_i_L0+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _playfield+0
	MOVWF      FSR
	MOVF       lower_rows_j_L0+0, 0
	MOVWF      R2+0
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__lower_rows237:
	BTFSC      STATUS+0, 2
	GOTO       L__lower_rows238
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__lower_rows237
L__lower_rows238:
	MOVF       INDF+0, 0
	ANDWF      R0+0, 1
	INCF       FSR, 1
	MOVF       INDF+0, 0
	ANDWF      R0+1, 1
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_lower_rows32
;tetris.c,192 :: 		draw_quad(j, i, 1, k);
	MOVF       lower_rows_j_L0+0, 0
	MOVWF      FARG_draw_quad_x+0
	MOVF       lower_rows_i_L0+0, 0
	MOVWF      FARG_draw_quad_y+0
	MOVLW      1
	MOVWF      FARG_draw_quad_c+0
	MOVF       lower_rows_k_L0+0, 0
	MOVWF      FARG_draw_quad_addsingle+0
	CALL       _draw_quad+0
;tetris.c,193 :: 		} else {
	GOTO       L_lower_rows33
L_lower_rows32:
;tetris.c,194 :: 		draw_quad(j, i, 0, k);
	MOVF       lower_rows_j_L0+0, 0
	MOVWF      FARG_draw_quad_x+0
	MOVF       lower_rows_i_L0+0, 0
	MOVWF      FARG_draw_quad_y+0
	CLRF       FARG_draw_quad_c+0
	MOVF       lower_rows_k_L0+0, 0
	MOVWF      FARG_draw_quad_addsingle+0
	CALL       _draw_quad+0
;tetris.c,195 :: 		}
L_lower_rows33:
;tetris.c,190 :: 		for (j=0; j<14; j++) {
	INCF       lower_rows_j_L0+0, 1
;tetris.c,196 :: 		}
	GOTO       L_lower_rows29
L_lower_rows30:
;tetris.c,189 :: 		for (i=start;i<end;i++) {
	INCF       lower_rows_i_L0+0, 1
;tetris.c,197 :: 		}
	GOTO       L_lower_rows26
L_lower_rows27:
;tetris.c,188 :: 		for (k=1;k<5;k++) {
	INCF       lower_rows_k_L0+0, 1
;tetris.c,199 :: 		}
	GOTO       L_lower_rows23
L_lower_rows24:
;tetris.c,200 :: 		}
	RETURN
; end of _lower_rows

_draw_shape:

;tetris.c,203 :: 		void draw_shape(unsigned short c, unsigned short x, unsigned short y)
;tetris.c,208 :: 		for (i=0; i<5; i++) {
	CLRF       draw_shape_i_L0+0
L_draw_shape34:
	MOVLW      5
	SUBWF      draw_shape_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_draw_shape35
;tetris.c,209 :: 		for (j=0; j<5; j++) {
	CLRF       draw_shape_j_L0+0
L_draw_shape37:
	MOVLW      5
	SUBWF      draw_shape_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_draw_shape38
;tetris.c,210 :: 		if (curr_shape_matrix[i] & 1 << j)
	MOVF       draw_shape_i_L0+0, 0
	ADDLW      _curr_shape_matrix+0
	MOVWF      FSR
	MOVF       draw_shape_j_L0+0, 0
	MOVWF      R2+0
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__draw_shape239:
	BTFSC      STATUS+0, 2
	GOTO       L__draw_shape240
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__draw_shape239
L__draw_shape240:
	MOVF       INDF+0, 0
	ANDWF      R0+0, 1
	MOVLW      0
	ANDWF      R0+1, 1
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_draw_shape40
;tetris.c,211 :: 		draw_quad(x + (j-2), y + (i-2), c, 0);
	MOVLW      2
	SUBWF      draw_shape_j_L0+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	ADDWF      FARG_draw_shape_x+0, 0
	MOVWF      FARG_draw_quad_x+0
	MOVLW      2
	SUBWF      draw_shape_i_L0+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	ADDWF      FARG_draw_shape_y+0, 0
	MOVWF      FARG_draw_quad_y+0
	MOVF       FARG_draw_shape_c+0, 0
	MOVWF      FARG_draw_quad_c+0
	CLRF       FARG_draw_quad_addsingle+0
	CALL       _draw_quad+0
L_draw_shape40:
;tetris.c,209 :: 		for (j=0; j<5; j++) {
	INCF       draw_shape_j_L0+0, 1
;tetris.c,212 :: 		}
	GOTO       L_draw_shape37
L_draw_shape38:
;tetris.c,208 :: 		for (i=0; i<5; i++) {
	INCF       draw_shape_i_L0+0, 1
;tetris.c,213 :: 		}
	GOTO       L_draw_shape34
L_draw_shape35:
;tetris.c,214 :: 		}
	RETURN
; end of _draw_shape

_build_shape_matrix:

;tetris.c,216 :: 		void build_shape_matrix(unsigned char *matrix, unsigned char type, unsigned char rotation)
;tetris.c,219 :: 		for (i=0;i<5;i++)
	CLRF       build_shape_matrix_i_L0+0
L_build_shape_matrix41:
	MOVLW      5
	SUBWF      build_shape_matrix_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_build_shape_matrix42
;tetris.c,220 :: 		matrix[i] = shapes_matrix[rotation][i][type];
	MOVF       build_shape_matrix_i_L0+0, 0
	ADDWF      FARG_build_shape_matrix_matrix+0, 0
	MOVWF      FLOC__build_shape_matrix+2
	MOVF       FARG_build_shape_matrix_rotation+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVLW      35
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVLW      _shapes_matrix+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_shapes_matrix+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      FLOC__build_shape_matrix+0
	MOVF       R0+1, 0
	MOVWF      FLOC__build_shape_matrix+1
	MOVF       build_shape_matrix_i_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVLW      7
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       FLOC__build_shape_matrix+0, 0
	ADDWF      R0+0, 1
	MOVF       FLOC__build_shape_matrix+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       FARG_build_shape_matrix_type+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       FLOC__build_shape_matrix+2, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;tetris.c,219 :: 		for (i=0;i<5;i++)
	INCF       build_shape_matrix_i_L0+0, 1
;tetris.c,220 :: 		matrix[i] = shapes_matrix[rotation][i][type];
	GOTO       L_build_shape_matrix41
L_build_shape_matrix42:
;tetris.c,222 :: 		}
	RETURN
; end of _build_shape_matrix

_check_and_update_position:

;tetris.c,226 :: 		char check_and_update_position(unsigned short x, unsigned short y, unsigned char type, unsigned char rot)
;tetris.c,233 :: 		build_shape_matrix(tmp_matrix, type, rot);
	MOVLW      check_and_update_position_tmp_matrix_L0+0
	MOVWF      FARG_build_shape_matrix_matrix+0
	MOVF       FARG_check_and_update_position_type+0, 0
	MOVWF      FARG_build_shape_matrix_type+0
	MOVF       FARG_check_and_update_position_rot+0, 0
	MOVWF      FARG_build_shape_matrix_rotation+0
	CALL       _build_shape_matrix+0
;tetris.c,235 :: 		for (i=0; i<5; i++) {
	CLRF       check_and_update_position_i_L0+0
L_check_and_update_position44:
	MOVLW      5
	SUBWF      check_and_update_position_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_check_and_update_position45
;tetris.c,237 :: 		for (j=0; j<5; j++) {
	CLRF       check_and_update_position_j_L0+0
L_check_and_update_position47:
	MOVLW      5
	SUBWF      check_and_update_position_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_check_and_update_position48
;tetris.c,248 :: 		if (tmp_matrix[i] & (1 << j) ) {
	MOVF       check_and_update_position_i_L0+0, 0
	ADDLW      check_and_update_position_tmp_matrix_L0+0
	MOVWF      FSR
	MOVF       check_and_update_position_j_L0+0, 0
	MOVWF      R2+0
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__check_and_update_position241:
	BTFSC      STATUS+0, 2
	GOTO       L__check_and_update_position242
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__check_and_update_position241
L__check_and_update_position242:
	MOVF       INDF+0, 0
	ANDWF      R0+0, 1
	MOVLW      0
	ANDWF      R0+1, 1
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_check_and_update_position50
;tetris.c,253 :: 		if ( ((unsigned short)x + (j - 2)) < 0 )
	MOVLW      2
	SUBWF      check_and_update_position_j_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R0+0, 0
	ADDWF      FARG_check_and_update_position_x+0, 0
	MOVWF      R2+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      R2+1
	MOVLW      128
	XORWF      R2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__check_and_update_position243
	MOVLW      0
	SUBWF      R2+0, 0
L__check_and_update_position243:
	BTFSC      STATUS+0, 0
	GOTO       L_check_and_update_position51
;tetris.c,254 :: 		return 0;
	CLRF       R0+0
	RETURN
L_check_and_update_position51:
;tetris.c,257 :: 		if ( ((unsigned short)x + (j - 2)) > 13 )
	MOVLW      2
	SUBWF      check_and_update_position_j_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R0+0, 0
	ADDWF      FARG_check_and_update_position_x+0, 0
	MOVWF      R2+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      R2+1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R2+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__check_and_update_position244
	MOVF       R2+0, 0
	SUBLW      13
L__check_and_update_position244:
	BTFSC      STATUS+0, 0
	GOTO       L_check_and_update_position52
;tetris.c,258 :: 		return 0;
	CLRF       R0+0
	RETURN
L_check_and_update_position52:
;tetris.c,261 :: 		if ( ((unsigned short)y + (i - 2)) > 19 )
	MOVLW      2
	SUBWF      check_and_update_position_i_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R0+0, 0
	ADDWF      FARG_check_and_update_position_y+0, 0
	MOVWF      R2+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      R2+1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R2+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__check_and_update_position245
	MOVF       R2+0, 0
	SUBLW      19
L__check_and_update_position245:
	BTFSC      STATUS+0, 0
	GOTO       L_check_and_update_position53
;tetris.c,262 :: 		return 0;
	CLRF       R0+0
	RETURN
L_check_and_update_position53:
;tetris.c,265 :: 		if ( playfield[y + (i-2) ] & (1 << x + (j-2) ) )
	MOVLW      2
	SUBWF      check_and_update_position_i_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R0+0, 0
	ADDWF      FARG_check_and_update_position_y+0, 0
	MOVWF      R3+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      R3+1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _playfield+0
	MOVWF      FSR
	MOVLW      2
	SUBWF      check_and_update_position_j_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       FARG_check_and_update_position_x+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__check_and_update_position246:
	BTFSC      STATUS+0, 2
	GOTO       L__check_and_update_position247
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__check_and_update_position246
L__check_and_update_position247:
	MOVF       INDF+0, 0
	ANDWF      R0+0, 1
	INCF       FSR, 1
	MOVF       INDF+0, 0
	ANDWF      R0+1, 1
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_check_and_update_position54
;tetris.c,266 :: 		return 0;
	CLRF       R0+0
	RETURN
L_check_and_update_position54:
;tetris.c,269 :: 		}
L_check_and_update_position50:
;tetris.c,237 :: 		for (j=0; j<5; j++) {
	INCF       check_and_update_position_j_L0+0, 1
;tetris.c,271 :: 		}
	GOTO       L_check_and_update_position47
L_check_and_update_position48:
;tetris.c,235 :: 		for (i=0; i<5; i++) {
	INCF       check_and_update_position_i_L0+0, 1
;tetris.c,272 :: 		}
	GOTO       L_check_and_update_position44
L_check_and_update_position45:
;tetris.c,279 :: 		for (i=0; i<5;i++)
	CLRF       check_and_update_position_i_L0+0
L_check_and_update_position55:
	MOVLW      5
	SUBWF      check_and_update_position_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_check_and_update_position56
;tetris.c,280 :: 		curr_shape_matrix[i] = tmp_matrix[i];
	MOVF       check_and_update_position_i_L0+0, 0
	ADDLW      _curr_shape_matrix+0
	MOVWF      R1+0
	MOVF       check_and_update_position_i_L0+0, 0
	ADDLW      check_and_update_position_tmp_matrix_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;tetris.c,279 :: 		for (i=0; i<5;i++)
	INCF       check_and_update_position_i_L0+0, 1
;tetris.c,280 :: 		curr_shape_matrix[i] = tmp_matrix[i];
	GOTO       L_check_and_update_position55
L_check_and_update_position56:
;tetris.c,282 :: 		block_pos_x = x;
	MOVF       FARG_check_and_update_position_x+0, 0
	MOVWF      _block_pos_x+0
;tetris.c,283 :: 		block_pos_y = y;
	MOVF       FARG_check_and_update_position_y+0, 0
	MOVWF      _block_pos_y+0
;tetris.c,284 :: 		rotation = rot;
	MOVF       FARG_check_and_update_position_rot+0, 0
	MOVWF      _rotation+0
;tetris.c,290 :: 		return 1;
	MOVLW      1
	MOVWF      R0+0
;tetris.c,292 :: 		}
	RETURN
; end of _check_and_update_position

_show_highscore:

;tetris.c,294 :: 		void show_highscore(void)
;tetris.c,306 :: 		ks0108_fill(0);
	CLRF       FARG_ks0108_fill+0
	CALL       _ks0108_fill+0
;tetris.c,308 :: 		y=0;
	CLRF       show_highscore_y_L0+0
;tetris.c,309 :: 		addr =0;
	CLRF       show_highscore_addr_L0+0
	CLRF       show_highscore_addr_L0+1
;tetris.c,311 :: 		for(i=0; i<8; i++) {
	CLRF       show_highscore_i_L0+0
L_show_highscore58:
	MOVLW      8
	SUBWF      show_highscore_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_show_highscore59
;tetris.c,312 :: 		x=0;
	CLRF       show_highscore_x_L0+0
;tetris.c,314 :: 		ks0108_char(x,y,i+17,0);
	CLRF       FARG_ks0108_char+0
	MOVF       show_highscore_y_L0+0, 0
	MOVWF      FARG_ks0108_char+0
	MOVLW      17
	ADDWF      show_highscore_i_L0+0, 0
	MOVWF      FARG_ks0108_char+0
	CLRF       FARG_ks0108_char+0
	CALL       _ks0108_char+0
;tetris.c,315 :: 		x+=6;
	MOVLW      6
	ADDWF      show_highscore_x_L0+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      show_highscore_x_L0+0
;tetris.c,316 :: 		ks0108_char(x,y,14,0);
	MOVF       R0+0, 0
	MOVWF      FARG_ks0108_char+0
	MOVF       show_highscore_y_L0+0, 0
	MOVWF      FARG_ks0108_char+0
	MOVLW      14
	MOVWF      FARG_ks0108_char+0
	CLRF       FARG_ks0108_char+0
	CALL       _ks0108_char+0
;tetris.c,317 :: 		x+=12;
	MOVLW      12
	ADDWF      show_highscore_x_L0+0, 1
;tetris.c,320 :: 		for (j=0;j<14;j++) {
	CLRF       show_highscore_j_L0+0
L_show_highscore61:
	MOVLW      14
	SUBWF      show_highscore_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_show_highscore62
;tetris.c,321 :: 		namechar = EEPROM_Read(addr++);
	MOVF       show_highscore_addr_L0+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      show_highscore_namechar_L0+0
	INCF       show_highscore_addr_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       show_highscore_addr_L0+1, 1
;tetris.c,322 :: 		if (namechar > 0x7f)
	MOVF       R0+0, 0
	SUBLW      127
	BTFSC      STATUS+0, 0
	GOTO       L_show_highscore64
;tetris.c,323 :: 		continue;
	GOTO       L_show_highscore63
L_show_highscore64:
;tetris.c,324 :: 		ks0108_char(x,y,namechar-32,0);
	MOVF       show_highscore_x_L0+0, 0
	MOVWF      FARG_ks0108_char+0
	MOVF       show_highscore_y_L0+0, 0
	MOVWF      FARG_ks0108_char+0
	MOVLW      32
	SUBWF      show_highscore_namechar_L0+0, 0
	MOVWF      FARG_ks0108_char+0
	CLRF       FARG_ks0108_char+0
	CALL       _ks0108_char+0
;tetris.c,325 :: 		x+=6;
	MOVLW      6
	ADDWF      show_highscore_x_L0+0, 1
;tetris.c,326 :: 		}
L_show_highscore63:
;tetris.c,320 :: 		for (j=0;j<14;j++) {
	INCF       show_highscore_j_L0+0, 1
;tetris.c,326 :: 		}
	GOTO       L_show_highscore61
L_show_highscore62:
;tetris.c,327 :: 		Delay_ms(20);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_show_highscore65:
	DECFSZ     R13+0, 1
	GOTO       L_show_highscore65
	DECFSZ     R12+0, 1
	GOTO       L_show_highscore65
	NOP
	NOP
;tetris.c,329 :: 		hiscore = EEPROM_Read(addr++);
	MOVF       show_highscore_addr_L0+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      show_highscore_hiscore_L0+0
	CLRF       show_highscore_hiscore_L0+1
	INCF       show_highscore_addr_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       show_highscore_addr_L0+1, 1
;tetris.c,330 :: 		hiscore |= EEPROM_Read(addr++) << 8;
	MOVF       show_highscore_addr_L0+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      R1+1
	CLRF       R1+0
	MOVF       R1+0, 0
	IORWF      show_highscore_hiscore_L0+0, 1
	MOVF       R1+1, 0
	IORWF      show_highscore_hiscore_L0+1, 1
	INCF       show_highscore_addr_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       show_highscore_addr_L0+1, 1
;tetris.c,332 :: 		strcpy(scorestr,"     ",5);
	MOVLW      show_highscore_scorestr_L0+0
	MOVWF      FARG_strcpy_target+0
	MOVLW      ?lstr1_tetris+0
	MOVWF      FARG_strcpy_source+0
	MOVLW      5
	MOVWF      FARG_strcpy_length+0
	CALL       _strcpy+0
;tetris.c,333 :: 		itoa(scorestr, hiscore, 5, 10);
	MOVLW      show_highscore_scorestr_L0+0
	MOVWF      FARG_itoa_target+0
	MOVF       show_highscore_hiscore_L0+0, 0
	MOVWF      FARG_itoa_value+0
	MOVF       show_highscore_hiscore_L0+1, 0
	MOVWF      FARG_itoa_value+1
	MOVLW      5
	MOVWF      FARG_itoa_i+0
	MOVLW      10
	MOVWF      FARG_itoa_base+0
	MOVLW      0
	MOVWF      FARG_itoa_base+1
	CALL       _itoa+0
;tetris.c,335 :: 		x=99;
	MOVLW      99
	MOVWF      show_highscore_x_L0+0
;tetris.c,336 :: 		for (j=0;j<5;j++) {
	CLRF       show_highscore_j_L0+0
L_show_highscore66:
	MOVLW      5
	SUBWF      show_highscore_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_show_highscore67
;tetris.c,337 :: 		ks0108_char(x,y,scorestr[j]-32,0);
	MOVF       show_highscore_x_L0+0, 0
	MOVWF      FARG_ks0108_char+0
	MOVF       show_highscore_y_L0+0, 0
	MOVWF      FARG_ks0108_char+0
	MOVF       show_highscore_j_L0+0, 0
	ADDLW      show_highscore_scorestr_L0+0
	MOVWF      FSR
	MOVLW      32
	SUBWF      INDF+0, 0
	MOVWF      FARG_ks0108_char+0
	CLRF       FARG_ks0108_char+0
	CALL       _ks0108_char+0
;tetris.c,338 :: 		x+=6;
	MOVLW      6
	ADDWF      show_highscore_x_L0+0, 1
;tetris.c,336 :: 		for (j=0;j<5;j++) {
	INCF       show_highscore_j_L0+0, 1
;tetris.c,339 :: 		}
	GOTO       L_show_highscore66
L_show_highscore67:
;tetris.c,341 :: 		y+=8;
	MOVLW      8
	ADDWF      show_highscore_y_L0+0, 1
;tetris.c,311 :: 		for(i=0; i<8; i++) {
	INCF       show_highscore_i_L0+0, 1
;tetris.c,343 :: 		}
	GOTO       L_show_highscore58
L_show_highscore59:
;tetris.c,345 :: 		while(PORTC & 0xf0);
L_show_highscore69:
	MOVLW      240
	ANDWF      PORTC+0, 0
	MOVWF      R0+0
	BTFSC      STATUS+0, 2
	GOTO       L_show_highscore70
	GOTO       L_show_highscore69
L_show_highscore70:
;tetris.c,346 :: 		while(!(PORTC & 0xf0));
L_show_highscore71:
	MOVLW      240
	ANDWF      PORTC+0, 0
	MOVWF      R0+0
	BTFSS      STATUS+0, 2
	GOTO       L_show_highscore72
	GOTO       L_show_highscore71
L_show_highscore72:
;tetris.c,348 :: 		}
	RETURN
; end of _show_highscore

_check_highscore:

;tetris.c,350 :: 		unsigned char check_highscore(void)
;tetris.c,358 :: 		const unsigned char *msg1 = "Congratulations!   ";
	MOVLW      ?lstr_2_tetris+0
	MOVWF      check_highscore_msg1_L0+0
	MOVLW      hi_addr(?lstr_2_tetris+0)
	MOVWF      check_highscore_msg1_L0+1
;tetris.c,359 :: 		const unsigned char *msg2 = "You are placed     ";
	MOVLW      ?lstr_3_tetris+0
	MOVWF      check_highscore_msg2_L0+0
	MOVLW      hi_addr(?lstr_3_tetris+0)
	MOVWF      check_highscore_msg2_L0+1
;tetris.c,360 :: 		const unsigned char *msg3 = "Enter name:        ";
	MOVLW      ?lstr_4_tetris+0
	MOVWF      check_highscore_msg3_L0+0
	MOVLW      hi_addr(?lstr_4_tetris+0)
	MOVWF      check_highscore_msg3_L0+1
;tetris.c,364 :: 		addr = 0;
	CLRF       check_highscore_addr_L0+0
;tetris.c,365 :: 		for (i=0; i<8; i++) {
	CLRF       check_highscore_i_L0+0
L_check_highscore73:
	MOVLW      8
	SUBWF      check_highscore_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_check_highscore74
;tetris.c,366 :: 		Delay_ms(20);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_check_highscore76:
	DECFSZ     R13+0, 1
	GOTO       L_check_highscore76
	DECFSZ     R12+0, 1
	GOTO       L_check_highscore76
	NOP
	NOP
;tetris.c,367 :: 		for (j=0; j<16; j++) {
	CLRF       check_highscore_j_L0+0
L_check_highscore77:
	MOVLW      16
	SUBWF      check_highscore_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_check_highscore78
;tetris.c,368 :: 		hiscore_record[addr % 16] = EEPROM_Read(addr);
	MOVLW      15
	ANDWF      check_highscore_addr_L0+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	ADDLW      check_highscore_hiscore_record_L0+0
	MOVWF      FLOC__check_highscore+0
	MOVF       check_highscore_addr_L0+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       FLOC__check_highscore+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;tetris.c,369 :: 		addr++;
	INCF       check_highscore_addr_L0+0, 1
;tetris.c,367 :: 		for (j=0; j<16; j++) {
	INCF       check_highscore_j_L0+0, 1
;tetris.c,370 :: 		}
	GOTO       L_check_highscore77
L_check_highscore78:
;tetris.c,371 :: 		Delay_ms(20);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_check_highscore80:
	DECFSZ     R13+0, 1
	GOTO       L_check_highscore80
	DECFSZ     R12+0, 1
	GOTO       L_check_highscore80
	NOP
	NOP
;tetris.c,372 :: 		hiscore = hiscore_record[14];
	MOVF       check_highscore_hiscore_record_L0+14, 0
	MOVWF      check_highscore_hiscore_L0+0
	CLRF       check_highscore_hiscore_L0+1
;tetris.c,373 :: 		hiscore |= hiscore_record[15] << 8;
	MOVF       check_highscore_hiscore_record_L0+15, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       R0+0, 0
	IORWF      check_highscore_hiscore_L0+0, 0
	MOVWF      R2+0
	MOVF       check_highscore_hiscore_L0+1, 0
	IORWF      R0+1, 0
	MOVWF      R2+1
	MOVF       R2+0, 0
	MOVWF      check_highscore_hiscore_L0+0
	MOVF       R2+1, 0
	MOVWF      check_highscore_hiscore_L0+1
;tetris.c,374 :: 		if (score > hiscore) {
	MOVF       _score+1, 0
	SUBWF      R2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__check_highscore248
	MOVF       _score+0, 0
	SUBWF      R2+0, 0
L__check_highscore248:
	BTFSC      STATUS+0, 0
	GOTO       L_check_highscore81
;tetris.c,376 :: 		addr = 0x80;
	MOVLW      128
	MOVWF      check_highscore_addr_L0+0
;tetris.c,377 :: 		Delay_ms(20);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_check_highscore82:
	DECFSZ     R13+0, 1
	GOTO       L_check_highscore82
	DECFSZ     R12+0, 1
	GOTO       L_check_highscore82
	NOP
	NOP
;tetris.c,378 :: 		for (k=0;k<10;k++) {
	CLRF       check_highscore_k_L0+0
L_check_highscore83:
	MOVLW      10
	SUBWF      check_highscore_k_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_check_highscore84
;tetris.c,379 :: 		player_name[k] = EEPROM_Read(addr++);
	MOVF       check_highscore_k_L0+0, 0
	ADDLW      check_highscore_player_name_L0+0
	MOVWF      FLOC__check_highscore+0
	MOVF       check_highscore_addr_L0+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       FLOC__check_highscore+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       check_highscore_addr_L0+0, 1
;tetris.c,378 :: 		for (k=0;k<10;k++) {
	INCF       check_highscore_k_L0+0, 1
;tetris.c,380 :: 		}
	GOTO       L_check_highscore83
L_check_highscore84:
;tetris.c,381 :: 		Delay_ms(20);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_check_highscore86:
	DECFSZ     R13+0, 1
	GOTO       L_check_highscore86
	DECFSZ     R12+0, 1
	GOTO       L_check_highscore86
	NOP
	NOP
;tetris.c,383 :: 		ks0108_fill(0);
	CLRF       FARG_ks0108_fill+0
	CALL       _ks0108_fill+0
;tetris.c,384 :: 		x = 0;
	CLRF       check_highscore_x_L0+0
;tetris.c,385 :: 		for (j=0; j<16; j++) {
	CLRF       check_highscore_j_L0+0
L_check_highscore87:
	MOVLW      16
	SUBWF      check_highscore_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_check_highscore88
;tetris.c,386 :: 		ks0108_char(x,0,msg1[j]-32,0);
	MOVF       check_highscore_x_L0+0, 0
	MOVWF      FARG_ks0108_char+0
	CLRF       FARG_ks0108_char+0
	MOVF       check_highscore_j_L0+0, 0
	ADDWF      check_highscore_msg1_L0+0, 0
	MOVWF      R0+0
	MOVF       check_highscore_msg1_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVLW      32
	SUBWF      R0+0, 0
	MOVWF      FARG_ks0108_char+0
	CLRF       FARG_ks0108_char+0
	CALL       _ks0108_char+0
;tetris.c,387 :: 		ks0108_char(x,8,msg2[j]-32,0);
	MOVF       check_highscore_x_L0+0, 0
	MOVWF      FARG_ks0108_char+0
	MOVLW      8
	MOVWF      FARG_ks0108_char+0
	MOVF       check_highscore_j_L0+0, 0
	ADDWF      check_highscore_msg2_L0+0, 0
	MOVWF      R0+0
	MOVF       check_highscore_msg2_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVLW      32
	SUBWF      R0+0, 0
	MOVWF      FARG_ks0108_char+0
	CLRF       FARG_ks0108_char+0
	CALL       _ks0108_char+0
;tetris.c,388 :: 		ks0108_char(x,16,msg3[j]-32,0);
	MOVF       check_highscore_x_L0+0, 0
	MOVWF      FARG_ks0108_char+0
	MOVLW      16
	MOVWF      FARG_ks0108_char+0
	MOVF       check_highscore_j_L0+0, 0
	ADDWF      check_highscore_msg3_L0+0, 0
	MOVWF      R0+0
	MOVF       check_highscore_msg3_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVLW      32
	SUBWF      R0+0, 0
	MOVWF      FARG_ks0108_char+0
	CLRF       FARG_ks0108_char+0
	CALL       _ks0108_char+0
;tetris.c,389 :: 		x+=6;
	MOVLW      6
	ADDWF      check_highscore_x_L0+0, 1
;tetris.c,385 :: 		for (j=0; j<16; j++) {
	INCF       check_highscore_j_L0+0, 1
;tetris.c,390 :: 		}
	GOTO       L_check_highscore87
L_check_highscore88:
;tetris.c,391 :: 		ks0108_char(95,8,i+17,0);
	MOVLW      95
	MOVWF      FARG_ks0108_char+0
	MOVLW      8
	MOVWF      FARG_ks0108_char+0
	MOVLW      17
	ADDWF      check_highscore_i_L0+0, 0
	MOVWF      FARG_ks0108_char+0
	CLRF       FARG_ks0108_char+0
	CALL       _ks0108_char+0
;tetris.c,392 :: 		j = (i > 3) ? 3 : i;
	MOVF       check_highscore_i_L0+0, 0
	SUBLW      3
	BTFSC      STATUS+0, 0
	GOTO       L_check_highscore90
	MOVLW      3
	MOVWF      R3+0
	GOTO       L_check_highscore91
L_check_highscore90:
	MOVF       check_highscore_i_L0+0, 0
	MOVWF      R3+0
L_check_highscore91:
	MOVF       R3+0, 0
	MOVWF      check_highscore_j_L0+0
;tetris.c,393 :: 		ks0108_char(101,8,suffix[j][0]-32,0);
	MOVLW      101
	MOVWF      FARG_ks0108_char+0
	MOVLW      8
	MOVWF      FARG_ks0108_char+0
	MOVF       R3+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      check_highscore_suffix_L0+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(check_highscore_suffix_L0+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVLW      32
	SUBWF      R0+0, 0
	MOVWF      FARG_ks0108_char+0
	CLRF       FARG_ks0108_char+0
	CALL       _ks0108_char+0
;tetris.c,394 :: 		ks0108_char(107,8,suffix[j][1]-32,0);
	MOVLW      107
	MOVWF      FARG_ks0108_char+0
	MOVLW      8
	MOVWF      FARG_ks0108_char+0
	MOVF       check_highscore_j_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      check_highscore_suffix_L0+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(check_highscore_suffix_L0+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVLW      32
	SUBWF      R0+0, 0
	MOVWF      FARG_ks0108_char+0
	CLRF       FARG_ks0108_char+0
	CALL       _ks0108_char+0
;tetris.c,396 :: 		addr = 0;
	CLRF       check_highscore_addr_L0+0
;tetris.c,397 :: 		j = 1;
	MOVLW      1
	MOVWF      check_highscore_j_L0+0
;tetris.c,398 :: 		x = 1;
	MOVLW      1
	MOVWF      check_highscore_x_L0+0
;tetris.c,399 :: 		while (PORTC & 0xf0);
L_check_highscore92:
	MOVLW      240
	ANDWF      PORTC+0, 0
	MOVWF      R0+0
	BTFSC      STATUS+0, 2
	GOTO       L_check_highscore93
	GOTO       L_check_highscore92
L_check_highscore93:
;tetris.c,400 :: 		while (1) {
L_check_highscore94:
;tetris.c,402 :: 		if (PORTC || j) {
	MOVF       PORTC+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__check_highscore219
	MOVF       check_highscore_j_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__check_highscore219
	GOTO       L_check_highscore98
L__check_highscore219:
;tetris.c,403 :: 		if (PORTC & KEY1) {
	BTFSS      PORTC+0, 7
	GOTO       L_check_highscore99
;tetris.c,404 :: 		if (player_name[addr] == 0)
	MOVF       check_highscore_addr_L0+0, 0
	ADDLW      check_highscore_player_name_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_check_highscore100
;tetris.c,405 :: 		player_name[addr] = 58;
	MOVF       check_highscore_addr_L0+0, 0
	ADDLW      check_highscore_player_name_L0+0
	MOVWF      FSR
	MOVLW      58
	MOVWF      INDF+0
	GOTO       L_check_highscore101
L_check_highscore100:
;tetris.c,407 :: 		player_name[addr]--;
	MOVF       check_highscore_addr_L0+0, 0
	ADDLW      check_highscore_player_name_L0+0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      FSR
	DECF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
L_check_highscore101:
;tetris.c,408 :: 		}
L_check_highscore99:
;tetris.c,410 :: 		if (PORTC & KEY2) {
	BTFSS      PORTC+0, 6
	GOTO       L_check_highscore102
;tetris.c,411 :: 		player_name[addr] = (player_name[addr] + 1) % 59;
	MOVF       check_highscore_addr_L0+0, 0
	ADDLW      check_highscore_player_name_L0+0
	MOVWF      FLOC__check_highscore+0
	MOVF       FLOC__check_highscore+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDLW      1
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      59
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       FLOC__check_highscore+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;tetris.c,412 :: 		}
L_check_highscore102:
;tetris.c,414 :: 		if (PORTC & KEY3) {
	BTFSS      PORTC+0, 5
	GOTO       L_check_highscore103
;tetris.c,415 :: 		addr = (addr + 1) % 10;
	MOVF       check_highscore_addr_L0+0, 0
	ADDLW      1
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      check_highscore_addr_L0+0
;tetris.c,416 :: 		}
L_check_highscore103:
;tetris.c,418 :: 		if (PORTC & KEY4)
	BTFSS      PORTC+0, 4
	GOTO       L_check_highscore104
;tetris.c,419 :: 		break;
	GOTO       L_check_highscore95
L_check_highscore104:
;tetris.c,422 :: 		x = 0;
	CLRF       check_highscore_x_L0+0
;tetris.c,423 :: 		for (j=0; j<10; j++) {
	CLRF       check_highscore_j_L0+0
L_check_highscore105:
	MOVLW      10
	SUBWF      check_highscore_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_check_highscore106
;tetris.c,424 :: 		if (player_name[j] > 58)
	MOVF       check_highscore_j_L0+0, 0
	ADDLW      check_highscore_player_name_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBLW      58
	BTFSC      STATUS+0, 0
	GOTO       L_check_highscore108
;tetris.c,425 :: 		player_name[j] = 0;
	MOVF       check_highscore_j_L0+0, 0
	ADDLW      check_highscore_player_name_L0+0
	MOVWF      FSR
	CLRF       INDF+0
L_check_highscore108:
;tetris.c,426 :: 		if (j == addr)
	MOVF       check_highscore_j_L0+0, 0
	XORWF      check_highscore_addr_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_check_highscore109
;tetris.c,427 :: 		ks0108_char(x,32,player_name[j],1);
	MOVF       check_highscore_x_L0+0, 0
	MOVWF      FARG_ks0108_char+0
	MOVLW      32
	MOVWF      FARG_ks0108_char+0
	MOVF       check_highscore_j_L0+0, 0
	ADDLW      check_highscore_player_name_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_ks0108_char+0
	MOVLW      1
	MOVWF      FARG_ks0108_char+0
	CALL       _ks0108_char+0
	GOTO       L_check_highscore110
L_check_highscore109:
;tetris.c,429 :: 		ks0108_char(x,32,player_name[j],0);
	MOVF       check_highscore_x_L0+0, 0
	MOVWF      FARG_ks0108_char+0
	MOVLW      32
	MOVWF      FARG_ks0108_char+0
	MOVF       check_highscore_j_L0+0, 0
	ADDLW      check_highscore_player_name_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_ks0108_char+0
	CLRF       FARG_ks0108_char+0
	CALL       _ks0108_char+0
L_check_highscore110:
;tetris.c,430 :: 		x+=6;
	MOVLW      6
	ADDWF      check_highscore_x_L0+0, 1
;tetris.c,423 :: 		for (j=0; j<10; j++) {
	INCF       check_highscore_j_L0+0, 1
;tetris.c,431 :: 		}
	GOTO       L_check_highscore105
L_check_highscore106:
;tetris.c,432 :: 		j = 0;
	CLRF       check_highscore_j_L0+0
;tetris.c,434 :: 		while (PORTC & 0xf0) {
L_check_highscore111:
	MOVLW      240
	ANDWF      PORTC+0, 0
	MOVWF      R0+0
	BTFSC      STATUS+0, 2
	GOTO       L_check_highscore112
;tetris.c,435 :: 		if (k>=20) {
	MOVLW      20
	SUBWF      check_highscore_k_L0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_check_highscore113
;tetris.c,436 :: 		if ( !(PORTC & KEY3) && (player_name[addr] == 0) )
	BTFSC      PORTC+0, 5
	GOTO       L_check_highscore116
	MOVF       check_highscore_addr_L0+0, 0
	ADDLW      check_highscore_player_name_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_check_highscore116
L__check_highscore218:
;tetris.c,437 :: 		Delay_ms(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_check_highscore117:
	DECFSZ     R13+0, 1
	GOTO       L_check_highscore117
	DECFSZ     R12+0, 1
	GOTO       L_check_highscore117
	DECFSZ     R11+0, 1
	GOTO       L_check_highscore117
	NOP
	GOTO       L_check_highscore118
L_check_highscore116:
;tetris.c,439 :: 		Delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_check_highscore119:
	DECFSZ     R13+0, 1
	GOTO       L_check_highscore119
	DECFSZ     R12+0, 1
	GOTO       L_check_highscore119
	DECFSZ     R11+0, 1
	GOTO       L_check_highscore119
	NOP
	NOP
L_check_highscore118:
;tetris.c,440 :: 		break;
	GOTO       L_check_highscore112
;tetris.c,441 :: 		} else {
L_check_highscore113:
;tetris.c,442 :: 		k++;
	INCF       check_highscore_k_L0+0, 1
;tetris.c,443 :: 		Delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_check_highscore121:
	DECFSZ     R13+0, 1
	GOTO       L_check_highscore121
	DECFSZ     R12+0, 1
	GOTO       L_check_highscore121
	DECFSZ     R11+0, 1
	GOTO       L_check_highscore121
	NOP
	NOP
;tetris.c,445 :: 		}
	GOTO       L_check_highscore111
L_check_highscore112:
;tetris.c,446 :: 		} else {
	GOTO       L_check_highscore122
L_check_highscore98:
;tetris.c,447 :: 		k=0;
	CLRF       check_highscore_k_L0+0
;tetris.c,448 :: 		}
L_check_highscore122:
;tetris.c,449 :: 		}
	GOTO       L_check_highscore94
L_check_highscore95:
;tetris.c,451 :: 		j=7;
	MOVLW      7
	MOVWF      check_highscore_j_L0+0
;tetris.c,452 :: 		do {
L_check_highscore123:
;tetris.c,453 :: 		j--;
	DECF       check_highscore_j_L0+0, 1
;tetris.c,454 :: 		addr = j<<4;
	MOVF       check_highscore_j_L0+0, 0
	MOVWF      check_highscore_addr_L0+0
	RLF        check_highscore_addr_L0+0, 1
	BCF        check_highscore_addr_L0+0, 0
	RLF        check_highscore_addr_L0+0, 1
	BCF        check_highscore_addr_L0+0, 0
	RLF        check_highscore_addr_L0+0, 1
	BCF        check_highscore_addr_L0+0, 0
	RLF        check_highscore_addr_L0+0, 1
	BCF        check_highscore_addr_L0+0, 0
;tetris.c,455 :: 		for (k=0;k<16;k++) {
	CLRF       check_highscore_k_L0+0
L_check_highscore126:
	MOVLW      16
	SUBWF      check_highscore_k_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_check_highscore127
;tetris.c,456 :: 		hiscore_record[k] = EEPROM_Read(addr + k);
	MOVF       check_highscore_k_L0+0, 0
	ADDLW      check_highscore_hiscore_record_L0+0
	MOVWF      FLOC__check_highscore+0
	MOVF       check_highscore_k_L0+0, 0
	ADDWF      check_highscore_addr_L0+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       FLOC__check_highscore+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;tetris.c,455 :: 		for (k=0;k<16;k++) {
	INCF       check_highscore_k_L0+0, 1
;tetris.c,457 :: 		}
	GOTO       L_check_highscore126
L_check_highscore127:
;tetris.c,458 :: 		Delay_ms(20);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_check_highscore129:
	DECFSZ     R13+0, 1
	GOTO       L_check_highscore129
	DECFSZ     R12+0, 1
	GOTO       L_check_highscore129
	NOP
	NOP
;tetris.c,459 :: 		addr += 16;
	MOVLW      16
	ADDWF      check_highscore_addr_L0+0, 1
;tetris.c,460 :: 		for (k=0;k<16;k++) {
	CLRF       check_highscore_k_L0+0
L_check_highscore130:
	MOVLW      16
	SUBWF      check_highscore_k_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_check_highscore131
;tetris.c,461 :: 		EEPROM_Write(addr + k, hiscore_record[k]);
	MOVF       check_highscore_k_L0+0, 0
	ADDWF      check_highscore_addr_L0+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       check_highscore_k_L0+0, 0
	ADDLW      check_highscore_hiscore_record_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;tetris.c,460 :: 		for (k=0;k<16;k++) {
	INCF       check_highscore_k_L0+0, 1
;tetris.c,462 :: 		}
	GOTO       L_check_highscore130
L_check_highscore131:
;tetris.c,463 :: 		Delay_ms(20);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_check_highscore133:
	DECFSZ     R13+0, 1
	GOTO       L_check_highscore133
	DECFSZ     R12+0, 1
	GOTO       L_check_highscore133
	NOP
	NOP
;tetris.c,464 :: 		} while (j>i);
	MOVF       check_highscore_j_L0+0, 0
	SUBWF      check_highscore_i_L0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_check_highscore123
;tetris.c,466 :: 		hiscore_record[14] = score & 255;
	MOVLW      255
	ANDWF      _score+0, 0
	MOVWF      check_highscore_hiscore_record_L0+14
;tetris.c,467 :: 		hiscore_record[15] = score >> 8;
	MOVF       _score+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	MOVWF      check_highscore_hiscore_record_L0+15
;tetris.c,469 :: 		addr = i<<4;
	MOVF       check_highscore_i_L0+0, 0
	MOVWF      check_highscore_addr_L0+0
	RLF        check_highscore_addr_L0+0, 1
	BCF        check_highscore_addr_L0+0, 0
	RLF        check_highscore_addr_L0+0, 1
	BCF        check_highscore_addr_L0+0, 0
	RLF        check_highscore_addr_L0+0, 1
	BCF        check_highscore_addr_L0+0, 0
	RLF        check_highscore_addr_L0+0, 1
	BCF        check_highscore_addr_L0+0, 0
;tetris.c,470 :: 		for (j=0; j<16; j++) {
	CLRF       check_highscore_j_L0+0
L_check_highscore134:
	MOVLW      16
	SUBWF      check_highscore_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_check_highscore135
;tetris.c,471 :: 		if (j<10)
	MOVLW      10
	SUBWF      check_highscore_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_check_highscore137
;tetris.c,472 :: 		hiscore_record[j] = player_name[j] + 32;
	MOVF       check_highscore_j_L0+0, 0
	ADDLW      check_highscore_hiscore_record_L0+0
	MOVWF      R1+0
	MOVF       check_highscore_j_L0+0, 0
	ADDLW      check_highscore_player_name_L0+0
	MOVWF      FSR
	MOVLW      32
	ADDWF      INDF+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
L_check_highscore137:
;tetris.c,473 :: 		EEPROM_Write(addr++, hiscore_record[j]);
	MOVF       check_highscore_addr_L0+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       check_highscore_j_L0+0, 0
	ADDLW      check_highscore_hiscore_record_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
	INCF       check_highscore_addr_L0+0, 1
;tetris.c,470 :: 		for (j=0; j<16; j++) {
	INCF       check_highscore_j_L0+0, 1
;tetris.c,474 :: 		}
	GOTO       L_check_highscore134
L_check_highscore135:
;tetris.c,475 :: 		Delay_ms(20);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_check_highscore138:
	DECFSZ     R13+0, 1
	GOTO       L_check_highscore138
	DECFSZ     R12+0, 1
	GOTO       L_check_highscore138
	NOP
	NOP
;tetris.c,476 :: 		addr = 0x80;
	MOVLW      128
	MOVWF      check_highscore_addr_L0+0
;tetris.c,477 :: 		for(k=0;k<10;k++) {
	CLRF       check_highscore_k_L0+0
L_check_highscore139:
	MOVLW      10
	SUBWF      check_highscore_k_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_check_highscore140
;tetris.c,478 :: 		EEPROM_Write(addr++, player_name[k]);
	MOVF       check_highscore_addr_L0+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       check_highscore_k_L0+0, 0
	ADDLW      check_highscore_player_name_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
	INCF       check_highscore_addr_L0+0, 1
;tetris.c,477 :: 		for(k=0;k<10;k++) {
	INCF       check_highscore_k_L0+0, 1
;tetris.c,479 :: 		}
	GOTO       L_check_highscore139
L_check_highscore140:
;tetris.c,480 :: 		Delay_ms(20);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_check_highscore142:
	DECFSZ     R13+0, 1
	GOTO       L_check_highscore142
	DECFSZ     R12+0, 1
	GOTO       L_check_highscore142
	NOP
	NOP
;tetris.c,482 :: 		return 1;
	MOVLW      1
	MOVWF      R0+0
	RETURN
;tetris.c,483 :: 		}
L_check_highscore81:
;tetris.c,365 :: 		for (i=0; i<8; i++) {
	INCF       check_highscore_i_L0+0, 1
;tetris.c,484 :: 		}
	GOTO       L_check_highscore73
L_check_highscore74:
;tetris.c,485 :: 		return 0;
	CLRF       R0+0
;tetris.c,486 :: 		}
	RETURN
; end of _check_highscore

_init_gamescreen:

;tetris.c,488 :: 		void init_gamescreen(void)
;tetris.c,491 :: 		const char *tmp = "Next :";
	MOVLW      ?lstr_5_tetris+0
	MOVWF      init_gamescreen_tmp_L0+0
	MOVLW      hi_addr(?lstr_5_tetris+0)
	MOVWF      init_gamescreen_tmp_L0+1
;tetris.c,493 :: 		ks0108_fill(0);
	CLRF       FARG_ks0108_fill+0
	CALL       _ks0108_fill+0
;tetris.c,496 :: 		ks0108_rect(1,3, 82, 58,1);
	MOVLW      1
	MOVWF      FARG_ks0108_rect+0
	MOVLW      3
	MOVWF      FARG_ks0108_rect+0
	MOVLW      82
	MOVWF      FARG_ks0108_rect+0
	MOVLW      58
	MOVWF      FARG_ks0108_rect+0
	MOVLW      1
	MOVWF      FARG_ks0108_rect+0
	CALL       _ks0108_rect+0
;tetris.c,499 :: 		y = 56;
	MOVLW      56
	MOVWF      init_gamescreen_y_L0+0
;tetris.c,500 :: 		for (i=0; i<6; i++) {
	CLRF       init_gamescreen_i_L0+0
L_init_gamescreen143:
	MOVLW      6
	SUBWF      init_gamescreen_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_init_gamescreen144
;tetris.c,501 :: 		ks0108_char_portrait(90, y, tmp[i]-32,0);
	MOVLW      90
	MOVWF      FARG_ks0108_char_portrait+0
	MOVF       init_gamescreen_y_L0+0, 0
	MOVWF      FARG_ks0108_char_portrait+0
	MOVF       init_gamescreen_i_L0+0, 0
	ADDWF      init_gamescreen_tmp_L0+0, 0
	MOVWF      R0+0
	MOVF       init_gamescreen_tmp_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVLW      32
	SUBWF      R0+0, 0
	MOVWF      FARG_ks0108_char_portrait+0
	CLRF       FARG_ks0108_char_portrait+0
	CALL       _ks0108_char_portrait+0
;tetris.c,502 :: 		y -= 6;
	MOVLW      6
	SUBWF      init_gamescreen_y_L0+0, 1
;tetris.c,500 :: 		for (i=0; i<6; i++) {
	INCF       init_gamescreen_i_L0+0, 1
;tetris.c,503 :: 		}
	GOTO       L_init_gamescreen143
L_init_gamescreen144:
;tetris.c,509 :: 		}
	RETURN
; end of _init_gamescreen

_update_scoreboard:

;tetris.c,511 :: 		void update_scoreboard(void) {
;tetris.c,518 :: 		strcpy(tmp0, "Row:      ", 10);
	MOVLW      update_scoreboard_tmp0_L0+0
	MOVWF      FARG_strcpy_target+0
	MOVLW      ?lstr6_tetris+0
	MOVWF      FARG_strcpy_source+0
	MOVLW      10
	MOVWF      FARG_strcpy_length+0
	CALL       _strcpy+0
;tetris.c,519 :: 		strcpy(tmp1, "Lev:      ", 10);
	MOVLW      update_scoreboard_tmp1_L0+0
	MOVWF      FARG_strcpy_target+0
	MOVLW      ?lstr7_tetris+0
	MOVWF      FARG_strcpy_source+0
	MOVLW      10
	MOVWF      FARG_strcpy_length+0
	CALL       _strcpy+0
;tetris.c,520 :: 		strcpy(tmp2, "Scr:      ", 10);
	MOVLW      update_scoreboard_tmp2_L0+0
	MOVWF      FARG_strcpy_target+0
	MOVLW      ?lstr8_tetris+0
	MOVWF      FARG_strcpy_source+0
	MOVLW      10
	MOVWF      FARG_strcpy_length+0
	CALL       _strcpy+0
;tetris.c,522 :: 		itoa(&(tmp0[5]), removed_rows, 5, 10);
	MOVLW      update_scoreboard_tmp0_L0+5
	MOVWF      FARG_itoa_target+0
	MOVF       _removed_rows+0, 0
	MOVWF      FARG_itoa_value+0
	MOVF       _removed_rows+1, 0
	MOVWF      FARG_itoa_value+1
	MOVLW      5
	MOVWF      FARG_itoa_i+0
	MOVLW      10
	MOVWF      FARG_itoa_base+0
	MOVLW      0
	MOVWF      FARG_itoa_base+1
	CALL       _itoa+0
;tetris.c,523 :: 		itoa(&(tmp1[5]), level, 5, 10);
	MOVLW      update_scoreboard_tmp1_L0+5
	MOVWF      FARG_itoa_target+0
	MOVF       _level+0, 0
	MOVWF      FARG_itoa_value+0
	CLRF       FARG_itoa_value+1
	MOVLW      5
	MOVWF      FARG_itoa_i+0
	MOVLW      10
	MOVWF      FARG_itoa_base+0
	MOVLW      0
	MOVWF      FARG_itoa_base+1
	CALL       _itoa+0
;tetris.c,524 :: 		itoa(&(tmp2[5]), score, 5, 10);
	MOVLW      update_scoreboard_tmp2_L0+5
	MOVWF      FARG_itoa_target+0
	MOVF       _score+0, 0
	MOVWF      FARG_itoa_value+0
	MOVF       _score+1, 0
	MOVWF      FARG_itoa_value+1
	MOVLW      5
	MOVWF      FARG_itoa_i+0
	MOVLW      10
	MOVWF      FARG_itoa_base+0
	MOVLW      0
	MOVWF      FARG_itoa_base+1
	CALL       _itoa+0
;tetris.c,526 :: 		y = 56;
	MOVLW      56
	MOVWF      update_scoreboard_y_L0+0
;tetris.c,527 :: 		for (i=0; i<10; i++) {
	CLRF       update_scoreboard_i_L0+0
L_update_scoreboard146:
	MOVLW      10
	SUBWF      update_scoreboard_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_update_scoreboard147
;tetris.c,528 :: 		ks0108_char_portrait(104, y, tmp0[i]-32,0);
	MOVLW      104
	MOVWF      FARG_ks0108_char_portrait+0
	MOVF       update_scoreboard_y_L0+0, 0
	MOVWF      FARG_ks0108_char_portrait+0
	MOVF       update_scoreboard_i_L0+0, 0
	ADDLW      update_scoreboard_tmp0_L0+0
	MOVWF      FSR
	MOVLW      32
	SUBWF      INDF+0, 0
	MOVWF      FARG_ks0108_char_portrait+0
	CLRF       FARG_ks0108_char_portrait+0
	CALL       _ks0108_char_portrait+0
;tetris.c,529 :: 		ks0108_char_portrait(112, y, tmp1[i]-32,0);
	MOVLW      112
	MOVWF      FARG_ks0108_char_portrait+0
	MOVF       update_scoreboard_y_L0+0, 0
	MOVWF      FARG_ks0108_char_portrait+0
	MOVF       update_scoreboard_i_L0+0, 0
	ADDLW      update_scoreboard_tmp1_L0+0
	MOVWF      FSR
	MOVLW      32
	SUBWF      INDF+0, 0
	MOVWF      FARG_ks0108_char_portrait+0
	CLRF       FARG_ks0108_char_portrait+0
	CALL       _ks0108_char_portrait+0
;tetris.c,530 :: 		ks0108_char_portrait(120, y, tmp2[i]-32,0);
	MOVLW      120
	MOVWF      FARG_ks0108_char_portrait+0
	MOVF       update_scoreboard_y_L0+0, 0
	MOVWF      FARG_ks0108_char_portrait+0
	MOVF       update_scoreboard_i_L0+0, 0
	ADDLW      update_scoreboard_tmp2_L0+0
	MOVWF      FSR
	MOVLW      32
	SUBWF      INDF+0, 0
	MOVWF      FARG_ks0108_char_portrait+0
	CLRF       FARG_ks0108_char_portrait+0
	CALL       _ks0108_char_portrait+0
;tetris.c,531 :: 		y -= 6;
	MOVLW      6
	SUBWF      update_scoreboard_y_L0+0, 1
;tetris.c,527 :: 		for (i=0; i<10; i++) {
	INCF       update_scoreboard_i_L0+0, 1
;tetris.c,532 :: 		}
	GOTO       L_update_scoreboard146
L_update_scoreboard147:
;tetris.c,534 :: 		}
	RETURN
; end of _update_scoreboard

_game_over:

;tetris.c,536 :: 		void game_over()
;tetris.c,541 :: 		int x = 11;
	MOVLW      11
	MOVWF      game_over_x_L0+0
	MOVLW      0
	MOVWF      game_over_x_L0+1
;tetris.c,542 :: 		for (i=0; i<4; i++) {
	CLRF       game_over_i_L0+0
L_game_over149:
	MOVLW      4
	SUBWF      game_over_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_game_over150
;tetris.c,543 :: 		ks0108_char(x, 24, tmp[0][i]-32,0);
	MOVF       game_over_x_L0+0, 0
	MOVWF      FARG_ks0108_char+0
	MOVLW      24
	MOVWF      FARG_ks0108_char+0
	MOVF       game_over_i_L0+0, 0
	ADDLW      game_over_tmp_L0+0
	MOVWF      R0+0
	MOVLW      hi_addr(game_over_tmp_L0+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVLW      32
	SUBWF      R0+0, 0
	MOVWF      FARG_ks0108_char+0
	CLRF       FARG_ks0108_char+0
	CALL       _ks0108_char+0
;tetris.c,544 :: 		ks0108_char(x, 32, tmp[1][i]-32,0);
	MOVF       game_over_x_L0+0, 0
	MOVWF      FARG_ks0108_char+0
	MOVLW      32
	MOVWF      FARG_ks0108_char+0
	MOVF       game_over_i_L0+0, 0
	ADDLW      game_over_tmp_L0+4
	MOVWF      R0+0
	MOVLW      hi_addr(game_over_tmp_L0+4)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVLW      32
	SUBWF      R0+0, 0
	MOVWF      FARG_ks0108_char+0
	CLRF       FARG_ks0108_char+0
	CALL       _ks0108_char+0
;tetris.c,545 :: 		x += 6;
	MOVLW      6
	ADDWF      game_over_x_L0+0, 1
	BTFSC      STATUS+0, 0
	INCF       game_over_x_L0+1, 1
;tetris.c,542 :: 		for (i=0; i<4; i++) {
	INCF       game_over_i_L0+0, 1
;tetris.c,546 :: 		}
	GOTO       L_game_over149
L_game_over150:
;tetris.c,548 :: 		while (PORTC & 0xf0);
L_game_over152:
	MOVLW      240
	ANDWF      PORTC+0, 0
	MOVWF      R0+0
	BTFSC      STATUS+0, 2
	GOTO       L_game_over153
	GOTO       L_game_over152
L_game_over153:
;tetris.c,549 :: 		while (!(PORTC & 0xf0));
L_game_over154:
	MOVLW      240
	ANDWF      PORTC+0, 0
	MOVWF      R0+0
	BTFSS      STATUS+0, 2
	GOTO       L_game_over155
	GOTO       L_game_over154
L_game_over155:
;tetris.c,551 :: 		}
	RETURN
; end of _game_over

_main:

;tetris.c,554 :: 		void main() {
;tetris.c,564 :: 		const char *menu1 = "RC7: New Game  ";
	MOVLW      ?lstr_9_tetris+0
	MOVWF      main_menu1_L0+0
	MOVLW      hi_addr(?lstr_9_tetris+0)
	MOVWF      main_menu1_L0+1
;tetris.c,565 :: 		const char *menu2 = "RC6: Highscores";
	MOVLW      ?lstr_10_tetris+0
	MOVWF      main_menu2_L0+0
	MOVLW      hi_addr(?lstr_10_tetris+0)
	MOVWF      main_menu2_L0+1
;tetris.c,566 :: 		unsigned char menuleft = 0;
	CLRF       main_menuleft_L0+0
;tetris.c,568 :: 		mostevilrestart:
___main_mostevilrestart:
;tetris.c,572 :: 		block_type_next = random_seed;
	MOVF       main_random_seed_L0+0, 0
	MOVWF      main_block_type_next_L0+0
;tetris.c,573 :: 		key_flags=0;
	CLRF       _key_flags+0
;tetris.c,575 :: 		score = 0;
	CLRF       _score+0
	CLRF       _score+1
;tetris.c,576 :: 		level = 1;
	MOVLW      1
	MOVWF      _level+0
;tetris.c,577 :: 		removed_rows = 0;
	CLRF       _removed_rows+0
	CLRF       _removed_rows+1
;tetris.c,578 :: 		round_delay = 1000;
	MOVLW      232
	MOVWF      _round_delay+0
	MOVLW      3
	MOVWF      _round_delay+1
;tetris.c,582 :: 		TRISC = 0xF0;                         // Port C - user-input
	MOVLW      240
	MOVWF      TRISC+0
;tetris.c,586 :: 		ks0108_init();
	CALL       _ks0108_init+0
;tetris.c,589 :: 		while (menuleft == 0) {
L_main156:
	MOVF       main_menuleft_L0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main157
;tetris.c,590 :: 		ks0108_fill(0);
	CLRF       FARG_ks0108_fill+0
	CALL       _ks0108_fill+0
;tetris.c,594 :: 		ks0108_title(128, 6);
	MOVLW      128
	MOVWF      FARG_ks0108_title+0
	MOVLW      6
	MOVWF      FARG_ks0108_title+0
	CALL       _ks0108_title+0
;tetris.c,596 :: 		for(i=0; i<15; i++) {
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
L_main158:
	MOVLW      0
	SUBWF      main_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main249
	MOVLW      15
	SUBWF      main_i_L0+0, 0
L__main249:
	BTFSC      STATUS+0, 0
	GOTO       L_main159
;tetris.c,597 :: 		ks0108_char(i*6,48, menu1[i]-32,0);
	MOVF       main_i_L0+0, 0
	MOVWF      R0+0
	MOVLW      6
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_ks0108_char+0
	MOVLW      48
	MOVWF      FARG_ks0108_char+0
	MOVF       main_i_L0+0, 0
	ADDWF      main_menu1_L0+0, 0
	MOVWF      R0+0
	MOVF       main_menu1_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      main_i_L0+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVLW      32
	SUBWF      R0+0, 0
	MOVWF      FARG_ks0108_char+0
	CLRF       FARG_ks0108_char+0
	CALL       _ks0108_char+0
;tetris.c,598 :: 		ks0108_char(i*6,56, menu2[i]-32,0);
	MOVF       main_i_L0+0, 0
	MOVWF      R0+0
	MOVLW      6
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_ks0108_char+0
	MOVLW      56
	MOVWF      FARG_ks0108_char+0
	MOVF       main_i_L0+0, 0
	ADDWF      main_menu2_L0+0, 0
	MOVWF      R0+0
	MOVF       main_menu2_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      main_i_L0+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVLW      32
	SUBWF      R0+0, 0
	MOVWF      FARG_ks0108_char+0
	CLRF       FARG_ks0108_char+0
	CALL       _ks0108_char+0
;tetris.c,596 :: 		for(i=0; i<15; i++) {
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;tetris.c,599 :: 		}
	GOTO       L_main158
L_main159:
;tetris.c,601 :: 		while (PORTC & 0xf0);
L_main161:
	MOVLW      240
	ANDWF      PORTC+0, 0
	MOVWF      R0+0
	BTFSC      STATUS+0, 2
	GOTO       L_main162
	GOTO       L_main161
L_main162:
;tetris.c,603 :: 		while (1) {
L_main163:
;tetris.c,605 :: 		if (PORTC & 0xf0) {
	MOVLW      240
	ANDWF      PORTC+0, 0
	MOVWF      R0+0
	BTFSC      STATUS+0, 2
	GOTO       L_main165
;tetris.c,606 :: 		block_type_next = (block_type_next + 1) % 7;
	MOVF       main_block_type_next_L0+0, 0
	ADDLW      1
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      7
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      main_block_type_next_L0+0
;tetris.c,607 :: 		}
L_main165:
;tetris.c,609 :: 		if (PORTC & KEY1) {
	BTFSS      PORTC+0, 7
	GOTO       L_main166
;tetris.c,610 :: 		menuleft=1;
	MOVLW      1
	MOVWF      main_menuleft_L0+0
;tetris.c,611 :: 		break;
	GOTO       L_main164
;tetris.c,612 :: 		}
L_main166:
;tetris.c,614 :: 		if (PORTC & KEY2) {
	BTFSS      PORTC+0, 6
	GOTO       L_main167
;tetris.c,615 :: 		show_highscore();
	CALL       _show_highscore+0
;tetris.c,616 :: 		break;
	GOTO       L_main164
;tetris.c,617 :: 		}
L_main167:
;tetris.c,619 :: 		}
	GOTO       L_main163
L_main164:
;tetris.c,621 :: 		}
	GOTO       L_main156
L_main157:
;tetris.c,623 :: 		menuleft = 0;
	CLRF       main_menuleft_L0+0
;tetris.c,625 :: 		while (PORTC & 0xf0) {
L_main168:
	MOVLW      240
	ANDWF      PORTC+0, 0
	MOVWF      R0+0
	BTFSC      STATUS+0, 2
	GOTO       L_main169
;tetris.c,626 :: 		random_seed = (random_seed + 1) % 7;
	MOVF       main_random_seed_L0+0, 0
	ADDLW      1
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      7
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      main_random_seed_L0+0
;tetris.c,627 :: 		}
	GOTO       L_main168
L_main169:
;tetris.c,631 :: 		init_gamescreen();
	CALL       _init_gamescreen+0
;tetris.c,634 :: 		for (i=0; i<20; i++)
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
L_main170:
	MOVLW      0
	SUBWF      main_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main250
	MOVLW      20
	SUBWF      main_i_L0+0, 0
L__main250:
	BTFSC      STATUS+0, 0
	GOTO       L_main171
;tetris.c,635 :: 		playfield[i] = 0;
	MOVF       main_i_L0+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _playfield+0
	MOVWF      FSR
	CLRF       INDF+0
	INCF       FSR, 1
	CLRF       INDF+0
;tetris.c,634 :: 		for (i=0; i<20; i++)
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;tetris.c,635 :: 		playfield[i] = 0;
	GOTO       L_main170
L_main171:
;tetris.c,637 :: 		update_scoreboard();
	CALL       _update_scoreboard+0
;tetris.c,639 :: 		mukke_start();
	CALL       _mukke_start+0
;tetris.c,641 :: 		while(1) {
L_main173:
;tetris.c,643 :: 		rotation=0;
	CLRF       _rotation+0
;tetris.c,644 :: 		block_pos_y=2;
	MOVLW      2
	MOVWF      _block_pos_y+0
;tetris.c,645 :: 		block_pos_x=6;
	MOVLW      6
	MOVWF      _block_pos_x+0
;tetris.c,646 :: 		round_finished = 0;
	CLRF       main_round_finished_L0+0
;tetris.c,648 :: 		block_type_current = block_type_next;
	MOVF       main_block_type_next_L0+0, 0
	MOVWF      main_block_type_current_L0+0
;tetris.c,649 :: 		block_type_next = random_seed;
	MOVF       main_random_seed_L0+0, 0
	MOVWF      main_block_type_next_L0+0
;tetris.c,651 :: 		build_shape_matrix(curr_shape_matrix, block_type_current, 0);
	MOVLW      _curr_shape_matrix+0
	MOVWF      FARG_build_shape_matrix_matrix+0
	MOVF       main_block_type_current_L0+0, 0
	MOVWF      FARG_build_shape_matrix_type+0
	CLRF       FARG_build_shape_matrix_rotation+0
	CALL       _build_shape_matrix+0
;tetris.c,652 :: 		draw_shape(0,13,23);
	CLRF       FARG_draw_shape_c+0
	MOVLW      13
	MOVWF      FARG_draw_shape_x+0
	MOVLW      23
	MOVWF      FARG_draw_shape_y+0
	CALL       _draw_shape+0
;tetris.c,653 :: 		build_shape_matrix(curr_shape_matrix, block_type_next, 0);
	MOVLW      _curr_shape_matrix+0
	MOVWF      FARG_build_shape_matrix_matrix+0
	MOVF       main_block_type_next_L0+0, 0
	MOVWF      FARG_build_shape_matrix_type+0
	CLRF       FARG_build_shape_matrix_rotation+0
	CALL       _build_shape_matrix+0
;tetris.c,654 :: 		draw_shape(1,13,23);
	MOVLW      1
	MOVWF      FARG_draw_shape_c+0
	MOVLW      13
	MOVWF      FARG_draw_shape_x+0
	MOVLW      23
	MOVWF      FARG_draw_shape_y+0
	CALL       _draw_shape+0
;tetris.c,661 :: 		if ( ! check_and_update_position(block_pos_x, block_pos_y, block_type_current, rotation) )  {
	MOVF       _block_pos_x+0, 0
	MOVWF      FARG_check_and_update_position_x+0
	MOVF       _block_pos_y+0, 0
	MOVWF      FARG_check_and_update_position_y+0
	MOVF       main_block_type_current_L0+0, 0
	MOVWF      FARG_check_and_update_position_type+0
	MOVF       _rotation+0, 0
	MOVWF      FARG_check_and_update_position_rot+0
	CALL       _check_and_update_position+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main175
;tetris.c,662 :: 		i=20;
	MOVLW      20
	MOVWF      main_i_L0+0
	MOVLW      0
	MOVWF      main_i_L0+1
;tetris.c,663 :: 		do {
L_main176:
;tetris.c,664 :: 		i--;
	MOVLW      1
	SUBWF      main_i_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       main_i_L0+1, 1
;tetris.c,665 :: 		destroy_row(i);
	MOVF       main_i_L0+0, 0
	MOVWF      FARG_destroy_row_row+0
	CALL       _destroy_row+0
;tetris.c,666 :: 		} while (i > 0);
	MOVF       main_i_L0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main251
	MOVF       main_i_L0+0, 0
	SUBLW      0
L__main251:
	BTFSS      STATUS+0, 0
	GOTO       L_main176
;tetris.c,668 :: 		game_over();
	CALL       _game_over+0
;tetris.c,669 :: 		mukke_stop();
	CALL       _mukke_stop+0
;tetris.c,671 :: 		if ( check_highscore() ) {
	CALL       _check_highscore+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main179
;tetris.c,672 :: 		show_highscore();
	CALL       _show_highscore+0
;tetris.c,673 :: 		}
L_main179:
;tetris.c,675 :: 		goto mostevilrestart
	GOTO       ___main_mostevilrestart
;tetris.c,676 :: 		}
L_main175:
;tetris.c,678 :: 		while (! round_finished) {
L_main180:
	MOVF       main_round_finished_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main181
;tetris.c,679 :: 		if (block_pos_y > 0) {
	MOVF       _block_pos_y+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_main182
;tetris.c,680 :: 		draw_shape(0, block_pos_x, block_pos_y);
	CLRF       FARG_draw_shape_c+0
	MOVF       _block_pos_x+0, 0
	MOVWF      FARG_draw_shape_x+0
	MOVF       _block_pos_y+0, 0
	MOVWF      FARG_draw_shape_y+0
	CALL       _draw_shape+0
;tetris.c,681 :: 		}
L_main182:
;tetris.c,682 :: 		draw_shape(1, block_pos_x, block_pos_y);
	MOVLW      1
	MOVWF      FARG_draw_shape_c+0
	MOVF       _block_pos_x+0, 0
	MOVWF      FARG_draw_shape_x+0
	MOVF       _block_pos_y+0, 0
	MOVWF      FARG_draw_shape_y+0
	CALL       _draw_shape+0
;tetris.c,684 :: 		for (i=0; i<(round_delay); i++) {
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
L_main183:
	MOVF       _round_delay+1, 0
	SUBWF      main_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main252
	MOVF       _round_delay+0, 0
	SUBWF      main_i_L0+0, 0
L__main252:
	BTFSC      STATUS+0, 0
	GOTO       L_main184
;tetris.c,686 :: 		if ( (PORTC & KEY3) && (! (key_flags & KEY3)) ) {
	BTFSS      PORTC+0, 5
	GOTO       L_main188
	BTFSC      _key_flags+0, 5
	GOTO       L_main188
L__main222:
;tetris.c,687 :: 		key_flags |= KEY3;
	BSF        _key_flags+0, 5
;tetris.c,688 :: 		draw_shape(0, block_pos_x, block_pos_y);
	CLRF       FARG_draw_shape_c+0
	MOVF       _block_pos_x+0, 0
	MOVWF      FARG_draw_shape_x+0
	MOVF       _block_pos_y+0, 0
	MOVWF      FARG_draw_shape_y+0
	CALL       _draw_shape+0
;tetris.c,689 :: 		check_and_update_position(block_pos_x, block_pos_y, block_type_current, (rotation + 1) % 4);
	MOVF       _block_pos_x+0, 0
	MOVWF      FARG_check_and_update_position_x+0
	MOVF       _block_pos_y+0, 0
	MOVWF      FARG_check_and_update_position_y+0
	MOVF       main_block_type_current_L0+0, 0
	MOVWF      FARG_check_and_update_position_type+0
	MOVF       _rotation+0, 0
	ADDLW      1
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      4
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_check_and_update_position_rot+0
	CALL       _check_and_update_position+0
;tetris.c,690 :: 		draw_shape(1, block_pos_x, block_pos_y);
	MOVLW      1
	MOVWF      FARG_draw_shape_c+0
	MOVF       _block_pos_x+0, 0
	MOVWF      FARG_draw_shape_x+0
	MOVF       _block_pos_y+0, 0
	MOVWF      FARG_draw_shape_y+0
	CALL       _draw_shape+0
;tetris.c,691 :: 		}
L_main188:
;tetris.c,693 :: 		if ( (PORTC & KEY1) && (! (key_flags & KEY1)) ) {
	BTFSS      PORTC+0, 7
	GOTO       L_main191
	BTFSC      _key_flags+0, 7
	GOTO       L_main191
L__main221:
;tetris.c,694 :: 		key_flags |= KEY1;
	BSF        _key_flags+0, 7
;tetris.c,695 :: 		draw_shape(0, block_pos_x, block_pos_y);
	CLRF       FARG_draw_shape_c+0
	MOVF       _block_pos_x+0, 0
	MOVWF      FARG_draw_shape_x+0
	MOVF       _block_pos_y+0, 0
	MOVWF      FARG_draw_shape_y+0
	CALL       _draw_shape+0
;tetris.c,696 :: 		check_and_update_position(block_pos_x - 1, block_pos_y, block_type_current, rotation);
	DECF       _block_pos_x+0, 0
	MOVWF      FARG_check_and_update_position_x+0
	MOVF       _block_pos_y+0, 0
	MOVWF      FARG_check_and_update_position_y+0
	MOVF       main_block_type_current_L0+0, 0
	MOVWF      FARG_check_and_update_position_type+0
	MOVF       _rotation+0, 0
	MOVWF      FARG_check_and_update_position_rot+0
	CALL       _check_and_update_position+0
;tetris.c,697 :: 		draw_shape(1, block_pos_x, block_pos_y);
	MOVLW      1
	MOVWF      FARG_draw_shape_c+0
	MOVF       _block_pos_x+0, 0
	MOVWF      FARG_draw_shape_x+0
	MOVF       _block_pos_y+0, 0
	MOVWF      FARG_draw_shape_y+0
	CALL       _draw_shape+0
;tetris.c,698 :: 		}
L_main191:
;tetris.c,700 :: 		if ( (PORTC & KEY2) && (! (key_flags & KEY2)) ) {
	BTFSS      PORTC+0, 6
	GOTO       L_main194
	BTFSC      _key_flags+0, 6
	GOTO       L_main194
L__main220:
;tetris.c,701 :: 		key_flags |= KEY2;
	BSF        _key_flags+0, 6
;tetris.c,702 :: 		draw_shape(0, block_pos_x, block_pos_y);
	CLRF       FARG_draw_shape_c+0
	MOVF       _block_pos_x+0, 0
	MOVWF      FARG_draw_shape_x+0
	MOVF       _block_pos_y+0, 0
	MOVWF      FARG_draw_shape_y+0
	CALL       _draw_shape+0
;tetris.c,703 :: 		check_and_update_position(block_pos_x + 1, block_pos_y, block_type_current, rotation);
	INCF       _block_pos_x+0, 0
	MOVWF      FARG_check_and_update_position_x+0
	MOVF       _block_pos_y+0, 0
	MOVWF      FARG_check_and_update_position_y+0
	MOVF       main_block_type_current_L0+0, 0
	MOVWF      FARG_check_and_update_position_type+0
	MOVF       _rotation+0, 0
	MOVWF      FARG_check_and_update_position_rot+0
	CALL       _check_and_update_position+0
;tetris.c,704 :: 		draw_shape(1, block_pos_x, block_pos_y);
	MOVLW      1
	MOVWF      FARG_draw_shape_c+0
	MOVF       _block_pos_x+0, 0
	MOVWF      FARG_draw_shape_x+0
	MOVF       _block_pos_y+0, 0
	MOVWF      FARG_draw_shape_y+0
	CALL       _draw_shape+0
;tetris.c,705 :: 		}
L_main194:
;tetris.c,708 :: 		if ( PORTC & KEY4 ) {
	BTFSS      PORTC+0, 4
	GOTO       L_main195
;tetris.c,709 :: 		random_seed = (random_seed + block_pos_y ) % 7;
	MOVF       _block_pos_y+0, 0
	ADDWF      main_random_seed_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      7
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      main_random_seed_L0+0
;tetris.c,710 :: 		if (i >= 100)
	MOVLW      0
	SUBWF      main_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main253
	MOVLW      100
	SUBWF      main_i_L0+0, 0
L__main253:
	BTFSS      STATUS+0, 0
	GOTO       L_main196
;tetris.c,711 :: 		continue;
	GOTO       L_main185
L_main196:
;tetris.c,712 :: 		} else {
	GOTO       L_main197
L_main195:
;tetris.c,713 :: 		if (PORTC & 0xf0) {
	MOVLW      240
	ANDWF      PORTC+0, 0
	MOVWF      R0+0
	BTFSC      STATUS+0, 2
	GOTO       L_main198
;tetris.c,714 :: 		random_seed = i % 7;
	MOVLW      7
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       main_i_L0+0, 0
	MOVWF      R0+0
	MOVF       main_i_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      main_random_seed_L0+0
;tetris.c,715 :: 		} else {
	GOTO       L_main199
L_main198:
;tetris.c,716 :: 		random_seed = (random_seed + block_pos_y ) % 7;
	MOVF       _block_pos_y+0, 0
	ADDWF      main_random_seed_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      7
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      main_random_seed_L0+0
;tetris.c,717 :: 		}
L_main199:
;tetris.c,718 :: 		}
L_main197:
;tetris.c,720 :: 		key_flags &= PORTC &0xf0;
	MOVLW      240
	ANDWF      PORTC+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	ANDWF      _key_flags+0, 1
;tetris.c,722 :: 		Delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_main200:
	DECFSZ     R13+0, 1
	GOTO       L_main200
	DECFSZ     R12+0, 1
	GOTO       L_main200
;tetris.c,723 :: 		}
L_main185:
;tetris.c,684 :: 		for (i=0; i<(round_delay); i++) {
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;tetris.c,723 :: 		}
	GOTO       L_main183
L_main184:
;tetris.c,726 :: 		draw_shape(0, block_pos_x, block_pos_y);
	CLRF       FARG_draw_shape_c+0
	MOVF       _block_pos_x+0, 0
	MOVWF      FARG_draw_shape_x+0
	MOVF       _block_pos_y+0, 0
	MOVWF      FARG_draw_shape_y+0
	CALL       _draw_shape+0
;tetris.c,727 :: 		if ( ! check_and_update_position(block_pos_x, block_pos_y + 1, block_type_current, rotation) ) {
	MOVF       _block_pos_x+0, 0
	MOVWF      FARG_check_and_update_position_x+0
	INCF       _block_pos_y+0, 0
	MOVWF      FARG_check_and_update_position_y+0
	MOVF       main_block_type_current_L0+0, 0
	MOVWF      FARG_check_and_update_position_type+0
	MOVF       _rotation+0, 0
	MOVWF      FARG_check_and_update_position_rot+0
	CALL       _check_and_update_position+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main201
;tetris.c,728 :: 		draw_shape(1, block_pos_x, block_pos_y);
	MOVLW      1
	MOVWF      FARG_draw_shape_c+0
	MOVF       _block_pos_x+0, 0
	MOVWF      FARG_draw_shape_x+0
	MOVF       _block_pos_y+0, 0
	MOVWF      FARG_draw_shape_y+0
	CALL       _draw_shape+0
;tetris.c,729 :: 		round_finished = 1;
	MOVLW      1
	MOVWF      main_round_finished_L0+0
;tetris.c,730 :: 		for (i=0; i < 5; i++) {
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
L_main202:
	MOVLW      0
	SUBWF      main_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main254
	MOVLW      5
	SUBWF      main_i_L0+0, 0
L__main254:
	BTFSC      STATUS+0, 0
	GOTO       L_main203
;tetris.c,731 :: 		tmp = (unsigned int)curr_shape_matrix[i] << block_pos_x;
	MOVF       main_i_L0+0, 0
	ADDLW      _curr_shape_matrix+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	MOVF       _block_pos_x+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      R4+0
	MOVF       R1+1, 0
	MOVWF      R4+1
	MOVF       R0+0, 0
L__main255:
	BTFSC      STATUS+0, 2
	GOTO       L__main256
	RLF        R4+0, 1
	RLF        R4+1, 1
	BCF        R4+0, 0
	ADDLW      255
	GOTO       L__main255
L__main256:
;tetris.c,732 :: 		playfield[i + (block_pos_y-2)] |=  ( tmp >> 2 );
	MOVLW      2
	SUBWF      _block_pos_y+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R0+0, 0
	ADDWF      main_i_L0+0, 0
	MOVWF      R2+0
	MOVF       main_i_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      R2+1
	MOVF       R2+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _playfield+0
	MOVWF      R3+0
	MOVF       R4+0, 0
	MOVWF      R0+0
	MOVF       R4+1, 0
	MOVWF      R0+1
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	MOVF       R3+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	IORWF      R0+0, 1
	INCF       FSR, 1
	MOVF       INDF+0, 0
	IORWF      R0+1, 1
	MOVF       R3+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;tetris.c,730 :: 		for (i=0; i < 5; i++) {
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;tetris.c,733 :: 		}
	GOTO       L_main202
L_main203:
;tetris.c,736 :: 		i=20;
	MOVLW      20
	MOVWF      main_i_L0+0
	MOVLW      0
	MOVWF      main_i_L0+1
;tetris.c,737 :: 		round_removed_rows = 0;
	CLRF       main_round_removed_rows_L0+0
;tetris.c,738 :: 		do {
L_main205:
;tetris.c,739 :: 		i--;
	MOVLW      1
	SUBWF      main_i_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       main_i_L0+1, 1
;tetris.c,740 :: 		if (playfield[i] >= 16383) {
	MOVF       main_i_L0+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _playfield+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R1+1
	MOVLW      63
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main257
	MOVLW      255
	SUBWF      R1+0, 0
L__main257:
	BTFSS      STATUS+0, 0
	GOTO       L_main208
;tetris.c,741 :: 		destroy_row(i);
	MOVF       main_i_L0+0, 0
	MOVWF      FARG_destroy_row_row+0
	CALL       _destroy_row+0
;tetris.c,742 :: 		lower_rows(0,i);
	CLRF       FARG_lower_rows_start+0
	MOVF       main_i_L0+0, 0
	MOVWF      FARG_lower_rows_end+0
	CALL       _lower_rows+0
;tetris.c,743 :: 		for (j=i; j>0; j--) {
	MOVF       main_i_L0+0, 0
	MOVWF      main_j_L0+0
	MOVF       main_i_L0+1, 0
	MOVWF      main_j_L0+1
L_main209:
	MOVF       main_j_L0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main258
	MOVF       main_j_L0+0, 0
	SUBLW      0
L__main258:
	BTFSC      STATUS+0, 0
	GOTO       L_main210
;tetris.c,744 :: 		playfield[j] = playfield[j-1];
	MOVF       main_j_L0+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _playfield+0
	MOVWF      R4+0
	MOVLW      1
	SUBWF      main_j_L0+0, 0
	MOVWF      R2+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      main_j_L0+1, 0
	MOVWF      R2+1
	MOVF       R2+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _playfield+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
	MOVF       R4+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;tetris.c,743 :: 		for (j=i; j>0; j--) {
	MOVLW      1
	SUBWF      main_j_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       main_j_L0+1, 1
;tetris.c,745 :: 		}
	GOTO       L_main209
L_main210:
;tetris.c,746 :: 		i++;
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;tetris.c,747 :: 		removed_rows++;
	INCF       _removed_rows+0, 1
	BTFSC      STATUS+0, 2
	INCF       _removed_rows+1, 1
;tetris.c,748 :: 		round_removed_rows++;
	INCF       main_round_removed_rows_L0+0, 1
;tetris.c,749 :: 		score += (20 * level) * round_removed_rows;
	MOVF       _level+0, 0
	MOVWF      R0+0
	MOVLW      20
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       main_round_removed_rows_L0+0, 0
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Mul_16x16_U+0
	MOVF       R0+0, 0
	ADDWF      _score+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _score+1, 1
;tetris.c,750 :: 		if (level < 10) {
	MOVLW      10
	SUBWF      _level+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main212
;tetris.c,751 :: 		if ((removed_rows % 10) == 0) {
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _removed_rows+0, 0
	MOVWF      R0+0
	MOVF       _removed_rows+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main259
	MOVLW      0
	XORWF      R0+0, 0
L__main259:
	BTFSS      STATUS+0, 2
	GOTO       L_main213
;tetris.c,752 :: 		level++;
	INCF       _level+0, 1
;tetris.c,753 :: 		round_delay -= 90;
	MOVLW      90
	SUBWF      _round_delay+0, 1
	BTFSS      STATUS+0, 0
	DECF       _round_delay+1, 1
;tetris.c,754 :: 		}
L_main213:
;tetris.c,755 :: 		}
L_main212:
;tetris.c,756 :: 		}
L_main208:
;tetris.c,758 :: 		} while (i > 0);
	MOVF       main_i_L0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main260
	MOVF       main_i_L0+0, 0
	SUBLW      0
L__main260:
	BTFSS      STATUS+0, 0
	GOTO       L_main205
;tetris.c,760 :: 		if (round_removed_rows > 0) {
	MOVF       main_round_removed_rows_L0+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_main214
;tetris.c,761 :: 		update_scoreboard();
	CALL       _update_scoreboard+0
;tetris.c,762 :: 		}
L_main214:
;tetris.c,764 :: 		} else {
	GOTO       L_main215
L_main201:
;tetris.c,765 :: 		draw_shape(1, block_pos_x, block_pos_y);
	MOVLW      1
	MOVWF      FARG_draw_shape_c+0
	MOVF       _block_pos_x+0, 0
	MOVWF      FARG_draw_shape_x+0
	MOVF       _block_pos_y+0, 0
	MOVWF      FARG_draw_shape_y+0
	CALL       _draw_shape+0
;tetris.c,766 :: 		}
L_main215:
;tetris.c,769 :: 		}
	GOTO       L_main180
L_main181:
;tetris.c,771 :: 		}
	GOTO       L_main173
;tetris.c,772 :: 		}
	GOTO       $+0
; end of _main
