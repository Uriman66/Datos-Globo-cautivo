//*******************************
//Definicion de pines del micro
//*******************************
//canales analógicos
#define canal_an1 pin_a0
#define canal_an2 pin_a1
#define canal_an3 pin_a2
//pines a3 a a4 no utilizados aun
//habilitador para v2xe/ms5540
#define habilitador pin_a5
//define el led indicador
#define indicador pin_c0
//pin para boton de inicio-fin de calibr
#define pin_calibracion pin_C1
//pin reset de brujula
#define pin_sync pin_c2
//Los siguientes pines son fijos:
//pin c3 clk para SPI
//pin c4 MOSI para SPI
//pin c5 MISO para SPI
//bus de datos para sht
#define datos pin_c6
//reloj para comunicaci�n con sht
#define clk pin_c7
//interrupci�n externa cada segundo
#define pulso_muestreo pin_b0
//entrada de pulsos
#define pulsos1 pin_b1
//pin b2 y b3 no utilizados aun
//pin b4 y b5 utilizados para comunicacion rs232
//pin b6 y b7 utilizados para comunicacion i2c
//direccion de inicio de escritaura en memoria externa
#define dir_ini 64
//**********************
//Librerias utilizadas
//**********************
#include <stdlib.h>
#include <math.h>
//librerias de sensores
#include <shtxx.c>
#include <v2xe.c>
#include <ms5540.c>
//rutinas mat
#include <rutinas.c>
//memoria externa
#include <24256est.c>
//manejo de cadenas
#include <cadenas.h>

//parámetros de configuración
//fecha
unsigned int segundos,minutos,horas,dia,mes,anio;
//intervalos
unsigned int isave,isample;
//localidad en memoria
unsigned long dir_mem;
//banderas
int1 memoria_llena;
//contadores
unsigned int cuenta_seg,cMuestras;
//Declaración de Variables de lecturas instantaneas
long presion;
unsigned long presInt;
int16 no_pulsos;
long analogico0,analogico1;
int16 temperatura,humedad;
float cvns,cvew;
//Variables acumulativas
float Wnsac,Wewac;
long long Pac,Tac;
long HRac,Aac;
//Variables finales
signed long Tp,Pp;
int AN1p,HRp,WS,WD;
//Funciones
void parpadea(void);
void realiza_lectura(void);
void envia_datos(void);
void iniVariables();