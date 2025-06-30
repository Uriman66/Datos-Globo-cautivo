//Se requiere definir las siguientes constantes en el programa
//principal :
// datos - pin que servirá como bus de datos (pin_c6 si no se especifica)
// clk	- pin utilizado para enviar señal de reloj(pin_c7 si no se especifica)
// t_clk - (duracion de un ciclo de reloj)/4 en [us] (1 sino se especifica)
//***************************************************
#ifndef datos
	#define datos	pin_c6
#endif

#ifndef	clk
	#define clk		pin_c7
#endif
#ifndef t_clk
	#define t_clk 	1
#endif


void ini_trans(void)
{
/////////////////////////////////////
// Genera un inicio de trasmision. //
//       ______         _______    //   
// DATOS:      |_______|           //   
//            ___     ___          //        
// CLK :  ___|   |___|   |_____    //
/////////////////////////////////////
	output_high(datos);
	output_low(clk);
	delay_us(t_clk*2);
	output_high(clk);
	delay_us(t_clk);
	output_low(datos);
	delay_us(t_clk);
	output_low(clk);
	delay_us(t_clk*2);
	output_high(clk);
	delay_us(t_clk);
	output_high(datos);
	delay_us(t_clk);
	output_low(clk);
}

//Reinicio de comunicacion
//________________________________________________           ________
// DATA:                                                       |_________|
//          _    _    _    _    _    _    _    _    _        _____     _____
// CLK : __| |__| |__| |__| |__| |__| |__| |__| |__| |______|     |___|     |___
//
void reinicio_com()
	{
	int i;
	
	output_low(clk);
	output_high(datos);
	delay_us(t_clk*2);
	for(i=0;i<9;i++)
		{
		output_high(CLK);
		delay_us(t_clk*2);
		output_low(clk);
		delay_us(t_clk*2);
		}
	ini_trans();
	}//reinicio

//envia_byte(envia)
//mediante esta función se envia un byte al sht
//envia es el byte a enviar
//regresa la señal ack generada por el sht (0 o 1)
int envia_byte(byte envia)
{
	int i,ack;

	output_low(clk);
	for (i=8;i>0;i--)
	{
		if (bit_test(envia,i-1))
			output_high(datos);
		else
			output_low(datos);
	
		delay_us(t_clk*2);
		output_high(clk);
		delay_us(t_clk*2);
		output_low(clk);
	}
	output_float(datos);
	delay_us(t_clk*2);
	output_high(clk);
	ack=input(datos);
	delay_us(t_clk*2);
	output_low(clk);
	return ack;
}


//Realiza la lectura de dos bytes del sht
//q corresponden a la lectura de temperatura
//o de humedad
//Regresa un entero de 16 bits
int16 lee_2bytes(void)
{
int1 bit_leido;
int16 bytes_leidos=0;
int i;

	output_low(clk);
	output_float(datos);
	while(input(datos));//Espera que el sensor ponga
						//la linea de datos en bajo
	for(i=16;i>0;i--)//Realiza lectura de los 16 bites
	{
		delay_us(t_clk*2);
		output_high(clk);
		delay_us(t_clk);
		bit_leido=input(datos);	
		delay_us(t_clk);
		output_low(clk);
		if (bit_leido)
			bit_set(bytes_leidos,i-1);
		else
			bit_clear(bytes_leidos,i-1);

		if(i==9)//envia ACK
			{
			output_low(datos);
			delay_us(t_clk*2);
			output_high(clk);
			delay_us(t_clk*2);
			output_low(clk);
			output_float(datos);
			}
	}//for
		delay_us(t_clk*2);//envia ACK
		output_high(clk);
		delay_us(t_clk*2);
		output_low(clk);
	return bytes_leidos;
}//fin lectura 2 bytes
	
//Ejemplo de programa que presenta la temperatura y humedad
//mediante LCD
//
//void main()
//	{
//	int16 temperatura,humedad;
//	float temp_en_c, humedad_lineal,humedad_comp;
//	delay_ms(500);
//	lcd_init();
//	lcd_putc("\fIniciando...");
//	delay_ms(500);
//	output_low(clk);
//	output_low(datos);
//	while(1)
//	{
//	
//	reinicio_com();
//	ini_trans();
//	envia_byte(0b00000011);
//	temperatura=lee_2bytes();
//	temp_en_c=-39.60+(.01*temperatura);
//
//	ini_trans();
//	envia_byte(0b00000101);
//	humedad=lee_2bytes();
//	humedad_lineal=-4+(0.0405*humedad)-(0.0000028*humedad*humedad);
//
//	temp_en_c=-39.60+(.01*temperatura);
//	humedad_comp=(temp_en_c-25)*(.01+(.00008*humedad))+humedad_lineal;
//
//	printf(lcd_putc,"\fHum = %f ",humedad_comp);
//	printf(lcd_putc,"\nTemp = %f º",temp_en_c);
//	delay_ms(1000);
//	}
//	}//main
//
//
