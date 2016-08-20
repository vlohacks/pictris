
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;mukke.c,88 :: 		void interrupt() {
;mukke.c,90 :: 		if (INTCON.TMR0IF) {
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt0
;mukke.c,91 :: 		INTCON.TMR0IF = 0;
	BCF        INTCON+0, 2
;mukke.c,93 :: 		if (current_note_delay == 0) {
	MOVF       _current_note_delay+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;mukke.c,94 :: 		current_note_delay = song[song_position][1];
	MOVF       _song_position+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _song+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_song+0)
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
	MOVWF      _current_note_delay+0
;mukke.c,95 :: 		PR2 = notes[song[song_position][0]][0];
	MOVF       _song_position+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _song+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_song+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R3+0
	MOVF       R3+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _notes+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_notes+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PR2+0
;mukke.c,96 :: 		CCPR1L  = 0x28;
	MOVLW      40
	MOVWF      CCPR1L+0
;mukke.c,97 :: 		CCP1CON = notes[song[song_position][0]][1];
	MOVF       _song_position+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _song+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_song+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R3+0
	MOVF       R3+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _notes+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_notes+0)
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
	MOVWF      CCP1CON+0
;mukke.c,98 :: 		if (song_position == SONG_LENGTH)
	MOVF       _song_position+0, 0
	XORLW      78
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt2
;mukke.c,99 :: 		song_position = 0;
	CLRF       _song_position+0
	GOTO       L_interrupt3
L_interrupt2:
;mukke.c,101 :: 		song_position++;
	INCF       _song_position+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _song_position+0
L_interrupt3:
;mukke.c,102 :: 		}
L_interrupt1:
;mukke.c,104 :: 		if (CCPR1L && (beatcount % 16) == 0) {
	MOVF       CCPR1L+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt6
	MOVLW      15
	ANDWF      _beatcount+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt6
L__interrupt9:
;mukke.c,105 :: 		CCPR1L-=1;
	DECF       CCPR1L+0, 1
;mukke.c,106 :: 		}
L_interrupt6:
;mukke.c,108 :: 		if (beatcount == 128) {
	MOVF       _beatcount+0, 0
	XORLW      128
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt7
;mukke.c,109 :: 		beatcount = 0;
	CLRF       _beatcount+0
;mukke.c,110 :: 		current_note_delay--;
	DECF       _current_note_delay+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _current_note_delay+0
;mukke.c,111 :: 		}  else {
	GOTO       L_interrupt8
L_interrupt7:
;mukke.c,112 :: 		beatcount = (beatcount + 1);
	INCF       _beatcount+0, 1
;mukke.c,113 :: 		}
L_interrupt8:
;mukke.c,114 :: 		}
L_interrupt0:
;mukke.c,116 :: 		}
L__interrupt10:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_mukke_start:

;mukke.c,118 :: 		void mukke_start()
;mukke.c,120 :: 		INTCON = 0;
	CLRF       INTCON+0
;mukke.c,121 :: 		INTCON.GIE = 1;
	BSF        INTCON+0, 7
;mukke.c,122 :: 		INTCON.TMR0IE = 1;
	BSF        INTCON+0, 5
;mukke.c,124 :: 		song_position = 0;
	CLRF       _song_position+0
;mukke.c,125 :: 		current_note_delay = 0;
	CLRF       _current_note_delay+0
;mukke.c,126 :: 		beatcount = 0;
	CLRF       _beatcount+0
;mukke.c,128 :: 		OPTION_REG  = 0b11000011;
	MOVLW      195
	MOVWF      OPTION_REG+0
;mukke.c,129 :: 		T2CON   = 0b00001111;
	MOVLW      15
	MOVWF      T2CON+0
;mukke.c,132 :: 		}
	RETURN
; end of _mukke_start

_mukke_stop:

;mukke.c,134 :: 		void mukke_stop()
;mukke.c,136 :: 		INTCON.TMR0IE = 0;
	BCF        INTCON+0, 5
;mukke.c,137 :: 		T2CON = 0;
	CLRF       T2CON+0
;mukke.c,138 :: 		}
	RETURN
; end of _mukke_stop
