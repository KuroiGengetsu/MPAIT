;; FILENAME:	EXA131.ASM
.486
;; 数据段
DATA	SEGMENT	USE16 ; SEGMENT 打错了
SUM	DB	?,?	      ; 多了一个逗号
MESG	DB	'25+9='
	DB	0,0,'$'	; 少了 ,'$'
N1	DB	9	; F0H 多余
N2	DB	25	; 应该定义为字节, 而不是字
DATA	ENDS

;; 代码段
CODE	SEGMENT	USE16
	ASSUME	CS:CODE, DS:DATA

	;; 将数据段段首址送入 DS
BEG:	MOV	AX,	DATA
	MOV	DS,	AX
	;; 进行加法计算
	MOV	BX,	OFFSET	SUM
	MOV	AH,	N1
	MOV	AL,	N2
	ADD	AH,	AL
	MOV	[BX],	AH
	;; 调用子程序, 将十位、个位送入 MESG
	CALL	CHANG
	;; 显示字符串 MESG
	MOV	AH,	9
	MOV	DX,	OFFSET	MESG ; 打字错误, OFFSET MESG
	INT	21H
	;; 退出至 DOS
	MOV	AH,	4CH
	INT	21H
	;; 子程序 CHANG
CHANG	PROC			; 冒号多余
LAST:	CMP	BYTE PTR [BX],	10	; 少 PTR
	JC	NEXT
	SUB	BYTE PTR [BX],	10	; 少 PTR
	INC	BYTE PTR [BX+7]		; 少 PTR
	JMP	LAST
NEXT:	MOV	DH,	SUM
	ADD	BYTE PTR [BX+8],	DH	; 物理内存单元之间只能用串操作符操作, 或者用寄存器作中间变量
	ADD	BYTE PTR [BX+7],	30H		; 少 PTR
	ADD	BYTE PTR [BX+8],	30H		; 少 PTR
	RET
CHANG	ENDP			; 冒号多余
CODE	ENDS
	END	BEG

