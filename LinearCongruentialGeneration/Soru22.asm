datasg	SEGMENT BYTE 'veri'
X       	DW 0   ;sonucun tutulacagi yer 
m		DW 8191
a		DW 884
c		DW 1 
datasg		ENDS

stacksg		SEGMENT BYTE STACK 'yigin'
		DW 12 DUP(?)
stacksg		ENDS

codesg		SEGMENT PARA 'kod'
		ASSUME CS:codesg, DS:datasg, SS:stacksg
ANA		PROC FAR
		PUSH DS			; geri donus adreslerinin ayarlanmasi
		XOR AX, AX
		PUSH AX
		MOV AX, datasg		; data segment degerinin ayarlanmasi
		MOV DS, AX	
	
		MOV AX, cs:[23] 	; seed degeri / X0
		JMP atla
tekrar:		MOV AX, X
atla:		MUL a 
		ADD AX, c 
		DIV m
		MOV X, DX
		CMP X, 255
		JNB tekrar
	
		RETF
ANA		ENDP
codesg		ENDS
		END ANA
