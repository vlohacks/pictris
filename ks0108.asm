
_ks0108_enable:

;ks0108.c,11 :: 		void ks0108_enable(void)
;ks0108.c,15 :: 		PORT_CTL |= CTL_EN;
	BSF        PORTB+0, 4
;ks0108.c,17 :: 		asm nop;
	NOP
;ks0108.c,18 :: 		asm nop;
	NOP
;ks0108.c,19 :: 		asm nop;
	NOP
;ks0108.c,20 :: 		asm nop;
	NOP
;ks0108.c,22 :: 		PORT_CTL &= ~CTL_EN;
	BCF        PORTB+0, 4
;ks0108.c,25 :: 		asm nop;
	NOP
;ks0108.c,26 :: 		asm nop;
	NOP
;ks0108.c,27 :: 		asm nop;
	NOP
;ks0108.c,28 :: 		asm nop;
	NOP
;ks0108.c,30 :: 		}
	RETURN
; end of _ks0108_enable

_ks0108_init:

;ks0108.c,33 :: 		void ks0108_init(void)
;ks0108.c,36 :: 		ks0108_x = 0;
	CLRF       _ks0108_x+0
;ks0108.c,37 :: 		ks0108_y = 0;
	CLRF       _ks0108_y+0
;ks0108.c,38 :: 		ks0108_page = 0;
	CLRF       _ks0108_page+0
;ks0108.c,41 :: 		REG_DATA = 0xff;
	MOVLW      255
	MOVWF      TRISD+0
;ks0108.c,44 :: 		REG_CTL = 0x00;
	CLRF       TRISB+0
;ks0108.c,47 :: 		PORT_CTL = CTL_RST;
	MOVLW      32
	MOVWF      PORTB+0
;ks0108.c,50 :: 		ks0108_command(CMD_ON, KS0108_CONTROLLER0);
	MOVLW      63
	MOVWF      FARG_ks0108_command+0
	CLRF       FARG_ks0108_command+0
	CALL       _ks0108_command+0
;ks0108.c,51 :: 		ks0108_command(CMD_ON, KS0108_CONTROLLER1);
	MOVLW      63
	MOVWF      FARG_ks0108_command+0
	MOVLW      1
	MOVWF      FARG_ks0108_command+0
	CALL       _ks0108_command+0
;ks0108.c,54 :: 		ks0108_command(CMD_DISP_START, KS0108_CONTROLLER0);
	MOVLW      192
	MOVWF      FARG_ks0108_command+0
	CLRF       FARG_ks0108_command+0
	CALL       _ks0108_command+0
;ks0108.c,55 :: 		ks0108_command(CMD_DISP_START, KS0108_CONTROLLER1);
	MOVLW      192
	MOVWF      FARG_ks0108_command+0
	MOVLW      1
	MOVWF      FARG_ks0108_command+0
	CALL       _ks0108_command+0
;ks0108.c,57 :: 		}
	RETURN
; end of _ks0108_init

_ks0108_fill:

;ks0108.c,60 :: 		void ks0108_fill(unsigned char pattern)
;ks0108.c,63 :: 		for (i=0; i<8; i++) {
	CLRF       ks0108_fill_i_L0+0
L_ks0108_fill0:
	MOVLW      8
	SUBWF      ks0108_fill_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_ks0108_fill1
;ks0108.c,64 :: 		ks0108_locate(0, i<<3);
	CLRF       FARG_ks0108_locate+0
	MOVF       ks0108_fill_i_L0+0, 0
	MOVWF      FARG_ks0108_locate+0
	RLF        FARG_ks0108_locate+0, 1
	BCF        FARG_ks0108_locate+0, 0
	RLF        FARG_ks0108_locate+0, 1
	BCF        FARG_ks0108_locate+0, 0
	RLF        FARG_ks0108_locate+0, 1
	BCF        FARG_ks0108_locate+0, 0
	CALL       _ks0108_locate+0
;ks0108.c,65 :: 		for (j=0; j<128; j++)
	CLRF       ks0108_fill_j_L0+0
L_ks0108_fill3:
	MOVLW      128
	SUBWF      ks0108_fill_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_ks0108_fill4
;ks0108.c,66 :: 		ks0108_data_write(pattern);
	MOVF       FARG_ks0108_fill_pattern+0, 0
	MOVWF      FARG_ks0108_data_write+0
	CALL       _ks0108_data_write+0
;ks0108.c,65 :: 		for (j=0; j<128; j++)
	INCF       ks0108_fill_j_L0+0, 1
;ks0108.c,66 :: 		ks0108_data_write(pattern);
	GOTO       L_ks0108_fill3
L_ks0108_fill4:
;ks0108.c,63 :: 		for (i=0; i<8; i++) {
	INCF       ks0108_fill_i_L0+0, 1
;ks0108.c,68 :: 		}
	GOTO       L_ks0108_fill0
L_ks0108_fill1:
;ks0108.c,69 :: 		}
	RETURN
