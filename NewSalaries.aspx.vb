'REVENUE FORECAST
'NewSalaries
'description: Ce formulaire affecte les salaires des employés fictifs
'Par: Francis Gauthier
'date: 27 juillet 2007
'contact: f.gauthier@cgodin.qc.ca
Public Class NewSalaries
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents DataGrid1 As System.Web.UI.WebControls.DataGrid
    Protected WithEvents Button1 As System.Web.UI.WebControls.Button
    Protected WithEvents Label3 As System.Web.UI.WebControls.Label
    Protected WithEvents Image1 As System.Web.UI.WebControls.Image

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
        Dim dtTable As New DataTable
        Dim struser As String

        'Vérifie user
        struser = Request.ServerVariables("LOGON_user").Substring(Request.ServerVariables("LOGON_user").IndexOf("\") + 1, Request.ServerVariables("LOGON_user").Length - (Request.ServerVariables("LOGON_user").IndexOf("\") + 1))
        If EstManager(struser) = False Then
            Response.Redirect("Denied.html")
        Else
            'get data
            dtTable = getData()
            'Affichage
            DataGrid1.DataSource = dtTable
            If Not IsPostBack Then
                Affiche(dtTable)
            End If
        End If
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click

        Response.Redirect("Forecast.aspx")
    End Sub
    Private Function getData() As DataTable
        Dim strReq As String
        Dim dtTable As New DataTable

        strReq = "Select Description, BaseSalary,RRSP,Points,ComponentID FROM tblComponents Where DetailID = " & Session("DetailID") & " and description not like '%total%'"
        dtTable = LectureBD(strReq)

        Return dtTable
    End Function
    Private Sub Affiche(ByVal dtTable As DataTable)
        Dim gridrow As DataGridItem
        Dim footer As DataGridItem
        Dim iCompteur As Integer = 0


        Me.DataGrid1.Columns(6).Visible = False
        DataGrid1.DataBind()
        For Each gridrow In DataGrid1.Items
            gridrow.Cells(0).Text = "Projected employee " & iCompteur + 1
            gridrow.Cells(1).Text = dtTable.Rows(iCompteur).Item(0)
            gridrow.Cells(2).Text = Format(dtTable.Rows(iCompteur).Item(1), "$#,##0;-$#,##0;")
            gridrow.Cells(3).Text = Format(dtTable.Rows(iCompteur).Item(2), "$#,##0;-$#,##0;")
            gridrow.Cells(4).Text = Format(dtTable.Rows(iCompteur).Item(3), "#,##0;-#,##0;")
            gridrow.Cells(6).Text = dtTable.Rows(iCompteur).Item(4)
            iCompteur += 1
        Next
        footer = DataGrid1.Controls(0).Controls(DataGrid1.Controls(0).Controls.Count - 1)

        footer.Cells(0).Text = "Total : " & Me.DataGrid1.Items.Count & " projected employee(s)"
    End Sub


    Private Sub DataGrid1_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles DataGrid1.ItemCommand
        Dim strReq As String
        Dim textbox As TextBox
        Dim dtTable As New DataTable
        Dim gridrow As DataGridItem

        If e.CommandName = "Add" Then

            textbox = e.Item.Cells(1).FindControl("TextBox4")
            strReq = "INSERT INTO tblComponents VALUES(" & Session("DetailID") & ",0,'" & setGuillemets(textbox.Text) & "',"

            textbox = e.Item.Cells(3).FindControl("TextBox2")
            strReq += Val(textbox.Text) & ","

            textbox = e.Item.Cells(4).FindControl("TextBox3")
            strReq += Val(textbox.Text) & ","

            textbox = e.Item.Cells(2).FindControl("TextBox1")
            strReq += Val(textbox.Text) & ")"
            EcritureBD(strReq)
            dtTable = getData()
            DataGrid1.DataSource = dtTable
            Affiche(dtTable)

            Dim dbltotal As Double = 0

            For Each gridrow In DataGrid1.Items
                dbltotal += CDbl(gridrow.Cells(2).Text.Remove(gridrow.Cells(2).Text.IndexOf("$"), 1)) + CDbl(gridrow.Cells(3).Text.Remove(gridrow.Cells(3).Text.IndexOf("$"), 1))
            Next
            'Save
            EcritureBD("EXEC prAjoutDepenseSalaireNew " & Session("DetailID") & "," & dbltotal & ",'Total projected employees Salaries'")

        ElseIf e.CommandName = "Delete" Then

            strReq = "DELETE FROM tblComponents Where ComponentID = " + e.Item.Cells(6).Text
            EcritureBD(strReq)
            dtTable = getData()
            DataGrid1.DataSource = dtTable
            Affiche(dtTable)

            Dim dbltotal As Double = 0

            For Each gridrow In DataGrid1.Items
                dbltotal += CDbl(gridrow.Cells(2).Text.Remove(gridrow.Cells(2).Text.IndexOf("$"), 1)) + CDbl(gridrow.Cells(3).Text.Remove(gridrow.Cells(3).Text.IndexOf("$"), 1))
            Next
            'Save
            EcritureBD("EXEC prAjoutDepenseSalaireNew " & Session("DetailID") & "," & dbltotal & ",'Total projected employees Salaries'")

        End If
    End Sub
End Class
