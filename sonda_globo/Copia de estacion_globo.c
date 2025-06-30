//#include <16F876.h>
#include <18F248.h>
#device ADC=10
#fuses HS,NOBROWNOUT,NOWDT,NOPUT,NOPROTECT,NOLVP
#use delay(clock=20000000)
#use i2c(master,sda=PIN_b6, scl=PIN_b7)
//#include <lcd_pc.c>
#include <24256est.c>
#use rs232(baud=9600, xmit=PIN_b4, rcv=PIN_b5, bits=8)
//#use rs232(baud=9600, xmit=PIN_c3, rcv=PIN_c2, bits=8)
#include <stdlib.h>



int segundos,minutos,horas,num_dia,dia,mes,anio,configurado;
int a;//entero auxiliar
int16 no_pulsos;
int16 lectura_pulsos,pulsos_min;
int imprime,cuenta_seg;
long dir_mem;
long cuenta_min,minutos_muestra;
long analogico0,analogico1,analogico2;//guarda lecturas instantaneas de canales ad
long lectura_ad0,lectura_ad1,lectura_ad2;//guarda lecturas acumuladas de canales ad
long promedio_min0,promedio_min1,promedio_min2;//guarda el promedio de N minutos

#INT_EXT1
void ANEMOMETRO()
{
 no_pulsos++;//lleva cuenta de pulsos
}//FIN ANEMOMETRO

#INT_ext

void LECTURA()//rutina de lectura de sensores
{
//*********************************//
//********Lectura de reloj*********//
//*********************************//
   i2c_start();
   i2c_write(0b11010000);      //byte de control del reloj, con escritura
   i2c_write(0);
   i2c_stop();            //inicializando el puntero a la direccion cero

   i2c_start();
   i2c_Write(0b11010001);      //byte de control del reloj, con lectura
   segundos=i2c_read();      //Lectura de todos los registros
   minutos=i2c_read();         //del reloj
   horas=i2c_read();
   num_dia=i2c_read();
   dia=i2c_read();
   mes=i2c_read();
   anio=i2c_read(0);
   i2c_stop();
   imprime=1;
//*********************************//
//**Lectura de canales analogicos**//
//*********************************//
//Canal 1
   set_adc_channel(0);
   delay_us(20);
   analogico0=READ_ADC();
   lectura_ad0=lectura_ad0+analogico0;
//Canal 2
   set_adc_channel(1);
   delay_us(20);
   analogico1=READ_ADC();
   lectura_ad1=lectura_ad1+analogico1;
//Canal 3
   set_adc_channel(2);
   delay_us(20);
   analogico2=READ_ADC();
   lectura_ad2=lectura_ad2+analogico2;

//***********************************//
//******** Lectura de Pulsos*********//
//***********************************//
   lectura_pulsos=lectura_pulsos+no_pulsos;

//***********************************//
//******** Realiza promedios*********//
//***********************************//

   cuenta_seg++;
   if(segundos==0&&(cuenta_seg!=0))
   {
   //Realiza promedio cada minuto
      promedio_min0=promedio_min0+(lectura_ad0/cuenta_seg);
      promedio_min1=promedio_min1+(lectura_ad1/cuenta_seg);
      promedio_min2=promedio_min2+(lectura_ad2/cuenta_seg);
      pulsos_min=pulsos_min+(lectura_pulsos/cuenta_seg);
      lectura_ad0=0;//Reinicio variables acumulativas
      lectura_ad1=0;
      lectura_ad2=0;
      pulsos_min=0;
      cuenta_seg=0;
      cuenta_min++;

      if (cuenta_min==minutos_muestra)//Realiza el promedio cada N minutos deseados; N=minutos muestra
      {
         promedio_min0=promedio_min0/minutos_muestra;
         promedio_min1=promedio_min1/minutos_muestra;
         promedio_min2=promedio_min2/minutos_muestra;
         pulsos_min=pulsos_min/minutos_muestra;
         a=promedio_min0;//evito guardar un 0xff**revisar utilidad
         if (a==0xff)
            promedio_min0++;

//********************************//
//********************************//
//******Guardando los datos ******//
//******  en EEPROM         ******//
//********************************//
//********************************//
         write_ext_eeprom(dir_mem,dia);
         write_ext_eeprom(dir_mem,dia);
         dir_mem++;
         write_ext_eeprom(dir_mem,mes);
         dir_mem++;
         write_ext_eeprom(dir_mem,anio);
         dir_mem++;
         write_ext_eeprom(dir_mem,horas);
         dir_mem++;
         write_ext_eeprom(dir_mem,minutos);
         dir_mem++;
         write_ext_eeprom(dir_mem,segundos);
         dir_mem++;
         write_ext_eeprom(dir_mem,promedio_min0>>8);
         dir_mem++;
         write_ext_eeprom(dir_mem,promedio_min0);
         dir_mem++;
         write_ext_eeprom(dir_mem,promedio_min1>>8);
         dir_mem++;
         write_ext_eeprom(dir_mem,promedio_min1);
         dir_mem++;

         write_ext_eeprom(dir_mem,promedio_min2>>8);
         dir_mem++;
         write_ext_eeprom(dir_mem,promedio_min2);
         dir_mem++;
         write_ext_eeprom(dir_mem,0xff);
         //Reinicio promedios por minuto y cuenta de minutos
         promedio_min0=0;
         promedio_min1=0;
         promedio_min2=0;
         pulsos_min=0;
         cuenta_min=0;
   


      }//if min

   }//if seg
   
}//fin lectura

