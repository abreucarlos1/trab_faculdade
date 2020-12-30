#include <16F870.h>
#include <math.h>


#use delay(clock=4000000)
#include <lcd.c>

int d,count;
int16 tempo,total;
float dist;

#int_TIMER1
void isr_timer()
{
   d++;
   if(d>100)
   {
      total = dist / count;
      lcd_gotoxy(1,2);
      printf(lcd_putc,"\f%lu cm",total);
      dist = 0;
      count = 0;
      delay_ms(1000);
   }
   set_timer1(0);
}



void main()
{
   output_low(PIN_b3);
   lcd_init();
   lcd_gotoxy(1,1);
   printf(lcd_putc,"\fInicializando...");
   delay_ms(1000);
   setup_timer_1 (T1_INTERNAL|T1_DIV_BY_1);
   tempo = 0;
   dist = 0;
   d = 0;
   count = 0;
   total = 0;
   ext_int_edge( H_TO_L );
   //enable_interrupts(int_RB);
   enable_interrupts(int_timer1);
   enable_interrupts(GLOBAL);
   //set_timer1(0);
   while (TRUE)
   {
      output_high(PIN_B3);
      delay_us(10);
      output_low(PIN_b3);
      set_timer1(0);
      if(!input(PIN_B0))
      {
         count++;
         disable_interrupts(int_timer1);
         tempo = get_timer1();
         dist = dist + (tempo * 334000)/20;
         //dist = (tempo * 334000) / 20;
         //dist = dist * 0.000001;
         //tempo = ceil(dist);
         //tempo = tempo - 5;
         //total = total + tempo;
        // total = total / count;
        // lcd_gotoxy(1,2);
        // printf(lcd_putc,"\f%lu cm",total);
        // delay_ms(2000);
         enable_interrupts(int_timer1);
         enable_interrupts(GLOBAL);
         //set_timer1(0);
      }
   /*
      else
      {
         if(d>=600)
         {
            lcd_gotoxy(1,2);
            printf(lcd_putc,"\fFora de Alcance");
            d = 0;
            count = 0;
            total = 0;
            set_timer1(0);
         }
      }
      */

    }

}
