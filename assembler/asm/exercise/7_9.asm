;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p155: 问题7.9
;编程：将data段中每个单词的前4个字母改为大写字母
;
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


assume cs:code,ds:data,ss:stack

stack segment STACK	;关键字STACK可以去除link警告：无STACK段
			;关键字STACK还可以自动使SS:SP指向此堆栈段
	dw	16 dup(0ffffh)
stack ends

data segment
	db '1. display      '
	db '2. brows        '
	db '3. replace      '
	db '4. modify       '
data ends

code segment

start:	;mov ax,stack
	;mov ss,ax
	;mov sp,16

	mov ax,data
	mov ds,ax

	mov bx,0
	mov cx,4
	
s:	mov si,0
	push cx
	mov cx,4

s0:	mov al,[bx+si+3]
	and al,11011111b
	mov [bx+si+3],al
	inc si
	loop s0

	add bx,16
	pop cx
	loop s

	mov ax,4c00h	;程序优雅退出
	int 21h

code ends

end start

