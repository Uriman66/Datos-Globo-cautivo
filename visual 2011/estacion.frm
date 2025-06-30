VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{536B6100-C58D-4035-9586-0FE18996EC97}#1.0#0"; "Button-Mac.ocx"
Object = "{80B2C82E-76D1-4FB9-BE8C-CD8A5D4C4C0C}#7.0#0"; "SkinFormYahoo.ocx"
Begin VB.Form form_estacion 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Globo Cautivo Meteorológico Instrumentado"
   ClientHeight    =   8115
   ClientLeft      =   4695
   ClientTop       =   2235
   ClientWidth     =   12060
   Icon            =   "estacion.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   8115
   ScaleWidth      =   12060
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame_espere 
      Appearance      =   0  'Flat
      BackColor       =   &H00FF8080&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   3015
      Left            =   3840
      TabIndex        =   69
      Top             =   6240
      Visible         =   0   'False
      Width           =   6015
      Begin VB.Label Label_espere 
         Alignment       =   2  'Center
         BackColor       =   &H00FF8080&
         Caption         =   "Espere..."
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   24
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   1095
         Left            =   1200
         TabIndex        =   70
         Top             =   1200
         Width           =   3735
      End
   End
   Begin VB.Frame Frame_puerto 
      BackColor       =   &H00FF8080&
      BorderStyle     =   0  'None
      Height          =   4455
      Left            =   6480
      TabIndex        =   64
      Top             =   0
      Width           =   6495
      Begin ButtonEstiloMac.ButtonMac Boton_busca_puertos 
         Height          =   615
         Left            =   3720
         TabIndex        =   68
         Top             =   2640
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   1085
         BackColor       =   16744576
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
         TabIndex        =   2
         Top             =   1920
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   661
         BackColor       =   16744576
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
         TabIndex        =   1
         Text            =   " ---"
         Top             =   1920
         Width           =   1095
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
         TabIndex        =   66
         Top             =   1920
         Width           =   975
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
         TabIndex        =   65
         Top             =   960
         Width           =   4695
      End
   End
   Begin VB.Frame framePaso1 
      BackColor       =   &H00FF8080&
      BorderStyle     =   0  'None
      ForeColor       =   &H00FF8080&
      Height          =   3375
      Left            =   0
      TabIndex        =   7
      Top             =   4440
      Visible         =   0   'False
      Width           =   6495
      Begin VB.TextBox txt_dir_sonda 
         Alignment       =   1  'Right Justify
         Height          =   285
         Left            =   2040
         TabIndex        =   62
         Top             =   720
         Width           =   615
      End
      Begin ButtonEstiloMac.ButtonMac botonCancelCon 
         Height          =   735
         Left            =   3480
         TabIndex        =   59
         Top             =   1200
         Width           =   1815
         _ExtentX        =   3201
         _ExtentY        =   1296
         BackColor       =   16744576
         Caption         =   "Cancelar"
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
      Begin ButtonEstiloMac.ButtonMac BotonConfigura2 
         Height          =   735
         Left            =   1200
         TabIndex        =   58
         Top             =   1200
         Width           =   1815
         _ExtentX        =   3201
         _ExtentY        =   1296
         BackColor       =   16744576
         Caption         =   "Configurar"
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
      Begin VB.CommandButton botonCancelConx 
         Caption         =   "Cancelar"
         Height          =   735
         Left            =   3480
         TabIndex        =   50
         Top             =   1200
         Visible         =   0   'False
         Width           =   1695
      End
      Begin ButtonEstiloMac.ButtonMac boton_guardar 
         Height          =   735
         Left            =   1080
         TabIndex        =   60
         Top             =   1200
         Width           =   1815
         _ExtentX        =   3201
         _ExtentY        =   1296
         BackColor       =   16744576
         Caption         =   "Leer"
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
      Begin VB.Label lbl_dir_sonda 
         BackColor       =   &H00FF8080&
         Caption         =   "Dirección de sonda (q):"
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Left            =   240
         TabIndex        =   63
         Top             =   720
         Width           =   1815
      End
   End
   Begin VB.Frame frameER 
      BackColor       =   &H00FF8080&
      BorderStyle     =   0  'None
      ForeColor       =   &H0000C0C0&
      Height          =   3495
      Left            =   6360
      TabIndex        =   20
      Top             =   4440
      Width           =   6495
      Begin ButtonEstiloMac.ButtonMac boton_recepcion 
         Height          =   735
         Left            =   4440
         TabIndex        =   57
         Top             =   1440
         Width           =   1815
         _ExtentX        =   3201
         _ExtentY        =   1296
         BackColor       =   16744576
         Caption         =   "Monitorear Sonda (m)"
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
      Begin ButtonEstiloMac.ButtonMac botonObtener 
         Height          =   735
         Left            =   2400
         TabIndex        =   56
         Top             =   1440
         Width           =   1815
         _ExtentX        =   3201
         _ExtentY        =   1296
         BackColor       =   16744576
         Caption         =   "Obtener Datos de la Sonda (b)"
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
      Begin ButtonEstiloMac.ButtonMac botonConfigura 
         Height          =   735
         Left            =   480
         TabIndex        =   55
         Top             =   1440
         Width           =   1695
         _ExtentX        =   2990
         _ExtentY        =   1296
         BackColor       =   16744576
         Caption         =   "Configurar Sonda (c)"
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
      Begin VB.CommandButton botonObtenerx 
         Caption         =   "Obtener Datos de la Sonda"
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
         Left            =   2520
         TabIndex        =   49
         Top             =   1440
         Visible         =   0   'False
         Width           =   1575
      End
      Begin VB.CommandButton botonConfigurax 
         Caption         =   "Configurar Sonda"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   615
         Left            =   480
         TabIndex        =   47
         Top             =   1440
         Visible         =   0   'False
         Width           =   1695
      End
      Begin VB.CommandButton boton_recepcionx 
         Caption         =   "Monitorear Sonda"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   615
         Left            =   4440
         TabIndex        =   21
         Top             =   1440
         Visible         =   0   'False
         Width           =   1575
      End
      Begin SkinFormYahoo.SkinYahoo SkinYahoo1 
         Height          =   690
         Left            =   5280
         TabIndex        =   54
         Top             =   240
         Width           =   690
         _ExtentX        =   1217
         _ExtentY        =   1217
         ColorTitulo     =   16711680
         ColorBordes     =   16744576
         ColorMenu       =   16744576
         ColorComandos   =   16711680
         ColorCaption    =   16777215
         MinimoHeight    =   1000
         MinimoWidth     =   2000
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.Label Label_eleccion 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         BackColor       =   &H00FF8080&
         Caption         =   "¿Que deseas hacer?"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   18
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   435
         Left            =   1440
         TabIndex        =   48
         Top             =   360
         Width           =   3525
      End
   End
   Begin VB.Frame Frame_analogicos 
      BackColor       =   &H00E0E0E0&
      Enabled         =   0   'False
      Height          =   2175
      Left            =   6840
      TabIndex        =   26
      Top             =   4920
      Visible         =   0   'False
      Width           =   6495
      Begin VB.TextBox multi1 
         Enabled         =   0   'False
         Height          =   285
         Left            =   1920
         TabIndex        =   38
         Text            =   "0.158502"
         Top             =   1320
         Width           =   615
      End
      Begin VB.CheckBox canal1 
         BackColor       =   &H00E0E0E0&
         Caption         =   "Analógico 2"
         Enabled         =   0   'False
         Height          =   495
         Left            =   480
         TabIndex        =   37
         Top             =   1200
         Width           =   1215
      End
      Begin VB.TextBox offset1 
         Enabled         =   0   'False
         Height          =   285
         Left            =   3720
         TabIndex        =   36
         Text            =   "-36.47"
         Top             =   1320
         Width           =   615
      End
      Begin VB.CheckBox canal0 
         BackColor       =   &H00E0E0E0&
         Caption         =   "Analógico 1"
         Enabled         =   0   'False
         Height          =   495
         Left            =   480
         TabIndex        =   35
         Top             =   720
         Width           =   1215
      End
      Begin VB.TextBox multi0 
         Enabled         =   0   'False
         Height          =   285
         Left            =   1920
         TabIndex        =   34
         Text            =   "1"
         Top             =   840
         Width           =   615
      End
      Begin VB.TextBox offset0 
         Enabled         =   0   'False
         Height          =   285
         Left            =   3720
         TabIndex        =   33
         Text            =   "0000"
         Top             =   840
         Width           =   615
      End
      Begin VB.TextBox offset2 
         Enabled         =   0   'False
         Height          =   285
         Left            =   3720
         TabIndex        =   32
         Text            =   "0000"
         Top             =   1800
         Width           =   615
      End
      Begin VB.CheckBox canal2 
         BackColor       =   &H00E0E0E0&
         Caption         =   "Analógico 3"
         Enabled         =   0   'False
         Height          =   495
         Left            =   480
         TabIndex        =   31
         Top             =   1680
         Width           =   1215
      End
      Begin VB.TextBox multi2 
         Enabled         =   0   'False
         Height          =   285
         Left            =   1920
         TabIndex        =   30
         Text            =   "0.004883"
         Top             =   1800
         Width           =   615
      End
      Begin VB.TextBox offset3 
         Height          =   285
         Left            =   3720
         TabIndex        =   29
         Text            =   "0000"
         Top             =   2280
         Width           =   615
      End
      Begin VB.CheckBox canal3 
         BackColor       =   &H00E0E0E0&
         Caption         =   "Pulsos"
         Height          =   495
         Left            =   480
         TabIndex        =   28
         Top             =   2160
         Width           =   1215
      End
      Begin VB.TextBox multi3 
         Height          =   285
         Left            =   1920
         TabIndex        =   27
         Text            =   "1"
         Top             =   2280
         Width           =   615
      End
      Begin VB.Label LabelPaso2 
         BackColor       =   &H00E0E0E0&
         Caption         =   "Configuración de los canales a utilizar:"
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
         Left            =   360
         TabIndex        =   41
         Top             =   240
         Width           =   5175
      End
      Begin VB.Label LabelMul 
         BackColor       =   &H00E0E0E0&
         Caption         =   "Multiplicador"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   1680
         TabIndex        =   40
         Top             =   600
         Width           =   1215
      End
      Begin VB.Label Labeloffset 
         BackColor       =   &H00E0E0E0&
         Caption         =   "Offset"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   3720
         TabIndex        =   39
         Top             =   600
         Width           =   735
      End
   End
   Begin VB.Frame Frame2 
      BackColor       =   &H00FF8080&
      BorderStyle     =   0  'None
      Caption         =   "Barra de Estado"
      ForeColor       =   &H0000C0C0&
      Height          =   1095
      Left            =   0
      TabIndex        =   4
      Top             =   -120
      Width           =   6495
      Begin ButtonEstiloMac.ButtonMac Boton_cambiar_puerto 
         Height          =   375
         Left            =   4080
         TabIndex        =   67
         Top             =   240
         Width           =   1095
         _ExtentX        =   1931
         _ExtentY        =   661
         BackColor       =   16744576
         Caption         =   "Cambiar (z)"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         PicOpacity      =   0
      End
      Begin MSComDlg.CommonDialog dialogoGuardar 
         Left            =   5760
         Top             =   240
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin MSCommLib.MSComm MSComm1 
         Left            =   120
         Top             =   480
         _ExtentX        =   1005
         _ExtentY        =   1005
         _Version        =   393216
         DTREnable       =   -1  'True
      End
      Begin VB.Timer TimerTiempo 
         Interval        =   1000
         Left            =   1920
         Top             =   600
      End
      Begin VB.Timer Timer_comm 
         Enabled         =   0   'False
         Interval        =   2000
         Left            =   1440
         Top             =   600
      End
      Begin VB.Timer Timer1 
         Enabled         =   0   'False
         Interval        =   5000
         Left            =   960
         Top             =   600
      End
      Begin VB.Label Label4 
         BackColor       =   &H00FF8080&
         Caption         =   "Puerto Seleccionado:"
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
         Left            =   120
         TabIndex        =   6
         Top             =   240
         Width           =   2415
      End
      Begin VB.Label Etiq_Puerto 
         BackColor       =   &H00FF8080&
         Caption         =   "Ninguno"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   375
         Left            =   2760
         TabIndex        =   5
         Top             =   240
         Width           =   1215
      End
   End
   Begin VB.Frame FramePaso2 
      BackColor       =   &H00FF8080&
      BorderStyle     =   0  'None
      Caption         =   "Configuración de sonda"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   3495
      Left            =   0
      TabIndex        =   0
      Top             =   960
      Visible         =   0   'False
      Width           =   6495
      Begin VB.VScrollBar VScrollDia 
         Height          =   350
         Left            =   2160
         Max             =   31
         Min             =   1
         TabIndex        =   77
         Top             =   1080
         Value           =   1
         Width           =   255
      End
      Begin VB.VScrollBar VScrollSegundo 
         Height          =   350
         Left            =   5520
         Max             =   59
         TabIndex        =   76
         Top             =   1080
         Width           =   255
      End
      Begin VB.VScrollBar VScrollMinuto 
         Height          =   350
         Left            =   4920
         Max             =   59
         TabIndex        =   75
         Top             =   1080
         Width           =   255
      End
      Begin VB.VScrollBar VScrollHora 
         Height          =   350
         Left            =   4320
         Max             =   23
         TabIndex        =   74
         Top             =   1080
         Width           =   255
      End
      Begin VB.VScrollBar VScrollAnios 
         Height          =   350
         Left            =   3400
         Max             =   99
         TabIndex        =   73
         Top             =   1080
         Value           =   1
         Width           =   255
      End
      Begin VB.VScrollBar VScrollMes 
         Height          =   350
         Left            =   2800
         Max             =   12
         Min             =   1
         TabIndex        =   72
         Top             =   1080
         Value           =   1
         Width           =   255
      End
      Begin VB.VScrollBar VScrollSegundos 
         Height          =   350
         Left            =   1680
         Max             =   60
         Min             =   1
         TabIndex        =   71
         Top             =   1680
         Value           =   5
         Width           =   255
      End
      Begin ButtonEstiloMac.ButtonMac Boton_Enviar 
         Height          =   615
         Left            =   4560
         TabIndex        =   61
         Top             =   2520
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   1085
         BackColor       =   16744576
         Caption         =   "Configurar"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         PicOpacity      =   0
      End
      Begin VB.CheckBox Check_borrar_memoria 
         BackColor       =   &H00FF8080&
         Caption         =   "Borrar Memoria"
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Left            =   3840
         TabIndex        =   46
         Top             =   1680
         Value           =   1  'Checked
         Width           =   1935
      End
      Begin VB.CheckBox Check_calibracion 
         BackColor       =   &H00FF8080&
         Caption         =   "Calibracion al iniciar"
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Left            =   2160
         TabIndex        =   45
         Top             =   2760
         Visible         =   0   'False
         Width           =   2055
      End
      Begin VB.TextBox total_estaciones_texto 
         Height          =   375
         Left            =   1200
         TabIndex        =   44
         Text            =   "1"
         Top             =   2640
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.TextBox segundos_muestra_texto 
         Enabled         =   0   'False
         Height          =   350
         Left            =   1440
         TabIndex        =   24
         Text            =   "5"
         Top             =   1680
         Width           =   375
      End
      Begin VB.ComboBox Combo_id 
         Height          =   315
         ItemData        =   "estacion.frx":4FDA5
         Left            =   1320
         List            =   "estacion.frx":4FDB2
         TabIndex        =   22
         Text            =   "Seleccione ID"
         Top             =   2160
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton nosincroniza 
         BackColor       =   &H00FF8080&
         Caption         =   "Personalizar fecha"
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Left            =   120
         TabIndex        =   19
         Top             =   1080
         Width           =   1695
      End
      Begin VB.OptionButton sisincroniza 
         BackColor       =   &H00FF8080&
         Caption         =   "Sincronizar con PC"
         ForeColor       =   &H00FFFFFF&
         Height          =   375
         Left            =   120
         TabIndex        =   18
         Top             =   600
         Value           =   -1  'True
         Width           =   1695
      End
      Begin VB.TextBox segundos 
         Enabled         =   0   'False
         Height          =   350
         Left            =   5280
         TabIndex        =   13
         Text            =   "00"
         Top             =   1080
         Width           =   300
      End
      Begin VB.TextBox minutos 
         Enabled         =   0   'False
         Height          =   350
         Left            =   4680
         TabIndex        =   12
         Text            =   "00"
         Top             =   1080
         Width           =   300
      End
      Begin VB.TextBox horas 
         Enabled         =   0   'False
         Height          =   350
         Left            =   4080
         TabIndex        =   11
         Text            =   "00"
         Top             =   1080
         Width           =   300
      End
      Begin VB.TextBox dias 
         Enabled         =   0   'False
         Height          =   350
         Left            =   1900
         TabIndex        =   10
         Text            =   "01"
         Top             =   1080
         Width           =   300
      End
      Begin VB.TextBox meses 
         Enabled         =   0   'False
         Height          =   350
         Left            =   2520
         TabIndex        =   9
         Text            =   "01"
         Top             =   1080
         Width           =   300
      End
      Begin VB.TextBox anios 
         Enabled         =   0   'False
         Height          =   350
         Left            =   3120
         TabIndex        =   8
         Text            =   "01"
         Top             =   1080
         Width           =   300
      End
      Begin VB.CommandButton Boton_Enviarx 
         Caption         =   "Configurar"
         Default         =   -1  'True
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
         Left            =   4680
         TabIndex        =   3
         Top             =   2520
         Visible         =   0   'False
         Width           =   1215
      End
      Begin VB.Label Label_total_estaciones 
         BackColor       =   &H00FF8080&
         Caption         =   "Total de estaciones:"
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
         TabIndex        =   43
         Top             =   2640
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.Label Label_tiempo_m 
         BackColor       =   &H00FF8080&
         Caption         =   "Muestrear cada:"
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
         TabIndex        =   42
         Top             =   1680
         Width           =   1095
      End
      Begin VB.Label Label_seg 
         BackColor       =   &H00FF8080&
         Caption         =   "Segundos"
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
         Left            =   2040
         TabIndex        =   25
         Top             =   1800
         Width           =   975
      End
      Begin VB.Label Label_id 
         BackColor       =   &H00FF8080&
         Caption         =   "Número de sonda:"
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
         TabIndex        =   23
         Top             =   2160
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.Label Labelhorasis 
         Alignment       =   2  'Center
         BackColor       =   &H00FF8080&
         Caption         =   "00:00:00"
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
         Left            =   4440
         TabIndex        =   17
         Top             =   600
         Width           =   975
      End
      Begin VB.Label Labelfechasis 
         Alignment       =   2  'Center
         BackColor       =   &H00FF8080&
         Caption         =   "00/00/00"
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
         Left            =   2160
         TabIndex        =   16
         Top             =   600
         Width           =   1215
      End
      Begin VB.Label Labelhora 
         Alignment       =   2  'Center
         BackColor       =   &H00FF8080&
         Caption         =   "hh/mm/ss"
         ForeColor       =   &H00FFFFFF&
         Height          =   375
         Left            =   4560
         TabIndex        =   15
         Top             =   240
         Width           =   855
      End
      Begin VB.Label Labelfecha 
         Alignment       =   2  'Center
         BackColor       =   &H00FF8080&
         Caption         =   "dia/mes/año"
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Left            =   2280
         TabIndex        =   14
         Top             =   240
         Width           =   1095
      End
   End
   Begin VB.Frame FrameLeyendo 
      BackColor       =   &H00FF8080&
      BorderStyle     =   0  'None
      Height          =   3375
      Left            =   0
      TabIndex        =   51
      Top             =   960
      Visible         =   0   'False
      Width           =   6495
      Begin VB.Label lblLeyendo 
         Alignment       =   2  'Center
         BackColor       =   &H00FF8080&
         Caption         =   "Obteniendo Datos..."
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   24
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   615
         Left            =   1080
         TabIndex        =   52
         Top             =   600
         Width           =   4695
      End
      Begin VB.Label lblespere 
         Alignment       =   2  'Center
         BackColor       =   &H00FF8080&
         Caption         =   "Espere..."
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   13.5
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   615
         Left            =   960
         TabIndex        =   53
         Top             =   1560
         Width           =   4695
      End
   End
