#include <18F2520.h>
//#device ADC=10
#fuses HS,NOBROWNOUT,NOWDT,NOPUT,NOPROTECT,NOLVP
#use delay(clock=8000000)
#use i2c(master,sda=PIN_b6, scl=PIN_b7)
#use rs232(baud=9600, xmit=PIN_b4, rcv=PIN_b5, bits=8,PARITY=o)

//*******************************
//Definicion de pines del micro
//*******************************
#define	canal_an1 pin_a0//canales analógicos
#define	canal_an2 pin_a1
#define canal_an3 pin_a2
//pines a3 a a4 no utilizados aun
#define habilitador pin_a5//habilitador para v2xe/ms5540
#define	indicador pin_c0 //define el led indicador
#define pin_calibracion pin_C1//pin para boton de inicio-fin de calibracion
 
#define pin_sync pin_c2//pin reset de brujula
//Los siguientes pines son fijos:
//pin c3 clk para SPI
//pin c4 MOSI para SPI
//pin c5 MISO para SPI
#define datos pin_c6//bus de datos para sht
#define clk pin_c7  //reloj para comunicación con sht
#define pulso_muestreo pin_b0//interrupción externa cada segundo
#define pulsos1 pin_b1//entrada de pulsos
//pin b2 y b3 no utilizados aun
//pin b4 y b5 utilizados para comunicacion rs232
//pin b6 y b7 utilizados para comunicacion i2c

#define dir_ini 64//direccion de inicio de escritaura en memoria externa
                  //maximo 255
#define localidad_dir_fin 0x20


//**********************
//Librerias utilizadas
//**********************
#include <24256est.c>
#include <stdlib.h>
#include <shtxx.c>//funciones para manejar el sht
#include <v2xe.c>//funciones para manejar la v2xe
#include <ms5540.c>//funciones para el manejo del ms5540
#include <rutinas.c>//rutinas mat

int a;//entero auxiliar
int id_estacion;
int cantidad_estaciones;
int segundos,minutos,horas,num_dia,dia,mes,anio,configurado;
//******************************************************//
//** Declaración de Variables de lecturas instantaneas**//
//******************************************************//

//Guarda lecturas instantaneas de pulsos
int16 no_pulsos;
//guarda lecturas instantaneas de canales ad
//long analogico0,analogico1,analogico2;
//Guarda lecturas de temperatura y humedad
int16 temperatura,humedad;
float temp_en_c,humedad_lineal,humedad_comp;
//Guarda lecturas de dirección y magnitud de V2xe
float direccion,magnitud;
//Guarda velocidad de viento
float velocidad;
//Variables acumulativas
float temp_acumulada,hum_acumulada,pres_acumulada,dir_acumulada,vel_acumulada;
//int16 pul_acumulados;
//variables q se envian
float temp_enviar,hum_enviar,pres_enviar,dir_enviar,vel_enviar;
//int16 pul_enviar;
int seg_envia,min_envia,hora_envia,dia_envia,mes_envia,anio_envia;

long cuenta_seg, segundos_muestra;
long dir_mem,dir_fin;
//long cuenta_min,minutos_muestra;

//long lectura_ad0,lectura_ad1,lectura_ad2;//guarda lecturas acumuladas de canales ad
//long promedio_min0,promedio_min1,promedio_min2;//guarda el promedio de N minutos
float  mul0,mul1,mul2,mul3;//multiplicadores q afectan a los canales
float  offset1,offset2,offset0,offset3;//offset q afectan a los canales
int exor;//byte para comprobación d errores

int1 inicio_lectura,memoria_llena;

byte dato_v2xe;
int estacion_q_envia;
int inicia_calibracion;

//variables v2xe
float x_calibrado,y_calibrado;
byte tempo1_v2xe,tempo2_v2xe,tempo3_v2xe,tempo4_v2xe;
int32 xoffset,yoffset,xgain,ygain;
int32 xrawv,yrawv;
float phi,cal_magn;



void realiza_lectura(void);
void WRITE_FLOAT_EXT_EEPROM(long int n, float data);
float READ_FLOAT_EXT_EEPROM(long int n);
void envia_datos(void);
#INT_TIMER0 
void rutina_timer() 
{
        set_timer0(0);
}


