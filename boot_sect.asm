[org 0x7c00]
KERNEL_OFFSET equ 0x1000 ; This is the memory offset to which we will load our kernel

mov [BOOT_DRIVE], dl 
mov bp, 0x9000 
mov sp, bp
mov bx, MSG_REAL_MODE 
call print_string
call load_kernel 
call switch_to_pm
jmp $
; Set-up the stack.
; Announce that we are starting ; booting from 16-bit real mode
; Load our kernel
; Switch to protected mode, from which ; we will not return
; Include our useful, hard-earned routines 
%include "print_string.asm"
%include "disk_load.asm"
%include "gdt.asm"
%include "print_string_pm.asm" 
%include "switch_to_pm.asm"
[bits 16]
; load_kernel
load_kernel:
	mov bx, MSG_LOAD_KERNEL 
	call print_string
	mov bx, KERNEL_OFFSET 
	mov dh , 15
	mov dl, [BOOT_DRIVE] 
	call disk_load
	ret
[bits 32]
; Print a message to say we are loading the kernel

BEGIN_PM:
mov ebx, MSG_PROT_MODE
call print_string_pm 
call KERNEL_OFFSET
jmp $
; Global variables
BOOT_DRIVE db 0
SECTORS        db 0
MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE db "Successfully landed in 32-bit Protected Mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory.", 0
; Use our 32-bit print routine to
; announce we are in protected mode
; Now jump to the address of our loaded
; kernel code , assume the brace position , ; and cross your fingers. Here we go!
; Hang.
; Bootsector padding 
times 510-($-$$) db 0 
dw 0xaa55