%include "asm_io.inc"
global asm_main

section .data
msg1 db "wrong number of command line arguments",0
msg2 db "too many characters",0

section .bss
string resb 21
N resd 1


section .text

asm_main:
  enter 0, 0

  mov eax, dword [ebp+8]  ; argc
  S1: cmp eax,3
      je S2
      mov eax,msg1
      call print_string
      call print_nl
      jmp END
  S2:

  mov ebx,dword [ebp+12]  ; address of argv[]
 
  mov eax,dword [ebx+4]   ; get argv[1] argument -- ptr to string
  ;; copy it to string
  ;; will use edx to traverse string
  mov edx, string
  mov dword [N],0
  L1: cmp [eax],byte 0
      je L2
      mov cl,[eax]
      mov [edx],cl
      inc eax
      inc edx
      add dword [N],1
      cmp dword [N],21
      jb L1
      mov eax,msg2
      call print_string
      call print_nl
      jmp END
  L2: mov cl,' '
      mov [edx],cl
      inc edx
      mov eax,dword [ebx+8]  ; get argv[2]
  L3: cmp [eax],byte 0
      je L4
      mov cl,[eax]
      mov [edx],cl
      inc edx
      inc eax
      jmp L3
  L4: mov [edx],byte 0
      mov eax,string
      call print_string
      call print_nl

  ;;;; now modify the string in the memory
  mov cl,'A'
  sub cl,'a'          ; cl is the conversion factor from a to A
  
  mov eax,string      ; eax will traverse the string
  L5: mov bl,[eax]
      cmp bl,byte 0
      je L6
      L7: cmp bl,' '
          jne L8
          mov dl,'-'
          mov [eax],dl    
          jmp L9
      L8: add bl,cl
      mov [eax],bl
      L9: inc eax
      jmp L5
  L6: mov eax,string
      call print_string
      call print_nl

  END:
  leave
  ret
