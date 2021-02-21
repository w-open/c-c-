;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p283	15.5 安装新的int 9中断例程
;
;任务：安装一个新的int 9中断例程
;功能：在DOS下，按F1键后改变当前屏幕的显示颜色，其他的键照常处理
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code,ss:stack

stack segment
	db 128 dup (0)
stack ends

code segment
start:	mov ax,stack
	mov ss,ax
	mov sp,128

	push cs
	pop ds

	mov ax,0
	mov es,ax

	mov si,OFFSET int9
	mov di,204h
	mov cx,OFFSET int9end - OFFSET int9
	cld
	rep movsb

	push es:[9*4]
	pop es:[200h]
	push es:[9*4+2]
	pop es:[202h]

	cli
	mov word ptr es:[9*4],204h
	mov word ptr es:[9*4+2],0
	sti

	mov ax,4c00h
	int 21h

int9:	push ax
	push bx
	push cx
	push es

	in al,60h

	pushf
	call dword ptr cs:[200h]

	cmp al,3bh
	jne int9ret

	mov ax,0b800h
	mov es,ax
	mov bx,1
	mov cx,2000
int9s:	inc byte ptr es:[bx]
	add bx,2
	loop int9s

int9ret:pop es
	pop cx
	pop bx
	pop ax

	iret

int9end:nop


code ends

end start
	
