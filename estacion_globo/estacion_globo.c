#include <18F252.h>
#fuses HS,NOBROWNOUT,NOWDT,NOPUT,PROTECT
#use delay(clock=8M)
#use i2c(master,sda=PIN_b6, scl=PIN_b7)
#use rs232(baud=9600, xmit=PIN_b4, rcv=PIN_b5,bits=8,PARITY=n,TIMEOUT=100)
#include <config.c>

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
short int status;
int16 chkenv;
unsigned int val8;
unsigned int pMuestreo[14];
int i;

    cuenta_seg++;
    if (cuenta_seg==isample){
        //Rutina de muestreo
        output_high(indicador);
        cuenta_seg=0;
        cMuestras++;
        realiza_lectura();
        //calculo de altura
        //altura=44330*(1-pow(presion/1013.25,0.19));
        //altura_relativa=altura-altura_base;
        //conversión a enteros de datos TR
        pMuestreo[0]=presion>>8;
        pMuestreo[1]=presion;
        pMuestreo[2]=presInt>>8;
        pMuestreo[3]=presInt;
        pMuestreo[4]=no_pulsos;
        pMuestreo[5]=x_calibrado*60.0;
        pMuestreo[6]=y_calibrado*60.0;
        pMuestreo[7]=(temperatura>>8);
        pMuestreo[8]=temperatura;
        pMuestreo[9]=humedad;
        pMuestreo[10]=dir_mem>>8;
        pMuestreo[11]=dir_mem;
        pMuestreo[12]=analogico0;
        pMuestreo[13]=analogico1;
        chkenv=0;
        //envio datos parte1
        for (i=0;i<=4;i++){
            chkenv=chkenv+pMuestreo[i];
            putc(pMuestreo[i]);
        }
        putc(chkenv>>8);
        putc(chkenv);
        //acumulo valores
        Tac+=temperatura;
        Pac+=presion;
        HRac+=humedad;
        Wnsac+=cvns;
        Wewac+=cvew;
        Aac+=analogico1;
        delay_ms(15);
        chkenv=0;
        //envio datos parte2
        for (i=5;i<=13;i++){
            chkenv=chkenv+pMuestreo[i];
            putc(pMuestreo[i]);
        }
        putc(pMuestreo[0]);
        putc(pMuestreo[1]);
        chkenv+=pMuestreo[0]+pMuestreo[1];
        putc(chkenv>>8);
        putc(chkenv);

    //Realizo promedios y almaceno datos
        if((memoria_llena==0)&&(isave==cMuestras))
        {
            Tp=(Tac/isave);
            HRp=(HRac/isave);
            Pp=Pac/isave;
            if (no_pulsos==0){
                WD=0;
                WS=0;
            }
            else{
                if (Wnsac==0)
                    if (Wewac<0)
                        WD=90;
                    else
                        WD=-90;
                else
                    WD=-57.2958*atan(Wewac/Wnsac);
                if (Wnsac<0)
                    bit_Set(Tp,15);
                else
                    bit_clear(Tp,15);
                WS=sqrt(pow(Wnsac,2)+pow(Wewac,2))/isave;
            }
            
            AN1p=Aac/isave;
            i2c_start();
            i2c_write(0xa0);
            i2c_write(dir_mem>>8);
            i2c_write(dir_mem);
            i2c_write(Tp>>8);
            i2c_write(Tp);
            i2c_write(HRp);
            i2c_write(Pp>>8);
            i2c_write(Pp);
            i2c_write(WS);
            i2c_write(WD);
            i2c_write(AN1p);
            i2c_stop();

            i2c_start();
            status=i2c_write(0xa0);
            while(status==1)
            {
                i2c_start();
                status=i2c_write(0xa0);
            }
            dir_mem=dir_mem+8;
            if (dir_mem>=65527)
                {
                    memoria_llena=1;
                }
            write_ext_eeprom(11,dir_mem>>8);
            write_ext_eeprom(12,dir_mem);
            //reinicio de variables
            iniVariables();
 
        }//if memoria llena
        else
            delay_ms(5);
        //envio datos promedio
        val8=Tp>>8;
        chkenv=val8;
        putc(val8);
        val8=Tp&0xFF;
        chkenv+=val8;
        putc(val8);
        chkenv+=HRp;
        putc(HRp);
        val8=Pp>>8;
        chkenv+=val8;
        putc(val8);
        val8=Pp&0xFF;
        chkenv+=val8;
        putc(val8);
        chkenv+=WS;
        putc(WS);
        chkenv+=WD;
        putc(WD);
        chkenv+=AN1p;
        putc(AN1p);
        val8=dir_mem>>8;
        putc(val8);
        chkenv+=val8;
        val8=dir_mem;
        putc(val8);
        chkenv+=val8;
        putc(anio);
        putc(mes);
        putc(dia);
        putc(horas);
        putc(minutos);
        putc(segundos);
        putc(isave);
        putc(presInt>>8);
        putc(presInt);
        chkenv+=anio+mes+dia+horas+minutos+segundos+isave;
        chkenv+=presInt>>8;
        chkenv+=presInt&0xff;
        putc(chkenv>>8);
        putc(chkenv);
        output_low(indicador);
    }
}//fin lectura

