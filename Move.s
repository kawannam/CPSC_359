.section .text

.global Move
Move:
	push	{r4, r5, r6, r7, r8, lr}

	ldr	r5, =InputValue
	ldr	r8, [r5]
Check:	
	ldr	r5, =0xFEFF

	tst	r5, r8

//	bne	noMotion


	ldr	r6, [r3, #12]
	ldr	r7, =0x0000
	str	r7, [r3, #12]
	bl	DrawPlayer

	ldr	r1, [r3, #4]
	ldr	r4, [r3, #16]

	add	r1, r4
	
	str	r1, [r3, #4]
	str	r6, [r3, #12]
	
	bl	DrawPlayer
	

noMotion:
	pop	{r4, r5, r6, r7, r8, lr}
	bx	lr

.global KingMotion
	
KingMotion:
	push	{r4, r5, r6, r7, lr}	
	
	ldr	r1, [r3, #4]
	ldr	r4, [r3, #16]
	ldr	r6, [r3, #12]
	add	r1, r4

	ldr	r7, =0x0000

	str	r7, [r3, #12]
	
	bl	DrawKing
	
	str	r1, [r3, #4]
	str	r6, [r3, #12]
	
	bl	DrawKing
	
	pop	{r4, r5, r6, r7, lr}
	bx	lr

.global QueenMotion
QueenMotion:
	push	{r4, r5, r6, r7, lr}	
	
	ldr	r1, [r3, #4]
	ldr	r4, [r3, #16]
	ldr	r6, [r3, #12]
	add	r1, r4

	ldr	r7, =0x0000

	str	r7, [r3, #12]
	
	bl	DrawQueen
	
	str	r1, [r3, #4]
	str	r6, [r3, #12]
	
	bl	DrawQueen
	
	pop	{r4, r5, r6, r7, lr}
	bx	lr

.global JackMotion
JackMotion:
	push	{r4, r5, r6, r7, lr}	
	
	ldr	r1, [r3, #4]
	ldr	r4, [r3, #16]
	ldr	r6, [r3, #12]
	add	r1, r4

	ldr	r7, =0x0000

	str	r7, [r3, #12]
	
	bl	DrawJack
	
	str	r1, [r3, #4]
	str	r6, [r3, #12]
	
	bl	DrawJack
	
	pop	{r4, r5, r6, r7, lr}
	bx	lr



