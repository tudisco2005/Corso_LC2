;ESERCIZIO 1 variante 3
;Scrivere un sottoprogramma che riceve in R1 e R2 gli indirizzi di due celle di memoria contenenti gli indirizzi di
;altre due celle di memoria contenenti a loro volta due numeri num1 e num2 in complemento a due, li confronta,
;restituisce in R0 la seguente indicazione:
;R0 = -1 se num1 < num2
;R0 = 0 se num1 = num2
;R0 = +1 se num1 > num2
;Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il
;sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino alterati.


;*******************START del programma*******************
	.orig	x4001

;qui le istruzioni che collaudano il sottoprogramma

	lea	r1,num1		;carico l'indirizzo di num1 nel registro r1
	lea	r2,num2		;carico l'indirizzo di num2 nel registro r2
	
	jsr	subpr 		;chiamata a sottoprogramma

stoqui 	brnzp	stoqui

;qui variabili e costanti del main

num1 	.fill 	val1		;num1 contiene un indirizzo, quello di val1 
num2	.fill	val2

val1	.fill	#5		;val1 contiene un indirizzo, quello di dove è allocata la variabile 5 
val2	.fill	#10


;qui la fine del main

;****************************************************
;qui le istruzioni per il sottoprogramma

subpr	ldr	r1,r1,#0	;r1 = m(r1) cioè l'indirizzo di val1
	ldr	r1,r1,#0	;r1 = m(r1) cioè il valore di num1
	ldr	r2,r2,#0	
	ldr	r2,r2,#0

	not 	r0,r2
	add 	r0,r0,#1	;num2 = -num2
	add 	r0,r1,r0	;num2 += 1
	
	brp 	major		; num1 > num2
	brn 	minor		; num1 < num2
	brz 	egual		; num1 == num2


major	and 	r0,r0,#0	;qui le istruzioni per il sottoprogramma se R1 > R2
	add 	r0,r0,#-1
	ret

egual	and 	r0,r0,#0	;qui le istruzioni per il sottoprogramma se R1 = R2
	ret

minor	and 	r0,r0,#0	;qui le istruzioni per il sottoprogramma se R1 < R2
	add 	r0,r0,#1
	ret

;qui variabili e costanti del sottoprogramma
; ...
;fine del sottoprogramma
;****************************************************

	.end