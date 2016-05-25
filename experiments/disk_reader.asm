[org 0x7c00]

KERNEL_OFFSET equ 0x1000
mov bx, KERNEL_OFFSET 
mov dl, 0x80
mov ah, 0x02 
mov al, dh
mov ch, 0x00
mov dh, 0x00
mov cl, 0x00
int 0x13
jc disk_error

disk_error :
; Start reading from second sector (i.e. ; after the boot sector)
; BIOS interrupt
; Jump if error (i.e. carry flag set)
; Restore DX from the stack
; if AL (sectors read) != DH (sectors expected) ; display error message
	int 0x10
	mov bx, DISK_ERROR_MSG 
	call print_string

	jmp $
; Variables
DISK_ERROR_MSG db "Disk read error!", 0

jmp KERNEL_OFFSET

%include "../print_string.asm"
times 510-($-$$) db 0 
dw 0xaa55


mov bx, SUCCESS 
call print_string
jmp $
; Variables
SUCCESS db "success", 0