End
Attribute VB_Name = "form_estacion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub abrir_puerto()
 'abre un puerto serial
On Error GoTo manejar_errores
    
    MSComm1.CommPort = puerto_com
    MSComm1.Settings = "9600,n,8,1"
    MSComm1.PortOpen = True
   
    Exit Sub
   
manejar_errores:
MsgBox ("Error detectado: " + Err.Description)
   
End Sub

Private Sub bOTON_acepta_com_Click()
    puerto_com = combo_puerto_com.ListIndex
    If puerto_com = -1 Then
        MsgBox "No has seleccionado un puerto"
    Else
        puerto_com = CInt(combo_puerto_com.List(puerto_com))
        Frame_puerto.Visible = False
        Etiq_Puerto.Caption = "COM " + Str(puerto_com)
    End If
End Sub

Private Sub Boton_busca_puertos_Click()
    detecta_com
End Sub

Private Sub Boton_cambiar_puerto_Click()
    detecta_com
    Frame_puerto.Visible = True
End Sub

Private Sub boton_recepcion_Click()
    form_estacion.Visible = False
    form_recepcion.Visible = True
    
    
End Sub

Private Sub botonCancelCon_Click()
    frameER.Visible = True
    framePaso1.Visible = False
End Sub

Private Sub botonConfigura_Click()
    ocultar_frames
    framePaso1.Visible = True
    BotonConfigura2.Visible = True
    boton_guardar.Visible = False
    txt_dir_sonda.SetFocus
