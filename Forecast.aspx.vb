'REVENUE FORECAST
'ForeCast
'description: Ce formulaire est le formulaire principale d'un budget
'Par: Francis Gauthier
'date: 27 juillet 2007
'contact: f.gauthier@cgodin.qc.ca

Imports System.Data.SqlClient

Public Class Forecast
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents DataGrid1 As System.Web.UI.WebControls.DataGrid
    Protected WithEvents Label1 As System.Web.UI.WebControls.Label
    Protected WithEvents Label2 As System.Web.UI.WebControls.Label
    Protected WithEvents Label3 As System.Web.UI.WebControls.Label
    Protected WithEvents Label4 As System.Web.UI.WebControls.Label
    Protected WithEvents Label6 As System.Web.UI.WebControls.Label
    Protected WithEvents Button2 As System.Web.UI.WebControls.Button
    Protected WithEvents PageX As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents PageY As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents xvalue As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents yvalue As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents Button4 As System.Web.UI.WebControls.Button
    Protected WithEvents ImageButton1 As System.Web.UI.WebControls.ImageButton
    Protected WithEvents Button3 As System.Web.UI.WebControls.Button
    Protected WithEvents Button7 As System.Web.UI.WebControls.Button
    Protected WithEvents Button8 As System.Web.UI.WebControls.Button
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
        Dim footer As DataGridItem
        Dim dblAmount As Double = 0
        Dim dtTable2 As New DataTable
        Dim dblGL As Double
        Dim label As Label


        'get username
        struser = Request.ServerVariables("LOGON_user").Substring(Request.ServerVariables("LOGON_user").IndexOf("\") + 1, Request.ServerVariables("LOGON_user").Length - (Request.ServerVariables("LOGON_user").IndexOf("\") + 1))
        If EstManager(struser) = False Then
            Response.Redirect("Denied.html")
        Else

        Me.DataGrid1.Columns(5).Visible = False
        'Affichage Du détenteur du budget ainsi que l'année
        strReq = "Select B.BudgetID, D.description, E.name FROM tblBudget AS B INNER JOIN tblDepartement AS D ON B.departmentID = D.departmentID INNER JOIN tblemployee AS E ON B.creator = E.employeeID Where B.Year = " & Session("Year") & " AND D.description like '" & Session("department") & "'"

        dtTable = LectureBD(strReq)

        Session("BudgetID") = CType(dtTable.Rows(0).Item(0), Integer)
        Me.Label3.Text = CType(dtTable.Rows(0).Item(1), String)
        Me.Label4.Text = CType(dtTable.Rows(0).Item(2), String)
        Me.Label6.Text = "Plan " & Session("Year")

        'Affichage des code GL ainsi que la somme des dépenses


        dtTable.Clear()
        dtTable = New DataTable
        dtTable = getGL()

        'Ici on va chercher les dépenses de "Travael and training
        'Et on ajoute les montants aux codes GL appropriés
            strReq = "SELECT isnull(sum(costofcourse),0), isnull(sum(fares),0), isnull(sum(hotel),0), isnull(sum(meals),0) + isnull(sum(entertainment),0), isnull(sum(carRental),0) from tblTravelBudget Where budgetID = " & Session("BudgetID")

        dtTable2 = LectureBD(strReq)


        Me.DataGrid1.DataSource = dtTable
        If Not IsPostBack Then
            DataGrid1.DataBind()
            Dim gridrow As DataGridItem
                Dim HEADER As DataGridItem


            HEADER = DataGrid1.Controls(0).Controls(0)
            HEADER.Cells(5).Text = "FY - " & Session("Year") - 1
            HEADER.Cells(6).Text = Session("Year") - 1 & " details"
            For Each gridrow In DataGrid1.Items
                dblGL = 0

                'Affichage des montants GL
                label = gridrow.Cells(1).FindControl("Label5")
                    gridrow.Cells(0).Text = dtTable.Rows(iCompteur).Item(0)
                    gridrow.Cells(5).Text = dtTable.Rows(iCompteur).Item(3)
                label.Text = dtTable.Rows(iCompteur).Item(1)

                If gridrow.Cells(0).Text.Trim = "08.0800310." Then

                        dblGL += dtTable2.Rows(0).Item(1)

                    ElseIf UCase(label.Text.Trim) = "MEALS & ENTERTAINMENT" Then

                        dblGL += dtTable2.Rows(0).Item(3)


                    ElseIf gridrow.Cells(0).Text.Trim = "08.0800610." Then


                        dblGL += dtTable2.Rows(0).Item(2)


                    ElseIf UCase(label.Text.Trim) = "TRAINING" Then

                        dblGL += dtTable2.Rows(0).Item(0)


                    ElseIf UCase(label.Text.Trim) = "CAR RENTAL" Then

                        dblGL += dtTable2.Rows(0).Item(4)

                    End If

                    label = gridrow.Cells(3).FindControl("Label7")
                    Dim btn As Button
                    If gridrow.Cells(0).Text.Trim = "09.0900310." Or gridrow.Cells(0).Text.Trim = "09.0900400." Then
                        If Val(gridrow.Cells(5).Text) = 1 Then
                            dblAmount += dtTable.Rows(iCompteur).Item(2) + dblGL
                        Else
                            dblAmount -= dtTable.Rows(iCompteur).Item(2) + dblGL
                        End If

                        label.Text = Format(dtTable.Rows(iCompteur).Item(2) + dblGL, "$#,##0;-$#,##0;")

                        btn = gridrow.Cells(4).FindControl("Button1")
                        btn.Visible = False
                    ElseIf gridrow.Cells(0).Text.EndsWith(".") = True Or gridrow.Cells(0).Text.Trim = "VARIOUS" Then
                        If Val(gridrow.Cells(5).Text) = 1 Then
                            dblAmount += dtTable.Rows(iCompteur).Item(2) + dblGL
                        Else
                            dblAmount -= dtTable.Rows(iCompteur).Item(2) + dblGL
                        End If

                        label.Text = Format(dtTable.Rows(iCompteur).Item(2) + dblGL, "$#,##0;-$#,##0;")
                    Else


                        btn = gridrow.Cells(2).FindControl("Button5")
                        btn.Visible = False
                        btn = gridrow.Cells(4).FindControl("Button1")
                        btn.Visible = False
                        btn = gridrow.Cells(6).FindControl("Button6")
                        btn.Visible = False

                        gridrow.Cells(1).Font.Bold = True
                        gridrow.Cells(1).Font.Underline = True
                        label.Text = ""
                        gridrow.Cells(5).Text = ""
                        gridrow.BackColor = Color.Gainsboro


                    End If
                    label.Style("text-align") = "right"
                    iCompteur += 1
                Next

                'Somme total
                footer = DataGrid1.Controls(0).Controls(DataGrid1.Controls(0).Controls.Count - 1)
                footer.Cells(1).Text = "Year : " & Me.Label6.Text
                label = footer.Cells(3).FindControl("Label8")
                label.Text = Format(dblAmount, "$#,##0;-$#,##0;")
                label.Style("text-align") = "right"
                footer.Font.Bold = True
            End If
        End If
        Me.DataGrid1.Columns(0).Visible = False
    End Sub
    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        Response.Redirect("Menu.aspx")
    End Sub

    Private Sub DataGrid1_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles DataGrid1.ItemCommand
        Dim strReq As String
        Dim dtTable As New DataTable
        Dim iCompteur As Integer = 0
        Dim txtbox As TextBox
        Dim label As Label

        label = e.Item.Cells(1).FindControl("Label5")
        If e.CommandName = "Edit" Then
            Me.DataGrid1.SelectedIndex = e.Item.ItemIndex
            'Lorsque l'utilisateur veut entrer une dépense
            'On va chercher le numéro du détail du budget
            strReq = "Select DetailID FROM tblBudgetDetails Where BudgetID = " + CType(Session("BudgetID"), String) + " AND NoGL Like '" + e.Item.Cells(0).Text + "'"
            dtTable = LectureBD(strReq)

            'S'il n'existe pas, on le crée
            If dtTable.Rows.Count = 0 Then
                InsertDetail(e)
                dtTable = New DataTable
                strReq = "Select IDENT_CURRENT('tblBudgetDetails')"
                dtTable = LectureBD(strReq)

            End If

            'Affichage du formulaire/pop up approprié au GL
            Session("DetailID") = CType(dtTable.Rows(0).Item(0), Integer)
            If UCase(label.Text.Trim) = "SALARIES" Then
                Response.Redirect("Salaries.aspx")

            ElseIf UCase(label.Text.Trim) = "NEW SALARIES" Then
                Response.Redirect("NewSalaries.aspx")

            ElseIf UCase(label.Text.Trim) = "CELLULAR" Then
                Session("Expense") = "cell"
                Response.Redirect("CellularCarExpense.aspx")
            ElseIf UCase(label.Text.Trim) = "AUTOMOBILE EXPENSES" Then
                Session("Expense") = "car"
                Response.Redirect("CellularCarExpense.aspx")

            ElseIf e.Item.Cells(0).Text.Trim = "VARIOUS" Then
                Session("DetailID") = Nothing
                Response.Redirect("CapitalExpenditure.aspx")
            Else

                Session("Expense") = CType(label.Text, String) & " Expenses"

                'Pop Up
                Response.Write("<body><script>window.open(""Components.aspx"",""null"",""width=380,height=250,top=250,left=616,status=no, resizable= no, scrollbars= yes, toolbar= no,location= no,menubar= no"");</script></body>")
            End If

        ElseIf e.CommandName = "Help" Then
            Me.DataGrid1.SelectedIndex = e.Item.ItemIndex
            'Affichage du pop up d'aide au GL
            Session("Expense") = CType(label.Text, String)
            Response.Write("<body><script>window.open(""GlPoPUP.aspx"",""null"",""width=380,height=250,top=250,left=616,status=no, resizable= no, scrollbars= no, toolbar= no,location= no,menubar= no"");</script></body>")

        ElseIf e.CommandName = "Details" Then
            Me.DataGrid1.SelectedIndex = e.Item.ItemIndex
            strReq = "Select DetailID FROM tblBudgetDetails Where BudgetID = " + CType(Session("BudgetID"), String) + " AND NoGL Like '" + e.Item.Cells(0).Text + "'"
            dtTable = LectureBD(strReq)

            'S'il n'existe pas, on le crée
            If dtTable.Rows.Count = 0 Then
                InsertDetail(e)
                dtTable = New DataTable
                strReq = "Select IDENT_CURRENT('tblBudgetDetails')"
                dtTable = LectureBD(strReq)
            End If

            'Affichage du formulaire/pop up approprié au GL
            Session("DetailID") = CType(dtTable.Rows(0).Item(0), Integer)
            Session("Expense") = CType(label.Text, String)
            Response.Write("<body><script>window.open(""FYdetails.aspx"",""null"",""width=380,height=250,top=250,left=616,status=no, resizable= no, scrollbars= yes, toolbar= no,location= no,menubar= no"");</script></body>")
        End If
    End Sub

    Private Sub InsertDetail(ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs)
        Dim strReq As String
        strReq = "INSERT INTO tblBudgetDetails VALUES(" + CType(Session("BudgetID"), String) + ",'" + e.Item.Cells(0).Text + "',0)"
        EcritureBD(strReq)
    End Sub

    Private Sub Button4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button4.Click
        Response.Redirect("TravelAndTraining.aspx")
    End Sub

    Private Sub ImageButton1_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        Dim strReq As String
        Dim dtTable As New DataTable
        Dim gridrow As DataGridItem
        Dim dblAmount As Double = 0
        Dim footer As DataGridItem
        Dim dtTable2 As New DataTable
        Dim dblGL As Double
        Dim Label As Label

        'REFRESH
        If Not Session("DetailID") Is Nothing Then

            strReq = "Select ISNULL(sum(C.Montant),0), D.NoGl, D.detailId FROM tblBudgetDetails AS D FULL JOIN tblComponents AS C ON C.DetailId = D.DetailID Where D.DetailID = " + CType(Session("DetailID"), String) + " GROUP BY D.NoGl,D.detailId"
            dtTable = LectureBD(strReq)

            strReq = "SELECT isnull(sum(costofcourse),0), isnull(sum(fares),0), isnull(sum(hotel),0), isnull(sum(meals),0) + isnull(sum(entertainment),0), isnull(sum(carRental),0) from tblTravelBudget Where budgetID = " & Session("BudgetID")

            dtTable2 = LectureBD(strReq)
            footer = DataGrid1.Controls(0).Controls(DataGrid1.Controls(0).Controls.Count - 1)
            For Each gridrow In DataGrid1.Items
                dblGL = 0

                Label = gridrow.Cells(1).FindControl("Label5")
                If gridrow.Cells(0).Text = dtTable.Rows(0).Item(1) Then

                    If gridrow.Cells(0).Text.Trim = "08.0800310." Then

                        dblGL += dtTable2.Rows(0).Item(1)

                    ElseIf UCase(Label.Text.Trim) = "MEALS & ENTERTAINMENT" Then

                        dblGL += dtTable2.Rows(0).Item(3)


                    ElseIf gridrow.Cells(0).Text.Trim = "08.0800610." Then


                        dblGL += dtTable2.Rows(0).Item(2)


                    ElseIf UCase(Label.Text.Trim) = "TRAINING" Then

                        dblGL += dtTable2.Rows(0).Item(0)


                    ElseIf UCase(Label.Text.Trim) = "CAR RENTAL" Then

                        dblGL += dtTable2.Rows(0).Item(4)

                    End If
                    Label = gridrow.Cells(3).FindControl("Label7")
                    Label.Text = Format(dtTable.Rows(0).Item(0) + dblGL, "$#,##0;-$#,##0;")
                End If

                Label = gridrow.Cells(3).FindControl("Label7")
                If Label.Text <> "" Then
                    If Val(gridrow.Cells(5).Text) = 1 Then
                        dblAmount += CDbl(Label.Text.Remove(Label.Text.IndexOf("$"), 1))
                    Else
                        dblAmount -= CDbl(Label.Text.Remove(Label.Text.IndexOf("$"), 1))
                    End If
                End If
                Label.Style("text-align") = "right"
            Next

            Label = footer.Cells(3).FindControl("Label8")
            Label.Text = Format(dblAmount, "$#,##0;-$#,##0;")
            Label.Style("text-align") = "right"
        End If
    End Sub

    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button3.Click
        Response.Redirect("Summary.aspx")
    End Sub

    Private Function getGL() As DataTable
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
        strReq = "EXEC prCurseur " & Session("BudgetID")

        dtTabble2.Columns.Add()
        dtTabble2.Columns.Add()
        dtTabble2.Columns.Add()
        dtTabble2.Columns.Add()

        cmdTable = New SqlCommand(strReq, dbConn)
        sqlAdapter = New SqlDataAdapter(cmdTable)
        sqlAdapter.Fill(dtTable)

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

    Private Sub Salaries(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button8.Click
        Dim strReq As String
        Dim dtTable As DataTable
        strReq = "Select DetailID FROM tblBudgetDetails Where BudgetID = " + CType(Session("BudgetID"), String) + " AND NoGL Like '08.0800110.'"
        dtTable = LectureBD(strReq)

        'S'il n'existe pas, on le crée ATTENTION FAUT PAS CHANGER SON CODE GL!
        If dtTable.Rows.Count = 0 Then
            strReq = "INSERT INTO tblBudgetDetails VALUES(" + CType(Session("BudgetID"), String) + ",'08.0800110.',0)"
            EcritureBD(strReq)
            dtTable = New DataTable
            strReq = "Select IDENT_CURRENT('tblBudgetDetails')"
            dtTable = LectureBD(strReq)

        End If
        Session("DetailID") = CType(dtTable.Rows(0).Item(0), Integer)
        Response.Redirect("Salaries.aspx")
    End Sub

    Private Sub CapExp(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button7.Click
        Dim strReq As String
        Dim dtTable As DataTable
        strReq = "Select DetailID FROM tblBudgetDetails Where BudgetID = " + CType(Session("BudgetID"), String) + " AND NoGL Like 'VARIOUS'"
        dtTable = LectureBD(strReq)

        'S'il n'existe pas, on le crée ATTENTION FAUT PAS CHANGER SON CODE GL!
        If dtTable.Rows.Count = 0 Then
            strReq = "INSERT INTO tblBudgetDetails VALUES(" + CType(Session("BudgetID"), String) + ",'VARIOUS',0)"
            EcritureBD(strReq)
        End If

        Response.Redirect("CapitalExpenditure.aspx")
    End Sub
End Class
