;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p242 程序12.1	编程处理0号中断
;
;	编程：当发生除法溢出时，在屏幕中间显示“overflow!”,返回DOS。
;	
;背景知识：
;	由于CPU随时都可能检测到中断信息，也就是说，CPU随时都可能执行中
;断处理程序，所以中断处理程序必须一直存储在内存某段空间中。而中断处理
;程序的入口地址，即中断向量，必须存储在对应的中断向量表表项中.
;
;	在8086CPU中，内存0000:0000~0000:03FF，大小为1KB的空间是系统存放
;中断处理程序入口地址的中断向量表。
;	一般情况下，从0000:0200~0000:02FF的256个字节的内存空间所对应的
;中断向量表表项是空的，操作系统和其它应用程序都不占用。
;
;编写步骤：
;（1）编写可以显示“overflow!”的中断处理程序：do0;
;（2）将do0送入内存0000:0200处；
;（3）将do0的入口地址0000:0200存储在中断向量表的0号表项中；
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code

code segment

start:	;do0安装程序

	mov ax,cs
	mov ds,ax
	mov si,OFFSET do0	;设置ds:si指向源地址

	mov ax,0
	mov es,ax
	mov di,200h		;设置es:di指向目的地址

	mov cx,OFFSET do0end - OFFSET do0	;设置cx为传输长度

	cld			;设置传输方向为正
	rep movsb
	
	;设置中断向量表
	mov ax,0
	mov es,ax
	mov word ptr es:[0*4],200h
	mov word ptr es:[0*4+2],0

	mov ax,4c00h
	int 21h


do0:	;显示字符串“overflow!”
	jmp short do0start
	db "overflow!"

do0start:
	mov ax,cs
	mov ds,ax
	mov si,202h		;设置ds:si指向字符串

	mov ax,0b800h
	mov es,ax
	mov di,12*160+50*2	;设置es:si指向显存空间的中间位置

	mov cx,9		;设置cx为字符串长度
do0_s:	mov al,[si]
	mov es:[di],al
	inc si
	add di,2
	loop do0_s

	mov ax,4c00h		;返回DOS
	int 21h
	
do0end:	nop

code ends

end start
