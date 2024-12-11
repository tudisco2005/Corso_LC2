1 tenere in registro della somma in ca2
2 leggere un numero dall array
3 converirlo in ca2
4 sommaro al registro della somma
5 sono alla fine convertirlo in modulo e segno

.orig	x4001
	
	lea	r0,arr
	jsr	SOMMA
	
stoqui	brnzp	stoqui

arr	.fill	b1000000000000001	; -1
	.fill	b1000000000000010	; -2
	.fill	b0000000000000100	; 4
	.fill	b0000000000000000	; ha 2 possibili rappresentazioni b1000000000000000

; *************************************
SOMMA 	st	r1,save_r1
	st	r2,save_r2	
	st 	r3,save_r3
	st	r4,save_r4
	st	r5,save_r5

ciclo	ld	r2,num
	ld	r5,mask

	ldr	r1,r0,#0
	brz	fine		; controllo prima rappresentazione dello 0 (b0000000000000000)
	add	r4,r1,r2
	brz	fine		; controllo seconda rappresentazione dello 0 (b1000000000000000)
	
; check del segno dei due operandi
	and	r1,r1,r1
	brp	r1_pos
	brn	r1_neg

r1_pos	and	r3,r3,r3
	brzp	concr_p
	brn	disc_p

r1_neg	and	r3,r3,r3
	brnz	concr_n
	brp	disc_n

concr_n	not	r2,r2
	
	and	r1,r1,r2	;azzera il segno del numero in modulo e segno
	not	r1,r1
	add	r1,r1,#1	;cambio segno in complemento a 2

	and	r3,r3,r2	;azzera il segno del numero in modulo e segno
	not	r3,r3
	add	r3,r3,#1	;cambio segno in complemento a 2

	add	r3,r3,r1	; sommo
	
	and	r3,r2,r3	; converto r3 in modulo e segno
	not	r3,r3
	add	r3,r3,#1
	
	not	r3,r3		
	not	r5,r5
		
	and 	r3,r3,r5
	not	r3,r3		

	brnzp	incr

concr_p	add	r3,r1,r3
	brnzp	incr

disc_p	; converire r1 e r3 in ca2 e sommarli (r3 e' negativo)
	brnzp	incr

disc_n	not	r2,r2
	and	r1,r1,r2
	
	not	r1,r1		; devo rendere negativo r1
	add	r1,r1,#1

	add	r3,r3,r1
	
	not	r2,r2
	not	r3,r3
	add	r3,r3,#1
	
	not	r3,r3
	not	r5,r5
		
	and 	r3,r3,r5
	not	r3,r3

	brnzp	incr

incr	add	r0,r0,#1
	brnzp	ciclo

fine	and	r0,r3,r3
	ld	r1,save_r1
	ld	r2,save_r2	
	ld 	r3,save_r3
	ld	r4,save_r4
	ld	r5,save_r5
	ret

; variabili
	
num 	.fill	b1000000000000000
mask	.fill	b1000000000000000

save_r1	.blkw	1
save_r2	.blkw	1
save_r3	.blkw	1
save_r4	.blkw	1
save_r5	.blkw	1
; *************************************
	.end
