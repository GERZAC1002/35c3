	.file	"pixelflut_client_loesch.c"
	.text
	.section	.rodata.Thread.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Fehler beim Erzeugen des Sockets"
.LC1:
	.string	"Fehler beim herstellen der Verbindung"
.LC2:
	.string	"Verbindung hergestellt"
.LC3:
	.string	"PX %i %i %s\n"
.LC4:
	.string	"\n"
	.section	.text.Thread,"ax",@progbits
	.globl	Thread
	.type	Thread, @function
Thread:
	pushq	%r14
	xorl	%edx, %edx
	movl	$1, %esi
	movl	$2, %edi
	pushq	%r13
	pushq	%r12
	pushq	%rbp
	pushq	%rbx
	subq	$1000128, %rsp
	call	socket@PLT
	leaq	ip(%rip), %rdi
	movw	$2, 12(%rsp)
	movl	%eax, %r12d
	movzwl	port(%rip), %eax
	xchgb	%ah, %al
	movw	%ax, 14(%rsp)
	call	inet_addr@PLT
	leaq	144(%rsp), %rdi
	movl	$249996, %ecx
	movq	$10, 128(%rsp)
	movl	%eax, 16(%rsp)
	xorl	%eax, %eax
	rep stosl
	leaq	44(%rsp), %rdi
	movl	$21, %ecx
	movq	$0, 136(%rsp)
	movq	$10, 28(%rsp)
	movq	$0, 36(%rsp)
	rep stosl
	testl	%r12d, %r12d
	jns	.L2
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	orl	$-1, %edi
	call	exit@PLT
.L2:
	movl	%r12d, %edi
	leaq	12(%rsp), %rsi
	movl	$16, %edx
	call	connect@PLT
	leaq	.LC1(%rip), %rdi
	testl	%eax, %eax
	js	.L11
	leaq	.LC2(%rip), %rdi
.L11:
	call	puts@PLT
	leaq	128(%rsp), %rbx
.L8:
	xorl	%ebp, %ebp
.L5:
	cmpl	%ebp, max_x(%rip)
	jl	.L8
	xorl	%r13d, %r13d
.L7:
	cmpl	%r13d, max_y(%rip)
	jl	.L13
	leaq	28(%rsp), %r14
	movl	%r13d, %ecx
	movl	%ebp, %edx
	xorl	%eax, %eax
	leaq	def_farbe(%rip), %r8
	leaq	.LC3(%rip), %rsi
	movq	%r14, %rdi
	incl	%r13d
	call	sprintf@PLT
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	strcat@PLT
	jmp	.L7
.L13:
	xorl	%eax, %eax
	movq	%rbx, %rdi
	orq	$-1, %rcx
	movq	%rbx, %rsi
	repnz scasb
	movl	%r12d, %edi
	incl	%ebp
	movq	%rcx, %rdx
	xorl	%ecx, %ecx
	notq	%rdx
	leaq	-1(%rdx), %rdx
	call	send@PLT
	leaq	.LC4(%rip), %rsi
	movq	%rbx, %rdi
	movb	$0, 128(%rsp)
	call	strcpy@PLT
	jmp	.L5
	.size	Thread, .-Thread
	.section	.rodata.main.str1.1,"aMS",@progbits,1
.LC5:
	.string	"Kommandozeilen Parameter: <programm> <IP-Adresse> <Port> <Threads>"
.LC6:
	.string	"Eingabe IPv4:"
.LC7:
	.string	"%s"
.LC8:
	.string	"Eingabe Port:"
.LC9:
	.string	"%d"
.LC10:
	.string	"Anzahl Threads:"
	.section	.text.startup.main,"ax",@progbits
	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	pushq	%rbx
	subq	$24, %rsp
	cmpl	$3, %edi
	jg	.L15
	leaq	.LC5(%rip), %rdi
	call	puts@PLT
	leaq	.LC6(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	leaq	ip(%rip), %rsi
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	__isoc99_scanf@PLT
	leaq	.LC8(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	leaq	port(%rip), %rsi
	leaq	.LC9(%rip), %rdi
	xorl	%eax, %eax
	call	__isoc99_scanf@PLT
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	leaq	anz_threads(%rip), %rsi
	leaq	.LC9(%rip), %rdi
	xorl	%eax, %eax
	call	__isoc99_scanf@PLT
.L18:
	xorl	%ebx, %ebx
	leaq	8(%rsp), %rbp
	jmp	.L16
.L15:
	movq	16(%rsi), %rdi
	movq	%rsi, %rbx
	call	atoi@PLT
	movq	24(%rbx), %rdi
	movl	%eax, port(%rip)
	call	atoi@PLT
	leaq	ip(%rip), %rdx
	movl	%eax, anz_threads(%rip)
	xorl	%eax, %eax
.L17:
	movq	8(%rbx), %rcx
	movb	(%rcx,%rax), %cl
	movb	%cl, (%rdx,%rax)
	incq	%rax
	cmpq	$16, %rax
	jne	.L17
	jmp	.L18
.L16:
	cmpl	%ebx, anz_threads(%rip)
	jle	.L22
	movq	%rbp, %rcx
	leaq	Thread(%rip), %rdx
	xorl	%esi, %esi
	movq	%rbp, %rdi
	call	pthread_create@PLT
	incl	%ebx
	jmp	.L16
.L22:
	xorl	%edi, %edi
	call	pthread_exit@PLT
	.size	main, .-main
	.globl	anz_threads
	.section	.data.anz_threads,"aw"
	.align 4
	.type	anz_threads, @object
	.size	anz_threads, 4
anz_threads:
	.long	1
	.globl	def_farbe
	.section	.data.def_farbe,"aw"
	.type	def_farbe, @object
	.size	def_farbe, 7
def_farbe:
	.string	"0"
	.zero	5
	.globl	max_y
	.section	.data.max_y,"aw"
	.align 4
	.type	max_y, @object
	.size	max_y, 4
max_y:
	.long	1080
	.globl	max_x
	.section	.data.max_x,"aw"
	.align 4
	.type	max_x, @object
	.size	max_x, 4
max_x:
	.long	1920
	.globl	ip
	.section	.data.ip,"aw"
	.align 32
	.type	ip, @object
	.size	ip, 100
ip:
	.string	"151.217.40.82"
	.zero	86
	.globl	port
	.section	.data.port,"aw"
	.align 4
	.type	port, @object
	.size	port, 4
port:
	.long	1234
	.section	.note.GNU-stack,"",@progbits
