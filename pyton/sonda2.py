#!/usr/bin/env python3
# coding= utf-8
#software de sonda instrumentada
import digi
from tkinter import *
import time
import datetime
import threading
import math
from tkinter import messagebox
import sonda_instru
import graficas
from collections import deque

class Spinboxlbl(Frame):
    '''Crea un Spinbox con etiquetas antes y despues'''
    def __init__( self, parent,lbltxt,utxt, **options ):
        Frame.__init__( self, parent )
        
        self._lbl1=Label(self,text=lbltxt)
        self._spbx=Spinbox(self,**options)
        self._lbl2 = Label( self ,text=utxt)

        spc=3
        self._lbl1.grid(padx=spc,pady=spc)
        self._spbx.grid(row=0,column=1)
        self._lbl2.grid(row=0,column=2,padx=spc)
    def get(self):
        return self._spbx.get()

def checksum16(lNum):
    '''calcula el checksum de 16 bits de
    una lista de números dados'''
    #lNum es la lista de números
    sumatoria=sum(lNum)&0xffff
    return sumatoria>>8,sumatoria&0xff

def portada(osonda,contenedor):
    frm=Frame(contenedor)
    frm.grid()
    lblTexto=Label(frm,
            text='Conecte el receptor,\nencienda la sonda,\ny presione aceptar',
            font=fuente,
            #bd=1,relief=SUNKEN,
            )
    lblTexto.grid(pady=5,padx=5,sticky=W+E+N+S)
    def aceptar1():
        frm.destroy()
        paso_ptos(osonda,contenedor)
    btnAC=Button(frm,text='Aceptar',
                command=aceptar1)
    btnAC.grid(
            pady=5,padx=10,
            )
    btnAC.focus_set()

def paso_ptos(osonda,contenedor):
    fuente=("Helvetica", 11, "bold")
    frm=Frame(contenedor)
    frm.grid()
    lblTexto=Label(frm,
            text='Espere...',
            font=fuente,
            )
    lblTexto.grid(padx=10,pady=10,columnspan=2)
    lprtos=Spinbox(frm,width=12)
    lprtos.grid(row=1,column=0,
            padx=5,columnspan=2)
    def aceptar():
        osonda.port=lprtos.get()
        frm.destroy()
        paso_sonda(osonda,contenedor)

    btnAceptar=Button(frm,
            text='Aceptar',
            command=aceptar,
            state=DISABLED,
            )
    btnAceptar.grid(row=2,column=0,
            padx=5,pady=10)
    def actualizar():
        frm.destroy()
        paso_ptos(osonda,contenedor)
        return 0
    btnActualizar=Button(frm,
            text='Actualizar',
            command=actualizar,
            state=DISABLED,
            )
    btnActualizar.grid(column=1,row=2,
            padx=5,pady=10)
    btnAceptar.focus_set()
    frm.update()
    lpuertos=osonda.scanNomPtos()
    lpuertos.append(None)
    lprtos.config(values=tuple(lpuertos))
    if len(lpuertos)==1:
        lblTexto.config(text='No se han encontrado puertos')
        btnActualizar.config(state=NORMAL)
        frm.update()
    else:
        lblTexto.config(text='Puertos encontrados...')
        frm.update()
        osonda.port=osonda.hayDigi(lpuertos)
        for pto in lpuertos:
            if pto!=osonda.port:
                lprtos.invoke('buttonup')
            else:
                break
        osonda.timeout=0.3
        if osonda.port!=None:
            lblTexto.config(text='Receptor encontrado en:')
            btnAceptar.config(state=NORMAL)
            btnActualizar.config(state=NORMAL)
        else:
            lblTexto.config(text='Receptor no encontrado')
        
    return 0

