;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p285	实验15 安装新的int 9中断例程
;
;安装一个新的int 9中断例程
;功能：在DOS下，按下“A”键后，除非不再松开，如果松开，就显示满屏幕的"A"
;	其他的键照常处理
;
;提示：按下一个键时产生的扫描码称为通码，松开一个键时产生的扫描码称为
;断码。断码=通码+80h
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code,ss:stack

stack segment STACK
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

	cmp al,9eh	;“A”的通码是1EH，则断码是9EH
	jne int9ret

	mov ax,0b800h
	mov es,ax
	mov bx,0
	mov cx,2000
int9s:	mov byte ptr es:[bx],'A'
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
	