End Sub

Private Sub BotonConfigura2_Click()

Dim prueba_var As Boolean
Dim temporal As Integer
Dim sonda_valida As Boolean

    sonda_valida = IsNumeric(txt_dir_sonda.Text)
    If Not sonda_valida Then
        MsgBox "La dirección indicada no es válida"
        Exit Sub
    End If
    txt_dir_sonda.Text = Str(CInt(txt_dir_sonda.Text))
    Frame_espere.Visible = True
    abrir_puerto
    If MSComm1.PortOpen Then

        MSComm1.Output = "+++"
        If leer_ok Then
            MSComm1.Output = "ATMY" + txt_dir_sonda.Text + Chr(13)
            prueba_var = leer_ok
            MSComm1.Output = "ATDL" + txt_dir_sonda.Text + Chr(13)
            prueba_var = leer_ok
            MSComm1.Output = "ATCN" + Chr(13)
            prueba_var = leer_ok
            limpia_buffer
            MSComm1.Output = "s"
            caracter = leer_mscomm1()
            If caracter = 0 Then
                MsgBox "No hay respuesta de la sonda"
                MSComm1.PortOpen = False
                Frame_espere.Visible = False

                Exit Sub
            Else
                temporal = MsgBox("Comunicación con sonda establecida", vbOKOnly + vbInformation)
                FramePaso2.Visible = True
                framePaso1.Visible = False
                Boton_Enviar.SetFocus
            End If
        Else
            MsgBox "No hay respuesta del receptor." + Chr(13) + "Revise la conexión"
            MSComm1.PortOpen = False
        End If
    End If
    BotonConfigura2.Enabled = True
    Frame_espere.Visible = False
