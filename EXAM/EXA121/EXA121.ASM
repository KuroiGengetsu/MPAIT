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
        MOV     CX, 5                   ; CX 变为 0005H, 循环 5 次
LL1:    MOV     MESG+5, 0DH             ; 回车符
        MOV     MESG+6, 0AH		; 换行符
        MOV     MESG+7, '$'		; 美元符号
        CALL    DISP			; 调用 DISP 子程序
        MOV     MESG+5, 0		; 重置 这三个字符, 简直是智障一样的代码
        MOV     MESG+6, 0
        MOV     MESG+7, 0
        LOOP    LL1

	;; 返回至 DOS
        MOV     AH, 4CH
        INT     21H

DISP    PROC
	;; 显示字符串 MESG
        MOV     AH, 9
        MOV     DX, OFFSET MESG
        INT     21H
        RET
        DISP    ENDP
        CODE    ENDS
        END     BEG