; end of _ks0108_fill

_ks0108_locate:

;ks0108.c,72 :: 		void ks0108_locate(unsigned short x, unsigned short y)
;ks0108.c,76 :: 		ks0108_x = x;
	MOVF       FARG_ks0108_locate_x+0, 0
	MOVWF      _ks0108_x+0
;ks0108.c,77 :: 		ks0108_y = y;
	MOVF       FARG_ks0108_locate_y+0, 0
	MOVWF      _ks0108_y+0
;ks0108.c,80 :: 		ks0108_page = (y >> 3);
	MOVF       FARG_ks0108_locate_y+0, 0
	MOVWF      _ks0108_page+0
	RRF        _ks0108_page+0, 1
	BCF        _ks0108_page+0, 7
	RRF        _ks0108_page+0, 1
	BCF        _ks0108_page+0, 7
	RRF        _ks0108_page+0, 1
	BCF        _ks0108_page+0, 7
;ks0108.c,83 :: 		if (x >= 64) {
	MOVLW      64
	SUBWF      FARG_ks0108_locate_x+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_ks0108_locate6
;ks0108.c,84 :: 		controller = KS0108_CONTROLLER1;
	MOVLW      1
	MOVWF      ks0108_locate_controller_L0+0
;ks0108.c,85 :: 		x -= 64;
	MOVLW      64
	SUBWF      FARG_ks0108_locate_x+0, 1
;ks0108.c,86 :: 		} else {
	GOTO       L_ks0108_locate7
L_ks0108_locate6:
;ks0108.c,87 :: 		controller = KS0108_CONTROLLER0;
	CLRF       ks0108_locate_controller_L0+0
;ks0108.c,88 :: 		}
L_ks0108_locate7:
;ks0108.c,91 :: 		ks0108_command(CMD_SET_PAGE | ks0108_page, KS0108_CONTROLLER0);
	MOVLW      184
	IORWF      _ks0108_page+0, 0
	MOVWF      FARG_ks0108_command+0
	CLRF       FARG_ks0108_command+0
	CALL       _ks0108_command+0
;ks0108.c,92 :: 		ks0108_command(CMD_SET_PAGE | ks0108_page, KS0108_CONTROLLER1);
	MOVLW      184
	IORWF      _ks0108_page+0, 0
	MOVWF      FARG_ks0108_command+0
	MOVLW      1
	MOVWF      FARG_ks0108_command+0
	CALL       _ks0108_command+0
;ks0108.c,95 :: 		ks0108_command(CMD_SET_ADD | x, controller);
	MOVLW      64
	IORWF      FARG_ks0108_locate_x+0, 0
	MOVWF      FARG_ks0108_command+0
	MOVF       ks0108_locate_controller_L0+0, 0
	MOVWF      FARG_ks0108_command+0
	CALL       _ks0108_command+0
;ks0108.c,98 :: 		}
	RETURN
; end of _ks0108_locate

_ks0108_command:

;ks0108.c,101 :: 		void ks0108_command(unsigned char cmd, unsigned char controller)
;ks0108.c,104 :: 		PORT_CTL = CTL_RST;
	MOVLW      32
	MOVWF      PORTB+0
;ks0108.c,107 :: 		if (controller == KS0108_CONTROLLER0) {
	MOVF       FARG_ks0108_command_controller+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_ks0108_command8
;ks0108.c,108 :: 		PORT_CTL |= CTL_C0;
	BSF        PORTB+0, 1
;ks0108.c,109 :: 		} else {
	GOTO       L_ks0108_command9
L_ks0108_command8:
;ks0108.c,110 :: 		PORT_CTL |= CTL_C1;
	BSF        PORTB+0, 0
;ks0108.c,111 :: 		}
L_ks0108_command9:
;ks0108.c,114 :: 		REG_DATA = 0x00;
	CLRF       TRISD+0
;ks0108.c,115 :: 		PORT_DATA = cmd;
	MOVF       FARG_ks0108_command_cmd+0, 0
	MOVWF      PORTD+0
;ks0108.c,118 :: 		ks0108_enable();
	CALL       _ks0108_enable+0
;ks0108.c,119 :: 		}
	RETURN
; end of _ks0108_command

_ks0108_pset:

;ks0108.c,122 :: 		void ks0108_pset(unsigned short x, unsigned short y, unsigned short c)
;ks0108.c,126 :: 		ks0108_locate(x,y);
	MOVF       FARG_ks0108_pset_x+0, 0
	MOVWF      FARG_ks0108_locate_x+0
	MOVF       FARG_ks0108_pset_y+0, 0
	MOVWF      FARG_ks0108_locate_y+0
	CALL       _ks0108_locate+0
