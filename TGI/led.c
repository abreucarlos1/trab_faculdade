
/////////////////////////////////////////////////////////////
// PROGRAMA QUE PISCA UM LED CONECTADO AO PINO B1, COM UMA //
// FREQU�NCIA DE 1Hz                                       //
// CRIADO POR CARLOS ALBERTO GON�ALVES ABREU               //
// RGM 126749                                              //
// ENGENHARIA DA COMPUTA��O                                //
// 15/05/2005                                              //
/////////////////////////////////////////////////////////////


// Inclui a biblioteca do dispositivo a ser utilizado
#include <16f870.h>

// HABILITA OS FUSIVEIS DE PROGRAMA��O
#fuses XT,NOWDT,NOPROTECT

// DEFINE A FREQUENCIA DO CRISTAL UTILIZADO
// PARA PODER GERAR OS TEMPOS UTILIZADOS NO PROGRAMA
#use delay(clock=4000000)

// FUN��O PRINCIPAL
void main()
{
   
  // LOOP INFINITO 
  while(TRUE)
  {
      // COLOCA O PINO B1 EM NIVEL BAIXO (0)
      output_low(PIN_B1);
      
      // ESPERA 1000 MILESEGUNDOS (1 SEGUNDO)
      delay_ms(1000);
      
      // COLOCA O PINO B1 EM NIVEL ALTO (1)
      output_high(PIN_B1);
      
      // ESPERA 1000 MILESEGUNDOS (1 SEGUNDO)
      delay_ms(1000);    
  }


}
// FIM DA FUN��O PRINCIPAL

