%include "asm_io.inc"
global asm_main

section .data
err1: db "incorrect number of command line arguments",10,0
err2: db "incorrect value for command line argument",10,0
peg: dd 0,0,0,0,0,0,0,0,0,0

section .bss
N resd 1

section .text

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
showp:
   enter 0,0
   pusha

   mov ecx, [ebp+12]; number of values in peg array
   mov edx, [ebp+8]; peg address 

   init:
   cmp ecx, 1
   je setLOOP
   add edx, 4
   dec ecx
   jmp init

   setLOOP:
   mov ecx, [ebp+12]

   LOOP:
   cmp ecx, dword 0
   je XXX
   dec ecx
   
   spacenum:
   mov ebx, dword 10
   sub ebx, [edx]
   printspace:
   cmp ebx, 0
   je onum
   mov eax, ' '
   call print_char
   dec ebx
   jmp printspace
   
   onum:
   mov ebx, [edx]
   printo:
   cmp ebx, 0
   je mid
   mov eax, 'o'
   call print_char
   dec ebx
   jmp printo
   
   mid:
   mov eax, '|'
   call print_char
   
   onum2:
   mov ebx, [edx]
   print2:
   cmp ebx, 0
   je next
   mov eax, 'o'
   call print_char
   dec ebx
   jmp print2
   
   next:
   call print_nl
   sub edx, 4
   jmp LOOP

   XXX:
   mov ebx, 21
   mov eax, 'X'
   printX:
   cmp ebx, 0
   je showpend
   call print_char
   dec ebx
   jmp printX


   showpend:
   call print_nl
   popa
   leave
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
   greater2:
   cmp bl, '2'
   jl ERR2
   less9:
   cmp bl, '9'
   jg ERR2
   
   random:
   sub bl, '0'
   mov eax, 0
   mov al, bl
   push eax
   mov ebx, peg
   push ebx
   call rconf
   add esp, 8

   print:
   cmp [ebx], dword 0
   je pause
   mov eax, [ebx]
   call print_int
   add ebx, 4
   jmp print
   pause:
   call read_char
   mov eax, 0
   mov ebx, 0
   mov ebx, dword [ebp+12]
   mov eax, dword [ebx+4]
   mov bl, byte [eax]
   sub bl, '0'
   mov eax, 0
   mov al, bl
   push eax
   mov ebx, 0
   mov ebx, peg
   push ebx
   call showp
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
