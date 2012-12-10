'REVENUE FORECAST
'Adjustments
'description: Ce formulaire permet au manager d'ajuster le plan du budget de l'année courante
'Par: Francis Gauthier
'date: 14 aout 2007
'contact: f.gauthier@cgodin.qc.ca

Imports System.Data.SqlClient
Public Class Adjustments
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents DataGrid1 As System.Web.UI.WebControls.DataGrid
    Protected WithEvents Label1 As System.Web.UI.WebControls.Label
    Protected WithEvents Button1 As System.Web.UI.WebControls.Button
    Protected WithEvents DropDownList1 As System.Web.UI.WebControls.DropDownList
    Protected WithEvents Label3 As System.Web.UI.WebControls.Label
    Protected WithEvents Button2 As System.Web.UI.WebControls.Button
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
        Dim strReq As String
        Dim dtTable As New DataTable
        Dim struser As String

        struser = Request.ServerVariables("LOGON_user").Substring(Request.ServerVariables("LOGON_user").IndexOf("\") + 1, Request.ServerVariables("LOGON_user").Length - (Request.ServerVariables("LOGON_user").IndexOf("\") + 1))

        If EstManager(struser) = False Then
            Response.Redirect("Denied.html")
        Else
            'Affiche la liste des départements du manager selon le budget du plan de l'an passé

            strReq = "Select B.budgetID,D.description from tblbudget AS B Inner Join tbldepartement AS D ON B.departmentID=D.departmentID Inner JOin tblmanager AS M ON B.departmentID = M.departmentID INNER JOIN tblemployee AS E ON M.employeeid = E.employeeID Where E.username = '" & struser & "' and year = " & GetFY(Month(Now())) & " ORDER BY description"

            dtTable = LectureBD(strReq)

            If Not IsPostBack Then
                If dtTable.Rows.Count > 0 Then
                    Me.DropDownList1.Items.Add(New ListItem("Choose department..."))
                Else
                    Me.DropDownList1.Items.Add(New ListItem("No " & GetFY(Month(Now())) & " budget available..."))
                End If
                For i As Int16 = 0 To dtTable.Rows.Count - 1
                    Me.DropDownList1.Items.Add(New ListItem(dtTable.Rows(i).Item(1), dtTable.Rows(i).Item(0)))
                Next
                Me.DropDownList1.SelectedIndex = 0
                Me.Button2.Enabled = False
            End If

            End If
    End Sub

    Private Sub back(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Response.Redirect("Manager.aspx")
    End Sub

    Private Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList1.SelectedIndexChanged
        Me.DropDownList1.Items.Remove("Choose department...")
        getForecast(Me.DropDownList1.SelectedItem.Text, Me.DropDownList1.SelectedItem.Value)
        Me.Button2.Enabled = True
    End Sub

    Private Sub getForecast(ByVal department As String, ByVal budgetID As Integer)
        Dim dtTable As New DataTable
        Dim dtTable2 As New DataTable
        Dim intcompteur As Integer = 0
        Dim gridrow As DataGridItem
        Dim txbox As TextBox
        Dim dbltotalPlan As Double = 0
        Dim dbltotalForecast As Double = 0
        Dim dbltotalFY As Double = 0

        Dim dblExpensePlan As Double = 0
        Dim dblExpenseForecast As Double = 0
        Dim dblExpenseFY As Double = 0
        Dim footer As DataGridItem
        Dim lbl As Label


        'Cache les colonnes non nécessaire
        Me.DataGrid1.Columns(3).Visible = False


        'get les datas
        dtTable = getData(department)
        Me.DataGrid1.DataSource = dtTable
        Me.DataGrid1.DataBind()


        footer = DataGrid1.Controls(0).Controls(DataGrid1.Controls(0).Controls.Count - 1)
        For Each gridrow In DataGrid1.Items
            'Si c'est un sous-titre , affiche seulement le nom
            If dtTable.Rows(intcompteur).Item(3) = 0 Then
                'Les sous-totaux ont tous le meme font
                gridrow.Cells(0).Text = dtTable.Rows(intcompteur).Item(0)
                gridrow.Cells(4).Text = ""
                gridrow.BackColor = Color.Gainsboro
                gridrow.Font.Bold = True

                'Ici on affiche les sous totaux GM et Total expenses
                If dtTable.Rows(intcompteur).Item(0) = "GM" Then
                    lbl = gridrow.Cells(1).FindControl("Label4")
                    lbl.Style("text-align") = "right"
                    lbl.Text = Format(dbltotalFY, "$#,##0;-$#,##0;")

                    lbl = gridrow.Cells(2).FindControl("Label8")
                    lbl.Style("text-align") = "right"
                    lbl.Text = Format(dbltotalPlan, "$#,##0;-$#,##0;")

                    lbl = gridrow.Cells(5).FindControl("Label10")
                    lbl.Style("text-align") = "right"
                    lbl.Text = Format(dbltotalForecast, "$#,##0;-$#,##0;")
                ElseIf dtTable.Rows(intcompteur).Item(0) = "Total expense" Then

                    lbl = gridrow.Cells(1).FindControl("Label4")
                    lbl.Style("text-align") = "right"
                    lbl.Text = Format(dblExpenseFY, "$#,##0;-$#,##0;")

                    lbl = gridrow.Cells(2).FindControl("Label8")
                    lbl.Style("text-align") = "right"
                    lbl.Text = Format(dblExpensePlan, "$#,##0;-$#,##0;")

                    lbl = gridrow.Cells(5).FindControl("Label10")
                    lbl.Style("text-align") = "right"
                    lbl.Text = Format(dblExpenseForecast, "$#,##0;-$#,##0;")

                End If

            Else
                lbl = gridrow.Cells(1).FindControl("Label4")
                lbl.Style("text-align") = "right"
                'Sinon Affichage des données et calculs le forecast
                txbox = gridrow.Cells(4).FindControl("TextBox1")
                gridrow.Cells(0).Text = dtTable.Rows(intcompteur).Item(0)
                dtTable2 = New DataTable
                dtTable2 = LectureBD("Select Adjustment from tblAdjustments Where budgetID = " & budgetID & " and description like '" & gridrow.Cells(0).Text & "'")

                'Si il trouve un ajustement, il l'affiche
                If dtTable2.Rows.Count > 0 Then
                    txbox.Text = Format(CType(dtTable2.Rows(0).Item(0), Double), "#,##0;-#,##0;")
                End If

                lbl.Text = Format(CType(dtTable.Rows(intcompteur).Item(2), Double), "$#,##0;-$#,##0;")

                lbl = gridrow.Cells(2).FindControl("Label8")
                lbl.Style("text-align") = "right"

                lbl.Text = Format(CType(dtTable.Rows(intcompteur).Item(1), Double), "$#,##0;-$#,##0;")
                gridrow.Cells(3).Text = dtTable.Rows(intcompteur).Item(3)

                lbl = gridrow.Cells(5).FindControl("Label10")
                lbl.Style("text-align") = "right"
                lbl.Text = Format(((dtTable.Rows(intcompteur).Item(2) / 8) * 12) + CDbl(Isnull(txbox.Text)), "$#,##0;-$#,##0;")

                'On ajoute les montant pour les sommes
                If Val(gridrow.Cells(3).Text) = 1 Then
                    'Contribution et GM
                    dbltotalPlan += CType(dtTable.Rows(intcompteur).Item(1), Double)
                    dbltotalForecast += ((CType(dtTable.Rows(intcompteur).Item(2), Double) / 8) * 12) + CDbl(Isnull(txbox.Text))
                    dbltotalFY += CType(dtTable.Rows(intcompteur).Item(2), Double)
                Else
                    'Contribution et GM
                    dbltotalPlan -= CType(dtTable.Rows(intcompteur).Item(1), Double)
                    dbltotalForecast -= ((CType(dtTable.Rows(intcompteur).Item(2), Double) / 8) * 12) + CDbl(Isnull(txbox.Text))
                    dbltotalFY -= CType(dtTable.Rows(intcompteur).Item(2), Double)

                    'Total expense
                    If Val(gridrow.Cells(3).Text) >= 3 Then
                        dblExpensePlan += CType(dtTable.Rows(intcompteur).Item(1), Double)
                        dblExpenseForecast += ((CType(dtTable.Rows(intcompteur).Item(2), Double) / 8) * 12) + CDbl(Isnull(txbox.Text))
                        dblExpenseFY += CType(dtTable.Rows(intcompteur).Item(2), Double)
                    End If

                End If
            End If
            intcompteur += 1
        Next

        'Affichage somme
        footer.Font.Bold = True
        footer.Cells(0).Text = "Contribution"

        lbl = footer.Cells(1).FindControl("Label5")
        lbl.Style("text-align") = "right"
        lbl.Text = Format(dbltotalFY, "$#,##0;-$#,##0;")

        lbl = footer.Cells(2).FindControl("Label9")
        lbl.Style("text-align") = "right"
        lbl.Text = Format(dbltotalPlan, "$#,##0;-$#,##0;")

        lbl = footer.Cells(5).FindControl("Label11")
        lbl.Style("text-align") = "right"
        lbl.Text = Format(dbltotalForecast, "$#,##0;-$#,##0;")
    End Sub

    Private Function getData(ByVal departement As String) As DataTable
        Dim dtTable As New DataSet
        Dim dtTabble2 As New DataTable
        Dim cmdTable As SqlCommand
        Dim sqlAdapter As SqlDataAdapter
        Dim strConn As String = "Server=localhost;uid=LCLADMIN;password=test;database=LCLAdmin"
        Dim dbConn As New SqlConnection(strConn)
        Dim strReq As String
        Dim Table As DataTable
        Dim row As DataRow
        Dim row2 As DataRow
        Dim icompteur As Integer

        'Super curseur SQL !
        strReq = "EXEC dbo.prAdjustments '" & departement & "'"
        'Création des colonnes de la table
        dtTabble2.Columns.Add()
        dtTabble2.Columns.Add()
        dtTabble2.Columns.Add()
        dtTabble2.Columns.Add()

        cmdTable = New SqlCommand(strReq, dbConn)
        'Le "timed out" est désactiver
        cmdTable.CommandTimeout = "0"
        sqlAdapter = New SqlDataAdapter(cmdTable)
        sqlAdapter.Fill(dtTable)

        'Remplit la table
        For Each Table In dtTable.Tables
            icompteur = 0
            For Each row In Table.Rows
                row2 = dtTabble2.NewRow()
                row2(0) = row.Item(0)
                row2(1) = row.Item(1)
                row2(2) = row.Item(2)
                row2(3) = row.Item(3)

                dtTabble2.Rows.Add(row2)
            Next
        Next
        Return dtTabble2
    End Function

    Private Sub Save(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        Dim gridrow As DataGridItem
        Dim txbox As TextBox
        Dim dbltotalForecast As Double = 0
        Dim footer As DataGridItem
        Dim lblFY As Label
        Dim lblForecast As Label
        Dim dblExpenseForecast As Double = 0

        Me.DataGrid1.Columns(3).Visible = False

        footer = DataGrid1.Controls(0).Controls(DataGrid1.Controls(0).Controls.Count - 1)
        For Each gridrow In DataGrid1.Items
            'Si ce n'est pas un sous-titre, calcule et sauvegarde le montant
            If Val(gridrow.Cells(3).Text) <> 0 Then
                lblFY = gridrow.Cells(1).FindControl("Label4")
                lblForecast = gridrow.Cells(5).FindControl("Label10")
                txbox = gridrow.Cells(4).FindControl("TextBox1")

                lblForecast.Text = Format(((CDbl(lblFY.Text.Remove(lblFY.Text.IndexOf("$"), 1)) / 8) * 12) + CDbl(Isnull(txbox.Text)), "$#,##0;-$#,##0;")

                'On ajoute les montant pour les sommes
                If Val(gridrow.Cells(3).Text) = 1 Then
                    'Contribution et GM
                    dbltotalForecast += ((CDbl(lblFY.Text.Remove(lblFY.Text.IndexOf("$"), 1)) / 8) * 12) + CDbl(Isnull(txbox.Text))

                Else
                    'Contribution et GM
                    dbltotalForecast -= ((CDbl(lblFY.Text.Remove(lblFY.Text.IndexOf("$"), 1)) / 8) * 12) + CDbl(Isnull(txbox.Text))
                    'Total expense
                    If Val(gridrow.Cells(3).Text) >= 3 Then
                        dblExpenseForecast += ((CDbl(lblFY.Text.Remove(lblFY.Text.IndexOf("$"), 1)) / 8) * 12) + CDbl(Isnull(txbox.Text))
                    End If
                End If
                'Save le montant
                EcritureBD("EXEC dbo.prSaveAdjustments " & Me.DropDownList1.SelectedItem.Value & ",'" & gridrow.Cells(0).Text & "'," & CDbl(Isnull(txbox.Text)))
            Else
                gridrow.Cells(4).Text = ""

                'Affichage somme GM et Contribution
                If gridrow.Cells(0).Text = "GM" Then
                    lblForecast = gridrow.Cells(5).FindControl("Label10")
                    lblForecast.Style("text-align") = "right"
                    lblForecast.Text = Format(dbltotalForecast, "$#,##0;-$#,##0;")
                ElseIf gridrow.Cells(0).Text = "Total expense" Then

                    lblForecast = gridrow.Cells(5).FindControl("Label10")
                    lblForecast.Style("text-align") = "right"
                    lblForecast.Text = Format(dblExpenseForecast, "$#,##0;-$#,##0;")
                End If
            End If
        Next

        'Affichage Résultat nouveau calcul
        lblForecast = footer.Cells(5).FindControl("Label11")
        lblForecast.Style("text-align") = "right"
        lblForecast.Text = Format(dbltotalForecast, "$#,##0;-$#,##0;")

    End Sub
End Class
