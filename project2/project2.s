mov r1,#0
ldr r0,=StringFile

swi 0x66	;open file
bcs Whoops

mov r3,r0 	;store file handle in r3

mov r0,r3	;move file handle into r0
ldr r1,=InputString
mov r2,#256
swi 0x6a 	;read string
bcs Whoops

ldrb r0,[r1]
cmp r0,#0	;No characters read means EOF
bcs Whoops

ldr r0,=InputString
mov
cmp r0,#80 ; Check for 'P' with decimal
cmp r0,#0x50; Check for 'P' with hexadecimal
cmp r0,#'P; Check for 'P' with character

mov r1,#1
ldr r0,=OutputFile

swi 0x66	;Open output file
bcs Whoops

ldr r1,=InputString

swi 0x69	;print string to file
bcs Whoops

Whoops:
swi 0x11	;Exit


.data
StringFile: .asciz "input.txt"
OutputFile: .asciz "output.txt"
InputString: .skip 255
