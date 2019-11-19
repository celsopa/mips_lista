.data 
	prompt_tam_lista: .asciiz "\nInforme o tamanho maximo da lista: "
	prompt_menu: .asciiz "\nMENU DE OPÇÕES:\n1 - Adicionar elemento\n2 - Recuperar elemento\n3 - Imprimir lista\n4 - Deletar elemento\n5 - Sair"
	prompt_acao: .asciiz "\nESCOLHA UMA ÁÇÃO: "
	prompt_novo_elemento: .asciiz "\nInforme o novo elemento: "
	prompt_recupera_indice: .asciiz "\nInforme o indice do elemento a ser recuperado: "
	prompt_del_indice: .asciiz "\nInforme o indice do elemento a ser deletado: "	
	prompt_recupera_lista: .asciiz "\nA lista informada é: "
	prompt_sair: .asciiz "\nEncerrando aplicação..."
	erro_tamanho_lista_impossivel: .asciiz "\n[ERRO] Tamanho da lista inválido."
	erro_tamanho_lista_maximo: .asciiz "\n[ERRO] Tamanho maximo da lista atingido."
	erro_indice: .asciiz  "\n[ERRO] Índice acimo do limite."
  
.text
main:
#Leitura do tamanho da lista
	li $t1, 0 #tamanho atual da lista em $t1
	la $a0, prompt_tam_lista
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	blez $v0, erro_tam_lista_impossivel #Verifica se o tamanho da lista informado é válido ou não
	
	move $t0, $v0 #tamanho maximo da lista em $t0		
		
inicio_menu:
#Imprime o menu
	la $a0, prompt_menu
	li $v0, 4
	syscall
	
	la $a0, prompt_acao
	li $v0, 4
	syscall








#Erro - Tamanho da lista inválido
erro_tam_lista_impossivel:
	la $a0, erro_tamanho_lista_impossivel
	li $v0, 4
	syscall
	j main

#Erro - Tamanho da lista inválido
erro_tam_lista_maximo:
	la $a0, erro_tamanho_lista_maximo
	li $v0, 4
	syscall
	j inicio_menu


func_novo_elemento:
	sle $t5, $t1, $t0
	blez $t5, erro_tam_lista_maximo
	
	la $a0, prompt_novo_elemento
	li $v0, 5
	syscall
	
	add $sp, $sp, -4
	sw $v0, 0($sp)
	
	addi $t0, $t0,1
