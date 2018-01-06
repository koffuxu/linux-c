	.file	"foo.c"
.globl a
	.bss
	.align 4
	.type	a, @object
	.size	a, 4
a:
	.zero	4
	.comm	b,4,4
	.section	.rodata
.LC0:
	.string	"..."
	.text
.globl main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	movq	%rsp, %rbp
	.cfi_offset 6, -16
	.cfi_def_cfa_register 6
	movl	a(%rip), %eax
	movl	%eax, %edi
	call	bar
	movl	$.LC0, %eax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	leave
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 4.4.7-1ubuntu2) 4.4.7"
	.section	.note.GNU-stack,"",@progbits
