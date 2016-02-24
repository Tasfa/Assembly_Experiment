assume cs:code,ds:data,ss:stack

data segment
db 16 dup(0)
data ends
stack segment
dw 8 dup(0)
stack ends

code segment
main:
      mov ax,12666
      mov bx,stack
      mov ss,bx
      mov sp,16
      mov bx,data
      mov ds,bx
      mov si,0
      mov bx,0
call dtoc
      mov dh,8
      mov dl,3
      mov cl,2
   call show_str
   mov ax,4c00h
   int 21h
dtoc:
      push bx
calulate:
      mov cl,al
      mov ch,0
      jcxz ok2

      mov cx,0ah
      mov dx,0
   call divdw

      add cx,30h
      push cx

 jmp short calulate
ok2:

        mov cx,ds:[si]
    jcxz ok3
    pop ds:[si]
        inc si
    jmp short ok2
 ok3:
 pop bx

  ret
show_str:
    mov ax,0b800h
    mov es,ax
        mov si,0
        mov di,0
        mov bp,0
    mov ax,0
    mov al,2
    mul dl
    push ax
    mov al,00a0h
    mul dh
    push ax
    mov bh,cl

    pop di
    pop bp

change:
    mov cl,ds:[si]
    mov ch,0
    jcxz ok
      
    mov bl,ds:[si]
        mov es:[di+bp],bx
    add bp,2
    inc si
    
jmp short change
ok:     
        
  
    ret
divdw:  
  push ax
  
  mov ax,dx
  mov dx,0
  div cx      
  mov bx,ax   
  pop ax
  div cx
  mov cx,dx
  mov dx,bx 
   ret

code ends
end main