#INT_ext
//rutina de lectura de sensores, almacenamiento
// de datos y envio de recepcion
void almacena()  
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
   
   if (segundos==1)
                {
                
                inicio_lectura=1;
                }
        
   if(inicio_lectura==1)
        {

    cuenta_seg++;


    realiza_lectura();
//aplico filtro digital paso bajas
    temp_en_c=filtro(temp_en_c,0.125,1);
    humedad_comp=filtro(humedad_comp,0.125,5);
    presion=filtro(presion,0.125,9);
    //velocidad=filtro(velocidad,0.25,30);
      

//acumulo valores
temp_acumulada=temp_acumulada+temp_en_c;
hum_acumulada=hum_acumulada+humedad_comp;
pres_acumulada=pres_acumulada+presion;
vel_acumulada=vel_Acumulada+velocidad;


//dir_acumulada=
  
//}//inicio_lectura


//***********************************//
//******** Realiza promedios*********//
//***********************************//
if(memoria_llena==0)
{
   if(segundos_muestra==cuenta_seg)
   {

//********************************//
//********************************//
//******Guardando los datos ******//
//******  en EEPROM         ******//
//********************************//
//********************************//

//**********************//
//Guardo la fecha y hora//
//**********************//
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
//**********************//
//Guardo la temperatura*//
//**********************//
	 temp_Acumulada=temp_Acumulada/cuenta_seg;
         write_float_ext_eeprom(dir_mem,temp_acumulada);
         dir_mem=dir_mem+4;        

//**********************//
//***Guardo la humedad**//
//**********************//

	 hum_acumulada=hum_acumulada/cuenta_seg;
         write_float_ext_eeprom(dir_mem,hum_acumulada);
         dir_mem=dir_mem+4;        

//************************//
// Guardo Presion ms5540  //
//************************//
	 pres_acumulada=pres_Acumulada/cuenta_seg;
         write_float_ext_eeprom(dir_mem,pres_acumulada);
         dir_mem=dir_mem+4;        

//************************//
//Guardo direccion de v2xe//
//************************//

         write_float_ext_eeprom(dir_mem,direccion);
         dir_mem=dir_mem+4;

//***************************//
//*  Guardo canal de pulsos *//
//***************************//
//         pul_acumulados=pul_acumulados/cuenta_seg;
//         write_ext_eeprom(dir_mem,pul_acumulados>>8);
//         dir_mem++;
//         write_ext_eeprom(dir_mem,pul_acumulados);
//         dir_mem++;
//

		vel_acumulada=vel_acumulada/cuenta_seg;
		write_float_ext_eeprom(dir_mem,vel_acumulada);
		dir_mem=dir_mem+4;
		
//***************************//
// Guardo canales analogicos //
//***************************//

//         write_ext_eeprom(dir_mem,promedio_min0>>8);
//         dir_mem++;
//         write_ext_eeprom(dir_mem,promedio_min0);
//         dir_mem++;
//         write_ext_eeprom(dir_mem,promedio_min1>>8);
//         dir_mem++;
//         write_ext_eeprom(dir_mem,promedio_min1);
//         dir_mem++;
//         write_ext_eeprom(dir_mem,promedio_min2>>8);
//         dir_mem++;
//         write_ext_eeprom(dir_mem,promedio_min2);
//         dir_mem++;

//Guardo las variables que se enviaran via rf
         dia_envia=dia;
         mes_envia=mes;
         anio_envia=anio;
         hora_envia=horas;
         min_envia=minutos;
         seg_envia=segundos;
         temp_enviar=temp_acumulada;
        hum_enviar=hum_acumulada;
        pres_enviar=pres_acumulada;
        dir_enviar=direccion;
        vel_enviar=vel_acumulada;
//Escribo caracter de fin de archivo
        dir_mem=dir_mem+6;
        if (dir_mem>=65503)
                {
                memoria_llena=1;
                }

        write_eeprom(localidad_dir_fin,dir_mem>>8);
        write_eeprom(localidad_dir_fin+1,dir_mem);
        write_ext_eeprom(dir_mem,0xff);
		
        temp_acumulada=0;
        hum_acumulada=0;
        pres_acumulada=0;
        vel_acumulada=0;
        dir_acumulada=0;
        //Reinicio de cuenta de tiempos de muestreo
        cuenta_seg=0;
        
        
      
   }//if
 }//if memoria llena

  
//compruebo si la estación debe enviar datos en 
//el segundo actual
  //      estacion_q_envia=((segundos%segundos_muestra)%cantidad_estaciones)+1;
//        
    //    if(estacion_q_envia==(id_estacion-0x21)) 
      //  {
         //envio datos via rf
        envia_datos();


      #use rs232(baud=2400, xmit=PIN_b4, rcv=PIN_b5, bits=8,PARITY=o)
        printf("\n %f %f %f %f  %Ld %Ld ",x_Calibrado,y_calibrado,direccion,magnitud,xrawv,yrawv);

        }


}//fin lectura

