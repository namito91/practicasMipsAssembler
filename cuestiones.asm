# .data                   # comienza zona de datos
# palabra1: .word 15      # decimal
# palabra2: .word 0x15    # hexadecimal


# --------------------------------------------------------

# .data      0x10010000          # comienza zona de datos
# palabra1: .word 15 , 0x15      # decimal / hexadecimal


# --------------------------------------------------------    

# vector de 5 palabras

# .data    0x10000002
# vector: .word 0x10
#	  .word 0x30
#	  .word 0x34
#	  .word 0x20
#      	  .word 60 


# --------------------------------------------------------

# .data 
# octeto: .byte 0x10 # hexadecimal


# --------------------------------------------------------
 
# big-endian: bit mas significativo,va en la direccion mas baja de memoria 
# little-endian: bit mas significativo,va en la direccion mas alta de memoria

# .data 
# palabra1: .byte 0x10 ,0x20 ,0x30 ,0x40   # hexadecimal ,
# palabra2: .word 0x10203040               # hexadecimal , 


# --------------------------------------------------------

# ASCII 

# .data 
# cadena: .ascii "abcde"   # defino string , 
# octeto: .byte 0xff


# --------------------------------------------------------

# ASCII 

# .data 
# cadena: .asciiz "abcde"   # defino string , asciiz : agrega de relleno 1 byte en valor 00
# octeto: .byte 0xff


# --------------------------------------------------------

# ASCII 

# .data 
# cadena: .byte "abcde"   # defino directiva .byte, donde antes habia una directiva .ascii (TIRA ERROR!)
# octeto: .byte 0xff


# --------------------------------------------------------

# reserva de espacio en memoria
# La directiva .space n sirve para reservar espacio para una variable en
# memoria, inicializándola a valor 0.


# .data
# palabra1: .word  0x20
# espacio:  .space 8      # guarda 8 bytes(64 bits) de memoria (dos palabras) 
# palabra2: .word  0x30


# --------------------------------------------------------

# Alineación de datos en memoria
# La directiva .align n alinea el siguiente dato a una dirección múltiplo de 2n .
# Crea un fichero con el siguiente código:

# .data

# byte1:   .byte  0x10	  # se almacena en la direccion 0x10010000
# espacio: .space 4         # guarda 4 bytes(32 bits) de memoria (consecutivos apartir de byte1) ,rango de memoria: 0x10010001 ~ 0x10010004       
# byte2:   .byte  0x20      # se almacena en la direccion 0x10010005 (este dato no esta alineado)
# palabra: .word  10        # se almacena en la direccion 0x10010008 (esta direccion esta alineada,por que antes no hay una directiva "space",que reserve alguna cantidad de bytes)


# --------------------------------------------------------

# .data

# byte1:   .byte  0x10
#          .align 2         # alinea el siguiente dato a una dirección múltiplo de 2n

# espacio: .space 4         # rango de memoria 0x10010004 ~ 0x10010007  ,puede pertenecer a una palabra,por que comienza en una direccion multiplo de 4
# byte2:   .byte  0x20      
# palabra: .word  10


# --------------------------------------------------------

# .text                     #zona de instrucciones

# main:    lui $s0, 0x8690


# --------------------------------------------------------

# .text                       #zona de instrucciones

# main:      li $s0,0x12345678


# --------------------------------------------------------

# .data

# palabra1: .word  0x10203040
# palabra2: .word  0x30406070

# .text                      #zona de instrucciones
# main:    lw $s0 , palabra1($0)


# --------------------------------------------------------


# .data

# palabra1: .word  0x10203040
# palabra2: .word  0x30406070

# .text                      #zona de instrucciones
# main:     la  $s0 , palabra1


# --------------------------------------------------------

# .data

# palabra1: .word  0x10203040


# .text                      #zona de instrucciones
# main:     lw  $s0 , palabra1 + 1    # se intenta acceder a una direccion erronea de donde comienza la palabra
				    # ocurre una excepcion	

# --------------------------------------------------------


# .data

# palabra1: .word  0x10203040


# .text                      #zona de instrucciones
# main:     lh  $s0 , palabra1 + 2


# --------------------------------------------------------

# .data

# octeto:    .byte 0x80
# siguiente: .byte 0x20


# .text      #zona de instrucciones

# main:      lb $s0, octeto($0)        
#            lbu $s1, siguiente($0)    # lbu puede representa un entero sin signo en el rango [0,256]  (load byte unsigned)
           			       # lb puede representar un entero signado en el rango [-126,127] (load byte)


# --------------------------------------------------------

# .data

# palabra1: .word  0x10203040
# palabra2: .space 4
# palabra3: .byte  0xec

# .text      #zona de instrucciones

# main:

# lw $s0, palabra1($0)  # lw (word) carga la palabra1 en un registro
# lb $s1, palabra3($0)  # lb (byte) carga la palabra3 en un registro
# sw $s0, palabra2($0)  # sw almacena el registro $s0 en memoria,en la direccion de palabra2
# sb $s1, palabra1($0)  # sb almacena el registro $s1 en memoria,en la direccion de palabra3


# --------------------------------------------------------

