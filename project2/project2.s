mov r1,#0
ldr r0,=StringFile

swi 0x66	;open file
bcs Whoops

mov r3,r0 	;store file handle in r3
mov r0,r3	;move file handle into r0

;Read input.txt
ldr r1,=InputString
mov r2,#256
swi 0x6a 	;read string
bcs Whoops

;Check if input.txt has characters
;cmp r0,#0	;No characters read means EOF
;bcs Whoops

charloop:
ldrb r2, [r1]
cmp  r2, #0
beq  endofstring
cmp  r2, #'z'
bgt  skip
cmp  r2, #'a'
bge  lower
cmp  r2, #'Z'
bgt  skip
cmp  r2, #'A'
bge  copy
;cmp  r2, #' '
;beq  copy
;bal  skip

lower:
sub  r2, r2, #32

copy:
strb r2, [r1], #1

skip:
add  r0, r0, #1
bal  charloop

;ldrb r0,[r1]
;cmp r0,#80 ; Check for 'P' with decimal
;cmp r0,#0x50; Check for 'P' with hexadecimal
;cmp r0,#'P; Check for 'P' with character

endofstring: 
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
