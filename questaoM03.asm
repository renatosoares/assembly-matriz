# Faça um programa que leia uma matriz 15x3 e imprima o número de
# linhas e o número de colunas nulas da matriz.

.data
linha_0:	.space 12
linha_1:	.space 12
linha_2:	.space 12
linha_3:	.space 12
linha_4:	.space 12
linha_5:	.space 12
linha_6:	.space 12
linha_7:	.space 12
linha_8:	.space 12
linha_9:	.space 12
linha_10:	.space 12
linha_11:	.space 12
linha_12:	.space 12
linha_13:	.space 12
linha_14:	.space 12
#------------------------------------------------------------------------
qtdLinhas:		.word 	15	# constante
qtdColunas:		.word	3	# constante
qtdElemMatriz:	.word	45	# quantidade de elementos da matriz
espaco:		.asciiz	" "
quebra:		.asciiz	"\n"
#########################################################################

.text
main:
# carrega o endereço do inicio do array
lui		$at, 0x1001
add		$s0, $zero, $at

# carrega o endereço da quantidade de linhas
lui		$at, 0x1001
addi 	$s5, $at, 0xB4

# carrega o endereço a quantidade de colunas
lui		$at, 0x1001
addi 	$t0, $at, 0xB8

# carregue endereço da quantidade de elementos da matriz
lui		$at, 0x1001
addi	$t1, $at, 0xBC   		

lw		$s1, 0($t1)	# carregue a quantidade de elementos da matriz

	#loop que insere valores na memória --------------------------------------------
	loopAdd:
	#trecho que pega dados do usuário
		#addi	$v0, $zero, 5
		#syscall
		#add	$s2, $zero, $v0
		addi $s2, $s2, 0 	#comando temporário

		sw		$s2, 0($s0)
		addi	$s0, $s0, 4

		addi	$s1, $s1, -1
		bgtz	$s1, loopAdd	# Se maior que zero vá para repetição

###################================================================================
# reinicia a posição da memória - MATRIZ[0][0]
lui	$at, 0x1001
add	$a0, $zero, $at

lw	$a1, 0($t1)	# valor a ser decrementado - tamanho da matriz
loopInicioLinha:
lw	$a2, 0($t0)	# valor a ser decrementado - colunas

add	$s3, $zero, $zero
######### loop da soma
loopProcuraNuloLinha:
		lw		$s2, 0($a0)
		addi	$a0, $a0, 4

		# condição
		beq		$zero, $s2, continuaFluxo	#	if (a[m][n] != 0) 	cont++;
      	addi	$s3, $s3, 1					
		
		#------------------------------------------------
		
		continuaFluxo:
		addi	$a2, $a2, -1
		bgtz	$a2, loopProcuraNuloLinha	# Se maior que zero vá para repetição
		
		bne		$s3, $zero, continuaFluxo2 #	if (cont == 0)		qtd_lin++;
		addi	$s4, $s4, 1			# armazena a quantidade de linhas nulas
		
		continuaFluxo2:
		addi	$a1, $a1, -3
		bgtz	$a1,  loopInicioLinha		
#-------------------------------------------------------------
###################================================================================
# reinicia a posição da memória - MATRIZ[0][0] - busca COLUNAS NULAS
lui	$at, 0x1001
add	$a0, $zero, $at

lw	$a1, 0($t1)	# valor a ser decrementado - tamanho da matriz
loopInicioColuna:
lw	$a2, 0($s5)	# valor a ser decrementado - colunas

add	$s3, $zero, $zero
######### loop da soma
loopProcuraNuloColuna:
		lw		$s2, 0($a0)
		addi	$a0, $a0, 12

		# condição
		beq		$zero, $s2, continuaFluxoC	#	if (a[i][j] != 0) 	cont++;
      	addi	$s3, $s3, 1					
		
		#------------------------------------------------
		
		continuaFluxoC:
		addi	$a2, $a2, -1
		bgtz	$a2, loopProcuraNuloColuna	# Se maior que zero vá para repetição
		
		bne		$s3, $zero, continuaFluxo2C #	if (cont == 0)		qtd_col++;
		addi	$s6, $s6, 1			# armazena a quantidade de linhas nulas
		
		continuaFluxo2C:
		addi	$a1, $a1, -15
		bgtz	$a1,  loopInicioColuna		
#-------------------------------------------------------------
		
						
#---------------------------------------------------impressão
	## Linhas nulas
	add		$a0, $zero, $s4 
	addi	$v0, $zero, 1
	syscall

	##Colunas nulas
	add		$a0, $zero, $s6
	addi	$v0, $zero, 1
	syscall		
		
fim:
	addi	$v0, $zero, 10
	syscall
		