# .data

# palabra: .word 0x10203040
# octeto:  .space 40

# .text       #zona de instrucciones

# main:

# lb $s0, palabra+3($0)    # palabra+3 no puede accederse por separado,por que esta "lw" cargando una .word , no esta cargando un byte
# sb $s0, octeto+1($0)

# --------------------------------------------------------

# .data  #zona de datos  #Máx. Positivo representable 0x7FFFFFFF

# numero: .word 2147483647

# .text  #zona de instrucciones

# main:

# lw $t0,numero($0)
# addi $t1,$t0,1        # addiu , no detecta desbordamiento

# --------------------------------------------------------


# .data

# numero1: .word 0x80000000    #max. Negativo represent.
# numero2: .word 1
# numero3: .word 1

# .text

# main:

# lw $t0,numero1($0)
# lw $t1,numero2($0)
# sub $t0,$t0,$t1

# lw $t1,numero3($0)
# sub $t0,$t0,$t1
# sw $t0,numero1($0)


# --------------------------------------------------------

# multiplicacion

# .data

# numero1: .word 20051235 
# numero2: .word 166464
    #      .space 8

# .text

# main:

# lw $t0,numero1($0)
# lw $t1,numero2($0)
# mult $t0,$t1 # multiplica los dos números
# mfhi $t0     # hi , lo : hold the 64-bit full result of a 32x32-bit integer mult
# mflo $t1
# sw $t0,numero2+4($0) #32 bits más peso
# sw $t1,numero2+8($0) #32 bits menos peso


# --------------------------------------------------------

# division

# .data

# numero1: .word 10 
# numero2: .word  2
 #        .space 8

# .text

# main:

# lw $t0,numero1($0)
# lw $t1,numero2($0)
# div $t0,$t1 # divide los dos números
# mfhi $t0     # hi (resto) , lo (cociente) 
# mflo $t1
# sw $t0,numero2+4($0) # resto
# sw $t1,numero2+8($0) # cociente


# --------------------------------------------------------

# convertir a los 16 bits menos significativos a 0 , excepto el bit 0 y los 16 bits mas significativos 

# .data

# numero: .word  0x3ff41  # ..     0011 1111111101000001 
#	.space 4        #        0011 0000000010111111
                        #        0011 0000000000000001  resultado del producto logico
# .text

# main: 

# lw   $t0,numero($0)
# andi $t1,$t0,0x300bf     # 0x300bf en binario es 0...0011 0000000010111111
# sw   $t1,numero+4($0)


# --------------------------------------------------------

# convertir los bits menos significativos a 1 , excepto el bit 0 y los 16 mas significativos permanezcan igual

# .data

# numero: .word  0x3ff41  # ..     0011 1111111101000001 
#	.space 4      #          0000 0000000010111110
                      #            11 1111111111111111  resultado de la suma logica
# .text

# main: 

# lw   $t0,numero($0)
# ori $t1,$t0,0xbe     # 0xffe en binario es 0...01111111111111110
# sw   $t1,numero+4($0)


# --------------------------------------------------------


# .data 

# numero:  .word 0xffffff41


# .text

# main:

# lw  $t0,numero($0)    # sra ( arithmetic shift ) : preserva el signo del numero ,que esta en c2. 
# sra $t1,$t0,4        



# --------------------------------------------------------



# .data 

# dato1: .word  50
# dato2: .word  30
# res:   .space 1


# .text

# main:

# lw $t0,dato1($0) # cargar dato1 en t0
# lw $t1,dato2($0) # cargar dato2 en t1

# poner a 1 $t2 si t0 < t1 , slt :  Si el contenido del primer registro es menor que el segundo carga un 1, en caso contrario carga un 0.
# slt $t2,$t0, $t1 
# sb $t2,res($0)   # almacenar $t2 en res



# --------------------------------------------------------



# .data 

#dato1: .word  40
#dato2: .word  30
#res:   .space 1


#.text

#main:

#lw $t0,dato1($0) # cargar dato1 en t0
#lw $t1,dato2($0) # cargar dato2 en t1
#sge $t2,$t0, $t1 # seq (set equal) pone a 1 $t2 si t0 = t1 , sge (set greater or equal) pone a 1 $t2 si t0 >= t1
#sb $t2,res($0)   # almacenar $t2 en res



# --------------------------------------------------------



# .data

# dato1: .word  200
# dato2: .word  20
# res:   .space 4
# msg:   .asciiz "el numero es menor.Fin de ejecucion"
# msg2:  .asciiz "el numero es mayor"
# msg3:  .asciiz "los numeros son iguales"


# .text


# main: 

# lb  $t5 , zero($0)
# lb  $t6 , one($0)
# lw  $t0 , dato1($0)     # cargar dato1 en t0
# lw  $t1 , dato2($0)     # cargar dato2 en t1
# slt $t2 , $t0, $t1      # poner a 1 $t2 si t0<t1 , slt (set less than)
#bne $t0,$t1,fineval    # si t0<>t1 salta a fineval
# or  $t3 , $t0,1         # poner a 1 t3 si t0 == 1 (ORI es la suma aritmerica con numeros pares)
# add $t4 , $t0,1         # una pseudoinstruccion que produce el mismo resultado que la instruccion anterior



