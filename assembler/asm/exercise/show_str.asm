;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p206 实验10 编写子程序
;
;	编程：在屏幕中间分别显示绿色、绿底红色、白底蓝色的字符串
;"welcome to masm!"。
;
;背景知识：
;	25*80的彩色字符模式显示缓冲区：内存地址空间为B8000H~BFFFFH;向这
;个地址空间中写入数据，所写的内容将立即出现在显示器上。
;
;	一个字符在显示缓冲区中要占2各字符，分别存放字符的ASCII码和显示属
;性。在显示缓冲区中，偶地址存放字符，奇地址存放字符的显示属性。
;
;	一个字符的显示属性：前景色、背景色、闪烁及高亮等信息记录在属性字
;节中，属性字节的格式为：
;	7	6	5	4	3	3	1	0
;含义：	BL	R	G	B	I	R	G	B	
;     -----    ---------------------  -----    ---------------------
;	闪烁		背景色            高亮	     前景色
;
;	(补充：黑色RGB=000，白色RGB=111)
;	
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;1、显示字符串
;	显示字符串是现实工作中经常要用到的功能，应该编写一个通用的子程序
;来实现这个功能。我们应该提供灵活的调用接口，使调用者可以决定显示的位置
;（行，列）、内容和颜色。
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code,ds:data,ss:stack

stack segment STACK
	dw 128 dup (0ffffh)
stack ends

data segment
	db 'welcome to masm!',1000 dup ('?')
	db 25 dup ('@'),0
data ends

code segment
	
start:	mov ax,stack
	mov ss,ax
	mov sp,100h		;初始化栈空间

	mov ax,data
	mov ds,ax
	mov si,0

	call clear_screen
	
	mov dh,0
	mov dl,0
	mov cl,2
	call show_str

	call debug_show

	mov ax,4c00h
	int 21h

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