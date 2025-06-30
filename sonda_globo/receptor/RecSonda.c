
#include <16F876.h>

#fuses HS, NOPROTECT, NOLVP, NOBROWNOUT, NOWDT
#use delay(clock=20000000)
#use RS232(BAUD=4800, XMIT=PIN_C6, RCV=PIN_C7)

#INT_RDA
void recepcion()   {
int c;
output_high(pin_c0);
c=getch();
putc(c);
delay_ms(50);
//if(c=='o')
//{

//while (c!= 'O')
//{
//   c=getch();
//   putc(c);
//}
//}//if
output_low(pin_c0);
}//recepcion



void main()   {
output_low(pin_c0);
output_high(pin_c0);
set_tris_c(0b10111100);
delay_ms(2000);
output_low(pin_c0);
output_float(pin_c7);

ENABLE_INTERRUPTS(INT_RDA);
ENABLE_INTERRUPTS(GLOBAL);

while(TRUE){}

}
