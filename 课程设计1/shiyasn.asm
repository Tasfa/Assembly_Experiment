assume cs:code,ds:data,es:table

data segment
  db '1975','1976','1977','1978','1979','1980','1981','1982','1983'   
  db '1984','1985','1986','1987','1988','1989','1990','1991','1992'   
  db '1993','1994','1995'   

  dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514    
  dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000  
 
  dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226   
  dw 11542,14430,15257,17800 
data ends

  data1 segment
  db 21 dup('year summ ne ?? ')
data1 ends


table segment
  db 21 dup('year summ ne ?? ')
table ends

code segment
   start:
        

        mov ax,data
        mov ds,ax
        mov bx,0

        mov ax,table
        mov es,ax
        mov si,0
        mov di,0
        mov cx,21
     s:
        


     
        mov al,[bx]
        mov es:[si],al
        mov al,[bx+1]
        mov es:[si+1],al
        mov al,[bx+2]
        mov es:[si+2],al
        mov al,[bx+3]
        mov es:[si+3],al

        mov ax,[bx+84]
        mov es:[si+5],ax
        mov ax,[bx+86]       
        mov es:[si+7],ax 
        
        sub bx,di 
        mov  ax,[bx+168]
        mov  es:[si+10],ax 
        add bx,di 

        mov ax,es:[si+5]
        mov dx,es:[si+7]
        div word ptr es:[si+10]
        mov es:[si+13],ax

     
        add di,2
        add si,16
        add bx,4
     loop s

     mov ax,4c00h
     int 21h
 code ends
 end start





















