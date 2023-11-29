.text
	.globl main
	
main:	la	$t0, n
	lw	$t0, 0($t0)		# $t0 -- n	
	
	la	$t1, A			# $t1 -- A
	la	$t2, B			# $t2 -- B
	la	$t3, C			# $t3 -- C
	la	$t4, D			# $t4 -- D
	
	xor	$t5, $t5, $t5		# $t5 -- i = 0
	
	
loop_init_vet:
	beq	$t5, $t0, init_max		#  i == n
	
    	lw	$t6, 0($t1)		# $t6 -- carrega A[i]
    	lw	$t7, 0($t2)   		# $t7 -- carrega B[i]
    	
    	add	$t8, $t6, $t7 		# C[i] = A[i] + B[i]
    	sub	$t9, $t6, $t7 		# D[i] = A[i] - B[i]
    	
    	sw 	$t8, 0($t3)   		# $t8 -- armazena na memoria C[i]
    	sw	$t9, 0($t4)   		# $t9 -- armazena na memoria D[i]
    	
    	# incremento
    	addi	$t5, $t5, 1  		# i
    	addi	$t1, $t1, 4  		# A 
    	addi	$t2, $t2, 4  		# B
    	addi	$t3, $t3, 4  		# C
    	addi	$t4, $t4, 4  		# D
    	
    	j	loop_init_vet   	
	
	
init_max:	
	xor	$t5, $t5, $t5		# i = 0
	la	$t1, C			# $t1 -- C
	la	$t2, D			# $t2 -- D
	lw 	$t3, 0($t1)		# $t3 -- max = C[i]	

loop_max:
	beq	$t5, $t0, init_soma		#  i == n
	
    	lw 	$t6, 0($t1)   		# $t6 -- carrega C[i]
    	lw 	$t7, 0($t2)   		# $t7 -- carrega D[i]
    	
    	bgt	$t6, $t3, max_c	 # C[i] > max
    	
l1:    	
    	bgt	$t7, $t3, max_d	 # D[i] > max
    	
l2:
	# incrementa
    	addi	$t5, $t5, 1  		# i
    	addi	$t1, $t1, 4  		# C
    	addi	$t2, $t2, 4  		# D
    	j loop_max		
    
max_c:
 	add	$t3, $t6, $0		# max = C[i] + 0
 	j	l1
 	
max_d:
 	add	$t3, $t7, $0		# max = D[i] + 0
 	j	l2	

	
init_soma:
	xor	$t5, $t5, $t5		# i = 0
	la	$t1, C			# $t1 -- C
	la	$t2, D			# $t2 -- D
	xor	$t4, $t4, $t4		# $t4 -- SM = 0	
	
loop_soma:
	beq	$t5, $t0, init_multi		# i == n
	
    	lw 	$t6, 0($t1)   		# $t6 -- carrega C[i]
    	lw 	$t7, 0($t2)   		# $t7 -- carrega D[i]
    	
    	add	$t4, $t4, $t6		# SM = SM + A[i]
    	add	$t4, $t4, $t7		# SM = SM + B[i]
    	
    	# incrementa
    	addi	$t5, $t5, 1  		#  i
    	addi	$t1, $t1, 4  		# C
    	addi	$t2, $t2, 4  		# D
    	j loop_soma
    		
    		
init_multi:
	xor	$t5, $t5, $t5		# i = 0
	xor	$t9, $t9, $t9		# $t9 -- vezes
	lw 	$t0, SM			# $t0 -- carrega SM
	
	add	$t1, $t3, $0		# $t1 -- max
	
	blt	$t1, $0, l3		# max < 0

loop_multi:
	beq	$t5, $t1, l4			# i = max
	add	$t9, $t9, $t4			# vezes = vezes + SM
	
	# incrementa 
	addi	$t5, $t5, 1			# i
	j loop_multi
	
l3:
	sub	$t1, $0, $t1		# max = 0 - max (inverte valor caso seja negativo)
	j	loop_multi
	
l4:
	bgt	$t3, $0, resultado_final	# max < 0

troca_sinal:
	sub	$t9, $0, $t9		# vezes = 0 - vezes
	
resultado_final:
	sw	$t9, 0($t0)		# $t9 -- armazena na memoria SM
	
fim:	j	fim
		
.data
n:	.word	8
A:	.word	10 -2 3 -5 12 6 -7 8
B:	.word	11 -3 5 22 -4 9 -8 19
C:	.word	0 0 0 0 0 0 0 0
D:	.word	0 0 0 0 0 0 0 0
SM:	.word	0
