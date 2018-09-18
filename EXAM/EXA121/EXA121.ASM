;; 【例 1.1】 显示五行 HELLO
.486                                    ; 选择的处理器为 486

DATA    SEGMENT USE16                   ; USE16 定义了 16位 的 段
MESG    DB      'HELLO'                 ; MESG 为字节变量
        DB      0, 0, 0
DATA    ENDS

CODE    SEGMENT USE16
        ASSUME  CS:CODE, DS:DATA

BEG:    MOV     AX, DATA                ; 数据段首址 放入 AX
        MOV     DS, AX                  ; 数据段首址 放入 DS
        MOV     ES, AX                  ; 数据段首址 放入 ES
        MOV     CX, 5                   ; CX 变为 0005H
LL1:    MOV     MESG+5, 0DH             ; 往下不知道要干涉呢
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
