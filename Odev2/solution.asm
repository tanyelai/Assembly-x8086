datasg		SEGMENT BYTE 'veri'
n			DW 10
datasg		ENDS

stacksg		SEGMENT BYTE STACK 'yigin'
			DW 300 DUP(?)
stacksg		ENDS

codesg		SEGMENT PARA 'kod'
			ASSUME CS:codesg, DS:datasg, SS:stacksg
ANA			PROC FAR
			PUSH DS				; geri donus adreslerinin ayarlanmasi
			XOR AX, AX
			PUSH AX
			MOV AX, datasg		; data segment degerinin ayarlanmasi
			MOV DS, AX	
			
			PUSH n
			CALL FAR PTR CONWAY
			POP DX
			CALL NEAR PTR PRINTINT
			
			RETF
ANA 		ENDP

PRINTINT    PROC NEAR
			ADD DL, 48
			MOV AH, 2
			INT 21h
			
			RET
PRINTINT	ENDP
			
CONWAY		PROC FAR
			
			PUSH BP
			MOV BP, SP
			PUSH AX
			MOV AX, [BP+6]
			
			CMP AX, 1
			JE islem
			CMP AX, 2
			JE islem
			
			PUSH BX
			PUSH CX
			PUSH DX
			
			MOV BX, AX
			DEC BX
			PUSH BX
			
			CALL CONWAY					
			POP DX
			
			MOV BX, AX
			SUB BX, DX
			PUSH BX
			
			CALL CONWAY
			POP CX
			
			PUSH DX
			CALL CONWAY
			POP BX
			
			ADD BX, CX
			MOV [BP+6], BX
			
			POP DX				
			POP CX
			POP BX		
			JMP atla
			
islem:  	MOV WORD PTR [BP+6], 1
atla:		POP AX
			POP BP
			RETF
CONWAY		ENDP

codesg		ENDS
			END ANA