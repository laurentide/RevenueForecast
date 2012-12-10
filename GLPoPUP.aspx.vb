'REVENUE FORECAST
'GLPoPUP
'description: Ce formulaire "POP UP" affiche une aide pour avoir un bonne idée du code GL sélectionné
'Par: Francis Gauthier
'date: 27 juillet 2007
'contact: f.gauthier@cgodin.qc.ca

Public Class GLPoPUP
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents TextBox1 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label1 As System.Web.UI.WebControls.Label
    Protected WithEvents Button1 As System.Web.UI.WebControls.Button

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
        Dim struser As String
        Dim strReq As String
        Dim dtTable As New DataTable

        Me.Label1.Text = Session("Expense")
        Me.Label1.Style("text-align") = "center"

        strReq = "Select help from tblGL Where description ='" & Session("Expense") & "'"
         dtTable = LectureBD(strReq)

        Me.TextBox1.Text = dtTable.Rows(0).Item(0)
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Response.Write("<script language='javascript'> { self.close() }</script>")
    End Sub
End Class
