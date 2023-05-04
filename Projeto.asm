;*******Grupo 8*********
; Afonso Pires  102803 *
; António Silva 102879 *
; Diogo Marques 102760 *
;***********************

; Constantes do teclado

DISPLAYS                  EQU 0A000H ; endereço dos displays de 7 segmentos
TEC_LIN                   EQU 0C000H ; endereço das linhas do teclado
TEC_COL                   EQU 0E000H ; endereço das colunas do teclado 
LINHA_T                   EQU 8      ; linha a testar (4ª linha)
MASCARA                   EQU 0FH    ; para isolar os 4 bits de menor peso, ao ler as colunas do teclado
TECLA                     EQU 0B000H
MULTIPLICACAO             EQU 4      ; constante usada para a conversão da tecla
TECLA_COMECO              EQU 000CH  ; tecla para começar o jogo
TECLA_FINAL               EQU 000EH  ; tecla para acabar o jogo
TECLA_PAUSA               EQU 000DH

; Constantes para mudar a forma

MUDAR_INICIO1             EQU 0      ; linha para mudar a primeira vez de forma
MUDAR_INICIO2             EQU 3      ; linha para mudar a segunda vez de forma
MET_INICIO                EQU 7      ; linha para mudar a terceira vez de forma
MET_MEIO                  EQU 11     ; linha para mudar a quarta vez de forma
METEORO                   EQU 15     ; linha para mudar a quinta vez de forma
QUATRO                    EQU 4      ; numero de meteoros

; Constantes do display

VIDA_0                    EQU 0000H  ; valor da vida do Rover no fim
VIDA_100                  EQU 0064H  ; valor da vida do Rover no início
VALOR_100d                EQU 100d   ; constante para obter o digíto das centenas
VALOR_10d                 EQU 10d    ; constante para obter o digíto das dezenas e das unidades
DELAY                     EQU 0FFFFH ; constante de atraso

; Constantes do som

SOM                       EQU 605AH  ; endereço do som na memória do pixel screen
SOM_0                     EQU 0      ; som a aterrar
SOM_1                     EQU 1      ; som a descolar
SOM_2                     EQU 2      ; som para mexer
SOM_3                     EQU 3      ; som a disparar
SOM_4                     EQU 4      ; som da colisao
SOM_5						EQU 5     ;	som gameover 
SOM_6 					EQU 6		;main menu 
MUTE_SOM 			EQU   604CH
RETOMA_SOM 		EQU 	604EH 


; Constantes do ecrã

APAGA_AVISO     		  EQU 6040H  ; endereço do comando para apagar o aviso de nenhum cenário selecionado
APAGA_ECRÃ	 		      EQU 6002H  ; endereço do comando para apagar todos os pixels já desenhados
SELECIONA_CENARIO_FUNDO   EQU 6042H  ; endereço do comando para selecionar uma imagem de fundo
SELECIONA_SOM             EQU 6048H  ; endereço do comando que obtém o som selecionado

COR_PRETA 		          EQU 0F001H
COR_AMARELA   	          EQU 0FFF5H
COR_BRANCA		          EQU 0FFFFH
COR_ROXA		          EQU 0FF49H ; endereço do comando que obtém as cores do Rover e do Meteoro
COR_VERMELHA 	          EQU 0FF00H
COR_LARANJA	              EQU 0FF80H
COR_AZULc 		          EQU 0F0EFH
COR_VERDEc                EQU 40F7H
COR_VERDEe                EQU 0C4F0H
COR_CINZENTA              EQU 0C777H
COR_INVISIVEL             EQU 000EH
COR_AZULe                 EQU 0F14BH

; Constantes do Rover 

DEFINE_LINHA    		  EQU 600AH  ; endereço do comando para definir a linha
DEFINE_COLUNA   		  EQU 600CH  ; endereço do comando para definir a coluna
DEFINE_PIXEL    		  EQU 6012H  ; endereço do comando para escrever um pixel
LE_PIXEL                  EQU 6014H  ; endereço do comando para ler um pixel

LINHA_INI                 EQU 31     ; linha do Rover (a meio do ecrã)
COLUNA_INI                EQU 32     ; coluna do Rover (a meio do ecrã)

COR_PIXEL		          EQU 0FF00H ; cor do pixel

LARGURA                   EQU 5
LINHAS                    EQU 4

MIN_COLUNA		          EQU 0		 ; número da coluna mais à esquerda que o objeto pode ocupar
MAX_COLUNA		          EQU 63     ; número da coluna mais à direita que o objeto pode ocupar
ATRASO			          EQU 2000H	 ; atraso para limitar a velocidade de movimento do Rover

N_LINHAS                  EQU 32     ; número de linhas do écrã 

; Constantes dos cenários

IMAGEM_INICIO             EQU 0      ; cenário de fundo quando o jogo inicia          
IMAGEM_LD0                EQU 1      ; cenários de loading do jogo
IMAGEM_LD1                EQU 2                      
IMAGEM_LD2                EQU 3                     
IMAGEM_LD3                EQU 4
IMAGEM_JOGO               EQU 5      ; cenário de fundo do jogo            
IMAGEM_FIM                EQU 6      ; cenário de fundo quando o jogo termina
IMAGEM_PAUSA              EQU 7      ; cenário quando o jogo está em pausa
IMAGEM_GAMEOVER           EQU 8
ATRASO_LD                 EQU 0FFFFH ; atraso para limitar a velocidade de troca das imagens de loading


; *********************************************************************************
; * INICIALIZAÇÃO DA PILHA
; *********************************************************************************
	PLACE       1000H
pilha:
	STACK       100H	             ; espaço reservado para a pilha 

SP_inicial:				

; **********************************************************************************
; * ROVER E OBJETOS A DESENHAR
; **********************************************************************************
DEF_BONECO:		; tabela que define o boneco (cor, largura, pixels)	
	WORD 		COR_AZULe,  0,  COR_AZULe, 0, COR_AZULe
	WORD		COR_ROXA, COR_AZULe, COR_AMARELA, COR_AZULe, COR_ROXA
	WORD 		0, COR_ROXA, COR_AZULe, COR_ROXA, 0
	WORD		0,0, COR_AZULe,0,0

DEF_INICIO:     ; tabela que define o meteoro bom e mau no inicio antes de se formar
	WORD        1,1        	               ; dimensões do meteoro 
	WORD        COR_CINZENTA, 0, 0, 0, 0
	
DEF_INICIO2:    ; tabela que define o meteoro bom e mau no inicio antes de se formar
	WORD 		2,2 				       ; dimensões do meteoro 
	WORD		COR_CINZENTA, COR_CINZENTA
	WORD        COR_CINZENTA, COR_CINZENTA
	
DEF_MAU:        ; tabela que define o meteoro (cor, largura, pixels)
	WORD 		5,5						   ; dimensões do meteoro 
	WORD 		COR_LARANJA, COR_INVISIVEL, COR_INVISIVEL, COR_INVISIVEL, COR_LARANJA
	WORD 		COR_LARANJA, 0, COR_LARANJA, 0, COR_LARANJA
	WORD 		0, COR_VERMELHA, COR_VERMELHA, COR_VERMELHA, 0
	WORD		COR_VERMELHA, 0, COR_VERMELHA, 0, COR_VERMELHA
	WORD 		COR_VERMELHA, 0, 0, 0, COR_VERMELHA
	
DEF_MAU_INICIO:
	WORD 	    3,3						   ; dimensões do meteoro 
	WORD		COR_VERMELHA, 0, COR_VERMELHA
	WORD		0, COR_VERMELHA, 0
	WORD		COR_VERMELHA, 0, COR_VERMELHA
	
