.data 
	prompt_tam_lista: .asciiz "\nInforme o tamanho maximo da lista: "
	prompt_menu: .asciiz "\nMENU DE OP��ES:\n1 - Adicionar elemento\n2 - Recuperar elemento\n3 - Imprimir lista\n4 - Deletar elemento\n5 - Sair"
	prompt_acao: .asciiz "\nESCOLHA UMA ���O: "
	prompt_novo_elemento: .asciiz "\nInforme o novo elemento: "
	prompt_recupera_indice: .asciiz "\nInforme o indice do elemento a ser recuperado: "
	prompt_del_indice: .asciiz "\nInforme o indice do elemento a ser deletado: "	
	prompt_recupera_lista: .asciiz "\nA lista informada �: "
	prompt_sair: .asciiz "\nEncerrando aplica��o..."
	prompt_lista_vazia: .asciiz "\nA lista n�o cont�m elementos."
	msg_erro_tamanho_lista_impossivel: .asciiz "\n[ERRO] Tamanho da lista inv�lido."
	msg_erro_menu_invalido: .asciiz "\n[ERRO] Op��o inv�lida."
	msg_erro_tamanho_lista_maximo: .asciiz "\n[ERRO] Tamanho maximo da lista atingido."
	msg_erro_indice: .asciiz  "\n[ERRO] �ndice acimo do limite."
  
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
	
	blez $v0, erro_menu_invalido
	bgt $v0, $s5, erro_menu_invalido
	
	beq $v0, $s1, func_adicionar_elemento #1 - Adicionar elemento
	j inicio_menu
	beq $v0, $s2, func_recuperar_elemento #2 - Recuperar elemento
	j inicio_menu
	beq $v0, $s3, func_imprimir_lista #3 - Imprimir lista
	j inicio_menu
	beq $v0, $s4, func_deletar_elemento #4 - Deletar elemento
	j inicio_menu
	beq $v0, $s5, func_sair #5 - Sair
	j inicio_menu







#############
##  ERROS  ##
#############

#Erro - Tamanho da lista inv�lido
erro_tamanho_lista_impossivel:
	la $a0, msg_erro_tamanho_lista_impossivel
	li $v0, 4
	syscall
	j main

#Erro - Tamanho da lista inv�lido
erro_menu_invalido:
	la $a0, msg_erro_menu_invalido
	li $v0, 4
	syscall
	j inicio_menu

#Erro - Tamanho da lista inv�lido
erro_tamanho_lista_maximo:
	la $a0, msg_erro_tamanho_lista_maximo
	li $v0, 4
	syscall
	j inicio_menu

###############
##  FUN��ES  ##
###############

## FUN��O ADICIONAR ELEMENTO ##
func_adicionar_elemento:
#Checa se � poss�vel adicionar novo elemento na lista
	sle $t5, $t1, $t0 #Se Tamanho atual da lista � menor que o tamanho maximo  $t5 recebe 1
	blez $t5, erro_tamanho_lista_maximo  #Se $t5 <= 0 pula para 'erro_tam_lista_maximo' 
	
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
	addi $t0, $t0,1
	
	
	
	
	
	
	
	

## FUN��O RECUPERAR ELEMENTO ##
func_recuperar_elemento:


## FUN��O IMPRIMIR LISTA ##
func_imprimir_lista:


## FUN��O DELETAR ELEMENTO ##
func_deletar_elemento:





func_sair:
	la $a0, prompt_sair
	li $v0, 4
	syscall
	li $v0, 10
	syscall