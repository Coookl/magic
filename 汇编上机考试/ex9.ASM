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
    MOV DX,0
    MOV AX,BX
    MOV CX,10000
    DIV CX
    MOV BX,DX
    ADD AX,30H
    MOV DX,AX
    MOV AH,02H
    INT 21H

    MOV DX,0
    MOV AX,BX
    MOV CX,1000
    DIV CX
    MOV BX,DX
    ADD AX,30H
    MOV DX,AX
    MOV AH,02H
    INT 21H

    MOV DX,0
    MOV AX,BX
    MOV CX,100
    DIV CX
    MOV BX,DX
    ADD AX,30H
    MOV DX,AX
    MOV AH,02H
    INT 21H

    MOV DX,0
    MOV AX,BX
    MOV CX,10
    DIV CX
    MOV BX,DX
    ADD AX,30H
    MOV DX,AX
    MOV AH,02H
    INT 21H

    MOV DX,0
    MOV AX,BX
    MOV CX,1
    DIV CX
    MOV BX,DX
    ADD AX,30H
    MOV DX,AX
    MOV AH,02H
    INT 21H
JIESHU:
    MOV AH,4CH
    INT 21H
CODE    ENDS
    END START