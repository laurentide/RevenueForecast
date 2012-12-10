'REVENUE FORECAST
'Salairies
'description: Ce formulaire regroupe les employés d'un département et planifie les salaires des employés
'Par: Francis Gauthier
'date: 27 juillet 2007
'contact: f.gauthier@cgodin.qc.ca

Imports System.DirectoryServices

Public Class CapitalExpenditure
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Panel1 As System.Web.UI.WebControls.Panel
    Protected WithEvents Button3 As System.Web.UI.WebControls.Button
    Protected WithEvents Label1 As System.Web.UI.WebControls.Label
    Protected WithEvents Button5 As System.Web.UI.WebControls.Button
    Protected WithEvents TextBox5 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label6 As System.Web.UI.WebControls.Label
    Protected WithEvents Label7 As System.Web.UI.WebControls.Label
    Protected WithEvents DataGrid1 As System.Web.UI.WebControls.DataGrid
    Protected WithEvents Button7 As System.Web.UI.WebControls.Button
    Protected WithEvents TextBox6 As System.Web.UI.WebControls.TextBox
    Protected WithEvents TextBox7 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label10 As System.Web.UI.WebControls.Label
    Protected WithEvents Label11 As System.Web.UI.WebControls.Label
    Protected WithEvents Label12 As System.Web.UI.WebControls.Label
    Protected WithEvents Label13 As System.Web.UI.WebControls.Label
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
        Dim dt As DataTable
        Dim strReq As String
        Dim intcompteur As Integer
        Dim dr As DataRow
        Dim strDepartment As String
        Dim qtyTextBox As TextBox
        Dim qtyTextPoints As TextBox
        Dim pourcentage As TextBox
        Dim basesalary As TextBox
        Dim RRSP As TextBox
        Dim struser As String
        Dim footer As DataGridItem
        Dim dblsalary As Double = 0
        Dim dblRRSP As Double = 0
        Dim dblsalaryREV As Double = 0
        Dim dblRRSPREV As Double = 0


        'Vérifie user
        struser = Request.ServerVariables("LOGON_user").Substring(Request.ServerVariables("LOGON_user").IndexOf("\") + 1, Request.ServerVariables("LOGON_user").Length - (Request.ServerVariables("LOGON_user").IndexOf("\") + 1))
        If EstManager(struser) = False Or accesSalaries(struser) = False Then
            Response.Redirect("Denied.html")
        Else

            'Get data et affichage des salaires
            dt = getData()
            Me.DataGrid1.DataSource = dt
            If Not IsPostBack Then
                DataGrid1.DataBind()
                'Set la ligne de séparation
                LigneSeparateur()

                Me.Label7.Text = CType(Session("Year"), Integer) - 1 & " Salaries"
                Me.Label6.Text = Session("Year") & " " & Me.Label6.Text

                Dim gridrow As DataGridItem
                intcompteur = 0

                For Each gridrow In DataGrid1.Items

                    gridrow.Cells(0).Text = intcompteur + 1
                    gridrow.Cells(1).Text = dt.Rows(intcompteur).Item(0)
                    gridrow.Cells(2).Text = Format(dt.Rows(intcompteur).Item(1), "$#,##0;-$#,##0;")
                    gridrow.Cells(3).Text = Format(dt.Rows(intcompteur).Item(2), "$#,##0;-$#,##0;")
                    gridrow.Cells(4).Text = Format(dt.Rows(intcompteur).Item(3), "#,##0;-#,##0;")

                    dblsalary += dt.Rows(intcompteur).Item(1)
                    dblRRSP += dt.Rows(intcompteur).Item(2)

                    pourcentage = gridrow.FindControl("TextBox1")
                    pourcentage.Text = dt.Rows(intcompteur).Item(4)

                    basesalary = gridrow.FindControl("TextBox4")
                    RRSP = gridrow.FindControl("TextBox3")

                    basesalary.Text = Format(dt.Rows(intcompteur).Item(5), "#,##0;-#,##0;")
                    dblsalaryREV += dt.Rows(intcompteur).Item(5)
                    qtyTextPoints = gridrow.FindControl("TextBox8")
                    If Session("Open mode") = "add" Then
                        qtyTextPoints.Text = dt.Rows(intcompteur).Item(3)
                    Else
                        qtyTextPoints.Text = dt.Rows(intcompteur).Item(7)
                    End If


                    RRSP.Text = Format(dt.Rows(intcompteur).Item(6), "#,##0;-#,##0;")
                    dblRRSPREV += dt.Rows(intcompteur).Item(6)
                    intcompteur += 1
                Next

                footer = DataGrid1.Controls(0).Controls(DataGrid1.Controls(0).Controls.Count - 1)

                footer.Cells(0).Text = "Total: "
                footer.Cells(1).HorizontalAlign = HorizontalAlign.Center
                footer.Cells(1).Text = Me.DataGrid1.Items.Count & " employees."
                footer.Cells(2).Text = Format(dblsalary, "$#,##0;-$#,##0;")
                footer.Cells(3).Text = Format(dblRRSP, "$#,##0;-$#,##0;")
                footer.Cells(4).Text = Format(dblRRSP + dblsalary, "$#,##0;-$#,##0;")

                footer.Cells(7).Text = Format(dblsalaryREV, "$#,##0;-$#,##0;")

                footer.Cells(8).Text = Format(dblRRSPREV, "$#,##0;-$#,##0;")
                footer.Cells(9).Text = Format(dblRRSPREV + dblsalaryREV, "$#,##0;-$#,##0;")

                Dim tabletaux As New DataTable
                strReq = "Select C.description from tblcomponents AS C Inner join tblbudgetDetails as D On c.detailID=D.detailID Where d.nogl like '09.0900310.' and d.budgetID=" & Session("BudgetID")
                tabletaux = LectureBD(strReq)
                If tabletaux.Rows.Count > 0 Then
                    Me.TextBox7.Text = tabletaux.Rows(0).Item(0)
                End If

                strReq = "Select C.description from tblcomponents AS C Inner join tblbudgetDetails as D On c.detailID=D.detailID Where d.nogl like '09.0900400.' and d.budgetID=" & Session("BudgetID")
                tabletaux = LectureBD(strReq)
                If tabletaux.Rows.Count > 0 Then
                    Me.TextBox6.Text = tabletaux.Rows(0).Item(0)
                End If

                'Affiche la possibilité de changer le taux de Payroll ou de groupe seulement si c'est Dean, Christian ou mon moi
                If struser = "DeanW" Or struser = "d2dadmin" Or struser = "ClaireD" Then
                    Me.Label10.Visible = True
                    Me.Label11.Visible = True
                    Me.Label12.Visible = True
                    Me.Label13.Visible = True
                    Me.TextBox6.Visible = True
                    Me.TextBox7.Visible = True
                End If

            End If

        End If
    End Sub
  
    Private Sub Save(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button3.Click
        Dim strReq As String

        Dim gridrow As DataGridItem
        Dim strNom As String
        Dim footer As DataGridItem

        Dim txtboxpoints As TextBox
        Dim pourcentage As TextBox
        Dim basesalary As TextBox
        Dim RRSP As TextBox
        Dim strString As String
        Dim dblRRSP As Double = 0
        Dim dblBaseSalary As Double = 0

        footer = DataGrid1.Controls(0).Controls(DataGrid1.Controls(0).Controls.Count - 1)
        strString = footer.Cells(2).Text
        For Each gridrow In DataGrid1.Items

            txtboxpoints = gridrow.FindControl("TextBox8")
            pourcentage = gridrow.FindControl("TextBox1")
            basesalary = gridrow.FindControl("TextBox4")
            RRSP = gridrow.FindControl("TextBox3")

            strReq = "EXEC dbo.prAjoutSalaire " & CType(Session("BudgetID"), String) & ",'" & setGuillemets(gridrow.Cells(1).Text) & "'," & CDbl(Isnull(basesalary.Text)) & "," & CDbl(Isnull(txtboxpoints.Text)) & "," & CDbl(Isnull(pourcentage.Text)) & "," & CDbl(Isnull(RRSP.Text))
            EcritureBD(strReq)

            If CDbl(Isnull(RRSP.Text)) > 3500 Then
                RRSP.Text = 3500
            End If
            dblRRSP += CDbl(Isnull(RRSP.Text))
            dblBaseSalary += CDbl(Isnull(basesalary.Text))
        Next

        'Save
        strReq = "EXEC dbo.prAjoutDepenseSalaire " & Session("DetailID") & "," & (dblRRSP + dblBaseSalary) & ",'Total employee salaries'"
        EcritureBD(strReq)

        Me.TextBox6.Text = Isnull(Me.TextBox6.Text)
        Me.TextBox7.Text = Isnull(Me.TextBox7.Text)

        If CDbl(Me.TextBox7.Text) > 100 Then
            Me.TextBox7.Text = "100"
        End If

        If CDbl(Me.TextBox6.Text) > 100 Then
            Me.TextBox6.Text = "100"
        End If

        'Affiche total
        strReq = "EXEC dbo.prTauxSalaire " & Session("BudgetID") & ",'" & CDbl(Me.TextBox7.Text) & "'," & (CDbl(Me.TextBox7.Text) * 0.01 * (dblRRSP + dblBaseSalary)) & ",'" & CDbl(Me.TextBox6.Text) & "'," & (CDbl(Me.TextBox6.Text) * 0.01 * (dblRRSP + dblBaseSalary))
        EcritureBD(strReq)
        footer.Cells(7).Text = Format(dblBaseSalary, "$#,##0;-$#,##0;")
        footer.Cells(8).Text = Format(dblRRSP, "$#,##0;-$#,##0;")
        footer.Cells(9).Text = Format(dblRRSP + dblBaseSalary, "$#,##0;-$#,##0;")
        footer.Cells(2).Text = strString
        Session("Open mode") = "edit"

    End Sub
    Private Sub LigneSeparateur()
        'Ca fais la différence entre l'année du budget et l'année prochaine
        Me.DataGrid1.Columns(5).ItemStyle.BackColor = Color.Gray
        Me.DataGrid1.Columns(5).HeaderStyle.BackColor = Color.Gray
        Me.DataGrid1.Columns(5).FooterStyle.BackColor = Color.Gray
        Me.DataGrid1.Columns(5).ItemStyle.BorderStyle = BorderStyle.None
        Me.DataGrid1.Columns(5).FooterStyle.BorderStyle = BorderStyle.None
        Me.DataGrid1.Columns(5).HeaderStyle.BorderStyle = BorderStyle.None
    End Sub

    Private Sub DataGrid1_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles DataGrid1.ItemCommand
        Dim footer As DataGridItem
        Dim gridrow As DataGridItem
        Dim SelCheckBox As CheckBox
        Dim pourcentage As TextBox
        Dim header As TextBox
        Dim dblsalary As Double = 0
        Dim dblRRSP As Double = 0
        Dim dblsalaryREV As Double = 0
        Dim dblRRSPREV As Double = 0
        Dim basesalary As TextBox
        Dim RRSP As TextBox
        Dim qtyTextBox As TextBox

        'Affecte le pourcentage d'augmentation désiré à un certain emploie et calcule le nouveau salaire

        If e.CommandName = "Inc" Then
            For Each gridrow In DataGrid1.Items
                SelCheckBox = gridrow.FindControl("CheckBox1")
                pourcentage = gridrow.FindControl("TextBox1")
                header = DataGrid1.Controls(0).Controls(0).FindControl("Textbox2")
                qtyTextBox = gridrow.FindControl("TextBox8")
                basesalary = gridrow.FindControl("TextBox4")

                RRSP = gridrow.FindControl("TextBox3")

                If (SelCheckBox.Checked = True) Then
                    If header.Text = "" Then
                        header.Text = "0"
                    End If
                    pourcentage.Text = CDbl(header.Text)

                    If pourcentage.Text = "" Then
                        pourcentage.Text = "0"
                    End If

                    basesalary.Text = Format(CDbl(gridrow.Cells(2).Text.Remove(gridrow.Cells(2).Text.IndexOf("$"), 1)) * (((CDbl(pourcentage.Text) * 0.01)) + 1), "#,##0;-#,##0;")

                    If (((CDbl(gridrow.Cells(3).Text.Remove(gridrow.Cells(3).Text.IndexOf("$"), 1)) * (CDbl(pourcentage.Text) / 100)) + CDbl(gridrow.Cells(3).Text.Remove(gridrow.Cells(3).Text.IndexOf("$"), 1))) > 3500) Then
                        RRSP.Text = Format(3500, "#,##0;-#,##0;")

                    Else
                        RRSP.Text = Format(((CDbl(gridrow.Cells(3).Text.Remove(gridrow.Cells(3).Text.IndexOf("$"), 1)) * (CDbl(Isnull(pourcentage.Text)) / 100)) + CDbl(gridrow.Cells(3).Text.Remove(gridrow.Cells(3).Text.IndexOf("$"), 1))), "#,##0;-#,##0;")
                    End If

                    qtyTextBox.Text = gridrow.Cells(4).Text

                    SelCheckBox.Checked = False
                End If

                dblsalary += CDbl(gridrow.Cells(2).Text.Remove(gridrow.Cells(2).Text.IndexOf("$"), 1))
                dblsalaryREV += CDbl(basesalary.Text)
                dblRRSP += CDbl(gridrow.Cells(3).Text.Remove(gridrow.Cells(3).Text.IndexOf("$"), 1))
                dblRRSPREV += CDbl(RRSP.Text)
            Next
        End If

        'Affiche le total
        footer = DataGrid1.Controls(0).Controls(DataGrid1.Controls(0).Controls.Count - 1)

        footer.Cells(0).Text = "Total: "
        footer.Cells(1).HorizontalAlign = HorizontalAlign.Center
        footer.Cells(1).Text = Me.DataGrid1.Items.Count & " employees."
        footer.Cells(2).Text = Format(dblsalary, "$#,##0;-$#,##0;")
        footer.Cells(3).Text = Format(dblRRSP, "$#,##0;-$#,##0;")
        footer.Cells(4).Text = Format(dblRRSP + dblsalary, "$#,##0;-$#,##0;")

        footer.Cells(7).Text = Format(dblsalaryREV, "$#,##0;-$#,##0;")

        footer.Cells(8).Text = Format(dblRRSPREV, "$#,##0;-$#,##0;")
        footer.Cells(9).Text = Format(dblRRSPREV + dblsalaryREV, "$#,##0;-$#,##0;")
    End Sub

    Private Sub Button7_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button7.Click
        Response.Redirect("Forecast.aspx")
    End Sub
    Private Function getData() As DataTable
        Dim strReq As String
        Dim dtTable As New DataTable

        strReq = "EXEC dbo.prAfficherSalaire " & Session("BudgetID") & ",'" & Session("department") & "'"
        dtTable = LectureBD(strReq)
        Return dtTable
    End Function
End Class


