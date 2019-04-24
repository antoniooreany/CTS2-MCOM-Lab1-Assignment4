###############################################
# MCOM-Labor: Vorlage fuer Assemblerprogramm
# Edition History:
# 28-04-2009: Getting Started - ms
# 12-03-2014: Stack organization changed - ms
###############################################

###############################################
# Definition von symbolen Konstanten
###############################################
	.equ STACK_SIZE, 0x400	# stack size
###############################################
# DATA SECTION
# assumption: 12 kByte data section (0 - 0x2fff)
# stack is located in data section and starts
# directly behind used data items at address
# STACK_END.
# Stack is growing downwards. Stack size
# is given by STACK_SIZE. A full descending
# stack is used, accordingly first stack item
# is stored at address STACK_END+(STACKSIZE).
###############################################	
	.data
TST_PAK1:
	.word 0x11112222	# test data
	
addrArrayA: 	.word 0x1	# ArrayA elements initialization
		.word 0x2	# ArrayA elements initialization
		.word 0x3	# ArrayA elements initialization
		.word 0x4	# ArrayA elements initialization
		.word 0x5	# ArrayA elements initialization
		.word 0x6	# ArrayA elements initialization
		.word 0x7	# ArrayA elements initialization
		.word 0x8	# ArrayA elements initialization
addrArrayB: 	.skip 32	# allocate 8 words * 4 bytes = 32 bytes

STACK_END:
	.skip STACK_SIZE	# stack area filled with 0

###############################################
# TEXT SECTION
# Executable code follows
###############################################
	.global _start
	.text
_start:
	#######################################
	# stack setup:
	# HAVE Care: By default JNiosEmu sets stack pointer sp = 0x40000.
	# That stack is not used here, because SoPC does not support
	# such an address range. I. e. you should ignore the STACK
	# section in JNiosEmu's memory window.
	
	movia	sp, STACK_END		# load data section's start address
	addi	sp, sp, STACK_SIZE	# stack start position should
					# begin at end of section


START:
	movi r2, 8		# addrArrayA.length=8
	mov r3, r0		# i=0
	movi r4, 2		# c=2
	
	movia r5, addrArrayA	# r5 <- start address of ArrayA
	movia r6, addrArrayB	# r6 <- start address of ArrayB
	
LOOP:
	bge r3, r2, END		# if i>=addrArrayA.length => END
	
	ldw r7, (r5)		# read next element of ArrayA ->
	
	add r8, r7, r4		# addrArrayB = addrArrayA + r4

	stw r8, (r6)		# store next element of ArrayB
	
	addi r5, r5, 4		# increment address of ArrayA by 4
	addi r6, r6, 4		# increment address of ArrayB by 4
	addi r3, r3, 1		# increment i by 1
	
	br LOOP			# continue LOOP
	
END:
	
endloop:
	br endloop		# that's it
	.end




endloop:
	br endloop		# that's it

###############################################
	.end
	
