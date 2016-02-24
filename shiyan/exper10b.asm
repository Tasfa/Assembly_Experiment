assume cs:code,ss:stack
stack segment
dw 8 dup(0)
stack ends

code segment
start:
mov ax,0ffffh
mov dx,0eeeeh
mov cx,0ah

call divdw

mov ax,4c00h
int 21h

divdw:
     
  push bx
  push ax
  
  mov ax,dx
  mov dx,0
  div cx      ;高位dx除以除数16位cx，ax存放商，dx存放余数
  mov bx,ax   ;将商存在BX里
  pop ax
  div cx      ;低位ax及余数dx除以除数cx
  mov cx,dx
  mov dx,bx
  
  pop bx
   ret
code ends
end start    

