
#	deklaracja portów wejścia oraz wyjścia
ALIAS		R0			ZERO
ALIAS		R10			SWITCH
ALIAS		R11			LED

#	deklaracja zmiennych programu:
ALIAS		R1			TIMER_L
ALIAS		R2			TIMER_H
ALIAS		R3			DUTY

START:
#	wstępna inicjalizacja zmiennych:
	ADDI	DUTY		ZERO		0
	ADDI	LED			ZERO		0
	ADDI	TIMER_L		ZERO		0
	ADDI	TIMER_H		ZERO		0
	
	NOP
	
LOOP:
#	skok warunkowy do etykiety "INCREMENT"
#	przy przepełnieniu zmiennej "TIMER_L":
	BEQ		TIMER_L		ZERO		INCREMENT
#	inkrementacja 8 dolnych bitów 12- bitowego licznika:
	ADDI	TIMER_L		TIMER_L		1
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	

END_LOOP:
#	skok bezwarunkowy do etykiety "LOOP":
	JAL		R30			LOOP
#	obcięcie górnych 4 bitów licznika:
	ANDI	TIMER_H		TIMER_H		0b00001111
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP

	
INCREMENT:
#	skok warunkowy do etykiety "PWM_L", jeśli 4 najwyższe bity
#	12-bitowego licznika są większe niż nastawy na przełącznikach:
	BLTU	SWITCH		TIMER_H		PWM_L
#	inkrementacja górnych bitów licznika:
	ADDI	TIMER_H		TIMER_H		1
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP

PWM_H:
#	skok bezwarunkowy do etykiety "END_LOOP"
	JAL		R30			END_LOOP
#	wystawienie stanu wysokiego na diodę led:
	ADDI	LED			ZERO		0b00000001
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	
PWM_L:
#	skok bezwarunkowy do etykiety "END_LOOP"
	JAL		R30			END_LOOP
#	wystawienie stanu niskiego na diodę led:
	ADDI	LED			ZERO		0b00000000
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP

	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP