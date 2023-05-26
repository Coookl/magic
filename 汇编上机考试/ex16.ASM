DATA    SEGMENT
    STR1 DB  'Please enter number:$'
    STR2 DB  'INPUT WRONG!PLEASE RESTART EXERCISE!$'
    ONE DB  0
    TWO DB  0
    THR DB  0
DATA    ENDS

CODE    SEGMENT
    ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
    CALL    READCHAR
    MOV AH,4CH
    INT 21H
READCHAR:
    LEA DX,STR1
    MOV AH,09H
    INT 21H
    MOV DL,0ah
    MOV AH,02H
    INT 21h
    MOV DL,0DH
    MOV AH,02H
    INT 21H
    MOV CX,0
INPUT:
    MOV AH,01H
    INT 21H
    CMP AL,0DH
    JE  output
    CMP AL,'0'
    jb  ERROR
    CMP AL,'9'
    JA  ERROR
    INC CL
    jmp INPUT
ERROR:
    LEA DX,STR2
    MOV AH,09H
    INT 21H
    MOV DX,0ah
    MOV AH,02H
    INT 21h
    jmp exit
output:
    CMP CL,1
    JE  add1
    CMP CL,2
    JE  add2
    jmp add3
add1:
    inc ONE
    JMP WEISHU
add2:
    INC TWO
    JMP WEISHU
add3:
    INC THR
    JMP WEISHU
WEISHU:
    INC ch
    CMP CH,0ah
    JE  EXIT
    MOV CL,0
    JMP INPUT
EXIT:
    MOV DL,0ah
    MOV AH,02H
    INT 21h
    MOV DL,ONE
    add DL,30h
    MOV AH,02H
    INT 21h

    MOV DL,0ah
    MOV AH,02H
    INT 21h
    MOV DL,TWO
    add DL,30h
    MOV AH,02H
    INT 21h

    MOV DL,0ah
    MOV AH,02H
    INT 21h
    MOV DL,THR
    add DL,30h
    MOV AH,02H
    INT 21h

    MOV AH,4CH
    INT 21h
CODE    ENDS
    END START
    