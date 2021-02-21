;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;P195:检测点10.5		转移地址在内存中的call指令
;
;	下面的程序执行后，ax和bx中的数值是多少？
;
;	ax=1,bx=0
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code

stack segment STACK
	db 16 dup (0)
stack ends

code segment
	
start:	mov ax,stack
	mov ss,ax
	mov sp,16
	mov word ptr ss:[0],offset s
	mov ss:[2],cs
	call dword ptr ss:[0]
	nop
s:	mov ax,offset s
	sub ax,ss:[0ch]
	mov bx,cs
	sub bx,ss:[0eh]

	mov ax,4c00h
	int 21h
code ends

end start	


