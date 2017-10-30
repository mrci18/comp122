mov r1,#0
ldr r0,=StringFile

swi 0x66 ; open file
bcs Whoops

mov r3,r0 ; move file handle into R3

ldr r1,=InputString
mov r2,#101
swi 0x6a ; read string
bcs Whoops

ldr r1,=InputString ; not required
@ldr r0,[r1] ; doesn't work

ldrb r0,[r1]
cmp r0,#80 ; Check for 'P' with decimal
cmp r0,#0x50; Check for 'P' with hexadecimal
cmp r0,#'P; Check for 'P' with character

Whoops:
swi 0x11 ; Exit

.data

StringFile: .asciz "string.txt"
InputString: .skip 100
