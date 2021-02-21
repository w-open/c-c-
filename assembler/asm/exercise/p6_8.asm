;p133 实验5
; 小实验(5) 编写代码，将a段和b段中的数据依次相加，结果存放在c段中

assume 	cs:code


a segment
	
	;dw 	0123h,	0456h
	db	1,	2,	3,	4,	5,	6,	7,	8
a ends

b segment
	
	db	1,	2,	3,	4,	5,	6,	7,	8
b ends

c segment

	db	0,	0,	0,	0,	0,	0,	0,	0	
	
c ends


code segment

start:	mov ax,cs
	sub ax,3
	mov ds,ax

	mov bx,0
	mov cx,8
s:	mov al,[bx]		;a segment 
	add al,[bx+16]		;a + b
	mov [bx+32],al		;c
	inc bx
	loop s
	
	mov ax,4c00h
	int 21h

code ends

end start	;伪指令end一方面告诉编译器源程序到此结束，
		;一方面也说明了程序的入口是start，即要执行的第一条指令在start处





