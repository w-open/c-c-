;p121 实验4 习题1 习题2

assume cs:code

code segment

	mov ax,20h
	mov ds,ax		;(ds)=20h

	mov bx,0		;(bx)=0, ds:bs->0020:0

	mov cx,40h		
s:	mov ds:[bx], bx
	inc bx
	loop s

	mov ax,4c00h
	int 21h

code ends

end