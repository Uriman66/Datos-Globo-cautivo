#!/usr/bin/env python
# coding= utf-8
#funciones para ventanas de uso común en instrumentación
#import instru
import math
import serial
import time
from tkinter import *
import threading
from datetime import datetime
from datetime import timedelta

def escribeFile(nombre,valores):
    '''
    Escribe una lista de valores en el archivo dado
    '''
    with open(nombre,'a') as f:
        for var in valores:
            f.write(str(var)+' ')
        f.write('\n')

def fDatos(datosraw):
    '''formatea los datos para sonda'''
    cteViento=17.0
    if datosraw[1]==7:
        datos=[
            #0:presión
            ((datosraw[0][0]<<8)+datosraw[0][1])/10.0,
            #1:presion base para altura
            ((datosraw[0][2]<<8)+datosraw[0][3])/10.0,
            #2:viento
            round(datosraw[0][4]/cteViento,1)
            ]
        datos[1]=11901.771*(pow(datos[1],0.19)-pow(datos[0],0.19))
        datos[1]=round(datos[1],1)
        return datos
    
    elif datosraw[1]==11:
        datos=[
            #0:viento
            comp2v(datosraw[0][0],datosraw[0][1]),
            #1:temperatura
            #(((datosraw[0][2]&0b111111)<<8)+datosraw[0][3])*0.04-39.60,
            ((datosraw[0][2]<<8)+datosraw[0][3])*0.04-39.6,
            #2:Humedad relativa
            -4+0.648*datosraw[0][4]-.00072*(datosraw[0][4]**2),
            #3:memoria
            100*((datosraw[0][5]<<8)+datosraw[0][6])/65534,
            #4:analógico0
            #7+(datosraw[0][6]*-0.0265),
            datosraw[0][7],
            #5:analógico1
            datosraw[0][8]*1.23
            ]
        #compensando humedad con temperatura
        datos[2]=(datos[1]-25)*(0.01+0.00128*datosraw[0][4])+datos[2]
        #redondeando a un decimal
        for i,ndato in enumerate(datos):
            if isinstance(ndato,float):
                datos[i]=round(ndato,1)
        
        #correccion en viento
        #if datos[3]>=128:
        #    datos[3]=datos[3]-256
        #datos[3]=datos[3]/5.0
 

        return datos
    
    elif datosraw[1]==21:
        datos=[
            #0:fecha
            '-/-/-',
            #1:hora
            '-:-:-',
            #2:altura
            ((datosraw[0][17]<<8)+datosraw[0][18])/10,
            #3:temperatura
            (((datosraw[0][0]&0b111111)<<8)+ datosraw[0][1])*0.04-39.6,
            #4:HR
            -4+0.648*datosraw[0][2]-.00072*(datosraw[0][2]**2),
            #5:Presión
            ((datosraw[0][3]<<8)+datosraw[0][4])/10,
            #6:Dirección
            datosraw[0][6],
            #7:Velocidad
            datosraw[0][5]/cteViento,
            #8:Ozono
            datosraw[0][7]*1.23,
            #9:Memoria
            (datosraw[0][8]<<8)+datosraw[0][9],
            #10:isave
            datosraw[0][16]
            ]
        #compensando humedad con temperatura
        datos[4]=(datos[3]-25)*(0.01+0.00128*datosraw[0][2])+datos[4]
        #recalculando dirección
        if datos[6]>90:
            datos[6]-=256
        if (datosraw[0][0]>>7):
            datos[6]=180+datos[6]
        if datos[6]<0:
            datos[6]+=360
        #redondeando a un decimal
        for i,ndato in enumerate(datos):
            if isinstance(ndato,float):
                datos[i]=round(ndato,1)
        #calculando fecha
        fechaBase=datetime(datosraw[0][10]+2000,
                    datosraw[0][11],
                    datosraw[0][12],
                    datosraw[0][13],
                    datosraw[0][14],
                    datosraw[0][15])
        tiempo=timedelta(seconds=20+datos[10]*(datos[9]-64)/8)
        fecha=fechaBase+tiempo
        datos[0]=fecha.date()
        datos[1]=fecha.time()
        #calculando altura
        datos[2]=11901.771*(pow(datos[2],0.19)-pow(datos[5],0.19))
        datos[2]=round(datos[2],1)
        
        return datos
        
    else:
        return None
        
def comp2v(x,y):
    '''convierte de componentes de viento a vector'''
    if x>=128:
        x-=256
    if y>=128:
        y-=256
    try:
        heading=math.degrees(math.atan(y/x))
        if x>0 and y>0:
            heading=360-heading
        if x>0 and y<0:
            heading=-heading
        if x<0:
            heading=180-heading
    except ZeroDivisionError:
        if y<0:
            heading=90
        else:
            heading=270
    #print('c=',x,y,int(heading),(((x**2)+(y**2))**0.5)/60)
    return heading
        
