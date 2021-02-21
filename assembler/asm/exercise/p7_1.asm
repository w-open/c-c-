;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p172:	实验7
;
;	寻址方式在访问结构化数据中的应用
;
;编程，将data段中的数据按照所要求的格式填写到table段中
;
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code, ds:data

stack segment STACK
	dw 8 dup (0ffffh)
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
data ends

table segment
		   ;0123456789abcdef
	db 21 dup ('year summ ne ?? ')
table ends

code segment

start:	mov ax,data
	mov ds,ax

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
	
	mov ah,4ch
	int 21h

code ends

end start





