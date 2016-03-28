[bits 16]
; Switch to protected mode
switch_to_pm:
cli ; We must switch of interrupts until we have ; set-up the protected mode interrupt vector
; otherwise interrupts will run riot.

lgdt [gdt_descriptor]
mov eax , cr0 
or eax, 0x1 
mov cr0 , eax
jmp CODE_SEG:init_pm
[bits 32]
	; Initialise registers and
	init_pm: 
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax 
	mov fs, ax 
	mov gs, ax
	mov ebp, 0x90000 
	mov esp , ebp
	call BEGIN_PM

; Now in PM , our old segments are meaningless , ; so we point our segment registers to the
; data selector we defined in our GDT
; Update our stack position so it is right ; at the top of the free space.
; Finally, call some well-known label