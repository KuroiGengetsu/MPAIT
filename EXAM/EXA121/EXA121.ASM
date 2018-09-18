;; 【例 1.1】 显示五行 HELLO
.486

DATA    SEGMENT USE16
MESG    DB      'HELLO'
        DB      0, 0, 0
DATA    ENDS

CODE    SEGMENT USE16
        ASSUME  CS:CODE, DS:DATA

BEG:    MOV     AX, DATA
        MOV     DS, AX
        MOV     ES, AX
        MOV     CX, 5
LL1:    MOV     MESG+5, 0DH
        MOV     MESG+6, 0AH
        MOV     MESG+7, '$'
        CALL    DISP
        MOV     MESG+5, 0
        MOV     MESG+6, 0
        MOV     MESG+7, 0
        LOOP    LL1
        MOV     AH, 4CH
        INT     21H
DISP    PROC
        MOV     AH, 9
        MOV     DX, OFFSET MESG
        INT     21H
        RET
        DISP    ENDP
        CODE    ENDS
        END     BEG
