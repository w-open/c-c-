;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;练习：打印标志寄存器flag的各标志位的值
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code,ds:data,ss:stack

stack segment STACK
	dw 128 dup (0ffffh)
stack ends

data segment
	str_buf	db 79 dup (' '),0
data ends

code segment

main:	mov ax,stack
	mov ss,ax
	mov sp,100h		;初始化栈空间(可有可无)

	mov ax,data
	mov ds,ax
	mov si,0		;初始化数据段

	call clear_screen
	
	call print_flag_reg

	mov dh,2
	mov dl,0
	mov cl,02h

	call show_str

	call debug_show

	mov ax,4c00h
	int 21h
	
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;名称：print_flag_reg
;功能：将标志寄存器flag中的各标志位“打印”到字符缓冲区
;
;参数：	ds:si指向字符串缓冲区的首地址
;
;返回：	无
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
print_flag_reg:
	push ax
	push cx
	push si


	pushf
	pop cx		;获取标志寄存器的值
	mov ax,cx	;保留标志寄存器的有效值
	
	mov word ptr ds:[si],'FO'
	mov byte ptr ds:[si+2],':'
	add si,3
	and cx,0800h
	call print_bit_value

	inc si
	mov word ptr ds:[si],'FD'
	mov byte ptr ds:[si+2],':'
	add si,3
	and cx,0400h
	call print_bit_value
	

	pop si
	pop cx
	pop ax

	ret
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;print_flag_reg的子函数analyze_bit_value
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
analyze_bit_value:



	ret
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;print_flag_reg的子函数print_bit_value
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
print_bit_value:
	jcxz short pbv_zero
	mov byte ptr ds:[si],'1'
	jmp short pbv_exit

pbv_zero:
	mov byte ptr ds:[si],'0'

pbv_exit:
	inc si
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

end main