def paso_sonda(osonda,contenedor):
    frm=Frame(contenedor)
    frm.grid()
    Label(frm,text='Puerto:').grid(
        padx=5,pady=10)
    Label(frm,text=osonda.port).grid(
        padx=5,pady=10,row=0,column=1)
    Label(frm,text='Sonda:').grid(
        padx=10,row=1,column=0)
    ntrDir=Entry(frm,width=5)
    ntrDir.grid(padx=5,row=1,column=1)
    frmbtn=Frame(frm)
    frmbtn.grid(columnspan=2,row=2)
    def cpuerto():
        frm.destroy()
        paso_ptos(osonda,contenedor)
        return 0
    Button(frmbtn,text='Cambiar\npuerto',
        command=cpuerto).grid(
            padx=5,pady=5,row=0,column=0)
    Button(frmbtn,text='Auto').grid(
            padx=5,pady=10,row=0,column=1)
    def aceptar():
        osonda.dirS=(ntrDir.get())
        if osonda.dirS.isdigit():
            frm.destroy()
            paso_elige(osonda,contenedor)
        else:
            messagebox.showinfo('Instrumentación',
                'La sonda indicada no es correcta')

    Button(frmbtn,text='Aceptar',
        command=aceptar).grid(
            padx=5,pady=10,row=0,column=2)
    ntrDir.focus_set()
    def cEnter(evento):
        aceptar()
    def cCancel(evento):
        cpuerto()
    ntrDir.bind('<Return>',cEnter)
    ntrDir.bind('<KP_Enter>',cEnter)
    ntrDir.bind('<Escape>',cCancel)

def paso_elige(osonda,contenedor):
    '''
    El usuario debe elegir la acción,
    Verifica datos antes de comenzar
    '''
    #osonda:objeto de tipo sonda
    #contenedor: frame donde se dibujarán los controles
    
    frm=Frame(contenedor)
    frm.grid()
    Label(frm,text='Puerto:').grid(
        row=0,column=0,
        padx=5,pady=2,
        )
    Label(frm,text=osonda.port).grid(
        row=0,column=1,
        padx=5,pady=2,
        )
    Label(frm,text='Sonda:').grid(
        row=1,column=0,
        padx=5,pady=2,
        )
    Label(frm,text=osonda.dirS).grid(
        row=1,column=1,
        padx=5,pady=2,
        )
    def cmd_cambia():
        frm.destroy()
        paso_sonda(osonda,contenedor)

    Button(frm,text='Cambiar',
        command=cmd_cambia).grid(
            row=1,column=2,
            )
    frmbtn=Frame(frm)
    frmbtn.grid(row=2,column=0,columnspan=3)
    def cmd_verifica():
        frm.destroy()
        paso_chk_cal(osonda,contenedor)
    def cmd_dtr():
        frm.destroy()
        paso_dtreal(osonda,contenedor)
    def cmd_rec():
        frm.destroy()
        recupera_datos(osonda,contenedor)
        paso_elige(osonda,contenedor)

    txt_btns=[
        'Configura\nSonda',
        'Datos en\nT. Real',
        'Recolectar\ndatos',
        ]
    cmds=[
        cmd_verifica,
        cmd_dtr,
        cmd_rec,
        ]
    btns=[]
    for i,txt in enumerate(txt_btns):
        btns.append(Button(frmbtn,text=txt,
        command=cmds[i]))
        btns[i].grid(row=0,column=i,
            padx=2,pady=5
            )
    btns[0].focus_set()
    
def recupera_datos(osonda,contenedor):
    '''
    Ventana de diálogo para la recuperación
    de datos de la sonda
    '''
    frm=Frame(contenedor)
    frm.grid()
    lbl_ndir=StringVar()
    Label(frm,
        text='Descargando datos...').grid()
    lbl_avance=Label(frm,textvariable=lbl_ndir)
    lbl_avance.grid(pady=5)
    #def avance():
        #while osonda.avance_datos<65527:
            #lbl_avance.config(text=osonda.avance_datos)
            #contenedor.update()
            #print(osonda.avance_datos)
            #time.sleep(1)
    #t=threading.Thread(target=avance)
    #t.daemon=True
    #t.start()
    
    nombre=osonda.pide_nombre(contenedor)
    if nombre==None:
        return 0
    t=threading.Thread(target=osonda.rec_datos,args=(nombre,lbl_ndir,frm))
    t.daemon=True
    t.start()
    
    #recupera=osonda.rec_datos(nombre,lbl_ndir,frm)
    #if recupera== 0:
        #texto='La recuperación de datos\nha terminado con éxito'
    #elif recupera==1:
        #texto='No se ha podido establecer la comunicación,\nrevise las conexiones e intente de nuevo'
    #elif recupera==2:
        #texto='Se ha perdido la comunicación,\nposiblemente no se hayan guardado todos los datos'
    #messagebox.showinfo('Instrumentación',texto)
    frm.wait_window()
    return 0
        
