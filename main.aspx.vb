
'REVENUE FORECAST
'Main
'description: Ce formulaire main
'Par: Francis Gauthier
'date: 27 juillet 2007
'contact: f.gauthier@cgodin.qc.ca
'http://www.thescripts.com/forum/thread337476.html
'http://forums.asp.net/t/301963.aspx
Imports System.DirectoryServices
Imports System.Security.Principal.WindowsIdentity

Public Class WebForm1
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents LinkButton1 As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkButton2 As System.Web.UI.WebControls.LinkButton
    Protected WithEvents Label1 As System.Web.UI.WebControls.Label

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub

    Private Sub Menu(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LinkButton1.Click, LinkButton2.Click
        Response.Redirect("Manager.aspx")
    End Sub
End Class
