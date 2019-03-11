	.file	"pixelflut_client.c"
	.text
	.section	.rodata.main.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Kommandozeilen Parameter: <programm> <IP-Adresse> <Port> <Threads>"
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
	.string	"PX %i %i %X\n"
	.section	.text.startup.main,"ax",@progbits
	.globl	main
	.type	main, @function
main:
	pushq	%r13
	pushq	%r12
	pushq	%rbp
	pushq	%rbx
	subq	$136, %rsp
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
	movw	%ax, port(%rip)
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
	movl	%eax, %ebx
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	movzwl	port(%rip), %eax
	leaq	ip(%rip), %rdi
	movw	$2, 12(%rsp)
	xchgb	%ah, %al
	movw	%ax, 14(%rsp)
	call	inet_addr@PLT
	leaq	.LC5(%rip), %rdi
	movl	%eax, 16(%rsp)
	testl	%ebx, %ebx
	js	.L15
	leaq	12(%rsp), %rsi
	movl	$16, %edx
	movl	%ebx, %edi
	call	connect@PLT
	leaq	28(%rsp), %rbp
	testl	%eax, %eax
	jns	.L7
	leaq	.LC6(%rip), %rdi
.L15:
	call	puts@PLT
	addq	$136, %rsp
	xorl	%eax, %eax
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
.L7:
	call	rand@PLT
	movl	breite(%rip), %ecx
	xorl	%r12d, %r12d
	subl	bild_breite(%rip), %ecx
	cltd
	idivl	%ecx
	movl	%edx, offset_x(%rip)
	call	rand@PLT
	movl	hohe(%rip), %ecx
	subl	bild_hohe(%rip), %ecx
	cltd
	idivl	%ecx
	movl	%edx, offset_y(%rip)
.L8:
	cmpl	%r12d, bild_hohe(%rip)
	jl	.L7
	xorl	%r13d, %r13d
.L10:
	cmpl	%r13d, bild_breite(%rip)
	jl	.L17
	xorl	%eax, %eax
	leaq	44(%rsp), %rdi
	movl	$21, %ecx
	movl	offset_x(%rip), %edx
	rep stosl
	movl	offset_y(%rip), %ecx
	movq	%rbp, %rdi
	movl	farbe(%rip), %r8d
	addl	%r12d, %edx
	leaq	.LC7(%rip), %rsi
	movq	$10, 28(%rsp)
	movq	$0, 36(%rsp)
	addl	%r13d, %ecx
	incl	%r13d
	call	sprintf@PLT
	xorl	%eax, %eax
	movq	%rbp, %rdi
	orq	$-1, %rcx
	repnz scasb
	movl	%ebx, %edi
	movq	%rcx, %rsi
	xorl	%ecx, %ecx
	notq	%rsi
	leaq	-1(%rsi), %rdx
	movq	%rbp, %rsi
	call	send@PLT
	jmp	.L10
.L17:
	incl	%r12d
	jmp	.L8
	.size	main, .-main
	.globl	breite
	.section	.data.breite,"aw"
	.align 4
	.type	breite, @object
	.size	breite, 4
breite:
	.long	1920
	.globl	hohe
	.section	.data.hohe,"aw"
	.align 4
	.type	hohe, @object
	.size	hohe, 4
hohe:
	.long	1080
	.globl	bild_breite
	.section	.data.bild_breite,"aw"
	.align 4
	.type	bild_breite, @object
	.size	bild_breite, 4
bild_breite:
	.long	100
	.globl	bild_hohe
	.section	.data.bild_hohe,"aw"
	.align 4
	.type	bild_hohe, @object
	.size	bild_hohe, 4
bild_hohe:
	.long	100
	.globl	offset_y
	.section	.data.offset_y,"aw"
	.align 4
	.type	offset_y, @object
	.size	offset_y, 4
offset_y:
	.long	300
	.globl	offset_x
	.section	.data.offset_x,"aw"
	.align 4
	.type	offset_x, @object
	.size	offset_x, 4
offset_x:
	.long	300
	.globl	farbe
	.section	.data.farbe,"aw"
	.align 4
	.type	farbe, @object
	.size	farbe, 4
farbe:
	.long	100000
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
	.align 2
	.type	port, @object
	.size	port, 2
port:
	.value	80
	.section	.note.GNU-stack,"",@progbits
