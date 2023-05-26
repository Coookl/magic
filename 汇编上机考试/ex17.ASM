DATA    SEGMENT
    STR1    DB  'Please Input Numbers:$'
    STR2    DB  'INPUT ERROR,PLEASE INPUT CORRECT NUMBER!$'
    STR3    DB  'The sum of numbers is:$'
    SUM     DW  0
    HEX     DB  'H','$'
DATA    ENDS

CODE    SEGMENT
    ASSUME  CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
INIT:
    LEA DX,STR1
    MOV AH,09H
    INT 21H
    MOV BX,0
INPUT:
    MOV AH,01H
    INT 21H
    CMP AL,'H'
    JE  SUMUP
    CMP AL,','
    JE  INPUT
    CMP AL,0DH
    JE  OUTPUT
    CMP AL,'0'
    JB  ERROR
    CMP AL,'9'
    JNA PRO
    CMP AL,'A'
    JB  ERROR
    CMP AL,'F'
    JA  ERROR
    SUB AL,07H
    JMP PRO
ERROR:
    MOV DL,0AH
    MOV AH,02H
    INT 21H

    LEA DX,STR2
    MOV AH,09H
    INT 21H

    MOV AH,4CH
    INT 21H
PRO:
    SUB AL,30H
    MOV AH,0
    XCHG    AX,BX
    MOV CX,10H
    MUL CX
    ADD BX,AX
    JMP INPUT
SUMUP:
    ADD SUM,BX
    MOV BX,0
    JMP INPUT
OUTPUT:
    MOV DL,0AH
    MOV AH,02H
    INT 21H
    LEA DX,STR3
    MOV AH,09H
    INT 21H
    MOV CL,04H
    MOV CH,04H
    MOV BX,SUM
SHIFT:
    ROL BX,CL
    MOV AL,BL
    AND AL,0FH
    ADD AL,30H
    CMP AL,'9'
    JNA PRINTF
    SUB AL,07H
PRINTF:
    MOV DL,AL
    MOV AH,02H
    INT 21H
    DEC CH
    CMP CH,0
    JE  EXIT
    JMP SHIFT
EXIT:
    LEA DX,HEX
    MOV AH,09H
    INT 21H
    MOV AH,4CH
    INT 21H
CODE    ENDS
    END START