def paso_chk_cal(osonda,contenedor):
    frm=Frame(contenedor)
    frm.grid()
    fuente=("Helvetica", 16, "bold")
    lblInstruc=Label(frm,
        text='Apunte la sonda hacia el Norte',
        font=fuente)
    lblInstruc.grid(padx=10,pady=5,columnspan=4)
    Label(frm,text='Dirección:',font=fuente).grid(
        row=1,column=0,
        padx=5,pady=5)
    lblDir=Label(frm,text='---',font=fuente)
    lblDir.grid(row=1,column=1,
        padx=5,pady=5)
    direccion=deque()
    def hiloCal():
        repite=True
        osonda.open()
        osonda.cambiarDir(osonda.dirS,True)
        paso=0
        while(repite):
            osonda.write('gSample')
            #time.sleep(0.05)
            cviento=osonda.leepaq(4)
            heading=None
            if cviento[0]==None:
                txtDir='---'
            else:
                heading=osonda.comp2v(cviento[0][0],cviento[0][1])
                txtDir=int(heading)
                if (heading >=paso*90-2 and heading<=paso*90+2):
                    direccion.append(heading)
                elif paso==0:
                    if heading>=358:
                        direccion.append(heading)
                else:
                    direccion.clear()
                print(direccion)
                if len(direccion)==20:
                    paso+=1
                    direccion.clear()
                    if paso==1:
                        texto='Apunte la sonda hacia el este'
                    elif paso==2:
                        texto='Apunte la sonda hacia el sur'
                    elif paso==3:
                        texto='Apunte la sonda hacia el oeste'
                    elif paso==4:
                        texto='¡Verificación exitosa!'
                        btnOK.config(state=NORMAL)
                    lblInstruc.config(text=texto)
                
            try:
                lblDir.config(text=txtDir)
            except:
                repite=False
        osonda.close()
            
    def cCancel():
        frm.destroy()
        paso_elige(osonda,contenedor)
        
    Button(frm,text='Regresar',command=cCancel).grid(
        row=2,column=0)
    def cCalibra():
        frm.destroy()
        paso_cal(osonda,contenedor)
    Button(frm,text='Calibrar',command=cCalibra).grid(
        row=2,column=1)
    def cConfig():
        frm.destroy()
        paso_conf(osonda,contenedor)
    btnOK=Button(frm,text='Configurar',
        command=cConfig,
        state=DISABLED,
        )
    btnOK.grid(row=2,column=2)
    
    t=threading.Thread(target=hiloCal)
    t.start()
    return 0

def paso_cal(osonda,contenedor):
    '''realiza la calibración'''
    fuente=('Helvetica',14)
    frm=Frame(contenedor)
    frm.grid()
    Label(frm,
        text='Coloque la sonda armada y\npresione aceptar',
        font=fuente).grid()
    Button(frm,text='Aceptar',command=frm.destroy).grid()
    contenedor.wait_window(frm)
    frm=Frame(contenedor)
    frm.grid()
    lblInstruc=Label(frm,text='Comience a girar en:',font=fuente)
    lblInstruc.grid()
    n=5
    lblConteo=Label(frm,text=n,font=fuente)
    lblConteo.grid()
    frm.update()
    for i in range(n-1,-1,-1):
        time.sleep(0.99)
        lblConteo.config(text=i)
        frm.update()
    lblInstruc.config(text='Gire la sonda\nmanteniendola horizontal')
    n=3
    lblConteo.config(text=n)
    frm.update()
    for i in range(n-1,-1,-1):
        time.sleep(1.2)
        lblConteo.config(text=i)
        frm.update()
    frm.destroy()
    paso_chk_cal(osonda,contenedor)

