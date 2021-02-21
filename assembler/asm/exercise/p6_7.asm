;p133 实验5
; 小实验(3)

assume 	cs:code, ds:data, ss:stack


code segment

start:	mov ax,stack
	mov ss,ax	;设置栈段基地址
	
	mov sp,16	;设置栈顶指针


	mov ax,data
	mov ds,ax	;设置数据段基地址
	

	push ds:[0]
	push ds:[2]

	pop ds:[2]
	pop ds:[0]
	
	mov ax,4c00h
	int 21h

code ends

data segment
	
	dw 	0123h,	0456h
	
data ends


stack segment

	dw	0,	0	
	
stack ends

end start	;伪指令end一方面告诉编译器源程序到此结束，
		;一方面也说明了程序的入口是start，即要执行的第一条指令在start处