DEF_MAU_MEIO:
	WORD 		4,4						   ; dimensões do meteoro 
	WORD		COR_VERMELHA, 0, 0, COR_VERMELHA
	WORD		COR_VERMELHA, 0, 0, COR_VERMELHA
	WORD		0, COR_VERMELHA, COR_VERMELHA, 0
	WORD		COR_VERMELHA, 0, 0, COR_VERMELHA

DEF_BOM:        ; tabela que define o meteoro (cor, largura, pixels)
	WORD 		5,5					       ; dimensões do meteoro 
	WORD 		COR_INVISIVEL, COR_VERDEe, COR_VERDEe, COR_VERDEe, COR_INVISIVEL
	WORD 		COR_VERDEe, COR_VERDEe, COR_VERDEe, COR_VERDEe, COR_VERDEe
	WORD 		COR_VERDEe, COR_VERDEe, COR_VERDEe, COR_VERDEe, COR_VERDEe
	WORD		COR_VERDEe, COR_VERDEe, COR_VERDEe, COR_VERDEe, COR_VERDEe
	WORD 		0, COR_VERDEe, COR_VERDEe, COR_VERDEe, 0

DEF_BOM_INICIO:
	WORD 		3,3 						; dimensões do meteoro 
	WORD		0, COR_VERDEe, 0
	WORD		COR_VERDEe, COR_VERDEe, COR_VERDEe
	WORD		0, COR_VERDEe, 0
	
DEF_BOM_MEIO: 
	WORD 		4,4 						; dimensões do meteoro 
	WORD		0, COR_VERDEe, COR_VERDEe, 0
	WORD		COR_VERDEe, COR_VERDEe, COR_VERDEe, COR_VERDEe
	WORD		COR_VERDEe, COR_VERDEe, COR_VERDEe, COR_VERDEe
	WORD		0, COR_VERDEe, COR_VERDEe, 0
	
DEF_COLISAO:
	WORD        0, COR_AZULc, 0 , COR_AZULc, 0
	WORD        COR_AZULc, 0, COR_AZULc, 0, COR_AZULc
	WORD        0, COR_AZULc, 0 , COR_AZULc, 0
	WORD        COR_AZULc, 0, COR_AZULc, 0, COR_AZULc
    WORD        0, COR_AZULc, 0 , COR_AZULc, 0

DEF_MISSIL: WORD COR_AZULc

DEF_BONECO2:		; tabela que define o boneco (cor, largura, pixels)
	WORD 		0, COR_ROXA, COR_AZULc, COR_ROXA, 0
	WORD		COR_ROXA, COR_AZULc, COR_AZULc, COR_AZULc, COR_ROXA	
	WORD 		COR_ROXA, COR_ROXA, COR_AZULc, COR_ROXA, COR_ROXA
	WORD		COR_ROXA, 0, COR_AZULc, 0, COR_ROXA
	
LINHA_COLISAO: WORD 1CH 
	
COLUNA_NAVE: WORD 32
LINHA_NAVE: WORD 1FH

COLUNA_MET_MAU: WORD 29
COLUNA_MET_BOM: WORD 41

LINHA_MET_MAU: WORD 4
LINHA_MET_BOM: WORD 4

COLUNA_MET_MAU_MEIO: WORD 30
COLUNA_MET_MAU_ESQ: WORD 16
COLUNA_MET_MAU_DIR: WORD 44

LINHA_MET_MAU_DIR: WORD 4
LINHA_MET_MAU_ESQ: WORD 4

POS_X_MISSIL: WORD 0
POS_Y_MISSIL: WORD 0

MAX_MOV_MISSIL: WORD 12

EXISTE_MISSIL:  WORD 0      ;nao existe nenhuma bala no ecra
						    ; 1  já existe uma bala no ecrâ 
	
NO_JOGO: WORD -1            ; 0 quando não estamos em jogo, 1  caso contrário 

TECLA_PRIMIDA: WORD  0

NUMERO_MET: WORD 0 

endereco_coluna_met: WORD  0

meteoro1 : WORD   0         ; 0 bom, 1 MAU 
desenho1: WORD 0 
pos_coluna_1  : WORD 0 
pos_linha_1  : WORD  0

meteoro2 : WORD   0         ; 0 bom, 1 MAU
desenho2: WORD 0  
pos_coluna_2  : WORD 0
pos_linha_2  : WORD  0

meteoro3 : WORD  0          ; 0 bom, 1 MAU 
desenho3: WORD 0 
pos_coluna_3  : WORD 0 
pos_linha_3  : WORD  0

meteoro4 : WORD   0         ; 0 bom, 1 MAU 
desenho4: WORD 0 
pos_coluna_4  : WORD 0 
pos_linha_4  : WORD  0


DESENHO_ROVER: WORD 0 

NIVEL: WORD 0 

KILL_MET: WORD 0 

; **********************************************************************************
; * TABELAS DAS ROTINAS DE INTERRUPÇÃO 
; **********************************************************************************
	PLACE		3000H

tab_int:	
	WORD	rot_int_0               ; rotina de atendimento de interrupção 0
	WORD 	rot_int_1               ; rotina de atendimento de interrupção 1
	WORD 	rot_int_2               ; rotina de atendimento de interrupção 2
	
meteoro_int: WORD 0	

meteoro_bom_int: WORD 0
	
missil_int:  WORD 0   

vida_int:    WORD 0
 
; ********************************************************************************
; * Código
; *********************************************************************************
	PLACE   0				            ; o código tem de começar em 0000H

inicio:
	MOV  SP, SP_inicial		            ; inicializa SP para a palavra a seguir à última da pilha
	MOV  BTE, tab_int                   ; inicializa BTE (registo de Base da Tabela de Exceções)

	MOV  [APAGA_AVISO], R1	            ; apaga o aviso de nenhum cenário selecionado (o valor de R1 não é relevante)
	MOV  [APAGA_ECRÃ], R1	            ; apaga todos os pixels já desenhados (o valor de R1 não é relevante)
	MOV  R1, IMAGEM_INICIO
	MOV  [SELECIONA_CENARIO_FUNDO], R1	; seleciona o cenário de fundo
	
	MOV R4, DISPLAYS                    
	MOV R11, VIDA_0                   
	MOV [R4], R11                       ; coloca o display a 0, uma vez que o jogo não começou 
	
	CALL reseta_dados
	MOV R6, SOM_6
	CALL som
	
	EI0
	EI1
	EI2
	EI
	
ciclo_main:
	CALL teclado                        ; lê as teclas do teclado
	ADD R8, 1							; incrementa o contador para o gerador
	
	MOV R6, [TECLA_PRIMIDA]
	CMP R6 , 0 
	JZ premiu
	
	MOV R6, TECLA_COMECO      
	CMP R7, R6                          ; se premir a tecla  C começa o jogo 
	JZ comeco
	MOV R6, TECLA_FINAL
	CMP R6, R7 							; se premir a tecla E acaba o jogo 
	JZ fimJOGO
	MOV R6, TECLA_PAUSA
	CMP R7, R6 							; se premir a tecla D pausa o jogo 
	JZ rotina_pausa
	
	CMP R7, 0 
	JZ move                             ; se premir a tecla 0 o rover move-se para a esquerda 
	CMP R7, 2 
	JZ move								; se premir a tecla 2 o rover move-se para a direita 
	CMP R7, 1 
	JZ missil					        ; se premir a tecla 1 o rover dispara missil
	JMP premiu 
	
