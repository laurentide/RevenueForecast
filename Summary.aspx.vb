'REVENUE FORECAST
'Summary
'description: Ce formulaire affiche le sommaire d'un budget
'Par: Francis Gauthier
'date: 27 juillet 2007
'contact: f.gauthier@cgodin.qc.ca

Public Class Summary
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Button1 As System.Web.UI.WebControls.Button
    Protected WithEvents DataGrid1 As System.Web.UI.WebControls.DataGrid
    Protected WithEvents Label4 As System.Web.UI.WebControls.Label
    Protected WithEvents TextBox2 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label6 As System.Web.UI.WebControls.Label
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
        Dim gridrow As DataGridItem
        Dim strReq, struser As String
        Dim txtbox As TextBox
        Dim lbl As Label

        Dim dblexpense As Double

        Me.Label4.Text = "Plan Summary " & Session("Year")
        Me.Label4.Style("text-align") = "center"
        struser = Request.ServerVariables("LOGON_user").Substring(Request.ServerVariables("LOGON_user").IndexOf("\") + 1, Request.ServerVariables("LOGON_user").Length - (Request.ServerVariables("LOGON_user").IndexOf("\") + 1))
        If EstManager(struser) = False Then
            Response.Redirect("Denied.html")
        Else
            strReq = "Select * from tblmaincat where catID between 1 and 6"

            dtTable = LectureBD(strReq)
            Me.DataGrid1.DataSource = dtTable
            If Not IsPostBack Then
                Me.DataGrid1.DataBind()

                'Colonne de droite
                Me.DataGrid1.Items(0).Cells(0).Text = "Revenues"
                Me.DataGrid1.Items(1).Cells(0).Text = "Margin"
                Me.DataGrid1.Items(2).Cells(0).Text = "Employee expenses"
                Me.DataGrid1.Items(3).Cells(0).Text = "Total expenses"
                Me.DataGrid1.Items(4).Cells(0).Text = "Contribution"
                Me.DataGrid1.Items(5).Cells(0).Text = "FTE"

                'En-tetes
                Dim header As DataGridItem
                Dim label As Label
                header = DataGrid1.Controls(0).Controls(0)

                label = header.FindControl("Label1")
                label.Text = "Plan " & CType(Session("Year"), Integer)

                label = header.FindControl("Label2")
                label.Text = "Projected " & CType(Session("Year"), Integer) - 1

                label = header.FindControl("Label3")
                label.Text = "Actual " & CType(Session("Year"), Integer) - 2

                label = header.FindControl("Label5")
                label.Text = "Actual " & CType(Session("Year"), Integer) - 3

                'Revenues
                strReq = "SELECT ISNULL(sum(C.montant),0) FROM tblComponents AS C INNER JOIN tblBudgetDetails AS D ON C.DetailID=D.DetailID INNER JOIN tblGL AS G ON D.nogl=G.GL INNER JOIN tblMainCat AS M ON G.catID=M.catID INNER JOIN tblBudget AS B ON D.budgetID = B.BudgetID WHere B.BudgetID = " & Session("BudgetID") & " and M.catID = 1"

                dtTable = New DataTable
                dtTable = LectureBD(strReq)

                Dim dtTable3 As New DataTable
                strReq = "Select * FROM tblSummary Where BudgetID = " & Session("BudgetID")
                dtTable3 = LectureBD(strReq)

                label = Me.DataGrid1.Items(0).Cells(1).FindControl("Label10")
                label.Text = Format(dtTable.Rows(0).Item(0), "$#,##0;-$#,##0;")
                label.Style("text-align") = "right"

                txtbox = Me.DataGrid1.Items(0).Cells(2).FindControl("TextBox1")
                txtbox.Text = Format(dtTable3.Rows(0).Item(1), "#,##0;-#,##0;")
                txtbox.Style("text-align") = "right"
                If struser <> "DeanW" And struser <> "ClaireD" And struser <> "d2dadmin" Then
                    txtbox.Enabled = False
                End If

                txtbox = Me.DataGrid1.Items(0).Cells(3).FindControl("TextBox3")
                txtbox.Text = Format(dtTable3.Rows(0).Item(2), "#,##0;-#,##0;")
                txtbox.Style("text-align") = "right"

                If struser <> "DeanW" And struser <> "ClaireD" And struser <> "d2dadmin" Then
                    txtbox.Enabled = False
                End If

                txtbox = Me.DataGrid1.Items(0).Cells(4).FindControl("TextBox4")
                txtbox.Text = Format(dtTable3.Rows(0).Item(3), "#,##0;-#,##0;")
                txtbox.Style("text-align") = "right"

                If struser <> "DeanW" And struser <> "ClaireD" And struser <> "d2dadmin" Then
                    txtbox.Enabled = False
                End If
                'Margin
                strReq = "SELECT ISNULL(sum(C.montant),0) FROM tblComponents AS C INNER JOIN tblBudgetDetails AS D ON C.DetailID=D.DetailID INNER JOIN tblGL AS G ON D.nogl=G.GL INNER JOIN tblMainCat AS M ON G.catID=M.catID INNER JOIN tblBudget AS B ON D.budgetID = B.BudgetID WHere B.BudgetID = " & Session("BudgetID") & " and M.catID = 2 "

                dtTable = New DataTable
                dtTable = LectureBD(strReq)
                lbl = Me.DataGrid1.Items(1).Cells(1).FindControl("Label10")
                lbl.Text = Format(CDbl(label.Text.Remove(label.Text.IndexOf("$"), 1) - dtTable.Rows(0).Item(0)), "$#,##0;-$#,##0;")
                lbl.Style("text-align") = "right"

                txtbox = Me.DataGrid1.Items(1).Cells(2).FindControl("TextBox1")
                txtbox.Text = Format(dtTable3.Rows(0).Item(4), "#,##0;-#,##0;")
                txtbox.Style("text-align") = "right"

                If struser <> "DeanW" And struser <> "ClaireD" And struser <> "d2dadmin" Then
                    txtbox.Enabled = False
                End If

                txtbox = Me.DataGrid1.Items(1).Cells(3).FindControl("TextBox3")
                txtbox.Text = Format(dtTable3.Rows(0).Item(5), "#,##0;-#,##0;")
                txtbox.Style("text-align") = "right"

                If struser <> "DeanW" And struser <> "ClaireD" And struser <> "d2dadmin" Then
                    txtbox.Enabled = False
                End If

                txtbox = Me.DataGrid1.Items(1).Cells(4).FindControl("TextBox4")
                txtbox.Text = Format(dtTable3.Rows(0).Item(6), "#,##0;-#,##0;")
                txtbox.Style("text-align") = "right"

                If struser <> "DeanW" And struser <> "ClaireD" And struser <> "d2dadmin" Then
                    txtbox.Enabled = False
                End If
                'Employee expenses
                strReq = "SELECT ISNULL(sum(C.montant),0) FROM tblComponents AS C INNER JOIN tblBudgetDetails AS D ON C.DetailID=D.DetailID INNER JOIN tblGL AS G ON D.nogl=G.GL INNER JOIN tblMainCat AS M ON G.catID=M.catID INNER JOIN tblBudget AS B ON D.budgetID = B.BudgetID WHere B.BudgetID = " & Session("BudgetID") & " and M.catID = 3 "

                dtTable = New DataTable
                dtTable = LectureBD(strReq)
                label = Me.DataGrid1.Items(2).Cells(1).FindControl("Label10")
                label.Text = Format(dtTable.Rows(0).Item(0), "$#,##0;-$#,##0;")
                label.Style("text-align") = "right"


                txtbox = Me.DataGrid1.Items(2).Cells(2).FindControl("TextBox1")
                txtbox.Text = Format(dtTable3.Rows(0).Item(7), "#,##0;-#,##0;")
                txtbox.Style("text-align") = "right"

                If struser <> "DeanW" And struser <> "ClaireD" And struser <> "d2dadmin" Then
                    txtbox.Enabled = False
                End If
                txtbox = Me.DataGrid1.Items(2).Cells(3).FindControl("TextBox3")
                txtbox.Text = Format(dtTable3.Rows(0).Item(8), "#,##0;-#,##0;")
                txtbox.Style("text-align") = "right"

                If struser <> "DeanW" And struser <> "ClaireD" And struser <> "d2dadmin" Then
                    txtbox.Enabled = False
                End If
                txtbox = Me.DataGrid1.Items(2).Cells(4).FindControl("TextBox4")
                txtbox.Text = Format(dtTable3.Rows(0).Item(9), "#,##0;-#,##0;")
                txtbox.Style("text-align") = "right"

                If struser <> "DeanW" And struser <> "ClaireD" And struser <> "d2dadmin" Then
                    txtbox.Enabled = False
                End If
                'Total expense
                strReq = "SELECT ISNULL(sum(C.montant),0) FROM tblComponents AS C INNER JOIN tblBudgetDetails AS D ON C.DetailID=D.DetailID INNER JOIN tblGL AS G ON D.nogl=G.GL INNER JOIN tblMainCat AS M ON G.catID=M.catID INNER JOIN tblBudget AS B ON D.budgetID = B.BudgetID WHere B.BudgetID = " & Session("BudgetID") & " and M.catID BETWEEN 3 AND 6"

                dtTable = New DataTable
                dtTable = LectureBD(strReq)

                strReq = "SELECT isnull(sum(costofcourse),0), isnull(sum(fares),0), isnull(sum(hotel),0), isnull(sum(meals),0) + isnull(sum(entertainment),0), isnull(sum(carRental),0) from tblTravelBudget Where budgetID = " & Session("BudgetID")
                Dim dtTable2 As New DataTable
                dtTable2 = LectureBD(strReq)
                dblexpense = 0

                dblexpense += dtTable2.Rows(0).Item(0)
                dblexpense += dtTable2.Rows(0).Item(1)
                dblexpense += dtTable2.Rows(0).Item(2)
                dblexpense += dtTable2.Rows(0).Item(3)
                dblexpense += dtTable2.Rows(0).Item(4)

                label = Me.DataGrid1.Items(3).Cells(1).FindControl("Label10")
                label.Text = Format(dtTable.Rows(0).Item(0) + dblexpense, "$#,##0;-$#,##0;")
                label.Style("text-align") = "right"

                txtbox = Me.DataGrid1.Items(3).Cells(2).FindControl("TextBox1")
                txtbox.Text = Format(dtTable3.Rows(0).Item(10), "#,##0;-#,##0;")
                txtbox.Style("text-align") = "right"

                If struser <> "DeanW" And struser <> "ClaireD" And struser <> "d2dadmin" Then
                    txtbox.Enabled = False
                End If
                txtbox = Me.DataGrid1.Items(3).Cells(3).FindControl("TextBox3")
                txtbox.Text = Format(dtTable3.Rows(0).Item(11), "#,##0;-#,##0;")
                txtbox.Style("text-align") = "right"

                If struser <> "DeanW" And struser <> "ClaireD" And struser <> "d2dadmin" Then
                    txtbox.Enabled = False
                End If
                txtbox = Me.DataGrid1.Items(3).Cells(4).FindControl("TextBox4")
                txtbox.Text = Format(dtTable3.Rows(0).Item(12), "#,##0;-#,##0;")
                txtbox.Style("text-align") = "right"

                If struser <> "DeanW" And struser <> "ClaireD" And struser <> "d2dadmin" Then
                    txtbox.Enabled = False
                End If

                'Contribution
                label = Me.DataGrid1.Items(4).Cells(1).FindControl("Label10")
                label.Text = Format(CDbl(CType(Me.DataGrid1.Items(1).Cells(1).FindControl("Label10"), Label).Text.Remove(CType(Me.DataGrid1.Items(1).Cells(1).FindControl("Label10"), Label).Text.IndexOf("$"), 1)) - CDbl(CType(Me.DataGrid1.Items(3).Cells(1).FindControl("Label10"), Label).Text.Remove(CType(Me.DataGrid1.Items(3).Cells(1).FindControl("Label10"), Label).Text.IndexOf("$"), 1)), "$#,##0;-$#,##0;")
                label.Style("text-align") = "right"

                txtbox = Me.DataGrid1.Items(4).Cells(2).FindControl("TextBox1")
                txtbox.Text = Format(dtTable3.Rows(0).Item(13), "#,##0;-#,##0;")
                txtbox.Style("text-align") = "right"

                If struser <> "DeanW" And struser <> "ClaireD" And struser <> "d2dadmin" Then
                    txtbox.Enabled = False
                End If
                txtbox = Me.DataGrid1.Items(4).Cells(3).FindControl("TextBox3")
                txtbox.Text = Format(dtTable3.Rows(0).Item(14), "#,##0;-#,##0;")
                txtbox.Style("text-align") = "right"

                If struser <> "DeanW" And struser <> "ClaireD" And struser <> "d2dadmin" Then
                    txtbox.Enabled = False
                End If
                txtbox = Me.DataGrid1.Items(4).Cells(4).FindControl("TextBox4")
                txtbox.Text = Format(dtTable3.Rows(0).Item(15), "#,##0;-#,##0;")
                txtbox.Style("text-align") = "right"

                If struser <> "DeanW" And struser <> "ClaireD" And struser <> "d2dadmin" Then
                    txtbox.Enabled = False
                End If
                'FTE
                Dim sommeemployees As Integer = 0
                strReq = "Select isnull(count(E.name),0) FROM tblemployee AS E INNER JOIN tblDepartement AS D ON E.departmentID = D.departmentID Where D.description like '" & Session("department") & "' AND E.name NOT LIKE '(Projected employees)'"
                dtTable = New DataTable
                dtTable = LectureBD(strReq)
                sommeemployees += dtTable.Rows(0).Item(0)

                strReq = "Select isnull(count(C.description),0) FROM tblcomponents AS C INNER JOIN tblbudgetDetails AS D ON c.detailid = D.detailid Where D.budgetID =" & Session("BudgetID") & " AND D.nogl LIKE '08.0800111.' AND c.description not like '%total%'"
                dtTable = New DataTable
                dtTable = LectureBD(strReq)
                sommeemployees += dtTable.Rows(0).Item(0)

                label = Me.DataGrid1.Items(5).Cells(1).FindControl("Label10")
                label.Text = sommeemployees & " Employees"
                label.Style("text-align") = "right"


                txtbox = Me.DataGrid1.Items(5).Cells(2).FindControl("TextBox1")


                txtbox.Text = dtTable3.Rows(0).Item(16)
                txtbox.Style("text-align") = "right"

                If struser <> "DeanW" And struser <> "ClaireD" And struser <> "d2dadmin" Then
                    txtbox.Enabled = False
                End If

                txtbox = Me.DataGrid1.Items(5).Cells(3).FindControl("TextBox3")

                txtbox.Text = dtTable3.Rows(0).Item(17)
                txtbox.Style("text-align") = "right"

                If struser <> "DeanW" And struser <> "ClaireD" And struser <> "d2dadmin" Then
                    txtbox.Enabled = False
                End If

                txtbox = Me.DataGrid1.Items(5).Cells(4).FindControl("TextBox4")

                txtbox.Text = dtTable3.Rows(0).Item(18)
                txtbox.Style("text-align") = "right"

                If struser <> "DeanW" And struser <> "ClaireD" And struser <> "d2dadmin" Then
                    txtbox.Enabled = False
                End If
                'Comments
                strReq = "Select Comments FROM tblBudget Where BudgetID =" & Session("BudgetID")

                dtTable = New DataTable
                dtTable = LectureBD(strReq)

                Me.TextBox2.Text = dtTable.Rows(0).Item(0)


            End If
        End If

    End Sub

    Private Sub Back(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim strReq As String
        Dim str(18) As String
        Dim gridrow As DataGridItem
        Dim icompteur As Integer = 0
        Dim txtbox1, txtbox2, txtbox3 As TextBox

        str(0) = "ProjectedRev="
        str(1) = " ,Actual1Rev="
        str(2) = " ,Actual2Rev="
        str(3) = " ,ProjectedMar="
        str(4) = " ,Actual1Mar="
        str(5) = " ,Actual2Mar="
        str(6) = " ,ProjectedEmpEX="
        str(7) = " ,Actual1EmpEx="
        str(8) = " ,Actual2EmpEx="
        str(9) = " ,ProjectedTot="
        str(10) = " ,Actual1Tot="
        str(11) = " ,Actual2Tot="
        str(12) = " ,ProjectedCon="
        str(13) = " ,Actual1Con="
        str(14) = " ,Actual2Con="
        str(15) = " ,ProjectedFTE="
        str(16) = " ,Actual1FTE="
        str(17) = " ,Actual2FTE="

        'Savegarde les données en entré
        strReq = "UPDATE tblSummary SET "
        For Each gridrow In DataGrid1.Items
            'inc = gridrow.FindControl("TextBox1")
            txtbox1 = gridrow.FindControl("TextBox1")
            txtbox2 = gridrow.FindControl("TextBox3")
            txtbox3 = gridrow.FindControl("TextBox4")

            strReq += str(icompteur) & CDbl(Isnull(txtbox1.Text)) & str(icompteur + 1) & CDbl(Isnull(txtbox2.Text)) & str(icompteur + 2) & CDbl(Isnull(txtbox3.Text))

            icompteur += 3
        Next

        strReq += " Where BudgetID =" & Session("BudgetID")

        EcritureBD(strReq)

        strReq = "UPDATE tblBudget SET Comments='" & setGuillemets(Me.TextBox2.Text) & "' Where budgetID = " & Session("BudgetID")
        EcritureBD(strReq)


        Response.Redirect("ForeCast.aspx")
    End Sub
End Class
