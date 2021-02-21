;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p183 检测点9.1 (1)
;
; 若要使程序中的jmp指令执行后，CS:IP指向程序中的第一条指令，在data段中
;应该定义哪些数据？
;	想要跳转到CS:0处，只需要将相对应的data数据区设置为0即可。
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:codesg

datasg segment
	db 16 dup (0)
datasg ends

codesg segment

start:	mov ax,datasg
	mov ds,ax
	mov bx,0
	jmp word ptr [bx+1]
	
codesg ends

end start