# res(1) <- (dato1 >= dato2). No utilices pseudoinstrucciones

# numero es menor

# slt $t2 , $t0 , $t1
# bne $t2 , $t6 , interval
# li  $t2 , 0
# la ,$a0 , msg
# li  $v0 , 4          
# syscall
# sb $t2,res($0)
# j Exit


# interval: 
   
# numero es mayor

# beq  $t0 , $t1 ,iguales

# li $t2 , 1
# la , $a0 , msg2
# li $v0 , 4          
# syscall
# j fineval


# iguales:

# li $t2  , 1
# la ,$a0 , msg3
# li $v0  , 4          
# syscall
# j fineval



# fineval: 

# sb $t2,res($0)       # almacenar $t2 en res
# j Exit


# Exit:    

# li $v0, 10           # program ends
# syscall



# --------------------------------------------------------



# .data

# dato1: .word  200
# dato2: .word  20
# res:   .space 4
# uno:   .byte  1
# msg:   .asciiz "el numero es menor.Fin de ejecucion"
# msg2:  .asciiz "el numero es mayor"
# msg3:  .asciiz "los numeros son iguales"



# .text

# main: 

# lw  $t0 , dato1($0)     # cargar dato1 en t0
# lw  $t1 , dato2($0)     # cargar dato2 en t1

# res(1) <- (dato1 >= dato2). usando pseudoinstrucciones


# lb $t3 , uno($0)
# sgt $t2 , $t0 , $t1

# bne $t2 , $t3 , noEsMayor 

# la ,$a0 , msg2
# li  $v0 , 4          
# syscall

# sb $t2,res($0)
# j Exit



# noEsMayor:

# bne $t0 , $t1 , menor

# los numeros son iguales
# la ,$a0 , msg3
# li  $v0 , 4          
# syscall

# sb $t3,res($0)
# j Exit


# menor:

# t0 es menor a t1
# la ,$a0 , msg
# li  $v0 , 4          
# syscall

# sb $zero,res($0)



# Exit:    

# li $v0, 10           # program ends
# syscall



# --------------------------------------------------------


# .data

# dato1: .word  0
# dato2: .word  0
# res:   .space 1


# .text
# main:

# lw  $t8 , dato1($0)
# lw  $t9 , dato2($0)
# and $t0 , $t0 , $0      # 00000000  AND  00000000  -->> 00000000  (bitwise AND) 
# and $t1 , $t1 , $0
# beq $t8 , $0  , igual
# ori $t0 , $0  , 1       # 00000000  OR  00000001   -->> 00000001  (ORI)


# igual:

# beq $t9,$0,fineval
# ori $t1,$0,1


# fineval: 

# and $t0,$t0,$t1      # 00000001  AND  00000000  -->> 00000000  (bitwise AND)
# sb  $t0,res($0)



# --------------------------------------------------------


# evaluar esta condicion : res (1) <-- ((dato1 <> 0) and (dato1 <> dato2))


# .data

# dato1: .word  10
# dato2: .word  0
# res:   .space 1


# .text
# main:

# lw  $t8 , dato1($0)
# lw  $t9 , dato2($0)
# and $t0 , $t0 , $0      # 00000000  AND  00000000  -->> 00000000  (bitwise AND) 
# and $t1 , $t1 , $0
# bne $t8 , $0  , igual
# ori $t0 , $0  , 1       # 00000000  OR   00000001   -->> 00000001  (ORI)


# igual:

# beq $t8,$t9,fineval
# ori $t1,$0,1


# fineval: 

# andi $t0,$t0,10        # 00000001  AND  00000000  -->> 00000000  (bitwise AND)
# sb  $t0,res($0)




# --------------------------------------------------------



# .data 

# dato1: .word  10
# dato2: .word  -20
# res:   .space 1


# .text
# main:

# lw  $t8,dato1($0)
# lw  $t9,dato2($0)
# and $t1,$t1,$0      # t1 -> 0 
# and $t0,$t0,$0      # t0 -> 0
# beq $t8,$0,igual    
# ori $t0,$0,1        # t0 -> 1


# igual:

# slt $t1,$t9,$t8     # true -> 1 , false -> 0


# fineval: 

# and $t0,$t0,$t1     # 00000001 AND 000000001  -->> 00..001
# sb  $t0,res($0)



# --------------------------------------------------------


# Modifica el código anterior para que la condición evaluada sea : 
# res (1) <-- ((dato1 <> dato2) and (dato1 <= dato2)).

.data 

dato1: .word  10
dato2: .word  -20
res:   .space 1


.text
main:

lw  $t8,dato1($0)
lw  $t9,dato2($0)
and $t1,$t1,$0      # t1 -> 0 
and $t0,$t0,$0      # t0 -> 0
beq $t8,$0,igual    
ori $t0,$0,1        # t0 -> 1


igual:

slt $t1,$t9,$t8     # true -> 1 , false -> 0


fineval: 

and $t0,$t0,$t1     # 00000001 AND 000000001  -->> 00..001
sb  $t0,res($0)