void realiza_lectura(void)
    {

    //peticion temperatura
    ini_trans();
    envia_byte(0b00000011);
    //Lectura de sensor ms5540
    output_high(habilitador);
    delay_us(10);
    setup_spi(spi_master|SPI_L_TO_H|SPI_CLK_DIV_64|SPI_XMIT_L_TO_H|SPI_SAMPLE_AT_END);
    presion=lee_5540();
    //Lectura de sensor v2xe
    output_low(habilitador);
    setup_spi(spi_master|SPI_L_TO_H|SPI_CLK_DIV_64|SPI_XMIT_L_TO_H);
    delay_us(10);   
    lee_datos_v2xe();
    //Lectura de temperatura
    temperatura=lee_2bytes();
    //peticion de HR
    ini_trans();
    envia_byte(0b00000101);
    //Lectura de canales analogicos
    ////Canal 0
    set_adc_channel(0);
    delay_us(20);
    analogico0=READ_ADC();
    set_adc_channel(1);
    delay_us(20);
    analogico1=READ_ADC();
    //Lectura de Pulsos
    no_pulsos=get_timer0();
    set_timer0(0);
    //para constante=17 (5 helices)
    //velocidad=no_pulsos*0.0589; 
    //para constante=15
    //  velocidad=no_pulsos*0.0667;
    //lectura de HR
    humedad=lee_2bytes();
    //conversion de variables de viento
    cvns=(float)no_pulsos*x_calibrado/magnitud;
    cvew=(float)no_pulsos*y_calibrado/magnitud;
    
    //conversiones T&HR
    //temp_en_c=-39.60+(.04*temperatura);
    //humedad_lineal=-4+(0.648*humedad)-(0.00072*humedad*humedad);
    //humedad_comp=(temp_en_c-25)*(.01+(.00128*humedad))+humedad_lineal;
 
    }

void parpadea(void)
{
     output_low(indicador); 
     delay_ms(400); 
     output_high(indicador);
     delay_ms(400); 
     output_low(indicador); 
     delay_ms(400); 
     output_high(indicador);
     delay_ms(400); 
     output_low(indicador);
     delay_ms(400); 
     output_high(indicador);
     delay_ms(400); 
     output_low(indicador);
}

