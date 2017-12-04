mov r0,#1
mov r1,#1
mov r2,#1000
swi 0x205 ;Display integer
BCS End

;Prompt user to press a blue button
PressBlue:
ldr r0,=PressB
swi 0x02
PressB: .asciz "Press one blue button\n"

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
cmp r0,#0
BEQ NotPressed

;Branch based on blue button display 8 segment display value 
A:
mov r0,#0xE7
swi 0x200
BAL PressBlack

B:
mov r0,#0x2F
swi 0x200
BAL PressBlack

C:
mov r0,#0x8D
swi 0x200
BAL PressBlack

D:
mov r0,#0x6E
swi 0x200
BAL PressBlack

E:
mov r0,#0x8F
swi 0x200
BAL PressBlack

F:
mov r0,#0x87
swi 0x200
BAL PressBlack

Zero:
mov r0,#0xED
swi 0x200
BAL PressBlack

One:
mov r0,#0x60
swi 0x200
BAL PressBlack

Two:
mov r0,#0xCE
swi 0x200
BAL PressBlack

Three:
mov r0,#0xEA
swi 0x200
BAL PressBlack

Four:
mov r0,#0x63
swi 0x200
BAL PressBlack

Five:
mov r0,#0xAB
swi 0x200
BAL PressBlack

Six:
mov r0,#0xAF
swi 0x200
BAL PressBlack

Seven:
mov r0,#0xE0
swi 0x200
BAL PressBlack

Eight:
mov r0,#0xEF
swi 0x200
BAL PressBlack

Nine:
mov r0,#0xE3
swi 0x200
BAL PressBlack

;Tell user to press button 
PressBlack:
ldr r0,=PressBLK
swi 0x02
PressBLK: .asciz "Press one black button\n"

Black:
swi 0x202
cmp r0,#0x02
beq Left
bal Right

Left:
mov r0,#0x02
swi 0x201 ;Left LED on
Bal Subtract

Right:
cmp r0,#0
BEQ NotPressed
mov r0,#0x01
swi 0x201 ;Right LED on
Bal Add

Subtract:
SUB r2,r2,#1
swi 0x205
BAL PressBlue

Add:
ADD r2,r2,#1
swi 0x205
BAL PressBlue

;Tell user that they did not press a button 
NotPressed:
ldr r0,=NPress
swi 0x02
NPress: .asciz "You didn't press a button so I have to exit\n"
BAL End

End:
swi 0x11
