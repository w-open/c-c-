;p158: 问题7.8
;编程，优化问题7.7的程序

assume cs:code,ds:data,ss:stack

data segment
	;每一行中每个单词距离该行首字符的偏移量均为3
	db 'ibm             '
	db 'dec             '
	db 'dos             '
	db 'vax             '
data ends

stack segment
	dw 	0,	0,	0,	0,	0,	0,	0,	0
stack ends

code segment

start:	mov ax,stack	
	mov ss,ax
	mov sp,10h	;init stack segment
	
	mov ax,data
	mov ds,ax	;init data segment

	mov bx,0
	mov cx,4	;循环遍历每一行
	
s:	push cx
	mov si,0
	mov cx,3	;循环遍历每一列
	
s0:	mov al,[bx+si]
	and al,11011111b
	mov [bx+si],al

	inc si
	loop s0

	add bx,16
	pop cx
	
	loop s

	
	mov ax,4c00h
	int 21h

code ends

end start