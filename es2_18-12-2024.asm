; Il candidato scriva un sottoprogramma denominato CONTA_DOPPIE che riceve:
; 1. nel registro R0 l’indirizzo della prima cella di una zona di memoria contenente in ciascuna cella il codice
; ASCII di un carattere di un testo in lingua italiana privo di lettere maiuscole;
; 2. nel registro R1 l’indirizzo della cella contenente l’ultimo carattere del testo italiano di cui al punto 1.
; Il sottoprogramma deve restituire nel registro R0 il numero di "doppie", cioè di coppie di lettere consecutive
; uguali. Si faccia l'ipotesi che il testo sia "ben formato", cioè non contenga sequenze di lettere uguali di lunghezza
; maggiore di 2.
; Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il
; sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino alterati.

	.orig	x4000
		
	lea	r0,s_str
	lea	r1,f_str
	add	r1,r1,#-2	; per ottenere l'indirizzo del ultimo carattere nella stringa

	jsr	CONTA_DOPPIE

stoqui	brnzp	stoqui

s_str	.stringz	"nel mezzo del cammin di nostra vita mi ritrovai per una selva oscura che' la diritta via era smarrita."
f_str	.fill	#1

;*************************************************
CONTA_DOPPIE
	st	r2,savr2	; r2 = -r1
	st	r3,savr3	
	st	r4,savr4
	st	r5,savr5	; contatore di doppie

	and	r5,r5,#0	; contatore a 0

	not	r2,r1
	add	r2,r2,#1

ciclo	add	r3,r0,r2	; r0 - r1 quando il ris e' positivo -> finita la stringa
	brp	fine

	ldr	r3,r0,#0	; carattere presente all'indirizzo r0
	ldr	r4,r0,#1	; carattere presente all'indirizzo r0 + 1

	not	r4,r4
	add	r4,r4,#1	; -r4

	add	r3,r3,r4	; se il risultato e' 0 sono 2 caratteri uguali
	brz	incr_c
inc	add	r0,r0,#1	; r0 = r0 + 1
	brnzp	ciclo

incr_c	add	r5,r5,#1
	brnzp	inc

fine	and	r0,r5,r5
	ld	r2,savr2
	ld	r3,savr3
	ld	r4,savr4
	ld	r5,savr5
	ret

; variabili
savr2	.blkw	1
savr3	.blkw	1
savr4	.blkw	1
savr5	.blkw	1
;*************************************************
	.end