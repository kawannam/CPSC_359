.section .text

.global GetInput

GetInput:

	push		{r0-r7}

set11:

	ldr		r0, =0x20200004
	ldr		r1, [r0]
	mov		r2, #0b111
	lsl		r2, #3
	bic		r1, r2
	mov		r3, #0b001
	lsl		r3, #3
	orr		r1, r3
	str		r1, [r0]

set9:

	ldr		r0, =0x20200000
	ldr		r1, [r0]
	mov		r2, #0b111
	lsl		r2, #27
	bic		r1, r2
	mov		r3, #0b001
	lsl		r3, #27
	orr		r1, r3
	str		r1, [r0]

set10:

	ldr		r0, =0x20200004
	ldr		r1, [r0]
	mov		r2, #0b111
	lsl		r2, #0
	bic		r1, r2
	mov		r3, #0b000
	lsl		r3, #0
	orr		r1, r3
	str		r1, [r0]

button:
	mov		r7, #0x0

writeclock:

	mov		r1, #1
	mov		r0, #11
	ldr		r2, =0x20200000
	mov		r3, #1
	lsl		r3, r0
	teq		r1, #0
	streq		r3, [r2, #40]
	strne		r3, [r2, #28]

writelatch:

	mov		r1, #1
	mov		r0, #9
	ldr		r2, =0x20200000
	mov		r3, #1
	lsl		r3, r0
	teq		r1, #0
	streq		r3, [r2, #40]
	strne		r3, [r2, #28]

wait12:
	ldr		r0, =0x20003004
	ldr		r1, [r0]
	add		r1, #12
waitloop:
	ldr		r2, [r0]
	cmp		r1, r2
	bhi		waitloop

writelatch2:

	mov		r1, #0
	mov		r0, #9
	ldr		r2, =0x20200000
	mov		r3, #1
	lsl		r3, r0
	teq		r1, #0
	streq		r3, [r2, #40]
	strne		r3, [r2, #28]

	mov		r6, #0

pulseLoop:
		
wait6:
	ldr		r0, =0x20003004
	ldr		r1, [r0]
	add		r1, #6
waitloop2:
	ldr		r2, [r0]
	cmp		r1, r2
	bhi		waitloop2

writeclock2:

	mov		r1, #0
	mov		r0, #11
	ldr		r2, =0x20200000
	mov		r3, #1
	lsl		r3, r0
	teq		r1, #0
	streq		r3, [r2, #40]
	strne		r3, [r2, #28]
wait63:
	ldr		r0, =0x20003004
	ldr		r1, [r0]
	add		r1, #6
waitloop3:
	ldr		r2, [r0]
	cmp		r1, r2
	bhi		waitloop3

readData:

	mov		r0, #10
	ldr		r2, =0x20200000
	ldr		r1, [r2, #52]
	mov		r3, #1
	lsl		r3, r0
	and		r1, r3
	teq		r1, #0
	moveq		r4, #0
	movne		r4, #1
	orr		r7, r4

writeclock3:

	mov		r1, #1
	mov		r0, #11
	ldr		r2, =0x20200000
	mov		r3, #1
	lsl		r3, r0
	teq		r1, #0
	streq		r3, [r2, #40]
	strne		r3, [r2, #28]

	add		r6, #1
	cmp		r6, #16
	lslne		r7, #1
	cmp		r6, #16
	bne		pulseLoop

	ldr		r0, =InputValue
	str		r7, [r0]
	
	pop		{r0-r7}

	bx		lr

