.data 
	prompt_tam_lista: .asciiz "\nInforme o tamanho maximo da lista: "
	prompt_menu: .asciiz "\nMENU DE OP��ES:\n1 - Adicionar elemento\n2 - Recuperar elemento\n3 - Imprimir lista\n4 - Deletar elemento\n5 - Sair"
	prompt_acao: .asciiz "\nESCOLHA UMA ���O: "
	prompt_novo_elemento: .asciiz "\nInforme o novo elemento: "
	prompt_indice: .asciiz "\nInforme o indice do elemento:"
	prompt_elemento_recuperado: .asciiz "\nValor recuperado: "
	prompt_recupera_lista: .asciiz "\nA lista informada �:\n"
	prompt_sair: .asciiz "\nEncerrando aplica��o..."
	prompt_lista_vazia: .asciiz "\nA lista n�o cont�m elementos.\n"
	msg_erro_tamanho_lista_impossivel: .asciiz "\n[ERRO] Tamanho da lista inv�lido."
	msg_erro_menu_invalido: .asciiz "\n[ERRO] Op��o inv�lida."
	msg_erro_tamanho_lista_maximo: .asciiz "\n[ERRO] Tamanho m�ximo da lista atingido. Ignorando a��o..."
	msg_erro_indice_invalido: .asciiz  "\n[ERRO] �ndice informado � invalido."
	pula_linha: .asciiz "\n"
	separa_itens: .asciiz " "
  
.text
main:
#INICIO DO PROGRAMA

#Carregamento dos dados iniciais
	li $t1, 0 #tamanho atual da lista em $t1
	li $s1, 1 #Adicionar elemento
	li $s2, 2 #Recuperar elemento
	li $s3, 3 #Imprimir lista
	li $s4, 4 #Deletar elemento
	li $s5, 5 #Sair

#Leitura do tamanho da lista	
	la $a0, prompt_tam_lista
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	blez $v0, erro_tamanho_lista_impossivel #Verifica se o tamanho da lista informado � v�lido ou n�o
	
	move $t0, $v0 #tamanho maximo da lista em $t0		


	
inicio_menu:
#Imprime o menu
	la $a0, prompt_menu
	li $v0, 4
	syscall
	
	la $a0, prompt_acao
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $a1, $v0
	
	blez $v0, erro_menu_invalido
	bgt $v0, $s5, erro_menu_invalido

testa_menu1:	
	seq  $t2, $a1, $s1  #1 - Adicionar elemento	
	beqz $t2, testa_menu2
	jal func_adicionar_elemento

testa_menu2:	
	seq $t2, $a1, $s2 #2 - Recuperar elemento
	beqz $t2, testa_menu3
	jal func_recuperar_elemento

testa_menu3:	
	seq $t2, $a1, $s3 #3 - Imprimir lista
	beqz $t2, testa_menu4
	jal func_imprimir_lista
	
testa_menu4:
	seq $t2, $a1, $s4 #4 - Deletar elemento
	beqz $t2, testa_menu5
	jal func_deletar_elemento

testa_menu5:
	seq $t2, $a1, $s5 #5 - Sair
	beqz $t2, inicio_menu
	jal func_sair
	
	j inicio_menu







	#############
	##  ERROS  ##
	#############
	
#################################
#Erro - Tamanho da lista inv�lido
erro_tamanho_lista_impossivel:
	la $a0, msg_erro_tamanho_lista_impossivel
	li $v0, 4
	syscall
	j main

#################################
#Erro - Menu inv�lido
erro_menu_invalido:
	la $a0, msg_erro_menu_invalido
	li $v0, 4
	syscall
	j inicio_menu

#################################
#Erro - Tamanho da lista inv�lido
erro_tamanho_lista_maximo:
	la $a0, msg_erro_tamanho_lista_maximo
	li $v0, 4
	syscall
	j inicio_menu

#################################
#Erro - �ndice inv�lido
erro_indice_invalido:
	la $a0, msg_erro_indice_invalido
	li $v0, 4
	syscall
	j inicio_menu






	###############
	##  FUN��ES  ##
	###############

