	.file	"pixelflut_client_request.c"
	.text
	.section	.rodata.main.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Kommandozeilen Parameter: <programm> <IP-Adresse> <Port>"
.LC1:
	.string	"Eingabe IPv4:"
.LC2:
	.string	"%s"
.LC3:
	.string	"Eingabe Port:"
.LC4:
	.string	"%d"
.LC5:
	.string	"Fehler beim Erzeugen des Sockets"
.LC6:
	.string	"Fehler beim herstellen der Verbindung"
.LC7:
	.string	"PX %i %i\n"
	.section	.text.startup.main,"ax",@progbits
	.globl	main
	.type	main, @function
main:
	pushq	%r13
	pushq	%r12
	pushq	%rbp
	pushq	%rbx
	subq	$24, %rsp
	cmpl	$2, %edi
	jg	.L2
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	leaq	.LC1(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	leaq	ip(%rip), %rsi
	leaq	.LC2(%rip), %rdi
	xorl	%eax, %eax
	call	__isoc99_scanf@PLT
	leaq	.LC3(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	leaq	port(%rip), %rsi
	leaq	.LC4(%rip), %rdi
	xorl	%eax, %eax
	call	__isoc99_scanf@PLT
	jmp	.L3
.L2:
	movq	16(%rsi), %rdi
	movq	%rsi, %rbx
	call	atoi@PLT
	leaq	ip(%rip), %rdx
	movl	%eax, port(%rip)
	xorl	%eax, %eax
.L4:
	movq	8(%rbx), %rcx
	movb	(%rcx,%rax), %cl
	movb	%cl, (%rdx,%rax)
	incq	%rax
	cmpq	$16, %rax
	jne	.L4
.L3:
	xorl	%edx, %edx
	movl	$1, %esi
	movl	$2, %edi
	call	socket@PLT
	xorl	%edi, %edi
	movl	%eax, %ebp
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	movzwl	port(%rip), %eax
	leaq	ip(%rip), %rdi
	movw	$2, (%rsp)
	xchgb	%ah, %al
	movw	%ax, 2(%rsp)
	call	inet_addr@PLT
	leaq	.LC5(%rip), %rdi
	movl	%eax, 4(%rsp)
	testl	%ebp, %ebp
	js	.L16
	movq	%rsp, %rsi
	movl	$16, %edx
	movl	%ebp, %edi
	xorl	%r12d, %r12d
	call	connect@PLT
	leaq	.LC7(%rip), %r13
	testl	%eax, %eax
	jns	.L7
	leaq	.LC6(%rip), %rdi
.L16:
	call	puts@PLT
	addq	$24, %rsp
	xorl	%eax, %eax
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
.L7:
	xorl	%ebx, %ebx
.L8:
	movl	%ebx, %ecx
	movl	%r12d, %edx
	movq	%r13, %rsi
	xorl	%eax, %eax
	leaq	data(%rip), %rdi
	incl	%ebx
	call	sprintf@PLT
	cmpl	$1080, %ebx
	jne	.L8
	incl	%r12d
	cmpl	$1980, %r12d
	jne	.L7
	leaq	data(%rip), %rbx
.L9:
	xorl	%eax, %eax
	movq	%rbx, %rdi
	leaq	data(%rip), %rsi
	orq	$-1, %rcx
	repnz scasb
	movl	%ebp, %edi
	movq	%rcx, %rdx
	xorl	%ecx, %ecx
	notq	%rdx
	leaq	-1(%rdx), %rdx
	call	send@PLT
	movl	$60, %edi
	call	sleep@PLT
	jmp	.L9
	.size	main, .-main
	.globl	port
	.section	.data.port,"aw"
	.align 4
	.type	port, @object
	.size	port, 4
port:
	.long	1234
	.globl	ip
	.section	.data.ip,"aw"
	.align 32
	.type	ip, @object
	.size	ip, 100
ip:
	.string	"151.217.40.82"
	.zero	86
	.comm	data,32076000,32
	.section	.note.GNU-stack,"",@progbits