End Sub
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
Private Function leer_mscomm1() As String
'Espera leer un caracter del mscomm1 durante el tiempo deternimado por
'el timer_comm. La función regresa el caracter leído, en caso de no obtener ningún caracter
'devuelve el valor 0
    Dim temp_rthres As Integer
    Dim temp_Sthres As Integer
    Dim temp_inputlen As Integer
    
    recepcion_comm = False
    Timer_comm.Enabled = True
    temp_rthres = MSComm1.RThreshold
    temp_inputlen = MSComm1.InputLen
    temp_Sthres = MSComm1.SThreshold
    MSComm1.SThreshold = 0
    MSComm1.RThreshold = 0
    MSComm1.InputLen = 10
    Do
        dummi = DoEvents()
    Loop Until (MSComm1.InBufferCount >= 1 Or recepcion_comm = True)
    If recepcion_comm Then
        leer_mscomm1 = 0
    Else
        Timer_comm.Enabled = False
        leer_mscomm1 = MSComm1.Input
    End If
    MSComm1.SThreshold = temp_Sthres
    MSComm1.RThreshold = temp_rthres
    MSComm1.InputLen = temp_inputlen
End Function
Private Sub configura_sonda()
Dim caracter As String
Dim configuracion_ok As Boolean

    configuracion_ok = False
    MSComm1.Output = "T"
    caracter = leer_mscomm1()
        If caracter = "z" Then
                configuracion_ok = True
                If (sisincroniza.Value) Then
                    enhex = dec_A_hex(CByte(segundo))
                    MSComm1.Output = enhex + "@"
                    
                Else
                    enhex = dec_A_hex(segundos.Text)
                    MSComm1.Output = enhex + "@"
                End If
        End If
        configuracion_ok = False
        caracter = leer_mscomm1()
        If caracter = "Z" Then
                configuracion_ok = True
                If (sisincroniza.Value) Then
                    enhex = dec_A_hex(CByte(minuto))
                    MSComm1.Output = enhex + "@"
                Else
                    enhex = dec_A_hex(minutos.Text)
                    MSComm1.Output = enhex + "@"
                End If
        End If
        configuracion_ok = False
        caracter = leer_mscomm1()
        If caracter = "y" Then
            configuracion_ok = True
            If (sisincroniza.Value) Then
                enhex = dec_A_hex(CByte(hora))
                MSComm1.Output = enhex + "@"
            Else
                enhex = dec_A_hex(horas.Text)
                MSComm1.Output = enhex + "@"
            End If
        
        End If
        caracter = leer_mscomm1()
        If caracter = "Y" Then
            If (sisincroniza.Value) Then
                enhex = dec_A_hex(CByte(dia))
                MSComm1.Output = enhex + "@"
            Else
                enhex = dec_A_hex(dias.Text)
                MSComm1.Output = enhex + "@"
            End If
        End If
        caracter = leer_mscomm1()
        If caracter = "x" Then
            If (sisincroniza.Value) Then
                enhex = dec_A_hex(CByte(mes))
                MSComm1.Output = enhex + "@"
            Else
                enhex = dec_A_hex(meses.Text)
                MSComm1.Output = enhex + "@"
            End If
        End If
        caracter = leer_mscomm1()
        If caracter = "X" Then
            If (sisincroniza.Value) Then
                enhex = dec_A_hex(CByte(anio Mod 100))
                MSComm1.Output = enhex + "@"
            Else
                enhex = dec_A_hex(anios.Text)
                MSComm1.Output = enhex + "@"
            End If
        End If
        caracter = leer_mscomm1()
        If caracter = "W" Then
                id_estacion = Combo_id.ListIndex
                id_estacion = Combo_id.ItemData(id_estacion)
                id_estacion = CStr(id_estacion) + "@"
                MSComm1.Output = id_estacion
        End If
        caracter = leer_mscomm1()
        If caracter = "w" Then
                 MSComm1.Output = segundos_muestra_texto.Text + "@"
       
        End If
        caracter = leer_mscomm1()
        If caracter = "U" Then
                MSComm1.Output = total_estaciones_texto.Text + "@"
        End If
        caracter = leer_mscomm1()
        If caracter = "u" Then
                If (Check_calibracion.Value) Then
                    MSComm1.Output = "1@"
                Else
                    MSComm1.Output = "0@"
                End If
        End If
        caracter = leer_mscomm1()
        If caracter = "t" Then
                If (Check_borrar_memoria) Then
                    MSComm1.Output = "0@"
                Else
                    MSComm1.Output = "1@"
                End If
        End If
        caracter = leer_mscomm1()
        If caracter = "a" Then
            MSComm1.Output = multi0.Text + "@"
        End If
        caracter = leer_mscomm1()
        If caracter = "A" Then
            MSComm1.Output = offset0.Text + "@"
        End If
        caracter = leer_mscomm1()
        If caracter = "b" Then
            MSComm1.Output = multi1.Text + "@"
        End If
        caracter = leer_mscomm1()
        If caracter = "B" Then
            MSComm1.Output = offset1.Text + "@"
        End If
        caracter = leer_mscomm1()
        If caracter = "c" Then
            MSComm1.Output = multi2.Text + "@"
        End If
        caracter = leer_mscomm1()
        If caracter = "C" Then
            MSComm1.Output = offset2.Text + "@"
        End If
        caracter = leer_mscomm1()
        If caracter = "d" Then
            MSComm1.Output = "0.0589@"
        End If
        caracter = leer_mscomm1()
        If caracter = "D" Then
            MSComm1.Output = offset3.Text + "@"
        End If
        
                
   ' End If
