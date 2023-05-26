DATA    SEGMENT
    BUF DB  100,?,100 DUP('$')
    STR DB  100,?,100 DUP('$')
DATA    ENDS

CODE    SEGMENT
    ASSUME  CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
    LEA DX,BUF
    MOV AH,0AH
    INT 21H
    MOV DL,0AH
    MOV AH,02H
    INT 21H
    MOV DL,0DH
    MOV AH,02H
    INT 21H
    MOV SI,2
    MOV DI,0
CHECK:
    MOV AL,BUF[SI]
    CMP AL,'A'
    JE  LOADCC
    JMP LOADCO
LOADCC:
    MOV STR[DI],'C'
    INC DI
    MOV STR[DI],'C'
    INC DI
    JMP AGAIN
LOADCO:
    MOV STR[DI],AL
    INC DI
    JMP AGAIN
AGAIN:
    INC SI
    DEC CX
    CMP CX,0
    JE  OUTPUT
    JMP CHECK

OUTPUT:
    LEA DX,STR
    MOV AH,09H
    INT 21H
    MOV AH,4CH
    INT 21H
    
CODE    ENDS
    END START