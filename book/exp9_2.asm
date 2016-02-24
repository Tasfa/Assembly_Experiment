assume cs:code,ds:data
data segment 
dd 12345678h
data ends

code segment
s:     

mov ax,data
mov ds,ax
mov bx,0
mov word ptr [bx],0
mov word ptr [bx+2],cs
jmp dword ptr ds:[0]
       

code ends
end s
