.section .text

.global DrawPixel16bpp
/* Draw Pixel to a 1024x768x16bpp frame buffer
 * Note: no bounds checking on the (X, Y) coordinate
 *	r0 - frame buffer pointer
 *	r1 - pixel X coord
 *	r2 - pixel Y coord
 *	r3 - colour (use low half-word)
 */
DrawPixel16bpp:
	push	{r4}

	offset	.req	r4

	// offset = (y * 1024) + x = x + (y << 10)
	add		offset,	r1, r2, lsl #10
	// offset *= 2 (for 16 bits per pixel = 2 bytes per pixel)
	lsl		offset, #1

	// store the colour (half word) at framebuffer pointer + offset
	strh	r3,		[r0, offset]

	pop		{r4}
	bx		lr

.global DrawHLine
DrawHLine:
	push		{r4, r5, lr}
	
	mov		r5, r3			//Stores the Address in r5 for use in method

	ldr		r3, [r5, #12]		//Sets r3 to the colour
	ldr		r4, [r5, #16]		//Sets r4 to Size

	add		r4, r1			//Calculates the right-most point of the line
lineLoop:

	bl		DrawPixel16bpp		//Calls DrawPixel

	add		r1, #1	
	cmp		r1, r4
	blt		lineLoop

	mov		r3, r5
	pop		{r4, r5, lr}
	bx		lr


.global DrawVLine
DrawVLine:
	push		{r4, r5, lr}
	
	mov		r5, r3			//Stores the Address in r5 for use in method

	ldr		r3, [r5, #12]		//Sets r3 to the colour
	ldr		r4, [r5, #16]		//Sets r4 to Size

	add		r4, r2			//Calculates the right-most point of the line
lineVLoop:

	bl		DrawPixel16bpp		//Calls DrawPixel

	add		r2, #1	
	cmp		r2, r4
	blt		lineVLoop

	mov		r3, r5
	pop		{r4, r5, lr}
	bx		lr

.global DrawArms
DrawArms:
	push		{r4, r5, r6, lr}
	
	ldr		r4, [r3, #16]		//Sets r4 to Size

	sub		r1, r4
	sub		r2, r4

	bl		DrawVLine

	lsr		r4, #1
	sub		r2, r4

	bl		DrawHLine
	
	bl		DrawHLine

	sub		r2, r4

	bl		DrawVLine

	pop		{r4, r5, r6, lr}
	bx		lr


.global DrawKINGArms
DrawKINGArms:
	push		{r4, r5, r6, lr}
	
	ldr		r4, [r3, #16]		//Sets r4 to Size

	sub		r1, r4	
	
	add		r2, r4, lsr #1

	bl		DrawVLine
	
	sub		r2, r4, lsr #1
	sub		r2, #2

	bl		DrawHLine

	bl		DrawHLine

	bl		DrawHLine

	bl		DrawHLine

	add		r2, #2
	sub		r2, r4, lsr #1

	bl		DrawVLine



	pop		{r4, r5, r6, lr}
	bx		lr

.global DrawQUEENArms
DrawQUEENArms:
	push		{r4, r5, r6, lr}
	
	ldr		r4, [r3, #16]		//Sets r4 to Size

	sub		r1, r4	
	
	add		r2, r4, lsr #1

	bl		DrawVLine
	
	sub		r2, r4, lsr #1
	sub		r2, #2

	bl		DrawHLine

	bl		DrawHLine

	bl		DrawHLine


	add		r2, #2
	sub		r2, r4, lsr #1

	bl		DrawVLine



	pop		{r4, r5, r6, lr}
	bx		lr

.global DrawJACKArms
DrawJACKArms:
	push		{r4, r5, r6, lr}
	
	ldr		r4, [r3, #16]		//Sets r4 to Size

	sub		r1, r4	
	
	add		r2, r4, lsr #1

	bl		DrawVLine
	
	sub		r2, r4, lsr #1
	sub		r2, #2

	bl		DrawHLine

	bl		DrawHLine

	add		r2, #2
	sub		r2, r4, lsr #1

	bl		DrawVLine



	pop		{r4, r5, r6, lr}
	bx		lr




.global DrawBlock


DrawBlock:

	push		{r4, r5, r6, lr}

	mov		r5, r3			//Stores the Address of SquareVariables in r5 for use in method

	ldr		r0, [r5]		//Loads the FrameBuffer from SquareVariables into r0
	ldr		r1, [r5, #4]		//Loads the X-coordinate from SquareVariables into r1
	ldr		r2, [r5, #8]		//Loads the Y-coordinate from SquareVariables into r2
	ldr		r4, [r5, #16]		//Loads the Size from SquareVariables into r4
	
	mov		r6, r1			//Save the initial X-Coordinate into r6
	add		r4, r2			//Calculates the lowest vertical point of the box

boxLoop:

	mov		r1, r6			//Resets the X-coordinate to start new line

	bl		DrawHLine		//Calls the DrawHLine function

	add		r2, #1
	cmp		r2, r4
	blt		boxLoop

	pop		{r4, r5, r6, lr}
	bx		lr


.global DrawTriangleUp

DrawTriangleUp:

	push		{r4, r5, r6, r7, lr}

	ldr		r4, [r3, #16]		//Loads the Size from SquareVariables into r4
	
	mov		r6, r1			//Save the initial X-Coordinate into r6
	mov		r7, r4			//Set counter for offeset to 0
	mov		r4, #1

triangleUpLoop:

	sub		r1, r6, r4, lsr #1
	str		r4, [r3, #16]

	bl		DrawHLine		//Calls the DrawHLine function

	add		r4, #1
	add		r2, #1
	cmp		r4, r7
	blt		triangleUpLoop

	mov		r1, r6
	str		r7, [r3, #16]

	pop		{r4, r5, r6, r7, lr}
	bx		lr

.global DrawTriangleDown

DrawTriangleDown:

	push		{r4, r5, r6, r7, lr}

	ldr		r0, [r3]		//Loads the FrameBuffer from SquareVariables into r0
	ldr		r1, [r3, #4]		//Loads the X-coordinate from SquareVariables into r1
	ldr		r2, [r3, #8]		//Loads the Y-coordinate from SquareVariables into r2
	ldr		r4, [r3, #16]		//Loads the Size from SquareVariables into r4
	
	mov		r6, r1			//Save the initial X-Coordinate into r6
	mov		r7, #0			//Set counter for offeset to 0

triangleDownLoop:

	sub		r1, r6, r4, lsr #1
	str		r4, [r3, #16]

	bl		DrawHLine		//Calls the DrawHLine function

	sub		r4, #1
	add		r2, #1
	cmp		r4, r7
	bgt		triangleDownLoop

	pop		{r4, r5, r6, r7, lr}
	bx		lr

.global DrawPlayer

DrawPlayer:

	push		{r4, r5, r6, r7, r8, lr}


	ldr		r0, [r3]		//Loads the FrameBuffer from SquareVariables into r0
	ldr		r1, [r3, #4]		//Loads the X-coordinate from SquareVariables into r1
	ldr		r2, [r3, #8]		//Loads the Y-coordinate from SquareVariables into r2
	ldr		r4, [r3, #16]		//Loads the Size from SquareVariables into r4

	mov		r6, r1			//Save the initial X-Coordinate into r6
	mov		r7, r4			//Set counter for offeset to 0
	mov		r8, r4			//Set counter for offeset to 0
	mov		r4, #1

playerUpLoop:

	sub		r1, r6, r4, lsr #1
	str		r4, [r3, #16]

	bl		DrawHLine		//Calls the DrawHLine function

	add		r4, #2
	add		r2, #1
	cmp		r4, r7
	blt		playerUpLoop
	


	mov		r7, #1			//Set counter for offeset to 0

playerDownLoop:

	sub		r1, r6, r4, lsr #1
	str		r4, [r3, #16]

	bl		DrawHLine		//Calls the DrawHLine function

	sub		r4, #2
	add		r2, #1
	cmp		r4, r7
	bgt		playerDownLoop

	str		r8, [r3, #16]
	
	bl		DrawArms

	pop		{r4, r5, r6, r7, r8, lr}
	bx		lr



.global DrawKing
	
DrawKing:

	push		{r4, r5, r6, r7, r8, lr}

	ldr		r0, [r3]		//Loads the FrameBuffer from SquareVariables into r0
	ldr		r1, [r3, #4]		//Loads the X-coordinate from SquareVariables into r1
	ldr		r2, [r3, #8]		//Loads the Y-coordinate from SquareVariables into r2
	ldr		r4, [r3, #16]		//Loads the Size from SquareVariables into r4

	mov		r6, r2			//Save the initial X-Coordinate into r6
	mov		r7, r1
	
	bl		DrawTriangleUp
	
	add		r1, r4
	mov		r2, r6

	bl		DrawTriangleUp

	add		r1, r4
	mov		r2, r6

 	bl		DrawTriangleUp

	mov		r2, r6
	mov		r1, r7
	bl		DrawKINGArms

	pop		{r4, r5, r6, r7, r8, lr}
	bx		lr

.global DrawQueen
	
DrawQueen:

	push		{r4, r5, r6, r7, r8, lr}

	ldr		r0, [r3]		//Loads the FrameBuffer from SquareVariables into r0
	ldr		r1, [r3, #4]		//Loads the X-coordinate from SquareVariables into r1
	ldr		r2, [r3, #8]		//Loads the Y-coordinate from SquareVariables into r2
	ldr		r4, [r3, #16]		//Loads the Size from SquareVariables into r4

	mov		r6, r2			//Save the initial X-Coordinate into r6
	mov		r7, r1
	
	bl		DrawTriangleUp
	
	add		r1, r4
	mov		r2, r6

	bl		DrawTriangleUp

	
	mov		r2, r6
	mov		r1, r7
	bl		DrawQUEENArms

	pop		{r4, r5, r6, r7, r8, lr}
	bx		lr


.global DrawJack
	
DrawJack:

	push		{r4, r5, r6, r7, r8, lr}

	ldr		r0, [r3]		//Loads the FrameBuffer from SquareVariables into r0
	ldr		r1, [r3, #4]		//Loads the X-coordinate from SquareVariables into r1
	ldr		r2, [r3, #8]		//Loads the Y-coordinate from SquareVariables into r2
	ldr		r4, [r3, #16]		//Loads the Size from SquareVariables into r4

	mov		r6, r2			//Save the initial X-Coordinate into r6
	mov		r7, r1
	
	bl		DrawTriangleUp
	
	mov		r2, r6
	mov		r1, r7
	bl		DrawJACKArms

	pop		{r4, r5, r6, r7, r8, lr}
	bx		lr

	

	