End Sub
'Esta funcion revisa la respuesta "OK" a comandos AT por mscomm1
Private Function leer_ok() As Boolean
    Dim contador As Integer
    Dim cadena As String
    Dim temp_rthres As Integer
    Dim temp_input_len As Integer

        contador = 0
        temp_rthres = MSComm1.RThreshold
        temp_input_len = MSComm1.InputLen
        MSComm1.RThreshold = 4
        MSComm1.InputLen = 3

        Do
        dummi = DoEvents()
        contador = contador + 1
        Loop Until MSComm1.InBufferCount >= 3 Or contador >= 3500
        cadena = MSComm1.Input
        MSComm1.RThreshold = temp_rthres
        MSComm1.InputLen = temp_input_len

        If cadena = "OK" + Chr(13) Then
            leer_ok = True
        Else
            leer_ok = False
        End If
        
End Function






Private Sub botonObtener_Click()
    ocultar_frames
    'BotonConfigura2.Enabled = False
    framePaso1.Visible = True
    BotonConfigura2.Visible = False
    boton_guardar.Visible = True
    txt_dir_sonda.SetFocus
End Sub





Private Sub Command1_Click()
    validar_configuracion
End Sub



Private Sub combo_puerto_com_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        bOTON_acepta_com_Click
    End If
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
    Select Case KeyAscii
    Case 27
        If framePaso1.Visible Then
            botonCancelCon_Click
        End If
  
    Case Asc("z"), KeyAscii = Asc("Z")
        
        Boton_cambiar_puerto_Click
        Exit Sub
    Case Asc("q"), Asc("Q")
        If framePaso1.Visible Then
            'txt_dir_sonda.Text = "101"
            txt_dir_sonda.SetFocus
            txt_dir_sonda.SelStart = 0
            txt_dir_sonda.SelLength = 3
        End If

    Case 13
        If Frame_puerto.Visible Then
            bOTON_acepta_com_Click
        End If
    
    
    Case Else
        If frameER.Visible Then
            'form_estacion.KeyPreview = False
            Select Case KeyAscii
            Case Asc("c"), Asc("C")
                botonConfigura_Click
            Case Asc("b"), Asc("B")
                botonObtener_Click
            Case Asc("M"), Asc("m")
                boton_recepcion_Click
            End Select
        End If
    End Select
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

