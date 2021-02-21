;p133 实验5
; 小实验(6) 编写代码，使用push指令将a段中的前8个字型数据，逆序存储到b段中

assume 	cs:code


a segment
	
	;dw 	0123h,	0456h
	dw	1,	2,	3,	4,	5,	6,	7,	8
	dw	9,	0ah,	0bh,	0ch,	0dh,	0eh,	0fh,	0ffh
a ends


b segment

	dw	0,	0,	0,	0,	0,	0,	0,	0	
	
b ends


code segment

start:	mov ax,b
	mov ss,ax
	mov sp,16

	mov ax,a
	mov ds,ax

	mov bx,0
	mov cx,8
s:	push [bx]
	add bx,2
	loop s
	
	mov ax,4c00h
	int 21h

code ends

end start	;伪指令end一方面告诉编译器源程序到此结束，
		;一方面也说明了程序的入口是start，即要执行的第一条指令在start处






