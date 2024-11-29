
;ESERCIZIO 2
;Scrivere un sottoprogramma che riceve in R0 e R1 due numeri num1 e num2 in complemento a due, li somma,
;restituisce in R1 il risultato e in R0 la seguente indicazione:

;R0 = -1 se si è verificato underflow
;R0 = 0 se la somma ha avuto esito corretto
;R0 = +1 se si è verificato overflow

;Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il
;sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino
;alterati

	.orig   x4001
    	
	; Test del sottoprogramma
	ld      r0,num1     	; Carico il primo numero in R0 
    	ld      r1,num2     	; Carico il secondo numero in R1
    	jsr     subpr       	; Chiamata al sottoprogramma

	ld      r0,num3     	
    	ld      r1,num4     	
    	jsr     subpr
	
	ld      r0,num5    	
    	ld      r1,num6     	
    	jsr     subpr

stoqui	brnzp	stoqui

num1    .fill   32765 		; somma senza overflow o underflow
num2    .fill   -10

num3   .fill   -32765 		; mi aspetto un underflow
num4    .fill   -10

num5    .fill   32765 		; mi aspetto un overflow
num6    .fill   10

;****************************************************
; Sottoprogramma per somma con gestione overflow/underflow
subpr   
	st      r2,save_r2  	; Salvo R2 che verrà usato
    
    	; Eseguo la somma
    	add     r2,r0,r1    	; Sommo num1 + num2 in R2
    
    	; Controllo segno degli operandi e del risultato
    	and     r0,r0,r0    	; Test segno num1
    	brzp    pos_check   	; Se num1 positivo o zero, vai a pos_check
    
    	; Caso num1 negativo
    	and     r1,r1,r1    	; Test segno num2
    	brn     neg_check   	; Se anche num2 negativo, vai a neg_check
    	brnzp   no_ovf      	; Se num2 positivo, non c'è overflow
    
pos_check
    	and     r1,r1,r1	; Test segno num2
    	brn     no_ovf     	; Se num2 negativo, non c'è overflow
    	and     r2,r2,r2   	; Test segno risultato
    	brn     overflow	; Se risultato negativo e operandi positivi -> underflow
    	brnzp   no_ovf

neg_check
    	and     r2,r2,r2    	; Test segno risultato
    	brzp    underflow	; Se risultato positivo e operandi negativi -> overflow
    	brnzp   no_ovf

underflow
    	and     r0,r0,#0    	; Azzero R0
    	add     r0,r0,#-1   	; Segnalo underflow (R0 = -1)
    	add     r1,r2,#0    	; Metto il risultato in R1
    	ld      r2,save_r2  	; Ripristino R2
    	ret

overflow
    	and     r0,r0,#0    	; Azzero R0
    	add     r0,r0,#1    	; Segnalo overflow (R0 = +1)
    	add     r1,r2,#0    	; Metto il risultato in R1
	ld      r2,save_r2  	; Ripristino R2
	ret

no_ovf
    	and     r0,r0,#0    	; Azzero R0 (nessun overflow/underflow)
    	add     r1,r2,#0    	; Metto il risultato in R1
	ld	r2,save_r2	; Ripristino R2
	ret

; Variabili del sottoprogramma
save_r2	.blkw	1       ; Spazio per salvare R2
	.end
