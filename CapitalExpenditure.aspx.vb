'REVENUE FORECAST
'CapitalExpenditure
'description: Ce formulaire regroupe les dépenses associés à la dépression
'Par: Francis Gauthier
'date: 27 juillet 2007
'contact: f.gauthier@cgodin.qc.ca


Public Class CapitalExpenditure1
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Button1 As System.Web.UI.WebControls.Button
    Protected WithEvents Label1 As System.Web.UI.WebControls.Label
    Protected WithEvents DataGrid1 As System.Web.UI.WebControls.DataGrid
    Protected WithEvents ImageButton1 As System.Web.UI.WebControls.ImageButton
    Protected WithEvents Image1 As System.Web.UI.WebControls.Image
    Protected WithEvents cmdRefresh As System.Web.UI.WebControls.Button

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

        'Vérification utilisateur
        struser = Request.ServerVariables("LOGON_user").Substring(Request.ServerVariables("LOGON_user").IndexOf("\") + 1, Request.ServerVariables("LOGON_user").Length - (Request.ServerVariables("LOGON_user").IndexOf("\") + 1))
        If EstManager(struser) = False Then
            Response.Redirect("Denied.html")
        Else

            dtTable = getData()
            DataGrid1.DataSource = dtTable
            If Not IsPostBack Then
                Affiche(dtTable)
            End If

        End If
    End Sub

    Private Sub Back(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Response.Redirect("Forecast.aspx")
    End Sub
    Private Sub Details(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles DataGrid1.ItemCommand
        Dim strReq As String
        Dim dtTable As DataTable

        'Affiche les dépense
        If e.CommandName = "Details" Then
            strReq = "Select d.DetailID FROM tblBudgetDetails AS D INNER JOIN tblGL AS G ON d.nogl=G.GL Where d.BudgetID = " + CType(Session("BudgetID"), String) + " AND g.description Like '" & e.Item.Cells(0).Text & "'"
            dtTable = LectureBD(strReq)
            Session("DetailID") = CType(dtTable.Rows(0).Item(0), Integer)

            Session("Expense") = e.Item.Cells(0).Text
            Me.DataGrid1.Items(5).Cells(2).Text = "n/a"
            Response.Write("<body><script>window.open(""Components.aspx"",""null"",""width=380,height=250,top=235,left=616,status=no, resizable= no, scrollbars= yes, toolbar= no,location= no,menubar= no"");</script></body>")
        End If
    End Sub

    'Private Sub Refresh(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
    '    Try
    '        Dim dtTable As New DataTable
    '        Dim strREQ As String
    '        Dim footer As DataGridItem

    '        dtTable = getData()
    '        DataGrid1.DataSource = dtTable
    '        Affiche(dtTable)
    '        footer = DataGrid1.Controls(0).Controls(DataGrid1.Controls(0).Controls.Count - 1)

    '        dtTable = New DataTable
    '        strREQ = "SELECT detailID from tblbudgetDetails where budgetid =" & Session("BudgetID") & " and nogl = '10.1010410.'"
    '        dtTable = LectureBD(strREQ)

    '        'Ajoute le montant total au GL de depression
    '        'strREQ = "EXEC dbo.prAjoutDepenseSalaire " & dtTable.Rows(0).Item(0) & "," & CDbl(footer.Cells(3).Text.Remove(footer.Cells(3).Text.IndexOf("$"), 1)) & ",'Total Depreciation'"
    '        'EcritureBD(strREQ)

    '        strREQ = "INSERT INTO tblComponents VALUES(" & dtTable.Rows(0).Item(0) & "," & CDbl(footer.Cells(3).Text.Remove(footer.Cells(3).Text.IndexOf("$"), 1)) & ",'Total Depreciation',0,0,0)"
    '        EcritureBD(strREQ)
    '    Catch ex As Exception

    '    End Try
    'End Sub

    Private Function getData() As DataTable
        Dim strReq As String
        Dim dtTable As New DataTable

        strReq = "Select G.description,D.Inc,ISNULL((SELECT SUM(ISNULL(C.montant,0)) from tblcomponents AS C where C.detailID = D.detailID),0) from tblBudgetdetails AS D INNER JOIN tblGL AS G ON D.nogl = G.GL where G.catid = 7 AND D.budgetID =" & Session("BudgetID")
        dtTable = LectureBD(strReq)
        Return dtTable
    End Function

    Private Sub Affiche(ByVal dtTable As DataTable)
        Dim gridrow As DataGridItem
        Dim iCompteur As Integer = 0
        Dim footer As DataGridItem
        Dim dblcapital As Double = 0
        Dim dbldepreciation As Double = 0

        Me.DataGrid1.DataBind()

        footer = DataGrid1.Controls(0).Controls(DataGrid1.Controls(0).Controls.Count - 1)

        For Each gridrow In DataGrid1.Items
            'inc = gridrow.FindControl("TextBox1")
            gridrow.Cells(0).Text = dtTable.Rows(iCompteur).Item(0)
            If iCompteur = 5 Then
                gridrow.Cells(1).Text = "n/a"
                gridrow.Cells(2).Text = "n/a"
                gridrow.Cells(3).Text = Format(dtTable.Rows(iCompteur).Item(2), "$#,##0;-$#,##0;")
                dbldepreciation += dtTable.Rows(iCompteur).Item(2)
            Else

                gridrow.Cells(2).Text = Format(dtTable.Rows(iCompteur).Item(2), "$#,##0;-$#,##0;")
                If iCompteur <> 4 Then
                    gridrow.Cells(1).Text = dtTable.Rows(iCompteur).Item(1)
                    gridrow.Cells(3).Text = Format((dtTable.Rows(iCompteur).Item(1) * dtTable.Rows(iCompteur).Item(2) * 0.01) * 0.5, "$#,##0;-$#,##0;")
                    dbldepreciation += (dtTable.Rows(iCompteur).Item(1) * dtTable.Rows(iCompteur).Item(2) * 0.01) * 0.5
                Else
                    dbldepreciation += (dtTable.Rows(iCompteur).Item(2) / dtTable.Rows(iCompteur).Item(1)) * 0.5
                    gridrow.Cells(1).Text = dtTable.Rows(iCompteur).Item(1) & " years"
                    gridrow.Cells(3).Text = Format((dtTable.Rows(iCompteur).Item(2) / dtTable.Rows(iCompteur).Item(1)) * 0.5, "$#,##0;-$#,##0;")

                End If
                dblcapital += dtTable.Rows(iCompteur).Item(2)

            End If

            iCompteur += 1
        Next
        footer.Cells(2).Text = Format(dblcapital, "$#,##0;-$#,##0;")
        footer.Cells(3).Text = Format(dbldepreciation, "$#,##0;-$#,##0;")

    End Sub

    Public Sub cmdRefresh_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdRefresh.Click
        Dim dtTable As New DataTable
        Dim strREQ As String
        Dim footer As DataGridItem

        dtTable = getData()
        DataGrid1.DataSource = dtTable
        Affiche(dtTable)
        footer = DataGrid1.Controls(0).Controls(DataGrid1.Controls(0).Controls.Count - 1)

        dtTable = New DataTable
        strREQ = "SELECT detailID from tblbudgetDetails where budgetid =" & Session("BudgetID") & " and nogl = '10.1010410.'"
        dtTable = LectureBD(strREQ)

        'Ajoute le montant total au GL de depression
        strREQ = "EXEC dbo.prAjoutDepreciation " & dtTable.Rows(0).Item(0) & "," & CDbl(footer.Cells(3).Text.Remove(footer.Cells(3).Text.IndexOf("$"), 1)) & ",'Total Depreciation'"
        EcritureBD(strREQ)

        'Ajoute le montant total au GL de depression
        'strREQ = "INSERT INTO tblComponents VALUES(" & dtTable.Rows(0).Item(0) & "," & CDbl(footer.Cells(3).Text.Remove(footer.Cells(3).Text.IndexOf("$"), 1)) & ",'Total Depreciation',0,0,0)"
        'EcritureBD(strREQ)
    End Sub
End Class
