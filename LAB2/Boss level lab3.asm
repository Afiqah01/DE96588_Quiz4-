#include<p18F4550.inc>

loop_cnt1	set	0x00
loop_cnt2	set	0x01

			org	0x00
			goto start
			org	0x08
			retfie
			org	0x18
			retfie

dup_nop		macro kk
			variable i
i = 0
			while i < kk
			nop
i += 1
			endw
			endm
			
start		CLRF	TRISD,A
			CLRF	PORTD,A
			BSF		PORTD,7,A
			CALL	DELAY
Blink		RRCF PORTD,F,A
			CALL	DELAY
			DECFSZ	PORTD, W, A
			BRA		Blink
Led			RLCF	PORTD,F,A
			CALL	DELAY
			DECFSZ	PORTD,W,A
			BRA		Led
			
DELAY		MOVLW D'100'		;1sec delay subroutine for
			MOVWF loop_cnt2,A
AGAIN1		MOVLW D'300'
			MOVWF loop_cnt1
AGAIN2		dup_nop	   D'247'
			DECFSZ	   loop_cnt1,F,A
			BRA	       AGAIN2
			DECFSZ	   loop_cnt2,F,A
			BRA		   AGAIN1
			NOP
			RETURN
			
			END