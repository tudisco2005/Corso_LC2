; Scrivere un sottoprogramma che:
;
; - riceve in R0 l'indirizzo del primo elemento di un array di numeri in modulo e segno diversi da zero (lo zero costituisce il tappo finale dell'array)
;
; - restituisce in RO il risultato (in modulo e segno) della sommatoria di tutti i numeri dell'array, trascurando eventuali traboccamenti
;
; Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il sottoprogramma stesso deve restituire 
; il controllo al programma chiamante senza che tali registri risultino alterati.


; ALGORITMO
; 1 tenere in registro della somma in ca2
; 2 leggere un numero dall array
; 3 converirlo in ca2
; 4 sommaro al registro della somma
; 5 sono alla fine convertirlo in modulo e segno

; COVERSIONE DA CA2 a A MODULO E SEGNO
; 1)	
; Se MSB = 0, il numero -> positivo.
; Se il bit del segno = 1, il numero -> negativo.
;
; 2)
; Calcola il valore assoluto:
; - Se il bit del segno = 0, i restanti bit rappresentano direttamente il modulo.
; - Se il bit del segno = 1, devi calcolare il modulo
;	- Inverti tutti i bit (complemento a 1).
;	- Aggiungi 1 al risultato.
;
; 3)
; Combina segno e modulo
; fare OR con il bit del segno e il modulo

	.orig	x4001
	
	lea	r0,arr
	jsr	SOMMA
	
stoqui	brnzp	stoqui

arr	.fill	b1000000000000001	; -1
	.fill	b1000000000000010	; -2
	.fill	b1000000000000100	; -4
	.fill	b0000000000000101	; 5
	.fill	b0000000000000010	; 2
	.fill	b0000000000000000	; 0 (fine array)

; *************************************
SOMMA 	st	r1,save_r1
	st	r2,save_r2		; contine la maschera per la conversione mask (mod e segno -> ca2)
	st 	r3,save_r3

ciclo	ld	r2,mask
	ldr	r1,r0,#0

	; converto il numero da modulo e segno in ca2
	
	brp	sum			; se positivo la rappresentazione e' uguale
	
	and	r1,r1,r2		; se negativo lo converto
	not	r1,r1
	add	r1,r1,#1	

	brz	fine		

sum	add	r3,r3,r1		; sommo r1 con r3 -> r3

	add	r0,r0,#1		; incremento dell inirizzo dell array
	brnzp	ciclo

conv_n	not	r3,r3			
	add	r3,r3,#1
	
	not	r3,r3
	and	r3,r3,r2
	not	r3,r3			; OR per mettere il bit del segno a 1
				
	brnzp	res
					; coverto il risultato della sommatoria in (ca2 -> mod e segno)
fine	and	r3,r3,r3		; check del segno del risultato
	
	brn	conv_n			; se negativo converto
	
res	and	r0,r3,r3		; se e' positivo va bene gia cosi

	ld	r1,save_r1		; ripristino i registri
	ld	r2,save_r2	
	ld 	r3,save_r3
	ret

; variabili

mask	.fill	b0111111111111111

save_r1	.blkw	1
save_r2	.blkw	1
save_r3	.blkw	1
; *************************************
	.end