comeco:
	MOV R1, SOM_5
	MOV [MUTE_SOM], R1 
	MOV R6, [NO_JOGO]
	CMP R6, 1
	JZ  premiu
	MOV R6, SOM_1                       ; coloca no R0 o som do inicio 
	CALL som
	CALL loading                        ; rotiina loading com imagens sucessivas
	MOV R1, SOM_6
	MOV [MUTE_SOM], R1 
	CALL verifica_display               ; verifica se o display está a 100, se não estiver é resetado a 100
	MOV R1, IMAGEM_JOGO
	MOV [SELECIONA_CENARIO_FUNDO], R1	; seleciona o cenário de fundo do jogo
	MOV R1, [NO_JOGO]
	MOV R1, 1                           ; estamos com o jogo iniciado 
	MOV [NO_JOGO], R1 
	JMP chama_boneco                    ; desenha boneco 
	
missil:
	MOV R10, [EXISTE_MISSIL]
	CMP R10, 0
	JNZ premiu 
	CALL cria_missil
	CALL decrementa
	JMP premiu 

rotina_pausa:
	CALL pausa
	JMP premiu
	
fimJOGO: 
	MOV R1, [NO_JOGO]
	CMP R1 , 0
	JZ premiu
	MOV R1, [NO_JOGO]
	MOV R1, 0     					   ; saimos do jogo, logo o rover nao move 
	MOV [NO_JOGO], R1
	MOV R1, 1
	MOV [SELECIONA_SOM], R1            ; Seleciona som de fim de jogo 
	MOV [APAGA_ECRÃ], R1 
	MOV R6, IMAGEM_FIM
	MOV  [SELECIONA_CENARIO_FUNDO], R6 ; seleciona o cenário de fundo de fim de jogo
	MOV R6, SOM_0                      ; som de aterragem
	CALL som
	CALL ha_tecla
	CALL reseta_dados
	JMP ciclo_main

chama_boneco:
	MOV R1, DEF_BONECO
	MOV [DESENHO_ROVER], R1 
	MOV R7, LINHA_INI
	MOV [LINHA_NAVE], R7                ; coloca a linha do rover na posição inicial
	MOV R7, COLUNA_INI
	MOV [COLUNA_NAVE], R7               ; coloca a coluna do rover na posição inicial
	CALL desenha_rover
	CALL ha_tecla                       ; verifica se a teclaestá primida 
	JMP premiu 
	
move:
	MOV R6, R7
	CALL MOVE                           ; chama rotina para mover o boneco 
	JMP premiu 
	

ha_tecla:
	MOV R3, TEC_COL
	MOV R5, MASCARA

	MOVB R6, [R3]
	AND  R6, R5 
	CMP R6, 0
	JNZ ha_tecla                        ; não sai da função enquanto estiver alguma tecla primida 
	RET

premiu:	
	MOV R7, 3
	CALL verifica_display_fim
	CALL rotina_missil
	CALL colisao
	CALL decrementa 
	CALL cria_meteoro
	CALL move_meteoro
	CALL colisao
	MOV R6, [TECLA_PRIMIDA]
	MOV R6 , 0 
	MOV [TECLA_PRIMIDA], R6
	JMP ciclo_main 


;*********************************************************************************
; SOM - Emite um som  
;                  
; Argumentos: R6 --> Número do som a emitir
;*********************************************************************************
som: 
	PUSH R1
	PUSH R6
	MOV R1, SOM
	MOV [R1], R6
	POP R6
	POP R1
	RET



;*********************************************************************************
; VERIFICA_DISPLAY_FIM - Verifica se o DISPLAY está a zero e se estiver
;                        GAME OVER
; Argumentos: R11 --> valor do display
;*********************************************************************************
verifica_display_fim:
	PUSH R0
	PUSH R1

	MOV R0, [NO_JOGO]
	CMP R0,0 
	JZ sai_verifica_fim

	CMP R11, 0 
	JZ acaba 
	JMP sai_verifica_fim 
	
acaba:
	CALL reseta_dados
	MOV R1, SOM_5
	MOV [RETOMA_SOM], R1 
	MOV R10, [NO_JOGO]
	MOV R10, 0     							; saimos do jogo, logo o rover nao move 
	MOV [NO_JOGO], R10 
	MOV R10, 1	
	MOV [SELECIONA_SOM], R10            ; Seleciona som de fim de jogo 
	MOV [APAGA_ECRÃ], R1 	
	MOV R6, IMAGEM_GAMEOVER 
	MOV  [SELECIONA_CENARIO_FUNDO], R6					; seleciona o cenário de fundo de fim de jogo
	MOV R6, SOM_5                       												; som de aterragem
	CALL som

sai_verifica_fim:
	POP R4 
	POP R0 
	RET 	

;*********************************************************************************
; RESET_DADOS - Reset todas as variaveis para o valor padrão
;
;*********************************************************************************
reseta_dados: 
	PUSH R0
	PUSH R1 
	PUSH R2 
	
	MOV R0, 12 
	MOV [MAX_MOV_MISSIL], R0 
	MOV R0 , 0
	MOV [NO_JOGO], R0 
	MOV [EXISTE_MISSIL], R0 
	MOV [NUMERO_MET], R0
	MOV [meteoro_int], R0
	MOV [missil_int], R0
	MOV [vida_int], R0
	MOV R8, R0                                ;  inicia o contador a  0

	MOV R1, pos_coluna_1
	MOV R2, 0 
	
ciclo_reseta:
	CMP R2, 4 
	JZ fim_reseta
	MOV R0 , 0 
	MOV [R1], R0 
	MOV [R1+2], R0 
	MOV R0, 8 
	ADD R1, R0 
	ADD R2, 1 
	JMP ciclo_reseta
	
fim_reseta:
	POP R2
	POP R1
	POP R0 
	RET

;*********************************************************************************
; VERIFICA_DISPLAY - Coloca o valor do display a 100
;*********************************************************************************
verifica_display:
	PUSH R0
	PUSH R4 

	MOV R0, VIDA_100
	CMP R0, R11
	JNZ RESET                           ; se o display não se encontrar a 100 é resetado 
	JMP sai_verifica
	
RESET:
	MOV R4, DISPLAYS
	MOV R11, VIDA_100
	CALL converte_display
	

sai_verifica:
	POP R4
	POP R0
	RET 

;*********************************************************************************
; ROTINAS DE INTERRUPÇÃO
;*********************************************************************************
rot_int_0:
    PUSH R0
    PUSH R1
	PUSH R2
    MOV R0, meteoro_int
	MOV R2, meteoro_bom_int
    MOV R1, 1
    MOV [R0], R1
	MOV [R2], R1
	POP R2
    POP R1
    POP R0
	RFE									; Return from Exception

rot_int_1:
    PUSH R0
    PUSH R1
    MOV  R0, missil_int
    MOV  R1, 1
    MOV  [R0], R1
    POP  R1
    POP  R0
    RFE
   
rot_int_2:
    PUSH R0
    PUSH R1
    MOV  R0, vida_int
    MOV  R1, 1
    MOV  [R0], R1
    POP  R1
    POP  R0
    RFE
   
;*********************************************************************************
; ROTINAS DE ATRASO
;*********************************************************************************

;*********************************************************************************
; ATRASO - Faz o Rover deslocar-se, de forma a 
;          consigamos ver o seu movimento
;*********************************************************************************
atraso:
	PUSH	R11
	MOV R11, ATRASO
ciclo_atraso:
	SUB	R11, 1
	JNZ	ciclo_atraso
	POP	R11
	RET

;*********************************************************************************
; ATRASO_DISPLAY - Faz o display incrementar ou decrementar 5,  
;                  de forma a que consigamos ver a alteração
;*********************************************************************************
atraso_display:
	PUSH R2
	MOV R2, DELAY 
ciclo_atraso2:
	SUB R2, 1
	JNZ ciclo_atraso2
	POP R2
	RET

