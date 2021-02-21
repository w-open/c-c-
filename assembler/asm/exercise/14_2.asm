;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p269 检测点14.2
;
;	编程，用加法和移位指令计算(ax)=(ax)*10
;	提示：(ax)*10=(ax)*2+(ax)*8
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code

code segment
start:	mov ax,4
	mov bx,ax	;保存原始值
	
	shl ax,1
	mov dx,ax	;保存2倍值

	mov ax,bx	;恢复旧值
	mov cl,3
	shl ax,cl	;左移三位

	add ax,dx

	mov ax,4c00h
	int 21h
	
code ends

end start



