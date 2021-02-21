;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p211 课程设计1
;
;	任务：将实验7中的Power idea公司的数据按照图10.2所示的格式在屏幕
;上显示出来。
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code,ds:data,ss:stack

stack segment STACK
	dw 128 dup (0ffffh)
stack ends

data segment
	db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
	db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
	db '1993','1994','1995'
	;以上是表示21年年份的21个字符串

	dd 	16,	22,	382,	1356,	2390,	8000,	16000,	24486
	dd	50065,	97479,	140417,	197514,	345980,	590827,	803530,	1183000
	dd	1843000,2759000,3753000,4649000,5937000
	;以上是表示21年公司总收入的21个dword型数据

	dw	3,	7,	9,	13,	28,	38,	130,	220
	dw	476,	778,	1001,	1442,	2258,	2793,	4037,	5635
	dw	8226,	11542,	14430,	15257,	17800
	;以上是表示21年公司雇员人数的21个word型数据

str_buf	db 79 dup (' '),0
row_num	dw 0
data ends

table segment
		   ;0123456789abcdef
	db 21 dup ('year summ ne ?? ')
table ends

code segment
	
start:	mov ax,stack
	mov ss,ax
	mov sp,100h		;初始化栈空间

	mov ax,data
	mov ds,ax
	mov si,0		;初始化数据段

	mov ax,table
	mov es,ax

	mov bx,0	;遍历talbe中的每一行
	mov bp,0	;遍历21年数据中的每一组
	mov cx,21
s_y:	push cx

	mov cx,4
	mov si,0
s_year: mov al,ds:[bp+si]
	mov es:[bx+si],al
	inc si
	loop s_year
	
	pop cx
	add bx,16
	add bp,4
	loop s_y

	mov bx,0	;遍历talbe中的每一行
	mov bp,0	;遍历21年数据中的每一组
	mov cx,21
	
s_s:	push cx
	mov si,0
	mov cx,2
s_summ:	mov ax,ds:[84+bp+si]
	mov es:[bx+5+si],ax
	add si,2
	loop s_summ

	pop cx
	add bx,16
	add bp,4
	loop s_s

	mov bx,0	;遍历talbe中的每一行
	mov bp,0	;遍历21年数据中的每一组
	mov cx,21
	
s_n:	mov ax,ds:[168+bp]
	mov es:[bx+10],ax
	
	add bx,16
	add bp,2
	loop s_n


	mov bx,0	;遍历talbe中的每一行
	mov cx,21
	
s_?:	mov dx,es:[bx+7]
	mov ax,es:[bx+5]
	div word ptr es:[bx+10]
	mov es:[bx+0dh],ax
	
	add bx,16
	loop s_?

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;以下代码用于显示内容
;		   ;0123456789abcdef
;	db 21 dup ('year summ ne ?? ')
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	call clear_screen

	mov cx,21
	mov word ptr row_num,0	;显示的行号
	mov bx,0		;遍历table表中的每一行数据

disp_loop:
	push cx
	
	mov di,OFFSET str_buf
	mov si,0
	mov cx,2	;复制4字节的年份
disp_year:
	mov ax,es:[bx+si]
	mov ds:[di],ax
	add si,2
	add di,2
	loop disp_year

	mov ax,es:[bx+5]
	mov dx,es:[bx+7]
	mov si,10 + OFFSET str_buf 
	call dtoc

	mov ax,es:[bx+0ah]
	mov dx,0
	mov si,20 + OFFSET str_buf 
	call dtoc

	mov ax,es:[bx+0dh]
	mov dx,0
	mov si,30 + OFFSET str_buf 
	call dtoc

	mov dh,row_num
	mov dl,0
	mov cl,02
	mov si,OFFSET str_buf
	call show_str

	inc word ptr row_num,1
	add bx,16
	pop cx
	loop disp_loop

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