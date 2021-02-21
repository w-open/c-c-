;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p291	检测点16.2
;
;	下面的程序将data段中a处的8个数据累加，结果存储到b处的字中，
;补全程序.
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code,ds:data

data segment
	a db 1,2,3,4,5,6,7,8
	b dw 0
data ends

code segment
start:	mov ax,data
	mov ds,ax

	mov si,0
	mov cx,8
	mov ah,0
s:	mov al,a[si]
	add b,ax
	inc si
	loop s

	mov ax,4c00h
	int 21h

code ends

end start