assume cs:code_sg

code_sg segment
	mov ax,0123h
	mov bx,0456h
	add ax,bx
	add ax,ax
	
	mov ax,4c00h
	int 21h
	
code_sg ends

end

