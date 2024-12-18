; Il candidato scriva un sottoprogramma denominato GAP_ASS che riceve nel registro RO 
; l'indirizzo della prima cella di un array di interi, 
; cioe di una zona di memoria contenente una sequenza di numeri a 16 bit in complemento
; a due, non ordinati; la sequenza è terminata dal 
; valore 0 (zero) che non fa parte dei valori da considerare.
; Il sottoprogramma deve restituire nel registro RO la differenza fra il 
; valore assoluto massimo e il valore assoluto minimo dei numeri della sequenza.
; Qualora per la realizzazione del sottoprogramma fosse
; necessario utilizzare altri registri della CPU, il sottoprogramma stesso deve restituire 
; il controllo al programma chiamante senza che tali registri risultino alterati.

	.orig	x4000

	lea	r0,arr	
	jsr	GAP_ASS

stoqui	brnzp	stoqui

arr	.fill	112
	.fill	-27
	.fill	-12
	.fill	45
	.fill	15
	.fill	0


;********************************************
GAP_ASS
	st	r1,savr1	; r1 tiene il valore presente all indirizzo r0[0]
	st	r2,savr2	; r2 per il minimo
	st	r3,savr3	; r3 per il massimo
	st	r4,savr4	; registo di appoggio temporaneo per i calcoli

	ldr	r2,r0,#0	; minimo messo a r0[0]
	brz	f_arr
	ldr	r3,r0,#1	; massimo messo a r[1]
	brnp	ciclo		; se carico un valore diverso da 0 so che il mio array ha piu di un elemento valido
f_arr	and	r3,r2,r2	; se no il minimo e il massimo coincidono

ciclo	ldr	r1,r0,#0

	; faccio il valore assoluto

	brz	fine		; sono arrivato alla fine dell array
	brp	chk_min		; se gia positivo non faccio nulla
	not	r1,r1
	add	r1,r1,#1	; se negativo faccio -(-r1) -> ottengo r1 positivo
	
	
	; se r1 < r2 nuovo minimo trovato
chk_min	not	r4,r1
	add	r4,r4,#1
	add	r4,r2,r4
	brnz	chk_max
	and	r2,r1,r1

	; se r1 > r3 nuovo massimo trovato
chk_max	not	r4,r1
	add	r4,r4,#1
	
	add	r4,r3,r4	
	brzp	incr
	and	r3,r1,r1	

incr	add	r0,r0,#1
	brnzp ciclo

fine	
	; valore assoluto del minimo
	and	r2,r2,r2
	brzp	calc
	not	r2,r2
	add	r2,r2,#1	
	
	; valore assoluto del massimo
	and	r3,r3,r3
	brzp	calc
	not	r3,r3
	add	r3,r3,#1
	
calc	not	r2,r2
	add	r2,r2,#1	; -r2
	add	r0,r3,r2	; massimo - minimo ->  r0 = r3 - r2

	ld	r1,savr1	
	ld	r2,savr2	
	ld	r3,savr3
	ld	r4,savr4
	ret

; variabili
savr1	.blkw	1
savr2	.blkw	1
savr3	.blkw	1
savr4	.blkw	1
;********************************************
	.end