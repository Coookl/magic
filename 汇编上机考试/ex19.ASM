DATA    SEGMENT
    BUFFER  DW  -2,-1,-10,4,21,10,32,-1,2
    LEN     DB  $-BUFFER
DATA    ENDS

STACK   SEGMENT

STACK   ENDS

CODE    SEGMENT
    ASSUME  CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
    MOV SI,0
    MOV CX,0
    MOV CH,LEN
CHECK:
    CMP CH,0
    JE  EXIT
    MOV AX,BUFFER[SI]
    CMP AX,0
    JL  ABS
    ADD SI,2
    SUB CH,2
    JMP CHECK
ABS:
    MOV BX,AX
    NEG BL
C1000:
    MOV AX,0
    MOV AL,BL
    MOV CL,100
    DIV CL
    MOV BH,AH
    CMP AL,0
    JE  C100
    ADD AL,30H
    MOV DL,AL
    MOV AH,02H
    INT 21H
C100:
    MOV AX,0
    MOV AL,BH
    MOV CL,10
    DIV CL
    MOV BH,AH
    CMP AL,0
    JE  C1
    ADD AL,30H
    MOV DL,AL
    MOV AH,02H
    INT 21H
C1:
    MOV AL,BH
    ADD AL,30H
    MOV DL,AL
    MOV AH,02H
    INT 21H

    MOV DL,0AH
    MOV AH,02H
    INT 21H
    MOV DL,0DH
    MOV AH,02H
    INT 21H

    ADD SI,2
    SUB CH,2
    JMP CHECK
EXIT:
    MOV AH,4CH
    INT 21H
CODE    ENDS
    END START