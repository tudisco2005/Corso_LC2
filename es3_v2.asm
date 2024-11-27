; Variante 2
; Scrivere un sottoprogramma che:
;
; - riceve in R0 l’indirizzo del primo elemento di un array A di numeri in complemento a due;
; - riceve in R1 l’indirizzo dell’ultimo elemento dell’array;
; - riceve in R2 un numero N in complemento a due;
; - restituisce in R0 l’indice I di N in A, cioè la posizione di N partendo da 1. Se il numero N non è presente in
;
; A, viene restituito il valore 0.
; Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il
; sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino alterati.

	.orig   x4001

	lea    	r0,array
	lea	r1,e_arr	
    	ld      r2,num1 	
    	jsr     subpr       	

stoqui	brnzp	stoqui

array	.fill	5
	.fill	9
	.fill	-12
	.fill	0
e_arr	.fill	32

num1	.fill	0

;****************************************************
; Sottoprogramma 

subpr   st      r3,save_r3	; Salvo R3 che verrà usato
	st	r4,save_r4	; Salvo R4 che verrà usato
	st	r5,save_r5	; Salvo R5 che verrà usato

	and	r3,r3,#0
	add	r3,r3,#1    	; contatore che parte da 1
ciclo	ldr	r5,r0,#0	; metto il il valore presente nella posizione dell array in R2
	
	not	r4,r0		; Contollo se arrivo alla fine dell array
	add	r4,r4,#1	;
	add	r4,r1,r4	; indirizzo contenuto in R0(array + indice) - R4(fine dell array), se < 0 allora ho superato la fine essendo che gli array sono continui in memoria
	brn	end_arr		; 
	
	not	r5,r5		; controllo se nella posizione dell array attuale == valore che cerco	
	add	r5,r5,#1	;
	add	r5,r2,r5	;
	brz	trovato		; Se lo trovo differenza = 0

	add	r0,r0,#1	; vado all indirizzo dell array successivo
	add	r3,r3,#1	; incremento il conatatore +1
	brnzp	ciclo

trovato	and	r0,r0,#0
	add	r0,r0,r3	
	brnzp	fine

end_arr	and	r0,r0,#0	; R0 = 0 se non ho trovato nulla o sono arrivato alla fine dell array
fine	ld	r3,save_r3
	ld	r4,save_r4
	ld	r5,save_r5
	ret

; Variabili del sottoprogramma
save_r3	.blkw	1       ; Spazio per salvare R3
save_r4	.blkw	1       ; Spazio per salvare R4
save_r5	.blkw	1       ; Spazio per salvare R5
	.end