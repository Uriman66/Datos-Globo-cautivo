VERSION 5.00
Begin VB.Form Form2 
   Caption         =   "Form2"
   ClientHeight    =   2400
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5820
   LinkTopic       =   "Form2"
   ScaleHeight     =   2400
   ScaleWidth      =   5820
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Boton_Enviar_Click()
texto_salida = vref.Text + "@"
Form1.MSComm1.Output = texto_salida

'Al escribir en la propiedad Output, se envian
'los datos desde el puerto al exterior.
'debo proteger frente a errores para que el programa
'no aborte.
On Error GoTo Error_Enviando


GoTo Salir

Error_Enviando:
   MsgBox "Ocurrió un error al intentar enviar"
   MsgBox "Visual Basic detectó: " + Err.Description
   label_envio = "Ocurrió error al enviar"
   
   Resume Salir

   
Salir:

Exit Sub
maneja_err:
MsgBox Err.Description


End Sub




Private Sub Form_Unload(Cancel As Integer)
End
End Sub
