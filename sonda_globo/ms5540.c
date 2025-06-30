void reset_ms5540 (void)
//secuencia de reset
{       spi_write(0x15);
        spi_write(0x55);
        spi_write(0x40);
        
        }
unsigned long c1,c2,c3,c4,c5,c6;
void ini_ms5540(void)
//Rutina de inicialización del modulo ms5540
{
byte w1_l,w1_h,w2_l,w2_h,w3_l,w3_h,w4_l,w4_h;
unsigned long w1,w2,w3,w4;
        reset_ms5540();
        spi_write(0);
        spi_write(0x1D);//lectura palabra 1
        spi_write(0x50);//
        w1_h=spi_read(0);
        w1_l=spi_read(0);
        w1=make16(w1_h,w1_l);
        spi_write(0x1D);//lectura palabra 2
        spi_write(0x60);//
        w2_h=spi_read(0);
        w2_l=spi_read(0);
        w2=make16(w2_h,w2_l);
        spi_write(0x1D);//lectura palabra 3
        spi_write(0x90);//
        w3_h=spi_read(0);
        w3_l=spi_read(0);
        w3=make16(w3_h,w3_l);
        spi_write(0x1D);//lectura palabra 4
        spi_write(0xA0);//
       
        w4_h=spi_read(0);
        w4_l=spi_read(0);
        w4=make16(w4_h,w4_l);
        c1=w1>>1;
        c2=w3&0x003f;
        c2=c2<<6;
        c2=c2+(w4&0x003f);
        c3=w4>>6;
        c4=w3>>6;
        c5=w2;
        c5=c5>>6;
        if (bit_test(w1,0))
            {bit_set(c5,10);}
    
        c6=w2&0x003f;

}

long lee_5540(void)
//Realiza lectura y calculo de presion
{
float temp_5540,presion;
signed int32 offst,sensitividad,xsensitividad,ut1,dt;
unsigned int tempH,tempL;
long d1,d2;

    //Lectura de d1
    spi_write(0x0f);
    spi_write(0x40);
    while(input(pin_c4));
    tempH=spi_read(0);  
    tempL=spi_read(0); 
    d1=make16(tempH,tempL);
    //Lectura de d2
    spi_write(0x0f);
    spi_write(0x20);
    while(input(pin_c4));
    tempH=spi_read(0);  
    tempL=spi_read(0); 
    d2=make16(tempH,tempL);
    //cálculos
    ut1=(8*c5)+20224;
    dt=d2-ut1;
    temp_5540=200+((dT*(c6+50))/1024);
    offst=((c4-512)*dT)/4096;
    offst=(c2*4)+offst;
    sensitividad=(c3*dT);
    sensitividad=sensitividad/1024;
    sensitividad=c1+sensitividad+24576;
    xsensitividad=((sensitividad*(d1-7168))/16384)-offst;
    presion=(xsensitividad*.03125)+250;
    return ((long)(presion*10.0));
}