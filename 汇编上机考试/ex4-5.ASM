DATAS SEGMENT
    BUF1 DB 'data,name,time,file,code,code,user,exit,quit,text','$'
    BUF2 DB 50,?,50 DUP('$')
    BUF3 DB 'disk'
DATAS ENDS

STACKS SEGMENT
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    
    LEA DX,BUF2
    MOV AH,0AH
    INT 21H
   
    MOV DL,0AH
	MOV AH,02H
	INT 21H

	MOV DL,0DH
	MOV AH,02H
	INT 21H
    
    MOV SI,0
    MOV DI,2
BIJIAOQI:
    CMP SI,45
    JE  JIESHU

    MOV AH,BUF1[SI]
    MOV AL,BUF2[DI]
    CMP AH,AL
    JNE YUAN

    MOV AH,BUF1[SI+1]
    MOV AL,BUF2[DI+1]
    CMP AH,AL
    JNE YUAN

    MOV AH,BUF1[SI+2]
    MOV AL,BUF2[DI+2]
    CMP AH,AL
    JNE YUAN    

    MOV AH,BUF1[SI+3]
    MOV AL,BUF2[DI+3]
    CMP AH,AL
    JNE YUAN 
    JMP HOU

YUAN:
    MOV DL,BUF1[SI]
    MOV AH,02H
    INT 21H

    MOV dl,buf1[si+1]
    MOV ah,02h
    INT 21H

    MOV dl,buf1[si+2]
    MOV ah,02h
    INT 21H

    MOV dl,buf1[si+3]
    MOV ah,02h
    INT 21H

    ADD si,5
    CMP si,45
    JE  JIESHU

    mov dx,','
    mov ah,02h
    int 21h

    JMP BIJIAOQI
HOU:
    ;MOV BUF1[SI],'d'
    ;MOV BUF1[SI+1],'i'
    ;MOV BUF1[SI+2],'s'
    ;MOV BUF1[SI+3],'k'
    ;JMP YUAN
    ADD SI,5
    CMP si,45
    JE  JIESHU
    JMP BIJIAOQI
JIESHU:
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