###############################
## FUN��O ADICIONAR ELEMENTO ##
func_adicionar_elemento:
#Checa se � poss�vel adicionar novo elemento na lista
	sge $t5, $t1, $t0 #Se Tamanho atual da lista � maior ou igual que o tamanho maximo  $t5 recebe 1
	beq $t5, 1, erro_tamanho_lista_maximo  #Se $t5 == 1 pula para 'erro_tam_lista_maximo' 
	
#Leitura do novo elemento da lista
	la $a0, prompt_novo_elemento
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
#Armazena o valor lido na stack
	add $sp, $sp, -4
	sw $v0, 0($sp)
	
#Incrementa o tamanho da lista
	addi $t1, $t1, 1
	jr $ra 
		
###############################
## FUN��O RECUPERAR ELEMENTO ##
func_recuperar_elemento:
#Checa se existe elemento na lista
	beqz $t1, imprime_lista_vazia_elemento #Se a lista estiver vazia, pula para 'imprime_lista_vazia'
	
	#Pergunta o indice do elemento a ser exibido
	la $a0, prompt_indice
	li $v0, 4
	syscall

	li $v0, 5
	syscall

	#Verifica se o elemento de indice informado � possivel de ser recuperado
	ble $v0, -1 erro_indice_invalido
	bge $v0, $t1, erro_indice_invalido

	#Obt�m o �ndice do elemento da stack a ser impresso
	add $t3, $t1, -1 #$t3 recebe o indice maximo possivel (numero de elementos menos uma unidade)
	sub $t3, $t3, $v0 #Manipula o valor de $t3 para percorrer a stack no caminho inverso
	li $t7, 4 #valor auxiliar para obtencao do indice da stack
	mul $t7, $t7, $t3
	
	la $a0, prompt_elemento_recuperado
	li $v0, 4
	syscall
	
	#Recupera o valor da stack
	add $sp, $sp, $t7
	lw $a0, 0($sp)
	li $v0, 1
	syscall
	
	sub $sp, $sp, $t7 #retorna a stack para a posicao original
	j fim_func_recuperar_elemento
	
#Se a lista estiver vazia, imprime essa informa��o
imprime_lista_vazia_elemento:
	la $a0, prompt_lista_vazia
	li $v0, 4
	syscall
fim_func_recuperar_elemento:
	la $a0, pula_linha
	li $v0, 4
	syscall
	jr $ra































































###########################
## FUN��O IMPRIMIR LISTA ##
func_imprimir_lista:
#Checa se existe elemento na lista
	move $t3, $t1 #$t3 recebe uma copia do tamanho atual da lista
	beqz $t3, imprime_lista_vazia #Se a lista estiver vazia, pula para 'imprime_lista_vazia'
	add $t3, $t3, -1

#Impress�o  dos elementos da lista
	la $a0, prompt_recupera_lista
	li $v0, 4
	syscall
		
for_lista:	
	ble $t3, -1, fim_func_imprimir_lista #Se $t3 <= -1 pula para 'fim_func_imprimir_lista' 

	li $t7, 4 #valor auxiliar para obtencao do indice da stack
	
	mul $t7, $t7, $t3 #obetem o indice do elemento da stack a ser impresso
	
	#Recupera o valor da stack
	add $sp, $sp, $t7
	lw $a0, 0($sp)
	li $v0, 1
	syscall
	
	la $a0, separa_itens
	li $v0, 4
	syscall
	
	sub $sp, $sp, $t7 #retorna a stack a posicao original
	
#Incrementa o tamanho da lista
	addi $t3, $t3, -1
	j for_lista
#Se a lista estiver vazia, imprime essa informa��o
imprime_lista_vazia:
	la $a0, prompt_lista_vazia
	li $v0, 4
	syscall
fim_func_imprimir_lista:
	la $a0, pula_linha
	li $v0, 4
	syscall
	jr $ra


#############################
## FUN��O DELETAR ELEMENTO ##
func_deletar_elemento:




###################
## 'FUN��O' SAIR ##
func_sair:
	la $a0, prompt_sair
	li $v0, 4
	syscall
	li $v0, 10
	syscall
