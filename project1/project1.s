;Charles Ibo
;Comp 122/L
;Project 1
;test commit 1

;Open file:
ldr r0,=MyFile 
swi 0x66 	;open file
bcs ExitFile 	;Exit File

;Store file handle and read first int:
mov r9,r0 	;store file handle in r9
swi 0x6c 	;read int from file
bcs ExitNoInt	;exit if there is no integer found

;Store x integer in r2 and count occurences of x in r6:  
ADD r6,r6,#1	; first occurance of x
mov r2,r0 	; move x to r2

mov r0, r9 	;recall file handle from r9
swi 0x6c 	;read next int
bcs Exitx	;exit if there is no integer found after x

;Store y integer in r3 and count if x occurs
mov r3,r0	;Move y to r3
CMP r2,r3 	;If next int is equal to R1
ADDEQ r6,r6,#1 	;Counter if x occurs

;Count if y is less than x:
CMP r2,r3 	;Compare y with x
ADDLT r8,r8,#1  ;Counter if y is less than x

mov r0, r9 ;recall file handle from r9
swi 0x6c ; read next int
bcs Exity	;exit if there is no integer found after y

;Count if x occurs in next int, if next int = y, read the next in and loop:
Loop:
CMP r0,r2 ; If next int is equal to R1
ADDEQ r6,r6,#1 ; Counter if x occurs

CMP r0,r3
ADDLT r8,r8,#1

mov r0, r9 ;recall file handle from r9
swi 0x6c ; read next int

BCS ExitLoop

B Loop

ExitLoop:
swi 0x68	;Close the file

;Stdout string saying what x is:
ldr r0,=x
swi 0x02
x: .asciz "The first integer value x: "
mov r0,#1	
mov r1,r2
swi 0x6b
mov r0,#'\n
swi 0x00

;Stdout string saying what y is:
ldr r0,=y
swi 0x02
y: .asciz "The second integer y: "
mov r0,#1	
mov r1,r3
swi 0x6b
mov r0,#'\n
swi 0x00

;Stdout string saying number occurence of x:
ldr r0,=xOccur
swi 0x02
xOccur: .asciz "The number of occurrences of x: "
mov r0,#1	
mov r1,r6
swi 0x6b
mov r0,#'\n
swi 0x00

;Stdout string saying number of integers less than y:
ldr r0,=yLess
swi 0x02
yLess: .asciz "The number of integers less than y: "
mov r0,#1	
mov r1,r8
swi 0x6b
mov r0,#'\n
swi 0x00

B ExitFinal
mov r0,r9

;Message saying no integers in file:
ExitNoInt:
ldr r0,=exitNoInt
swi 0x02
exitNoInt: .asciz "There are no integers in file"
B ExitFinal

;Message saying no integers in file after x:
Exitx:
ldr r0,=exitx
swi 0x02
exitx: .asciz "There are no integers after integer x"
B ExitFinal

;Message saying no integers in file after y:
Exity:
ldr r0,=exity
swi 0x02
exity: .asciz "There are no integers after integer y"
B ExitFinal

;Message saying there was no file found:
ExitFile:
ldr r0,=MyString
swi 0x02
MyString: .asciz "File not found, please create file before continuing"

ExitFinal:
swi 0x11 	;Final exit

.data
MyFile: .asciz "integers.dat" ;\0 after string
