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
         push ax            ;计算相应的列数并入栈
         mov al,00a0h
         mul dh
         push ax            ;计算相应的行数并入栈
         mov bh,cl          ;将颜色存储在bx中，方便一次性输入16位
         pop di             ;行号出栈并赋给di 下类似
         pop bp
change:
         mov cl,ds:[si]
         mov ch,0
         jcxz ok

         mov bl,ds:[si]
         mov es:[di+bp],bx   ;写入显存
         inc si
         add bp,2
 jmp short change
 ok: 
         pop cx
         ret