;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p251 实验12 编写0号中断的处理程序
;
;	编写0号中断的处理程序，使得在除法溢出发生时，在屏幕中间显示字
;符串"divide error!"
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code

code segment

start:	;do0 安装程序
	mov ax,code
	mov ds,ax
	mov si,OFFSET do0	;设置ds:si指向do0

	mov ax,0
	mov es,ax
	mov di,200h		;设置es:di指向0000:0200

	cld			;设置DF=0,正向传送数据

	mov cx,OFFSET do0end - OFFSET do0	;设置传送的字节数
	rep movsb

	;设置中断向量表
	mov ax,0
	mov es,ax
	mov word ptr es:[0*4],200h		;设置0号中断向量的偏移地址
	mov word ptr es:[0*4+2],0		;设置0号中断向量的段地址

	mov ax,4c00h
	int 21h


;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
do0:	jmp short do0start
	db "divide error!"
do0start:
	push ax
	push cx
	push ds
	push es
	push si
	push di
	
	;显示字符串
	mov ax,cs
	mov ds,ax
	mov si,200h+2		;设置ds:si指向待显示的字符串

	mov ax,0b800h
	mov es,ax
	mov di,160*12+56*2

	mov cx,13
do0_s:	mov al,ds:[si]
	mov es:[di],al
	inc si
	add di,2
	loop do0_s

	pop di
	pop si
	pop es
	pop ds
	pop cx
	pop ax

	;iret
	mov ax,4c00h		;0号中断处理程序执行结束，即返回DOS操作系统
	int 21h
do0end:	nop

code ends

end start








