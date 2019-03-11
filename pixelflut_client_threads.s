	.file	"pixelflut_client_threads.c"
	.text
	.section	.rodata.Thread.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Fehler beim Erzeugen des Sockets"
.LC1:
	.string	"Fehler beim herstellen der Verbindung"
.LC2:
	.string	"Verbindung hergestellt"
.LC3:
	.string	"PX %i %i %x\n"
.LC4:
	.string	"PX %i %i %s\n"
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
	subq	$1000184, %rsp
	call	socket@PLT
	leaq	ip(%rip), %rdi
	movw	$2, 60(%rsp)
	movl	%eax, 36(%rsp)
	movzwl	port(%rip), %eax
	xchgb	%ah, %al
	movw	%ax, 62(%rsp)
	call	inet_addr@PLT
	leaq	192(%rsp), %rdi
	movl	$249996, %ecx
	movq	$10, 176(%rsp)
	movl	%eax, 64(%rsp)
	xorl	%eax, %eax
	rep stosl
	leaq	92(%rsp), %rdi
	movl	$21, %ecx
	movq	$0, 184(%rsp)
	rep stosl
	xorl	%edi, %edi
	movq	$10, 76(%rsp)
	movq	$0, 84(%rsp)
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	cmpl	$0, 36(%rsp)
	jns	.L2
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	orl	$-1, %edi
	jmp	.L21
.L2:
	movl	36(%rsp), %edi
	leaq	60(%rsp), %rsi
	movl	$16, %edx
	call	connect@PLT
	testl	%eax, %eax
	jns	.L3
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
	movl	36(%rsp), %edi
	call	close@PLT
	movl	$1, %edi
.L21:
	call	exit@PLT
.L3:
	leaq	.LC2(%rip), %rdi
	leaq	76(%rsp), %rbx
	call	puts@PLT
	movl	$0, 16(%rsp)
.L14:
	call	rand@PLT
	xorl	%r13d, %r13d
	cltd
	idivl	max_x(%rip)
	movl	%edx, 20(%rsp)
	call	rand@PLT
	movl	$0, 12(%rsp)
	cltd
	movl	$0, 8(%rsp)
	idivl	max_y(%rip)
	movl	$0, 4(%rsp)
	movq	$0, 24(%rsp)
	movl	%edx, 32(%rsp)
.L4:
	movslq	laenge(%rip), %rax
	cmpq	24(%rsp), %rax
	jl	.L14
	movq	24(%rsp), %rax
	movl	$5, %ecx
	cqto
	idivq	%rcx
	testq	%rdx, %rdx
	jne	.L5
	call	rand@PLT
	movl	$4, %ebp
	cltd
	idivl	%ebp
	decl	%edx
	jg	.L5
	call	rand@PLT
	cltd
	idivl	%ebp
	movl	%edx, 16(%rsp)
.L5:
	call	rand@PLT
	movl	$16777215, %ebp
	cltd
	idivl	%ebp
	movl	%edx, 40(%rsp)
	call	rand@PLT
	cltd
	idivl	%ebp
	movl	$1, %ebp
	movl	%edx, 44(%rsp)
.L6:
	cmpl	%ebp, breite(%rip)
	jle	.L24
	cmpl	$0, 16(%rsp)
	jne	.L7
	movl	12(%rsp), %r12d
	movl	40(%rsp), %r8d
	movq	%rbx, %rdi
	xorl	%eax, %eax
	incl	4(%rsp)
	movl	4(%rsp), %r14d
	leaq	176(%rsp), %r15
	leaq	.LC3(%rip), %rsi
	subl	%r13d, %r12d
	addl	20(%rsp), %r12d
	subl	8(%rsp), %r14d
	movl	%r12d, %edx
	addl	32(%rsp), %r14d
	subl	%ebp, %edx
	movl	%r14d, %ecx
	call	sprintf@PLT
	movq	%rbx, %rsi
	movq	%r15, %rdi
	call	strcat@PLT
	movl	44(%rsp), %r8d
	leal	(%r12,%rbp), %edx
	xorl	%eax, %eax
	movl	%r14d, %ecx
	leaq	.LC3(%rip), %rsi
	movq	%rbx, %rdi
	call	sprintf@PLT
	movq	%rbx, %rsi
	movq	%r15, %rdi
	call	strcat@PLT
	movl	%r14d, %ecx
	movq	%rbx, %rdi
	movl	%r12d, %edx
	leaq	def_farbe(%rip), %r8
	subl	breite(%rip), %edx
	leaq	.LC4(%rip), %rsi
	xorl	%eax, %eax
	call	sprintf@PLT
	movq	%rbx, %rsi
	movq	%r15, %rdi
	call	strcat@PLT
	movl	breite(%rip), %edx
	addl	%r12d, %edx
	jmp	.L22
