PORTA1      DATA    090H
KBD         EQU     0FFF4H
INT0        BIT     0A8H
P32         BIT     0B2H
VM          BIT     094H
AM          BIT     095H
VD          BIT     096H
;
            ORG     7000H

            CLR     INT0
            MOV     DPTR,#KBD
VOLTA:      JB      P32,$
            MOVX    A,@DPTR

            JZ     INICIO
            SJMP   FIM

INICIO:     CLR     VM
            MOV     R0,#07EH
VM3:        MOV     R1,#255H
VM2:        MOV     R2,#255H
VM1:        DJNZ    R2,VM1
            DJNZ    R1,VM2
            DJNZ    R0,VM3
            SETB    VM

            CLR     AM
            MOV     R0,#01FH
VA3:        MOV     R1,#255H
VA2:        MOV     R2,#255H
VA1:        DJNZ    R2,VA1
            DJNZ    R1,VA2
            DJNZ    R0,VA3
            SETB    AM

            CLR     VD
            MOV     R0,#0BDH
VD3:        MOV     R1,#255H
VD2:        MOV     R2,#255H
VD1:        DJNZ    R2,VD1
            DJNZ    R1,VD2
            DJNZ    R0,VD3
            SETB    VD

            SJMP    VOLTA

FIM:        ORL     PORTA1,#0F0H
            SETB    INT0
            RET
            END


