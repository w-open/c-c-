;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p184 检测点9.2
;
;	补全程序，利用loop指令，实现在内存2000h段中查找第一个值为0的
;字节，找到后，将它的偏移地址存储在dx中
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code

code segment

start:	mov ax,2000h
	mov ds,ax
	mov bx,0

s:	mov cl,[bx]
	mov ch,0
	inc cx
	inc bx
	loop s

ok:	dec bx
	mov dx,bx

	mov ah,4ch
	int 21h

code ends

end start

