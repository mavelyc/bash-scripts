%include "asm_io.inc"

; Declare some external functions

extern printf                ; the C function, to be called

SECTION .data                ; Data section, initialized variables
str1: db    "hellohello worldworld",0



SECTION .text                ; Code section.

global main                  ; the standard gcc entry point
main:                        ; the program label for the entry point
	mov eax, str1
	mov ecx, 1
	
	Lstart:
		cmp ecx, 20
	 	je exit
		jge disp
		add ecx, 1
		exit:
			leave
			ret
		disp:
			mov eax str1
        		call print_string
        		call print_nl
		mov edx, ecx
	loop Lstart
		
	
	Lstart2:
		mov ecx 1
		cmp ecx, edx
		add ecx, 1
		SUB eax,'h'
		ADD eax,'H'
		SUB eax,'e'
		ADD eax,'E'
		SUB eax,'l'
		ADD eax, 'L'
		SUB eax,'o'
		ADD eax, 'O'
		SUB eax,' '
		ADD eax,'-'
		SUB eax,'w'
		ADD eax, 'W'
		SUB eax,'r'
		ADD eax, 'R
		SUB eax,'d'
		ADD eax, 'D'
		je disp
		disp:
        		call print_string
        		call print_nl
	loop Lstart2
