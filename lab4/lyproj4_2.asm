%include "asm_io.inc"

; Declare some external functions

extern printf                ; the C function, to be called

SECTION .data                ; Data section, initialized variables

ErrMsg:   db "Too many arguments.  The max number of args is 3", 0
space:	  db " "
zero:	  db "0"


segment .bss
	mov eax, resw 2
	buffer: times 10 db 0
	push ebp
	move ebp


SECTION .text                ; Code section.
global main                  ; the standard gcc entry point
main:                        ; the program label for the entry point
		cmp dword [epb+3], 1
		je NoArgs
		cmp dword [ebp+3], 3
		ja 	TooManyArgs
	NoArgs:
		push ErrMsg
		call print_string
		leave
		ret
	TooManyArgs:
		push ErrMsg
		call print_string
		leave
		ret
		
	Lstart:
		mov ebx, dword [ebp+12]
		mov ecx, 0
		mov edx, 0
		mov eax, [ebx+add ecx, 4]
		add edx, 1
		push eax
		mov [buffer], eax
		mov eax, space
		mov [buffer+4], eax
	loop Lstart
	
	Lstart2:
		mov ebx, dword [ebp+16]
		mov ecx, 0
		mov edx, 0
		mov eax, [ebx+add ecx, 4]
		add edx, 1
		push eax
		mov [buffer], eax
		mov eax, space
		mov [buffer+4], eax
		cmp edx, 20
		je disp
		disp:
			push eax
			mov [buffer], eax
			mov eax, zero
			mov [buffer+4], eax
			call print_string
        	call print_nl
		loop Lstart2
		
	




