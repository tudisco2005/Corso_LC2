; convertire un numero da mudulo e segno in CA2 ricevuto nell r0

	.orig	x4000
	ld	r0,n1
	jsr	modtoc2
	ld	r0,n2
	jsr	modtoc2

stoqui	brnzp	stoqui

n1	.fill	5			; la rapprentazione di 5 in modulo e segno e' uguale al CA2
n2	.fill	b1000000000000101	; rappresentazione in modulo e segno di -5

;************************************************
modtoc2	st	r1,sav1

	and	r0,r0,r0
	brzp	fine		;se r0 >= 0 modulo e segno coincide con il complemento a 2
;qui modulo e segno negativo, devo creare il negativo in complemento a 2
	ld	r1,mask
	and	r0,r0,r1	;azzera il segno del numero in modulo e segno
	not	r0,r0
	add	r0,r0,#1	;cambio segno in complemento a 2
;qui comunque
fine	ld	r1,sav1
	ret

mask	.fill	b0111111111111111
sav1	.blkw	1
;***********************************************************

	.end
