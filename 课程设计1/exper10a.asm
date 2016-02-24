assume cs:code,ds:data,ss:stack
data segment
db '123456789',0
data ends

stack segment
dw 8 dup(0)
stack ends

code segment
start:
	mov dh,12
	mov dl,40
	mov cl,74

	mov ax,stack
	mov ss,ax
	mov sp,16
	mov ax,data
	mov ds,ax

	call show_str

	mov ax,4c00h
	int 21h
show_str:
	mov ax,0b800h
	mov es,ax

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
	ret
code ends
end start

