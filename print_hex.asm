
HexDigit:
	cmp dl, 10
	jb .less
	add dl,'A'-12O
	ret
	.less:
	or dl, '0'
	ret 

print_hex:
	pusha
	pushf
	mov di, HEX_OUT
	xor ecx, ecx
	xor ebx, ebx
	mov bl, 0x10

	.divide:
	xor	edx, edx
	div bx

	;add dl,'A'-12O
	call HexDigit
	push edx
	inc ecx
	or eax, eax
	jnz .divide

	.reverse:
	pop eax
	stosb
	loop .reverse
	mov bx, HEX_OUT
	call print_string
	popa
	popf
	ret

HEX_OUT: db "0000", 0