;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;P192:检测点10.2 		依据位移量进行转移的call指令
;
;	下面的程序执行后，ax中的数值是多少？
;
;
;	ax=0006h
;
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code

stack segment STACK
	db 16 dup (0)
stack ends

code segment

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	mov ax,0
	call s
	inc ax
s:	pop ax
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


start:	mov ax,stack
	mov ss,ax
	mov sp,16
	mov ax,1000h
	push ax
	mov ax,0
	push ax

	;~~~~~~~~~~~~~~~~~~~~~~~~~~
	mov ax,1000h
	mov ds,ax
	mov bx,0
	mov cx,4
copy:	mov ax,cs:[bx]
	mov [bx],ax
	add bx,2
	loop copy
	
	retf
code ends

end start	