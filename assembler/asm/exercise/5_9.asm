;p121

assume cs:code

code segment

	mov ax,0ffffh
	mov ds,ax		;(ds)=0ffffh

	mov ax,0020h
	mov es,ax		;(es)=0020h

	mov bx,0		;(bx)=0, ds:bs->ffff:0 es:bx->0020:0

	mov cx,12		;(cx)=0, 12 count loop
s:	mov dl,ds:[bx]
	mov es:[bx],dl
	inc bx
	loop s

	mov ax,4c00h
	int 21h

code ends

end

