.data
# dados devem ser alocados
# no segmento de dados
MATRIZ_0: 	.space 20
MATRIZ_1: 	.space 20
MATRIZ_2: 	.space 20
MATRIZ_3: 	.space 20
MATRIZ_4: 	.space 20
#------------------------------------------------------------------------
sizeA:		.word 	5	# tamanho do array
sizeM:		.word	25
espaco:		.asciiz	" "
quebra:		.asciiz	"\n"
#########################################################################
.text
main:
#la	$s0, newArray	# carregue endereço do array
lui		$at, 0x1001
add		$s0, $zero, $at

#la	$s5, size	# carregue endereço do tamanho variável
lui		$at, 0x1001
addi 	$s5, $at, 0x68


lw		$s5, 0($s5)	# carregue tamanho do array

add 	$s1, $zero, $s5

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
# reinicia a posição da memória - MATRIZ[0][0]
lui	$at, 0x1001
add	$a0, $zero, $at

add	$a1, $zero, $s5	# valor a ser decrementado - tamanho da matriz

######### loop da soma
loopSoma:
		lw		$s2, 0($a0)
		addi	$a0, $a0, 4

		add		$s3, $s3, $s2	# soma valores do array

		addi	$a1, $a1, -1
		bgtz	$a1, loopSoma	# Se maior que zero vá para repetição
		
		
################------------- impressão

# quebra de linha
	lui		$at, 0x1001
	addi	$a0, $at, 0x6E
	addi	$v0, $zero, 4
	syscall
	
	#imprime soma
	add		$a0, $zero, $s3 
	addi	$v0, $zero, 1
	syscall
	

fim:
	addi	$v0, $zero, 10
	syscall