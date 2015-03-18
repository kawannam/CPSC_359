.section    .init
.globl     _start

_start:
    b       main
    
.section .text

main:
    mov     sp, #0x8000
	
	bl		EnableJTAG

	bl		InitFrameBuffer

// branch to the halt loop if there was an error initializing the framebuffer

	cmp		r0, #0
	beq		haltLoop$

 	ldr		r3, =KingVariables	//Getting Address of SquareVariables
	str		r0, [r3]		//Stores FrameBuffer in SquareVariables

	bl		DrawKing

	ldr		r3, =QueenVariables	//Getting Address of SquareVariables
	str		r0, [r3]		//Stores FrameBuffer in SquareVariables

	bl		DrawQueen

	ldr		r3, =JackVariables	//Getting Address of SquareVariables
	str		r0, [r3]		//Stores FrameBuffer in SquareVariables

	bl		DrawJack

GameLoop:

	ldr		r3, =PlayerVariables	//Getting Address of SquareVariables
	str		r0, [r3]		//Stores FrameBuffer in SquareVariables

	bl		DrawPlayer

	ldr		r3, =PlayerVariables	//Getting Address of SquareVariables
	bl		GetInput
	
	bl		Move

//	b		GameLoop

	

  
haltLoop$:
	b		haltLoop$


.section .data

SquareVariables:
	.int 0, 100, 100, 0x99FF, 20		//Framebuffer, X, Y, Colour, SIZE
TriangleVariables:
	.int 0, 110, 110, 0x6677, 30		//Frambuffer, X, Y, Colour, SIZE
PlayerVariables:
	.int 0, 400, 300, 0x6677, 40		//Frambuffer, X, Y, Colour, SIZE
KingVariables:
	.int 0, 700, 700, 0x7777, 30
QueenVariables:
	.int 0, 500, 700, 0x99FF, 30
JackVariables:
	.int 0, 100, 700, 0x9988, 30
.global InputValue
InputValue:
	.word 0x0000


