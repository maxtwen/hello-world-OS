; load DH sectors to ES:BX from drive DL
; Store DX on stack so later we can recall ; how many sectors were request to be read,
disk_load:
	push dx
	mov ah, 0x02 
	mov al, dh
	mov ch, 0x00
	mov dh, 0x00
	mov cl, 0x00
	; even
	; BIOS
	; Read
	; Select cylinder 0 ; Select head 0
	int 0x13
	jc disk_error
	pop dx
	cmp dh, al
	jne disk_error 
	ret
disk_error :
; Start reading from second sector (i.e. ; after the boot sector)
; BIOS interrupt
; Jump if error (i.e. carry flag set)
; Restore DX from the stack
; if AL (sectors read) != DH (sectors expected) ; display error message

	mov bx, DISK_ERROR_MSG 
	call print_string
	jmp $
; Variables
DISK_ERROR_MSG db "Disk read error!", 0