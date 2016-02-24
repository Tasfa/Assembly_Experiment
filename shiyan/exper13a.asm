assume cs:code
code segment
  start:
        mov ax,cs
        mov ds,ax
        mov si,offset show_str
        mov ax,0
        mov es,ax
        mov di,200h
        mov cx,offset show_strend-offset show_str
        cld
        rep movsb

        mov ax,0
        mov es,ax
        mov word ptr es:[7ch*4],200h
        mov word ptr es:[7ch*4+2],0

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
        iret
 show_strend: nop

 code ends
 end start
