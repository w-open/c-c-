;P113

assume cs:code

code segment
	mov ax,0ffffh
	mov ds,ax

	mov bx,0	;设置偏移量初始值
	mov dx,0	;初始化累加器

	mov ah,0	;set ah = 0

	mov cx,12	; init loop count
s:	mov al,[bx]
	add dx,ax
	inc bx
	loop s

	mov ax,4c00h
	int 21h

code ends

end