def showVar(variables,valores,unidades,marco):
    '''crea una ventana que muestra los datos'''
    etqVar=[]
    etqVal=[]
    etqUni=[]
    mvar=Frame(marco) 
    mvar.grid()
    mval=Frame(marco)
    mval.grid(column=1,row=0) 
    muni=Frame(marco)
    muni.grid(column=2,row=0)
    i=0
    fuente=("Helvetica", 18, "bold")
    for var in variables:
        etqVar.append(Label(mvar,
            text=variables[i],
            anchor='e',
            width=10,
            font=fuente))
        etqVar[-1].grid()
        etqVal.append(Label(mval,
            text=valores[i],
            font=fuente,
            width=10))
        etqVal[-1].grid()
        etqUni.append(Label(muni,
            text=unidades[i],
            anchor='w',
            width=6,
            font=fuente))
        etqUni[-1].grid()
        i+=1
    return etqVal

def actualiza(etq,valores):
    '''cambia el texto en etq'''
    i=0
    for valor in valores:
        if valor!=None:
                etq[i].config(text=valor)
        i+=1

def leepaq(puerto,maxbytes=14):
    '''lee un paquete de datos verificando el checksum'''
    ans=puerto.read(maxbytes)
    lenpq=len(ans)
    #if lenpq!=0:
        #print(ans,lenpq)
    chk=None
    if lenpq>=3:
        ansLs=list(ans[0:-2])
        chk2=0
        for b in ansLs:
            chk2=chk2+b
        chk2=chk2&0xffff
        chk=int.from_bytes(ans[lenpq-2:lenpq],'big')
        if chk==chk2:
            return ans,lenpq
        else:
            return None,lenpq
    return None,lenpq

def hilodatos(puerto):
    j=0
    nombre='archivo.cca'
    f=open(nombre,'w')
    f.close()
    locmem=64
    while True:
        #try:
            respuesta=leepaq(puerto,21)
            tbytes[0]=tbytes[0]+respuesta[1]
            if respuesta[0]!=None:
                print(respuesta)
                fres=fDatos(respuesta)
                #print(fres)
                if respuesta[1]==7:
                    tbytes[1]=tbytes[1]+respuesta[1]
                    a=[fres[1],None,None,fres[0],
                        None,fres[2],None,None,
                        None]
                    #presenta datos en ventana
                    actualiza(valI,a)

                elif respuesta[1]==11:
                    tbytes[1]=tbytes[1]+respuesta[1]
                    a=[None,fres[1],fres[2],None,
                        fres[0],None,fres[3],fres[4], fres[5]]
                    #presenta datos en ventana
                    actualiza(valI,a)
                elif respuesta[1]==21:
                    tbytes[1]+=respuesta[1]
                    actualiza(valProm,fres)
                    if locmem<fres[9]:
                        locmem=fres[9]
                        escribeFile(nombre,fres)

            if tbytes[0]==0:
                tbytes[2]=0
            else:
                tbytes[2]=round(100*tbytes[1]/tbytes[0],1)
            actualiza(valSta,tbytes)    
#                respuesta=b''
        #except:
        #    print('*')
         #   break

#Ventana de datos instantáneos

var=['Altura:',
    'Temp.:',
    'Hum. Rel.:',
    'Presión:',
    'Dirección:',
    'Velocidad:',
    'mem',
    'bat',
    'O3'
    ]
val=[]
for v in var:
    val.append('---')
uni=['m',
    '°C',
    '%',
    'mbar',
    '°',
    'm/s',
    '%',
    'V',
    'PPB'
    ]
root=Tk()
root.title('Datos Instantáneos')
valI=showVar(var,val,uni,root)
#Ventana de estadística
vstad=Toplevel(root)
vstad.title('Estadística de recepción')
valSta=showVar(['bytes rec','bytes ok','%'],
            ['','',''],
            ['','',''],
            vstad)
#Ventana de datos promedio
vPromdata=Toplevel(root)
vPromdata.title('Datos promedio')
var=['Fecha:','Hora:',
    'Altura:',
    'Temp.:',
    'Hum. Rel.:',
    'Presión:',
    'Dirección:',
    'Velocidad:',
    'O3:',
    'Memoria:',
    'Intervalo:']
val=[]
for v in var:
    val.append('---')
uni=['','','m','°C','%','mBar','°','m/s','PPB','','']
valProm=showVar(var,val,uni,vPromdata)
#configuración de puerto
puerto=serial.Serial()
puerto.port='/dev/ttyUSB0'
puerto.baudrate=9600
#puerto.timeout=0.05
puerto.timeout=0.005
#puerto.interCharTimeout=0.001
puerto.open()
tbytes=[0,0,0]

t=threading.Thread(target=hilodatos,args=(puerto,))
t.start()

root.mainloop()
puerto.close()
print('fin')

