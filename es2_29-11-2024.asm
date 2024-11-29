	.orig   x4001

	lea    	r0,array
    	lea     r1,arr_end	
    	jsr     subpr       	

	jsr     p_arr	; Chiama la funzione per stampare l'array "in un registro r5 solo per comodita, lo posso vedere anche dal simulatore"

stoqui	brnzp	stoqui

array	.fill	1
	.fill	2
	.fill	3
	.fill	4
	.fill	5
arr_end	.fill	6


;****************************************************
; Sottoprogramma 

subpr   st	r0,save_r0	; modifichero l'indirizzo di partenza dell array incrementandolo
	st	r1,save_r1	; modifichero l'indirizzo di fine dell array incrementandolo
	st      r2,save_r2  	; differenza tra gli indirizzi r0 - r1
	st      r3,save_r3	; var temporanea per 1 valore
	st	r4,save_r4	; var temporanea per 1 valore usate per scambiare i 2 valori
	

ciclo	not	r2,r1		
	add	r2,r2,#1
	add	r2,r0,r2
	brp	fine		; se la differenza tra gli indirizzi -1 avro scambiato tutti i valori nell array

	ldr	r3,r0,#0	; Salvo in r3 il valore partendo dall inizio dell array
	ldr	r4,r1,#0	; Salvo in r4 il valore partendo dalla fine dell array
	
swap	str	r4,r0,#0
	str	r3,r1,#0

	add	r0,r0,#1	; incremento l'indirizzo r0 di 1
	add	r1,r1,#-1	; decremento l'indirizzo r1 di 1
	brnzp	ciclo

fine	ld	r0,save_r0
	ld	r1,save_r1
	ld	r2,save_r2
	ld	r3,save_r3
	ld	r4,save_r4
	ret

; Variabili del sottoprogramma
save_r0	.blkw	1       	; Spazio per salvare R0
save_r1	.blkw	1       	; Spazio per salvare R1
save_r2	.blkw	1       	; Spazio per salvare R2
save_r3	.blkw	1       	; Spazio per salvare R3
save_r4	.blkw	1       	; Spazio per salvare R4

; sottoprogramma per mostrare i valori dell array scorrendoli nel registro r5
p_arr	st	r0,save_r0	
	st	r1,save_r1
	st      r2,save_r2
	st	r5,save_r5

ciclo_p	not	r2,r0		
	add	r2,r2,#1
	add	r2,r1,r2
	brn	fine_p	

	ldr	r5,r0,#0	
	
	add	r0,r0,#1	; incremento l'indirizzo r0 di 1
	brnzp	ciclo_p

fine_p	ld	r0,save_r0
	ld	r1,save_r1
	ld	r1,save_r2
	ret

save_r5	.blkw	1

; *****************************************
	.end     
	