void realiza_lectura(void)
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
   
//*********************************//
//******Lectura de sensor sht******//
//*********************************//
	reinicio_com();
	ini_trans();
	envia_byte(0b00000011);
	temperatura=lee_2bytes();
    temp_en_c=-39.60+(.01*temperatura);
    ini_trans();
	envia_byte(0b00000101);
	humedad=lee_2bytes();
    humedad_lineal=-4+(0.0405*humedad)-(0.0000028*humedad*humedad);
    humedad_comp=(temp_en_c-25)*(.01+(.00008*humedad))+humedad_lineal;

//*********************************//
//*****Lectura de sensor v2xe *****//
//*********************************//
   output_low(habilitador);
   delay_us(10);
   setup_spi(spi_master|SPI_L_TO_H|SPI_CLK_DIV_64|SPI_XMIT_L_TO_H);//configura spi
   dato_v2xe=spi_read(0xaa);
   dato_v2xe=spi_read(0x04);//pide datos
   dato_v2xe=spi_read(0x00);
   //delay_ms(50);
   while (dato_v2xe!=0xaa)//Espera q la v2xe envie datos
      dato_v2xe=spi_read(0x00);

   dato_v2xe= spi_read(0);//lee id de comando
   dato_v2xe= spi_read(0);//lee n comp

dato_v2xe= spi_read(0);//lee id de dato1
        tempo1_v2xe=spi_read(0);
        tempo2_v2xe=spi_read(0);
        tempo3_v2xe=spi_read(0);
        tempo4_v2xe=spi_read(0);
        xrawv=make32(tempo1_v2xe,tempo2_v2xe,tempo3_v2xe,tempo4_v2xe);
dato_v2xe= spi_read(0);//lee id de dato2
        tempo1_v2xe=spi_read(0);
        tempo2_v2xe=spi_read(0);
        tempo3_v2xe=spi_read(0);
        tempo4_v2xe=spi_read(0);
        yrawv=make32(tempo1_v2xe,tempo2_v2xe,tempo3_v2xe,tempo4_v2xe);

   
   dato_v2xe= spi_read(0);//lee id de dato3
   en_ieee[0]=spi_read(0x00);//lee dato1
   en_ieee[1]=spi_read(0x00);
   en_ieee[2]=spi_read(0x00);
   en_ieee[3]=spi_read(0x00);
   x_calibrado=ieee_en_mic();//convierte de formato ieee a formato de microcip
   dato_v2xe= spi_read(0);//lee id de dato 4
   en_ieee[0]=spi_read(0x00);//lee dato2
   en_ieee[1]=spi_read(0x00);
   en_ieee[2]=spi_read(0x00);
   en_ieee[3]=spi_read(0x00);
   y_calibrado=ieee_en_mic();//convierte de formato ieee a formato de microchip


   dato_v2xe= spi_read(0);//lee id de dato5
   en_ieee[0]=spi_read(0x00);//lee dato3
   en_ieee[1]=spi_read(0x00);
   en_ieee[2]=spi_read(0x00);
   en_ieee[3]=spi_read(0x00);
   direccion=ieee_en_mic();//convierte de formato ieee a formato de microcip
   dato_v2xe= spi_read(0);//lee id de dato 6
   en_ieee[0]=spi_read(0x00);//lee dato4
   en_ieee[1]=spi_read(0x00);
   en_ieee[2]=spi_read(0x00);
   en_ieee[3]=spi_read(0x00);
   magnitud=ieee_en_mic();//convierte de formato ieee a formato de microchip
 
   dato_v2xe= spi_read(0);//lee caracter de fin

