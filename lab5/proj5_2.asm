%include "asm_io.inc"
global asm_main

SECTION .data

        err1: db "Incorrect number of arguments",10,0
        err2: db "Argument must contain an odd digit greater than 1 in second byte",10,0
        err3: db "Argument must have an uppercase letter in first byte",10,0
        err4: db "Argument is the wrong length",10,0
	print1: db "Displaying shape of size ",0
	print2: db " made of letters ",0

SECTION .bss


SECTION .text
   global asm_main

display_shape:
   enter 0,0
   pusha
   mov eax, dword[ebp+8]
   mov al, byte[ebp+12]
   call print_char

   popa
   leave
   ret

;display_line:


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_main:
   enter 0,0
   pusha

   mov ebx, dword [ebp+8]
   cmp ebx, dword 2
   jne ERR1

   mov ebx, dword [ebp+12]
   mov eax, dword [ebx+4]

   cmp byte [eax], byte 0
   je ERR4
   cmp byte [eax+1], byte 0
   je ERR4
   cmp byte [eax+2], byte 0
   jne ERR4

   ; upper letter check
   cmp byte [eax],'A'
   jb ERR3
   cmp byte [eax],'Z'
   ja ERR3

   ;number check
   cmp byte [eax+1],'0'
   jb ERR2
   cmp byte [eax+1],'9'
   ja ERR2

numconv:
   mov bl, byte [eax+1]
   mov eax,0
   mov al, bl
   ;call print_char
   SUB al,'0'
   ;call print_int

check:
   mov ecx, eax
   cmp eax,dword 1
   jbe ERR2
   
   mov edx,0
   mov ebx,0
   mov ebx,2
   DIV ebx
   cmp edx,dword 1
   jne ERR2

stackpush:
   mov eax, ecx
   push eax
   mov eax,0
   mov ebx, dword [ebp+12]
   mov eax, dword [ebx+4]
   mov bl, byte [eax]
   mov al,bl
   push al
   call display_shape
   add esp, 5
   jmp END

ERR1:
   mov eax, err1
   call print_string
   jmp END


ERR2:
   mov eax, err2
   call print_string
   jmp END

ERR3:
   mov eax, err3
   call print_string
   jmp END

ERR4:
   mov eax, err4
   call print_string
   jmp END

END:
   popa
   leave 
   ret
