assume cs:code

 code segment
    main:
     mov ax,cs
     mov ds,ax
     mov si,offset looper
     mov ax,0
     mov es,ax
     mov di,200h
     mov cx,offset loopend-offset looper
     cld
     rep movsb

     mov ax,0
     mov es,ax
     mov word ptr es:[7ch*4],200h
     mov word ptr es:[7ch*4+2],0

     mov ax,4c00h
     int 21h

     looper:
           push bp
           mov bp,sp
           dec cx
           jcxz ok
           add [bp+2],bx
       ok:
           pop bp
           iret
    loopend:
          nop
  code ends
  end main
           
