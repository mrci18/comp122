mov r1,#0
ldr r0,=StringFile

swi 0x66 ; open file
bcs Whoops

mov r3,r0 ; store file handle in R3

mov r0,r3 ; move file handle into R0
ldr r1,=InputString
mov r2,#51
swi 0x6a ; read string


mov r1,#1
ldr r0,=OutputFile

swi 0x66 ; open output file
bcs Whoops

; file handle should already be in R0
ldr r1,=InputString

swi 0x69 ; print string to file
bcs Whoops

Whoops:
swi 0x11 ; Exit

.data

StringFile: .asciz "string.txt"
OutputFile: .asciz "out.txt"
InputString: .skip 50
