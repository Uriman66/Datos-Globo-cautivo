VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{536B6100-C58D-4035-9586-0FE18996EC97}#1.0#0"; "Button-Mac.ocx"
Object = "{27395F88-0C0C-101B-A3C9-08002B2F49FB}#1.1#0"; "PICCLP32.OCX"
Begin VB.Form form_recepcion 
   BackColor       =   &H00FF8080&
   Caption         =   "Recepción de datos"
   ClientHeight    =   8700
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11010
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   11.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00400000&
   LinkTopic       =   "Form1"
   ScaleHeight     =   580
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   734
   StartUpPosition =   3  'Windows Default
   Visible         =   0   'False
   Begin ButtonEstiloMac.ButtonMac boton_cerrar_recepcion 
      Height          =   615
      Left            =   3720
      TabIndex        =   18
      Top             =   480
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   1085
      Caption         =   "Terminar Recepción"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      PicOpacity      =   0
   End
   Begin ButtonEstiloMac.ButtonMac boton_rec 
      Height          =   615
      Left            =   240
      TabIndex        =   17
      Top             =   480
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   1085
      Caption         =   "Iniciar Recepción"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      PicOpacity      =   0
   End
   Begin VB.PictureBox Pic_pres 
      Height          =   495
      Left            =   5280
      ScaleHeight     =   435
      ScaleWidth      =   195
      TabIndex        =   16
      Top             =   2280
      Visible         =   0   'False
      Width           =   255
   End
   Begin VB.PictureBox Pic_altura 
      Height          =   495
      Left            =   4440
      ScaleHeight     =   435
      ScaleWidth      =   195
      TabIndex        =   15
      Top             =   1680
      Visible         =   0   'False
      Width           =   255
   End
   Begin PicClip.PictureClip PClipsubebaja 
      Left            =   4440
      Top             =   2280
      _ExtentX        =   529
      _ExtentY        =   953
      _Version        =   393216
      Picture         =   "form_recepcionxp.frx":0000
   End
   Begin VB.PictureBox Pic_dir 
      AutoSize        =   -1  'True
      Height          =   1215
      Left            =   3960
      ScaleHeight     =   1155
      ScaleWidth      =   1275
      TabIndex        =   14
      Top             =   2880
      Width           =   1335
   End
   Begin PicClip.PictureClip PClip_dir 
      Left            =   3960
      Top             =   2880
      _ExtentX        =   92604
      _ExtentY        =   38629
      _Version        =   393216
      Rows            =   4
      Cols            =   10
      Picture         =   "form_recepcionxp.frx":0722
   End
   Begin VB.Timer Timer_espera_nuevo 
      Enabled         =   0   'False
      Interval        =   700
      Left            =   10200
      Top             =   240
   End
   Begin VB.Timer Timer_unsec 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   9720
      Top             =   240
   End
   Begin MSCommLib.MSComm MSComm1 
      Left            =   8160
      Top             =   240
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      DTREnable       =   -1  'True
      InputLen        =   1
      NullDiscard     =   -1  'True
      RThreshold      =   1
      BaudRate        =   2400
      ParitySetting   =   1
   End
   Begin VB.ComboBox Combo_Velocidad 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      ItemData        =   "form_recepcionxp.frx":4E0464
      Left            =   6480
      List            =   "form_recepcionxp.frx":4E048E
      TabIndex        =   5
      Text            =   "Combo_Velocidad"
      Top             =   240
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.ComboBox Combo_Puerto 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00400000&
      Height          =   315
      ItemData        =   "form_recepcionxp.frx":4E04DA
      Left            =   2160
      List            =   "form_recepcionxp.frx":4E04F0
      TabIndex        =   4
      Text            =   "Combo_Puerto"
      Top             =   600
      Width           =   1215
   End
   Begin VB.CommandButton boton_recx 
      Appearance      =   0  'Flat
      BackColor       =   &H8000000A&
      Caption         =   "Iniciar Recepción"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   480
      MaskColor       =   &H00004040&
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   480
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.Frame Frame_recepcion 
      BackColor       =   &H00FF8080&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   0
      TabIndex        =   1
      Top             =   -120
      Width           =   10575
      Begin VB.TextBox Texto_datos 
         BackColor       =   &H00FF8080&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   375
         Left            =   720
         Locked          =   -1  'True
         TabIndex        =   6
         Text            =   "Esperando..."
         Top             =   120
         Width           =   9255
      End
      Begin VB.Label Label_datos 
         BackColor       =   &H00FF8080&
         Caption         =   "Datos"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   375
         Left            =   120
         TabIndex        =   2
         Top             =   120
         Width           =   615
      End
   End
   Begin VB.CommandButton boton_cerrar_recepcionx 
      Caption         =   "Terminar Recepcion"
      Enabled         =   0   'False
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
      Left            =   3960
      TabIndex        =   0
      Top             =   480
      Visible         =   0   'False
      Width           =   1335
   End
   Begin MSComDlg.CommonDialog dialogoGuardar 
      Left            =   9120
      Top             =   240
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.Label Label_hora 
      Alignment       =   2  'Center
      BackColor       =   &H00FF8080&
      Caption         =   "00:00:00"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   48
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   975
      Left            =   6360
      TabIndex        =   13
      Top             =   600
      Width           =   4215
   End
   Begin VB.Label Label_presion 
      BackColor       =   &H00FF8080&
      Caption         =   "Presion:1000.0 mb"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   615
      Left            =   0
      TabIndex        =   12
      Top             =   2280
      Width           =   4335
   End
   Begin VB.Label Label_humedad 
      BackColor       =   &H00FF8080&
      Caption         =   "Hum: 100.0%"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   615
      Left            =   0
      TabIndex        =   11
      Top             =   5040
      Width           =   3615
   End
   Begin VB.Label Label_temp 
      BackColor       =   &H00FF8080&
      Caption         =   "Temp: 100.0°"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   615
      Left            =   0
      TabIndex        =   10
      Top             =   4440
      Width           =   3135
   End
   Begin VB.Label Label_dir 
      BackColor       =   &H00FF8080&
      Caption         =   "Dir: 360°"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   615
      Left            =   0
      TabIndex        =   9
      Top             =   3720
      Width           =   2775
   End
   Begin VB.Label Label_velocidad 
      BackColor       =   &H00FF8080&
      Caption         =   "Vel:0.0 m/s"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   615
      Left            =   0
      TabIndex        =   8
      Top             =   3000
      Width           =   3615
   End
   Begin VB.Label Label_altura 
      BackColor       =   &H00FF8080&
      Caption         =   "Altura: 1000.0 m"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   615
      Left            =   0
      TabIndex        =   7
      Top             =   1680
      Width           =   4335
   End
