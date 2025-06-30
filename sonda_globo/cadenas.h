//Libreria para manejo de cadenas
char *ind[10];
void separaStr(char *cadena)
///devuelve subcadenas separadas por un espacio
///obtenidas de la cadena proporcionada
{
char *cStr;
int cont;
ind[0]=cadena;
cont=0;
for (cStr=cadena;*cStr!=0;cStr++)
	{
	if (*cStr==' ')
		{
		*cStr='\0';
		cont++;
		ind[cont]=cStr+1;
		}
	}
//return (ind);
}
int cmpStr(char *cadena1,char *cadena2){
//compara dos cadenas
   while (*cadena1==*cadena2){
       if (*cadena1 == 0)
         return(True);
       cadena1++;
       cadena2++;
   }
   return(False);
}

//revisar utilidad
///int cmp_str_mtx(char *cadena_cmp)
///Esta función compara una cadena con un arreglo
///de cadenas, devuelve el no de renglón en el que
///se encontró la coincidencia. -1 sino hay coincidencia
///debe declarase previamente el arreglo que se 
///usará en la comparación de la forma:
///const int8 palabras[8][11] = {
/// "ACKOFF",
/// "ACKON",
/// "AUTOn ",
/// "Axxxxxxxxx",
/// "BAUDn ",
/// "Bxxxxxxxxx",
/// "CAL_ONn ",
/// "xxxxxxxxxx" 
///También se deben definir
///#define renglon_max 3
///#define columna_max 10
// {
// 	int ren_str,col_str;
// 	char c_str;
// 	c_str=1;
// 	ren_str=0;
// 	while (ren_str<renglon_max)
// 	{
// 	for (col_str=0;c_str!=0&&col_str<columna_max;col_str++)
// 		{
// 			c_str=*(cadena_cmp+col_str);
// 			if (palabras[ren_str][col_str]!=c_str)
// 				col_str=columna_max;
// 			else if(c_str==0)
// 				return ren_str;
// 		}
// 		ren_str++;
// 	}
// 		return -1;
// }

void getStr0(char* s, unsigned int8 max) {
//obtiene una cadena terminada en cero
//o un máximo de caracteres (max)
char c;
unsigned int8 len;
    len=0;
    do{
       c=getc();
       s[len++]=c;
    }while(c!=0&&len<=max);
}