;ks0108.c,129 :: 		ks0108_data_read();
	CALL       _ks0108_data_read+0
;ks0108.c,130 :: 		display_data = ks0108_data_read();
	CALL       _ks0108_data_read+0
	MOVF       R0+0, 0
	MOVWF      ks0108_pset_display_data_L0+0
;ks0108.c,133 :: 		if (c)
	MOVF       FARG_ks0108_pset_c+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_ks0108_pset10
;ks0108.c,134 :: 		display_data |= 1 << (y % 8);
	MOVLW      7
	ANDWF      FARG_ks0108_pset_y+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__ks0108_pset51:
	BTFSC      STATUS+0, 2
	GOTO       L__ks0108_pset52
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__ks0108_pset51
L__ks0108_pset52:
	MOVF       R0+0, 0
	IORWF      ks0108_pset_display_data_L0+0, 1
	GOTO       L_ks0108_pset11
L_ks0108_pset10:
;ks0108.c,136 :: 		display_data &= ~(1 << (y % 8));
	MOVLW      7
	ANDWF      FARG_ks0108_pset_y+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__ks0108_pset53:
	BTFSC      STATUS+0, 2
	GOTO       L__ks0108_pset54
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__ks0108_pset53
L__ks0108_pset54:
	COMF       R0+0, 1
	MOVF       R0+0, 0
	ANDWF      ks0108_pset_display_data_L0+0, 1
L_ks0108_pset11:
;ks0108.c,139 :: 		ks0108_data_write(display_data);
	MOVF       ks0108_pset_display_data_L0+0, 0
	MOVWF      FARG_ks0108_data_write+0
	CALL       _ks0108_data_write+0
;ks0108.c,140 :: 		}
	RETURN
; end of _ks0108_pset

_ks0108_rect:

