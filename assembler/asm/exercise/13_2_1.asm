;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p253	13.2 编写供应用程序调用的中断例程
;
;问题一：编写、安装中断7CH的中断例程
;
;功能：求一word型数据的平方
;参数：(ax)=要计算的数据
;返回值：dx,ax中存放结果的高16位和低16位
;应用举例：求2*3456^2
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


assume cs:code

code segment

start:	mov ax,cs
	mov ds,ax
	mov si,OFFSET sqr

	mov ax,0
	mov es,ax
	mov di,200h

	mov cx,OFFSET sqrend - OFFSET sqr
	cld
	rep movsb

	mov ax,0
	mov es,ax
	mov word ptr es:[7ch*4],200h
	mov word ptr es:[7ch*4+2],0


	mov ax,3456		;(ax)=3456
	int 7ch			;调用7ch的中断例程，计算ax中数据的平方
	add ax,ax
	adc dx,dx		;dx:ax存放结果，然后将结果乘以2

	mov ax,4c00h
	int 21h

sqr:	mul ax
	iret
sqrend:	nop
	
code ends

end start