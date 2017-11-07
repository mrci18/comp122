;Charles Ibo
;Comp 122/L
;Project 2

;Open File
mov r1,#0
ldr r0,=StringFile

swi 0x66	;open file
bcs ExitFile

;Store file handle
mov r3,r0 	;store file handle in r3
mov r0,r3	;move file handle into r0

;Read input.txt
ldr r1,=InputString
mov r2,#256
swi 0x6a 	;read string

;Check if input.txt has characters
cmp r0,#0	;No characters read means EOF
beq ExitNoChar

;Loop to see if input.txt has a lowercase, uppercase, forward slash, space, apostraphe, and comma
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
cmp  r2, #47
beq  count
cmp  r2, #32
beq  copy
cmp  r2, #39
beq  copy
cmp  r2, #44
beq  copy

;Check if there has been two consecutive forward slashes
count:
add  r6,r2,r6
cmp  r6, #94
beq  double
cmp  r6, #47
beq  skip

;Remove first slash and indent to a new line
double:
mov  r2,#32
strb r2, [r1], #1
mov  r2,#10
strb r2, [r1], #1
mov  r6,#0
cmp  r6,#0
beq  skip

;Subtract 32 and make letter uppercase
lower:
sub  r2, r2, #32

;Place in output.txt
copy:
strb r2, [r1], #1

;Check next position in input.txt
skip:
add  r0, r0, #1
bal  charloop

;Print what we gathered
endofstring: 
mov r1,#1
ldr r0,=OutputFile

swi 0x66	;Open output file
bcs ExitFinal

ldr r1,=InputString

swi 0x69	;print string to file
bcs ExitFinal

;Message saying no characters in file:
ExitNoChar:
ldr r0,=exitNoChar
swi 0x02
exitNoChar: .asciz "There are no characters in input.txt"
B ExitFinal

;Message saying there was no file found:
ExitFile:
ldr r0,=MyString
swi 0x02
MyString: .asciz "File not found, please create file before continuing"

ExitFinal:
ldr r0,=Output
swi 0x02
Output: .asciz "Your string has been printed in an output.txt file"
swi 0x11	;Exit


.data
StringFile: .asciz "input.txt"
OutputFile: .asciz "output.txt"
InputString: .skip 255
