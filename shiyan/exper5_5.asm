assume cs:code,ss:c,ds:a
a segment
 db 1,2,3,4,5,6,7,8
a ends

b segment
 db 1,2,3,4,5,6,7,8
b ends

c segment
 db 0,0,0,0,0,0,0,0
c ends

code segment
start:
      mov ax,c
      mov ss,ax
      mov sp,18

      mov ax,a
      mov ds,ax
      mov bx,0
      mov bp,0010h
      mov si,0
      mov cx,8
      mov dx,0

      
   s:  
      mov bx,0
      mov dx,0
      add bl,ds:[bp]
      add dl,ds:[si]
      add bx,dx
      
      push bx
      pop  ss:[si]
      add bp,1
      add si,1
      loop s

      mov ax,4c00h
      int 21h

code ends
end start 