;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p187 实验9 根据材料编程
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


stack segment STACK
	dw 64 dup (0ffffh)
stack ends


data segment
	db 'welcome to masm!'	;16个字符
	db 00000010b		;绿色
	db 00100100b		;绿底红色
	db 01110001b		;白底蓝色
	
;定义显示字符的起始位置
row	EQU 15			;起始行
column	EQU 20			;起始列
pos	EQU 80*2*(row-1)+2*(column-1)	;显示字符的缓冲区起始位置

data ends



code segment

	assume cs:code,ds:data,ss:stack
	
start:	mov ax,data
	mov ds,ax		;寄存器ds指向数据段的段基址

	mov ax,0b800h
	mov es,ax		;寄存器es指向显示缓冲区的起始地址


	mov bx,0		;一般情况下，显示第0页的内容，故清屏
	mov cx,2000
clean:	mov byte ptr es:[bx],0
	add bx,2
	loop clean
	

	mov bx,pos		;设置显示位置
	mov bp,16		;遍历显示属性

	mov cx,3

disp:	push cx

	mov si,0
	mov di,0
	mov cx,16

mess:	mov al,[si]
	mov ah,ds:[bp]
	mov es:[bx+di],ax
	inc si
	add di,2
	loop mess

	add bx,160
	inc bp
	pop cx
	loop disp

	mov ax,4c00h
	int 21h
	
code ends

end start