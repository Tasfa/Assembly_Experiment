assume cs:code,ds:data
data segment
  db "Beginner's All-purpose Symbolic Instruction Code.",0
data ends

code segment
main:
    mov ax,data
    mov ds,ax
    mov si,0
  call letterc
    
    mov ax,4c00h
    int 21h

  letterc:
      s:
        mov ch,0
        mov cl,[si]
      jcxz ok
        cmp cl,'a'
        jb s0
        cmp cl,'z'
        ja s0
       
        and cl,11011111b
        mov [si],cl
        inc si
        jmp short s
      s0:
         inc si
         jmp short s
      ok:
         ret
code ends
end main

