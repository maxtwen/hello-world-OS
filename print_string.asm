print_string:
	pusha
	pushf
	mov ah, 0x0e
	mov si, bx
	call _print_next_char
	popa
	popf
	ret

_print_next_char:
	lodsb
	cmp al, 0
	jne .print
	ret
	.print:
		int 0x10
		jmp _print_next_char
