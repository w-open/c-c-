;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p299	实验16 编写包含多个功能子程序的中断例程
;
;安装一个新的int 7ch中断例程，为显示输出提供如下功能子程序。
;(1)清屏；
;(2)设置前景色；
;(3)设置背景色；
;(4)向上滚动一行。
;
;入口参数说明如下：
;(1)用ah寄存器传递功能号：0表示清屏，1表示设置前景色，2表示设置背景色，
;	3表示向上滚动一行；
;(2)对于1，2号功能，用al传送颜色值，(al)={0,1,2,3,4,5,6,7}。
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

	mov si,OFFSET int7c
	mov di,200h
	mov cx,OFFSET int7cend - OFFSET int7c
	cld
	rep movsb

	cli
	mov word ptr es:[7ch*4],200h
	mov word ptr es:[7ch*4+2],0
	sti

	mov ah,2
	mov al,3
	int 7ch
	
	call debug_show
	
	mov ax,4c00h
	int 21h

	ORG 200H
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;说明：int 7ch中断例程
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
int7c:	push ax

	call setscreen

	pop ax
	iret

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;说明：功能号*2=对应的功能子程序再地址表中的偏移
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
setscreen:
	jmp short set
	
	table dw sub1,sub2,sub3,sub4		;此处有错误，偏移地址是在安装程序中的偏移地址

set:	push bx
	cmp ah,3	;判断功能号是否大于3
	ja sret
	mov bl,ah
	mov bh,0
	add bx,bx	;根据ah中的功能号计算对应子程序在table表中的偏移

	call word ptr table[bx]	;调用对应的功能子程序
	

sret:	pop bx
	ret
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;子程序1：清屏，将显存中当前屏幕中的字符设为空格符
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sub1:	push bx
	push es
	push cx

	mov bx,0b800h
	mov es,bx

	mov bx,0
	mov cx,2000
sub1s:	mov byte ptr es:[bx],' '
	add bx,2
	loop sub1s

	pop cx
	pop es
	pop bx

	ret


;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;子程序2：设置前景色：设置显存中当前屏幕中处于奇地址的属性字节的
;	第0，1，2位
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sub2:	push bx
	push es
	push cx
	
	mov bx,0b800h
	mov es,bx

	mov bx,1
	mov cx,2000
sub2s:	and byte ptr es:[bx],11111000b
	or es:[bx],al
	add bx,2
	loop sub2s

	pop cx
	pop es
	pop bx
	ret

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;子程序3：设置背景色：设置显存中当前屏幕中处于奇地址的属性字节的
;	第4，5，6位
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sub3:	push bx
	push es
	push cx
	
	mov cl,4
	shl al,cl
	
	mov bx,0b800h
	mov es,bx

	mov bx,1
	mov cx,2000
sub3s:	and byte ptr es:[bx],10001111b
	or es:[bx],al
	add bx,2
	loop sub3s

	pop cx
	pop es
	pop bx
	ret
	
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;子程序4：向上滚动一行：依次将第n+1行的内容复制到第n行处，最后一行
;	为空
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sub4:	push cx
	push si
	push di
	push es
	push ds

	mov si,0b800h
	mov ds,si
	mov es,si

	mov si,160	;di:si指向第n+1行
	mov di,0	;es:di指向第n行
	cld
	mov cx,24	;共复制24行
	
sub4s:	push cx
	mov cx,160	
	rep movsb	
	pop cx		
	loop sub4s

	mov cx,80
	mov di,0
sub4s1:	mov byte ptr [160*24+di],' '
	add di,2
	loop sub4s1

	pop ds
	pop es
	pop di
	pop si
	pop cx

	ret

int7cend:nop


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
	