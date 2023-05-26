DATA    SEGMENT
    BUF DB  38H,4AH,0C5H,83H,9CH,0B4H,7FH,0C4H,05H,0F5H
    SUM DW  0
    NEG_NUM DB  0
    STR1    DB  'The sum of the neg numbers is:$'
    STR2    DB  'The num of the neg numbers is:$'
DATA    ENDS

STACK   SEGMENT

STACK   ENDS

CODE    SEGMENT
    ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
    MOV SI,0
    MOV CX,0
    MOV CL,10
    MOV DX,0
CHECK:
    MOV AL,BUF[SI]
    INC SI
    CMP AL,0
    JL  FUSHU
    JMP ZHENGSHU
FUSHU:
    NEG AL
    MOV AH,0
    ADD DX,AX
    INC NEG_NUM
    DEC CL
    CMP CL,0
    JE  JIESHU
    JMP CHECK
ZHENGSHU:
    DEC CL
    CMP CL,0
    JE  JIESHU
    JMP CHECK
JIESHU:
    MOV BX,DX
    LEA DX,STR1
    MOV AH,09H
    INT 21H
    MOV DL,0AH
    MOV AH,02H
    INT 21H
    MOV DL,'-'
    MOV AH,02H
    INT 21H
    MOV DX,0
C1W:
    MOV AX,BX
    MOV CX,10000
    DIV CX
    MOV BX,DX
    CMP AX,0
    JE  C1K
    ADD AX,30H
    MOV DX,AX
    MOV AH,02H
    INT 21H
C1K:
    MOV DX,0
    MOV AX,BX
    MOV CX,1000
    DIV CX
    MOV BX,DX
    CMP AX,0
    JE  C1B
    ADD AX,30H
    MOV DX,AX
    MOV AH,02H
    INT 21H
    MOV DX,0
C1B:
    MOV DX,0
    MOV AX,BX
    MOV CX,100
    DIV CX
    MOV BX,DX
    CMP AX,0
    JE  CT
    ADD AX,30H
    MOV DX,AX
    MOV AH,02H
    INT 21H
    MOV DX,0
CT:
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
C1:
    MOV DX,0
    MOV AX,BX
    ADD AX,30H
    MOV DX,AX
    MOV AH,02H
    INT 21H
    MOV DL,0AH
    MOV AH,02H
    INT 21H
    MOV DL,0DH
    MOV AH,02H
    INT 21H
    LEA DX,STR2
    MOV AH,09H
    INT 21H

    MOV DL,0AH
    MOV AH,02H
    INT 21H
    MOV DL,0DH
    MOV AH,02H
    INT 21H
    ADD NEG_NUM,30H
    MOV DL,NEG_NUM
    MOV AH,02H
    INT 21H
    MOV AH,4CH
    INT 21H
CODE    ENDS
    END START