Private Sub Form_Load()
    
    framePaso1.Top = 960
    framePaso1.Left = 0
    frameER.Top = 960
    frameER.Left = 0
    Frame_puerto.Top = 0
    Frame_puerto.Left = 0
    form_estacion.Height = 4875
    form_estacion.Width = 6585
    Frame_espere.Top = 600
    Frame_espere.Left = 240
    
    detecta_com
    'form_estacion.KeyPreview = False
    configura = False
    Combo_id.ListIndex = 0
    transmitiendo = False
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
    'configura el cuadro de dialogo guardar
    dialogoGuardar.DefaultExt = ".txt"
    dialogoGuardar.DialogTitle = "Guardar en el archivo..."
    dialogoGuardar.Filename = ""
    dialogoGuardar.Filter = "Texto (*.txt)|*.txt|Todos los archivos(*.*)|*.*"
    dialogoGuardar.Flags = cdlOFNHideReadOnly
    dialogoGuardar.Flags = cdlOFNOverwritePrompt
    guardar_cerrar = False

End Sub


Private Sub boton_guardar_click()
'    On Error GoTo maneja_error
Dim sonda_valida As Boolean
Dim caracter As String
Dim tem_rthres As Integer
Dim tem_sthres As Integer

    sonda_valida = IsNumeric(txt_dir_sonda.Text)
    If Not sonda_valida Then
        MsgBox "La dirección indicada no es válida"
        Exit Sub
    End If
    txt_dir_sonda.Text = Str(CInt(txt_dir_sonda.Text))
    tem_rthres = MSComm1.RThreshold
    tem_sthres = MSComm1.SThreshold
    MSComm1.RThreshold = 0
    MSComm1.SThreshold = 0
    abrir_puerto

    If MSComm1.PortOpen Then

        MSComm1.Output = "+++"
        'prueba_var = leer_ok
        If leer_ok Then
            MSComm1.Output = "ATMY" + txt_dir_sonda.Text + Chr(13)
            prueba_var = leer_ok
            MSComm1.Output = "ATDL" + txt_dir_sonda.Text + Chr(13)
            prueba_var = leer_ok
            MSComm1.Output = "ATCN" + Chr(13)
            prueba_var = leer_ok
            limpia_buffer
            MSComm1.Output = "s"
            caracter = leer_mscomm1()
            If caracter = "0" Then
                MsgBox "No hay respuesta de la sonda"
                MSComm1.PortOpen = False
                Frame_espere.Visible = False

                Exit Sub
            Else
                limpia_buffer
                temporal = MsgBox("Comunicación con sonda establecida", vbOKOnly + vbInformation)
                FramePaso2.Visible = True
                framePaso1.Visible = False
            End If
        MsgBox "Proporcione el nombre del archivo" + Chr(13) & Chr(10) + "en donde se guardará la lectura"
        dialogoGuardar.ShowSave
        nombre_archivo = dialogoGuardar.Filename
        Close
        numarchivo = FreeFile
        Open nombre_archivo For Output As #numarchivo
        Print #numarchivo, "Fecha Hora Temperatura Humedad Presión Dirección Velocidad Altura"
        ocultar_frames
        FrameLeyendo.Visible = True
        limpia_buffer
        MSComm1.Output = "t"
        Do
            caracter = leer_mscomm1()
            MSComm1.Output = "b"

            Select Case caracter
                Case ""
                
                Case "s"
                    recibi_S = True
                    Timer1_Timer
            
                Case "*"
                    Close #numarchivo
                    MsgBox "Lectura terminada"
                    respuesta = MsgBox("¿Deseas ver el archivo generado?", vbYesNo)
                    If respuesta = vbYes Then    '
                        val_regresa = Shell("notepad.exe " + nombre_archivo, vbNormalFocus)
                    End If
                    Boton_Cerrar_Click
                    ocultar_frames
                    frameER.Visible = True
                        
                Case Else
                    If caracter = "+" Then
                        caracter = Chr(13) & Chr(10)
                    End If
                    Print #numarchivo, caracter; 'Escribe en el archivo
            End Select
        Loop Until caracter = "*"
            'Boton_Abrir_Click
            'TimerEsperaLEc.Enabled = True
        Else
            MsgBox "No hay respuesta del receptor." + Chr(13) + "Revise la conexión"
            MSComm1.PortOpen = False
        End If 'if leer_ok
    End If 'if puerto abierto
    MSComm1.RThreshold = tem_rthres
    MSComm1.SThreshold = tem_sthres