//*******************************************//
//*****Escritura de flotante en eeprom*******//
//*******************************************//

void WRITE_FLOAT_EXT_EEPROM(long int n, float data) {
   int i;

   for (i = 0; i < 4; i++) 
      write_ext_eeprom(i + n, *(&data + i) ) ; 
}

//*******************************************//
//******lectura de flotante en eeprom********//
//*******************************************//

float READ_FLOAT_EXT_EEPROM(long int n) {
   int i; 
   float data;

   for (i = 0; i < 4; i++) 
      *(&data + i) = read_ext_eeprom(i + n);

   return(data); 
}

int miputc(byte caracter)
{
   long tiempo,t_respuesta;
   char respuesta;
   int num_nores;
   tiempo=0;
   respuesta=0;
   num_nores=0;
   t_respuesta=50000;//no. de ciclos a realizar
   while (respuesta!='b')
   {
      putc(caracter);
      while ((!kbhit())&&(tiempo<50000))
      {
         delay_us(10);
         tiempo++;
      }

      if (kbhit())
      {
         respuesta= getch();
         if (respuesta=='e')
            return (1);
         else
            respuesta='b';
      }
   
   }//fin while
   return (0);

}//fin miputc

float lee_cadena(void)//lee una cadena enviada desde rs232 y lo transforma en flotante
{      // el caracter de fin de cadena es @
byte tempo1;
char tempo[20];
int contador;
float resultado;

tempo1=48;
contador=0;
while(tempo1!='@')
   {
   if (kbhit())
      {
      tempo1=getch();
      tempo[contador]=tempo1;
      contador++;
      }
   }

resultado=atof(tempo);
return(resultado);
}

int cadena_ent(char *cadena)// transforma una cadena en un entero
{                     
   long potencia;
   int ex,valor,a;
   char *ini_cadena;
   int resultado;
   ini_cadena=cadena;
   resultado=0;

      while(*cadena>47&&*cadena<58)
      {
//      printf(lcd_putc,"%c",*cadena);
      cadena++;
   }
//   delay_ms(1000);
   cadena--;
   for(ex=0;cadena>=ini_cadena;ex++,cadena--)
   {
      valor=((*cadena)-48);
      potencia=1;
      for(a=0;a<ex;a++)
         potencia=potencia*10;
      resultado=resultado+((valor)*(potencia));
   }

return (resultado);
}//fin cadena ent

