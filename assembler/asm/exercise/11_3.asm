;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p229 检测点11.3
;
;	（1）补全下面的程序，统计F000:0处的32个字节中，大小在[32,128]
;的数据的个数
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


assume cs:code,ds:data

data segment
	db 1,3,4,32,128,0
data ends

code segment

main:	mov ax,data
	mov ds,ax

	mov bx,0
	mov dx,0
	mov cx,32

s:	mov al,[bx]
	cmp al,32
	jb s0
	cmp al,128
	ja s0
	inc dx
s0:	inc bx
	loop s

	mov ax,4c00h
	int 21h
code ends

end main