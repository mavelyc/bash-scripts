%include "asm_io.inc"

SECTION .data
string: db "Hello World",0
err: db "The length of the string is over 20",0
length: db "The length of the string is",0
numup: db "The number of upper case letters is",0 

SECTION .bss
N resd 1
upper resd 1

SECTION .text
global asm_main
asm_main:
	enter 0,0
	mov ebx, string
	mov dword [N], dword 0
	mov dword [upper], dword 0
	A1: cmp byte [ebx], byte 0
	je A2
	cmp byte [ebx], 'A'
	jb A3
	cmp byte [ebx], 'Z'
	ja A3
	add dword [upper], dword 1 
	inc ebx
	add dword [N], dword 1
	cmp dword [N], dword 20
	jb A1	
	mov eax, err
	call print_string
	call print_nl
	jmp END


	A2:mov eax, string
	call print_string
	call print_nl
	mov eax, length
	call print_string
	mov eax, ' '
	call print_char
	mov eax, [N]
	call print_int
	call print_nl
	mov eax, numup
	call print_string
	mov eax, ' '
	call print_char
	mov eax, [upper]
	call print_int
	call print_nl	
	jmp END

	A3: inc ebx
	add dword [N], dword 1
	cmp dword [N], dword 20
	jb A1
	mov eax, err
	call print_string
	call print_nl
	jmp END

	END:leave
	ret
