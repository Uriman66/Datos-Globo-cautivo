#!/usr/bin/env python3
# coding= utf-8
#funciones para uso de los módulos de radio DIGI
import serial
import time
import platform
import glob
import serial.tools.list_ports # Import the list_ports module

class digiError(Exception):
    pass

class noAns(digiError):
    '''error cuando el módulo digi no responde'''
    pass

class digi(serial.Serial):
    def __init__(self,*args,**kw):
        serial.Serial.__init__(self,*args,**kw)

    def write(self,objw):
        '''amplia write para aceptar cadenas'''
        if isinstance(objw,str):
            objw=objw.encode('latin1')
        return serial.Serial.write(self,objw)

    def read(self,size=1):
        '''amplia read para regresar cadenas'''
        ans=serial.Serial.read(self,size)
        return ans.decode('latin1')

    def readbytes(self,size=1):
        '''read original'''
        return serial.Serial.read( self,size)

    def modoComando(self):
        '''ingresa al modo comando del Xbee'''
        #devuelve True si se ha ingresado correctamente
        self.flushInput()
        self.flushOutput()
        time.sleep(0.1)
        self.write('+++')
        if self.read(3)!='OK\r':
            for n in range(0,3):
                time.sleep(1)
                self.write('+')
            time.sleep(1)
            if self.read(3)!='OK\r':
                raise noAns('El módulo DIGI no responde')
        return True

    def setModoC(self,modo):
        '''cambia el tiempo de guarda para comandos AT'''
        #modo='fast' GT=18
        #modo='normal' GT=3e8
        #regresa False en caso de algun error en el cambio
        #regresa None en caso de error de modo
        dicModo={
            'fast':'18',
            'normal':'3e8',
            'over':'ce5'
            }
        self.modoComando()
        ans=self.enviaAT('GT'+dicModo[modo])
        self.enviaAT('WR')
        self.enviaAT('CN')
        return True

    def enviaAT(self,*cmds):
        '''envia los comandos AT especificados'''
        #regresa la respuesta del módulo
        #previamente debe estar en modo comandos AT
        ansL=[]
        if cmds==[]:
            cmds.append('')
        for comando in cmds:
            comando='AT'+comando+'\r'
            self.write(comando)
            ansB=''
            ans=''
            while ansB!='\r':
                ansB=self.read()
                if ansB=='':
                    raise noAns('No hay respuesta al comando')
                ans=ans+ansB
            if ans=='ERROR\r':
                raise ValueError('El comando respondió con un error')
            ansL.append(ans)
        return ansL

    def cambiarDir(self,canal,wr=False):
        '''cambia el módulo Xbee al canal proporcionado,
        regresa True en un cambio exitoso'''
        #wr especifica si se guarda el cambio de manera permanente
        self.modoComando()
        if wr:
            self.enviaAT('DL'+canal,'MY'+canal,'WR','CN')
        else:
            self.enviaAT('DL'+canal,'MY'+canal,'CN')
        return True

    def scanNomPtos(self):
        """revisa por los puertos disponibles.
        Regresa una lista de nombres (strings)."""
        puertos = []
        # Use serial.tools.list_ports.comports() for a robust and cross-platform scan
        for port_info in serial.tools.list_ports.comports():
            try:
                # port_info.device gives the port name as a string (e.g., 'COM1', '/dev/ttyUSB0')
                s = serial.Serial(port_info.device)
                puertos.append(s.portstr) # s.portstr is already a string
                s.close()
            except (serial.SerialException, OSError): # Catch specific exceptions
                pass
        return puertos

    def hayDigi(self,ptos):
        '''Detecta si hay algún DIGI en la lista de puertos'''
        found_digi_port = None # Initialize to None
        for pto in ptos:
            # Ensure pto is a string for serial.Serial
            if not isinstance(pto, str):
                pto = str(pto) # Convert to string if it somehow isn't already

            odigi = None # Initialize odigi for each iteration
            try:
                odigi=digi(pto,timeout=0.3)
                odigi.modoComando()
                odigi.enviaAT('CN')
                found_digi_port = pto # Found a DIGI, store the port name
                break # Exit loop once found
            except (serial.SerialException, noAns, digiError, ValueError, OSError):
                # Catch specific exceptions that might occur during communication
                pass
            finally:
                if odigi and odigi.is_open:
                    odigi.close() # Ensure port is closed even if an error occurs

        return found_digi_port # Return the found port or None


if __name__ == '__main__':
    def decName(f):
        def ret(*arg):
            print('Ejecutando:', end=' ')
            for argm in arg:
                print('AT',argm,sep='',end='\t')
            a=f(*arg)
            print('\nRespuesta:',a)
            return a
        return ret

    odigi=digi()
    #decorando envio de comandos AT
    odigi.enviaAT=decName(odigi.enviaAT)
    lpuertos=odigi.scanNomPtos()
    print('Puertos Disponibles:')
    for pto in lpuertos:
        print(pto)
    npto=odigi.hayDigi(lpuertos)
    odigi.port=npto
    if npto!=None:
        print('DIGI encontrado en:',npto)
    else:
        print('DIGI no encontrado')

    # Only attempt to open if a port was found
    if odigi.port:
        try:
            odigi.open()
            odigi.modoComando()
            #odigi.enviaAT()
            odigi.enviaAT('VR','HV','DB','MY','DL','CN')
        except (serial.SerialException, noAns, digiError, ValueError, OSError) as e:
            print(f'An error occurred during DIGI communication: {e}')
        finally:
            if odigi.is_open:
                odigi.close()
    print('Fin de la ejecución de prueba.')
