;Charles Ibo
;Project 3

;Display 1000 on LED screen
mov r0,#1
mov r1,#1
mov r2,#1000
swi 0x205 ;Display integer

;Tell user to press button
PressBlack:
ldr r0,=PressBLK
swi 0x02
PressBLK: .asciz "Press black or blue button"

;Check whether user pressed left or right
Black:
swi 0x202
cmp r0,#0x02
BEQ Left
BAL Right

;Turn on left light
Left:
mov r0,#0x02
swi 0x201 ;Left LED on
mov r3,#2
cmp r0,#2
BEQ Blue

;Turn on right light
Right:
cmp r0,#0
BEQ Blue
mov r0,#0x01
swi 0x201 ;Right LED on
mov r3,#1
cmp r0,#1
BEQ Blue

;Associate blue buttons with 0-9 and A-F
Blue:
swi 0x203
cmp r0,#1
BEQ Zero

cmp r0,#2
BEQ One

cmp r0,#4
BEQ Two

cmp r0,#8
BEQ Three

cmp r0,#16
BEQ Four

cmp r0,#32
BEQ Five

cmp r0,#64
BEQ Six

cmp r0,#128
BEQ Seven

cmp r0,#256
BEQ Eight

cmp r0,#512
BEQ Nine

cmp r0,#1024
BEQ A

cmp r0,#2048
BEQ B

cmp r0,#4096
BEQ C

cmp r0,#8192
BEQ D

cmp r0,#16384
BEQ E

cmp r0,#32768
BEQ F
BAL Black

;cmp r0,#0
;BEQ NotPressed

;Branch based on blue button display 8 segment display value
;If r3 is 2 subtract
;If r3 is 1 add
;Else Loop back to black 
Zero:
mov r0,#0xED
swi 0x200
mov r7,#0
cmp r3,#2
BEQ Subtract
cmp r3,#1
BEQ Add
BAL Black

One:
mov r0,#0x60
swi 0x200
mov r7,#1
cmp r3,#2
BEQ Subtract
cmp r3,#1
BEQ Add
BAL Black

Two:
mov r0,#0xCE
swi 0x200
mov r7,#2
cmp r3,#2
BEQ Subtract
cmp r3,#1
BEQ Add
BAL Black

Three:
mov r0,#0xEA
swi 0x200
mov r7,#3
cmp r3,#2
BEQ Subtract
cmp r3,#1
BEQ Add
BAL Black

Four:
mov r0,#0x63
swi 0x200
mov r7,#4
cmp r3,#2
BEQ Subtract
cmp r3,#1
BEQ Add
BAL Black

Five:
mov r0,#0xAB
swi 0x200
mov r7,#5
cmp r3,#2
BEQ Subtract
cmp r3,#1
BEQ Add
BAL Black

Six:
mov r0,#0xAF
swi 0x200
mov r7,#6
cmp r3,#2
BEQ Subtract
cmp r3,#1
BEQ Add
BAL Black

Seven:
mov r0,#0xE0
swi 0x200
mov r7,#7
cmp r3,#2
BEQ Subtract
cmp r3,#1
BEQ Add
BAL Black

Eight:
mov r0,#0xEF
swi 0x200
mov r7,#8
cmp r3,#2
BEQ Subtract
cmp r3,#1
BEQ Add
BAL Black

Nine:
mov r0,#0xE3
swi 0x200
mov r7,#9
cmp r3,#2
BEQ Subtract
cmp r3,#1
BEQ Add
BAL Black

A:
mov r0,#0xE7
swi 0x200
mov r7,#10
cmp r3,#2
BEQ Subtract
cmp r3,#1
BEQ Add
BAL Black

B:
mov r0,#0x2F
swi 0x200
mov r7,#11
cmp r3,#2
BEQ Subtract
cmp r3,#1
BEQ Add
BAL Black

C:
mov r0,#0x8D
swi 0x200
mov r7,#12
cmp r3,#2
BEQ Subtract
cmp r3,#1
BEQ Add
BAL Black

D:
mov r0,#0x6E
swi 0x200
mov r7,#13
cmp r3,#2
BEQ Subtract
cmp r3,#1
BEQ Add
BAL Black

E:
mov r0,#0x8F
swi 0x200
mov r7,#14
cmp r3,#2
BEQ Subtract
cmp r3,#1
BEQ Add
BAL Black

F:
mov r0,#0x87
swi 0x200
mov r7,#15
cmp r3,#2
BEQ Subtract
cmp r3,#1
BEQ Add
BAL Black

;Subtract value from 8 segment display if digit and display on LED
Subtract:
mov r0,#1
mov r1,#1
SUB r2,r2,r7
swi 0x206
swi 0x205
BAL Black

;Add value from 8 segment display if digit and display on LED
Add:
mov r0,#1
mov r1,#1
ADD r2,r2,r7
swi 0x206
swi 0x205
BAL Black
