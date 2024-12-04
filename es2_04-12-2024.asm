; Il candidato scriva un sottoprogramma denominato CONTA_PARI_DISPARI che riceve:
; - 1. nel registro R0 l’indirizzo della prima cella di una zona di memoria contenente una sequenza di numeri a 16 bit in complemento a due;
; - 2. nel registro R1 l’indirizzo della cella contenente l’ultimo numero della sequenza di cui al punto 1.
; Il sottoprogramma deve restituire:
; - 1. nel registro R0 il conteggio di quanti numeri pari sono presenti nella sequenza;
; - 2. nel registro R1 il conteggio di quanti numeri dispari sono presenti nella sequenza

	.orig	x4001
	lea	r0,arr
	lea	r1,f_arr
	jsr	CONTA_PARI_DISPARI 
	
stoqui	brnzp 	stoqui

arr 	.fill	22
	.fill	150
	.fill	0
	.fill	451
	.fill	15
f_arr	.fill	121


;***************************************
CONTA_PARI_DISPARI
	st	r2,save_r2	; contatore pari
	st	r3,save_r3	; contatore dispari
	st	r4,save_r4	; r4 usato per la differenza tra gli indirizzi (vedere se siamo alla fine dell'array)
	st	r5,save_r5	; r5 usato per tenere il numero predente nell array all indirizzo di r0
	st	r6,save_r6	; r6 per la measchera

	and	r2,r2,#0	; azzeriamo i contatori
	and	r3,r3,#0
	ld	r6,mask

ciclo	not 	r4,r0		; si puo usare anche la logica inversa r0 - r1 fermati quando il risulatato e' >0
	add	r4,r4,#1
	add	r4,r1,r4	; r1 - r0 se negativo (<0) abbiamo superato la fine dell array 
	brn	fine	

	ldr	r5,r0,#0	
	and	r5,r5,r6	; controlle se il numero e' pari guardando solo l'ultimo bit usando una maschera
	brz	pari		; se r5 = 0 pari +1
	add	r3,r3,#1	; se no dispari +1
	brzp	incr
	
pari	add	r2,r2,#1
	
incr	add	r0,r0,#1
	brnzp	ciclo
	
fine	and	r0,r2,r2	; metto in r0 il conto dei numeri pari
	and	r1,r3,r3	; metto in r1 il conto dei numeri dispari
	ld	r2,save_r2	
	ld	r3,save_r3	
	ld	r4,save_r4	
	ld	r5,save_r5
	ld	r6,save_r6
	ret	

save_r2	.blkw	1
save_r3	.blkw	1
save_r4	.blkw	1
save_r5	.blkw	1
save_r6	.blkw	1

mask	.fill	b00000001	; mi bastava scrivere #1
;***************************************
	.end