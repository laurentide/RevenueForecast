'REVENUE FORECAST
'CellularExpense
'description: Ce formulaire regroupe les dépenses de cellulaire/car expense des employés
'Par: Francis Gauthier
'date: 27 juillet 2007
'contact: f.gauthier@cgodin.qc.ca

Public Class CellularExpense
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Button1 As System.Web.UI.WebControls.Button
    Protected WithEvents Datagrid1 As System.Web.UI.WebControls.DataGrid
    Protected WithEvents Label5 As System.Web.UI.WebControls.Label
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
        Dim struser As String
        Dim strReq As String
        Dim dtTable As New DataTable
        Dim iCompteur As Integer = 0
        Dim txtbox As TextBox
        Dim lbltxt As Label
        Dim dblsomme As Double = 0


        struser = Request.ServerVariables("LOGON_user").Substring(Request.ServerVariables("LOGON_user").IndexOf("\") + 1, Request.ServerVariables("LOGON_user").Length - (Request.ServerVariables("LOGON_user").IndexOf("\") + 1))
        If EstManager(struser) = False Then
            Response.Redirect("Denied.html")
        Else
            'Get data
            If Session("Expense") = "cell" Then
                Me.Label5.Text = "Cellular expenses"
                strReq = "SELECT E.name, ISNULL((SELECT S.Cellularamount FROM tblSalaries AS S Where S.EmployeeID = E.EmployeeID And S.BudgetID = " & Session("BudgetID") & "),0) 'Base salary' FROM tblEmployee AS E INNER JOIN tbldepartement AS D ON E.departmentID=D.departmentID WHERE D.description ='" & Session("department") & "' ORDER BY name"
            ElseIf Session("Expense") = "car" Then
                Me.Label5.Text = "Car expenses"
                strReq = "SELECT E.name, ISNULL((SELECT S.CarExpense FROM tblSalaries AS S Where S.EmployeeID = E.EmployeeID And S.BudgetID = " & Session("BudgetID") & "),0) 'Base salary' FROM tblEmployee AS E INNER JOIN tbldepartement AS D ON E.departmentID=D.departmentID WHERE D.description ='" & Session("department") & "' ORDER BY name"
            End If
            Me.Label5.Style("text-align") = "center"

            dtTable = LectureBD(strReq)

            'Affichage data
            Me.Datagrid1.DataSource = dtTable
            If Not IsPostBack Then
                Datagrid1.DataBind()
                Dim header As TextBox
                header = Datagrid1.Controls(0).Controls(0).FindControl("Textbox1")
                header.Style("text-align") = "right"
                Dim gridrow As DataGridItem
                For Each gridrow In Datagrid1.Items
                    txtbox = gridrow.Cells(1).FindControl("TextBox2")
                    gridrow.Cells(0).Text = dtTable.Rows(iCompteur).Item(0)
                    txtbox.Text = Format(dtTable.Rows(iCompteur).Item(1), "#,##0;-#,##0;")
                    dblsomme += CDbl(txtbox.Text)
                    txtbox.Style("text-align") = "right"
                    iCompteur += 1
                Next

                'Affichage somme
                Dim footer As DataGridItem
                footer = Datagrid1.Controls(0).Controls(Datagrid1.Controls(0).Controls.Count - 1)
                lbltxt = footer.FindControl("Label4")
                lbltxt.Text = Format(dblsomme, "$#,##0;-$#,##0;")
                lbltxt.Style("text-align") = "right"
            End If
        End If
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Response.Redirect("Forecast.aspx")
    End Sub

    Private Sub Datagrid1_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles Datagrid1.ItemCommand
        Dim footer As DataGridItem
        Dim gridrow As DataGridItem
        Dim SelCheckBox As CheckBox
        Dim amount As TextBox
        Dim header As TextBox
        Dim lbltxt As Label
        Dim dblsomme As Double = 0
        Dim strReq As String

        footer = Datagrid1.Controls(0).Controls(Datagrid1.Controls(0).Controls.Count - 1)
        lbltxt = footer.FindControl("Label4")
        If e.CommandName = "Amount" Then
            'Pour tous les employés sélectionner on ajoute leur montant
            For Each gridrow In Datagrid1.Items
                SelCheckBox = gridrow.FindControl("CheckBox1")
                amount = gridrow.FindControl("TextBox2")
                header = Datagrid1.Controls(0).Controls(0).FindControl("Textbox1")


                If (SelCheckBox.Checked = True) Then
                    amount.Text = CDbl(Isnull(header.Text))
                    SelCheckBox.Checked = False
                End If
                dblsomme += CDbl(Isnull(amount.Text))
            Next


        ElseIf e.CommandName = "Save" Then
            'Pour chaque employé on sauvegarde leur montant
            For Each gridrow In Datagrid1.Items
                amount = gridrow.FindControl("TextBox2")
                strReq = "EXEC dbo.prCellularCarExpense " & CType(Session("BudgetID"), String) & ",'" & setGuillemets(gridrow.Cells(0).Text) & "'," & CDbl(Isnull(amount.Text)) & ",'" & Session("Expense") & "','" & Session("department") & "'"
                EcritureBD(strReq)
                dblsomme += CDbl(Isnull(amount.Text))
            Next


            strReq = "EXEC dbo.prAjoutDepenseSalaire " & Session("DetailID") & "," & dblsomme & ",'Total " & Me.Label5.Text & " amount'"

         EcritureBD(strReq)


        ElseIf e.CommandName = "Clear" Then
        dblsomme = 0
        For Each gridrow In Datagrid1.Items
            SelCheckBox = gridrow.FindControl("CheckBox1")
            amount = gridrow.FindControl("TextBox2")
                amount.Text = "0"
            SelCheckBox.Checked = False
        Next
        End If

        lbltxt.Text = Format(dblsomme, "$#,##0;-$#,##0;")
        lbltxt.Style("text-align") = "right"

    End Sub
End Class
