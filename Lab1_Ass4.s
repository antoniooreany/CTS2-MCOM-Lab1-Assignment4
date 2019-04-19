	.data
addrArrayA: 	.word 0x1	# ArrayA elements initialization
		.word 0x2	# ArrayA elements initialization
		.word 0x3	# ArrayA elements initialization
		.word 0x4	# ArrayA elements initialization
		.word 0x5	# ArrayA elements initialization
		.word 0x6	# ArrayA elements initialization
		.word 0x7	# ArrayA elements initialization
		.word 0x8	# ArrayA elements initialization
addrArrayB: 	.skip 32	# allocate 8 words * 4 bytes = 32 bytes

	.global _start
	.text
START:
	movi r2, 8		# addrArrayA.length=8
	mov r3, r0		# i=0
	movi r4, 2		# c=2
	
	movia r5, addrArrayA	# r5 <- start address of ArrayA
	movia r6, addrArrayB	# r6 <- start address of ArrayB
	
LOOP:
	bge r3, r2, END		# if i>=addrArrayA.length => END
	
	ldw r7, (r5)		# read next element of ArrayA
	
	add r8, r7, r4		# addrArrayB = addrArrayA + r4

	stw r8, (r6)		# store next element of ArrayB
	
	addi r5, r5, 4		# increment address of ArrayA by 4
	addi r6, r6, 4		# increment address of ArrayA by 4
	addi r3, r3, 1		# increment i by 1
	
	br LOOP			# continue LOOP
	
END:
	
endloop:
	br endloop		# that's it
	.end

CALC:
	
	

	