////obteniendo datos de calibracion
//
//        spi_write(0xaa);
//        spi_write(0x0c);
//        spi_write(0x00);
//        dato_v2xe=spi_read(0);
//        dato_v2xe=spi_read(0);
//        dato_v2xe=spi_read(0);//cuenta de datos
//        tempo1_v2xe=spi_read(0);
//        tempo2_v2xe=spi_read(0);
//        tempo3_v2xe=spi_read(0);
//        tempo4_v2xe=spi_read(0);
//        xoffset=make32(tempo1_v2xe,tempo2_v2xe,tempo3_v2xe,tempo4_v2xe);
//
//        tempo1_v2xe=spi_read(0);
//        tempo2_v2xe=spi_read(0);
//        tempo3_v2xe=spi_read(0);
//        tempo4_v2xe=spi_read(0);
//        yoffset=make32(tempo1_v2xe,tempo2_v2xe,tempo3_v2xe,tempo4_v2xe);
//
//        tempo1_v2xe=spi_read(0);
//        tempo2_v2xe=spi_read(0);
//        tempo3_v2xe=spi_read(0);
//        tempo4_v2xe=spi_read(0);
//        xgain=make32(tempo1_v2xe,tempo2_v2xe,tempo3_v2xe,tempo4_v2xe);
//
//        tempo1_v2xe=spi_read(0);
//        tempo2_v2xe=spi_read(0);
//        tempo3_v2xe=spi_read(0);
//        tempo4_v2xe=spi_read(0);
//        ygain=make32(tempo1_v2xe,tempo2_v2xe,tempo3_v2xe,tempo4_v2xe);
//
//   en_ieee[0]=spi_read(0x00);//lee dato4
//   en_ieee[1]=spi_read(0x00);
//   en_ieee[2]=spi_read(0x00);
//   en_ieee[3]=spi_read(0x00);
//   phi=ieee_en_mic();//convier
//
//   en_ieee[0]=spi_read(0x00);//lee dato4
//   en_ieee[1]=spi_read(0x00);
//   en_ieee[2]=spi_read(0x00);
//   en_ieee[3]=spi_read(0x00);
//   cal_magn=ieee_en_mic();//convierv




    
//*********************************//
//***Lectura de sensor ms5540 *****//
//*********************************//

    output_high(habilitador);
    setup_spi(spi_master|SPI_L_TO_H|SPI_CLK_DIV_64|SPI_XMIT_L_TO_H|SPI_SAMPLE_AT_END);//configura spi
    letc_calc_5540();
    
//*********************************//
//**Lectura de canales analogicos**//
//*********************************//
////Canal 1
//   set_adc_channel(0);
//   delay_us(20);
//   analogico0=READ_ADC();
//   lectura_ad0=lectura_ad0+analogico0;
////Canal 2
//   set_adc_channel(1);
//   delay_us(20);
//   analogico1=READ_ADC();
//   lectura_ad1=lectura_ad1+analogico1;
////Canal 3
//   set_adc_channel(2);
//   delay_us(20);
//   analogico2=READ_ADC();
//   lectura_ad2=lectura_ad2+analogico2;

//***********************************//
//******** Lectura de Pulsos*********//
//***********************************//
    
        no_pulsos=get_timer0();
        set_timer0(0);
	velocidad=no_pulsos*0.0589; 
   // setup_timer_0(RTCC_OFF);
    
 
   // setup_timer_0 (RTCC_EXT_H_TO_L|RTCC_DIV_1 );
    
}//fin realiza lectura

//*******************************************//
//*****Escritura de flotante en eeprom*******//
//*******************************************//