;ks0108.c,144 :: 		void ks0108_rect(unsigned short x, unsigned short y, unsigned short width, unsigned short height, unsigned short c)
;ks0108.c,148 :: 		for (j=y; j<y+height;j++) {
	MOVF       FARG_ks0108_rect_y+0, 0
	MOVWF      ks0108_rect_j_L0+0
L_ks0108_rect12:
	MOVF       FARG_ks0108_rect_height+0, 0
	ADDWF      FARG_ks0108_rect_y+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__ks0108_rect55
	MOVF       R1+0, 0
	SUBWF      ks0108_rect_j_L0+0, 0
L__ks0108_rect55:
	BTFSC      STATUS+0, 0
	GOTO       L_ks0108_rect13
;ks0108.c,150 :: 		if ( (j==y) || (j==(y+(height-1))) ) {
	MOVF       ks0108_rect_j_L0+0, 0
	XORWF      FARG_ks0108_rect_y+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__ks0108_rect50
	MOVLW      1
	SUBWF      FARG_ks0108_rect_height+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R0+0, 0
	ADDWF      FARG_ks0108_rect_y+0, 0
	MOVWF      R2+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      R2+1
	MOVLW      0
	XORWF      R2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__ks0108_rect56
	MOVF       R2+0, 0
	XORWF      ks0108_rect_j_L0+0, 0
L__ks0108_rect56:
	BTFSC      STATUS+0, 2
	GOTO       L__ks0108_rect50
	GOTO       L_ks0108_rect17
L__ks0108_rect50:
;ks0108.c,152 :: 		for (i=x; i<x+width;i++) {
	MOVF       FARG_ks0108_rect_x+0, 0
	MOVWF      ks0108_rect_i_L0+0
L_ks0108_rect18:
	MOVF       FARG_ks0108_rect_width+0, 0
	ADDWF      FARG_ks0108_rect_x+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__ks0108_rect57
	MOVF       R1+0, 0
	SUBWF      ks0108_rect_i_L0+0, 0
L__ks0108_rect57:
	BTFSC      STATUS+0, 0
	GOTO       L_ks0108_rect19
;ks0108.c,153 :: 		ks0108_pset(i, j, c);
	MOVF       ks0108_rect_i_L0+0, 0
	MOVWF      FARG_ks0108_pset_x+0
	MOVF       ks0108_rect_j_L0+0, 0
	MOVWF      FARG_ks0108_pset_y+0
	MOVF       FARG_ks0108_rect_c+0, 0
	MOVWF      FARG_ks0108_pset_c+0
	CALL       _ks0108_pset+0
;ks0108.c,152 :: 		for (i=x; i<x+width;i++) {
	INCF       ks0108_rect_i_L0+0, 1
;ks0108.c,154 :: 		}
	GOTO       L_ks0108_rect18
L_ks0108_rect19:
;ks0108.c,155 :: 		} else {
	GOTO       L_ks0108_rect21
L_ks0108_rect17:
;ks0108.c,157 :: 		ks0108_pset(x,j,c);
	MOVF       FARG_ks0108_rect_x+0, 0
	MOVWF      FARG_ks0108_pset_x+0
	MOVF       ks0108_rect_j_L0+0, 0
	MOVWF      FARG_ks0108_pset_y+0
	MOVF       FARG_ks0108_rect_c+0, 0
	MOVWF      FARG_ks0108_pset_c+0
	CALL       _ks0108_pset+0
;ks0108.c,158 :: 		ks0108_pset(x+(width-1),j,c);
	DECF       FARG_ks0108_rect_width+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	ADDWF      FARG_ks0108_rect_x+0, 0
	MOVWF      FARG_ks0108_pset_x+0
	MOVF       ks0108_rect_j_L0+0, 0
	MOVWF      FARG_ks0108_pset_y+0
	MOVF       FARG_ks0108_rect_c+0, 0
	MOVWF      FARG_ks0108_pset_c+0
	CALL       _ks0108_pset+0
;ks0108.c,159 :: 		}
L_ks0108_rect21:
;ks0108.c,148 :: 		for (j=y; j<y+height;j++) {
	INCF       ks0108_rect_j_L0+0, 1
;ks0108.c,160 :: 		}
	GOTO       L_ks0108_rect12
L_ks0108_rect13:
;ks0108.c,162 :: 		}
	RETURN
; end of _ks0108_rect

_ks0108_char:

;ks0108.c,206 :: 		void ks0108_char(unsigned short x, unsigned short y, unsigned char c, unsigned char invert)
;ks0108.c,212 :: 		j = c * 5;
	MOVF       FARG_ks0108_char_c+0, 0
	MOVWF      R0+0
	MOVLW      5
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      ks0108_char_j_L0+0
	MOVF       R0+1, 0
	MOVWF      ks0108_char_j_L0+1
;ks0108.c,213 :: 		ks0108_locate(x,y);
	MOVF       FARG_ks0108_char_x+0, 0
	MOVWF      FARG_ks0108_locate_x+0
	MOVF       FARG_ks0108_char_y+0, 0
	MOVWF      FARG_ks0108_locate_y+0
	CALL       _ks0108_locate+0
;ks0108.c,214 :: 		for (i=0;i<5;i++) {
	CLRF       ks0108_char_i_L0+0
L_ks0108_char22:
	MOVLW      5
	SUBWF      ks0108_char_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_ks0108_char23
;ks0108.c,215 :: 		ks0108_data_read();
	CALL       _ks0108_data_read+0
;ks0108.c,216 :: 		d = ks0108_data_read();
	CALL       _ks0108_data_read+0
	MOVF       R0+0, 0
	MOVWF      ks0108_char_d_L0+0
;ks0108.c,217 :: 		d = (font5x7[j] << (y % 8));
	MOVF       ks0108_char_j_L0+0, 0
	ADDLW      ks0108_font5x7+0
	MOVWF      R0+0
	MOVLW      hi_addr(ks0108_font5x7+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      ks0108_char_j_L0+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R1+0
	MOVLW      7
	ANDWF      FARG_ks0108_char_y+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      ks0108_char_d_L0+0
	MOVF       R0+0, 0
L__ks0108_char58:
	BTFSC      STATUS+0, 2
	GOTO       L__ks0108_char59
	RLF        ks0108_char_d_L0+0, 1
	BCF        ks0108_char_d_L0+0, 0
	ADDLW      255
	GOTO       L__ks0108_char58
L__ks0108_char59:
;ks0108.c,218 :: 		if (invert)
	MOVF       FARG_ks0108_char_invert+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_ks0108_char25
;ks0108.c,219 :: 		d = ~d;
	COMF       ks0108_char_d_L0+0, 1
L_ks0108_char25:
;ks0108.c,220 :: 		ks0108_data_write(d);
	MOVF       ks0108_char_d_L0+0, 0
	MOVWF      FARG_ks0108_data_write+0
	CALL       _ks0108_data_write+0
;ks0108.c,221 :: 		j++;
	INCF       ks0108_char_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       ks0108_char_j_L0+1, 1
;ks0108.c,214 :: 		for (i=0;i<5;i++) {
	INCF       ks0108_char_i_L0+0, 1
;ks0108.c,222 :: 		}
	GOTO       L_ks0108_char22
L_ks0108_char23:
;ks0108.c,223 :: 		}
	RETURN
; end of _ks0108_char

_ks0108_char_portrait:

;ks0108.c,225 :: 		void ks0108_char_portrait(unsigned short x, unsigned short y, unsigned short c, unsigned char invert)
;ks0108.c,230 :: 		j = (c * 5) + 4;
	MOVF       FARG_ks0108_char_portrait_c+0, 0
	MOVWF      R0+0
	MOVLW      5
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVLW      4
	ADDWF      R0+0, 0
	MOVWF      ks0108_char_portrait_j_L0+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      ks0108_char_portrait_j_L0+1
;ks0108.c,231 :: 		for (i=0;i<5;i++) {
	CLRF       ks0108_char_portrait_i_L0+0
L_ks0108_char_portrait26:
	MOVLW      5
	SUBWF      ks0108_char_portrait_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_ks0108_char_portrait27
;ks0108.c,235 :: 		d = (font5x7[j]);
	MOVF       ks0108_char_portrait_j_L0+0, 0
	ADDLW      ks0108_font5x7+0
	MOVWF      R0+0
	MOVLW      hi_addr(ks0108_font5x7+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      ks0108_char_portrait_j_L0+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      ks0108_char_portrait_d_L0+0
;ks0108.c,236 :: 		if (invert)
	MOVF       FARG_ks0108_char_portrait_invert+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_ks0108_char_portrait29
;ks0108.c,237 :: 		d = ~d;
	COMF       ks0108_char_portrait_d_L0+0, 1
L_ks0108_char_portrait29:
;ks0108.c,239 :: 		ks0108_locate(x,y);
	MOVF       FARG_ks0108_char_portrait_x+0, 0
	MOVWF      FARG_ks0108_locate_x+0
	MOVF       FARG_ks0108_char_portrait_y+0, 0
	MOVWF      FARG_ks0108_locate_y+0
	CALL       _ks0108_locate+0
;ks0108.c,240 :: 		for (k=0; k<7; k++) {
	CLRF       ks0108_char_portrait_k_L0+0
L_ks0108_char_portrait30:
	MOVLW      7
	SUBWF      ks0108_char_portrait_k_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_ks0108_char_portrait31
;ks0108.c,241 :: 		ks0108_data_read();
	CALL       _ks0108_data_read+0
;ks0108.c,242 :: 		e = ks0108_data_read();
	CALL       _ks0108_data_read+0
	MOVF       R0+0, 0
	MOVWF      ks0108_char_portrait_e_L0+0
;ks0108.c,243 :: 		f = ((d & (1<<k)) >> k) << (i + (y % 8));
	MOVF       ks0108_char_portrait_k_L0+0, 0
	MOVWF      R2+0
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__ks0108_char_portrait60:
	BTFSC      STATUS+0, 2
	GOTO       L__ks0108_char_portrait61
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__ks0108_char_portrait60
L__ks0108_char_portrait61:
	MOVF       R0+0, 0
	ANDWF      ks0108_char_portrait_d_L0+0, 0
	MOVWF      R3+0
	MOVLW      0
	ANDWF      R0+1, 0
	MOVWF      R3+1
	MOVF       ks0108_char_portrait_k_L0+0, 0
	MOVWF      R0+0
	MOVF       R3+0, 0
	MOVWF      R1+0
	MOVF       R3+1, 0
	MOVWF      R1+1
	MOVF       R0+0, 0
L__ks0108_char_portrait62:
	BTFSC      STATUS+0, 2
	GOTO       L__ks0108_char_portrait63
	RRF        R1+1, 1
	RRF        R1+0, 1
	BCF        R1+1, 7
	BTFSC      R1+1, 6
	BSF        R1+1, 7
	ADDLW      255
	GOTO       L__ks0108_char_portrait62
L__ks0108_char_portrait63:
	MOVLW      7
	ANDWF      FARG_ks0108_char_portrait_y+0, 0
	MOVWF      R0+0
	MOVF       ks0108_char_portrait_i_L0+0, 0
	ADDWF      R0+0, 1
	MOVF       R1+0, 0
	MOVWF      ks0108_char_portrait_f_L0+0
	MOVF       R0+0, 0
L__ks0108_char_portrait64:
	BTFSC      STATUS+0, 2
	GOTO       L__ks0108_char_portrait65
	RLF        ks0108_char_portrait_f_L0+0, 1
	BCF        ks0108_char_portrait_f_L0+0, 0
	ADDLW      255
	GOTO       L__ks0108_char_portrait64
L__ks0108_char_portrait65:
;ks0108.c,244 :: 		if (i == 0)
	MOVF       ks0108_char_portrait_i_L0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_ks0108_char_portrait33
;ks0108.c,245 :: 		e = f;
	MOVF       ks0108_char_portrait_f_L0+0, 0
	MOVWF      ks0108_char_portrait_e_L0+0
	GOTO       L_ks0108_char_portrait34
L_ks0108_char_portrait33:
;ks0108.c,247 :: 		e |= f;
	MOVF       ks0108_char_portrait_f_L0+0, 0
	IORWF      ks0108_char_portrait_e_L0+0, 1
L_ks0108_char_portrait34:
;ks0108.c,248 :: 		ks0108_data_write(e);
	MOVF       ks0108_char_portrait_e_L0+0, 0
	MOVWF      FARG_ks0108_data_write+0
	CALL       _ks0108_data_write+0
;ks0108.c,240 :: 		for (k=0; k<7; k++) {
	INCF       ks0108_char_portrait_k_L0+0, 1
;ks0108.c,249 :: 		}
	GOTO       L_ks0108_char_portrait30
L_ks0108_char_portrait31:
;ks0108.c,252 :: 		if (y % 8) {
	MOVLW      7
	ANDWF      FARG_ks0108_char_portrait_y+0, 0
	MOVWF      R0+0
	BTFSC      STATUS+0, 2
	GOTO       L_ks0108_char_portrait35
;ks0108.c,253 :: 		ks0108_locate(x,y+8);
	MOVF       FARG_ks0108_char_portrait_x+0, 0
	MOVWF      FARG_ks0108_locate_x+0
	MOVLW      8
	ADDWF      FARG_ks0108_char_portrait_y+0, 0
	MOVWF      FARG_ks0108_locate_y+0
	CALL       _ks0108_locate+0
;ks0108.c,254 :: 		for (k=0; k<7; k++) {
	CLRF       ks0108_char_portrait_k_L0+0
L_ks0108_char_portrait36:
	MOVLW      7
	SUBWF      ks0108_char_portrait_k_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_ks0108_char_portrait37
;ks0108.c,255 :: 		ks0108_data_read();
	CALL       _ks0108_data_read+0
;ks0108.c,256 :: 		e = ks0108_data_read();
	CALL       _ks0108_data_read+0
	MOVF       R0+0, 0
	MOVWF      ks0108_char_portrait_e_L0+0
;ks0108.c,257 :: 		e |=  (((d & (1<<k)) >> k) << i) >> (8 - (y % 8));
	MOVF       ks0108_char_portrait_k_L0+0, 0
	MOVWF      R3+0
	MOVLW      1
	MOVWF      R1+0
	MOVLW      0
	MOVWF      R1+1
	MOVF       R3+0, 0
L__ks0108_char_portrait66:
	BTFSC      STATUS+0, 2
	GOTO       L__ks0108_char_portrait67
	RLF        R1+0, 1
	RLF        R1+1, 1
	BCF        R1+0, 0
	ADDLW      255
	GOTO       L__ks0108_char_portrait66
L__ks0108_char_portrait67:
	MOVF       R1+0, 0
	ANDWF      ks0108_char_portrait_d_L0+0, 0
	MOVWF      R4+0
	MOVLW      0
	ANDWF      R1+1, 0
	MOVWF      R4+1
	MOVF       ks0108_char_portrait_k_L0+0, 0
	MOVWF      R1+0
	MOVF       R4+0, 0
	MOVWF      R2+0
	MOVF       R4+1, 0
	MOVWF      R2+1
	MOVF       R1+0, 0
L__ks0108_char_portrait68:
	BTFSC      STATUS+0, 2
	GOTO       L__ks0108_char_portrait69
	RRF        R2+1, 1
	RRF        R2+0, 1
	BCF        R2+1, 7
	BTFSC      R2+1, 6
	BSF        R2+1, 7
	ADDLW      255
	GOTO       L__ks0108_char_portrait68
L__ks0108_char_portrait69:
	MOVF       ks0108_char_portrait_i_L0+0, 0
	MOVWF      R1+0
	MOVF       R2+0, 0
	MOVWF      R4+0
	MOVF       R2+1, 0
	MOVWF      R4+1
	MOVF       R1+0, 0
L__ks0108_char_portrait70:
	BTFSC      STATUS+0, 2
	GOTO       L__ks0108_char_portrait71
	RLF        R4+0, 1
	RLF        R4+1, 1
	BCF        R4+0, 0
	ADDLW      255
	GOTO       L__ks0108_char_portrait70
L__ks0108_char_portrait71:
	MOVLW      7
	ANDWF      FARG_ks0108_char_portrait_y+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	SUBLW      8
	MOVWF      R1+0
	CLRF       R1+1
	BTFSS      STATUS+0, 0
	DECF       R1+1, 1
	MOVF       R1+0, 0
	MOVWF      R3+0
	MOVF       R4+0, 0
	MOVWF      R1+0
	MOVF       R4+1, 0
	MOVWF      R1+1
	MOVF       R3+0, 0
L__ks0108_char_portrait72:
	BTFSC      STATUS+0, 2
	GOTO       L__ks0108_char_portrait73
	RRF        R1+1, 1
	RRF        R1+0, 1
	BCF        R1+1, 7
	BTFSC      R1+1, 6
	BSF        R1+1, 7
	ADDLW      255
	GOTO       L__ks0108_char_portrait72
L__ks0108_char_portrait73:
	MOVF       R1+0, 0
	IORWF      R0+0, 1
	MOVF       R0+0, 0
	MOVWF      ks0108_char_portrait_e_L0+0
;ks0108.c,258 :: 		ks0108_data_write(e);
	MOVF       R0+0, 0
	MOVWF      FARG_ks0108_data_write+0
	CALL       _ks0108_data_write+0
;ks0108.c,254 :: 		for (k=0; k<7; k++) {
	INCF       ks0108_char_portrait_k_L0+0, 1
;ks0108.c,259 :: 		}
	GOTO       L_ks0108_char_portrait36
L_ks0108_char_portrait37:
;ks0108.c,260 :: 		}
L_ks0108_char_portrait35:
;ks0108.c,263 :: 		j--;
	MOVLW      1
	SUBWF      ks0108_char_portrait_j_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       ks0108_char_portrait_j_L0+1, 1
;ks0108.c,231 :: 		for (i=0;i<5;i++) {
	INCF       ks0108_char_portrait_i_L0+0, 1
;ks0108.c,264 :: 		}
	GOTO       L_ks0108_char_portrait26
L_ks0108_char_portrait27:
;ks0108.c,265 :: 		}
	RETURN
; end of _ks0108_char_portrait

_ks0108_title:

;ks0108.c,267 :: 		void ks0108_title(unsigned short width, unsigned short hpages)
;ks0108.c,271 :: 		k=0;
	CLRF       ks0108_title_k_L0+0
	CLRF       ks0108_title_k_L0+1
;ks0108.c,272 :: 		for (i=0; i<hpages; i++) {
	CLRF       ks0108_title_i_L0+0
	CLRF       ks0108_title_i_L0+1
L_ks0108_title39:
	MOVLW      128
	XORWF      ks0108_title_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__ks0108_title74
	MOVF       FARG_ks0108_title_hpages+0, 0
	SUBWF      ks0108_title_i_L0+0, 0
L__ks0108_title74:
	BTFSC      STATUS+0, 0
	GOTO       L_ks0108_title40
;ks0108.c,273 :: 		ks0108_locate(0,i<<3);
	CLRF       FARG_ks0108_locate_x+0
	MOVLW      3
	MOVWF      R0+0
	MOVF       ks0108_title_i_L0+0, 0
	MOVWF      FARG_ks0108_locate_y+0
	MOVF       R0+0, 0
L__ks0108_title75:
	BTFSC      STATUS+0, 2
	GOTO       L__ks0108_title76
	RLF        FARG_ks0108_locate_y+0, 1
	BCF        FARG_ks0108_locate_y+0, 0
	ADDLW      255
	GOTO       L__ks0108_title75
L__ks0108_title76:
	CALL       _ks0108_locate+0
;ks0108.c,274 :: 		for (j=0;j<width;j++) {
	CLRF       ks0108_title_j_L0+0
	CLRF       ks0108_title_j_L0+1
L_ks0108_title42:
	MOVLW      128
	XORWF      ks0108_title_j_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__ks0108_title77
	MOVF       FARG_ks0108_title_width+0, 0
	SUBWF      ks0108_title_j_L0+0, 0
L__ks0108_title77:
	BTFSC      STATUS+0, 0
	GOTO       L_ks0108_title43
;ks0108.c,275 :: 		if (j==64)
	MOVLW      0
	XORWF      ks0108_title_j_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__ks0108_title78
	MOVLW      64
	XORWF      ks0108_title_j_L0+0, 0
L__ks0108_title78:
	BTFSS      STATUS+0, 2
	GOTO       L_ks0108_title45
;ks0108.c,276 :: 		ks0108_locate(j,i<<3);
	MOVF       ks0108_title_j_L0+0, 0
	MOVWF      FARG_ks0108_locate_x+0
	MOVLW      3
	MOVWF      R0+0
	MOVF       ks0108_title_i_L0+0, 0
	MOVWF      FARG_ks0108_locate_y+0
	MOVF       R0+0, 0
L__ks0108_title79:
	BTFSC      STATUS+0, 2
	GOTO       L__ks0108_title80
	RLF        FARG_ks0108_locate_y+0, 1
	BCF        FARG_ks0108_locate_y+0, 0
	ADDLW      255
	GOTO       L__ks0108_title79
L__ks0108_title80:
	CALL       _ks0108_locate+0
L_ks0108_title45:
;ks0108.c,277 :: 		ks0108_data_write(title_bitmap[k++]);
	MOVF       ks0108_title_k_L0+0, 0
	ADDLW      ks0108_title_bitmap+0
	MOVWF      R0+0
	MOVLW      hi_addr(ks0108_title_bitmap+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      ks0108_title_k_L0+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_ks0108_data_write+0
	CALL       _ks0108_data_write+0
	INCF       ks0108_title_k_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       ks0108_title_k_L0+1, 1
;ks0108.c,274 :: 		for (j=0;j<width;j++) {
	INCF       ks0108_title_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       ks0108_title_j_L0+1, 1
;ks0108.c,278 :: 		}
	GOTO       L_ks0108_title42
L_ks0108_title43:
;ks0108.c,272 :: 		for (i=0; i<hpages; i++) {
	INCF       ks0108_title_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       ks0108_title_i_L0+1, 1
;ks0108.c,279 :: 		}
	GOTO       L_ks0108_title39
L_ks0108_title40:
;ks0108.c,280 :: 		}
	RETURN
; end of _ks0108_title

_ks0108_data_read:

;ks0108.c,283 :: 		unsigned char ks0108_data_read()
;ks0108.c,289 :: 		PORT_DATA = 0x00;
	CLRF       PORTD+0
;ks0108.c,290 :: 		REG_DATA = 0xff;
	MOVLW      255
	MOVWF      TRISD+0
;ks0108.c,293 :: 		PORT_CTL = CTL_RST;
	MOVLW      32
	MOVWF      PORTB+0
;ks0108.c,296 :: 		if (ks0108_x >= 64) {
	MOVLW      64
	SUBWF      _ks0108_x+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_ks0108_data_read46
;ks0108.c,297 :: 		PORT_CTL |= CTL_C1;
	BSF        PORTB+0, 0
;ks0108.c,298 :: 		} else {
	GOTO       L_ks0108_data_read47
L_ks0108_data_read46:
;ks0108.c,299 :: 		PORT_CTL |= CTL_C0;
	BSF        PORTB+0, 1
;ks0108.c,300 :: 		}
L_ks0108_data_read47:
;ks0108.c,303 :: 		PORT_CTL |= CTL_DI;
	BSF        PORTB+0, 2
;ks0108.c,304 :: 		PORT_CTL |= CTL_RW;
	BSF        PORTB+0, 3
;ks0108.c,307 :: 		PORT_CTL |= CTL_EN;
	BSF        PORTB+0, 4
;ks0108.c,308 :: 		asm nop;
	NOP
;ks0108.c,309 :: 		asm nop;
	NOP
;ks0108.c,310 :: 		asm nop;
	NOP
;ks0108.c,311 :: 		asm nop;
	NOP
;ks0108.c,314 :: 		display_data = PORT_DATA;
	MOVF       PORTD+0, 0
	MOVWF      ks0108_data_read_display_data_L0+0
;ks0108.c,317 :: 		PORT_CTL &= ~CTL_EN;
	BCF        PORTB+0, 4
;ks0108.c,318 :: 		asm nop;
	NOP
;ks0108.c,319 :: 		asm nop;
	NOP
;ks0108.c,320 :: 		asm nop;
	NOP
;ks0108.c,321 :: 		asm nop;
	NOP
;ks0108.c,324 :: 		ks0108_locate(ks0108_x, ks0108_y);
	MOVF       _ks0108_x+0, 0
	MOVWF      FARG_ks0108_locate_x+0
	MOVF       _ks0108_y+0, 0
	MOVWF      FARG_ks0108_locate_y+0
	CALL       _ks0108_locate+0
;ks0108.c,327 :: 		return display_data;
	MOVF       ks0108_data_read_display_data_L0+0, 0
	MOVWF      R0+0
;ks0108.c,329 :: 		}
	RETURN
; end of _ks0108_data_read

_ks0108_data_write:

;ks0108.c,333 :: 		void ks0108_data_write(unsigned char d)
;ks0108.c,337 :: 		PORT_CTL = CTL_RST;
	MOVLW      32
	MOVWF      PORTB+0
;ks0108.c,340 :: 		if (ks0108_x >= 64) {
	MOVLW      64
	SUBWF      _ks0108_x+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_ks0108_data_write48
;ks0108.c,341 :: 		PORT_CTL |= CTL_C1;
	BSF        PORTB+0, 0
;ks0108.c,342 :: 		} else {
	GOTO       L_ks0108_data_write49
L_ks0108_data_write48:
;ks0108.c,343 :: 		PORT_CTL |= CTL_C0;
	BSF        PORTB+0, 1
;ks0108.c,344 :: 		}
L_ks0108_data_write49:
;ks0108.c,347 :: 		PORT_CTL |= CTL_DI;
	BSF        PORTB+0, 2
;ks0108.c,350 :: 		REG_DATA = 0x00;
	CLRF       TRISD+0
;ks0108.c,351 :: 		PORT_DATA = d;
	MOVF       FARG_ks0108_data_write_d+0, 0
	MOVWF      PORTD+0
;ks0108.c,354 :: 		ks0108_enable();
	CALL       _ks0108_enable+0
;ks0108.c,357 :: 		ks0108_x++;
	INCF       _ks0108_x+0, 1
;ks0108.c,359 :: 		}
	RETURN
; end of _ks0108_data_write
