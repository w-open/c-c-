;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p208 实验10 编写子程序
;
;	2、解决除法溢出的问题
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code,ds:data,ss:stack

stack segment STACK
	dw 128 dup (0ffffh)
stack ends

data segment
	db 'welcome to masm!',0
data ends

code segment
	
start:	mov ax,stack
	mov ss,ax
	mov sp,100h		;初始化栈空间

	mov ax,data
	mov ds,ax
	mov si,0		;初始化数据段

	mov dx,9876h
	mov ax,5432h
	mov cx,10
	call divdw

	mov ax,4c00h
	int 21h


;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;名称：divdw
;功能：进行不会产生溢出的除法运算，被除数为dword型，除数为word型，结果
;      为dword型
;参数：	(dx)=dword型数据的高16位
;	(ax)=dword型数据的低16位
;	(cx)=除数
;
;返回：	(dx)=结果的高16位
;	(ax)=结果的低16位
;	(cx)=余数
;
;公式：(X/N)=INT(H/N)*65536+[REM(H/N)*65536+L]/N
;	其中，int()取商,rem()取余数
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
divdw:
	push bx
	push di
	
	mov di,ax	;保存低16位
	
	mov ax,dx
	mov dx,0
	div cx

	mov bx,ax	;保存高16位除法的商	

	mov ax,di
	div cx

	mov cx,dx	;返回结果
	mov dx,bx

	pop di
	pop bx
	ret
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

code ends

end start