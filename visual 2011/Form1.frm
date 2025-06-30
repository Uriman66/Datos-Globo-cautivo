VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Object = "{4BFC7EC8-1C67-11D1-9CCD-444553540000}#2.0#0"; "GBAR.OCX"
Begin VB.Form Form_lector 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Lector de Memoria"
   ClientHeight    =   5490
   ClientLeft      =   4695
   ClientTop       =   2190
   ClientWidth     =   7215
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5490
   ScaleWidth      =   7215
   ShowInTaskbar   =   0   'False
   Begin VB.Frame FramePaso2 
      BackColor       =   &H00E0E0E0&
      Caption         =   "PASO 2"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2535
      Left            =   0
      TabIndex        =   15
      Top             =   3000
      Width           =   7215
      Begin VB.OptionButton lect_normal 
         BackColor       =   &H00E0E0E0&
         Caption         =   "Lectura Normal"
         Height          =   255
         Left            =   480
         TabIndex        =   22
         Top             =   600
         Value           =   -1  'True
         Width           =   2055
      End
      Begin VB.TextBox inicio 
         Height          =   285
         Left            =   1800
         TabIndex        =   20
         Text            =   "0000"
         Top             =   1440
         Width           =   615
      End
      Begin VB.CommandButton Boton_Enviar 
         Caption         =   "Iniciar Lectura"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   5760
         TabIndex        =   19
         Top             =   360
         Width           =   1215
      End
      Begin VB.TextBox fin 
         Height          =   285
         Left            =   2760
         TabIndex        =   18
         Text            =   "64535"
         Top             =   1440
         Width           =   735
      End
      Begin VB.OptionButton lect_inte 
         BackColor       =   &H00E0E0E0&
         Caption         =   "Intervalo  (max 64535)"
         ForeColor       =   &H80000008&
         Height          =   495
         Left            =   480
         TabIndex        =   17
         Top             =   1320
         Width           =   1215
      End
      Begin VB.OptionButton lect_com 
         BackColor       =   &H00E0E0E0&
         Caption         =   "Lectura Completa de la Memoria"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   480
         TabIndex        =   16
         Top             =   960
         Width           =   2655
      End
      Begin GBAR1.GBar GBar1 
         Height          =   255
         Left            =   1560
         TabIndex        =   23
         ToolTipText     =   "Avance de descarga"
         Top             =   2160
         Width           =   4215
         _ExtentX        =   7435
         _ExtentY        =   450
         ForeColor       =   255
         BackColor       =   14737632
         Value           =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderColor     =   255
      End
      Begin VB.Label Labelpaso2 
         BackColor       =   &H00E0E0E0&
         Caption         =   "Elige el tipo de lectura a realizar"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   480
         TabIndex        =   25
         Top             =   240
         Width           =   4695
      End
      Begin VB.Label Label9 
         BackColor       =   &H00E0E0E0&
         Caption         =   "Progreso"
         Height          =   255
         Left            =   480
         TabIndex        =   24
         Top             =   2160
         Width           =   855
      End
      Begin VB.Label Label6 
         BackColor       =   &H00E0E0E0&
         Caption         =   "a"
         Height          =   255
         Left            =   2520
         TabIndex        =   21
         Top             =   1440
         Width           =   135
      End
   End
   Begin VB.CommandButton Boton_salir 
      BackColor       =   &H00E0E0E0&
      Caption         =   "Cerrar"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   6240
      TabIndex        =   13
      Top             =   240
      Width           =   855
   End
   Begin VB.Frame FramePaso1 
      BackColor       =   &H00E0E0E0&
      Caption         =   "PASO 1"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1935
      Left            =   0
      TabIndex        =   0
      Top             =   1080
      Width           =   7215
      Begin VB.ComboBox Combo_Velocidad 
         Height          =   315
         ItemData        =   "Form1.frx":030A
         Left            =   3840
         List            =   "Form1.frx":032D
         TabIndex        =   6
         Text            =   "Combo_Velocidad"
         Top             =   480
         Visible         =   0   'False
         Width           =   1455
      End
      Begin VB.ComboBox Combo_Puerto 
         Height          =   315
         ItemData        =   "Form1.frx":036D
         Left            =   1200
         List            =   "Form1.frx":037D
         TabIndex        =   3
         Text            =   "Combo_Puerto"
         Top             =   930
         Width           =   1215
      End
      Begin VB.CommandButton Boton_Cerrar 
         Caption         =   "Cerrar Conexión"
         Height          =   495
         Left            =   4680
         TabIndex        =   2
         Top             =   840
         Width           =   1095
      End
      Begin VB.CommandButton Boton_Abrir 
         Caption         =   "Establecer Conexión"
         Height          =   495
         Left            =   3000
         TabIndex        =   1
         Top             =   840
         Width           =   1335
      End
      Begin VB.Label Label_Paso1 
         BackColor       =   &H00E0E0E0&
         Caption         =   "Elige el puerto que se va a utilizar:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   615
         Left            =   480
         TabIndex        =   7
         Top             =   360
         Width           =   4335
      End
      Begin VB.Label Label1 
         BackColor       =   &H00E0E0E0&
         Caption         =   "Puerto:"
         Height          =   255
         Left            =   360
         TabIndex        =   4
         Top             =   960
         Width           =   615
      End
   End
   Begin VB.Frame Frame2 
      BackColor       =   &H00E0E0E0&
      Caption         =   "Barra de Estado"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1095
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   7215
      Begin VB.Timer Timer1 
         Enabled         =   0   'False
         Interval        =   5000
         Left            =   5400
         Top             =   600
      End
      Begin MSCommLib.MSComm MSComm1 
         Left            =   6480
         Top             =   120
         _ExtentX        =   1005
         _ExtentY        =   1005
         _Version        =   327680
         DTREnable       =   -1  'True
         RThreshold      =   1
         SThreshold      =   1
      End
      Begin VB.Label Label_conexion 
         Alignment       =   2  'Center
         BackColor       =   &H00E0E0E0&
         Caption         =   "Sin conexion"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   375
         Left            =   2280
         TabIndex        =   14
         Top             =   600
         Width           =   2655
      End
      Begin VB.Label Label4 
         BackColor       =   &H00E0E0E0&
         Caption         =   "Puerto en uso:"
         Height          =   255
         Left            =   120
         TabIndex        =   12
         Top             =   240
         Width           =   1095
      End
      Begin VB.Label Etiq_Puerto 
         BackColor       =   &H00E0E0E0&
         Caption         =   "Ninguno"
         Height          =   255
         Left            =   1320
         TabIndex        =   11
         Top             =   240
         Width           =   735
      End
      Begin VB.Label Label5 
         BackColor       =   &H00E0E0E0&
         Caption         =   "Velocidad:"
         Height          =   255
         Left            =   3240
         TabIndex        =   10
         Top             =   240
         Width           =   855
      End
      Begin VB.Label Etiq_Velocidad 
         BackColor       =   &H00E0E0E0&
         Caption         =   "-"
         Height          =   255
         Left            =   4320
         TabIndex        =   9
         Top             =   240
         Width           =   1215
      End
      Begin VB.Label Etiq_Estado 
         BackColor       =   &H00E0E0E0&
         Caption         =   "CERRADO"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   2160
         TabIndex        =   8
         Top             =   240
         Width           =   975
      End
   End