.L7:
	cmpl	$1, 16(%rsp)
	jne	.L9
	movl	12(%rsp), %r12d
	movl	44(%rsp), %r8d
	movq	%rbx, %rdi
	xorl	%eax, %eax
	incl	8(%rsp)
	movl	4(%rsp), %r14d
	leaq	176(%rsp), %r15
	leaq	.LC3(%rip), %rsi
	subl	8(%rsp), %r14d
	subl	%r13d, %r12d
	addl	32(%rsp), %r14d
	addl	20(%rsp), %r12d
	movl	%r14d, %ecx
	leal	(%r12,%rbp), %edx
	call	sprintf@PLT
	movq	%rbx, %rsi
	movq	%r15, %rdi
	call	strcat@PLT
	movl	40(%rsp), %r8d
	movl	%r12d, %edx
	movl	%r14d, %ecx
	subl	%ebp, %edx
	leaq	.LC3(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	sprintf@PLT
	movq	%rbx, %rsi
	movq	%r15, %rdi
	call	strcat@PLT
	movl	breite(%rip), %edx
	movl	%r14d, %ecx
	xorl	%eax, %eax
	leaq	def_farbe(%rip), %r8
	leaq	.LC4(%rip), %rsi
	movq	%rbx, %rdi
	addl	%r12d, %edx
	call	sprintf@PLT
	movq	%rbx, %rsi
	movq	%r15, %rdi
	call	strcat@PLT
	movl	%r12d, %edx
	subl	breite(%rip), %edx
.L22:
	leaq	def_farbe(%rip), %r8
	movl	%r14d, %ecx
	jmp	.L19
.L9:
	cmpl	$2, 16(%rsp)
	jne	.L10
	movl	12(%rsp), %r14d
	incl	%r13d
	movl	40(%rsp), %r8d
	movq	%rbx, %rdi
	movl	4(%rsp), %r12d
	subl	8(%rsp), %r12d
	leaq	.LC3(%rip), %rsi
	xorl	%eax, %eax
	addl	32(%rsp), %r12d
	subl	%r13d, %r14d
	addl	20(%rsp), %r14d
	leal	(%r12,%rbp), %ecx
	movl	%r14d, %edx
	leaq	176(%rsp), %r15
	call	sprintf@PLT
	movq	%rbx, %rsi
	movq	%r15, %rdi
	call	strcat@PLT
	movl	44(%rsp), %r8d
	movl	%r12d, %ecx
	movl	%r14d, %edx
	subl	%ebp, %ecx
	leaq	.LC3(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	sprintf@PLT
	movq	%rbx, %rsi
	movq	%r15, %rdi
	call	strcat@PLT
	movl	breite(%rip), %ecx
	movl	%r14d, %edx
	xorl	%eax, %eax
	leaq	def_farbe(%rip), %r8
	leaq	.LC4(%rip), %rsi
	movq	%rbx, %rdi
	addl	%r12d, %ecx
	call	sprintf@PLT
	movq	%rbx, %rsi
	movq	%r15, %rdi
	call	strcat@PLT
	movl	%r12d, %ecx
	subl	breite(%rip), %ecx
	jmp	.L20
.L10:
	cmpl	$3, 16(%rsp)
	jne	.L8
	incl	12(%rsp)
	movl	12(%rsp), %r14d
	movq	%rbx, %rdi
	xorl	%eax, %eax
	movl	4(%rsp), %r12d
	subl	8(%rsp), %r12d
	leaq	176(%rsp), %r15
	leaq	.LC3(%rip), %rsi
	addl	32(%rsp), %r12d
	movl	44(%rsp), %r8d
	subl	%r13d, %r14d
	movl	%r12d, %ecx
	addl	20(%rsp), %r14d
	subl	%ebp, %ecx
	movl	%r14d, %edx
	call	sprintf@PLT
	movq	%rbx, %rsi
	movq	%r15, %rdi
	call	strcat@PLT
	movl	40(%rsp), %r8d
	leal	(%r12,%rbp), %ecx
	xorl	%eax, %eax
	movl	%r14d, %edx
	leaq	.LC3(%rip), %rsi
	movq	%rbx, %rdi
	call	sprintf@PLT
	movq	%rbx, %rsi
	movq	%r15, %rdi
	call	strcat@PLT
	movl	%r14d, %edx
	movq	%rbx, %rdi
	movl	%r12d, %ecx
	leaq	def_farbe(%rip), %r8
	subl	breite(%rip), %ecx
	leaq	.LC4(%rip), %rsi
	xorl	%eax, %eax
	call	sprintf@PLT
	movq	%rbx, %rsi
	movq	%r15, %rdi
	call	strcat@PLT
	movl	breite(%rip), %ecx
	addl	%r12d, %ecx
.L20:
	leaq	def_farbe(%rip), %r8
	movl	%r14d, %edx
.L19:
	leaq	.LC4(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	sprintf@PLT
	movq	%rbx, %rsi
	movq	%r15, %rdi
	call	strcat@PLT
.L8:
	incl	%ebp
	jmp	.L6
.L24:
	movl	12(%rsp), %edx
	movl	4(%rsp), %ecx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	subl	8(%rsp), %ecx
	leaq	def_farbe(%rip), %r8
	addl	32(%rsp), %ecx
	leaq	.LC4(%rip), %rsi
	subl	%r13d, %edx
	leaq	176(%rsp), %rbp
	addl	20(%rsp), %edx
	call	sprintf@PLT
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	strcat@PLT
	movq	24(%rsp), %rax
	movl	$100, %ecx
	cqto
	idivq	%rcx
	testq	%rdx, %rdx
	je	.L12
	xorl	%eax, %eax
	movq	%rbp, %rdi
	orq	$-1, %rcx
	repnz scasb
	movl	36(%rsp), %edi
	movq	%rcx, %rsi
	xorl	%ecx, %ecx
	notq	%rsi
	leaq	-1(%rsi), %rdx
	movq	%rbp, %rsi
	call	send@PLT
	leaq	.LC5(%rip), %rsi
	movq	%rbp, %rdi
	movb	$0, 176(%rsp)
	call	strcpy@PLT
.L12:
	incq	24(%rsp)
	jmp	.L4
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
	.section	.text.startup.main,"ax",@progbits
	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	pushq	%rbx
	subq	$24, %rsp
	cmpl	$3, %edi
	jg	.L26
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
.L29:
	xorl	%ebx, %ebx
	leaq	8(%rsp), %rbp
	jmp	.L27
.L26:
	movq	16(%rsi), %rdi
	movq	%rsi, %rbx
	call	atoi@PLT
	movq	24(%rbx), %rdi
	movl	%eax, port(%rip)
	call	atoi@PLT
	leaq	ip(%rip), %rdx
	movl	%eax, anz_threads(%rip)
	xorl	%eax, %eax
.L28:
	movq	8(%rbx), %rcx
	movb	(%rcx,%rax), %cl
	movb	%cl, (%rdx,%rax)
	incq	%rax
	cmpq	$16, %rax
	jne	.L28
	jmp	.L29
.L27:
	cmpl	%ebx, anz_threads(%rip)
	jle	.L33
	movq	%rbp, %rcx
	leaq	Thread(%rip), %rdx
	xorl	%esi, %esi
	movq	%rbp, %rdi
	call	pthread_create@PLT
	incl	%ebx
	jmp	.L27
.L33:
	xorl	%edi, %edi
	call	pthread_exit@PLT
	.size	main, .-main
	.globl	laenge
	.section	.data.laenge,"aw"
	.align 4
	.type	laenge, @object
	.size	laenge, 4
laenge:
	.long	1000
	.globl	breite
	.section	.data.breite,"aw"
	.align 4
	.type	breite, @object
	.size	breite, 4
breite:
	.long	5
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
	.string	"ffffff"
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
