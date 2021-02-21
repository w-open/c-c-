;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;P191:检测点10.1
;
;	补全程序，实现从内存1000:000处开始执行指令
;
;
;
;
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code

stack segment STACK
	db 16 dup (0)
stack ends

code segment

start:	mov ax,stack
	mov ss,ax
	mov sp,16
	mov ax,1000h
	push ax
	mov ax,0
	push ax
	retf
code ends

end start	