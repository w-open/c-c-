;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p183 检测点9.1 (2)
;
;	补全程序，使得jmp指令执行后，CS:IP指向程序的第一条指令。 
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:codesg

datasg segment
	dd 12345678h
datasg ends

codesg segment

start:	mov ax,datasg
	mov ds,ax
	mov bx,0
	mov [bx],bx
	mov [bx+2],cs
	jmp dword ptr ds:[0]
	
codesg ends

end start


