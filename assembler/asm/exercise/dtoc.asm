;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p209 实验10 编写子程序
;
;3、数值显示
;
;	应用举例：编程，将数据12666以十进制的形式在屏幕的8行3列，用绿色显示
;出来。在显示时，可调用本次实验中的第一个子程序show_str.
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code,ds:data,ss:stack

stack segment STACK
	dw 128 dup (0ffffh)
stack ends

data segment
	db 16 dup (0)
data ends

code segment
	
start:	mov ax,stack
	mov ss,ax
	mov sp,100h		;初始化栈空间

	mov ax,data
	mov ds,ax
	mov si,0		;初始化数据段

	mov dx,654H
	mov ax,678H
	call dtoc

	call clear_screen
	
	mov dh,8
	mov dl,3
	mov cl,2
	call show_str

	call debug_show
	
	mov ax,4c00h
	int 21h

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;名称：dtoc
;功能：将dword型数据转变为表示十进制的字符串，字符串以0为结尾符
;
;参数：	(dx)=dword型数据的高16位
;	(ax)=dword型数据的低16位
;	ds:si指向字符串的首地址
;
;返回：	无
;
;注意：调用此函数需要包含子程序divdw，以实现无溢出除法计算
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
dtoc:	
	push ax
	push bx
	push cx
	push dx
	push si

	mov bx,0	;统计十进制数中的数值位	

dtoc_div:
	mov cx,0ah
	call divdw
	push cx		;首先保存余数
	inc bx

	mov cx,0	;判断商是否为0
	mov cx,dx
	or cx,ax
	jcxz dtoc_conv

	jmp short dtoc_div


dtoc_conv:
	mov cx,bx
dtoc_loop:
	pop bx
	add bx,30h
	mov ds:[si],bl
	inc si
	loop dtoc_loop
	;mov byte ptr ds:[si],0		;确保字符串以0为结尾符
	
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	
	ret
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;名称：divdw
;功能：进行不会产生溢出的除法运算，被除数为dword型，除数为word型，结果
;      为dword型
;参数：	(dx)=dword型数据的高16位
;	(ax)=dword型数据的低16位
;	(cx)=除数
;
;返回：	(dx)=结果的高16位
;	(ax)=结果的低16位
;	(cx)=余数
;
;公式：(X/N)=INT(H/N)*65536+[REM(H/N)*65536+L]/N
;	其中，int()取商,rem()取余数
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
divdw:
	push bx
	push di
	
	mov di,ax	;保存低16位
	
	mov ax,dx
	mov dx,0
	div cx

	mov bx,ax	;保存高16位除法的商	

	mov ax,di
	div cx

	mov cx,dx	;返回结果
	mov dx,bx

	pop di
	pop bx
	ret
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
;名称：show_str；
;功能：在指定的位置，用指定的颜色，显示一个用0结束的字符串；
;参数：(dh)=行号(取值范围0~24)，(dl)=列号(取值范围0~79)，
;      (cl)=颜色，ds:si指向字符串的首地址
;返回：无
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
show_str:
	push ax
	push cx
	push dx
	push es
	push si
	push di

	mov ax,0b800h		;使es:di指向显示字符的缓冲区起始位置
	mov es,ax

	mov al,160
	mul dh
	mov di,ax

	mov al,2
	mul dl
	add di,ax

	and cl,00000111b	;设置字符显示属性
	mov al,cl		;al暂存字符颜色

	mov ch,0
ss_display:
	mov cl,[si]
	jcxz ss_exit
	mov es:[di],cl
	mov es:[di+1],al
	add di,2
	inc si
	jmp short ss_display
ss_exit:	
	pop di
	pop si
	pop es
	pop dx
	pop cx
	pop ax

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