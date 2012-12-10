'REVENUE FORECAST
'FYdetails
'description: Ce formulaire "POP UP" affiche les données réels de l'année précédente à partir de la bse de données NOMIS
'Par: Francis Gauthier
'date: 27 juillet 2007
'contact: f.gauthier@cgodin.qc.ca

Public Class FYdetails
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents DataGrid1 As System.Web.UI.WebControls.DataGrid

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
        Dim strReq As String
        Dim icompteur As Integer = 0
        Dim dblSomme As Double = 0
        Dim footer As DataGridItem

        'Affichage titre et get data
        Response.Write("<title>" + CType(Session("Expense"), String) + "</title>")
        strReq = "prGetDetails " & Session("BudgetID") & "," & Session("DetailID")
        dtTable = LectureBD(strReq)
        DataGrid1.DataSource = dtTable

        If Not IsPostBack Then
            DataGrid1.DataBind()
            'Affichage données
            Dim gridrow As DataGridItem
            For Each gridrow In DataGrid1.Items
                gridrow.Cells(0).Text = dtTable.Rows(icompteur).Item(0)
                gridrow.Cells(1).Text = Format(dtTable.Rows(icompteur).Item(1), "$#,##0;-$#,##0;")
                gridrow.Cells(1).Style("text-align") = "right"
                dblSomme += dtTable.Rows(icompteur).Item(1)
                icompteur += 1
            Next

            'Affichage somme
            footer = DataGrid1.Controls(0).Controls(DataGrid1.Controls(0).Controls.Count - 1)
            footer.Cells(0).Text = "Total: " & icompteur & " Expenses"
            footer.Cells(1).Text = Format(dblSomme, "$#,##0;-$#,##0;")
            footer.Font.Bold = True
        End If

    End Sub

    Private Sub DataGrid1_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles DataGrid1.ItemCommand
        'Print
        If e.CommandName = "Print" Then
            Response.Write("<script>window.print();</script>")
        End If
    End Sub
End Class
