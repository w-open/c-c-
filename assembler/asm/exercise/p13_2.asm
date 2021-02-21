;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p262	实验13 编写、应用中断例程
;
;(2)编写并安装int 7ch中断例程，功能为完成loop指令的功能。
;
;参数：(cx)=循环次数，(bx)=位移
;
;	在屏幕的中间显示80个“！”
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code,ds:data

data segment
	db 'conversation',0
data ends
	
code segment

start:	mov ax,cs
	mov ds,ax
	mov si,OFFSET int_loop

	mov ax,0
	mov es,ax
	mov di,200h

	mov cx,OFFSET int_loopend - OFFSET int_loop
	cld
	rep movsb

	mov ax,0
	mov es,ax
	mov word ptr es:[7ch*4],200h
	mov word ptr es:[7ch*4+2],0

	;调用中断例程，进行测试
	call clear_screen
	
	mov ax,0b800h
	mov es,ax
	mov di,12*160

	mov bx,OFFSET s - OFFSET se	;设置标号se到标号s的转移位移
	mov cx,83
s:	mov byte ptr es:[di],'!'
	add di,2
	int 7ch				;如果(cx)!=0,则转移到标号s处
se:	nop
	
	call debug_show
	mov ax,4c00h
	int 21h

int_loop:
	push bp
	mov bp,sp
	dec cx
	jcxz int_loop_exit
	add [bp+2],bx
int_loop_exit:
	pop bp
	iret
int_loopend:
	nop

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





