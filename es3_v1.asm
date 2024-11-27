;Variante 1
;Scrivere un sottoprogramma che:
;
;- riceve in R0 l’indirizzo del primo elemento di un array A di numeri in complemento a due diversi da zero;
;
;la prima occorrenza del valore 0 costituisce il tappo dell’array, cioè ne indica la fine;
;
;- riceve in R1 un numero N in complemento a due;
;- restituisce in R0 l’indice I di N in A, cioè la posizione di N partendo da 1. Se il numero N non è presente in A, viene restituito il valore 0.
;
;Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il
;sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino alterati.

	.orig   x4001

	lea    	r0,array   	
    	ld      r1,num1 	
    	jsr     subpr       	

stoqui	brnzp	stoqui

array	.fill	5
	.fill	9
	.fill	-12
	.fill	34
vuoto	.fill	0

num1	.fill	5

;****************************************************
; Sottoprogramma 

subpr   st      r2,save_r2  	; Salvo R2 che verrà usato
	st      r3,save_r3	; Salvo R2 che verrà usato

	and	r3,r3,#0
	add	r3,r3,#1    	; contatore che parte da 1
ciclo	ldr	r2,r0,#0	; metto il il valore presente nella posizione dell array in R2
	and	r2,r2,r2	; Contollo del segno
	brz	end_arr		; se arrivo alla fine dell array
	
	not	r2,r2		; controllo se nella posizione dell array attuale == valore che cerco	
	add	r2,r2,#1	; R2 = -R2
	add	r2,r1,r2	

	brz	trovato		; Se lo trovo
	add	r0,r0,#1	; vado all indirizzo dell array successivo
	add	r3,r3,#1	; incremento il conatatore +1
	brnzp	ciclo

trovato	and	r0,r0,#0
	add	r0,r0,r3	
	brnzp	fine

end_arr	and	r0,r0,#0	; R0 = 0 se non ho trovato nulla o sono arrivato alla fine dell array
fine	ld	r2,save_r2
	ld	r3,save_r3
	ret

; Variabili del sottoprogramma
save_r2	.blkw	1       ; Spazio per salvare R2
save_r3	.blkw	1       ; Spazio per salvare R3
	.end