End
Attribute VB_Name = "form_recepcion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim transmitiendo As Boolean
Dim texto_tem As String
Dim rec_exor As Boolean
Dim exor_transmitida As Byte
Dim exor_local As Byte
Dim paquete As String 'contiene los datos correctos
Dim caracter_inicio As String 'Define el caracter de inicio de transmision
Dim id As Integer 'contiene id de estacion de acuerdo al segundo en q se encuentre
Dim espera_id As Boolean

Private Function obtener_variables(nom_archivo As String)
    Dim cadena_entera As String
    Dim id_var As Integer
    Dim caracter_actual As String
    Dim caracter_asc As String
    Dim variable_actual As Single
    Dim variable_caracter As String
           
    id_var = 0
    archivo = FreeFile
    Open nom_archivo For Input As #archivo
    caracter_actual = Input(1, #archivo)
    caracter_asc = Asc(caracter_actual)
    'Do While Not EOF(numarchivo) ' Loop until end of file.
    Do While (Not (caracter_asc = 10)) '
            
        cadena_entera = cadena_entera + caracter_actual

        If (caracter_actual = " ") Then
            If (id_var > 1) Then
                variable(id_var) = CSng(variable_caracter)
            End If
            If (id_var = 1) Then
                hora_sonda = variable_caracter
            End If
            variable_caracter = ""
            caracter_actual = ""
            id_var = id_var + 1
        End If
        variable_caracter = variable_caracter + caracter_actual
        caracter_actual = Input(1, #archivo)
        caracter_asc = Asc(caracter_actual)
    Loop
Close #archivo    ' Close file.
    
End Function


Private Sub boton_cerrar_recepcion_Click()
        form_estacion.Visible = True
        form_recepcion.Visible = False
        If MSComm1.PortOpen Then
            MSComm1.PortOpen = False
        End If
        form_recepcion.Visible = False
        form_estacion.Visible = True
        transmitiendo = False
        boton_cerrar_recepcion.Enabled = False
        boton_rec.Enabled = True
        Combo_Velocidad.Enabled = True
        Combo_Puerto.Enabled = True
            Close #numarchivo
            MsgBox "Lectura terminada"
            respuesta = MsgBox("¿Deseas ver el archivo generado?", vbYesNo)
            If respuesta = vbYes Then    '
                val_regresa = Shell("notepad.exe " + nombre_archivo, vbNormalFocus)
            End If
                
End Sub


Private Sub boton_rec_Click()

    
On Error GoTo maneja_errores


    Texto_datos.Text = "Esperando..."
    MsgBox "Proporcione el nombre del archivo" + Chr(13) & Chr(10) + "en donde se guardará la lectura"
    dialogoGuardar.ShowSave
    nombre_archivo = dialogoGuardar.FileName
    Close
    numarchivo = FreeFile
    
    'obtener_variables (nombre_archivo)
    
    Open nombre_archivo For Output As #numarchivo


    nro_puerto = Combo_Puerto.ListIndex
    nro_puerto = Combo_Puerto.ItemData(nro_puerto)
    velocidad = Combo_Velocidad.ListIndex
    velocidad = Combo_Velocidad.ItemData(velocidad)
    velocidad = 9600    'velocidad necesaria para rf
    MSComm1.CommPort = nro_puerto
    MSComm1.Settings = Str$(velocidad) + ",n,8,1" 'Establece la configuración
                                                'de puerto rs232
    boton_cerrar_recepcion.Enabled = True
    boton_rec.Enabled = False
    Combo_Velocidad.Enabled = False
    Combo_Puerto.Enabled = False
    Timer_unsec.Enabled = True
    rec_exor = False
    transmitiendo = False
    espera_id = False
    MSComm1.PortOpen = True
    
    
    Exit Sub
maneja_errores:
    

End Sub



Private Sub Form_Unload(Cancel As Integer)
    Unload form_estacion
End Sub




Private Sub MSComm1_OnComm()
If MSComm1.CommEvent = comEvReceive Then
    'Esto se ejecuta cuando se recibe por el puerto
    On Error GoTo maneja_errores
    
    texto_tem = MSComm1.Input
    Timer_unsec.Enabled = False
    Timer_unsec.Enabled = True
    caracter_inicio = &H21
    a = Asc(texto_tem)
  
    
    If a = caracter_inicio Then
                    paquete = ""
                    espera_id = True
                    transmitiendo = True
                    Timer_espera_nuevo.Enabled = True
                    exor_local = Asc(texto_tem)
                    Exit Sub
    Else
        If transmitiendo Then
        
            If espera_id Then
                espera_id = False
                id = a
            End If
        
                If a = 10 Then
                paquete = paquete + Chr(13) & Chr(10)
                    Timer_espera_nuevo.Enabled = False
 
                    transmitiendo = False
                    rec_exor = True
                    exor_local = exor_local Xor Asc(texto_tem)
                    Exit Sub
                Else
                    paquete = paquete + texto_tem
                    exor_local = exor_local Xor Asc(texto_tem)
                    Exit Sub
                End If 'salto de linea
        
        
        End If 'transmitiendo
   If rec_exor Then
        rec_exor = False
        exor_transmitido = Asc(texto_tem)
        If exor_transmitido = exor_local Then
            Texto_datos.Text = paquete
            
            'Print #numarchivo, paquete; 'Escribe en el archivo
            
'************************************
'*****AQUI presentacion de datos******
'**************************************
                num_archivo_temp = FreeFile
                Open "variables.txt" For Output As #num_archivo_temp
                Print #num_archivo_temp, paquete; 'Escribe en el archivo
                Close #num_archivo_temp
                obtener_variables ("variables.txt") 'obtengo las variables enviadas
                localidadRfant = localidadRf
                localidadRf = CInt(variable(8))
                If (CInt(variable(9)) = 1) Then
                    If (localidadRfant <> localidadRf) Then
                        Print #numarchivo, paquete; 'Escribe en el archivo
                    End If
                Else
                    
                                  
                Label_altura.Caption = "Altura: " + CStr(variable(7)) + "m"
                Label_velocidad.Caption = "Vel: " + CStr(variable(6)) + "m/s"
                Label_dir.Caption = "Dir: " + CStr(variable(5)) + "°"
                Label_presion.Caption = "Presion: " + CStr(variable(4)) + " mbar"
                Label_temp.Caption = "Temp: " + CStr(variable(2)) + "°"
                Label_humedad.Caption = "Hum: " + CStr(variable(3)) + "%"
                Label_hora.Caption = hora_sonda
                
                
      '         Select Case variable(5)
                'intervalos:
                '348.75-11.25
                '11.25-33.75
                '33.75-56.25
                '56.25-78.75
                '78.75-101.25
                '101.25-123.75
                '123.75-146.25
                '146.25-168.75
                '168.75-191.25
                '191.25-213.75
                '213.75-236.25
                '236.25-258.75
                '258.75-281.25
               
                If (variable(5) > 355 Or variable(5) <= 5) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(0)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\FLECHA00.gif")
        End If
                If (variable(5) > 5 And (variable(5) <= 15)) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(1)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha22.gif")
        End If
                If (variable(5) > 15 And variable(5) <= 25) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(2)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha45.gif")
        End If
                If (variable(5) > 25 And variable(5) <= 35) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(3)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha67.gif")
        End If
                If (variable(5) > 35 And variable(5) <= 45) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(4)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha90.gif")
        End If
                If (variable(5) > 45 And variable(5) <= 55) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(5)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha112.gif")
        End If
                If (variable(5) > 55 And variable(5) <= 65) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(6)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha135.gif")
        End If
                If (variable(5) > 65 And variable(5) <= 75) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(7)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha157.gif")
        End If
                If (variable(5) > 75 And variable(5) <= 85) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(8)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha180.gif")
        End If
                If (variable(5) > 85 And variable(5) <= 95) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(9)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha202.gif")
        End If
                If (variable(5) > 95 And variable(5) <= 105) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(10)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha225.gif")
        End If
                If (variable(5) > 105 And (variable(5) <= 115)) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(11)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha247.gif")
        End If
                If (variable(5) > 115 And variable(5) <= 125) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(12)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha270.gif")
        End If
                If (variable(5) > 125 And variable(5) <= 135) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(13)
                'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha292.gif")
        End If
                If (variable(5) > 135 And variable(5) <= 145) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(14)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha315.gif")
        End If
                If (variable(5) > 145 And variable(5) <= 155) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(15)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                End If
                If (variable(5) > 155 And variable(5) <= 165) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(16)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                End If
                If (variable(5) > 165 And variable(5) <= 175) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(17)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                End If
                If (variable(5) > 175 And variable(5) <= 185) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(18)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                End If
                If (variable(5) > 185 And variable(5) <= 195) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(19)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                End If
                If (variable(5) > 195 And variable(5) <= 205) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(20)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                End If
                If (variable(5) > 205 And variable(5) <= 215) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(21)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                End If
                If (variable(5) > 215 And variable(5) <= 225) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(22)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                End If
                If (variable(5) > 225 And variable(5) <= 235) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(23)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                End If
                If (variable(5) > 235 And variable(5) <= 245) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(24)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                End If
                If (variable(5) > 245 And variable(5) <= 255) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(25)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                End If
                If (variable(5) > 255 And variable(5) <= 265) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(26)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                End If
                If (variable(5) > 265 And variable(5) <= 275) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(27)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                End If
                If (variable(5) > 275 And variable(5) <= 285) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(28)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                End If
                If (variable(5) > 285 And variable(5) <= 295) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(29)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                End If
                If (variable(5) > 295 And variable(5) <= 305) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(30)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                End If
                If (variable(5) > 305 And variable(5) <= 315) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(31)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                End If
                If (variable(5) > 315 And variable(5) <= 325) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(32)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                End If
                If (variable(5) > 325 And variable(5) <= 335) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(33)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                End If
                If (variable(5) > 335 And variable(5) <= 345) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(34)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                End If
                If (variable(5) > 345 And variable(5) <= 355) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(35)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                End If
                If (variable(5) > 155 And variable(5) <= 165) Then
                    Pic_dir.Picture = PClip_dir.GraphicCell(36)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                End If

                End If 'else
                
        End If
        
    'termometro.Value = variable(2)
        
        
        
        transmitiendo = False
     
   End If 'exor
    
    End If 'inicio
    
    
    
    
      
End If
Exit Sub

maneja_errores:
If Err.Number = 8020 Then


End If
End Sub


Private Sub Form_Load()
    mihora = Time
    mifecha = Date
    hora = Hour(mihora)
    minuto = Minute(mihora)
    segundo = Second(mihora)
    dia = Day(mifecha)
    mes = Month(mifecha)
    anio = Year(mifecha)

Pic_dir.Picture = PClip_dir.GraphicCell(0)


dialogoGuardar.DefaultExt = ".txt"
dialogoGuardar.DialogTitle = "Guardar en el archivo..."
dialogoGuardar.FileName = ""
dialogoGuardar.Filter = "Texto (*.txt)|*.txt|Todos los archivos(*.*)|*.*"
dialogoGuardar.Flags = cdlOFNHideReadOnly
dialogoGuardar.Flags = cdlOFNOverwritePrompt
guardar_cerrar = False
text_rec = ""
Combo_Puerto.ListIndex = 0
Combo_Velocidad.ListIndex = 1
espera_id = False

rec_exor = False
transmitiendo = False
texto_tem = ""
exor_transmitida = 0
exor_local = 0
paquete = ""
espera_id = False

End Sub




'Private Sub Timer_segundero_Timer()
'    Dim hora_Actual As String
'    Dim minuto_actual As String
'    Dim segundo_actual As String
'
'    hora_Actual = Hour(Time)
'    minuto_actual = Minute(Time)
 '   segundo_actual = Second(Time)
'    Label_hora.Caption = ""
    
'    If (hora_Actual < 10) Then
'        Label_hora.Caption = "0"
'    End If
'    Label_hora.Caption = Label_hora.Caption + hora_Actual + ":"
    
'    If (minuto_actual < 10) Then
'        Label_hora.Caption = Label_hora.Caption + "0"
'    End If
'    Label_hora.Caption = Label_hora.Caption + minuto_actual + ":"
    
'    If (segundo_actual < 10) Then
'        Label_hora.Caption = Label_hora.Caption + "0"
'    End If
'    Label_hora.Caption = Label_hora.Caption + segundo_actual
'End Sub

Private Sub Timer_unsec_Timer()
    On Error GoTo maneja_errores
    MSComm1.PortOpen = False
    MSComm1.PortOpen = True

maneja_errores:

End Sub

'   If transmitiendo Then
    
'End Sub
Private Sub Timer_espera_nuevo_Timer()
    transmitiendo = False
    espera_id = False
    
End Sub
