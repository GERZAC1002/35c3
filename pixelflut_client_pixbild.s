	.file	"pixelflut_client_pixbild.c"
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
	.string	"PX %i %i 0\n"
.LC5:
	.string	"\n"
	.section	.text.Thread,"ax",@progbits
	.globl	Thread
	.type	Thread, @function
Thread:
	pushq	%r15
	xorl	%edx, %edx
	movl	$1, %esi
	movl	$2, %edi
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbp
	pushq	%rbx
	subq	$5000152, %rsp
	call	socket@PLT
	leaq	ip(%rip), %rdi
	movw	$2, 28(%rsp)
	movl	%eax, %r15d
	movzwl	port(%rip), %eax
	xchgb	%ah, %al
	movw	%ax, 30(%rsp)
	call	inet_addr@PLT
	leaq	160(%rsp), %rdi
	movl	$249996, %ecx
	movq	$10, 144(%rsp)
	movl	%eax, 32(%rsp)
	xorl	%eax, %eax
	rep stosl
	leaq	60(%rsp), %rdi
	movl	$21, %ecx
	movq	$0, 152(%rsp)
	movq	$10, 44(%rsp)
	movq	$0, 52(%rsp)
	rep stosl
	testl	%r15d, %r15d
	jns	.L2
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	orl	$-1, %edi
	call	exit@PLT
.L2:
	movl	%r15d, %edi
	leaq	28(%rsp), %rsi
	movl	$16, %edx
	call	connect@PLT
	leaq	.LC1(%rip), %rdi
	testl	%eax, %eax
	js	.L14
	leaq	.LC2(%rip), %rdi
.L14:
	call	puts@PLT
	movabsq	$4294967297, %r13
.L10:
	leaq	1000144(%rsp), %rdi
	movl	$1000000, %ecx
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	rep stosl
	movq	%r13, 1000144(%rsp)
	movl	$1, 1000152(%rsp)
	movq	%r13, 1000160(%rsp)
	movl	$1, 1000168(%rsp)
	movq	%r13, 1000176(%rsp)
	movl	$1, 1000184(%rsp)
	movq	%r13, 1000192(%rsp)
	movl	$1, 1000200(%rsp)
	movl	$1, 1004152(%rsp)
	movl	$1, 1004160(%rsp)
	movl	$1, 1004176(%rsp)
	movl	$1, 1004184(%rsp)
	movl	$1, 1004200(%rsp)
	movq	%r13, 1008144(%rsp)
	movl	$1, 1008152(%rsp)
	movq	%r13, 1008160(%rsp)
	movl	$1, 1008168(%rsp)
	movl	$1, 1008176(%rsp)
	movq	%r13, 1008192(%rsp)
	movl	$1, 1008200(%rsp)
	movl	$1, 1012152(%rsp)
	movl	$1, 1012168(%rsp)
	movl	$1, 1012176(%rsp)
	movl	$1, 1012184(%rsp)
	movl	$1, 1012200(%rsp)
	movq	%r13, 1016144(%rsp)
	movl	$1, 1016152(%rsp)
	movq	%r13, 1016160(%rsp)
	movl	$1, 1016168(%rsp)
	movq	%r13, 1016176(%rsp)
	movl	$1, 1016184(%rsp)
	movq	%r13, 1016192(%rsp)
	movl	$1, 1016200(%rsp)
.L5:
	movl	%ebp, %eax
	movl	$10, %ebx
	cltd
	idivl	%ebx
	xorl	%ebx, %ebx
	cltq
	movq	%rax, 8(%rsp)
.L8:
	movl	%ebx, %eax
	movl	$10, %edi
	leaq	44(%rsp), %r14
	movl	offset_y(%rip), %ecx
	cltd
	movl	offset_x(%rip), %esi
	leaq	144(%rsp), %r12
	idivl	%edi
	addl	%ebx, %ecx
	addl	%ebp, %esi
	cltq
	imulq	$1000, %rax, %rax
	addq	8(%rsp), %rax
	cmpl	$1, 1000144(%rsp,%rax,4)
	jne	.L6
	movl	%esi, %edx
	leaq	def_farbe(%rip), %r8
	movq	%r14, %rdi
	xorl	%eax, %eax
	leaq	.LC3(%rip), %rsi
	call	sprintf@PLT
	jmp	.L15
