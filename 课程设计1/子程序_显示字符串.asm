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
         push ax            ;������Ӧ����������ջ
         mov al,00a0h
         mul dh
         push ax            ;������Ӧ����������ջ
         mov bh,cl          ;����ɫ�洢��bx�У�����һ��������16λ
         pop di             ;�кų�ջ������di ������
         pop bp
change:
         mov cl,ds:[si]
         mov ch,0
         jcxz ok

         mov bl,ds:[si]
         mov es:[di+bp],bx   ;д���Դ�
         inc si
         add bp,2
 jmp short change
 ok: 
         pop cx
         ret