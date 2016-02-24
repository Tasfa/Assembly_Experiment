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
        以上为调用中断清除屏幕
        mov ax,data
        mov ds,ax      
        mov ax,0b800h
        mov es,ax      
        mov ah,07h      ; 设定颜色值  
        mov bx,0
        mov si,0  
        mov cx,21    
 
      s:push cx       ;cx入栈保护
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
  ;-----显示年份----
                
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
   ;-----显示总收入-----
                
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


;-----显示总人数


        mov bx,40
        mov si,0
        mov di,0
        mov cx,21
     s5:mov dx,86[di]
        mov ax,84[di]
        div word ptr 168[si] ;计算人均收入，ax保存
        mov dx,0                    ;为了调用dtoc子程序，把收入定为32bit
        call dtoc
        call show_str
        add si,2
        add di,4
        add bx,160
        loop s5


;------显示人均收入-----


        mov ax,4c00h
        int 21h
   
;;dtcoc功能把数字转化为十进制表示的字符串
;参数：dx =dword高十六位，ax=dword低十六位
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
       loop kkk                  ;function ：to reverse the number string


       pop si
       pop cx
       ret                                      
;show_str:在当前屏幕上显示字符串
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


;divdw功能:进行不会溢出的除法运算，被除数为dword型，除数为word型，结果为dword型
;参数:ax=dword型数据的低16位，dx=dword型数据的高16位，cx=除数
;返回:dx=结果的高16位，ax=结果的低16位，cx=余数
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
