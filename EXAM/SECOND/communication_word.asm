	.586

	DATA	SEGMENT	USE16
	;; 退格键是 08H
	TIP1	DB	0AH, 0DH, 'Please Enter Communication Word:_________', 9 DUP(08H), '$'
	;; ORIGINAL 是 密码
	ORIGINAL	DB	'123$%^[].'
	LEN1	DB	$-ORIGINAL ; ORIGINAL 的长度
	PSWORD	DB	255 DUP(0) ; 保存用户输入的字符
	COUNT	DB	3	   ; 次数
	IN_MESSAGE	DB	0AH, 0DH, 'Login Successfully', 0AH, 0DH, '$'
	OUT_MESSAGE	DB	0AH, 0DH, 'Login Failed', 0AH, 0DH, '$'
	DATA	ENDS

	CODE	SEGMENT	USE16
	ASSUME	CS:CODE,	DS:DATA,	ES:DATA
BEG:	MOV	AX,	DATA
	MOV	DS,	AX
	MOV	ES,	AX	; 数据段 与 附加段 重合

	;; 显示 TIP1
L1:	MOV	AH,	09H
	LEA	DX,	TIP1
	INT	21H

	;; BX 指向 PSWORD
	LEA	BX,	PSWORD

L2:	;; 输入字符到 AL, 不回显 不响应 C-c
	MOV	AH,	07H
	INT	21H

	CMP	AL,	0DH	; 比较字符是否是 换行符, 也就是 ENTER 键
	;; 是换行符跳到 L3
	JZ	L3

	;; 不是换行符
	;; 比较 AL 与 退格符
	CMP	AL,	08H
	;; 是退格符跳到 L4
	JZ	L4

	;; 不是退格符
	MOV	BYTE PTR [BX],	AL
	INC	BX
	CALL	STAR
	JMP	L2

	;; 是退格符
L4:	;; 读取光标当前的位置
	MOV	AH,	03H
	MOV	BH,	0
	INT	10H

	CMP	DL,	32	; 如果光标在冒号后边, 也就是密码的第一位
	JZ	L2

	DEC	BX
	PUSH	BX
	CALL	BACKSPACE
	MOV	AH,	02H
	MOV	DL, '_'
	INT	21H
	CALL	BACKSPACE
	POP	BX
	JMP	L2


	;; 是换行符
L3:	LEA	SI,	ORIGINAL ; SI 指向 源串
	LEA	DI,	PSWORD	 ; DI 指向 目标串
	MOV	CL,	LEN1	 ; 次数 放入 CX
	MOV	CH,	0
	;; 比较两个串, 不等则停下
	REPZ	CMPSB
	JZ	LOGIN		; 相等 跳到 EXIT
	;; 不等
	DEC	COUNT	; 次数-1
	CMP	COUNT, 0
	JZ	LOGOUT		; 次数为 0, 跳到 EXIT
	JMP	L1		; 次数不为 0, 跳到 L1

LOGIN:	MOV	AH,	09H
	LEA	DX,	IN_MESSAGE
	INT	21H
	JMP	EXIT

LOGOUT:	MOV	AH,	09H
	LEA	DX,	OUT_MESSAGE
	INT	21H

EXIT:	MOV	AH,	4CH
	INT	21H

	;; 显示 * 的程序, 破坏 AL
	STAR	PROC
	MOV	AH,	02H
	MOV	DL,	'*'
	INT	21H
	RET
	STAR	ENDP

	;; 退格
	BACKSPACE	PROC
	;; 读取光标当前的位置
	MOV	AH,	03H
	MOV	BH,	0
	INT	10H

	CMP	DL,	32
	JZ	REACHBEGIN
	DEC	DL		; 列号-1

	MOV	AH,	02H	; 移动光标
	INT	10H
REACHBEGIN:	RET
	BACKSPACE	ENDP

	CODE	ENDS
	END	BEG