.L6:
	movl	%esi, %edx
	movq	%r14, %rdi
	leaq	.LC4(%rip), %rsi
	xorl	%eax, %eax
	call	sprintf@PLT
.L15:
	movq	%r14, %rsi
	movq	%r12, %rdi
	incl	%ebx
	call	strcat@PLT
	cmpl	$51, %ebx
	jne	.L8
	xorl	%eax, %eax
	movq	%r12, %rdi
	orq	$-1, %rcx
	movq	%r12, %rsi
	repnz scasb
	movl	%r15d, %edi
	incl	%ebp
	movq	%rcx, %rbx
	xorl	%ecx, %ecx
	notq	%rbx
	leaq	-1(%rbx), %rdx
	call	send@PLT
	leaq	.LC5(%rip), %rsi
	movq	%r12, %rdi
	movb	$0, 144(%rsp)
	call	strcpy@PLT
	cmpl	$151, %ebp
	jne	.L5
	jmp	.L10
	.size	Thread, .-Thread
	.section	.rodata.main.str1.1,"aMS",@progbits,1
.LC6:
	.string	"Kommandozeilen Parameter: <programm> <IP-Adresse> <Port> <Threads>"
.LC7:
	.string	"Eingabe IPv4:"
.LC8:
	.string	"%s"
.LC9:
	.string	"Eingabe Port:"
.LC10:
	.string	"%d"
.LC11:
	.string	"Anzahl Threads:"
.LC12:
	.string	"Eingabe Position x:"
.LC13:
	.string	"Eingabe Position y:"
	.section	.text.startup.main,"ax",@progbits
	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	pushq	%rbx
	subq	$24, %rsp
	cmpl	$3, %edi
	jg	.L18
	leaq	.LC6(%rip), %rdi
	call	puts@PLT
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	leaq	ip(%rip), %rsi
	leaq	.LC8(%rip), %rdi
	xorl	%eax, %eax
	call	__isoc99_scanf@PLT
	leaq	.LC9(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	leaq	port(%rip), %rsi
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	call	__isoc99_scanf@PLT
	leaq	.LC11(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	leaq	anz_threads(%rip), %rsi
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	call	__isoc99_scanf@PLT
	leaq	.LC12(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	leaq	max_x(%rip), %rsi
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	call	__isoc99_scanf@PLT
	leaq	.LC13(%rip), %rdi
	xorl	%eax, %eax
	addl	$150, max_x(%rip)
	call	printf@PLT
	leaq	max_y(%rip), %rsi
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	call	__isoc99_scanf@PLT
	addl	$50, max_y(%rip)
	jmp	.L19
.L18:
	movq	16(%rsi), %rdi
	movq	%rsi, %rbx
	call	atoi@PLT
	movq	24(%rbx), %rdi
	movl	%eax, port(%rip)
	call	atoi@PLT
	leaq	ip(%rip), %rdx
	movl	%eax, anz_threads(%rip)
	xorl	%eax, %eax
.L20:
	movq	8(%rbx), %rcx
	movb	(%rcx,%rax), %cl
	movb	%cl, (%rdx,%rax)
	incq	%rax
	cmpq	$16, %rax
	jne	.L20
.L19:
	movl	max_x(%rip), %eax
	xorl	%ebx, %ebx
	leaq	8(%rsp), %rbp
	subl	$150, %eax
	movl	%eax, offset_x(%rip)
	movl	max_y(%rip), %eax
	subl	$50, %eax
	movl	%eax, offset_y(%rip)
.L21:
	cmpl	%ebx, anz_threads(%rip)
	jle	.L25
	movq	%rbp, %rcx
	leaq	Thread(%rip), %rdx
	xorl	%esi, %esi
	movq	%rbp, %rdi
	call	pthread_create@PLT
	incl	%ebx
	jmp	.L21
.L25:
	xorl	%edi, %edi
	call	pthread_exit@PLT
	.size	main, .-main
	.comm	offset_y,4,4
	.comm	offset_x,4,4
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
	.string	"ff00"
	.zero	2
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
