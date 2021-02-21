;p129 检测点6.1
;使用内存单元0:0~0:15中的内容改写程序中的数据
;要求：数据的传送通过栈空间来实现

assume cs:code

code segment

	dw 	0123h,	0456h,	0789h,	0abch,	0defh,	0fedh,	0cbah,	0987h
	dw	0,	0,	0,	0,	0,	0,	0,	0
	dw	0,	0	;10个字单元用作栈空间
	
start:	mov ax,cs
	mov ss,ax
	mov sp,24h

	mov ax,0
	mov ds,ax
	
	mov bx,0
	mov cx,8		
s:	push [bx]
	pop cs:[bx]
	add bx,2
	loop s
	
	mov ax,4c00h
	int 21h

code ends

end start


