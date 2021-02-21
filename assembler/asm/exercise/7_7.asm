;p154: 问题7.7
;编程，将data段中的每个单词改为大写字母

assume cs:code,ds:data

data segment
	;每一行中每个单词距离该行首字符的偏移量均为3
	db 'ibm             '
	db 'dec             '
	db 'dos             '
	db 'vax             '
data ends

code segment

start:	mov ax,data
	mov ds,ax

	mov bx,0
	mov cx,4	;循环遍历每一行
	
s:	mov dx,cx   	;保持循环变量cx
	mov si,0
	mov cx,3	;循环遍历每一列
	
s0:	mov al,[bx+si]
	and al,11011111b
	mov [bx+si],al

	inc si
	loop s0

	add bx,16
	mov cx,dx	;恢复循环变量cx
	loop s

	
	mov ax,4c00h
	int 21h

code ends

end start


