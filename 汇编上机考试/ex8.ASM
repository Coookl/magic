DATA    SEGMENT
   
DATA    ENDS

CODE    SEGMENT
    ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
    MOV BX,0
INPUT:
    MOV AH,01H
    INT 21H
    MOV AH,0
    SUB AL,30H
    CMP AL,0
    JB  EXIT
    CMP AL,1
    JA  EXIT
    MOV AH,0
    XCHG    AX,BX
    MOV CX,2
    MUL CX
    ADD BX,AX
    JMP INPUT
EXIT:
    MOV DL,0DH
    MOV AH,02H
    INT 21H
    MOV CH,04H
OUTPUT:
    MOV CL,04H
    ROL BX,CL
    MOV AL,BL
    AND AL,0FH
    ADD AL,30H
    CMP AL,'9'
    JNA PRINTF
    ADD AL,07H
PRINTF:
    MOV DL,AL
    MOV AH,02H
    INT 21H
    DEC CH
    CMP CH,0
    JE  JIESHU
    JMP OUTPUT
JIESHU:
    MOV AH,4CH
    INT 21H
CODE    ENDS
    END START