;*********************************************************************************
; ATRASO_LOADING - Faz o cenário de loading trocar de imagens,  
;                  de forma a que consigamos ver a alteração
;*********************************************************************************
atraso_loading:
	MOV R11, ATRASO_LD
	JMP ciclo_loading
ciclo_loading:
	SUB	R11, 1
	JNZ	ciclo_loading
	RET
	
; ********************************************************************************
; CRIA_METEORO - Cria um meteoro para ser desenhado no jogo
;
; ********************************************************************************
cria_meteoro:
	PUSH R4 
	PUSH R2
	PUSH R3
	PUSH R1 	
	
	MOV R3, [NO_JOGO]              ; verifica se está no jogo
	CMP R3, 0 
	JZ fim_cria_met
	
	MOV R3, [NUMERO_MET]           ; verifica se o número de meteoros máximo
	CMP R3, QUATRO                 ; no ecrâ foi atinigido
	JZ fim_cria_met
	
	MOV R4, pos_coluna_1
	MOV R3, 0
	
ciclo_met:
	CMP R3, QUATRO                 ; se já existirem 4 meteoros
	JZ fim_cria_met                ; sai da funcao
	MOV R2, [R4]
	CMP R2, 0 
	JNZ muda_met 
	CALL gerador                   ; gera uma coluna
	CALL aleatorio                 ; gera o tipo de meteoro
	MOV R2, [R4-4]
	MOV R2, [endereco_coluna_met]  	
	MOV [R4], R2 
	MOV R3, [NUMERO_MET]
	ADD R3, 1 
	MOV [NUMERO_MET], R3
	MOV R2, [R4]
	MOV R1, [R4+2]
	MOV R9, DEF_INICIO
	CALL desenha_meteoro
	JMP fim_cria_met

muda_met: 
	MOV R2,  8
	ADD R4, R2 
	ADD R3, 1 
	JMP ciclo_met
	
fim_cria_met:
	POP R1 
	POP R3
	POP R2 
	POP R4  
	RET 
	
; **********************************************************************
; GERADOR - Retorna uma coluna aleatoria para desenhar 
;
; Argumentos: R9 --> contador
; **********************************************************************
gerador:
    PUSH R0               
    PUSH R1
   	PUSH R8 
    MOV  R0, 3
    MOD  R8, R0                     ; resto da divisao do contador por 3
    JNZ  nao_zero                   ; se o resto for 0, retorna o endereco da nave da esq
    MOV  R0, [COLUNA_MET_MAU_ESQ]
    JMP fim_gerador

nao_zero:
    MOV  R0, 1
    CMP  R8, R0
    JNZ  nao_um                     ; se o resto for 1, retorna o endereco da nave do meio
    MOV  R0, [COLUNA_MET_MAU_MEIO]
    JMP  fim_gerador

nao_um:                             ; se o resto for 2, retorna o endereco da nave da dir
    MOV  R0, [COLUNA_MET_MAU_DIR]

fim_gerador:
    MOV R1, endereco_coluna_met
    MOV [R1], R0
    POP R8 
    POP R1
    POP R0
    RET	
	
; ********************************************************************************
; ALEATORIO - Retorna um tipo de meteoro (bom ou mau) aleatoria para desenhar
;
; Argumentos: R4 --> Tipo do meteoro
; ********************************************************************************
aleatorio:
	PUSH R0 
	PUSH R1 
	PUSH R8 
	ADD R8, 3               ; iniciàmos um contador que vamos incrementando
	MOV R0, 4 
	MOD R8, R0              ; fazemos o resto da divisão do contador por 4
	JNZ nao_zero2 
	MOV R0, 0               ; resto 0
	JMP fim_aleatorio 
	
nao_zero2:
	CMP R8, 1               
	JNZ nao_um2
	MOV R0, 1               ; resto 1 
	JMP fim_aleatorio
	
nao_um2:
	CMP R8, 2 
	JNZ nao_dois 
	MOV R0, 0               ; resto 2 
	JMP fim_aleatorio
	
nao_dois:
	MOV R0, 0 
	
fim_aleatorio:
	MOV [R4-4], R0          ; tipo de meteoro
	POP R8 
	POP R1 
	POP R0 
	RET 

; ********************************************************************************
; MOVE_METEORO - Faz o meteoro mover-se
;
; Argumentos: R1 --> Linha onde está o meteoro
; ********************************************************************************
move_meteoro:
	PUSH R6
	PUSH R2
	PUSH R3
	PUSH R4 
	PUSH R5
	
	MOV R6, [meteoro_int]
	CMP R6, 0                   ; atualiza na variável a linha em que o meteoro está
	JZ saida_move_meteoro
	
	MOV R5, [NO_JOGO]
	CMP R5, 0                   ; se nao tivermos no ecra de jogo, os meteoros não se movem 
	JZ saida_move_meteoro
	
	MOV R6,  pos_coluna_1       ; atualiza a linha em que está o meteoro
	MOV R3, 0 

ciclo_move_meteoros:
	CMP R3, QUATRO
	JZ saida_move_meteoro
	MOV R2, [R6+2]
	MOV R5, 1FH
	CMP R5, R2 
	JZ embate_meteoro
	MOV R2, [R6]
	CMP R2, 0 
	JZ muda_met1
	
	MOV R2, [R6]                ; argumentos para a funcao apaga_meteoro
	MOV R1, [R6+2]
	
	CALL apaga_meteoro
	
	MOV R2, R6
	MOV R4, [R2+2]              ; linha do meteoro
	ADD R4 , 1 
	MOV [R2+2], R4 
	
	MOV R2, [R6]                ; argumentos para as funcoes seguintes   
	MOV R1, [R6+2]
	CALL verifica_forma
	CALL desenha_meteoro 
	
muda_met1:
	ADD R3, 1 
	MOV R2, 8 
	ADD R6, R2 
	JMP ciclo_move_meteoros
	
embate_meteoro:
	MOV R2, [R6]
	MOV R1, [R6+2] 
	MOV R9, DEF_MAU
	CALL apaga_meteoro
	MOV R2, 0 
	MOV [R6], R2 
	MOV [R6+2], R2 
	MOV R2, [NUMERO_MET]
	SUB R2, 1 
	MOV [NUMERO_MET], R2 
	MOV R2, [R6-4]
	CMP R2, 0
	JZ decrementa_embate 
	JMP muda_met1
	
decrementa_embate:
	MOV R7, 1
	CALL decrementa
	JMP muda_met1
	
saida_move_meteoro:
	MOV R6, 0
	MOV [meteoro_int], R6
	
	POP R5
	POP R4 
	POP R3
	POP R2 
	POP R1
	RET

;*********************************************************************************
; VERIFICA_FORMA - verifica qual a forma do meteoro que é preciso  
;                  e guarda em R9 a tabela do meteoro que tem de desenhar,
;                  nas diferentes fases do movimento
;
; Argumentos: R1 --> linha
;             R2 --> coluna
;*********************************************************************************
verifica_forma:
	PUSH R1
	PUSH R2 
	PUSH R3 
	PUSH R4 
	PUSH R5
	PUSH R6 	

	MOV R1, R6 
	MOV R2, 0 
	
ciclo_muda_forma:
	MOV R3, [R1]
	CMP R3, 0 
	JZ muda_met2
	MOV R6, [R1-4]                ; tipo do met 
	MOV R4, [R1+2]                ; linha do met 
	MOV R5, MUDAR_INICIO2
	CMP R4, R5                    ; verifica se está na linha correta para mudar de forma
	JGT mudar_inicio2
	MOV R9, DEF_INICIO            ; se estiver na linha, atualiza a tabela que desenha
	JMP fim_verifica              
	
