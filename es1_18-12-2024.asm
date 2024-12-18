; Il candidato scriva un sottoprogramma denominato FIBONACCI che riceve nel registri R0 il numero intero N e
; che restituisce sempre in R0 il termine N-esimo FN della sequenza di Fibonacci.
; Si ricorda che il termine N-esimo della sequenza di Fibonacci è dato da:
; FN = FN-1 + FN-2
; con F1 = 1 e F2 = 1. Si faccia inoltre l’ipotesi che sia FN = 0 per N = 0
; Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il
; sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino alterati.

	.orig	x4000

	ld	r0,num
	jsr	FIBONACCI	

stoqui	brnzp	stoqui

num	.fill	10
;*******************************************
FIBONACCI
	st	r1,save_r1
	st	r2,save_r2
	st	r3,save_r3	; tengo il risultato della somma ogni volta

	and	r0,r0,r0
	brp	start

	and	r3,r3,#0	; caso input negativo
	brnzp	fine
				; carico 1 perche e' il valore di F(1) = 1 e F(2) = 1
start	ld	r1,start_n	; carico 1 in r1
	ld	r2,start_n	; carico 1 in r2
	ld	r3,start_n	

	add	r0,r0,#-2	; tolgo -2 perche il primi 2 valori di fibonacci sono noti

ciclo	brnz	fine

	add	r3,r1,r2	
	and	r1,r2,r2
	and	r2,r3,r3

	add	r0,r0,#-1
	brnzp	ciclo

fine	and	r0,r3,r3	; metto il risultato in r0
	ld	r1,save_r1	; ripristino i valori 
	ld	r2,save_r2
	ld	r3,save_r3
	ret


; varibili
start_n	.fill 	1

save_r1 .blkw 	1
save_r2 .blkw 	1
save_r3 .blkw 	1
;*******************************************
	.end