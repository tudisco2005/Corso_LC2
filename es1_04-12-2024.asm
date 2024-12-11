;Il candidato scriva un sottoprogramma denominato CONV_MAIUS che riceve nel registro R0 l’indirizzo della
;prima cella di una zona di memoria contenente una stringa di caratteri codificati ASCII (un carattere per cella).
;La stringa è terminata dal valore 0 (corrispondente al carattere NUL).
;Il sottoprogramma deve:
;1. convertire tutte le lettere minuscole contenute nella stringa nelle corrispondenti lettere maiuscole;
;2. restituire nel registro R0 il conteggio delle lettere convertite.

	.orig	x4001
	lea	r0,stringa
	jsr	CONV_MAIUS
	
stoqui	brnzp 	stoqui

stringa	.stringz "Buon Lunedi 7 febbraio 2011"

;**********************************************
CONV_MAIUS
	st	r1,save_r1
	st	r2,save_r2
	st	r3,save_r3
	st	r4,save_r4
	st	r5,save_r5
	
	ld	r3,num1
	ld	r4,num2
	
	and 	r5,r5,#0 	; conteggio lettere convertite partndo da 0

ciclo	ldr	r1,r0,#0
	brz	fine
		
				; capire se e' nell intervallo 97 - 122 delle lettere minuscole
	add	r2,r1,r3	; -97 totale di sotrazione


	brn	incr		; se negativa dopo la sottrazione di -97 fuori a sinistra dall intervallo prima della 'a'

	add	r2,r2,#-16
	add	r2,r2,#-9	; -122 totale sotratto a r1 che era il valore decimale della lettera		
				
	brp	incr		; se positiva dopo la sottrazione di -122 fuori a destra dall intervallo dopo la 'z'

; ora siamo nell intervallo a...z
	add	r1,r1,r4	; convertila in maiscolo (-32)
	add	r5,r5,#1	; +1 lettera convertita
	str	r1,r0,#0	; salva la lettera modificata

incr	add	r0,r0,#1	; lettera successiva
	brnzp	ciclo

fine	and	r0,r0,#0
	add	r0,r0,r5	; oppure and r0,r5,r5
	ld	r1,save_r1
	ld	r2,save_r2
	ld	r3,save_r3
	ld	r4,save_r4
	ld	r5,save_r5
	ret

; variabili e costanti

save_r1 .blkw	1
save_r2 .blkw	1
save_r3 .blkw	1
save_r4 .blkw	1
save_r5 .blkw	1

num1	.fill  	#-97
num2	.fill	#-32
;*********************************************
	.end