muda_met2:
	MOV R3, 8
	ADD R1, R3                    ; muda para de meteoro, para verificar se também 
	ADD R2, 1                     ; tem que mudar de forma
	JMP ciclo_muda_forma
	
mudar_inicio2:
	MOV R5, MET_INICIO            
	CMP R4, R5                    ; verifica outra linha
	JGT  met_inicio
	MOV R9, DEF_INICIO2
	JMP fim_verifica
	
met_inicio:
	MOV R5, MET_MEIO
	CMP R4, R5                    ; verifica outra linha
	JGT  met_meio
	CMP R6, 0                     ; verifica qual é o tipo de meteoro (mau ou bom) a alterar 
	JZ mau_i 	
	MOV R9, DEF_BOM_INICIO
	JMP fim_verifica
mau_i:
	MOV R9, DEF_MAU_INICIO
	JMP fim_verifica
	
met_meio:
	MOV R5, METEORO
	CMP R4, R5                    ; verifica outra linha
	JGT meteoro
	CMP R6, 0                     ; verifica qual é o tipo de meteoro (mau ou bom) a alterar
	JZ mau_m
	MOV R9, DEF_BOM_MEIO
	JMP fim_verifica
mau_m:
	MOV R9, DEF_MAU_MEIO
	JMP fim_verifica
	
meteoro:
	CMP R6, 0                     ; verifica qual é o tipo de meteoro (mau ou bom) a alterar
	JZ met_mau 
	MOV R9, DEF_BOM
	JMP fim_verifica 
met_mau:
	MOV R9, DEF_MAU
	JMP fim_verifica
	
fim_verifica:
	POP R6 
	POP R5 
	POP R4 
	POP R3 
	POP R2 
	POP R1 
	RET 

;*********************************************************************************
; DESENHA_METEORO - Desenha um meteoro bom ou mau no ecrã  
;                  
; Argumentos: R9 --> Tabela do meteoro que vai desenhar
;*********************************************************************************
desenha_meteoro:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R0
	PUSH R5
	PUSH R6
	PUSH R9
	MOV R6, [R9]
	ADD R9, 2 
	MOV R5, [R9]			            ; obtém a largura do boneco
	MOV R0, R5 
	ADD R9, 2 

desenha_pixels2:       		            ; desenha os pixels do boneco a partir da tabela
	MOV	R3, [R9]                        ; obtém a cor do pixel do boneco
	CALL escreve_pixel		            ; escreve cada pixel do boneco
	ADD	R9, 2                           ; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
    ADD R2, 1                           ; próxima coluna
    SUB R5, 1			                ; menos uma coluna para tratar
    JNZ desenha_pixels2                 ; continua até percorrer toda a largura do objeto
	CALL prox_l2
	SUB R6, 1
	JNZ desenha_pixels2
	MOV R7, R2                          ; guarda a coluna do ultimo pixel desenhado 
	ADD R1, 1                           ; compensa o -1 no prox_l 
	POP R9
	POP R6
	POP	R5
	POP	R0
	POP	R3
	POP	R2
	POP R1
	RET

prox_l2:
	MOV R5, R0                          ; largura meteoro 
	SUB R1, 1                           ; proxima linha a desenhar 
	SUB R2, R0                          ; volta para a coluna mias à esquerda 
	RET
	
;*********************************************************************************
; APAGA_METEORO - Apaga um objeto do ecrâ. 
;          
; Argumentos: R1 --> linha
;             R2 --> coluna
;*********************************************************************************
apaga_meteoro: 
	PUSH R2
	PUSH R3
	PUSH R5
	PUSH R6
	MOV R5, LARGURA 
	MOV R6, 5

apaga_pixel2:		
	MOV R3, 0                           ; cor definida para 0 
	CALL escreve_pixel
	ADD R2, 1                           ; incrementa coluna para desenhar novo pixel 
	SUB R5, 1                           ; menos uma coluna a tratar
	JNZ apaga_pixel2
	MOV R5, LARGURA
	SUB R1, 1                           ; proxima linha do meteoro a desenhar 
	SUB R2, 5
	SUB R6 ,1                           ; menos uma linha a tratar
	JNZ apaga_pixel2
	ADD R1, 5
	POP R6
	POP R5
	POP R3
	POP R2 
	RET

; **************************************************************************
; MOVE - Move o rover no ecrã
;
; Argumentos:   R1 --> linha
;               R2 --> coluna
; **************************************************************************
MOVE:
	PUSH R5
	PUSH R3
	PUSH R1
	PUSH R2
	
	MOV R1, [NO_JOGO]
	CMP R1, 0
	JZ sai
	
	MOV R2, [COLUNA_NAVE]
	MOV R1, [LINHA_NAVE]
	
testa_lim_esquerdo:                    ; vê se o Rover chegou ao limite esquerdo
	MOV R5, MIN_COLUNA
	CMP R2, R5
	JZ movimento_limite_esquerdo
	JMP testa_lim_direito
	
movimento_limite_esquerdo:
	CMP R6, 0                          ; se estiver no limite esquerdo e a tecla 0 for premida, não há movimento 
	JZ sai
	JMP move_desenho
	
movimento_limite_direito:
	CMP R6, 2                           ;se estiver no limite direito e a tecla 2 for premida, não há movimento 
	JZ sai
	JMP move_desenho
	
testa_lim_direito:
	MOV R5, MAX_COLUNA
	MOV R3, LARGURA
	ADD R3, R2
	CMP R3, R5                        ; passa a deslocar-se para a esquerda
	JGT movimento_limite_direito
	JMP move_desenho

move_desenho:
	CALL atraso                        ; delay que permite que o rover nao se move tão depressa 
	CALL apaga_boneco
	CMP R6, 2                          ; se a tecla primida for 2 então ele vai mover-se para direita
	JZ MOV_DIR       
	SUB  R2, 1		                   ; se a tecla primida for 0 então vai se mover para a esquerda e subtrai um coluna 
	MOV [COLUNA_NAVE], R2	           ; guarda a coluna 
	CALL desenha_rover                 ; desenha o rover nas novas coordenadas 
	MOV R6, SOM_2		               ; som ao mover o rover 
	CALL som
	JMP sai

MOV_DIR:
	ADD R2, 1                          ; como se move para a direita encrementamos a coordenada da coluna do rover 
	MOV [COLUNA_NAVE], R2
	CALL desenha_rover                 ; desenha rover nas novas coordenadas 
	MOV R6, SOM_2	                   ; som ao mover o rover 
	CALL som
	JMP sai
	
sai:
	POP R2
	POP R1
	POP R3
	POP R5 
	RET

; **************************************************************************
; DESENHA_ROVER - Desenha um boneco na linha e coluna indicadas
;			    com a forma e cor definidas na tabela indicada.
; Argumentos:   R1 - linha
;               R2 - coluna
;               R4 - tabela que define o boneco
; **************************************************************************
desenha_rover:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	MOV R6, LINHAS
	MOV	R4, [DESENHO_ROVER]		           ; endereço da tabela que define o boneco
	MOV	R5, LARGURA			           ; obtém a largura do boneco			             
	MOV R1, [LINHA_NAVE]
	MOV R2, [COLUNA_NAVE]

desenha_pixels:       		           ; desenha os pixels do boneco a partir da tabela
	MOV	R3, [R4]			           ; obtém a cor do próximo pixel do boneco
	CALL escreve_pixel		           ; escreve cada pixel do boneco
	ADD	R4, 2			               ; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
    ADD R2, 1                          ; próxima coluna
    SUB R5, 1			               ; menos uma coluna para tratar
    JNZ desenha_pixels                 ; continua até percorrer toda a largura do objeto
	CALL prox_l
	SUB R6, 1
	JNZ desenha_pixels
	MOV R7,R2                          ; guarda a coluna do ultimo pixel desenhado 
	ADD R1, 1                          ; compensa o -1 no prox_l 
	MOV [COLUNA_NAVE], R2	           ; guarda coluna 
	MOV [LINHA_NAVE], R1	           ; guarda linha 
	POP R6
	POP	R5
	POP	R4
	POP	R3
	POP	R2
	POP R1
	RET