End
Attribute VB_Name = "Form_lector"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Private Sub Boton_Enviar_Click()

On Error GoTo Error_Enviando
If lect_normal.Value = True Then
    texto_salida = "n"
Else
    texto_salida = "c"
End If
intervalo = Int((valor_final - valor_inicial) / 100)
If intervalo = 0 Then
    intervalo = 1
End If

MSComm1.Output = texto_salida
num_datos = 0

Close
On Error GoTo Error_Enviando
numarchivo = FreeFile
Open App.Path + "\temporal.txt" For Output As #numarchivo


GoTo Salir

Error_Enviando:
   MsgBox "Ocurrió un error al intentar enviar"
   MsgBox "Visual Basic detectó: " + Err.Description
   Label_conexion = "Ocurrió error al enviar"
   
   Resume Salir

   
Salir:

End Sub

Private Sub Boton_salir_Click()
End
End Sub

'*****************************************************
'************************INICIO***********************
'*****************************************************
Private Sub Form_Load()
' Variables globales, definidas en Module1:
'  velocidad As Integer   Bauds
'  nro_puerto As Integer  Cual puerto uso
'  incluye_salto_carro As Boolean  Enviar o no CR+LF (0x0D y 0x0A)
'  cadena_entrada As Variant  Recibe el texto del control.
'  Inicilización de variables
velocidad = 9600
nro_puerto = 1
Combo_Puerto.ListIndex = 0
Combo_Velocidad.ListIndex = 0

