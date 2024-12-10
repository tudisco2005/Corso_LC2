	.orig	x4001
	lea	r0,arr
	ld	r1,num1
	jsr	OR_ARR
	
stoqui	brnzp 	stoqui

arr 	.fill	b0000111100001111
	.fill	b0011001100110011
	.fill	b1100110011001100
	.fill	b0000000000000000

num1 	.fill 	b1111000011110000
;**********************************
OR_ARR
	st	r2,save_r2
	st	r3,save_r3

	not	r1,r1
ciclo	ldr	r2,r0,#0
	brz	fine
	
	not 	r2,r2
	and	r3,r1,r2
	not	r3,r3
	str	r3,r0,#0
	
incr	add	r0,r0,#1
	brnzp	ciclo

fine	ld	r2,save_r2
	ld	r3,save_r3
	ret

save_r2	.blkw	1
save_r3	.blkw	1
;**********************************
	.end
