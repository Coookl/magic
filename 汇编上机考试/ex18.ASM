DATA    SEGMENT
    BUFFER  DW  -25,-4,-23,-22,-21,0
    LEN     DB  $-BUFFER
    MAX     DW  8001H
    MIN     DW  7FFFH
    AVE     DW  0
    STR1    DB  'The maximum number:$'
    STR2    DB  'The minimum number:$'
    STR3    DB  'The average of num:$'
DATA    ENDS

STACK   SEGMENT

STACK   ENDS

CODE    SEGMENT
    ASSUME  CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
    MOV SI,0
MAXIMUM:
    MOV AX,BUFFER[SI]
    CMP AX,0
    JE  OUTPUT
    ADD SI,2
    CMP AX,MAX
    JL  MINIMUM
    MOV MAX,AX
MINIMUM:
    CMP AX,MIN
    JG  SUM
    MOV MIN,AX
SUM:
    ADD AVE,AX
    JMP MAXIMUM
OUTPUT:
    LEA DX,STR1
    MOV AH,09H
    INT 21H
    MOV DL,0AH
    MOV AH,02H
    INT 21H

OUTMAX:
    MOV BX,MAX
    CMP BX,0
    JNL  POUT
    MOV DL,'-'
    MOV AH,02H
    INT 21H
    NEG BL
POUT:
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

    LEA DX,STR2
    MOV AH,09H
    INT 21H
    MOV DL,0AH
    MOV AH,02H
    INT 21H

OUTMIN:
    MOV BX,MIN
    CMP BX,0
    JNL  IPOUT
    MOV DL,'-'
    MOV AH,02H
    INT 21H
    NEG BL
IPOUT:
IC1000:
    MOV AX,0
    MOV AL,BL
    MOV CL,100
    DIV CL
    MOV BH,AH
    CMP AL,0
    JE  IC100
    ADD AL,30H
    MOV DL,AL
    MOV AH,02H
    INT 21H
IC100:
    MOV AX,0
    MOV AL,BH
    MOV CL,10
    DIV CL
    MOV BH,AH
    CMP AL,0
    JE  IC1
    ADD AL,30H
    MOV DL,AL
    MOV AH,02H
    INT 21H
IC1:
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

    LEA DX,STR3
    MOV AH,09H
    INT 21H
    MOV DL,0AH
    MOV AH,02H
    INT 21H

OUTAVE:
    MOV BX,AVE
    MOV AX,BX
    MOV CL,5
    IDIV CL
    MOV BL,AL
    CMP BX,0
    JNL  EPOUT
    MOV DL,'-'
    MOV AH,02H
    INT 21H
    NEG BL
EPOUT:
EC1000:
    MOV AX,0
    MOV AL,BL
    MOV CL,100
    DIV CL
    MOV BH,AH
    CMP AL,0
    JE  EC100
    ADD AL,30H
    MOV DL,AL
    MOV AH,02H
    INT 21H
EC100:
    MOV AX,0
    MOV AL,BH
    MOV CL,10
    DIV CL
    MOV BH,AH
    CMP AL,0
    JE  EC1
    ADD AL,30H
    MOV DL,AL
    MOV AH,02H
    INT 21H
EC1:
    MOV AL,BH
    ADD AL,30H
    MOV DL,AL
    MOV AH,02H
    INT 21H

    MOV AH,4CH
    INT 21H


CODE    ENDS
    END START