prox_l:
	MOV R5, LARGURA                    ; largura do rover 
	SUB R1, 1                          ; proxima linha a desenhar 
	SUB R2, 5                          ; volta para a coluna mais à esquerda 
	RET

; ********************************************************************************
; ESCREVE_PIXEL - Escreve um pixel na linha e coluna indicadas.
; Argumentos:   R1 - linha
;               R2 - coluna
;               R3 - cor do pixel (em formato ARGB de 16 bits)
; ********************************************************************************
escreve_pixel:
	MOV  [DEFINE_LINHA], R1		       ; seleciona a linha
	MOV  [DEFINE_COLUNA], R2           ; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3		       ; altera a cor do pixel na linha e coluna já selecionadas
	RET

;*********************************************************************************
; APAGA_BONECO - Apaga um objeto do ecrâ. 
;          
; Argumentos: R4 --> endereço do objeto 
;*********************************************************************************
apaga_boneco:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R5
	PUSH R6
	MOV R6, LINHAS                     ; quantidade de linhas do rover 
	MOV R5, LARGURA
	MOV R2, [COLUNA_NAVE]              ; coordenada da coluna do rover
	MOV R1, [LINHA_NAVE]               ; coordenada da linha do rover 

apaga_pixel:		
	MOV R3, 0                          ; cor definida para 0 
	CALL escreve_pixel
	ADD R2, 1                          ; incrementa coluna para desenhar novo pixel 
	SUB R5, 1                          ; menos uma coluna a tratar 
	JNZ apaga_pixel
	MOV R5, LARGURA
	ADD R1, 1                          ; proxima linha do rover a desenhar 
	SUB R2, 5                          ; volta para a coluna mais à esquerda 
	SUB R6 ,1                          ; menos uma linha a tratar 
	JNZ apaga_pixel
	SUB R1, 1                          ; compensa o incremento a mais feito anteriormente 
	MOV [LINHA_NAVE], R1               ; guarda a linha 
	POP R6
	POP R5
	POP R3
	POP R2
	POP R1
	RET

;*********************************************************************************
; TECLADO - Retorna a tecla premida pelo utilizador no periférico do teclado 
;           (POUT-2).  
;*********************************************************************************
teclado: 
	PUSH R0
	PUSH R9
	PUSH R1
	PUSH R2
	PUSH R6 
	PUSH R4 
	PUSH R8 
	
inicializacoes:
	MOV R2, TEC_LIN
	MOV R3, TEC_COL
	MOV R4, DISPLAYS
	MOV R5, MASCARA
	MOV R6, LINHA_T
	MOV R8, MULTIPLICACAO

começa:
	MOV R7, 0
	MOV R9, 0
	
ciclo_teclado:
   MOVB [R2], R6                        ; escreve no periférico de saida qual é a linha
   MOVB R0, [R3]
   MOV R1,R0
   AND R0, R5  
   CMP R0, 0
   JNZ converte					        ; se alguma tecla for primida entao convertemos para saber qual foi 
   SHR R6,1                             ; muda de linha 
   JZ saida                             ; passa para a 4ª linha 
   JMP ciclo_teclado

adc_l:
	ADD R7, 1                           ; incrementa registo 
	JMP converte
	
adc_c:
	ADD R9 ,1                           ; incrementa registo
	JMP converte

converte:
	MOV R1, [LINHA_NAVE]
	SHR R6, 1
	CMP R6, 0
	JNZ adc_l                           ; vai encrementando o R7 até R6 ser 0
	SHR R0,1
	CMP R0,0
	JNZ adc_c                           ; vai encrementando o R9 até R6 ser 0
	MUL R7, R8	                        ; formula para converter para o valor da tecla primida 
	ADD R7, R9
	MOV R9, [TECLA_PRIMIDA]
	MOV R9, 1 
	MOV [TECLA_PRIMIDA], R9 

saida:
	POP R8
	POP R4 
	POP R6 
	POP R2
	POP R1
	POP R9
	POP R0 
	RET
	
;*********************************************************************************
; CRIA_MISSIL - Cria um missil para ser disparado 
;                  
;*********************************************************************************
cria_missil:
	PUSH R5
	PUSH R3 
	PUSH R6
	PUSH R2 
	PUSH R1 
	MOV R1, [NO_JOGO]
	CMP R1, 0  				  		 ; se nao tivermos no ecra de jogo a tecla da bala nao funciona 
	JZ fim_cria
	MOV R3, [DEF_MISSIL]		     ; cor do pixel do missil 
	MOV R5, [EXISTE_MISSIL]
	ADD R5,1 										
	MOV [EXISTE_MISSIL], R5	         ; passa a existir um missil no ecra, a variavel é mudada para 1
	CALL som_disparo                 ; som de disparo 
	MOV R6, [LINHA_NAVE]
	SUB R6, 1				    	 ; subtrai um à linha do rover de forma a não desenhar o missil por cima do rover 
	MOV [POS_Y_MISSIL], R6 			 ; atualiza-se a linha do missil 
	MOV R6, [COLUNA_NAVE]
	ADD R6, 2                        ; encrementa-se 2 ao valor da coluna do rover  para desenhar o missil no meio do rover 
	MOV [POS_X_MISSIL], R6           ; atualiza-se a coluna do missil 
	MOV R1, [POS_Y_MISSIL]
	MOV R2, [POS_X_MISSIL]
	CALL escreve_pixel               ; escrevemos o primeiro pixel a ser desenhado do missil imediatamente por cima do meio do rover 
	JMP fim_cria
	
som_disparo:	
	PUSH R6
	MOV R6, SOM_3                    ; som disparo
	CALL som
	POP R6
	RET

fim_cria:
	POP R1 
	POP R2 
	POP R6 
	POP R3 
	POP R5
	RET
	
;*********************************************************************************
; ROTINA_MISSIL - Garante o movimento do missil 
;                   
;*********************************************************************************
rotina_missil:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R5
	PUSH R6
	PUSH R4 
	
    MOV  R1, missil_int
    MOV  R0, [R1]
    MOV  R2, 0
    CMP  R0, R2 		        ;verifica se está no cilco da interrupção, se não, entao nao move 
    JZ   fim_missil
	
	MOV R5,  [EXISTE_MISSIL]
	CMP R5, 0   			    ; verifica se existe algum missil no ecra, se não, entao sai da rotina 
	JZ fim_missil
	
	MOV R1, [POS_Y_MISSIL]
	MOV R2, [POS_X_MISSIL]
	MOV R4, [MAX_MOV_MISSIL]

ciclo_missil:
	CALL apaga_missil
	MOV R3 ,[DEF_MISSIL]
	SUB R1, 1                   ; sobe uma linha 
	MOV [POS_Y_MISSIL], R1		; atualizamos a linha do missil 
	CALL escreve_pixel
	SUB R4, 1					; menos um moviemento a dar 
	MOV [MAX_MOV_MISSIL], R4 
	CMP R4, 0
	JNZ fim_missil  			; se nao  chegou ao movimento max e nao colidiu entao continua a mover-se 
	MOV R3, 0
	CALL escreve_pixel          ; se deu o maximo de movimentos, entao o missil desaparece 
	ADD R4, 6
	SHL R4, 1                   ; multiplica R4 por 2 ficando 12 no registo 
	MOV [MAX_MOV_MISSIL], R4  
	MOV R5, 0
	MOV [POS_Y_MISSIL], R5      ; atualiza-se o valor das linhas para 0
	MOV R5, [EXISTE_MISSIL]
	SUB R5,1 
	MOV [EXISTE_MISSIL], R5     ; deixa de existir um missil no ecra, o EXISTE_MISSIL  passa a  0
	MOV R3,  TEC_COL
	MOV R5, MASCARA
	CALL ha_tecla               ; o rover só dipisra outro missil se a tecla 1 nao continuar primida depois de se movimentar até ao limite 
	JMP fim_missil
	
