;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p282	检测点15.1
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code,ds:data,ss:stack

stack segment STACK
	dw 128 dup (0)
stack ends

data segment
	dw 0,0
data ends

code segment
start:	mov ax,stack
	mov ss,ax
	mov sp,256

	mov ax,data
	mov ds,ax

	mov ax,0
	mov es,ax

	push es:[9*4]
	pop ds:[0]
	push es:[9*4+2]
	pop ds:[2]	;将原来的int 9中断例程的入口地址保存在ds:0,ds:2单元中

	cli
	mov word ptr es:[9*4],OFFSET int9
	mov word ptr es:[9*4+2],cs	;在中断向量表中设置新的int 9中断例程的入口地址
	sti

	call clear_screen
	
	mov ax,0b800h
	mov es,ax
	mov ah,'a'
s:	mov es:[160*12+40*2],ah
	call delay
	inc ah
	cmp ah,'z'
	jna s

	mov ax,0
	mov es,ax

	push ds:[0]
	pop es:[9*4]
	push ds:[2]
	pop es:[9*4+2]	;将中断向量表中int 9中断例程的入口恢复位原来的地址
	
	;call debug_show

	mov ax,4c00h
	int 21h

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;名称：delay
;功能：CPU执行无意义操作，延时一段时间
;参数：无
;返回：无
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
delay:	push ax
	push dx

	mov dx,000ah
	mov ax,0FFFFh

delay_s:sub ax,1
	sbb dx,0
	cmp ax,0
	jne delay_s
	cmp dx,0
	jne delay_s

	pop dx
	pop ax

	ret
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;名称：新的int 9中断例程
;功能：
;参数：无
;返回：无
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
int9:	push ax
	push bx
	push es

	in al,60h

	pushf

	;在进入中断例程后，IF和TF都已经设置为0，没有必要再进行设置了。
	;pushf
	;pop bx
	;and bh,11111100b
	;push bx
	;popf
	call dword ptr ds:[0]	;对int指令进行模拟，调用原来的int 9中断例程

	cmp al,1
	jne int9ret

	mov ax,0b800h
	mov es,ax
	inc byte ptr es:[160*12+40*2+1]		;将属性值加1，改变颜色

int9ret:pop es
	pop bx
	pop ax
	iret
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;名称：clear_screen；
;功能：清除屏幕显示内容
;参数：无
;返回：无
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
clear_screen:
	push es
	push di
	push cx
	
	mov di,0b800h
	mov es,di
	mov di,0		;使es:di指向显存的首地址

	mov cx,4000h		;将显存地址空间B8000H~BFFFFH清空
clean:	mov byte ptr es:[di],0
	add di,2
	loop clean

	pop cx
	pop di
	pop es

	ret
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;名称：debug_show；
;功能：循环检测，按Esc键则退出循环
;参数：无
;返回：无
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
debug_show:
	push ax
	
ds_check:	
	in al,60h
	cmp al,81h
	je ds_exit
	jmp short ds_check

ds_exit:	
	pop ax
	ret
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
code ends

end start