void cfgSensores(){
    //configura los sensores
    //convertidor AD
    input(pin_A0);
    setup_adc(ADC_CLOCK_INTERNAL);
    setup_adc_ports(AN0_AN1_AN3);
    //Timer (vel viento)
    set_timer0(0);
    setup_timer_0 (RTCC_EXT_H_TO_L|RTCC_DIV_1 );
    //SHT75
    output_low(clk);
    output_low(datos);
    //a baja resolución
    ini_trans();
    envia_byte(0b00000110);
    envia_byte(0b00000001);
    //Carga configuracion de v2xe
    output_low(habilitador);
    delay_us(10);
    output_low(pin_sync);
    setup_spi(spi_master|SPI_L_TO_H|SPI_CLK_DIV_64|SPI_XMIT_L_TO_H);
    output_high(pin_sync);
    delay_us(15);
    output_low(pin_sync);
    delay_us(15);
    //v2xe
    configura_v2xe();
    //ms5540
    output_high(habilitador);
    setup_spi(spi_master|SPI_L_TO_H|SPI_CLK_DIV_64|SPI_XMIT_L_TO_H|SPI_SAMPLE_AT_END);
    ini_ms5540();
}
void iniVariables(){
    //inicializa diversas variables
    Pac=0;
    Tac=0;
    HRac=0;
    Wnsac=0;
    Wewac=0;
    Aac=0;
    cuenta_seg=0;
    cMuestras=0;
    isample=read_ext_eeprom(1);
    dir_mem=read_ext_eeprom(11);
    dir_mem=dir_mem<<8;
    dir_mem=dir_mem+read_ext_eeprom(12);
    presInt=read_ext_eeprom(0x09);
    presInt=presInt<<8;
    presInt=presInt+read_ext_eeprom(0x0A);
}
void main (){

int    matriz8[14],i,val8l,val8h;
int1         status;
unsigned int t,chk8;
unsigned int16 chksum,chkrcv; 
char         s[10];
char    comandos[7][8]={
    "tst",
    "gDatos",
    "config",
    "calibra",
    "gSample",
    "gParam",
    "reset"
};

    output_low(indicador);
    delay_ms(5);
    port_b_pullups (false);
    output_high(indicador);
    output_float(pin_b0);
    output_float(pin_b6);
    output_float(pin_b7);
    output_high(indicador);

    while(True)
    {
        getStr0(s,10);
        //test
        if(cmpStr(&comandos[0][0],s))
            printf("OK");
        //se envian datos de la memoria
        else if(cmpStr(&comandos[1][0],s)){
            printf("OK");
            dir_mem=0;
            while (dir_mem!=0xffff){
                val8h=getc();
                val8l=getc();
                dir_mem=make16(val8h,val8l);
                chk8=getc();
                if ((val8l+val8h)==chk8 && dir_mem!=0xffff && dir_mem!=0){
                    i2c_start();
                    i2c_write(0xa0);
                    i2c_write(dir_mem>>8);
                    i2c_write(dir_mem);
                    i2c_start();
                    i2c_write(0xa1);
                    chksum=0;
                    for (i=0;i<=6;i++)
                    {
                        matriz8[i]=i2c_read();
                        chksum+=matriz8[i];
                    }
                    matriz8[7]=i2c_read(0);
                    i2c_stop();
                    chksum+=matriz8[7];
                    for (i=0;i<=7;i++)
                    {
                        putc(matriz8[i]);
                    }
                    putc(chksum>>8);
                    putc(chksum);
                }
            }
        }

        //Configuración y activación de la sonda
        else if (cmpStr(&comandos[2][0],s)){
            printf("OK");
            t=0;
            anio=0;
            while(t<20&&anio==0){
                t+=1;
                anio=getc();
            }
            chksum=anio;
            mes=getc();
            chksum+=mes;
            dia=getc();
            chksum+=dia;
            horas=getc();
            chksum+=horas;
            minutos=getc();
            chksum+=minutos;
            segundos=getc();
            chksum+=segundos;
            isample=getc();
            chksum+=isample;
            isave=getc();
            chksum+=isave;
            chkrcv=getc();
            chkrcv=chkrcv<<8;
            chkrcv=chkrcv+getc();
            if (chkrcv==chksum&&chksum!=0){
                printf("OK");
                //guardo parámetros
                i2c_start();
                i2c_write(0xa0);
                i2c_write(0);
                i2c_write(1);
                //guardo isample
                i2c_write(isample);
                //guardo isave
                i2c_write(isave);
                //guardo año
                i2c_write(anio);
                //mes
                i2c_write(mes);
                //dia
                i2c_write(dia);
                //horas
                i2c_write(horas);
                //minutos
                i2c_write(minutos);
                //segundos
                i2c_write(segundos);
                i2c_stop();
                i2c_start();
                status=i2c_write(0xa0);
                while(status==1){
                    i2c_start();
                    status=i2c_write(0xa0);
                }      
                //Configuracion RTC
                i2c_start();
                //byte de control del reloj, con escritura
                i2c_write(0b11010000);
                //inicializando el puntero a la direccion cero
                i2c_write(0);
                //configuración de fecha & parámetros
                i2c_write(0);//segundos
                i2c_write(0);
                i2c_write(0);
                i2c_write(1);
                i2c_write(1);
                i2c_write(1);
                i2c_write(0);
                i2c_write(0b00010000);
                i2c_write(0x13);
                i2c_stop();
                memoria_llena=0;
                //presion a nivel del mar
                //write_ext_eeprom(0x09,0x27);
                //write_ext_eeprom(0x0a,0x94);
                //dirección inicial
                write_ext_eeprom(0x0b,0);
                write_ext_eeprom(0x0c,0x40);
                iniVariables();
                cfgSensores();
                delay_ms(20000);
                realiza_lectura();
                presInt=presion;
                i2c_start();
                i2c_write(0xa0);
                i2c_write(0x00);
                i2c_write(0x09);
                i2c_write(presInt>>8);
                i2c_write(presInt);
                i2c_stop();
                i2c_start();
                status=i2c_write(0xa0);
                while(status==1)
                {
                    i2c_start();
                    status=i2c_write(0xa0);
                }
                printf("OK");
                output_low(indicador);
                ENABLE_INTERRUPTS(INT_EXT);
                ENABLE_INTERRUPTS(GLOBAL);
                while(True);
                }
            else{
                printf("ER");
            }
        }
        //calibración
        else if (cmpStr(&comandos[3][0],s)){
            printf("OK");
            delay_ms(5000);
            output_high(indicador);
            delay_ms(100);
            calStart();
            delay_ms(3500);
            calEnd();
            output_low(indicador);
        }
        //muestra
        else if (cmpStr(&comandos[4][0],s)){
            //configuracion y lectura de v2xe
            output_low(habilitador);
            delay_us(10);
            output_low(pin_sync);
            setup_spi(spi_master|SPI_L_TO_H|SPI_CLK_DIV_64|SPI_XMIT_L_TO_H);
            output_high(pin_sync);
            delay_us(15);
            output_low(pin_sync);
            delay_us(15);
            configura_v2xe();
            delay_ms(100);
            lee_datos_v2xe();
            val8h=x_calibrado*60;
            val8l=y_calibrado*60;
            chksum=(int16)val8h+(int16)val8l;
            putc(val8h);
            putc(val8l);
            putc(chksum>>8);
            putc(chksum);
        }

        //envia parámetros
        else if(cmpStr(&comandos[5][0],s)){
            printf("OK");
            i2c_start();
            i2c_write(0xa0);
            i2c_write(0);
            i2c_write(1);
            i2c_start();
            i2c_write(0xa1);
            chksum=0;
            for (i=1;i<=0xB;i++)
            {
                matriz8[i]=i2c_read();
                chksum+=matriz8[i];
            }
            matriz8[0xC]=i2c_read(0);
            i2c_stop();
            chksum+=matriz8[0xC];
            for (i=1;i<=0xC;i++)
            {
                putc(matriz8[i]);
            }
            putc(chksum>>8);
            putc(chksum);
        }
    }//while
}//main
//implementar rutina de checksum