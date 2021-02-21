;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p257	检测点13.1
;
;
;（2）用7ch中断例程完成jmp near ptr s指令的功能，用bx向中断例程传送转
;移位移
;
;应用举例：在屏幕的第12行，显示data段中以0结尾的字符串
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


assume cs:code,ds:data

data segment
	db 'conversation',0
data ends
	
code segment

start:	mov ax,cs
	mov ds,ax
	mov si,OFFSET int_jmp

	mov ax,0
	mov es,ax
	mov di,200h

	mov cx,OFFSET int_jmpend - OFFSET int_jmp
	cld
	rep movsb

	mov ax,0
	mov es,ax
	mov word ptr es:[7ch*4],200h
	mov word ptr es:[7ch*4+2],0

	;调用中断例程，进行测试
	mov ax,data
	mov ds,ax
	mov si,0

	mov ax,0b800h
	mov es,ax
	mov di,12*160

s:	cmp byte ptr [si],0
	je ok				;如果是0则跳出循环
	mov al,[si]
	mov es:[di],al
	inc si
	add di,2

	mov bx,OFFSET s - OFFSET ok	;设置标号ok到标号s的转移位移
	int 7ch				;转移到标号s处
	
ok:	mov ax,4c00h
	int 21h

int_jmp:
	push bp
	mov bp,sp
	add [bp+2],bx
	pop bp
	iret
int_jmpend:
	nop
code ends

end start

