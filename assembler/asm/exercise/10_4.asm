;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;P194:检测点10.4		转移地址在寄存器中的call指令
;
;	下面的程序执行后，ax中的数值是多少？
;
;
;	ax=000bh
;
;存在的问题：代码复制到1000:0000处，CALL指令后面的转移地址不对。
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code

stack segment STACK
	db 16 dup (0)
stack ends

code segment

obj_start:
	mov ax,6
	call ax
	inc ax
	mov bp,sp
	add ax,[bp]
obj_end:


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
	mov cx,OFFSET obj_end - OFFSET obj_start
copy:	mov al,cs:[bx]
	mov [bx],al
	inc bx
	loop copy
	
	retf
code ends

end start	

