extern printf                ; the C function, to be called

SECTION .data                ; Data section, initialized variables
a: dd 2                      ; int a=5;
fmt: db "%d*%d + 3*%d - 5 = %d",10,0  ; The printf format, '\n','0'

SECTION .text                ; Code section.

global main                  ; the standard gcc entry point
main:                        ; the program label for the entry point
        
   push ebp                  ; calling convention
   mov ebp, esp

   mov eax, [a]              ; put a from store into register
   mul eax
   mov ebx, eax
   mov eax, 3
   mul dword [a]
   mov ecx, eax                ; a+2
   mov edx, -5
   mov eax,ebx
   add eax, ecx
   add eax, edx
   push eax
   mov eax, [a]
   push eax
   push eax
   push eax                  ; value of a+2
   push dword fmt            ; address of ctrl string
   call printf               ; Call C function
   add  esp, 16              ; pop stack 3 times = 4 bytes

   mov esp, ebp              ; returning convention
   pop ebp                   ; same as "leave" op

   mov eax,0                 ; normal (no error) return value
   ret                       ; return
