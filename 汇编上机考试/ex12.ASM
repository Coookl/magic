DATA    SEGMENT
    STR1    DB  20,?,20 DUP('$')
    STR2    DB  20,?,20 DUP('$')
    STR3    DB  20,?,20 DUP('$')
DATA    ENDS

STACK   SEGMENT

STACK   ENDS

CODE    SEGMENT
    ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX

    LEA DX,STR1
    MOV AH,0AH
    INT 21H

    MOV DL,0AH
    MOV AH,02H
    INT 21H
    MOV DL,0DH
    MOV AH,02H
    INT 21H

    LEA DX,STR2
    MOV AH,0AH
    INT 21H

    MOV DL,0AH
    MOV AH,02H
    INT 21H
    MOV DL,0DH
    MOV AH,02H
    INT 21H

    MOV CX,0
    MOV CL,8
    MOV AX,0
    MOV SI,0009H
    MOV DI,0
    MOV AX,0
    MOV BX,0
    MOV DI,0
CALCULATE:
    MOV AL,STR1[SI]
    MOV BL,STR2[SI]
    SUB AL,30H
    SUB BL,30H
    CLC
    ADD AL,AH
    MOV AH,0
    ADC AL,BL
    AAA

    MOV STR3[DI],AL

    DEC CL
    CMP CX,0
    JE  OUTPUT
    DEC SI
    INC DI
    JMP CALCULATE
OUTPUT:
    MOV DL,STR3[DI]
    ADD DL,30H 
    MOV AH,02H
    INT 21H
    CMP DI,0
    JE  EXIT
    DEC DI
    JMP OUTPUT
EXIT:
    MOV AH,4CH
    INT 21H
CODE    ENDS
    END START