
#include <16F876.h>

#fuses HS, NOPROTECT, NOLVP, NOBROWNOUT, NOWDT
#use delay(clock=20000000)
#use rs232(baud=2400, XMIT=PIN_C6, RCV=PIN_C7, bits=8, uart1)

#INT_RDA
void recepcion()   {
int c;
c=getch();
putc(c);
}

void main()   {
output_high(pin_c0);
delay_ms(2000);
output_low(pin_c0);

set_tris_c(0b10111111);
ENABLE_INTERRUPTS(INT_RDA);
ENABLE_INTERRUPTS(GLOBAL);
while(1){}

//while(TRUE){
//c=getch();
//if (c>=0x0A)//&&(c<=0x7A))//(((c>=0x20)&&(c<=0x7A))||((c==0x0A)||(c==0x0D)))
//{
   //putc(c);
//}
//}
}
