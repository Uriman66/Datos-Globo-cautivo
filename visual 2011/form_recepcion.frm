VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{27395F88-0C0C-101B-A3C9-08002B2F49FB}#1.1#0"; "PICCLP32.OCX"
Object = "{536B6100-C58D-4035-9586-0FE18996EC97}#1.0#0"; "Button-Mac.ocx"
Begin VB.Form form_recepcion 
   BackColor       =   &H00FF8080&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "***Adquisitor de Datos*** Instrumentación Meteorológica C.C.A. U.N.A.M."
   ClientHeight    =   10170
   ClientLeft      =   1875
   ClientTop       =   375
   ClientWidth     =   19605
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
   Icon            =   "form_recepcion.frx":0000
   LinkTopic       =   "Form1"
   MinButton       =   0   'False
   ScaleHeight     =   678
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   1307
   StartUpPosition =   2  'CenterScreen
   Visible         =   0   'False
   Begin VB.CheckBox Chk_ozono 
      BackColor       =   &H00FF8080&
      Caption         =   "Ozono"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   270
      Left            =   480
      TabIndex        =   75
      Top             =   1200
      Width           =   975
   End
   Begin VB.Frame Frame_puerto 
      BackColor       =   &H00FF8080&
      BorderStyle     =   0  'None
      Height          =   4455
      Left            =   4200
      TabIndex        =   69
      Top             =   2400
      Visible         =   0   'False
      Width           =   6495
      Begin VB.ComboBox combo_puerto_com 
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   390
         Left            =   2160
         TabIndex        =   72
         Text            =   " ---"
         Top             =   1920
         Width           =   1095
      End
      Begin ButtonEstiloMac.ButtonMac Boton_busca_puertos 
         Height          =   615
         Left            =   3720
         TabIndex        =   70
         Top             =   2640
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   1085
         Caption         =   "Actualizar puertos"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         PicOpacity      =   0
      End
      Begin ButtonEstiloMac.ButtonMac bOTON_acepta_com 
         Height          =   375
         Left            =   3720
         TabIndex        =   71
         Top             =   1920
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   661
         Caption         =   "Elegir"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   0
         PicOpacity      =   0
      End
      Begin VB.Label lbl_elige_puerto 
         BackColor       =   &H00FF8080&
         Caption         =   "Elige el puerto serie a utilizar..."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   15.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   975
         Left            =   1200
         TabIndex        =   74
         Top             =   960
         Width           =   4695
      End
      Begin VB.Label label_pcom 
         BackColor       =   &H00FF8080&
         Caption         =   "COM:"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   15.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   375
         Left            =   1080
         TabIndex        =   73
         Top             =   1920
         Width           =   975
      End
   End
   Begin ButtonEstiloMac.ButtonMac boton_cambiaCOM 
      Height          =   375
      Left            =   9120
      TabIndex        =   67
      Top             =   480
      Width           =   855
      _ExtentX        =   1508
      _ExtentY        =   661
      Caption         =   "Cambiar"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      PicOpacity      =   0
   End
   Begin ButtonEstiloMac.ButtonMac Boton_altura_S2 
      Height          =   375
      Left            =   3480
      TabIndex        =   36
      Top             =   840
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   661
      Caption         =   "Altura a cero"
      Enabled         =   0   'False
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      State           =   3
   End
   Begin ButtonEstiloMac.ButtonMac Boton_altura_S1 
      Height          =   375
      Left            =   3480
      TabIndex        =   35
      Top             =   360
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   661
      Caption         =   "Altura a cero"
      Enabled         =   0   'False
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      State           =   3
   End
   Begin VB.Frame Frame_calibracion 
      BackColor       =   &H00FF8080&
      BorderStyle     =   0  'None
      Height          =   3975
      Left            =   4560
      TabIndex        =   29
      Top             =   2640
      Visible         =   0   'False
      Width           =   7695
      Begin ButtonEstiloMac.ButtonMac Boton_calibrar_cancelar 
         Height          =   375
         Left            =   5760
         TabIndex        =   33
         Top             =   3360
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   661
         Caption         =   "Cancelar"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         PicOpacity      =   0
      End
      Begin ButtonEstiloMac.ButtonMac Boton_fin_cal 
         Height          =   375
         Left            =   3480
         TabIndex        =   30
         Top             =   3360
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   661
         Caption         =   "Fin"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin ButtonEstiloMac.ButtonMac BOton_inicia_cal 
         Height          =   375
         Left            =   1080
         TabIndex        =   31
         Top             =   3360
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   661
         Caption         =   "Iniciar"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.Label lbl_calibracion 
         BackColor       =   &H00FF8080&
         Caption         =   "..."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   15.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   1455
         Left            =   720
         TabIndex        =   32
         Top             =   1200
         Width           =   6495
      End
   End
   Begin ButtonEstiloMac.ButtonMac Boton_Calibracion_s1 
      Height          =   375
      Left            =   2040
      TabIndex        =   28
      Top             =   360
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   661
      Caption         =   "Calibrar"
      Enabled         =   0   'False
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      State           =   3
   End
   Begin VB.Timer Timer_peticion 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   8880
      Top             =   960
   End
   Begin VB.CheckBox Check1 
      BackColor       =   &H00FF8080&
      Caption         =   "Sonda 1"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   270
      Left            =   120
      TabIndex        =   27
      Top             =   480
      Value           =   1  'Checked
      Width           =   975
   End
   Begin VB.TextBox txt_dir_S1 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   1200
      TabIndex        =   26
      Text            =   "101"
      Top             =   480
      Width           =   735
   End
   Begin VB.TextBox txt_dir_S2 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   1200
      TabIndex        =   25
      Text            =   "102"
      Top             =   840
      Width           =   735
   End
   Begin VB.CheckBox Chk_sonda2 
      BackColor       =   &H00FF8080&
      Caption         =   "Sonda 2"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   270
      Left            =   120
      TabIndex        =   24
      Top             =   840
      Width           =   975
   End
   Begin VB.Timer Timer_max_espera 
      Enabled         =   0   'False
      Interval        =   2050
      Left            =   9960
      Top             =   0
   End
   Begin VB.PictureBox picGrafica 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FFFFFF&
      FillStyle       =   0  'Solid
      BeginProperty Font 
         Name            =   "Arial Narrow"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   10155
      Left            =   10560
      ScaleHeight     =   673
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   596
      TabIndex        =   16
      Top             =   0
      Width           =   9000
   End
   Begin ButtonEstiloMac.ButtonMac boton_cerrar_recepcion 
      Height          =   450
      Left            =   5040
      TabIndex        =   1
      Top             =   840
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   794
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
      Height          =   450
      Left            =   5040
      TabIndex        =   0
      Top             =   360
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   794
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
      Left            =   5520
      ScaleHeight     =   435
      ScaleWidth      =   195
      TabIndex        =   14
      Top             =   2880
      Visible         =   0   'False
      Width           =   255
   End
   Begin VB.PictureBox Pic_altura 
      Height          =   495
      Left            =   5400
      ScaleHeight     =   435
      ScaleWidth      =   195
      TabIndex        =   13
      Top             =   3480
      Visible         =   0   'False
      Width           =   255
   End
   Begin PicClip.PictureClip PClipsubebaja 
      Left            =   5520
      Top             =   2760
      _ExtentX        =   529
      _ExtentY        =   953
      _Version        =   393216
      Picture         =   "form_recepcion.frx":4FDA5
   End
   Begin VB.PictureBox Pic_dir 
      AutoSize        =   -1  'True
      Height          =   1215
      Left            =   5280
      ScaleHeight     =   1155
      ScaleWidth      =   1275
      TabIndex        =   12
      Top             =   4680
      Width           =   1335
   End
   Begin PicClip.PictureClip PClip_dir 
      Left            =   5280
      Top             =   4680
      _ExtentX        =   92604
      _ExtentY        =   38629
      _Version        =   393216
      Rows            =   4
      Cols            =   10
      Picture         =   "form_recepcion.frx":504C7
   End
   Begin VB.Timer Timer_espera_nuevo 
      Enabled         =   0   'False
      Interval        =   700
      Left            =   9840
      Top             =   600
   End
   Begin VB.Timer Timer_unsec 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   9960
      Top             =   240
   End
   Begin MSCommLib.MSComm MSComm1 
      Left            =   8040
      Top             =   600
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      DTREnable       =   -1  'True
      InputLen        =   1
      NullDiscard     =   -1  'True
      RThreshold      =   1
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
      ItemData        =   "form_recepcion.frx":530209
      Left            =   8400
      List            =   "form_recepcion.frx":530233
      TabIndex        =   4
      Text            =   "Combo_Velocidad"
      Top             =   0
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
      Height          =   495
      Left            =   720
      TabIndex        =   2
      Top             =   0
      Width           =   9135
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
         Height          =   255
         Left            =   840
         Locked          =   -1  'True
         TabIndex        =   5
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
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Top             =   120
         Width           =   615
      End
   End
   Begin MSComDlg.CommonDialog dialogoGuardar 
      Left            =   7440
      Top             =   840
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
      CancelError     =   -1  'True
   End
   Begin ButtonEstiloMac.ButtonMac Boton_Calibracion_s2 
      Height          =   375
      Left            =   2040
      TabIndex        =   34
      Top             =   840
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   661
      Caption         =   "Calibrar"
      Enabled         =   0   'False
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      State           =   3
   End
   Begin VB.Label lbl_etiqtas 
      Alignment       =   2  'Center
      BackColor       =   &H00FF8080&
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   14.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   29
      Left            =   6120
      TabIndex        =   76
      Top             =   1800
      Width           =   1815
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "O3:"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   14.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   28
      Left            =   5280
      TabIndex        =   68
      Top             =   1800
      Width           =   735
   End
   Begin VB.Label Label_puertoCOM 
      Alignment       =   2  'Center
      BackColor       =   &H00FF8080&
      Caption         =   "-"
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
      Height          =   255
      Index           =   1
      Left            =   7920
      TabIndex        =   66
      Top             =   600
      Width           =   1095
   End
   Begin VB.Label Label_puertoCOM 
      BackColor       =   &H00FF8080&
      Caption         =   "Puerto:"
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
      Height          =   255
      Index           =   0
      Left            =   7200
      TabIndex        =   65
      Top             =   600
      Width           =   615
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "°C"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   15.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   27
      Left            =   3855
      TabIndex        =   64
      Top             =   9510
      Width           =   735
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "% "
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   15.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   26
      Left            =   3855
      TabIndex        =   63
      Top             =   9015
      Width           =   735
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "mBar"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   15.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   25
      Left            =   3855
      TabIndex        =   62
      Top             =   8520
      Width           =   885
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "m"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   15.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   24
      Left            =   3855
      TabIndex        =   61
      Top             =   6120
      Width           =   495
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "m/s"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   15.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   23
      Left            =   3855
      TabIndex        =   60
      Top             =   6720
      Width           =   735
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "° "
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   15.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   22
      Left            =   3855
      TabIndex        =   59
      Top             =   7920
      Width           =   735
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "m/s"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   15.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   21
      Left            =   3855
      TabIndex        =   58
      Top             =   7320
      Width           =   735
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "Temp:"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   20
      Left            =   0
      TabIndex        =   57
      Top             =   9510
      Width           =   1575
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "Hum:"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   19
      Left            =   0
      TabIndex        =   56
      Top             =   9015
      Width           =   1575
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "Presión:"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   18
      Left            =   0
      TabIndex        =   55
      Top             =   8520
      Width           =   1575
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "Altura:"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   17
      Left            =   0
      TabIndex        =   54
      Top             =   6120
      Width           =   1575
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "V. asc:"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   16
      Left            =   0
      TabIndex        =   53
      Top             =   6720
      Width           =   1575
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "Vel.:"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   15
      Left            =   0
      TabIndex        =   52
      Top             =   7320
      Width           =   1575
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "Dir:"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   14
      Left            =   0
      TabIndex        =   51
      Top             =   7920
      Width           =   1575
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "Temp:"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   13
      Left            =   0
      TabIndex        =   50
      Top             =   4785
      Width           =   1575
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "Hum:"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   12
      Left            =   0
      TabIndex        =   49
      Top             =   4335
      Width           =   1575
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "°C"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   15.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   11
      Left            =   3855
      TabIndex        =   48
      Top             =   4785
      Width           =   735
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "% "
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   15.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   10
      Left            =   3855
      TabIndex        =   47
      Top             =   4335
      Width           =   735
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "mBar"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   15.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   9
      Left            =   3855
      TabIndex        =   46
      Top             =   3840
      Width           =   885
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "Presión:"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   8
      Left            =   0
      TabIndex        =   45
      Top             =   3840
      Width           =   1575
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "m/s"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   15.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   7
      Left            =   3855
      TabIndex        =   44
      Top             =   2640
      Width           =   735
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "Dir:"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   6
      Left            =   0
      TabIndex        =   43
      Top             =   3240
      Width           =   1575
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "° "
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   15.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   5
      Left            =   3855
      TabIndex        =   42
      Top             =   3240
      Width           =   735
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "m/s"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   15.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   4
      Left            =   3855
      TabIndex        =   41
      Top             =   2040
      Width           =   735
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "m"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   15.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   3
      Left            =   3855
      TabIndex        =   40
      Top             =   1560
      Width           =   495
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "Vel.:"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   2
      Left            =   0
      TabIndex        =   39
      Top             =   2640
      Width           =   1575
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "V. asc:"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   1
      Left            =   0
      TabIndex        =   38
      Top             =   2040
      Width           =   1575
   End
   Begin VB.Label lbl_etiqtas 
      BackColor       =   &H00FF8080&
      Caption         =   "Altura:"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   0
      Left            =   120
      TabIndex        =   37
      Top             =   1440
      Width           =   1575
   End
   Begin VB.Label Label_altura 
      Alignment       =   2  'Center
      BackColor       =   &H00FF8080&
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   495
      Index           =   2
      Left            =   1800
      TabIndex        =   23
      Top             =   6120
      Width           =   1935
   End
   Begin VB.Label Label_velocidad 
      Alignment       =   2  'Center
      BackColor       =   &H00FF8080&
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   495
      Index           =   2
      Left            =   1800
      TabIndex        =   22
      Top             =   7320
      Width           =   1935
   End
   Begin VB.Label Label_dir 
      Alignment       =   2  'Center
      BackColor       =   &H00FF8080&
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   495
      Index           =   2
      Left            =   1800
      TabIndex        =   21
      Top             =   7920
      Width           =   1935
   End
   Begin VB.Label Label_temp 
      Alignment       =   2  'Center
      BackColor       =   &H00FF8080&
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   495
      Index           =   2
      Left            =   1800
      TabIndex        =   20
      Top             =   9510
      Width           =   1935
   End
   Begin VB.Label Label_humedad 
      Alignment       =   2  'Center
      BackColor       =   &H00FF8080&
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   495
      Index           =   2
      Left            =   1800
      TabIndex        =   19
      Top             =   9015
      Width           =   1935
   End
   Begin VB.Label Label_presion 
      Alignment       =   2  'Center
      BackColor       =   &H00FF8080&
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   495
      Index           =   2
      Left            =   1800
      TabIndex        =   18
      Top             =   8520
      Width           =   1935
   End
   Begin VB.Label Labeldh 
      Alignment       =   2  'Center
      BackColor       =   &H00FF8080&
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   2
      Left            =   1800
      TabIndex        =   17
      Top             =   6720
      Width           =   1935
   End
   Begin VB.Label Labeldh 
      Alignment       =   2  'Center
      BackColor       =   &H00FF8080&
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   1
      Left            =   1800
      TabIndex        =   15
      Top             =   2040
      Width           =   1935
   End
   Begin VB.Label Label_presion 
      Alignment       =   2  'Center
      BackColor       =   &H00FF8080&
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   495
      Index           =   1
      Left            =   1800
      TabIndex        =   11
      Top             =   3840
      Width           =   1935
   End
   Begin VB.Label Label_humedad 
      Alignment       =   2  'Center
      BackColor       =   &H00FF8080&
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   495
      Index           =   1
      Left            =   1800
      TabIndex        =   10
      Top             =   4335
      Width           =   1935
   End
   Begin VB.Label Label_temp 
      Alignment       =   2  'Center
      BackColor       =   &H00FF8080&
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   495
      Index           =   1
      Left            =   1800
      TabIndex        =   9
      Top             =   4785
      Width           =   1935
   End
   Begin VB.Label Label_dir 
      Alignment       =   2  'Center
      BackColor       =   &H00FF8080&
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   495
      Index           =   1
      Left            =   1800
      TabIndex        =   8
      Top             =   3240
      Width           =   1935
   End
   Begin VB.Label Label_velocidad 
      Alignment       =   2  'Center
      BackColor       =   &H00FF8080&
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   495
      Index           =   1
      Left            =   1800
      TabIndex        =   7
      Top             =   2640
      Width           =   1935
   End
   Begin VB.Label Label_altura 
      Alignment       =   2  'Center
      BackColor       =   &H00FF8080&
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "Arial Rounded MT Bold"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   495
      Index           =   1
      Left            =   1800
      TabIndex        =   6
      Top             =   1440
      Width           =   1935
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
'Dim paquete As String 'contiene los datos correctos
Dim caracter_inicio As String 'Define el caracter de inicio de transmision
Dim Id As Integer 'contiene id de estacion de acuerdo al segundo en q se encuentre
Dim espera_id As Boolean
Dim alturaAnterior As Single
Dim dh As Single



