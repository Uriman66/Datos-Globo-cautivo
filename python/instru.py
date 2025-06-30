#!/usr/bin/env python
# coding= utf-8
#funciones para ventanas de uso común en instrumentación
#**pendientes:
#-revisar si esta respondiendo el receptor
from tkinter import *
#from tkinter.ttk import *
import serial
import time
import tkinter.messagebox
import datetime
class pto232:
    def __init__(self):
        '''inicialización de variables'''
        #inicializa puerto serie
        self.puerto=serial.Serial()
        #lista de sensores
        self.sensores=[]
        self.senEspera=[]
        #diccionario de loc memoria
        self.locmem={}
        #parámetros de los sensores
        self.parametros=[]
        #lista de renglones de despliegue tabular
        self.listaRenglones=[]
        #intervalo de canales a buscar
        self.cInicio=10
        self.cFin=13
        #estado de muestreo
        self.emuestreo=True
        #nombres de archivos a crear
        self.archivos=[]
        #dirección de memoria de medida anterior
        self.pamem=0

    def validaF(self,valor,li,ls):
        '''Valida que el valor sea un flotante dentro del intervalo'''
        try:
            t=float(valor)
            if t<float(li) or t>float(ls):
                tkinter.messagebox.showinfo('Instrumentación',
                        'Valor fuera de rango')
            return False
        except ValueError:
            tkinter.messagebox.showinfo('Instrumentación',
                    'Valor no válido')
            return False
        return True
    def cerrarV(self,ventana):
        '''cierra la ventana indicada'''
        ventana.quit()
        ventana.destroy()
    def escribeEntry(self,nEntry,texto):
        """escribe texto nuevo en un widget ENtry"""
        nEntry.config(state='normal')
        nEntry.delete(0,END)
        nEntry.insert(0,texto)
        nEntry.config(state='readonly')

    def creaVtabular(self,ventana,cabecera,nSens):
        '''Crea una ventana tabular,
        de manera predeterminada la primer columna
        es de numeración'''
        #La lista de entradas modificables se encuentran en:
        #self.listaRenglones

        frmCuerpo=Frame(ventana,height=200,width=300)
        frmCuerpo.grid(padx=5,pady=5)
        lblEtiquetas=[]
        for etiq in cabecera:
            lblEtiquetas.append(Label(frmCuerpo,
                                      text=etiq,
#                                      width=10,
                                      justify='center'
                                      ))
            pos=len(lblEtiquetas)-1
            lblEtiquetas[pos].grid(column=0,row=pos)
        for col in range(1,nSens):
            #dibuja casillas de valores
            ntrInfo=[]
            for nren in range(0,len(cabecera)):
                ntrInfo.append(Label(frmCuerpo,
                    width=13,
                    ))
                #print(col,nren)
                ntrInfo[nren].grid(column=col,row=nren)
            self.listaRenglones.append(ntrInfo)
            ntrInfo[0].config(text=str(col))
            #ntrInfo[0].config(state='normal')
            #ntrInfo[0].insert(0,str(col))
            #ntrInfo[0].config(state='readonly')

    def obtieneNomPtos(self):
        """revisa por los puertos disponibles.
        Regresa una lista(nombre)"""
        puertos = []
        for i in range(100):
            try:
                s = serial.Serial(i)
                puertos.append( s.portstr)
                s.close()   
            except serial.SerialException:
                pass
        return puertos
    def asignaPto(self,puertos,ventana):
        self.puerto.port=puertos.get()
        ventana.quit()
        ventana.destroy()
    def eligeEntry(self,lista,texto,tboton):
        popElige=Tk()
        popElige.valor = None
        Label(popElige,
            text=texto).grid(column=0,row=1,padx=5)
        spel=Spinbox(popElige,
            values=lista,
            width=5)
        spel.grid(row=1,column=1,padx=5)
        def leeEntry():
            popElige.valor=spel.get()
            popElige.quit()
            popElige.destroy()
        Button(popElige,
            text=tboton,
            command=leeEntry).grid(row=1, column=2,
                    pady=5,padx=5)
        popElige.mainloop()
        return popElige.valor
        
    def creaElegirPto(self):
        '''crea la ventana para elegir puerto,
        devuelve el nombre del puerto seleccionado y 
        también se almacena en self.puerto.port'''
        ventana=Tk()
        ventana.title('Instrumentación Meteorológica')
        #ventana.overrideredirect(1)
        self.puerto.port=''
        puertos=self.obtieneNomPtos()
        while (puertos==[]):
            ans=tkinter.messagebox.askokcancel(parent=ventana,
            title='Instrumentación',
            message='No se han encontrado puertos disponibles!\n'+
            'Conecte un puerto y presione OK')
            #print('ans=',ans)
            if not ans:
                sys.exit(0)
        puertos=tuple(puertos)
        frm1=Frame(ventana)
            #bd=5,padx=10,pady=5
            #)
        frm1.grid()
        #etiquetas
        lbl1=Label(frm1,
                   text='Se han detectados los siguientes'+
                   ' puertos en su sistema:')
        lbl1.grid(columnspan=6,padx=3,pady=3)
        lbl2=Label(frm1,
                   text='Elija el puerto a utilizar:')
        lbl2.grid(pady=5)
        #spinbox & botones
        spbPuertos=Spinbox(frm1,width=8,justify='center')
        spbPuertos.grid(column=1,row=1,padx=3,pady=3)
        spbPuertos.config(values=puertos)
        btnElige=Button(frm1,text='Elegir',
                        command=lambda:self.asignaPto(spbPuertos,ventana))
        btnElige.grid(column=2,row=1,padx=3,pady=3)
        btnF5=Button(frm1,text='Actualiza',
                     command=lambda:spbPuertos.config(values=tuple(self.obtieneNomPtos())))
        btnF5.grid(column=3,row=1,padx=3)

        #Asignación de botones
        def sube(event):
            spbPuertos.invoke('buttonup')
        def baja(event):
            spbPuertos.invoke('buttondown')
        ventana.bind('<Up>',sube)
        ventana.bind('<Down>',baja)
        ventana.bind('<Return>',lambda e:self.asignaPto(spbPuertos,ventana))
        ventana.mainloop()
        #si la ventana se cierra, termino el programa
        if self.puerto.port=='':
            sys.exit(0)
        return self.puerto.port
    def abreP(self):
        '''Abre el puerto serie asignado al objeto
        verifica primero si ya está abierto'''
        if not self.puerto.isOpen():
            self.puerto.open()

    def modoComando(self):
        """ingresa al modo comando del Xbee,
        se requiere revisar timeout o cambiar GT=0x64,
        devuelve 1 si se ha ingresado correctamente"""
        self.puerto.flushInput()
        self.puerto.flushOutput()
        time.sleep(0.1)
        cadenaC='+++'
        cadenaC=cadenaC.encode('ascii')
        self.puerto.write(cadenaC)
        ok=self.leeOK()
        return ok
    def leeOK(self):
        """lee la cadena OK\r del puerto serie"""
        if self.puerto.read(3)==b'OK\r':
            return 1
        else:
            return 0
    def cambiaCanal(self,canal):
        '''cambia el módulo Xbee al canal indicado'''
        if self.modoComando():
            comando='ATDL'+str(canal)+'\r'
            comando=comando.encode('ascii')
            self.puerto.write(comando)
            self.leeOK()
            comando='ATMY'+str(canal)+'\r'
            comando=comando.encode('ascii')
            self.puerto.write(comando)
            self.leeOK()
            self.puerto.write(b'ATCN\r')
            self.leeOK()
            return 0
        return 1
    def test(self):
        '''realiza una prueba de comunicación'''
        i=3
        tst=b''
        while (i>0 and tst==b''):
            self.puerto.write(b's')
            tst=self.puerto.read(2)
            i-=1
        return(i)
    def gfechahora(self):
        '''obtiene fecha y hora del sensor
        en una lista de 2 cadenas'''
        dt=self.bin2fecha(self.obtieneHoraS())
        try:
            fecha=datetime.datetime(2000+dt[0],dt[1],dt[2],
                        dt[3],dt[4],dt[5])
            return str(fecha.date()),str(fecha.time()),fecha
        except ValueError:
            return '*-*-*','*:*:*',None
    def rmem(self):
        self.puerto.write(b'setpmem\r')
        self.puerto.write(bytes([0,32,32]))
        ans=self.puerto.read(2)
        if ans==b'OK':
            return True
        else:
            return False
    def gmem(self,direc,nB):
        '''pide nB bytes a partir de la dirección direc'''
        self.puerto.write(b'LeeM\r')
        self.puerto.write(direc.to_bytes(2,byteorder='big'))
        self.puerto.write(nB.to_bytes(1,byteorder='big'))
        dirm=int.from_bytes(self.puerto.read(2),byteorder='big')
        mem=[]
        for i in range(0,nB):
            mem.append(int.from_bytes(self.puerto.read(1),
                    byteorder='big'))
        chk=int.from_bytes(self.puerto.read(1),byteorder='big')
        chkc=dirm>>8
        chkc=chkc+(dirm&0xff)
        for imem in mem:
            chkc=chkc+imem
        chkc=chkc&0xff
        #print('gmem',direc,nB,dirm,mem)
        if chk==chkc:
            return mem
        else:
            return None

    def apor100(self,num,total):
        return (num/total)*100

    def obtieneHoraS(self):
        '''obtiene la hora del sensor
        devuelve la siguiente lista:
        [año mes dia hora min seg]'''
        self.puerto.write(b'Ghora\r')
        horafecha=int.from_bytes(self.puerto.read(6),byteorder='big')
        chksumH=int.from_bytes(self.puerto.read(1),byteorder='big')
        chksumHC=0
        for i in range(40,-1,-8):
            chksumHC=chksumHC+((horafecha>>i)&0xff)
        chksumHC=chksumHC&0xff
        if chksumH==chksumHC and chksumH!=0:
            return(horafecha)
        else:
            return -1
    def bcd2dec(self,bcd):
        fdiv=divmod(bcd,16)
        return (fdiv[0]*10)+(fdiv[1])
    def bin2fecha(self,fecha):
        '''convierte una fecha obtenida con obtieneHoraS
        en valores adecuados'''
        fechahora=[]
        fechahorab=[]
        #print(fecha)
        if fecha==-1:
            return [0,0,0, 0, 0, 0]
        else:
            for i in range(40,-1,-8):
                fechahora.append((fecha>>i)&0xff)
            for f in fechahora:
                fdiv=divmod(f,16)
                fechahorab.append((fdiv[0]*10)+(fdiv[1]))
            return fechahorab
    def verificaSinc(self):
        '''verifica la sincronización de la hora'''
        fsen=self.bin2fecha(self.obtieneHoraS())
        if fsen[1]==0:
            return 0
        fsen=datetime.datetime(2000+fsen[0],
                fsen[1],
                fsen[2],
                fsen[3],
                fsen[4],
                fsen[5])
        fnow=datetime.datetime.today()
        dif=(fnow-fsen).total_seconds()
        print(dif)
        if abs(dif)<100:
            return 1
        else:
            return 0
    def obtieneSenVen(self,ventana):

        #popf5auto.mainloop()
        salir=False
        self.abreP()
        while not salir:
            listaSen=self.obtieneSensores()
            if listaSen[0]==[] and listaSen[1]==[]:
                msg='No se han encontrado sensores\n¿Desea buscar nuevamente?'
                ans=tkinter.messagebox.askyesno(parent=ventana,
                title='Instrumentación',message=msg)
                if ans==None:
                    sys.exit(0)
                if not ans:
                    tkinter.messagebox.showinfo(parent=ventana,
                        title='Instrumentación',
                        message='Debe agregar los sensores manualmente')
                    salir=True
            else:
                salir=True
        self.puerto.close()
        
        return listaSen
            
    def obtieneSensores(self):
        """Obtiene los sensores disponibles 
        en el rango de canales dado"""
        sensores=[]
        senEspera=[]
        for i in range(self.cInicio,self.cFin):
            self.cambiaCanal(i)
            tst=self.test()
            self.puerto.write(b'IDsensor\r')
            IDsensor=int.from_bytes(self.puerto.read(2),
                                    byteorder='big')
            chksum=int.from_bytes(self.puerto.read(1),
                                    byteorder='big')
            byteID=divmod(IDsensor,256)
            chksumC=byteID[0]+byteID[1]
            chksumC=chksum%256
            fechahora=self.obtieneHoraS()
            estado=''
            if fechahora!=-1:
                if ((fechahora&0xff)>>7)==1:
                    estado='en espera'
                else:
                    estado='midiendo'
            if chksum==chksumC and IDsensor!=0:
                #guarda las listas de sensores
                if estado=='midiendo':
                    sensores.append(i)
                elif estado=='en espera':
                    senEspera.append(i)
        return (sensores,senEspera)
    def dec2bcd(self,dec):
        '''convierte un decimal a bcd'''
        parte=divmod(dec,10)
        return (parte[0]*16)+parte[1]
    def bcd2dec(self,bcd):
        """convierte un bcd a deciimal"""
        parte=divmod(bcd,16)
        return (parte[0]*10)+parte[1]


    #Sensores SHT
    def vConfig(self,vpadre,canal=None):
        popConfig=Toplevel(vpadre)
        frmCfg=[]
        #frame canal
        frmCfg.append(LabelFrame(popConfig,
                    text='Canal',
                    width=300,
                    padx=15,pady=10))
        lblNSensor=Label(frmCfg[0],
            padx=5,
            pady=5,
            text='Indique el canal:').grid()
        if canal==None:
            spbSenC=Spinbox(frmCfg[0],
                values=self.sensores+self.senEspera,
                width=3
                )
        else:
            spbSenC=Spinbox(frmCfg[0],
                values=[canal],
                state='readonly',
                width=3
                )
        spbSenC.grid(column=1,row=0)
        #frame de intervalo
        frmCfg.append(LabelFrame(popConfig,
                text='Intervalo de almacenamiento',
                padx=15,pady=10))

        lblInt=['Horas','Minutos','Segundos']
        vHoras=[list(range(0,13)),
                list(range(0,60)),
                list(range(0,60))]
        spbh=[]
        for i in range(0,3):
            Label(frmCfg[1],
                text=lblInt[i]).grid(column=i,row=1)
            spbh.append(Spinbox(frmCfg[1],
                        values=vHoras[i],
                        width=3))
            spbh[i].grid(column=i,row=2)
        spbh[1].invoke('buttonup')
        #frame de alertas
        frmCfg.append(LabelFrame(popConfig,
                text='Alertas',
                padx=15,pady=15))
        chkb=[]
        chkval=[]
        alertas=[]
        #chkval=[IntVar ,IntVar ,IntVar, IntVar]
        listaAl=['Temperatura inferior',
                 'Temperatura superior',
                 'Humedad inferior',
                 'Humedad superior']
        i=0

        def habDes():
            n=0
            for chk in chkval:
                if chk.get():
                    alertas[n].config(state='normal')
                    alertas[n].focus_set()
                else:
                    alertas[n].config(state='disabled')
                n+=1

        for lbl in listaAl:
            chkval.append(IntVar())
            chkb.append(Checkbutton(frmCfg[2],
                    text=lbl,
                    command=habDes,
                    var=chkval[i]))
            chkb[i].grid(sticky=W)
            alertas.append(Entry(frmCfg[2],
                    #validate='focusout',
                    width=5
                    ))
            alertas[i].grid(column=1,row=i)
            alertas[i].config(state='disabled')
            i+=1

        #dibuja frames
        i=0
        for frames in frmCfg:
            frames.grid(column=0,row=i,sticky=W+E+N+S)
            i+=1

        #frame de botones
        frmbtn=Frame(popConfig)
        frmbtn.grid()
        def obtParam():
            valores=[]
            nseg=int(spbh[2].get())+\
                 (int(spbh[1].get())*60)+\
                 (int(spbh[0].get())*3600)
            valores.append(nseg)
            #convierte valores
            try:
                if chkval[0].get():
                    valores.append(int(100*(float(alertas[0].get())+39.6)))
                else:
                    valores.append(0xffff)
                if chkval[1].get():
                    valores.append(int(100*(float(alertas[1].get())+39.6)))
                else:
                    valores.append(0xffff)
                if chkval[2].get():
                    valores.append(int(10*float(alertas[2].get())))
                else:
                    valores.append(0xffff)
                if chkval[3].get():
                    valores.append(int(10*float(alertas[3].get())))
                else:
                    valores.append(0xffff)
            except ValueError:
                return None

            #mult=1
            valores.append(1)
            #offt=0
            valores.append(0)
            #mulh=1
            valores.append(1)
            #offh=0
            valores.append(0)
            #nbytes=4
            valores.append(4)
            res=[]
            for v in valores:
                res.append(self.int2bin(v,2)[0])
                res.append(self.int2bin(v,2)[1])
            chksum=0
            for v in res:
                chksum=chksum+v
            res.append(chksum&0xff)
            return res
        def aceptar():
            ans=self.setparamSHT(obtParam(),spbSenC.get())
            if ans==None:
                tkinter.messagebox.showinfo('Instrumentación',
                    'No se logró la configuración,\r\
                    inténtenlo nuevamente',
                    parent=popConfig)
            elif ans==True:
                tkinter.messagebox.showinfo('Instrumentación',
                    'Configuración exitosa',
                    parent=popConfig)
                popConfig.destroy()
            elif ans==False:
                tkinter.messagebox.showinfo('Instrumentación',
                    'Existe algún parámetro erróneo',
                    parent=popConfig)
        Ba=Button(frmbtn,text='Aceptar',
                command=aceptar)
        Bc=Button(frmbtn,text='Cancelar',
                command=popConfig.destroy)
        Ba.grid(row=1,column=0)
        Bc.grid(row=1,column=1)
    def hr2bin(self,hr):
        hc=(hr+4)/0.0405
        return(int(hc))
        
    def int2bin(self,vint,largo):
        '''convierte un entero en n bytes'''
        vint=int(vint)
        print(vint)
        if vint!=0xffff:
            vint=vint.to_bytes(largo,byteorder='big',signed=True)
            return (vint[0]),(vint[1])
        else:
            return (0xff,0xff)

    def setparamSHT(self,param,canal):
        '''envia parámetros para sht'''
        #param=[nseg,t1,t2,h1,h2,mult,offt,mulh,offh,nbytes]
        if param==None:
            return False
        cmd='Sparam'+chr(13)
        self.abreP()
        self.cambiaCanal(canal)
        self.test()
        self.puerto.write(cmd.encode('ascii'))
        for p in param:
            self.puerto.write(p.to_bytes(1,'big'))
        ok=self.puerto.read(2)
        self.puerto.close()
        if ok!=b'OK':
            return None
        return True
        
    def obtieneParam(self,canal):
        '''Obtiene los parámetros en el canal actual
        regresa una lista con la siguiente estructura:
        [ID intervalo T1 T2 H1 H2 chksum]'''
        parametros=[]
        self.cambiaCanal(canal)
        self.test()
        self.puerto.write(b'Gparam\r')
        for i in range(0,6):
            parametros.append(int.from_bytes(self.puerto.read(2),byteorder='big'))
        parametros.append(int.from_bytes(self.puerto.read(1),byteorder='big'))

        chksumC=0
        for i in range(0,6):
            chksumC=chksumC+(parametros[i]>>8)+(parametros[i]&0xff)
        chksumC=chksumC&0xff
        #print(parametros, chksumC)
        if chksumC==parametros[6]:
            return parametros
        else:
            return ['-','-','-','-','-','-','-','-']

    def Vsinc(self,padre):
        popSinc=Toplevel(padre)
        Label(popSinc,
            text='Indique el canal del sensor\ra sincronizar')\
            .grid(columnspan=2,padx=10,pady=5)
        spbcnl=Spinbox(popSinc,values=self.sensores,
            justify='center',width=5)
        spbcnl.grid(row=1,column=0,padx=15)
        def sinc():
            i=0
            ans=''
            while (ans!=b'OK' and i<10):
                ans=self.cfghora(spbcnl.get())
                i=i+1
            print(ans)
            if (ans==b'OK'):
                tkinter.messagebox.showinfo('Instrumentación',
                        '¡Sincronización exitosa!')
            else:
                tkinter.messagebox.showinfo('Instrumentación',
                        'La sincronización ha fallado,\rinténtelo nuevamente')
            #popSinc.quit()
            popSinc.destroy()
        Button(popSinc,text='Sincronizar',
            padx=5,
            command=sinc)\
            .grid(row=1,column=1,pady=5,padx=15)
        #popSinc.mainloop()
    def gfechahoracpu(self):
        fecha=datetime.datetime.today()
        return fecha.strftime('%Y/%m/%d'),fecha.strftime('%X')
    def cfghora(self,canal):
        fecha=datetime.datetime.today()
        fecha2=[]
        fecha2.append(self.dec2bcd(int(fecha.strftime("%y"))))
        fecha2.append(self.dec2bcd(int(fecha.strftime('%m'))))
        fecha2.append(self.dec2bcd(int(fecha.strftime('%d'))))
        fecha2.append(1)
        fecha2.append(self.dec2bcd(int(fecha.strftime('%H'))))
        fecha2.append(self.dec2bcd(int(fecha.strftime('%M'))))
        fecha2.append(self.dec2bcd(int(fecha.strftime('%S'))))
        chk=0
        for n in fecha2:
            chk=chk+n
        fecha2.append(chk&0xff)
        self.abreP()
        self.cambiaCanal(canal)
        self.test()
        self.puerto.write(b'Shora\r')
        self.puerto.write(bytes(fecha2))
        ans=self.puerto.read(2)
        self.puerto.close()
        return ans

    def mideRHbin(self):
        """Realiza la medición de los datos de temperatura
            y humedad"""
        comandos=["Vactual\r"]
        respuesta=[]
        for comando in comandos:
            i=3
            while i>0:
                i-=1
                ntest=self.test()
                if ntest==0:
                    return ['-','-']
                self.puerto.write(comando.encode('ascii'))
                Tresp=int.from_bytes(self.puerto.read(2),byteorder='big')
                Hresp=int.from_bytes(self.puerto.read(2),byteorder='big')
                chksum=int.from_bytes(self.puerto.read(1),byteorder='big')
                byteT=divmod(Tresp,256)
                byteH=divmod(Hresp,256)
                chksumC=(byteT[0]+byteT[1]+byteH[0]+byteH[1])%256
                #print(Tresp,Hresp,chksum,chksumC)
                if chksum==chksumC:
                    respuesta.append(Tresp)
                    respuesta.append(Hresp)
                    break
        if chksum!=chksumC or chksumC==0:
            return ['-','-']
        #Tactual
        respuesta[0]="{0:.2f}".format(self.transforma_t(respuesta[0]))
        #HRactual
        respuesta[1]="{0:.2f}".format(self.transforma_RH(float(respuesta[0]),float(respuesta[1])))
        return respuesta

    def transforma_t(self,t_crudo):
        """transforma un valor de temperatura crudo
        a valor en °C"""
        t_crudo=-39.6+0.01*t_crudo
        return t_crudo
    def transforma_RH(self,tenC,hcrudo):
        """transforma en HR compensada los valores requeridos"""
        hum_lin=-4+(0.0405*hcrudo)-(2.8e-6*(hcrudo**2))
        hum_comp=(tenC-25)*(0.01+80e-6*hcrudo)+hum_lin
        return hum_comp
#if __name__=='__main__':
#    objIns=pto232()
#    #obtengo nombre de puerto
#    print(objIns.creaElegirPto())
#    #configuración de puerto
#    objIns.puerto.baudrate=9600
#    objIns.puerto.timeout=0.2
#    vtab=Tk()
#    ans=True
#    while (ans):
#        objIns.abreP()
#        haySensores=objIns.obtieneSensores(10,12)
#        objIns.puerto.close()
#        if not haySensores:
#            msg='No se han encontrado sensores\n¿Desea buscar nuevamente?'
#            ans=tkinter.messagebox.askyesnocancel(parent=vtab,
#                    title='Instrumentación',message=msg)
#            if ans==None:
#                sys.exit(0)
#         
#    cabecera=[['No.',3],
#                ['Canal',6],
#                ['ID',7],
#                ['Estado',7],
#                ['Temperatura\r[°C]',12],
#                ['Hum. Rel.\r[%HR]',12]]
#    objIns.creaVtabular(vtab,cabecera,15)
#    

    
