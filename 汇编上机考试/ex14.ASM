DATA    SEGMENT
    BUF DB 100,?,100 DUP('$')
    STR1    DB  'The NUM of numbers is:','$'
    STR2    DB  'The NUM of letters is:','$'
    STR3    DB  'The NUM of space   is:','$'
DATA    ENDS

STACK   SEGMENT

STACK   ENDS

CODE    SEGMENT
    ASSUME  CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
    LEA DX,BUF
    MOV AH,0AH
    INT 21H
    LEA SI,BUF[2]
    MOV CL,BUF[1]
    MOV DL,0AH
    MOV AH,02H
    INT 21H
    MOV DL,0DH
    MOV AH,02H
    INT 21H
    MOV BX,0
CHECK_NUM:
    MOV AL,BUF[SI]
    CMP AL,'0'
    JB  AGAIN_NUM
    CMP AL,'9'
    JA  AGAIN_NUM
    INC BX
AGAIN_NUM:
    CMP CX,0
    JE  TONGJI_NUM
    INC SI
    DEC CX
    JMP CHECK_NUM
TONGJI_NUM:
    LEA DX,STR1
    MOV AH,09H
    INT 21H
    CALL    JIESHU
    MOV DL,0AH
    MOV AH,02H
    INT 21H
    MOV BX,0
    LEA SI,BUF[2]
    MOV CL,BUF[1]
CHECK_LETTER:
    MOV AL,BUF[SI]
    CMP AL,'A'
    JB  AGAIN_LETTER
    CMP AL,'Z'
    JA  CMPZ
    INC BX
    JMP AGAIN_LETTER
CMPZ:
    CMP AL,'a'
    JB  AGAIN_LETTER
    CMP AL,'z'
    JA  AGAIN_LETTER
    INC BX
AGAIN_LETTER:
    CMP CX,0
    JE  TONGJI_LETTER
    INC SI
    DEC CX
    JMP CHECK_LETTER
TONGJI_LETTER:
    LEA DX,STR2
    MOV AH,09H
    INT 21H
    CALL    JIESHU
    MOV DL,0AH
    MOV AH,02H
    INT 21H
    MOV BX,0
    LEA SI,BUF[2]
    MOV CL,BUF[1]

CHECK_SPACE:
    MOV AL,BUF[SI]
    CMP AL,' '
    JNE AGAIN_SPACE
    INC BX
AGAIN_SPACE:
    CMP CX,0
    JE  TONGJI_SPACE
    INC SI
    DEC CX
    JMP CHECK_SPACE
TONGJI_SPACE:
    LEA DX,STR3
    MOV AH,09H
    INT 21H
    CALL    JIESHU
    MOV AH,4CH
    INT 21H


JIESHU:
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

    RET
CODE    ENDS
    END     START 