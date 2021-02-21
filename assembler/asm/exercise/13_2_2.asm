;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p253	13.2 编写供应用程序调用的中断例程
;
;问题二：编写、安装中断7CH的中断例程
;
;功能：将一个全是字母，以0结尾的字符串，转换为大写
;参数：ds:si指向字符串的首地址
;返回值：无
;应用举例：将data段中的字符串转化为大写
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


assume cs:code,ds:data

data segment
	db 'conversation',0
data ends
	
code segment

start:	mov ax,cs
	mov ds,ax
	mov si,OFFSET capital

	mov ax,0
	mov es,ax
	mov di,200h

	mov cx,OFFSET capitalend - OFFSET capital
	cld
	rep movsb

	mov ax,0
	mov es,ax
	mov word ptr es:[7ch*4],200h
	mov word ptr es:[7ch*4+2],0

	;调用中断例程，进行测试
	mov ax,data
	mov ds,ax
	mov si,0
	int 7ch

	mov ax,4c00h
	int 21h

capital:
	push cx
	push si
	
	mov ch,0
change:	mov cl,[si]
	jcxz ok
	and byte ptr [si],11011111b
	inc si
	jmp short change
ok:	pop si
	pop cx
	iret
capitalend:
	nop
code ends

end start
