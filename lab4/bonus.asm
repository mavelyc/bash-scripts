%include "asm_io.inc"

section .data
msg: db "wrong number of command line arguments",0
lost: db "sorry, you do not win",0
win: db "Ooooh yes, you are the winner",0

section .bss
nums resd 5
N resd 1

section .text
global asm_main

asm_main:
    enter 0, 0

    ;;; check the number of arguments
    mov eax, dword [ebp+8]  ; argc
    cmp eax,2
    je S1
    mov eax,msg
    call print_string
    call print_nl
    jmp END
    S1:
 
    mov ecx,dword [ebp+12]  ; address of argv[]
    mov ebx,dword [ecx+4]   ; get 1st argument -- ptr to a string

    ;;;;;;;;;;; create the array nums from 1st argument and set its length [N] ;;;;;;
    ;;; check that the length does not go over 5
    ;;; ebx traverse the argument, ecx traverses the array
    mov ecx,nums
    mov [N],dword 0
    L1: cmp byte [ebx],byte 0
        je L2                  ; end of string reached
        mov edx,0
        mov dl,byte [ebx]      ; move the digit to dl
        sub dl,'0'             ; turn the digit into number
        mov [ecx],edx          ; move the number to the array nums
        inc ebx
        add ecx,4
        add dword [N],dword 1
        cmp dword [N],5      ; we can accommodate at most 5 integers in nums
        jbe L1
    L2: cmp dword [N],9
        jne L3
        mov eax,win
        call print_string
        call print_nl
        jmp END
    L3: mov eax, lost
        call print_string
        call print_nl

    END:
    leave
    ret                       ; return