'    If MSComm1.PortOpen Then
'            Boton_Abrir_Click
'            TimerEsperaLEc.Enabled = True
'
''            MsgBox "Proporcione el nombre del archivo" + Chr(13) & Chr(10) + "en donde se guardará la lectura"
' '           dialogoGuardar.ShowSave
' '           nombre_archivo = dialogoGuardar.FileName
' '           Close
' '           numarchivo = FreeFile
' '           Open nombre_archivo For Output As #numarchivo
'  '
'  '          MSComm1.Output = "t"
            
 '   End If

maneja_error:
End Sub

Private Sub Boton_Cerrar_Click()
'Al pulsar aquí cierra un puerto serial
On Error GoTo manejar_errores 'Protejo frente al error.
 MSComm1.PortOpen = False 'Puede haber error si
   'intento cerrar un puerto que está en uso por otro
   'programa, entre otras causas.
 GoTo salir
 
manejar_errores:
 MsgBox ("Error al intentar cerrar COM" + Str$(puerto_com))
 MsgBox ("Error detectado: " + Err.Description)
 Resume salir
 
salir:
 
End Sub



Private Sub Form_Unload(Cancel As Integer)
    Unload form_recepcion
End Sub







Private Sub Boton_Enviar_Click()
    obten_hora
    limpia_buffer
    configura_sonda
    MSComm1.PortOpen = False
    MsgBox "Configurado"
    respuesta_msg = MsgBox("¿Deseas comenzar a capturar datos?", vbYesNo, "Sonda...")
    FramePaso2.Visible = False
    frameER.Visible = True
    If respuesta_msg = vbYes Then
        form_estacion.Visible = False
        form_recepcion.Visible = True
        form_recepcion.txt_dir_S1.Text = txt_dir_sonda.Text
    End If
