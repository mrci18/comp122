ldr r0,=MyFile 

swi 0x66 ;open file
bcs Exit 

mov r9,r0 ;store file handle in r9

swi 0x6c ;read int from file

mov r1,r0 ; store int x in r1
mov r0,#1 ; print to stdout
swi 0x6b ; print int in r1

ADD R7,R7,#1; first occurance of x

mov r2,r1 ; move x to r2

mov r0, r9 ;recall file handle from r9
swi 0x6c ; read next int

CMP R0,R2 ; If next int is equal to R1
ADDEQ R7,R7,#1 ; Counter if x occurs

mov r1,r0 ; store in y in r1
mov r0,#1 ; print to stdout
swi 0x6b

mov r3,r1; move y to r3 

mov r0, r9 ;recall file handle from r9
swi 0x6c ; read next int

CMP R0,R2 ; If next int is equal to R1
ADDEQ R7,R7,#1 ; Counter if x occurs

CMP R0,R1
ADDLT R8,R8,#1

Exit:
swi 0x11 ; exit

.data
MyFile: .asciz "integers.dat" ;\0 after string
