;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p262	实验13 编写、应用中断例程
;
;（1）编写并安装int 7ch中断例程，功能为显示一个用0结束的字符串，中断例
;程安装在0:200处
;
;参数：(dh)=行号，(dl)=列号，(cl)=颜色，di:si指向字符串首地址
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


assume cs:code,ds:data

data segment
	db 'Welcome to masm!',0
data ends
	
code segment

start:	mov ax,cs
	mov ds,ax
	mov si,OFFSET int_show_str

	mov ax,0
	mov es,ax
	mov di,200h

	mov cx,OFFSET int_show_str_end - OFFSET int_show_str
	cld
	rep movsb

	mov ax,0
	mov es,ax
	mov word ptr es:[7ch*4],200h
	mov word ptr es:[7ch*4+2],0

	;调用中断例程，进行测试
	mov dh,10	;行号
	mov dl,10	;列号
	mov cl,2	;颜色
	mov ax,data
	mov ds,ax
	mov si,0
	int 7ch
	
	mov ax,4c00h
	int 21h

int_show_str:
	push ax
	push cx
	push dx
	push es
	push si
	push di

	mov ax,0b800h
	mov es,ax

	mov al,160
	mul dh
	mov di,ax
	mov al,2
	mul dl
	add di,ax	;计算显示缓冲区的偏移量

	mov dl,cl	;临时保存字符显示属性

	mov ch,0
str_loop:
	mov cl,[si]
	jcxz int_show_str_exit
	mov es:[di],cl
	mov es:[di+1],dl
	inc si
	add di,2
	jmp short str_loop
	
int_show_str_exit:	
	pop di
	pop si
	pop es
	pop dx
	pop cx
	pop ax
	iret
int_show_str_end:
	nop
code ends

end start


