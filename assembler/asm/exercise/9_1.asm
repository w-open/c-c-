;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p176 问题9.1
;
;	补全代码，以使该程序在运行时将s处的一条指令复制到s0处
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:codesg

codesg segment

s:	mov ax,bx	;mov ax,bx的机器码占两个字节
	mov si, offset s
	mov di, offset s0

	mov ax,cs:[si]
	mov cs:[di],ax

s0:	nop		;nop的机器码占一个字节
	nop
codesg ends

end s