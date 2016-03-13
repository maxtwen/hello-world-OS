print_string:
	pusha
	mov ah, 0x0e
	call _print
	popa
	ret

_print:
	mov al, [bx]
	int 0x10
	inc bx
	cmp byte [bx], 0
	jne _print
	ret