apaga_missil:
	MOV R3, 0 
	CALL escreve_pixel
	RET
	
fim_missil:
    MOV  R1, missil_int
    MOV  R0, 0
    MOV  [R1], R0
    POP R4 
    POP R6 
    POP R5 
	POP R3 
	POP R2
	POP R1
	POP R0
	RET
	
;*********************************************************************************
; LOADING - Coloca o cenário correto, de acordo com a fase do jogo 
;                  
; Argumentos: R1 --> Número do cenário que deve ser transmitido  
;*********************************************************************************
loading:
	PUSH R1
	PUSH R2
	MOV R2, ATRASO_LD
 	MOV R1, IMAGEM_LD0
	MOV  [SELECIONA_CENARIO_FUNDO], R1	; seleciona o cenário de fundo de loading 
	CALL atraso_loading                 ; delay entre imagens 
	CALL atraso_loading
 	MOV R1, IMAGEM_LD1
	MOV  [SELECIONA_CENARIO_FUNDO], R1	; seleciona o cenário de fundo de loading 
	CALL atraso_loading
	CALL atraso_loading
	MOV R1, IMAGEM_LD2
	MOV  [SELECIONA_CENARIO_FUNDO], R1	; seleciona o cenário de fundo de loading 
	CALL atraso_loading
	CALL atraso_loading
 	MOV R1, IMAGEM_LD3
	MOV  [SELECIONA_CENARIO_FUNDO], R1	; seleciona o cenário de fundo de loading  
	CALL atraso_loading
	CALL atraso_loading
	POP R2
	POP R1
	RET
	
;***********************************************************************************
; Converte_display - Passa o valor do display, que está em hexadecimal para decimal 
;					 
; Argumentos: R11 --> Valor que está nos displays  
;***********************************************************************************
converte_display:
	PUSH R0                             ; inicializações 
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R9
	PUSH R10
	MOV  R4, DISPLAYS
	MOV  R0, R11
	MOV  R9, VALOR_100d					
	MOV  R2, VALOR_10d
	MOV  R3, 0
	MOV  R5, 0
	MOV  R6, 0
	MOV  R10, VIDA_100
	CMP  R0, R10 						; vê se a vida do Rover está a 100,
	JZ   convertor_100                  ; pois o convertor para 100 é diferente

convertor:
	DIV  R0, R2                         ; serve para obter o digito das dezenas caso o número tenha dois digítos
	MOV  R5, R0                         ; exemplo: 95 // 10 = 9
	MOV  R0, R11                        ; repõe o valor que estamos a converter
	MOD  R0, R2                         ; serve para agora obter o digito das unidades
	MOV  R6, R0							; exemplo: 95 % 10 = 5

	SHL  R5, 4                          ; cria espaço para se somar o digíto a seguir sem afetar o número (0009 -> 0090)
	ADD  R5, R6                         ; soma-se o segundo digíto e obtém-se a conversão

 	MOV [R4], R5                        ; atualiza o valor do display após a conversão
	JMP saida_converte

convertor_100:                          ; caso seja 100
	DIV R0, R9							; apenas obtém o digito das centenas
	MOV R3, R0                          ; 100 // 100 = 1
	SHL R3, 8                           ; cria espaço para o digito das dezenas e das unidades (0001 -> 0100)
	MOV [R4], R3                        ; atualiza o valor do display após a conversão
	
saida_converte:
	POP R10
	POP R9
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R0
	RET
	
;*********************************************************************************
; PAUSA -  Quando clicada a tecla D o jogo pausa e quando clicada novamente
;          volta onde estava
;
; Argumentos: R1 --> Número do cenário que deve ser transmitido  
;*********************************************************************************
pausa:
	PUSH R0
	PUSH R1
	
	MOV R1, [NO_JOGO]
	CMP R1 , 0
	JZ sai_pausa
	
	DI 
	CALL apaga_boneco
	MOV [APAGA_ECRÃ], R1 
	MOV R1, IMAGEM_PAUSA
	MOV  [SELECIONA_CENARIO_FUNDO], R1	  ; seleciona o cenário de fundo de pausa 
	CALL ha_tecla
	
	MOV R1,  0
	MOV [NO_JOGO],  R1  			; deixames de estar no ecra do jogo 
	
	
espera_tecla_pausa:
	CALL teclado
	MOV R0, TECLA_PAUSA
	CMP R0, R7
	JZ retoma 
	MOV R0, TECLA_COMECO
	CMP R0, R7 
	JZ reinicia
	MOV R0, TECLA_FINAL
	CMP R0, R7
	JZ termina_jogo
	JMP espera_tecla_pausa
	
reinicia :
	CALL reseta_dados
	EI2
	EI1
	EI0
	EI 
	JMP sai_pausa
	
termina_jogo:
	JMP sai_pausa
	
retoma: 
	MOV R1, IMAGEM_JOGO
	MOV [SELECIONA_CENARIO_FUNDO], R1
	MOV R1, [LINHA_NAVE]
	CALL desenha_rover
	MOV R1, [NO_JOGO]
	MOV R1, 1
	MOV [NO_JOGO], R1 
	CALL ha_tecla
	EI2
	EI1
	EI0
	EI 
	
sai_pausa:
	POP R1
	POP R0 
	RET 

;***********************************************************************************************
; DECREMENTA - Decrementa 5% à vida do Rover, de 3 em 3 segundos
;
; Argumentos: R11 --> Valor que está nos displays
;***********************************************************************************************
decrementa:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	
	MOV R1, [NO_JOGO]
	CMP R1, 0
	JZ fim_decrementa
	
	CMP R7, 01H
	JZ  decrementa_sozinho
    MOV  R1, [vida_int]
	CMP R1, 0
	JZ fim_decrementa
	
	decrementa_sozinho:
	MOV R4, DISPLAYS
	MOV R1, VIDA_0
	CMP R11, R1                         ; verifica se o valor do display está a zero
	JNZ nao_eh_0                           
	MOV [R4], R1                        ; se tiver a zero, o display não é decrementado
	JMP fim_decrementa
	
	nao_eh_0:                        	; se não for zero
	JNZ decrementa_auto
	SUB R11, 5
	CALL converte_display
	JMP fim_decrementa
	
	decrementa_auto:
	SUB R11, 5	                        ; decrementa 5 ao valor do display
	CALL converte_display				; converte o valor de hexadecimal para decimal
	JMP fim_decrementa
	
fim_decrementa:
	MOV R1, 0
	MOV [vida_int], R1
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET

;***********************************************************************************************
; INCREMENTA - Incrementa a vida do meteoro
;
; Argumentos: R11 --> Valor que está nos displays
;***********************************************************************************************
incrementa:
	PUSH R0
	
	incrementa_display:
	MOV R0, VIDA_100
	CMP R11, R0                         ; verifica se o valor do display está a cem
	JNZ nao_100  
	CALL converte_display
	JMP saida_incrementa
	
	nao_100: 
	ADD R11, 5                          ; incrementa 5 ao display
	CALL converte_display
	CALL atraso_display
	CALL atraso_display
	JMP saida_incrementa
	
