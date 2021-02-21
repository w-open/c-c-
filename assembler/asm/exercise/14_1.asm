;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;p267 检测点14.1
;
;(1)编程，读取CMOS RAM中的2号单元的内容
;(2)编程，向CMOS RAM中的2号单元写入0
;
;背景信息：CMOS RAM芯片有2个端口，端口地址分别是70H,71H
;	其中，70H为地址端口，存放要访问的CMOS RAM单元的地址
;	      71H为数据端口，存放从选定的CMOS RAM单元总读取的数据，或
;			要写入到其中的数据
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assume cs:code

code segment
start:	mov al,02h
	out 70h,al	;选定CMOS RAM芯片的2号内存单元

	in al,71h	;读取CMOS RAM芯片的2号内存单元

	mov al,00h
	out 71h,al	;向CMOS RAM芯片的2号内存单元写入

	mov ax,4c00h
	int 21h
	
code ends

end start