void WRITE_FLOAT_EXT_EEPROM(long int n, float data) 
{
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

void config_canales()//Realiza la configuracion de los canales
{

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
}

void envia_rf(byte caracter)
{

#use rs232(baud=2400, xmit=PIN_b4, rcv=PIN_b5, bits=8,PARITY=o)
if (caracter==0x21)
   {
   exor=caracter;
   putc(caracter);
   }
else{
   exor=exor^caracter;
   putc(caracter);
   if (caracter==0x0a)
   {
      putc(exor);
      putc (0x0d);
   }

   }

}
//*******************************************//
//** Rutina q envia todos los datos via RF **//
//*******************************************//

void envia_datos(void)
{
int caracter_inicio;
       output_high(indicador);
       #use rs232(baud=2400, xmit=PIN_b4, rcv=PIN_b5, bits=8,PARITY=o)
        caracter_inicio=0x21;
    //Envia caracter de inicio de transmisión y la id de la estación
       printf(envia_rf,"%c%c",caracter_inicio,id_estacion);
    //Envia fecha y hora
       printf(envia_rf,"%2x/%2x/%2x %2x:%2x:%2x ",dia_envia,mes_envia,anio_envia,hora_envia,min_envia,seg_envia);
    //Envia los datos de los sensores integrados al sistema
       printf(envia_rf,"%2.1f %2.1f %2.1f %2.1f ",temp_enviar,hum_enviar,pres_enviar,dir_enviar);
    //Envia datos del canal analógico 0
    //   printf(envia_rf,"%2.2f ",(analogico0*mul0)+offset0);
    //Envia datos del canal analógico 1
    //   printf(envia_rf,"%2.2f ",(analogico1*mul1)+offset1);
    //Envia datos del canal analógico 2
    //   printf(envia_rf,"%2.2f ",(analogico2*mul2)+offset2);
    //Envia datos del canal de pulsos 1
       printf(envia_rf,"%2.1f",vel_enviar);
      printf(envia_rf," %Lu ",dir_mem);


    //Envia caracter de fin de transmisión
       printf(envia_rf,"\n");
       output_low(indicador);
       no_pulsos=0;
}

void main (){

int    car_fin;
int32  t_espera;
char   caracter_r;




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
//

#use rs232(baud=9600, xmit=PIN_b4, rcv=PIN_b5, bits=8,PARITY=o)
//setup_timer_0 (RTCC_EXT_H_TO_L );
   

      delay_ms(500);

      caracter_r=64;
      t_espera=0;
      port_b_pullups (false);
      output_high(indicador);
//      while (t_espera++<500000)//busca conexion durante 5 seg
//      {
//      delay_us(10);
//      if (kbhit())
//         {
//         caracter_r= getc();
//         t_espera=500000;
//         }
//      }
//      output_low(indicador);
//
while(caracter_r!='s')
{
caracter_r=getc();
}
output_low(indicador);
//      if (caracter_r=='s')      //Si hay conexión
  //    {                     //REaliza esta rutina
         //Lcd_putc("\nPC encontrada...");
#use rs232(baud=9600, xmit=PIN_b4, rcv=PIN_b5, bits=8,PARITY=o)
         putc('s');
         caracter_r= getc();
         
         switch (caracter_r){
         case 't':
//Si se recibe "t" se envian datos de la memoria
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

               dir_mem=dir_ini;
               car_fin=0;
               //Lcd_putc("\fEnviando...");
               while(car_fin!=0xff&&dir_mem>=dir_ini){
                   output_high(indicador);
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
                //Envia presion y humedad
                    temp_en_C=read_float_ext_eeprom(dir_mem);
                    dir_mem=dir_mem+4;
                    humedad_comp=read_float_ext_eeprom(dir_mem);
                    dir_mem=dir_mem+4;
                     printf(miputc,"%2.1f ",temp_en_c);
                     printf(miputc,"%2.1f ",humedad_comp);

                        output_low (indicador);

//                  //envia canal0
//                     promedio_min0=0;
//                     promedio_min0=read_ext_eeprom(dir_mem);
//                     promedio_min0=promedio_min0<<8;
//                     dir_mem++;
//                     promedio_min0=promedio_min0+read_ext_eeprom(dir_mem);
//                     printf(miputc,"%2.2f ",(promedio_min0*mul0)+offset0);
//                     dir_mem++;
//                  //envia canal1
//                     promedio_min0=0;
//                     promedio_min0=read_ext_eeprom(dir_mem);
//                     promedio_min0=promedio_min0<<8;
//                     dir_mem++;
//                     promedio_min0=promedio_min0+read_ext_eeprom(dir_mem);
//                     printf(miputc,"%2.2f ",(promedio_min0*mul1)+offset1);
//                     dir_mem++;
//                  //envia canal2
//                     promedio_min0=0;
//                     promedio_min0=read_ext_eeprom(dir_mem);
//                     promedio_min0=promedio_min0<<8;
//                     dir_mem++;
//                     promedio_min0=promedio_min0+read_ext_eeprom(dir_mem);
//                     printf(miputc,"%2.2f ",(promedio_min0*mul2)+offset2);
//                     dir_mem++;
//

                    //envia presion
                     printf(miputc,"%2.1f ",read_float_ext_eeprom(dir_mem));
                     dir_mem=dir_mem+4;

                     //envia dirección
                     printf(miputc,"%2.1f ",read_float_ext_eeprom(dir_mem));
                     dir_mem=dir_mem+4;

                //envia velocidad
                     printf(miputc,"%2.1f ",read_float_ext_eeprom(dir_mem));
                     dir_mem=dir_mem+4;

                     printf(miputc,"+");
	                
                     dir_mem=dir_mem+6;
                     car_fin=read_ext_eeprom(dir_mem);
				
                

               }//while
               output_low (indicador);
               printf("*");
               //printf(lcd_putc,"\f**Envio terminado**");
                delay_ms(5000);
                reset_cpu();
               break;
         case 'T': 
    //Si se recibe "T" se configura la estación
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
               printf ("W");
                //configuro id_estacion
               id_estacion=lee_cadena_ent();
               write_eeprom(21,id_estacion);
                //configuro tiempo de muestreo
               printf("w");
               write_eeprom(20,lee_cadena_ent());
               printf("U");
               cantidad_estaciones=lee_cadena_ent();
               write_eeprom(22,cantidad_estaciones);
                printf("u");
                inicia_calibracion=lee_cadena_ent();
                write_eeprom(23,inicia_calibracion);
                printf("t");
                dir_fin=lee_cadena_ent();
                if(dir_fin==0)
                       {
                        write_eeprom(localidad_dir_fin,0);
                        write_eeprom(localidad_dir_fin+1,dir_ini);        
                       }
                

                
//*****************************************************//
//**********Configuracion del Reloj********************//
//*****************************************************//
               i2c_start();
               i2c_write(0b11010000);//byte de control del reloj, con escritura
               i2c_write(0);//inicializando el puntero a la direccion cero
               i2c_write(segundos);//Configura segundos e inicia el oscilador
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

               config_canales();

               //lcd_putc("\f*Configurado*");
               //reset_cpu();
               break;
        default:
               reset_cpu();
                break;


         }//switch
//      }   //if s

  //    else      //Si no hay conexión
   //   {
      //lcd_putc("\f*No conex*");
      //lcd_putc("\nCargando config");
      


//DESDE AQUI
      no_pulsos=0;
//*****************************************************//
//*************Si no hay conexion**********************//
//*****************************************************//
//************Configuracion predeterminada ************//
//*****************************************************//

                  //***************************************//
                  //*****Revisa si hay configuracion*******//
                  //***************************************//
                     i2c_start();
                     i2c_write(0b11010000); //byte de control del reloj, con escritura
                     i2c_write(8);//inicializando el puntero a la direccion 8
                     i2c_stop();

                     i2c_start();
                     i2c_Write(0b11010001);      //byte de control del reloj, con lectura
                     configurado=i2c_read(0);
                     i2c_stop();
//carga configuracion del reloj predeterminada si es necesario
                     if (configurado!=0x13)

                     {
                           segundos=1;
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

                     //************************************//
                     //***Carga configuracion de canales***//
                     //************************************//
                           mul0=.0029296875;
                           offset0=0;
                           mul1=0.158502;
                           offset1=-36.47;
                           mul2=.0029296875;
                           offset2=0;
                           mul3=.0589;
                           offset3=0;
                           config_canales();
                        //se muestrea cada 1 segundo
                        segundos_muestra=1;
                        write_eeprom(20,15);
                     //ID de estacion predeterminada =0x22
                           id_estacion=0x22;
                           write_eeprom(21,id_estacion);

                        //cantidad de estaciones=1
                        cantidad_estaciones=1;
                        write_eeprom(22,cantidad_estaciones);
                        //se realiza calibracion al inicio
                        inicia_calibracion=0;
                        write_eeprom(23,inicia_calibracion);
                     }//fin configuracion predeterminada

//************************************//
//*****Carga configuracion de sht*****//
//************************************//
    	output_low(clk);
	    output_low(datos);

//************************************//
//****Carga configuracion de v2xe*****//
//************************************//
        output_low(habilitador);
        delay_us(10);
        output_low(pin_sync);
        setup_spi(spi_master|SPI_L_TO_H|SPI_CLK_DIV_64|SPI_XMIT_L_TO_H);//configura spi
        output_high(pin_sync); //Rutina q
        delay_us(15);          //Reinicia la v2xe
        output_low(pin_sync);
        delay_us(15);

//**********************************************//
//**Configuracion de los datos q envia la v2xe**//
//**cada q se requieran datos                 **//
//**********************************************//

//        dato_v2xe=spi_read(0xaa);//byte de sincronizacion
//        dato_v2xe=spi_read(0x03);//comando
//        dato_v2xe=spi_read(0x02);//numero de datos=2
//        dato_v2xe=spi_read(0x05);//dato1=direccion
//        dato_v2xe=spi_read(0x06);//dato2=magnitud
//        dato_v2xe=spi_read(0x00);//caracter de fin      

configura_v2xe();

//************************************//
//***Carga configuracion de ms5540****//
//************************************//
        output_high(habilitador);
        setup_spi(spi_master|SPI_L_TO_H|SPI_CLK_DIV_64|SPI_XMIT_L_TO_H|SPI_SAMPLE_AT_END);//configura spi
        ini_ms5540();

//******************************************
//*****Configuracion del convertidor AD*****
//******************************************
//      set_tris_a(0xff);
//      setup_adc(ADC_CLOCK_DIV_32);
//      setup_adc_ports(AN0_TO_AN2);
//

//**Configuracion de Timer
        set_timer0(0);
        setup_timer_0 (RTCC_EXT_H_TO_L|RTCC_DIV_1 );




//**********************************************//
//******** Inicializo valores de las  **********//
//********    lecturas  instantaneas  **********//
//********    y valores acumulados    **********//
//**********************************************//
//      lectura_ad0=0;
//      lectura_ad1=0;
//      lectura_ad2=0;
//      
//      promedio_min0=0;
//      promedio_min1=0;
//      promedio_min2=0;
temp_acumulada=0;
hum_acumulada=0;
pres_acumulada=0;
vel_acumulada=0;
dir_acumulada=0;
cuenta_seg=0;
inicio_lectura=0;
//segundos_muestra
segundos_muestra=read_eeprom(20);

//ID de estacion
id_estacion=read_eeprom(21);

//cantidad de estaciones
cantidad_estaciones=read_eeprom(22);

//Dirección de inicio de datos 0x20
dir_mem=read_eeprom(localidad_dir_fin);
dir_mem=dir_mem<<8;
dir_mem=dir_mem+read_eeprom(localidad_dir_fin+1);
if(dir_mem==0)
{
        memoria_llena=1;
}
else
{
        memoria_llena=0;
}
     

//Se realiza calibracion si asi se requiere
inicia_calibracion=read_eeprom(23);
if (inicia_calibracion==1)
{
        output_low(indicador);
        delay_ms(100);
        output_high(indicador);
        delay_ms(100);
        output_low(indicador);
        delay_ms(100);
        output_high(indicador);
        delay_ms(100);
        output_low(indicador);
        delay_ms(100);
        output_high(indicador);
        calibracion();
        output_low(indicador);
        delay_ms(100);
        output_high(indicador);
        delay_ms(100);
        output_low(indicador);
        delay_ms(100);
        output_high(indicador);
        delay_ms(100);
        output_low(indicador);
        delay_ms(100);
        output_high(indicador);
        delay_ms(200);
        inicia_calibracion=0;
        write_eeprom(23,inicia_calibracion);
}
 
//inicializo datos del filtro
realiza_lectura();
write_float_eeprom(1,temp_en_c);
write_float_eeprom(5,humedad_comp);
write_float_eeprom(9,presion);

   
      ENABLE_INTERRUPTS(INT_EXT);
      ENABLE_INTERRUPTS(GLOBAL);
      

   while(1)
   {
      output_low(indicador);

   }

//***

  //    }//else
}//main