End Sub
Private Function validar_configuracion() As Boolean
Dim esnumero As Boolean
    validar_configuracion = True
    esnumero = IsNumeric(segundos_muestra_texto.Text)
    If Not esnumero Then
        validar_configuracion = False
        MsgBox "Debe colocar un entero en la casilla muestrear"
        Exit Function
    End If
    esnumero = IsNumeric(dias.Text) And IsNumeric(meses.Text) And IsNumeric(anios.Text) And IsNumeric(horas.Text) And IsNumeric(minutos.Text) And IsNumeric(segundos.Text)
    If Not esnumero Then
            validar_configuracion = False
            MsgBox "El formato de fecha no es válido"
            Exit Function
    End If
    
End Function






Private Sub Timer_comm_Timer()
    recepcion_comm = True
    
End Sub

Private Sub Timer1_Timer()
Timer1.Enabled = False

If recibi_S Then
    FramePaso2.Visible = True
    

Else
    MsgBox "No se encontró lector," + Chr$(13) + "verifique la conexión"
    Boton_Cerrar_Click
    ocultar_frames
    framePaso1.Visible = True
    
End If
End Sub

Private Function dec_A_hex(num_dec As Byte) As Byte
If (num_dec > 9) Then
    dec_A_hex = num_dec + (6 * Int(num_dec / 10))
Else
    dec_A_hex = num_dec
End If
End Function

Private Sub obten_hora()
    mihora = Time
    mifecha = Date
    hora = Hour(mihora)
    minuto = Minute(mihora)
    segundo = Second(mihora)
    dia = Day(mifecha)
    mes = Month(mifecha)
    anio = Year(mifecha)
    Labelfechasis.Caption = dia + "/" + mes + "/" + anio
    Labelhorasis.Caption = hora + ":" + minuto + ":" + segundo

End Sub

Private Sub ocultar_frames()
            FrameLeyendo.Visible = False
            FramePaso2.Visible = False
            framePaso1.Visible = False
            frameER.Visible = False

End Sub
Private Sub TimerTiempo_Timer()
    obten_hora
End Sub



Private Sub txt_dir_sonda_KeyPress(KeyAscii As Integer)
'    If KeyAscii > Asc("0") And KeyAscii < Asc("9") Then
'        txt_dir_sonda.Text = txt_dir_sonda.Text + Chr(KeyAscii)
'    End If
    If KeyAscii = 13 Then
        If BotonConfigura2.Visible Then
            BotonConfigura2_Click
        End If
        If boton_guardar.Visible Then
            boton_guardar_click
        End If
    End If
End Sub

Private Sub VScroll1_Change()
    Text1.Text = VScroll1.Value
    
End Sub


Private Sub VScrollAnios_Change()

    anios.Text = VScrollAnios.Value
End Sub

Private Sub VScrollDia_Change()
    dias.Text = VScrollDia.Value
End Sub

Private Sub VScrollHora_Change()
    horas.Text = VScrollHora.Value
End Sub

Private Sub VScrollMes_Change()
    meses.Text = VScrollMes.Value
End Sub

Private Sub VScrollMinuto_Change()
    minutos.Text = VScrollMinuto.Value
End Sub

Private Sub VScrollSegundo_Change()
    segundos.Text = VScrollSegundo.Value
End Sub

Private Sub VScrollSegundos_Change()
    segundos_muestra_texto.Text = VScrollSegundos.Value
End Sub
