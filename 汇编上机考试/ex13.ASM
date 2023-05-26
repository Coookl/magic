DATA    SEGMENT
    BUF DB  100,?,100 DUP('$')
    BUFNO   DB  'NONONO!','$'
    BUFYES  DB  'YESYESYES!','$'
    LEN DB  $-BUF
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
    MOV CH,0
    MOV BX,CX
    ADD BX,001H
    MOV DL,0AH
    MOV AH,02H
    INT 21H
    MOV DL,0DH
    MOV AH,02H
    INT 21H
CHECK:
    MOV AX,[SI]
    MOV DX,[BX]
    CMP AL,DL
    JNE NO

    MOV AX,SI
    CMP AX,BX
    JE  YES
    SUB AX,01H
    CMP AX,BX
    JE  YES
    INC SI
    DEC BX
    JMP CHECK
NO:
    LEA DX,BUFNO
    MOV AH,09H
    INT 21H
    JMP JIESHU
YES:    
    LEA DX,BUFYES
    MOV AH,09H
    INT 21H
    JMP JIESHU
JIESHU:
    MOV AH,4CH
    INT 21H
CODE    ENDS
END START