saida_incrementa:
	POP R0
	RET
	
;*********************************************************************************
; DESENHA_COLISAO - Desenha uma explosão, quando à colisao
;                 
; Argumentos: R1 --> linha
;             R2 --> coluna
;*********************************************************************************
desenha_colisao:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R0
	PUSH R5
	PUSH R6
	PUSH R4
	MOV R6, 5
	MOV R4, DEF_COLISAO
	MOV R5, LARGURA			            ; obtém a largura do boneco

desenha_pixels3:       		            ; desenha os pixels do boneco a partir da tabela
	MOV	R3, [R4]                        ; obtém a cor do pixel do boneco
	CALL escreve_pixel		            ; escreve cada pixel do boneco
	ADD	R4, 2                           ; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
    ADD R2, 1                           ; próxima coluna
    SUB R5, 1			                ; menos uma coluna para tratar
    JNZ desenha_pixels3                 ; continua até percorrer toda a largura do objeto
	CALL prox_l3
	SUB R6, 1
	JNZ desenha_pixels3
	MOV R7, R2                          ; guarda a coluna do ultimo pixel desenhado 
	ADD R1, 1                           ; compensa o -1 no prox_l 
	POP R4
	POP R6
	POP	R5
	POP	R0
	POP	R3
	POP	R2
	POP R1
	RET

prox_l3:
	MOV R5, LARGURA                     ; largura meteoro 
	SUB R1, 1                           ; proxima linha a desenhar 
	SUB R2, 5                           ; volta para a coluna mias à esquerda 
	RET
	
;*********************************************************************************
; APAGA_COLISAO - Apaga a explosão, apos a colisão 
;                 
; Argumentos: R1 --> linha
;             R2 --> coluna
;*********************************************************************************
apaga_colisao:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	MOV R5, LARGURA
	MOV R6, 5                           ; quantidade de linhas do meteoro 

apaga_pixel3:		
	MOV R3, 0                           ; cor definida para 0 
	CALL escreve_pixel
	ADD R2, 1                           ; incrementa coluna para desenhar novo pixel 
	SUB R5, 1                           ; menos uma coluna a tratar
	JNZ apaga_pixel3
	MOV R5, LARGURA
	SUB R1, 1                           ; proxima linha do meteoro a desenhar 
	SUB R2, 5                           ; volta para a coluna mais à esquerda
	SUB R6 ,1                           ; menos uma linha a tratar
	JNZ apaga_pixel3
	ADD R1, 5 
	POP R8
	POP R7
	POP R6
	POP R5
	POP R3
	POP R2
	POP R1
	RET
	
colisao:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R9
	PUSH R7
	PUSH R8
	PUSH R10
	PUSH R11
	
	MOV R9, [NO_JOGO]                  
	CMP R9, 0                            ; verifica se o jogo já começou
	JZ saida_colisao                     ; se ainda não começou, sai da rotina
	
	MOV R9, [EXISTE_MISSIL]              
	CMP R9, 0                            ; se estiver no jogo, verifica se já existe algum missil disparado
	JZ saida_colisao                     ; se não houver missil, sai da rotina
	
	MOV R9, [NUMERO_MET]                 
	CMP R9, 0                            ; se houver missil, verifica se já existem meteoros a cair
	JZ saida_colisao                     ; se ainda não houverem, sai da rotina
	
	MOV R4, [POS_Y_MISSIL]
	MOV R5, [POS_X_MISSIL]	
	MOV R3, pos_coluna_1

	MOV R0, 8                            ; necessario para fazer a soma, que permite mudar para outro meteoro 
	MOV R9, 0                            ; contador de meteoros
	MOV R7, 4                            ; contador de meteoros
	
primeira_verificacao:
	MOV R6, [R3+2]                       ; linha do meteoro 1
	CMP R6, R4                           ; verifica se a linha do meteoro e do missil correspondem
	JZ segunda_verificacao               ; se estiverem na mesma linha, passa para a próxima verificação
	
	ADD R3, R0                           ; se não, muda R3 para a linha de outro meteoro
	ADD R9, 1
	CMP R9, QUATRO                       ; confirmamos se já foram verificados todos os meteoros
	JZ saida_colisao                     ; se sim, ele sai, pois nenhum estava na linha do missil
	
	JMP primeira_verificacao             ; verifica o próximo meteoro
	
segunda_verificacao:
	MOV R6, [R3]                         ; coluna do meteoro 1
	CMP R5, R6                           ; verficamos se o missil está dentro da largura do meteoro (5)
	JGE terceira_verificacao             ; primeiro vemos se a coluna do missil é maior que a largura 0
	
	ADD R3, R0                           ; caso não esteja, mudamos de meteoro e verificamos a sua coluna
	ADD R9, 1                            
	CMP R9, QUATRO                       ; verificamos se já foram os quatro meteoros
	JZ saida_colisao
	
	JMP segunda_verificacao              ; verifica o próximo meteoro
	
terceira_verificacao:
	MOV R6, [R3]
	ADD R6, 4                            ; somamos cinco à coluna do meteoro para verificar se o missil 
	CMP R5, R6                           ; está na largura do meteoro
	JLE quarta_verificacao               ; verificar se é menor que a largura 5 e assim está dentro do intervalo
	SUB R6, 4                            ; repomos o valor da coluna para o correto	
	
	ADD R3, R0                           ; caso não esteja, mudamos de meteoro
	ADD R9 ,1      
	CMP R9, QUATRO                       ; verificamos se já foram os quatro meteoros
	JZ saida_colisao
	
	JMP terceira_verificacao             ; verifica o próximo meteoro
	
quarta_verificacao:
	CMP R5, R6                           ; verificamos qual coluna dentro intervalo corresponde
	JZ rotina_colisao                    ; se nenhuma corresponder, ele sai
	
	CMP R7, 0                            ; verifica se o contador chegou ao fim
	JZ saida_colisao
	
	SUB R6, 1                            ; mudar de coluna
	SUB R7, 1                            ; decrementamos o contador
	JMP quarta_verificacao
	
rotina_colisao:
	;SUB R6, 5                           ; caso a terceira verificacao se realize, repomos a coluna do meteoro
	MOV R2, [R3]
	MOV R1, [R3+2]                       ; argumentos da funcao apaga meteoro
	
	CALL apaga_meteoro
    MOV R6, SOM_4
	CALL som
	
	CALL desenha_colisao
	CALL atraso_display
	CALL apaga_colisao
	
	MOV R6, [R3-4]
	CMP R6, 1
	JZ incrementa_bom
	CALL incrementa
	JMP reset_colisao

incrementa_bom:
	CALL incrementa
	CALL incrementa
	
reset_colisao:
	MOV R9, 0
	MOV [R3], R9                         ; repomos a zero a linha e coluna do meteoro, 
	MOV [R3+2], R9                       ; para voltar a ser desenhado no próximo ciclo
	
	MOV [EXISTE_MISSIL], R9              ; deixa de existir missil
	
	MOV R9, 12
	MOV [MAX_MOV_MISSIL], R9             ; repomos os movimentos do missil
	
	MOV R1, [NUMERO_MET]
	SUB R1, 1                            ; diminuimos os meteoros em jogo, para serem criados novos
	MOV [NUMERO_MET], R1
	
	MOV R3, 0
	MOV R1, [POS_Y_MISSIL]               ; garantimos que o missil é apagado
	MOV R2, [POS_X_MISSIL]
	CALL escreve_pixel
	
	MOV R1, [KILL_MET]
	ADD R1, 1 
	MOV   [KILL_MET], R1 
	
saida_colisao:
	POP R11
	POP R10
	POP R8
	POP R7
	POP R9
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET
	
