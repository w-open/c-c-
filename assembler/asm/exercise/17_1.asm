;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p303 7.2 使用int 16h中断例程读取键盘缓冲区
;
;	编程，接收用户的键盘输入，输入“r”，将屏幕上的字符设置为红色；输入
;“g”，将屏幕上的字符设置为绿色；输入“b”，将屏幕上的字符设置为蓝色
;
;	背景知识：BIOS的int 9中断例程和int 16h中断例程是一对相互配合的程
;序，int 9中断例程向键盘缓冲区中写入，int 16h中断例程从缓冲区中读出。它们
;写入和读出的时机不同，int 9中断例程是在有键按下的时候向键盘缓冲区中写入
;数据；而int 16h中断例程是在应用程序对其进行调用的时候，将数据从键盘缓冲区
;中读出。
;
;	因此，我们在编写一般的处理键盘输入的程序的时候，可以调用int 16h
;从键盘缓冲区读取键盘的输入。
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code

code segment

start:	mov ah,0
	int 16h

	mov ah,1
	cmp al,'r'
	je red
	cmp al,'g'
	je green
	cmp al,'b'
	je blue
	jmp short sret

red:	shl ah,1
green:	shl ah,1
blue:	mov bx,0b800h
	mov es,bx
	mov bx,1
	mov cx,2000
s:	and byte ptr es:[bx],11111000b
	or es:[bx],ah
	add bx,2
	loop s

sret:	mov ax,4c00h
	int 21h

code ends

end start
	