int lee_cadena_ent(void)//lee una cadena enviada desde rs232 y lo transforma en entero
{      // el caracter de fin de cadena es @
byte tempo1;
char tempo[20];
int contador;
int resultado;

tempo1=48;
contador=0;
while(tempo1!=0)
   {
   if (kbhit())
      {
      tempo1=getch();
      if (tempo1=='@')
         tempo1=0;
      tempo[contador]=tempo1;
      contador++;
      }
   }

resultado=cadena_ent(tempo);
return(resultado);
}


void main (){

int      car_fin;
int32  t_espera;
char   caracter_r;
float  mul0,mul1,mul2,mul3;
float  offset1,offset2,offset0,offset3;

//////////////////////////////////////////////////
////////   || |\\ || || //---  || ||--||  ////////
////////   || ||\\|| || ||     || ||  ||  ////////
////////   || || \\| || ||___  || ||--||  ////////
//////////////////////////////////////////////////

//******************************************//
//******************************************//
//********INICIO del programa***************//
//******************************************//
//******************************************//
//////////////////////////////////////////////
      delay_ms(1000);
//      lcd_init();
  //    lcd_putc("\fIniciando...");

      caracter_r=64;
      t_espera=0;
//      lcd_putc("\fBuscando PC...");
     port_b_pullups (false);

      output_float(pin_c0);
      //set_tris_b(0b11101111);
      output_high(pin_c5);
      while (t_espera++<500000)//busca conexion durante 5 seg
      {
      delay_us(10);
      if (kbhit())
         {
         caracter_r= getc();
         t_espera=500000;
         }
      }
      output_low(pin_c5);
//while(true)
//{
//caracter_r= getc();
//putc (caracter_r);
//}
      //printf(lcd_putc,"\f %c",caracter_r);
      if (caracter_r=='s')      //Si hay conexión
      {                     //REaliza esta rutina
         //Lcd_putc("\nPC encontrada...");
         putc('s');
         caracter_r= getc();
         switch (caracter_r){
         case 't':            //Si se recibe "t" se envian datos de la memoria
               dir_mem=1;
               mul0=READ_FLOAT_EXT_EEPROM(dir_mem);
               dir_mem=dir_mem+4;
               offset0=READ_FLOAT_EXT_EEPROM(dir_mem);
               dir_mem=dir_mem+4;

               mul1=READ_FLOAT_EXT_EEPROM(dir_mem);
               dir_mem=dir_mem+4;
               offset1=READ_FLOAT_EXT_EEPROM(dir_mem);
               dir_mem=dir_mem+4;

               mul2=READ_FLOAT_EXT_EEPROM(dir_mem);
               dir_mem=dir_mem+4;
               offset2=READ_FLOAT_EXT_EEPROM(dir_mem);
               dir_mem=dir_mem+4;

               mul3=READ_FLOAT_EXT_EEPROM(dir_mem);
               dir_mem=dir_mem+4;
               offset3=READ_FLOAT_EXT_EEPROM(dir_mem);
               dir_mem=dir_mem+4;

               dir_mem=64;
               car_fin=0;
               //Lcd_putc("\fEnviando...");
               while(car_fin!=0xff){

                  //envia dia
                     printf(miputc,"%X/",read_ext_eeprom(dir_mem));
                     dir_mem++;
                  //envia mes
                     printf(miputc,"%X/",read_ext_eeprom(dir_mem));
                     dir_mem++;
                  // envia año
                     printf(miputc,"%X ",read_ext_eeprom(dir_mem));
                     dir_mem++;
                  //envia hora
                     printf(miputc,"%X:",read_ext_eeprom(dir_mem));
                     dir_mem++;
                  //envia minutos
                     printf(miputc,"%X:",read_ext_eeprom(dir_mem));
                     dir_mem++;
                  //envia segundos
                     printf(miputc,"%X ",read_ext_eeprom(dir_mem));
                     dir_mem++;
                  //envia canal0
                     promedio_min0=0;
                     promedio_min0=read_ext_eeprom(dir_mem);
                     promedio_min0=promedio_min0<<8;
                     dir_mem++;
                     promedio_min0=promedio_min0+read_ext_eeprom(dir_mem);
                     printf(miputc,"%2.2f ",(promedio_min0*mul0)+offset0);
                     dir_mem++;
                  //envia canal1
                     promedio_min0=0;
                     promedio_min0=read_ext_eeprom(dir_mem);
                     promedio_min0=promedio_min0<<8;
                     dir_mem++;
                     promedio_min0=promedio_min0+read_ext_eeprom(dir_mem);
                     printf(miputc,"%2.2f ",(promedio_min0*mul1)+offset1);
                     dir_mem++;
                  //envia canal2
                     promedio_min0=0;
                     promedio_min0=read_ext_eeprom(dir_mem);
                     promedio_min0=promedio_min0<<8;
                     dir_mem++;
                     promedio_min0=promedio_min0+read_ext_eeprom(dir_mem);
                     printf(miputc,"%2.2f ",(promedio_min0*mul2)+offset2);
                     dir_mem++;
                //envia pulsos
                     promedio_min0=0;
                     promedio_min0=read_ext_eeprom(dir_mem);
                     promedio_min0=promedio_min0<<8;
                     dir_mem++;
                     promedio_min0=promedio_min0+read_ext_eeprom(dir_mem);
                     printf(miputc,"%2.2f ",(promedio_min0*mul3)+offset3);
                     dir_mem++;

                     printf(miputc,"+");
                     car_fin=read_ext_eeprom(dir_mem);

               }//while

               printf("*");
               //printf(lcd_putc,"\f**Envio terminado**");
               break;
         case 'T':      //Si se recibe "T" se configura la estación
               //lcd_putc("\f*Configurando*");

      //***************************************//
      //***************************************//
      //*** Configuración de la estación  *****//
      //***************************************//
      //***************************************//

               printf("z");
               segundos=lee_cadena_ent();
               printf("Z");
               minutos=lee_cadena_ent();
               printf("y");
               horas=lee_cadena_ent();
               printf("Y");
               dia=lee_cadena_ent();
               printf("x");
               mes=lee_cadena_ent();
               printf("X");
               anio=lee_cadena_ent();
//*****************************************************//
//**********Configuracion del Reloj********************//
//*****************************************************//
               i2c_start();
               i2c_write(0b11010000);//byte de control del reloj, con escritura
               i2c_write(0);//inicializando el puntero a la direccion cero
               i2c_write(segundos);//Cofigura segundos e inicia el oscilador
               i2c_write(minutos);//Configura minutos
               i2c_write(horas);//configura horas
               i2c_write(num_dia);   //Dia de la semana
               i2c_write(dia);   //Cofigura dia
               i2c_write(mes);   //Configura mes
               i2c_write(anio);   //Cofigura año
               i2c_write(0b00010000);   //Saca la señal del oscilador a 1hz
               i2c_write(0x13);//bit q indica q la configuracion ha sido realizada
               i2c_stop();

      //********************************************//
      //********* Inicializo mul y offset***********//
      //*********                         **********//
      //********* Para valores en volts   **********//
      //********* (canales analogicos)    **********//
      //********* mul=5/1024=4.8828125 m  **********//
      //*********       y offset=0        **********//
      //********************************************//
      //****       Para canal 0 (pulsos)        ****//
      //****  mul=velocidad base/no pulsos base ****//
               printf("a");
               mul0=lee_cadena();
               printf("A");
               offset0=lee_cadena();
               printf("b");
               mul1=lee_cadena();
               printf("B");
               offset1=lee_cadena();
               printf("c");
               mul2=lee_cadena();
               printf("C");
               offset2=lee_cadena();
               printf("d");
               mul3=lee_cadena();
               printf("D");
               offset3=lee_cadena();

               dir_mem=0;
               write_ext_eeprom(dir_mem,0);
               dir_mem++;
               WRITE_FLOAT_EXT_EEPROM(dir_mem, mul0);
               dir_mem=dir_mem+4;
               WRITE_FLOAT_EXT_EEPROM(dir_mem, offset0);
               dir_mem=dir_mem+4;

               WRITE_FLOAT_EXT_EEPROM(dir_mem, mul1);
               dir_mem=dir_mem+4;
               WRITE_FLOAT_EXT_EEPROM(dir_mem, offset1);
               dir_mem=dir_mem+4;

               WRITE_FLOAT_EXT_EEPROM(dir_mem, mul2);
               dir_mem=dir_mem+4;
               WRITE_FLOAT_EXT_EEPROM(dir_mem, offset2);
               dir_mem=dir_mem+4;

               WRITE_FLOAT_EXT_EEPROM(dir_mem, mul3);
               dir_mem=dir_mem+4;
               WRITE_FLOAT_EXT_EEPROM(dir_mem, offset3);
               dir_mem=dir_mem+4;

               //lcd_putc("\f*Configurado*");
               break;


         }//switch


      }   //if s



      else      //Si no hay conexión
      {
      //lcd_putc("\f*No conex*");
      //lcd_putc("\nCargando config");
      imprime=0;
      no_pulsos=0;

//*****************************************************//
//******Configuracion del Reloj por default************//
//*****************************************************//
                  //*********************************//
                  //********Lectura de reloj*********//
                  //*********************************//
                     i2c_start();
                     i2c_write(0b11010000); //byte de control del reloj, con escritura
                     i2c_write(8);//inicializando el puntero a la direccion 8
                     i2c_stop();

                     i2c_start();
                     i2c_Write(0b11010001);      //byte de control del reloj, con lectura
                     configurado=i2c_read(0);
                     i2c_stop();
               if (configurado!=0x13)//carga configuracion del reloj por default si es necesario
               {
                     segundos=0;
                     minutos=0;
                     horas=0;
                     num_dia=0;
                     dia=1;
                     mes=1;
                     anio=1;

                     i2c_start();
                     i2c_write(0b11010000);//byte de control del reloj, con escritura
                     i2c_write(0);//inicializando el puntero a la direccion cero
                     i2c_write(segundos);//Cofigura segundos e inicia el oscilador
                     i2c_write(minutos);//Configura minutos
                     i2c_write(horas);//configura horas
                     i2c_write(num_dia);   //Dia de la semana
                     i2c_write(dia);   //Cofigura dia
                     i2c_write(mes);   //Configura mes
                     i2c_write(anio);   //Cofigura año
                     i2c_write(0b00010000);   //Saca la señal del oscilador a 1hz
                     i2c_write(0x13);//bit q indica q la configuracion ha sido realizada
                     i2c_stop();
               }
//******************************************
//*****Configuracion del convertidor AD*****
//******************************************
      set_tris_a(0xff);

      setup_adc(ADC_CLOCK_DIV_32);
//   setup_adc_ports(ALL_ANALOG);
      setup_adc_ports(AN0_AN1_AN3);

//**********************************************//
//******** Inicializo valores de las  **********//
//********    lecturas  instantaneas  **********//
//**********************************************//
      lectura_ad0=0;
      lectura_ad1=0;
      lectura_ad2=0;
      
      promedio_min0=0;
      promedio_min1=0;
      promedio_min2=0;
      cuenta_seg=0;
      cuenta_min=0;
      minutos_muestra=1;//indica cada cuantos minutos se guardan los datos

      dir_mem=64;      //Dirección de inicio de datos
   
      ENABLE_INTERRUPTS(INT_EXT);
      ENABLE_INTERRUPTS(INT_EXT1);
      ENABLE_INTERRUPTS(GLOBAL);

   while(1)
   {
      output_low(pin_c5);
      if (imprime)
      {
       output_high(pin_c5);
       delay_ms(2);
       #use rs232(baud=2400, xmit=PIN_b4, rcv=PIN_b5, bits=8)
       printf("!%x/%x/%x %x:%x:%x ",dia,mes,anio,horas,minutos,segundos);
       printf("AN1:%2.2f AN2:%2.2f AN3:%2.2f PULSOS:%Lu\n",(analogico0*mul0)+offset0,(analogico1*mul1)+offset1,(analogico2*mul2)+offset2,no_pulsos);
       output_low(pin_c5);
       no_pulsos=0;
       imprime=0;
      }
   }

//***

      }
}//main
