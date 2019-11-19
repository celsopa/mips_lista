.data 
	prompt_tam_lista: .asciiz "Informe o tamanho maximo da lista: "
	prompt_menu: .asciiz "\nMENU DE OPÇÕES:\n1 - Adicionar elemento\n2 - Recuperar elemento\n3 - Imprimir lista\n4 - Deletar elemento\n5 - Sair"
	prompt_acao: .asciiz "\nESCOLHA UMA ÁÇÃO: "
	prompt_novo_elemento: .asciiz "\nInforme o novo elemento: "
	prompt_recupera_indice: .asciiz "\nInforme o indice do elemento a ser recuperado: "
	prompt_del_indice: .asciiz "\nInforme o indice do elemento a ser deletado: "	
	prompt_recupera_lista: .asciiz "\nA lista informada é: "
	prompt_sair: .asciiz "\nEncerrando aplicação..."
	erro_tamanho_impossivel: .asciiz "\n[ERRO] Tamanho da lista inválido"
	erro_tam_max_lista: .asciiz "\n[ERRO] Tamanho maximo da lista atingido."
	erro_indice: .asciiz  "\n[ERRO] Índice acimo do limite."
  
.text
#Leitura do tamanho da lista
	la $a0, prompt_tam_lista
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $t0, $v0 #tamanho maximo da lista em $t0	
	li $t1, 0 #tamanho atual da lista em $t1
	
#Imprime o menu
	la $a0, prompt_menu
	li $v0, 4
	syscall