'*** Preparación del objeto MSCOMM1 para recibir *******
'*** y transmitir                                *******
MSComm1.InputLen = 0 ' El valor 0 hace que se lea todo
    ' el contenido del buffer de recepcion que posee
    ' el control MSComm.
    ' Si InputLen valiera 6, se recibirian los primeros 6
    'caracteres de ese buffer, ignorando el resto.
MSComm1.RThreshold = 1 ' al recibir uno o mas caracteres
    'se generará el evento OnComm y la propiedad
    'CommEvent contendrá el valor comEvReceive.
    'La constante comEvReceive vale 2 .

MSComm1.SThreshold = 1 ' al enviar uno o mas caracteres
   'se generará el evento OnComm y la propiedad
   'ComEvent contendrá el valor comEvSend
   'La constante comEvSend vale 1.
'*** Para trabajar con MSCOMM, faltan los siguientes pasos:
'  1) Especificar cual port va a usar:
'     MSComm1.CommPort = 1
'  2) Establecer parámetros de la comunicación:
'     MSComm1.Settings = "9600,N,8,1"
'         velocidad=9600, paridad=No usada,
'         cantidad de bits=8,
'         cantidad de bits de parada (stop bits) = 1
' 9600 baudios, sin paridad, 8 bits de datos y 1 bit de parada.
'  3) Abrir el puerto:
'      MSComm1.PortOpen = True
' Estos 3 pasos se llevan a cabo en el botón llamado
'   Boton_Abrir
'
Etiq_Estado.ForeColor = &HFF&    'Rojo
Etiq_Estado.Caption = "CERRADO"
'Boton_Ayuda_Oculto.SetFocus

End Sub


Private Sub Boton_Abrir_Click()
 'abre un puerto serial
On Error GoTo manejar_errores
    nro_puerto = Combo_Puerto.ListIndex
    nro_puerto = Combo_Puerto.ItemData(nro_puerto)
  MSComm1.CommPort = nro_puerto 'Paso 1: elijo el puerto
  MSComm1.Settings = Str$(velocidad) + ",N,8,1" 'Paso 2:
     ' preparo parámetros de comunicación
  MSComm1.PortOpen = True ' Paso 3: Intento abrir el
   'puerto. Puedo no lograrlo: si no existe, o si otro
   'programa lo está usando. Aquí puede ocurrir un error
   'y saltaría a la etiqueta " manejar_errores "
   recibi_S = False
   Timer1.Enabled = True
   MSComm1.Output = "s"
   Label_conexion.Caption = "Conectando..."
'   MsgBox ("Puerto COM" + Str$(nro_puerto) + ": Abierto")
   Etiq_Puerto.Caption = "COM" + Str$(nro_puerto) + ":"
   Etiq_Velocidad.Caption = Str$(velocidad) + " bauds"
   Etiq_Estado.ForeColor = &HFF00&   'Color verde
   Etiq_Estado.Caption = "Abierto"
   'inicializo variables
   num_errores = 0
   GoTo Salir
  
manejar_errores:
 MsgBox ("Error al intentar abrir COM" + Str$(nro_puerto))
 MsgBox ("Error detectado por Visual Basic: " + Err.Description)
 Resume Salir ' Resume me permite continuar con el programa.
 
Salir:
  
End Sub


