;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p271	实验14 访问CMOS RAM
;
;	编程：以“年/月/日 时:分:秒”的格式，显示当前的日期，时间。
;
;	注意：CMOS RAM中存储着系统的配置信息，除了保存时间信息的单元外，
;不要向其它的单元中写入内容，否则将引起一些系统错误。
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code,ds:data,ss:stack

stack segment STACK
	dw 128 dup (0)
stack ends

data segment
time	db '00/00/00 00:00:00','$'
address db 9,8,7,4,2,0
data ends

code segment
start:	mov ax,stack
	mov ss,ax
	mov sp,256

	mov ax,data
	mov ds,ax
	mov si,OFFSET address

	mov es,ax
	mov di,OFFSET time

	mov cx,6
s:	mov al,ds:[si]
	call read_time
	mov es:[di],ah
	mov es:[di+1],al
	inc si
	add di,3
	loop s

	call clear_screen

	mov ah,2
	mov bh,0
	mov dh,5
	mov dl,12
	int 10h

	mov dx,OFFSET time
	mov ah,9
	int 21h


	call debug_show

	mov ax,4c00h
	int 21h

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;名称：read_time
;功能：读取CMOS RAM中存储的时间信息(年、月、日、时、分、秒)子项
;参数：(al)=时间子项的地址
;返回：(ah)=时间子项的高位十进制数 ASCII码
;      (al)=时间子项的低位十进制数 ASCII码
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
read_time:
	push cx
	
	out 70h,al
	in al,71h

	mov ah,al
	mov cl,4
	shr ah,cl
	and al,00001111b

	add ah,30h
	add al,30h
	
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




