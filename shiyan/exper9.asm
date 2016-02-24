assume cs:code,ds:data,ss:stack

data segment
db 77h,02h,65h,02h,6ch,02h,63h,02h,6fh,02h,6dh,02h,65h,02h,20h,02h,74h,02h,6fh,02h,20h,02h,6dh,02h,61h,02h,73h,02h,6dh,02h,21h,02h
db 77h,24h,65h,24h,6ch,24h,63h,24h,6fh,24h,6dh,24h,65h,24h,20h,24h,74h,24h,6fh,24h,20h,24h,6dh,24h,61h,24h,73h,24h,6dh,24h,21h,24h
db 77h,71h,65h,71h,6ch,71h,63h,71h,6fh,71h,6dh,71h,65h,71h,20h,71h,74h,71h,6fh,71h,20h,71h,6dh,71h,61h,71h,73h,71h,6dh,71h,21h,71h
data ends

stack segment
dw 0,0,0,0,0,0,0,0
stack ends

code segment
start:
 mov ax,stack
 mov ss,ax
 mov sp,16

 mov ax,data
 mov ds,ax

 mov ax,0b800h
 mov es,ax

 mov si,62
 mov bx,0
 mov dx,0
 mov bp,8c0h
 mov cx,3
s1:
   push cx
   mov cx,32
s:
  mov dx,ds:[bx]
  mov es:[bp+si],dx
  inc bx
  inc si
  loop s
  mov si,62
  add bp,0a0h
  pop cx
  loop s1
  mov ax,4c00h
  int 21h
code ends
end start
  
