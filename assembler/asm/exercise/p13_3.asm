;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p262	实验13 编写、应用中断例程
;
;(3)下面的程序，分别在屏幕的第2、4、6、8行显示4句英文诗，补全程序
;
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


assume cs:code, ds:data

data segment
	db 'Welcome to masm!','$'
data ends

code segment
s1:	db 'Good,better,best,','$'
s2:	db 'Never let it rest','$'
s3:	db 'Till good is better','$'
s4:	db 'And better,bset.','$'
s:	dw OFFSET s1,OFFSET s2,OFFSET s3,OFFSET s4
row:	db 2,4,6,8

start:	call clear_screen

	mov ax,cs
	mov ds,ax
	mov bx,OFFSET s
	mov si,OFFSET row

	mov cx,4
ok:	mov bh,0	;第0页
	mov dh,[si]	;行号
	mov dl,0	;列号
	mov ah,2	;子功能号
	int 10h

	mov dx,[bx]
	mov ah,9	;子功能号
	int 21h

	inc si
	add bx,2
	loop ok

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