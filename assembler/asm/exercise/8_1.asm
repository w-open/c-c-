;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p171:问题8.1
;  使用div计算data段中第一个数据除以第二个数据后的结果，商保存在第三
;个数据的存储单元中
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


assume cs:code,ds:data,ss:stack

stack segment STACK	;关键字STACK可以去除link警告：无STACK段
			;关键字STACK还可以自动使SS:SP指向此堆栈段
	dw	16 dup(0ffffh)
stack ends

data segment
	dd 100001
	dw 100
	dw 0
data ends

code segment

start:	;mov ax,stack
	;mov ss,ax
	;mov sp,16

	mov ax,data
	mov ds,ax

	mov bx,0

	mov ax,ds:[0]
	mov dx,ds:[2]
	div word ptr ds:[4]
	mov ds:[6],ax

	mov ax,4c00h	;程序优雅退出
	int 21h

code ends

end start


