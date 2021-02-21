;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p234 实验11 编写子程序
;
;	编写一个子程序，将包含任意字符，以0结尾的字符串中的小写字母转变
;为大写字母。
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code,ds:data,ss:stack

stack segment STACK
	dw 128 dup (0)
stack ends

data segment
	db "Beginner's All-purpose Symbolic Instruction Code.",0
data ends

code segment

main:	mov ax,data
	mov ds,ax
	mov si,0

	call clear_screen

	mov dh,0
	mov dl,0
	mov cl,02h
	call show_str

	
	call letterc

	mov dh,2
	mov dl,0
	mov cl,02h
	call show_str

	call debug_show

	mov ax,4c00h
	int 21h

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;名称：letterc
;功能：将以0结尾的字符串中的小写字母转变为大写字母
;
;参数：	ds:si指向字符串的首地址
;
;返回：	无
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
letterc:
	push cx
	push si

	mov ch,0
letter_scan:
	mov cl,[si]
	jcxz letterc_exit
	cmp cl,'a'
	jb letter_next
	cmp cl,'z'
	ja letter_next
	
	and cl,11011111B
	mov [si],cl
	
letter_next:
	inc si
	jmp short letter_scan
	
letterc_exit:
	pop si
	pop cx

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