# Example: display the value stored in $t0 on the console

# .data
 
# byte : .byte 0x15
        
    
# .text 
# .globl main    

# main: 

# lb $t0 , byte($0)          # lb (byte) carga la palabra3 en un registro                                                                                                                                                               
# li  $v0, 1                 # service 1 is print integer
# add $a0, $t0 , $zero       # load desired value into argument register $a0, using pseudo-op
# syscall

#-------------------------------------------------------------------------

# simple "hola mundo"

# .data 

# msg: .asciiz "hola mundo \n"


# .text 

# .globl main

# main: la $a0 , msg
#       li $v0 , 4  	
#       syscall	
      		

#-------------------------------------------------------------------------


# menu de opciones

.data 

opciones: .asciiz "elegi 1 , 2 o 3 ..."
opcion1:  .asciiz "Javascript" 
opcion2:  .asciiz "Python" 
opcion3:  .asciiz "React"  
salir:    .asciiz "incorrect option, exiting..." 


.text  
.globl Main

Main: 


li $t0 , 1
li $t1 , 2
li $t2 , 3


# muestra las opciones disponibles
la $a0 , opciones
li $v0 , 4  	
syscall

li $v0 , 5  	
syscall	


bne $v0, $t0 , second

la $a0 , opcion1
li $v0 , 4  	
syscall
j Exit


second:
bne $v0, $t1 , third

la $a0 , opcion2
li $v0 , 4  	
syscall
j Exit

third:
bne $v0, $t2 , Else

la $a0 , opcion3
li $v0 , 4  	
syscall
j Exit


Else:

la $a0 , salir
li $v0 , 4  	
syscall
j Exit


Exit:    li $v0, 10           # program ends
         syscall
