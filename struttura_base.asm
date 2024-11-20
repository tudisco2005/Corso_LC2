	.orig x4000
;qui le istruzioni che collaudano il sottoprogramma
	ld	...

	jsr	subpr
stoqui	brnzp	stoqui

;qui variabili e costanti del main
label1	.blkw
label2	.fill
;qui la fine del main

;****************************************************
;qui le istruzioni per il sottoprogramma

subpr	st	r3,savr3	;salvo R3 in memoria - salvo tutti i registri che mi servono prima di usarli e poi li ripristino


	ld	r3,savr3	;ripristina il valore di R3 prima del sottoprogramma
	ret

;qui variabili e costanti del sottoprogramma
lab1	.blkw
lab2	.fill

savr3	.blkw	1

;fine del sottoprogramma
;****************************************************

	.end