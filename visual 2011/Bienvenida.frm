VERSION 5.00
Begin VB.Form frmSplash 
   BackColor       =   &H00EBDCC5&
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   4245
   ClientLeft      =   255
   ClientTop       =   1410
   ClientWidth     =   7380
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   9.75
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "Bienvenida.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4245
   ScaleWidth      =   7380
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      BackColor       =   &H00EBDCC5&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4050
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   7080
      Begin VB.Timer Timer1 
         Interval        =   20
         Left            =   360
         Top             =   360
      End
      Begin VB.Image imgLogo 
         Height          =   2055
         Left            =   120
         Picture         =   "Bienvenida.frx":000C
         Stretch         =   -1  'True
         Top             =   960
         Width           =   2175
      End
      Begin VB.Label lblCopyright 
         Caption         =   "Copyright"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   4
         Top             =   3120
         Visible         =   0   'False
         Width           =   2415
      End
      Begin VB.Label lblCompany 
         Caption         =   "Compañía"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Top             =   3360
         Visible         =   0   'False
         Width           =   2415
      End
      Begin VB.Label lbl_mensaje 
         BackColor       =   &H00EBDCC5&
         BackStyle       =   0  'Transparent
         Caption         =   "Presione una tecla para continuar"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00817345&
         Height          =   195
         Left            =   120
         TabIndex        =   2
         Top             =   3660
         Width           =   6855
      End
      Begin VB.Label lblVersion 
         Alignment       =   1  'Right Justify
         AutoSize        =   -1  'True
         BackColor       =   &H00EBDCC5&
         Caption         =   "Versión"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H009D723C&
         Height          =   285
         Left            =   5970
         TabIndex        =   5
         Top             =   2700
         Width           =   885
      End
      Begin VB.Label lblPlatform 
         Alignment       =   1  'Right Justify
         AutoSize        =   -1  'True
         BackColor       =   &H00EBDCC5&
         Caption         =   "Software"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H009D723C&
         Height          =   330
         Left            =   5790
         TabIndex        =   6
         Top             =   2040
         Width           =   1125
      End
      Begin VB.Label lblProductName 
         AutoSize        =   -1  'True
         BackColor       =   &H00EBDCC5&
         Caption         =   "Bienvenido"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   32.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H009D723C&
         Height          =   765
         Left            =   2760
         TabIndex        =   8
         Top             =   1140
         Width           =   3450
      End
      Begin VB.Label lblCabcra 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00EBDCC5&
         Caption         =   "U.N.A.M. Centro de Ciencias de la Atmósfera"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H009D723C&
         Height          =   255
         Left            =   3600
         TabIndex        =   1
         Top             =   240
         Width           =   3375
      End
      Begin VB.Label lblCompanyProduct 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         BackColor       =   &H00EBDCC5&
         Caption         =   "Instrumentación Meteorológica"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   18
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H009D723C&
         Height          =   435
         Left            =   840
         TabIndex        =   7
         Top             =   480
         Width           =   5370
      End
   End
End
Attribute VB_Name = "frmSplash"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Private Sub Form_KeyPress(KeyAscii As Integer)
    Unload Me
End Sub

Private Sub Form_Load()
    lblVersion.Caption = "Versión " & App.Major & "." & App.Minor & "." & App.Revision
    'lblProductName.Caption = App.Title
    lblPlatform.Caption = "Software para captura y visualización" & Chr(13) & Chr(10) & "de datos de sonda cautiva"
   
    
End Sub

Private Sub Frame1_Click()
    Unload Me
End Sub

Private Sub Timer1_Timer()
    lblCabcra.Left = lblCabcra.Left - 5
    If lblCabcra.Left < 6 Then
        lblCabcra.Left = 5800
    End If
End Sub
