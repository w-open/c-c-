;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p305 7.3 字符串的输入
;	
;	编写一个接收字符串输入的子程序，实现(最基本的字符串输入程序，需要
;具备下面的功能)：	
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code,ds:data

data segment
	db 80 dup (0)
data ends

code segment

start:	mov ax,data
	mov ds,ax
	mov si,0

	mov dh,2
	mov dl,2

	call clear_screen
	
	call getstr

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
;名称：getstr；
;功能：接收字符串输入，实现：
;	(1)在输入的同时需要显示这个字符串
;	(2)一般在输入回车符之后，字符串输入结束
;	(3)能够删除已经输入的字符
;
;参数：(dh)、(dl)=字符串在屏幕上显示的行、列位置
;      ds:si指向字符串的存储位置，字符串以0为结尾符
;返回：无
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
getstr:	push ax

getstrs:
	mov ah,0
	int 16h

	cmp al,20h
	jb nochar	;ASCII码小于20h,说明不是字符
	mov ah,0
	call charstack	;字符入栈
	mov ah,2
	call charstack	;显示栈中的字符
	jmp getstrs

nochar:	cmp ah,0eh	;退格键的扫描码
	je backspace
	cmp ah,1ch	;Enter键的扫描码
	je enter
	jmp getstrs

backspace:
	mov ah,1
	call charstack	;字符出栈
	mov ah,2
	call charstack	;显示栈中的字符
	jmp getstrs

enter:	mov al,0
	mov ah,0
	call charstack	;0入栈
	mov ah,2
	call charstack	;显示栈中的字符

	pop ax
	ret
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;名称：charstack；
;功能：字符栈的入栈、出栈和显示
;参数：(ah)=功能号，0表示入栈，1表示出栈，2表示显示
;	ds:si指向字符栈空间
;	对于0号功能：(al)=入栈字符
;	对于1号功能：(al)=返回字符
;	对于2号功能：(dh)、(dl)=字符串在屏幕上显示的行、列位置
;
;
;返回：无
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
charstack:
	jmp short charstart

table	dw charpush,charpop,charshow
top	dw 0				;栈顶

charstart:
	push bx
	push dx
	push di
	push es

	cmp ah,2
	ja sret
	mov bl,ah
	mov bh,0
	add bx,bx
	jmp word ptr table[bx]

charpush:
	mov bx,top
	mov [si][bx],al
	inc top
	jmp sret

charpop:
	cmp top,0
	je sret
	dec top
	mov bx,top
	mov al,[si][bx]
	jmp sret

charshow:
	mov bx,0b800h
	mov es,bx
	mov al,160
	mov ah,0
	mul dh
	mov di,ax
	add dl,dl
	mov dh,0
	add di,dx

	mov bx,0

charshows:
	cmp bx,top
	jne noempty
	mov byte ptr es:[di],' '
	jmp sret
noempty:
	mov al,[si][bx]
	mov es:[di],al
	mov byte ptr es:[di+2],' '
	inc bx
	add di,2
	jmp charshows

sret:	pop es
	pop di
	pop dx
	pop bx
	ret
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

code ends

end start