Private Function obtener_variables_fecha(nom_archivo As String, num_sonda As Integer)
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
            'falla
                variable(id_var, num_sonda) = CSng(variable_caracter)
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
Private Function obtener_variables(nom_archivo As String, num_sonda As Integer)
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
    'caracter_actual = Input(1, #archivo)
    'caracter_asc = Asc(caracter_actual)
    'Do While Not EOF(numarchivo) ' Loop until end of file.
    Do While (Not (caracter_asc = 10)) '

        cadena_entera = cadena_entera + caracter_actual

        If (caracter_actual = " ") Then
       
       
            variable(id_var, num_sonda) = CSng(variable_caracter)
            variable_caracter = ""
            caracter_actual = ""
            id_var = id_var + 1
        End If
        If (IsNumeric(caracter_actual) Or caracter_actual = "." Or caracter_actual = "-") Then
            variable_caracter = variable_caracter + caracter_actual
        End If
        caracter_actual = Input(1, #archivo)
        caracter_asc = Asc(caracter_actual)
    Loop
Close #archivo    ' Close file.
    
End Function


Private Sub Calibracion_s1()
Dim boo As Boolean
    
    Timer_peticion.Enabled = False
    Timer_max_espera.Enabled = False
    
    lbl_calibracion.Caption = "Verifique que el led en la sonda este encendido" + Chr(13) + "y presione iniciar..."
    Frame_calibracion.Visible = True
    MSComm1.Output = "+++"
    If leer_ok Then
        MSComm1.Output = "ATMY" + txt_dir_S1.Text + Chr(13)
        boo = leer_ok
        MSComm1.Output = "ATDL" + txt_dir_S1.Text + Chr(13)
        If leer_ok Then
            MSComm1.Output = "ATCN" + Chr(13)
            boo = leer_ok
            MSComm1.Output = "N1"
        End If
    
    End If

End Sub

Private Sub Calibracion_s2()
Dim boo As Boolean
    Frame_calibracion.Visible = True
    Timer_peticion.Enabled = False
    Timer_max_espera.Enabled = False
    lbl_calibracion.Caption = "Verifique que el led en la sonda este encendido" + Chr(13) + "y presione iniciar..."

    MSComm1.Output = "+++"
    If leer_ok Then
        MSComm1.Output = "ATMY" + txt_dir_S2.Text + Chr(13)
        boo = leer_ok
        MSComm1.Output = "ATDL" + txt_dir_S2.Text + Chr(13)
        If leer_ok Then
            MSComm1.Output = "ATCN" + Chr(13)
            boo = leer_ok
            MSComm1.Output = "N1"
        End If
    
    End If

End Sub
Private Sub altura(direccion As String)
Dim boo As Boolean
Dim contador As Integer

    MSComm1.Output = "+++"
    If leer_ok Then
        MSComm1.Output = "ATDL" + direccion + Chr(13)
        boo = leer_ok
        MSComm1.Output = "ATMY" + direccion + Chr(13)
        If leer_ok Then
            MSComm1.Output = "ATCN" + Chr(13)
            boo = leer_ok
            MSComm1.Output = "N0"
        End If
    
    End If
End Sub

Private Sub bOTON_acepta_com_Click()
    puerto_com = combo_puerto_com.ListIndex
    If puerto_com = -1 Then
        MsgBox "No has seleccionado un puerto"
    Else
        puerto_com = CInt(combo_puerto_com.List(puerto_com))
        Frame_puerto.Visible = False
        Label_puertoCOM(1).Caption = "COM " + Str(puerto_com)
    End If

End Sub

Private Sub Boton_altura_S1_Click()
    altura_cero_S1 = True
    
End Sub

Private Sub Boton_altura_S2_Click()
    altura_cero_S2 = True
    
End Sub

Private Sub Boton_busca_puertos_Click()
    detecta_com
End Sub

Private Sub Boton_Calibracion_s1_Click()
    calibrar_S1 = True
End Sub

Private Sub Boton_Calibracion_s2_Click()
    calibrar_S2 = True
    
End Sub

Private Sub Boton_calibrar_cancelar_Click()
    Frame_calibracion.Visible = False
    peticion
    MsgBox "La sonda debe ser reconfigurada"
End Sub

Private Sub boton_cambiaCOM_Click()
    detecta_com
    Frame_puerto.Visible = True
End Sub
Private Sub detecta_com()
Dim i As Integer
Dim a As Integer

    On Error Resume Next
    a = 0
    combo_puerto_com.Clear
    For i = 1 To 15
        Err.Clear
        MSComm1.CommPort = i
        MSComm1.PortOpen = True
        If Err.Number = 0 Then
            a = a + 1
            combo_puerto_com.AddItem Str(i)
            combo_puerto_com.ItemData(combo_puerto_com.NewIndex) = i
            If Err.Number <> 0 Then
                MsgBox "Error detectado"
            End If
            MSComm1.PortOpen = False
        End If
           
    Next i
    If a = 0 Then
        MsgBox "No se encontraron puertos disponibles"
    Else
        combo_puerto_com.ListIndex = 0
    End If
End Sub


Private Sub boton_cerrar_recepcion_Click()
Dim diD As Long
Dim bOK As Long

    respuesta = MsgBox("¿Deseas cerrar la conexión?", vbYesNo)
    If respuesta = vbYes Then
    Timer_max_espera.Enabled = False '
    Timer_peticion.Enabled = False
    'Timer_segundero.Enabled = False
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
            Close #numarchivo
            Close #numarchivo_s2
            picGrafica.Picture = picGrafica.Image
            'SavePicture picGrafica, archivo_Imagen
            'diD = FreeImage_CreateFromImageContainer(picGrafica, True)
            'diD = SaveImageContainerEx(picGrafica, archivo_Imagen_PNG, True, FIF_GIF, , , 150, 150, True)
            MsgBox "Lectura terminada"
            respuesta = MsgBox("¿Deseas ver el archivo generado?", vbYesNo)
            If respuesta = vbYes Then    '
                val_regresa = Shell("notepad.exe " + nombre_archivo, vbNormalFocus)
                val_regresa = Shell("notepad.exe " + nombre_archivo_S2, vbNormalFocus)
            End If
    Else
    Timer_cambio.Enabled = True
   
    End If
End Sub


Private Sub Boton_fin_cal_Click()
    MSComm1.Output = "G"
    MsgBox "Calibración terminada"
    lbl_calibracion.Caption = "..."
    Frame_calibracion.Visible = False
    peticion
    
End Sub

Private Sub BOton_inicia_cal_Click()

    MsgBox "El led debe apagarse" + Chr(13) + "despues de presionar aceptar"
    MSComm1.Output = "F"
    lbl_calibracion.Caption = "Gire lentamente la sonda..." + Chr(13) + "Presione fin al terminar"

End Sub

Private Sub boton_rec_Click()

    
On Error GoTo maneja_errores


    Texto_datos.Text = "Esperando..."
    MsgBox "Proporcione el directorio en" + Chr(13) & Chr(10) + "donde se guardarán los archivos"
    mihora = Time
    mifecha = Date
    hora = Hour(mihora)
    minuto = Minute(mihora)
    segundo = Second(mihora)
    dia = Day(mifecha)
    mes = Month(mifecha)
    anio = Year(mifecha)
    sonda_MY(1) = CInt(txt_dir_S1.Text)
    sonda_MY(2) = CInt(txt_dir_S2.Text)
    alturaPromedio = 0
    
    dialogoGuardar.FileName = Format(Now, "yymmdd_hhmm")
    nombre_archivo = dialogoGuardar.FileName + "_S1.txt"
    nombre_archivo_S2 = dialogoGuardar.FileName + "_S2.txt"
    archivo_Imagen = dialogoGuardar.FileName + "_graf.bmp"
    archivo_Imagen_PNG = dialogoGuardar.FileName

    dialogoGuardar.ShowSave
    Close
    numarchivo = FreeFile
    numarchivo_s2 = FreeFile(1)
    
    'obtener_variables (nombre_archivo)
    Open nombre_archivo For Output As #numarchivo
    Open nombre_archivo_S2 For Output As #numarchivo_s2
    Print #numarchivo, "fecha hora Temperatura Humedad Presión Dirección Velocidad Altura" + Chr(13) & Chr(10)
    If Chk_ozono Then
        Print #numarchivo_s2, "Fecha Hora Temperatura Humedad Presión Dirección Velocidad Altura Memoria X Bat Temperatura(°C) Temp Ozono(ppb) Ozono" + Chr(13) & Chr(10)
    Else
        Print #numarchivo_s2, "Fecha hora Temperatura Humedad Presión Dirección Velocidad Altura" + Chr(13) & Chr(10)
    End If
    
    MSComm1.CommPort = puerto_com
    MSComm1.Settings = "9600,n,8,1" 'Establece la configuración de puerto rs232
    boton_cerrar_recepcion.Enabled = True
    boton_rec.Enabled = False
    'Timer_unsec.Enabled = True
    rec_exor = False
    transmitiendo = False
    espera_id = False
    If MSComm1.PortOpen = False Then
        MSComm1.PortOpen = True
    End If
    sonda_MY_i = 2
    Boton_Calibracion_s1.Enabled = True
    Boton_Calibracion_s2.Enabled = True
    Boton_altura_S1.Enabled = True
    Boton_altura_S2.Enabled = True
    en_recepcion = True
    componenteX = 0
    componenteY = 0
    Ncomponentes = 0
    
    Ascendiendo = True
    peticion
    'Timer_cambia_sonda.Enabled = True
    'Timer_segundero.Enabled = True
    
    Exit Sub
maneja_errores:
    If Err.Number <> 32755 Then
    MsgBox ("Error detectado: " + Err.Description)
    End If

    

End Sub


Private Sub Chk_sonda2_Click()
    Select Case Chk_sonda2.Value
    Case 0
        txt_dir_S2.Enabled = False
        If en_recepcion Then
            Boton_Calibracion_s2.Enabled = False
            Boton_altura_S2.Enabled = False
        End If
        esconde_S2
        sonda_2_Activa = False
        
     Case 1
        txt_dir_S2.Enabled = True
        If en_recepcion Then
            Boton_Calibracion_s2.Enabled = True
            Boton_altura_S2.Enabled = True
        End If
        muestra_S2
        sonda_2_Activa = True
        
     End Select
     
     
End Sub





Private Sub Form_Unload(Cancel As Integer)
    Unload form_estacion
End Sub


Private Sub MSComm1_OnComm()

If MSComm1.CommEvent = comEvReceive Then
'Timer_cambia_sonda.Enabled = False
    'On Error GoTo maneja_errores
    
    texto_tem = MSComm1.Input
    'Timer_unsec.Enabled = False    'COMENTE ESTO
    'Timer_unsec.Enabled = True
    a = Asc(texto_tem)
    caracter_inicio = &H21 'Establece el caracter de inicio
    If a = caracter_inicio Then 'verifica que si se leyó el caracter de inicio
                    Timer_peticion.Enabled = False
                    paquete = ""
                    espera_id = True
                    transmitiendo = True
                    t_Espera = t_Espera + 30
                    Timer_max_espera.Interval = t_Espera
                    exor_local = Asc(texto_tem)
                    Exit Sub
    Else
        If transmitiendo Then
            t_Espera = t_Espera + 50
            Timer_max_espera.Interval = t_Espera
       
            If espera_id Then
                espera_id = False
                Id = a
                boo_tem = True
                
                
            End If
        
                If a = 10 Then
                    paquete = paquete + Chr(13) & Chr(10)
 
                    transmitiendo = False
                    rec_exor = True
                    exor_local = exor_local Xor Asc(texto_tem)
                    Exit Sub
                Else
                    If boo_tem = False Then
                        paquete = paquete + texto_tem
                    End If
                    If boo_tem Then
                    boo_tem = False
                    End If
                    exor_local = exor_local Xor Asc(texto_tem)
                    Exit Sub
                End If 'salto de linea
        
        
        End If 'transmitiendo
   If rec_exor Then
        rec_exor = False
        exor_transmitido = Asc(texto_tem)
        If exor_transmitido = exor_local Then
                'Texto_datos.Text = paquete
                Timer_max_espera.Enabled = False
                t_Espera = t_Espera_Inicial
                Timer_max_espera.Interval = t_Espera
            
            
'*************************************
'*****AQUI presentacion de datos******
'*************************************
'>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
'>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
'Guarda el paquete de datos recibido en el archivo variables para su separación en variables
                num_archivo_temp = FreeFile
                Open "variables.txt" For Output As #num_archivo_temp
                Print #num_archivo_temp, paquete; 'Escribe en el archivo
                Close #num_archivo_temp
                asdf = obtener_variables("variables.txt", sonda_MY_i) 'Obtiene variables y las almacena en variable()
                localidadRfant = localidadRf
                localidadRf = CLng(variable(6, 1))
                localidadRfant_S2 = localidadRf_S2
                localidadRf_S2 = CLng(variable(6, 2))
                If (sonda_MY_i = 1) Then
                    'If (CLng(variable(7, 1)) = 0) Then
                       ' If (localidadRfant <> localidadRf) Then
                            Print #numarchivo, Format(Now, "dd/mm/yy hh:mm:ss ") + paquete; 'Escribe en el archivo
                            paquete_p1 = paquete
                            hora_paq1 = Now
                       ' End If
                    'End If
                End If
                If (sonda_MY_i = 2) Then
                    'If (CInt(variable(7, 2)) = 0) Then
                        'If (localidadRfant_S2 <> localidadRf_S2) Then
                            hora_paq2 = Now
                            tiempo_sondas = hora_paq2 - hora_paq1
                            If Chk_ozono = False Then
                                Print #numarchivo_s2, Format(Now, "dd/mm/yy hh:mm:ss ") + paquete; 'Escribe en el archivo
                            Else
                            rererere = 3.473 * 10 ^ -5
                                If tiempo_sondas < (3.473 * 10 ^ -5) Then
                                    Print #numarchivo_s2, Format(Now, "dd/mm/yy hh:mm:ss ") + paquete_p1 + paquete; 'Escribe en el archivo
                                Else
                                    Print #numarchivo_s2, Format(Now, "dd/mm/yy hh:mm:ss ") + "--- --- --- --- --- --- --- --- --- " + paquete; 'Escribe en el archivo
                                End If

                            End If
                        'End If
                   ' End If
                End If
                'PRESENTACION DE DATOS
                'Texto
                Texto_datos.Text = paquete
                If sonda_MY_i = 2 And Chk_ozono.Value = 1 Then
                    lbl_etiqtas(29) = variable(3, 2)
                Else
                    dh = (variable(5, 1) - alturaAnterior) / 3 'aproximación de Velocidad de ascenso
                    Label_altura(sonda_MY_i).Caption = CStr(variable(5, sonda_MY_i))
                    Label_velocidad(sonda_MY_i).Caption = CStr(variable(4, sonda_MY_i))
                    Labeldh(sonda_MY_i).Caption = Format(dh, "0.00")
                    Label_dir(sonda_MY_i).Caption = CStr(variable(3, sonda_MY_i))
                    Label_presion(sonda_MY_i).Caption = CStr(variable(2, sonda_MY_i))
                    Label_temp(sonda_MY_i).Caption = CStr(variable(0, sonda_MY_i))
                    Label_humedad(sonda_MY_i).Caption = CStr(variable(1, sonda_MY_i))
                    'picGrafica.Scale (VarMin, hmax)-(VarMax, hmin)
                    'grafico
                    picGrafica.Scale (-100, 1010)-(500, 0) 'Escala
                    picGrafica.PSet (CLng(variable(0, 1) * 10), CInt(variable(5, 1))), vbRed 'Temperatura
                    'picGrafica.PSet (CLng(variable(0, 1) * 10 * ((1000 / CLng(variable(2, 1))) ^ 0.2857)), CInt(variable(5, 1))), vbMagenta 'temp virtual
                    picGrafica.Scale (0, 1010)-(1200, 0) 'Escala
                    picGrafica.PSet (CLng(variable(1, 1) * 10), CInt(variable(5, 1))), vbBlue 'humedad
                End If
                If sonda_MY_i = 1 Then
                    Ncomponentes = Ncomponentes + 1
                    alturaAcumulada = alturaAcumulada + variable(5, 1)
                    xAcumulada = xAcumulada + variable(4, 1) * Sin(variable(3, 1) * 0.017453)
                    yAcumulada = yAcumulada + variable(4, 1) * Cos(variable(3, 1) * 0.017453)
    
                    If Abs(variable(5, 1) - (alturaAcumulada / Ncomponentes)) >= 10 And Ncomponentes > 1 Then
                        temp = graficaVientoComponentes(alturaAcumulada / Ncomponentes, xAcumulada / Ncomponentes, yAcumulada / Ncomponentes, Ascendiendo)
                        alturaAcumulada = 0
                        Ncomponentes = 0
                        xAcumulada = 0
                        yAcumulada = 0
                    End If
                    'PicViento.PSet (CInt(variable(5, 1) * (Sin(variable(3, 1) / 57.2957))), CInt(variable(5, 1) * (Cos(variable(3, 1) / 57.2957)))), vbGreen
                    'Label_hora.Caption = hora_sonda
                    variableanterior = variable
                    alturaAnterior = variable(5, 1)
                
                'If sonda_MY_i = 1 Then
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
               
                    If (variable(3, 1) > 355 Or variable(3, 1) <= 5) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(0)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\FLECHA00.gif")
                    End If
                    If (variable(3, 1) > 5 And (variable(3, 1) <= 15)) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(1)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha22.gif")
                    End If
                    If (variable(3, 1) > 15 And variable(3, 1) <= 25) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(2)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha45.gif")
                    End If
                    If (variable(3, 1) > 25 And variable(3, 1) <= 35) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(3)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha67.gif")
                    End If
                    If (variable(3, 1) > 35 And variable(3, 1) <= 45) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(4)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha90.gif")
                    End If
                    If (variable(3, 1) > 45 And variable(3, 1) <= 55) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(5)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha112.gif")
                    End If
                    If (variable(3, 1) > 55 And variable(3, 1) <= 65) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(6)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha135.gif")
                    End If
                    If (variable(3, 1) > 65 And variable(3, 1) <= 75) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(7)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha157.gif")
                    End If
                    If (variable(3, 1) > 75 And variable(3, 1) <= 85) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(8)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha180.gif")
                    End If
                    If (variable(3, 1) > 85 And variable(3, 1) <= 95) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(9)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha202.gif")
                    End If
                    If (variable(3, 1) > 95 And variable(3, 1) <= 105) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(10)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha225.gif")
                    End If
                    If (variable(3, 1) > 105 And (variable(3, 1) <= 115)) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(11)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha247.gif")
                    End If
                    If (variable(3, 1) > 115 And variable(3, 1) <= 125) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(12)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha270.gif")
                    End If
                    If (variable(3, 1) > 125 And variable(3, 1) <= 135) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(13)
                    'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha292.gif")
                    End If
                    If (variable(3, 1) > 135 And variable(3, 1) <= 145) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(14)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha315.gif")
                    End If
                    If (variable(3, 1) > 145 And variable(3, 1) <= 155) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(15)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                    End If
                    If (variable(3, 1) > 155 And variable(3, 1) <= 165) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(16)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                    End If
                    If (variable(3, 1) > 165 And variable(3, 1) <= 175) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(17)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                    End If
                    If (variable(3, 1) > 175 And variable(3, 1) <= 185) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(18)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                    End If
                    If (variable(3, 1) > 185 And variable(3, 1) <= 195) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(19)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                    End If
                    If (variable(3, 1) > 195 And variable(3, 1) <= 205) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(20)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                    End If
                    If (variable(3, 1) > 205 And variable(3, 1) <= 215) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(21)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                    End If
                    If (variable(3, 1) > 215 And variable(3, 1) <= 225) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(22)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                    End If
                    If (variable(3, 1) > 225 And variable(3, 1) <= 235) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(23)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                    End If
                    If (variable(3, 1) > 235 And variable(3, 1) <= 245) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(24)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                    End If
                    If (variable(3, 1) > 245 And variable(3, 1) <= 255) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(25)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                    End If
                    If (variable(3, 1) > 255 And variable(3, 1) <= 265) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(26)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                    End If
                    If (variable(3, 1) > 265 And variable(3, 1) <= 275) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(27)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                    End If
                    If (variable(3, 1) > 275 And variable(3, 1) <= 285) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(28)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                    End If
                    If (variable(3, 1) > 285 And variable(3, 1) <= 295) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(29)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                    End If
                    If (variable(3, 1) > 295 And variable(3, 1) <= 305) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(30)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                    End If
                    If (variable(3, 1) > 305 And variable(3, 1) <= 315) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(31)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                    End If
                    If (variable(3, 1) > 315 And variable(3, 1) <= 325) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(32)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                    End If
                    If (variable(3, 1) > 325 And variable(3, 1) <= 335) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(33)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                    End If
                    If (variable(3, 1) > 335 And variable(3, 1) <= 345) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(34)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                    End If
                    If (variable(3, 1) > 345 And variable(3, 1) <= 355) Then
                        Pic_dir.Picture = PClip_dir.GraphicCell(35)
                        'Image_dir.Picture = LoadPicture("C:\personal\Miguel Angel\archivos globo\estacion\visual\imagenes\flecha337.gif")
                    End If
                End If 'sonda_my_i
                'Fin de presentación de datos
                If calibrar_S1 Then
                    Calibracion_s1
                    calibrar_S1 = False
                    Exit Sub
                End If
                If calibrar_S2 Then
                    Calibracion_s2
                    calibrar_S2 = False
                    Exit Sub
                End If
                If altura_cero_S1 And sonda_MY_i = 1 Then
                    altura (txt_dir_S1)
                    altura_cero_S1 = False
                End If
                If altura_cero_S2 And sonda_MY_i = 2 Then
                    altura (txt_dir_S2)
                    altura_cero_S2 = False
                End If
                
                  peticion
        End If
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
Dim tururu As Single
Dim tarara As Single
Dim temp
Dim direccion As Single


    t_Espera_Inicial = 1500
    mihora = Time
    mifecha = Date
    hora = Hour(mihora)
    minuto = Minute(mihora)
    segundo = Second(mihora)
    dia = Day(mifecha)
    mes = Month(mifecha)
    anio = Year(mifecha)
    alturaAnterior = 0
    sonda_MY_i = 1
    tiempo_guarda = False
    boo_tem = False
    boton_cerrar_recepcion.Enabled = False
    calibrar_S1 = False
    calibrar_S2 = False
    altura_cero_S1 = False
    altura_cero_S2 = False
    en_recepcion = False
    Label_puertoCOM(1).Caption = "COM " + Str(puerto_com)
    sonda_2_Activa = True
    t_Espera = t_Espera_Inicial
    Timer_max_espera.Interval = t_Espera_Inicial
    temp = Perfiles_sonda.Dibuja_ejes
    Ncomponentes = 0
    
Ascendiendo = True
Perfil_Ymin = 1000
Perfil_Ymax = 0
'tarara = 0
'For tururu = 0 To 500 Step 5
'            variable(5, 1) = tururu
'            direccion = tarara
'                Ncomponentes = Ncomponentes + 1
'                alturaAcumulada = alturaAcumulada + variable(5, 1)
'                xAcumulada = xAcumulada + Sin(direccion * 0.017453)
'                yAcumulada = yAcumulada + Cos(direccion * 0.017453)
'
'                If Abs(variable(5, 1) - (alturaAcumulada / Ncomponentes)) >= 10 And Ncomponentes > 1 Then
'                    temp = graficaVientoComponentes(alturaAcumulada / Ncomponentes, xAcumulada / Ncomponentes, yAcumulada / Ncomponentes, direccion, Ascendiendo)
'                     alturaAcumulada = 0
 '                   Ncomponentes = 0
 '                   xAcumulada = 0
 '                   yAcumulada = 0
 '               End If
 ''               'PicViento.PSet (CInt(variable(5, 1) * (Sin(variable(3, 1) / 57.2957))), CInt(variable(5, 1) * (Cos(variable(3, 1) / 57.2957)))), vbGreen
 '               'Label_hora.Caption = hora_sonda
 '               variableanterior = variable
 '               alturaAnterior = variable(5, 1)
'
''aaa = Perfiles_sonda.graficaViento(tururu, tarara, 15, True)
'tarara = tarara + 5
'Next
'tarara = 0
'For tururu = 0 To 500 Step 5
'aaa = Perfiles_sonda.graficaViento(tururu, tarara, 15, False)
'tarara = tarara + 5
'Next

Pic_dir.Picture = PClip_dir.GraphicCell(0)


dialogoGuardar.DefaultExt = ".txt"
dialogoGuardar.DialogTitle = "Guardar en el archivo..."
dialogoGuardar.FileName = ""
dialogoGuardar.Filter = "Texto (*.txt)|*.txt|Todos los archivos(*.*)|*.*"
dialogoGuardar.Flags = cdlOFNHideReadOnly
dialogoGuardar.Flags = cdlOFNOverwritePrompt
guardar_cerrar = False
text_rec = ""
espera_id = False

rec_exor = False
transmitiendo = False
texto_tem = ""
exor_transmitida = 0
exor_local = 0
paquete = ""
espera_id = False

End Sub

Private Sub Timer_max_espera_Timer()
'    MSComm1.Output = "C"
    Timer_max_espera.Enabled = False
    Timer_peticion.Enabled = False
    peticion
        transmitiendo = False

End Sub

Private Sub Timer_peticion_Timer()
    MSComm1.Output = "M"
    If (Chk_sonda2.Value = 1) Then
        'Timer_max_espera.Interval = 2000
    Else
        'Timer_max_espera.Interval = 700
    End If
End Sub
Private Sub esconde_S2()
    Label_altura(2).Visible = False
    Labeldh(2).Visible = False
    Label_velocidad(2).Visible = False
    Label_dir(2).Visible = False
    Label_presion(2).Visible = False
    Label_humedad(2).Visible = False
    Label_temp(2).Visible = False
    lbl_etiqtas(17).Visible = False
    lbl_etiqtas(16).Visible = False
    lbl_etiqtas(15).Visible = False
    lbl_etiqtas(14).Visible = False
    lbl_etiqtas(18).Visible = False
    lbl_etiqtas(19).Visible = False
    lbl_etiqtas(20).Visible = False
    lbl_etiqtas(21).Visible = False
    lbl_etiqtas(22).Visible = False
    lbl_etiqtas(23).Visible = False
    lbl_etiqtas(24).Visible = False
    lbl_etiqtas(25).Visible = False
    lbl_etiqtas(26).Visible = False
    lbl_etiqtas(27).Visible = False
End Sub
Private Sub muestra_S2()
    Label_altura(2).Visible = True
    Labeldh(2).Visible = True
    Label_velocidad(2).Visible = True
    Label_dir(2).Visible = True
    Label_presion(2).Visible = True
    Label_humedad(2).Visible = True
    Label_temp(2).Visible = True
    lbl_etiqtas(17).Visible = True
    lbl_etiqtas(16).Visible = True
    lbl_etiqtas(15).Visible = True
    lbl_etiqtas(14).Visible = True
    lbl_etiqtas(18).Visible = True
    lbl_etiqtas(19).Visible = True
    lbl_etiqtas(20).Visible = True
    lbl_etiqtas(21).Visible = True
    lbl_etiqtas(22).Visible = True
    lbl_etiqtas(23).Visible = True
    lbl_etiqtas(24).Visible = True
    lbl_etiqtas(25).Visible = True
    lbl_etiqtas(26).Visible = True
    lbl_etiqtas(27).Visible = True


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

Private Sub peticion()
Dim boo As Boolean

limpia_buffer
MSComm1.Output = "+++"
If leer_ok Then
    Select Case sonda_MY_i
    Case 1
        'If sonda_2_Activa Then
            MSComm1.Output = "ATDL" + Str(sonda_MY(2)) + Chr(13)
            boo = leer_ok
            MSComm1.Output = "ATMY" + Str(sonda_MY(2)) + Chr(13)
            If leer_ok Then
                MSComm1.Output = "ATCN" + Chr(13)
                boo = leer_ok
                sonda_MY_i = 2
            End If
        'End If
    Case 2
            MSComm1.Output = "ATDL" + Str(sonda_MY(1)) + Chr(13)
            boo = leer_ok
            MSComm1.Output = "ATMY" + Str(sonda_MY(1)) + Chr(13)
            If leer_ok Then
                MSComm1.Output = "ATCN" + Chr(13)
                boo = leer_ok
                sonda_MY_i = 1
            End If
    End Select
Timer_peticion.Enabled = True

End If
Timer_max_espera.Enabled = True

End Sub
'funcion para limpiar el buffer de entrada de mscomm1
Private Sub limpia_buffer()
    Dim basura As String
    Dim temp_rthres As Integer
    Dim temp_input_len As Integer

        temp_rthres = MSComm1.RThreshold
        temp_input_len = MSComm1.InputLen
        If MSComm1.InBufferCount > 0 Then
            InputLen = MSComm1.InBufferCount
            basura = MSComm1.Input
        End If
        MSComm1.RThreshold = temp_rthres
        MSComm1.InputLen = temp_input_len


End Sub
'Esta funcion revisa la respuesta "OK" a comandos AT por mscomm1
Private Function leer_ok() As Boolean
    Dim contador As Integer
    Dim cadena As String
    Dim temp_rthres As Integer
    Dim temp_input_len As Integer
        If MSComm1.PortOpen = False Then
            leer_ok = False
            Exit Function
        End If
        contador = 0
        temp_rthres = MSComm1.RThreshold
        temp_input_len = MSComm1.InputLen
        MSComm1.RThreshold = 5
        MSComm1.InputLen = 4

        Do
        dummi = DoEvents()
        contador = contador + 1
        Loop Until MSComm1.InBufferCount >= 3 Or contador >= 6000
        cadena = MSComm1.Input
        MSComm1.RThreshold = temp_rthres
        MSComm1.InputLen = temp_input_len

        If (cadena = "OK" + Chr(13)) Then
            leer_ok = True
        Else
            leer_ok = False
        End If
        
End Function

'Private Sub VScroll_sincronizacion_Change()
'    Timer_max_espera.Interval = VScroll_sincronizacion.Value
'    lbl_etiqtas(28).Caption = Str(Timer_max_espera.Interval)
'End Sub




