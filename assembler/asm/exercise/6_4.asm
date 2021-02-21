;p130 程序6.4

assume 	cs:code, ds:data, ss:stack


data segment
	
	dw 	0123h,	0456h,	0789h,	0abch,	0defh,	0fedh,	0cbah,	0987h
	
data ends


stack segment

	dw	0,	0,	0,	0,	0,	0,	0,	0
	dw	0,	0,	0,	0,	0,	0,	0,	0	
	
stack ends


code segment

start:	mov ax,stack
	mov ss,ax	;设置栈段基地址
	
	mov sp,20h	;设置栈顶指针


	mov ax,data
	mov ds,ax	;设置数据段基地址
	
	mov bx,0	;设置数据段索引值

	
	mov cx,8		
s:	push [bx]
	add bx,2
	loop s

	mov bx,0
	
	mov cx,8		
s0:	pop cs:[bx]
	add bx,2
	loop s0
	
	mov ax,4c00h
	int 21h

code ends

end start	;伪指令end一方面告诉编译器源程序到此结束，
		;一方面也说明了程序的入口是start，即要执行的第一条指令在start处