Private Sub Boton_Cerrar_Click()
'cierra un puerto serial
On Error GoTo manejar_errores 'Protejo frente al error.
 MSComm1.PortOpen = False 'Puede haber error si
   'intento cerrar un puerto que está en uso por otro
   'programa, entre otras causas.
 'MsgBox ("Puerto COM" + Str$(nro_puerto) + ": cerrado")
 Etiq_Estado.ForeColor = &HFF&     'Rojo
 Etiq_Estado = "CERRADO"
 Label_conexion = "Sin Conexión"
 
 GoTo Salir
 
manejar_errores:
 MsgBox ("Error al intentar cerrar COM" + Str$(nro_puerto))
 MsgBox ("Visual basic detectó: " + Err.Description)
 Resume Salir
 
Salir:
 
End Sub



Private Sub Combo_Velocidad_Click()
Dim vieja_velocidad As Integer
vieja_velocidad = velocidad

velocidad = Combo_Velocidad.ListIndex
velocidad = Combo_Velocidad.ItemData(velocidad)

'Me fijo si el usuario intenta cambiar la velocidad.
If (vieja_velocidad <> velocidad) _
Then MsgBox "Cambió la velocidad. Si el puerto ya estaba abierto," _
+ Chr$(13) + " debe cerrarlo y luego abrirlo antes de usarlo"

End Sub





Private Sub MSComm1_OnComm()
'Aqui se interceptan los eventos que se producen
'durante la comunicación RS232.
'Cada vez que pasa algo relativo al puerto COM
'en uso, cambia el valor de la propiedad CommEvent


If MSComm1.CommEvent = comEvReceive Then
    'Esto se ejecuta cuando se recibe por el puerto
    texto_rec = MSComm1.Input
    valor_inicio = 0
    valor_final = 64535
  Select Case texto_rec
    Case "e"
        num_errores = num_errores + 1
        If num_errores = 20 Then
            MsgBox "Ocurrió un error en la comunicación cierre otros programas abiertos"
            texto_rec = "*"
        End If
        Exit Sub
        
    Case "s"
        recibi_S = True
        texto_rec = ""
            
    Case "i" 'Al recibir una "i" del micro envia la direccion de inicio de lectura
        If lect_inte.Value = True Then
            valor_inicio = inicio.Text
        End If
        texto_salida = valor_inicio + "@"
        On Error GoTo Error_Enviando
        MSComm1.Output = texto_salida
        texto_rec = ""
    
    Case "f" 'Al recibir una "f" del micro envia la dirección de fin de lectura
        If lect_inte.Value = True Then
            valor_final = fin.Text
        End If
        texto_salida = valor_final + "@"
        On Error GoTo Error_Enviando
        texto_rec = ""
        MSComm1.Output = texto_salida
        
    Case "-"
        num_datos = num_datos + 1
    
    If num_datos >= intervalo Then
        GBar1.Value = GBar1.Value + 1
        num_datos = 0
    End If
    Case Else
        If texto_rec = "*" Then
        Close #numarchivo
        GBar1.Value = 100
        MsgBox "Lectura terminada"
    Else
        Print #numarchivo, texto_rec; 'Escribe en el archivo
    End If

 End Select
 
                
   ' MSComm1.Output = texto_rec
            
  
  
  End If
 
If MSComm1.CommEvent = comEvSend Then
   'Esto se ejecuta cuando se envia por el puerto
   
End If
Exit Sub
Error_Enviando:
   MsgBox "Ocurrió un error al intentar enviar"
   MsgBox "Visual Basic detectó: " + Err.Description
   Label_conexion = "Ocurrió error al enviar"
   
End Sub

Private Sub Timer1_Timer()
Timer1.Enabled = False
If recibi_S Then
    Label_conexion.Caption = "Conexión Establecida"
    Label_conexion.ForeColor = &HFF00&
Else
    MsgBox "No se encontró lector," + Chr$(13) + "verifique la conexión"
    Label_conexion.Caption = "No se encontró lector"
    Boton_Cerrar_Click
End If
End Sub