def paso_conf(osonda,contenedor):
    frmConfig=Frame(contenedor)
    frmConfig.grid()
    #frames
    frm=LabelFrame(frmConfig,
            text='Información de sonda',
            width=300,height=75,
            )
    frm.grid(columnspan=2,row=0)
    frm.grid_propagate(0)
    Label(frm,text='Puerto:').grid(
        row=0,column=0,
        padx=5,pady=2,
        )
    Label(frm,text=osonda.port).grid(
        row=0,column=1,
        padx=5,pady=2,
        )
    Label(frm,text='Sonda:').grid(
        row=1,column=0,
        padx=5,pady=2,
        )
    Label(frm,text=osonda.dirS).grid(
        row=1,column=1,
        padx=5,pady=2,
        )
    frm1=LabelFrame(frmConfig,
            text='Configuración de hora',
            width=300,height=70)
    frm1.grid(columnspan=2,row=1)
    frm1.grid_propagate(0)
    sinc=BooleanVar()
    Radiobutton(frm1,
            text='Sincronizar con PC',
            variable=sinc,
            value=True,
            ).grid(sticky=W)
    Radiobutton(frm1,
            text='Personalizado',
            variable=sinc,
            value=False,
            ).grid(sticky=W)
    frm2=LabelFrame(frmConfig,
            text='Configuración de medición',
            width=300,height=70)
    frm2.grid(columnspan=2,row=2)
    frm2.grid_propagate(0)
    sinc.set(True)
    iSave=IntVar()
    iSample=IntVar()
    spbImuestreo = Spinboxlbl(frm2,
            lbltxt='Intervalo de muestreo: ',
            utxt='s',
            width=4,
            from_=1,
            to=60,
            textvariable=iSample,
            )
    spbImuestreo.grid(sticky=E)
    spbIalmacena=Spinboxlbl(frm2,
            lbltxt='Intervalo de almacenamiento:',
            utxt='s',
            width=4,
            from_=1,
            to=60,
            textvariable=iSave,
            )
    spbIalmacena.grid(sticky=E)
    def anterior():
        frmConfig.destroy()
        paso_ptos(osonda,contenedor)
    def siguiente():
        osonda.iSave=iSave.get()
        osonda.iSample=iSample.get()
        osonda.sinc=sinc.get()
        osonda.fhora=datetime.datetime.today()
        osonda.fhora=list(osonda.fhora.timetuple()[0:6])
        osonda.fhora[0]=osonda.fhora[0]-2000
        param=osonda.fhora+[osonda.iSample,osonda.iSave]
        param=bytes(param)
        chk16=checksum16(param)
        osonda.open()
        osonda.cambiarDir(osonda.dirS)
        try:
            osonda.envia_s_cmd('config')
            osonda.write(param)
            osonda.envia_s_cmd(bytes(chk16))
            messagebox.showinfo('Instrumentación','¡Configurado')
            osonda.close()
            frmConfig.destroy()
            paso_dtreal(osonda,contenedor)
            return 0
        except sonda_instru.noOkError:
            messagebox.showinfo('Instrumentación',
            'Error en la comunicación,\nintente nuevamente')
            osonda.close()

    Button(frmConfig,
            text='Aceptar',
            command=siguiente,
            ).grid(row=3,column=1)
    Button(frmConfig,
            text='Cancelar',
            command=anterior,
            ).grid(row=3,column=0)
    return 0

