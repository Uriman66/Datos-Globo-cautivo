"""Libreria para realizar graficas"""
from tkinter import *
import math
class grafica:
    def __init__(self,marco,
            #posicion,
            #xm,ym,xb,yb
            escala_x=[0,500,100],
            escala_y=[0,500,100],
            tam=[500,500],
            color='black',
            #nombre,
            ):
        #parametros={}
        #contenedor tipo canvas
        self.marco=marco
        #colores
        self.color=color
        #espacio para ejes
        self.offset_izq=50
        self.offset_der=50
        self.offset_up=30
        self.offset_down=30
        #escala
        #m=px/u
        self.x_min=escala_x[0]
        self.x_max=escala_x[1]
        self.y_min=escala_y[0]
        self.y_max=escala_y[1]
        self.escala_x_paso=escala_x[2]
        self.escala_y_paso=escala_y[2]
        self.escala_xm=tam[0]/(escala_x[1]-escala_x[0])
        self.escala_ym=tam[1]/(escala_y[1]-escala_y[0])
        self.escala_xb=escala_x[0]*self.escala_xm
        self.escala_yb=escala_y[0]*self.escala_ym
        #tamaño total de la ventana
        self.width=tam[1]+self.offset_izq+self.offset_der
        self.height=tam[0]+self.offset_up+self.offset_down
        self.marco.config(width=self.width)
        self.marco.config(height=self.height)
        #dibuja ejes
        self.crea_eje()
        self.crea_eje(lugar='left')
    
    def cambia_coor(self,x,y):
        #ajustando por escala
        x=x*self.escala_xm-self.escala_xb
        y=y*self.escala_ym-self.escala_yb
        #invirtiendo Y y recorriendo por ejes
        y=self.height-y-self.offset_down
        x=x+self.offset_izq
        return x,y
    def cambia_coor_x(self,x):
        x=x*self.escala_xm-self.escala_xb
        x=x+self.offset_izq
        return x
    
    def cambia_coor_y(self,y):
        y=y*self.escala_ym-self.escala_yb
        y=self.height-y-self.offset_down
        return y

    def punto(self,x,y):
        '''coloca un punto en la grafica'''
        x,y=self.cambia_coor(x,y)
        self.marco.create_oval(x,y,x+1,y+1,outline=self.color)
    
    def crea_eje(self,x_i=0,y_i=0,lugar='down'):
        '''
        Dibuja un eje
        '''
        if lugar=='down':
            y_c=self.cambia_coor_y(self.y_min)
            self.marco.create_line(
                self.cambia_coor_x(self.x_min),
                y_c,
                self.cambia_coor_x(self.x_max),
                y_c,
                fill=self.color,
                )
            for x in range(self.x_min, self.x_max+1, self.escala_x_paso):
                x_c=self.cambia_coor_x(x)
                self.marco.create_line(
                    x_c,y_c,
                    x_c,y_c+10,
                    fill=self.color,
                    )
                self.marco.create_text(x_c,y_c+20,
                        text=x,
                        fill=self.color,
                        )
        elif lugar=='left':
            x_c=self.cambia_coor_x(self.x_min)
            self.marco.create_line(
                x_c,
                self.cambia_coor_y(self.y_min),
                x_c,
                self.cambia_coor_y(self.y_max),
                fill=self.color,
                )
            for y in range(self.y_min, self.y_max+1, self.escala_y_paso):
                y_c=self.cambia_coor_y(y)
                self.marco.create_line(
                    x_c,y_c,
                    x_c-10,y_c,
                    fill=self.color,
                    )
                self.marco.create_text(x_c-25,y_c,
                        text=y,
                        fill=self.color,
                        )



if __name__ == "__main__":
    root=Tk()
    marco=Canvas(root)
    marco.grid()
    graf=grafica(marco,
        escala_x=[-10,40,10],
        escala_y=[0,2000,100],
        color='blue',
        )
    graf.punto(20,100.5)
    graf.punto(40,250)
    root.mainloop()