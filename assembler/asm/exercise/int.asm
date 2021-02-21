;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;用于测试DOS/BIOS的中断功能调用效果
;	Dos功能调用只是Bios的一部分
;	Dos中断功能只是在DOS操作系统环境下适用，而BIOS功能调用则不受
;		操作操作系统的约束
;
;二者的关系
;形式上：
;	1、BIOS功能调用中断号（10h~1fh）
;	2、DOS功能调用中断号（20h~2fh）
;
;层次上：
;	Dos的功能是建立在Bios的功能之上的
;	Dos的功能依赖于Bios的功能，而反之则不然
;
;功能上：
;	Dos的功能扩展了Bios的功能
;
;
;DOS 	中断调用:
;
;
;BIOS 	中断调用:
;	int 10h:显示中断
;		00号子功能：设置显示方式
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


assume cs:code,ds:data,ss:stack

stack segment STACK	;关键字STACK可以去除link警告：无STACK段
			;关键字STACK还可以自动使SS:SP指向此堆栈段
	dw	16 dup(0)
stack ends

data segment
	db '1. display      '
	db '2. brows        '
	db '3. replace      '
	db '4. modify       '
data ends

code segment

start:	
	mov ax,data
	mov ds,ax
	mov bx,0

	mov al,3
	mov ah,0
	int 10h

	mov ax,4c00h	;程序优雅退出
	int 21h

code ends

end start


