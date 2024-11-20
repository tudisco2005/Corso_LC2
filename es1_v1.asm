;ESERCIZIO 1 Variante 1
;Scrivere un sottoprogramma che riceve in R1 e R2 due numeri num1 e num2 in complemento a due, li confronta,
;restituisce in R0 la seguente indicazione:
;R0 = -1 se num1 < num2
;R0 = 0 se num1 = num2
;R0 = +1 se num1 > num2
;Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il
;sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino alterati

;qui le istruzioni che collaudano il sottoprogramma

	.orig	x4001

; POSSO azzerare un registro e poi sommare il valore che mi serve -> (VARIANTE 1)

;	and	r1,r1,#0 	;setto il valore num1 in r1
;	add	r1,r1,#5

;	and 	r2,r2,#0 	;setto il valore num2 in r2
;	add 	r2,r2,#10

; OPPURE per caricare le variabili dalla memoria(non serve azzerare i registri) -> (VARIANTE 2)

	ld	r1,num1		;carico il valore di num1 nel registro r1
	ld	r2,num2		;carico il valore di num2 nel registro r2
	

	jsr	subpr ;chiamata a sottoprogramma

; Faccio un po di casi di test
	ld	r1,num3
	ld	r2,num4
	jsr	subpr

	ld	r1,num5
	ld	r2,num6
	jsr	subpr	

stoqui 	brnzp	stoqui

;qui variabili e costanti del main

num1 	.fill 	5
num2	.fill	10
num3	.fill	0
num4	.fill	0
num5	.fill	12
num6	.fill	2

;qui la fine del main

;****************************************************
;qui le istruzioni per il sottoprogramma

subpr	not 	r0,r2
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