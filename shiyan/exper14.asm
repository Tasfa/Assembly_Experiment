assume cs:code,ds:data
data segment
  db 32 dup(0)
data ends

code segment
 start:
       mov ax,data
       mov ds,ax

       mov si,0
       mov di,1
       mov bl,9
       mov cx,3
       
    s: push cx
       mov al,bl
       out 70h,al
       in al,71h

       mov ah,al
       mov cl,4
       shr ah,cl
       and al,00001111b

       add ah,30h
       add al,30h

       mov byte ptr ds:[si],ah
       mov byte ptr ds:[di],al
       mov byte ptr ds:[di+1],2fh

       add si,3
       add di,3
       dec bl
       pop cx
   loop s
       mov byte ptr ds:[8],20h

       mov ax,20h
       mov ds:[9],ax
       mov si,10
       mov di,11
       mov bl,4
       mov cx,3
       
    s0: push cx
        mov al,bl
       out 70h,al
       in al,71h

       mov ah,al
       mov cl,4
       shr ah,cl
       and al,00001111b

       add ah,30h
       add al,30h

       mov byte ptr ds:[si],ah
       mov byte ptr ds:[di],al
       mov byte ptr ds:[di+1],3ah

       add si,3
       add di,3
       sub bl,2
       pop cx
   loop s0
       mov byte ptr ds:[18],20h

       mov dh,12
       mov dl,35
       mov cl,02h
       call show_str
     mov ax,4c00h
       int 21h
   show_str:
     push cx
   
         mov ax,0b800h
         mov es,ax
         mov si,0
         mov bp,0
         mov di,0
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
         inc si
         add bp,2
 jmp short change
 ok: 
         pop cx
         ret

       
 code ends
 end start

