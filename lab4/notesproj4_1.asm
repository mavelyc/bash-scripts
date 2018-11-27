%include "asm_io.inc"
global asm_main

section .data
;string db "hellohellohellohello worldworldworldworldworld",0
string db "hello world",0
msg1 db "too many characters",0

section .bss
N resd 1

section .text

asm_main:
  enter 0, 0

  ;; calculate the string's length by traversing it
  ;; using ebx to traverse the string
  mov ebx,string
  mov dword [N],dword 0
  L1: cmp byte [ebx],byte 0
      je L2
      inc ebx
      add dword [N],1
      cmp dword [N],20
      jb L1
      mov eax,msg1
      call print_string
      call print_nl
      jmp END

  L2: mov eax,string
  call print_string
  call print_nl

  ;;;; now modify the string in the memory
  mov cl,'A'
  sub cl,'a'          ; cl is the conversion factor from a to A
  
  mov eax,string      ; eax will traverse the string
  L3: mov bl,[eax]
      cmp bl,byte 0
      je L4
      cmp bl,' '
      jne L5
      mov dl,'-'
      mov [eax],dl    
      jmp L6
      L5: add bl,cl
      mov [eax],bl
      L6: inc eax
      jmp L3
  L4: mov eax,string
  call print_string
  call print_nl

  END:
  leave
  ret
