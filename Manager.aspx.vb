'REVENUE FORECAST
'Manager
'description: Ce formulaire est le menu d'un gérant, il affiche les actions possibles
'Par: Francis Gauthier
'date: 27 juillet 2007
'contact: f.gauthier@cgodin.qc.ca

Public Class Manager
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Label4 As System.Web.UI.WebControls.Label
    Protected WithEvents Label3 As System.Web.UI.WebControls.Label
    Protected WithEvents LinkButton1 As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkButton2 As System.Web.UI.WebControls.LinkButton
    Protected WithEvents Label5 As System.Web.UI.WebControls.Label
    Protected WithEvents Label6 As System.Web.UI.WebControls.Label
    Protected WithEvents LinkButton4 As System.Web.UI.WebControls.LinkButton
    Protected WithEvents Linkbutton5 As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkButton6 As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkButton7 As System.Web.UI.WebControls.LinkButton
    Protected WithEvents LinkButton3 As System.Web.UI.WebControls.LinkButton
    Protected WithEvents Image1 As System.Web.UI.WebControls.Image
    Protected WithEvents LinkButton8 As System.Web.UI.WebControls.LinkButton

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
        Dim strReq As String
        Dim dtTable As New DataTable
        Dim struser As String


        struser = Request.ServerVariables("LOGON_user").Substring(Request.ServerVariables("LOGON_user").IndexOf("\") + 1, Request.ServerVariables("LOGON_user").Length - (Request.ServerVariables("LOGON_user").IndexOf("\") + 1))

        If EstManager(struser) = False And EstAdmin(struser) = False Then
            Response.Redirect("Denied.html")
        Else
            strReq = "Select E.name, M.departmentid,D.description from tblmanager AS M INNER JOIN tblemployee AS E ON M.employeeid = E.employeeid INNER JOIN tblDepartement AS D ON M.departmentid = D.departmentid where upper(E.UserName)= upper('" & struser & "')"

            dtTable = LectureBD(strReq)

            Me.Label4.Text = dtTable.Rows(0).Item(0)

            'Ici On met les admins!
            If EstAdmin(struser) = True Then
                Me.LinkButton6.Visible = True
                Me.LinkButton3.Visible = True
                Me.Label6.Visible = True
                Me.LinkButton7.Visible = True

            End If
            If struser = "DeanW" Or struser = "ClaireD" Or struser = "d2dadmin" Or struser = "Duc-DuyN" Then
                Me.LinkButton4.Visible = True
                Me.Linkbutton5.Visible = True
            End If
        End If
    End Sub


    Private Sub ForeCast(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LinkButton2.Click, LinkButton1.Click
        If sender Is Me.LinkButton1 Then
            Session("Open mode") = "add"
        ElseIf sender Is Me.LinkButton2 Then
            Session("Open mode") = "edit"
        End If
        Response.Redirect("Menu.aspx")
    End Sub

    Private Sub LinkButton3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LinkButton3.Click
        Response.Redirect("GL.aspx")
    End Sub

    Private Sub LinkButton4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LinkButton4.Click
        Response.Redirect("department.aspx")
    End Sub

    Private Sub Linkbutton6_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Response.Redirect("http://lcl-faxs/reports1/Pages/Folder.aspx")
    End Sub

    Private Sub Linkbutton5_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Linkbutton5.Click
        Response.Redirect("Managers.aspx")
    End Sub

    Private Sub LinkButton7_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LinkButton7.Click
        Response.Redirect("General.aspx")
    End Sub

    Private Sub LinkButton8_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LinkButton8.Click
        Response.Redirect("Adjustments.aspx")
    End Sub
End Class
