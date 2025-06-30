from tkinter import *

master = Tk()

w = Canvas(master, width=200, height=100)
w.grid()

w.create_line(10, 20, 10, 20,fill='red')
w.create_line(0, 100, 200, 0, fill="red", dash=(4, 4))

w.create_rectangle(50, 25, 150, 75, fill="blue")

mainloop()
