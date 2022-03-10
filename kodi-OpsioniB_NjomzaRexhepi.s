.data
 x: .asciiz "\nEnter positive integer to check: "
 nprimeNumber: .asciiz " is not a prime number" 
 primeNumber: .asciiz " is a prime number"
 flag: .word 0
 input: .word 0
.text
.globl main 
main:

     #print x
	li $v0, 4
	la $a0, x
	syscall 
	#number from keyboard
	li $v0,5
	syscall
	#save the value from keyboard to input
	sw $v0,input
	
	#print x
	li $v0, 1 
    lw $a0, input
    syscall
	
	#i=2
	li $t1,2 
	
	#call the prime function 
	jal prime
	add $s0,$v0,$zero 

	
	#check if the return value from prime function is ==0 or ==1
	beq $s0,0,PrintIsPrime
	beq $s0,1,PrintIsNotPrime
	
	#print text 
	PrintIsPrime: 
	 li $v0,4
	 la $a0, nprimeNumber
	 syscall
	  b exit
	PrintIsNotPrime:
	li $v0,4
	la $a0, primeNumber
	syscall
    b exit
    syscall
	
#function prime
prime:	
#in case $a0 is equal with 1 go to isNotPrime 
	beq $a0,1 ,isNotPrime
	# $a0 is less than 1 go to isNotPrime
	blt $a0, 1, isNotPrime
	loop: 
	     beq $t1, $a0, isPrime  
		 div $a0, $t1  # $a0/$t1
		 mfhi $t2  # div reminder 'Move from HI' HI->remainder
		 beq $t2, $0, isNotPrime
		 addi $t1,$t1,1 
		 b loop
		 
	isPrime:
	li $v0, 1      #return 1  
    jr $ra
	.end isPrime
	  
	isNotPrime: 
    li $v0, 0       #return 0
    jr $ra
	.end isNotPrime
.end prime
 #exit label end the program
	exit:
	li $v0,10
	syscall
