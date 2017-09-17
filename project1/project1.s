ldr r0,=MyFile 

swi 0x66 ;open file
bcs Exit 

mov r9,r0 ;store file handle in r9

swi 0x6c ;read int from file

mov r1,r0 ; store int x in r1
mov r0,#1 ; print to stdout

swi 0x6b ; print int in r1

mov r0, r9 ;recall file handle from r9
swi 0x6c ; read next int

mov r1,r0
mov r0,#1 ; print to stdout

swi 0x6b

Exit:
swi 0x11 ; exit

.data
MyFile: .asciz "integers.dat" ;\0 after string
