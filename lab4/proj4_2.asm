%include "asm_io.inc"

SECTION .data
string: db "Hello World",0
err: db "The length of the string is over 20",0
length: db "The length of the string is",0
numup: db "The number of upper case letters is/are",0 

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
	mov eax, [N]
	call print_int
	call print_nl
	mov eax, [upper]
	call print_int
	call print_nl
	jmp A4	

	A3: inc ebx
	add dword [N], dword 1
	cmp dword [N], dword 20
	jb A1
	mov eax, err
	call print_string
	call print_nl
	jmp END

	A4: mov eax, string
	mov cl, 'a'
	sub cl, 'A'
	jmp A5

	A5: mov bl,[eax]
	cmp bl,byte 0
	je pr
	cmp bl,' '
	jne A6
	jmp A7
	A6:cmp bl,'A'
	jb A8
	cmp bl, 'Z'
	ja A8 
	add bl,cl
	jmp A8
	A8:mov [eax],bl
	A7: inc eax
	jmp A5
	
	pr: mov eax, string
	call print_string
	call print_nl
	jmp END
	END:leave
	ret
