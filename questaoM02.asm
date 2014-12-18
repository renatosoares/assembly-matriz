# Faça um programa que leia uma matriz de 8x4 e crie um array de 4
# elementos, onde cada elemento do array é a soma dos elementos coluna.

.data
# dados devem ser alocados
# no segmento de dados
MATRIZ_0: 	.space 16
MATRIZ_1: 	.space 16
MATRIZ_2: 	.space 16
MATRIZ_3: 	.space 16
MATRIZ_4: 	.space 16
MATRIZ_5: 	.space 16
MATRIZ_6: 	.space 16
MATRIZ_7: 	.space 16
#-----------------------------------------------------------------------
arrayFinal:	.space	16

#------------------------------------------------------------------------
sizeA:		.word 	8	# tamanho do array
sizeM:		.word	32	# tamanho da matriz
espaco:		.asciiz	" "
quebra:		.asciiz	"\n"
#########################################################################

.text
main:

lui		$at, 0x1001
add		$s0, $zero, $at

# carregue o endereço do tamanho da matriz
lui		$at, 0x1001
addi 	$s5, $at, 0x94

# carregue o endereço do tamanho do array
lui		$at, 0x1001
addi 	$t0, $at, 0x90

# carregue endereço do array final
lui		$at, 0x1001
addi	$t1, $at, 0x80   		

lw		$s1, 0($s5)	# carregue tamanho do array

	#loop que insere valores na memória --------------------------------------------
	loopAdd:
	#trecho que pega dados do usuário
	#	addi	$v0, $zero, 5
	#	syscall
	#	add	$s2, $zero, $v0
		addi $s2, $s2, 1 	#comando temporário

		sw		$s2, 0($s0)
		addi	$s0, $s0, 4

		addi	$s1, $s1, -1
		bgtz	$s1, loopAdd	# Se maior que zero vá para repetição
###################================================================================

###################================================================================
# reinicia a posição da memória - MATRIZ[0][0]
lui	$at, 0x1001
add	$a0, $zero, $at


lw	$a1, 0($s5)	# valor a ser decrementado - tamanho da matriz
loopInicio:
lw	$a2, 0($t0)	# valor a ser decrementado - tamanho do array

######### loop da soma
loopSoma:
		lw		$s2, 0($a0)
		addi	$a0, $a0, 4

		add		$s3, $s3, $s2	# soma valores do array

		addi	$a2, $a2, -1
		bgtz	$a2, loopSoma	# Se maior que zero vá para repetição
		
		sw		$s3, 0($t1)
		addi	$t1, $t1, 4
		add		$s3, $zero, $zero
		addi	$a1, $a1, -8
		bgtz	$a1,  loopInicio		## parei aqui ------!!!!!!!!!!!
		
fim:
	addi	$v0, $zero, 10
	syscall
		