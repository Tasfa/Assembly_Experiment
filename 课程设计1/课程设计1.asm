assume cs:code,ds:data,ss:stack
stack segment
  
  dw 128 dup (0)


stack ends


data segment


db '1975','1976','1977','1978','1979','1980','1981','1982','1983'


db '1984','1985','1986','1987','1988','1989','1990','1991','1992'


db '1993','1994','1995'


dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514


dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000


dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226


dw 11452,14430,15257,17800


db 16 dup (0)


data ends


code segment
  start:
        mov ax,0600h
        mov bh,00
        mov cx,0000h
        mov dx,184fh
        int 10h                  
        mov ah,2
        mov bh,0
        mov dh,0
        mov dl,12
        int 10h         
        ����Ϊ�����ж������Ļ
        mov ax,data
        mov ds,ax      
        mov ax,0b800h
        mov es,ax      
        mov ah,07h      ; �趨��ɫֵ  
        mov bx,0
        mov si,0  
        mov cx,21    
 
      s:push cx       ;cx��ջ����
        mov di,0        
        mov cx,4    
    
   s1:mov al,[si]           
        mov es:[bx+di],al
        mov es:[bx+di].1,ah   ;assigment
        inc si
        add di,2
        loop s1
        
        add bx,160   
        pop cx              
        loop s
  ;-----��ʾ���----
                
        mov ax,stack
        mov ss,ax
        mov sp,32
        mov ax,data
        mov ds,ax


        mov bx,0       
        mov si,0
        mov di,0    
        
        mov cx,21  
    s3: mov dx,86[di]
        mov ax,84[di]
        call dtoc
        call show_str
        add di,4
        add bx,160
        loop s3
   ;-----��ʾ������-----
                
        mov bx,20    
        mov si,0
        mov di,0
        mov cx,21
     s4:mov dx,0
        mov ax,168[di]
        call dtoc
        call show_str
        add di,2
        add bx,160
        loop s4


;-----��ʾ������


        mov bx,40
        mov si,0
        mov di,0
        mov cx,21
     s5:mov dx,86[di]
        mov ax,84[di]
        div word ptr 168[si] ;�����˾����룬ax����
        mov dx,0                    ;Ϊ�˵���dtoc�ӳ��򣬰����붨Ϊ32bit
        call dtoc
        call show_str
        add si,2
        add di,4
        add bx,160
        loop s5


;------��ʾ�˾�����-----


        mov ax,4c00h
        int 21h
   
;;dtcoc���ܰ�����ת��Ϊʮ���Ʊ�ʾ���ַ���
;������dx =dword��ʮ��λ��ax=dword��ʮ��λ
  dtoc:
       push cx
       push si ;turn the dword to decimal system string                       
       mov si,0                                        
    ok:call divdw                  
       add cx,30h
       push cx
       mov cx,ax
       jcxz go1
    
   go3:inc si                    
       jmp  short ok                  
                                 
   go1:mov cx,dx              
       jcxz go2                  ; the go1 go2 go3 judge if the quotient is 0
       jmp go3                  ; if true,return
                              
   go2:inc si
       mov byte ptr 210[si],0
       mov cx,si
       mov si,0
   kkk:pop ax
       mov 210[si],al
       inc si
       loop kkk                  ;function ��to reverse the number string


       pop si
       pop cx
       ret                                      
;show_str:�ڵ�ǰ��Ļ����ʾ�ַ���
show_str:push cx
         push bx
         push ax
         push si
         push di
         mov si,0
         mov di,0               
         mov ah,07h
         add bx,20
      sh:mov cl,210[di]
         mov ch,0
         jcxz gos
         mov al,210[di]
         mov es:[bx+si],al
         mov es:[bx+si].1,ah
         inc di
         add si,2
         jmp short sh
     
     
     gos:pop di 
         pop si 
         pop ax 
         pop bx 
         pop cx
         ret


;divdw����:���в�������ĳ������㣬������Ϊdword�ͣ�����Ϊword�ͣ����Ϊdword��
;����:ax=dword�����ݵĵ�16λ��dx=dword�����ݵĸ�16λ��cx=����
;����:dx=����ĸ�16λ��ax=����ĵ�16λ��cx=����
divdw:push bx        ;the parament is dx and ax
        mov cx,10           ;function: big number divide
        mov bx,ax           
        mov ax,dx           
        mov dx,0            
        div cx              
        push ax          
        mov ax,bx      
        div cx              ;  ax store the lower bits of the quotient
        mov cx,dx      ;  cx store the remainder
        pop dx            ;  dx store the higher bits of quotient                              
        pop bx
        ret                 
code ends
end start  