def paso_dtreal(osonda,contenedor):
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
    val=['- - -' for i in range(len(var))]
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
    val_i=osonda.showVar(var,val,uni,contenedor)
    #Ventana de datos promedio
    w_promedio=Toplevel(contenedor)
    w_promedio.title('Datos promedio')
    w_promedio.protocol('WM_DELETE_WINDOW',w_promedio.withdraw)
    #Ventanas de graficos
    osonda.fhora=datetime.datetime.today()
    w_grafica_t=Toplevel(contenedor)
    w_grafica_t.title('Gráficas VS tiempo')
    w_grafica_t.protocol('WM_DELETE_WINDOW',
        w_grafica_t.withdraw)
    cnt_graficas_tiempo=Canvas(w_grafica_t,
            #bg='white',
            )
    cnt_graficas_tiempo.grid()
    color_t='OrangeRed2'
    color_tprom='OrangeRed4'
    color_hr='RoyalBlue2'
    color_hr_prom='RoyalBlue4'
    esc_t=[0,3600,300]
    esc_temp=[-10,40,10]
    esc_hum=[0,100,10]
    graf_tprom=graficas.grafica(cnt_graficas_tiempo,
        escala_x=esc_t,
        escala_y=esc_temp,
        color=color_tprom,
        eje_x=['Temp',0],
        eje_y=['Tiem',0],
        ejes_izq=2,
        ejes_der=1,
        tam=[500,600],
        )
    graf_temp=graficas.grafica(cnt_graficas_tiempo,
        escala_x=esc_t,
        escala_y=esc_temp,
        color=color_t,
        eje_x=['Tiempo',1],
        ejes_izq=2,
        ejes_der=1,
        eje_y=['Temp.',-1],
        tam=[500,600],
        )
    graf_hprom=graficas.grafica(cnt_graficas_tiempo,
        escala_x=esc_t,
        escala_y=esc_hum,
        color=color_hr_prom,
        eje_x=['',0],
        ejes_izq=2,
        ejes_der=1,
        eje_y=['',0],
        tam=[500,600],
        )
    graf_hum=graficas.grafica(cnt_graficas_tiempo,
        escala_x=esc_t,
        escala_y=esc_hum,
        color=color_hr,
        eje_x=['',0],
        ejes_izq=2,
        ejes_der=1,
        eje_y=['%RH',-2],
        tam=[500,600],
        )
    w_grafica_h=Toplevel(contenedor)
    w_grafica_h.title('Graficas VS altura')
    w_grafica_h.protocol('WM_DELETE_WINDOW',
        w_grafica_h.withdraw)
    cnt_graficas_h=Canvas(w_grafica_h,
        )
    cnt_graficas_h.grid()
    esc_h=[-10,10,2]
    tam_h=[600,500]
    temp_vs_h=graficas.grafica(cnt_graficas_h,
        escala_x=esc_temp,
        escala_y=esc_h,
        color=color_t,
        eje_x=['Temperatura',1],
        eje_y=['Altura',1],
        ejes_down=2,
        tam=tam_h,
        )
    tprom_vs_h=graficas.grafica(cnt_graficas_h,
        escala_x=esc_temp,
        escala_y=esc_h,
        color=color_tprom,
        eje_x=['Temperatura',0],
        eje_y=['Altura',0],
        ejes_down=2,
        tam=tam_h,
        )
    hr_vs_h=graficas.grafica(cnt_graficas_h,
        escala_x=esc_hum,
        escala_y=esc_h,
        color=color_hr,
        eje_x=['Hum. rel.',2],
        eje_y=['Altura',-1],
        ejes_down=2,
        tam=tam_h,
        )
    hrprom_vs_h=graficas.grafica(cnt_graficas_h,
        escala_x=esc_hum,
        escala_y=esc_h,
        color=color_hr_prom,
        eje_x=['Hum. rel.',0],
        eje_y=['Altura',0],
        ejes_down=2,
        tam=tam_h,
        )
        
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
    val=['- - -' for i in range(len(var))]
    uni=['','','m','°C','%','mBar','°','m/s','PPB','','']
    val_prom=osonda.showVar(var,val,uni,w_promedio)

    #ventana de rosa de vientos
    w_rosa=Toplevel(contenedor)
    w_rosa.title('Dirección del viento')
    w_rosa.protocol('WM_DELETE_WINDOW',w_rosa.withdraw)
    cnt_rosa=Canvas(w_rosa,
                height=350,
                width=350,
                )
    cnt_rosa.grid()
    img_rosa=[
        PhotoImage(file='FLECHA00.gif'),
        PhotoImage(file='FLECHA22.gif'),
        PhotoImage(file='FLECHA45.gif'),
        PhotoImage(file='FLECHA67.gif'),
        PhotoImage(file='FLECHA90.gif'),
        PhotoImage(file='FLECHA112.gif'),
        PhotoImage(file='FLECHA135.gif'),
        PhotoImage(file='FLECHA157.gif'),
        PhotoImage(file='FLECHA180.gif'),
        PhotoImage(file='FLECHA202.gif'),
        PhotoImage(file='FLECHA225.gif'),
        PhotoImage(file='FLECHA247.gif'),
        PhotoImage(file='FLECHA270.gif'),
        PhotoImage(file='FLECHA292.gif'),
        PhotoImage(file='FLECHA315.gif'),
        PhotoImage(file='FLECHA337.gif'),
        ]
    rosa=cnt_rosa.create_image(175,175,
        image=img_rosa[0],
        )
    osonda.timeout=0.005
    osonda.open()
    t=threading.Thread(target=osonda.hilodatos,
            args=(val_i,val_prom,
                graf_temp,graf_hum,
                graf_tprom,graf_hprom,
                cnt_rosa,rosa,img_rosa,
                temp_vs_h,tprom_vs_h,
                hr_vs_h,hrprom_vs_h,
                cnt_graficas_tiempo,
                cnt_graficas_h,
                ))
    t.start()
    root.mainloop()


sonda1=sonda_instru.sonda()
sonda1.timeout=0.005
#creación de ventana
root=Tk()
root.title('Instrumentación Meteorológica')
def cerrar():
    sonda1.terminar=True
    time.sleep(2)
    root.quit()
    root.destroy()
    print('cerrar')

root.protocol('WM_DELETE_WINDOW',cerrar)
#root.geometry('350x215')
fuente=("Helvetica", 14)
frmbarra=Frame(root,width=350,height=2,bd=1,relief=SUNKEN)
frmbarra.grid_propagate(0)
frmbarra.grid()
frmPasos=Frame(root)
frmPasos.grid()
portada(sonda1,frmPasos)
root.mainloop()
print('fin')
#sonda1.close()