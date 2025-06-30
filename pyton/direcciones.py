from tkinter import *
from time import sleep
def dir_veleta(dir_v):
    i_imagen= int((dir_v+11.25)/22.5)
    if i_imagen==16:
        i_imagen=0
    return i_imagen
root=Tk()
marco=Canvas(root,height=400,width=350)
marco.grid()
imagenes=[]
imagenes.append(PhotoImage(file='direcciones/FLECHA00.gif'))
imagenes.append(PhotoImage(file='direcciones/FLECHA22.gif'))
imagenes.append(PhotoImage(file='direcciones/FLECHA45.gif'))
imagenes.append(PhotoImage(file='direcciones/FLECHA67.gif'))
imagenes.append(PhotoImage(file='direcciones/FLECHA90.gif'))
imagenes.append(PhotoImage(file='direcciones/FLECHA112.gif'))
imagenes.append(PhotoImage(file='direcciones/FLECHA135.gif'))
imagenes.append(PhotoImage(file='direcciones/FLECHA157.gif'))
imagenes.append(PhotoImage(file='direcciones/FLECHA180.gif'))
imagenes.append(PhotoImage(file='direcciones/FLECHA202.gif'))
imagenes.append(PhotoImage(file='direcciones/FLECHA225.gif'))
imagenes.append(PhotoImage(file='direcciones/FLECHA247.gif'))
imagenes.append(PhotoImage(file='direcciones/FLECHA270.gif'))
imagenes.append(PhotoImage(file='direcciones/FLECHA292.gif'))
imagenes.append(PhotoImage(file='direcciones/FLECHA315.gif'))
imagenes.append(PhotoImage(file='direcciones/FLECHA337.gif'))
veleta=marco.create_image(0,0,image=imagenes[0],anchor=NW)
for i in range(0,360):
    i_imagen=dir_veleta(i)
    print(i,i_imagen)
    marco.itemconfig(veleta,image=imagenes[i_imagen])
    sleep(0.2)
    root.update()
root.mainloop()