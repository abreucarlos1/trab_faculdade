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
INICIO:     JB      P32,$
            ORL     PORTA1,#0F0H

            MOV     R1,#04H
            CLR     VM
T1:         LCALL   TEMPO
            DJNZ    R1,T1
            SETB    VM
            CLR     AM
            LCALL   TEMPO
            SETB    AM
            MOV     R1,#06
            CLR     VD
T2:         LCALL   TEMPO
            DJNZ    R1,T2
            SETB    VD
            SJMP    INICIO

TEMPO:      MOV     R0,#0AH
T3:         MOV     TH0,#3CAFH
            MOV     TL0,#3CAFH
            CLR     TF0
            SETB    TR0
            JNB     TF0,$
            CLR     TF0
            CLR     TR0
            DJNZ    R0,T3
            RET

            END


