#!/usr/bin/env python
# coding= utf-8
#funciones para ventanas de uso común en instrumentación
import instru
import datetime
import math

def obtenCanal():
    cn=input('Indica canal: ')
    try:
        return int(cn)
    except ValueError:
        return None


gral=instru.pto232()
#obtengo nombre de puerto
print(gral.creaElegirPto())
#configuración de puerto
gral.puerto.baudrate=9600
gral.puerto.timeout=0.2
gral.puerto.open()
canal=obtenCanal()
if canal != None:
    if gral.cambiaCanal(canal)==0:
        gral.puerto.write(b's')
        if b's'==gral.puerto.read(1):
            gral.puerto.write(b't')
            answ=gral.puerto.read(1)
            chkcalc=0
            answ=0
            info=[]
            for i in range(0,11):
                answ=int.from_bytes(gral.puerto.read(1),byteorder='big')
                chkcalc=chkcalc+answ
                if i<6:
                    answ=gral.bcd2dec(answ)
                info.append(answ)
            chk=int.from_bytes(gral.puerto.read(2),byteorder='big')
            if chk==(chkcalc&0xffff):
                fechahora=datetime.datetime(info[5]+2000,
                        info[4],info[3],info[2],info[1],info[0])
                pbase=info[7]+(info[6]<<8)
                hbase=44330*(1-((pbase/10132.5)**0.19))
                mfin=info[9]+(info[8]<<8)
                print(fechahora,int(hbase),mfin,info[10])
            else:
                print('error recepcion cabecera')
                exit()
            arch= open(fechahora.strftime('%y%m%d%H%M%S')+'.cca','w')
            encabezado='Instrumentación Meteorológica,\n\
Centro de Ciencias de la Atmósfera,\n U.N.A.M.\n\
Información de Muestreo\n\
fecha: {}\nhora: {}\naltura base aprox.:{} m.s.n.m.\n\
Intervalo de muestreo: {} s\n\
Hora\tTemp.\tHumedad\tPresión\tDir.Viento\tVel.Viento\tAltura\n'.format(fechahora.date(), fechahora.time(),int(hbase),info[10])
            arch.write(encabezado)
            hora=datetime.timedelta(hours=fechahora.hour,
                    minutes=fechahora.minute,
                    seconds=fechahora.second)
            mem=64
            while(mem<mfin-8):
                mem=int.from_bytes(gral.puerto.read(2), byteorder='big')
                tem=int.from_bytes(gral.puerto.read(2), byteorder='big')
                hum=int.from_bytes(gral.puerto.read(1), byteorder='big')
                prs=int.from_bytes(gral.puerto.read(2), byteorder='big')
                cns=int.from_bytes(gral.puerto.read(1), byteorder='big')
                ceo=int.from_bytes(gral.puerto.read(1), byteorder='big')
                h=44330*(1-((prs/10132.5)**0.19))
                if cns>127:
                    cns=cns-256
                if ceo>127:
                    ceo=ceo-256
                cns=cns/5.0
                ceo=ceo/5.0
                vel=((cns**2)+(ceo**2))**0.5
                dirv=math.atan2(ceo,cns)
                dirv=math.degrees(dirv)
                if dirv<0:
                    dirv+=360
                arch.write('{}\t{:.1f}\t{}\t{:.1f}\t{:.1f}\t{:.1f}\t{}\n'\
                .format(hora,tem/10.0, hum,prs/10.0,dirv,vel,int(h-hbase)))
                hora=hora+datetime.timedelta(seconds=int(info[10]))
        else:
            print('error en respuesta sonda')
    else:
        print('error en receptor')
else:
    print('error en canal')
arch.close()
gral.puerto.close()
