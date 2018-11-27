%include "asm_io.inc"
global asm_main

section .data
err1: db "Incorrect number of command line arguments",10,0
err2: db "First byte is not a number",10,0
err3: db "Second byte is not an upper case letter",10,0

section .bss

section .text

sorthem:
   enter 0,0
   pusha

   mov al, bl
   call print_char

   popa
   leave
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_main:
   enter 0,0
   pusha
   
   mov eax, dword [ebp+8]
   cmp eax, dword 2
   jne ERR1
   ; now we have the right # of arguments 
   mov ebx, dword [ebp+12]
   mov eax, dword [ebx+4]
   mov bl, byte [eax]
   length1:
   cmp bl, byte 0
   je ERR2
   length2:
   mov bl, byte [eax+1]
   cmp bl, 0
   je ERR2
   nottLength3:
   mov bl, [eax+2]
   cmp bl, 0
   jn ERR2
   
   random:
   sub bl, '0'
   mov eax, 0
   mov al, bl
   push eax
   mov ebx, peg
   push ebx
   call rconf
   add esp, 8
   
   jmp END


   ERR1: 
   mov eax, err1
   call print_string
   jmp END

   ERR2:
   mov eax, err2
   call print_string

   END:
   popa
   leave
   ret
