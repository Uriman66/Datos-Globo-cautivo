
void WRITE_FLOAT_EEPROM(long int n, float data);
float READ_FLOAT_EEPROM(long int n);
float filtro(float x, float k, int localidad);


void write_float_sd(float data) {

   int i;

   for (i = 0; i < 4; i++)

     i2c_write(*(&data + i) );

}

void WRITE_FLOAT_EEPROM(long int n, float data) {

   int i;

   for (i = 0; i < 4; i++)

     write_eeprom(i + n, *(&data + i) ) ;

}

 

float READ_FLOAT_EEPROM(long int n) {

   int i;

   float data;

   for (i = 0; i < 4; i++)

     *(&data + i) = read_eeprom (i + n);

   return(data);

}

float filtro(float x, float k, int localidad)
{
float yn,yn1;

yn1=read_float_eeprom(localidad);
yn=(yn1*(1-k))+x*k;
write_float_eeprom(localidad,yn);
return(yn);
}


