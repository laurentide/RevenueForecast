'REVENUE FORECAST
'TravelAndTRaining
'description: Ce formulaire ajout/edit les dépenses de travel ou de training
'Par: Francis Gauthier
'date: 27 juillet 2007
'contact: f.gauthier@cgodin.qc.ca

Public Class TravelAndTraining
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents DataGrid1 As System.Web.UI.WebControls.DataGrid
    Protected WithEvents Button1 As System.Web.UI.WebControls.Button
    Protected WithEvents Label6 As System.Web.UI.WebControls.Label
    Protected WithEvents ImageButton1 As System.Web.UI.WebControls.ImageButton
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
        Dim strReq As String
        Dim struser As String

        'Vérifie user
        struser = Request.ServerVariables("LOGON_user").Substring(Request.ServerVariables("LOGON_user").IndexOf("\") + 1, Request.ServerVariables("LOGON_user").Length - (Request.ServerVariables("LOGON_user").IndexOf("\") + 1))
        If EstManager(struser) = False Then
            Response.Redirect("Denied.html")
        Else
            'Affichage
            dtTable = getData(False)
            DataGrid1.DataSource = dtTable
            If Not IsPostBack Then
                Me.Label6.Text = "Travel And Training " & Session("Year")
                Affiche(dtTable)
            End If
        End If

    End Sub
    Private Sub Affiche(ByVal dtTable As DataTable)
        Dim gridrow As DataGridItem
        Dim iCompteur As Integer = 0

        Me.DataGrid1.Columns(12).Visible = False
        DataGrid1.DataBind()
        For Each gridrow In DataGrid1.Items
            'Affichage selon l'édition
            If gridrow.ItemIndex <> Me.DataGrid1.EditItemIndex Then
                gridrow.Cells(0).Text = dtTable.Rows(iCompteur).Item(0)
                gridrow.Cells(1).Text = dtTable.Rows(iCompteur).Item(1)
                gridrow.Cells(2).Text = dtTable.Rows(iCompteur).Item(2)
                gridrow.Cells(3).Text = dtTable.Rows(iCompteur).Item(3)

                gridrow.Cells(4).Text = Format(dtTable.Rows(iCompteur).Item(4), "$#,##0;-$#,##0;")

                gridrow.Cells(5).Text = Format(dtTable.Rows(iCompteur).Item(5), "$#,##0;-$#,##0;")


                gridrow.Cells(6).Text = Format(dtTable.Rows(iCompteur).Item(6), "$#,##0;-$#,##0;")


                gridrow.Cells(7).Text = Format(dtTable.Rows(iCompteur).Item(7), "$#,##0;-$#,##0;")

                gridrow.Cells(8).Text = Format(dtTable.Rows(iCompteur).Item(8), "$#,##0;-$#,##0;")

                gridrow.Cells(9).Text = Format(dtTable.Rows(iCompteur).Item(9), "$#,##0;-$#,##0;")

                gridrow.Cells(10).Text = dtTable.Rows(iCompteur).Item(10)
                gridrow.Cells(12).Text = dtTable.Rows(iCompteur).Item(11)

            Else
                Dim dtTable2 As New DataTable
                Dim btn As Button
                Dim txtbox As TextBox
                Dim list As DropDownList
                dtTable2 = getData(True)

                list = gridrow.FindControl("DropDownList3")
                list.Items.Clear()
                For i As Integer = 0 To dtTable2.Rows.Count - 1
                    list.Items.Add(New ListItem(dtTable2.Rows(i).Item(1), dtTable2.Rows(i).Item(0)))
                Next
                list.SelectedIndex = list.Items.IndexOf(list.Items.FindByText(dtTable.Rows(iCompteur).Item(0)))

                list = gridrow.FindControl("DropDownList4")
                list.SelectedIndex = list.Items.IndexOf(list.Items.FindByText(dtTable.Rows(iCompteur).Item(1)))

                txtbox = gridrow.FindControl("TextBox10")
                txtbox.Text = dtTable.Rows(iCompteur).Item(2)


                txtbox = gridrow.FindControl("TextBox11")
                txtbox.Text = dtTable.Rows(iCompteur).Item(3)

                txtbox = gridrow.FindControl("TextBox12")
                txtbox.Text = Format(dtTable.Rows(iCompteur).Item(4), "#,##0;-#,##0;")

                txtbox = gridrow.FindControl("TextBox13")
                txtbox.Text = Format(dtTable.Rows(iCompteur).Item(5), "#,##0;-#,##0;")

                txtbox = gridrow.FindControl("TextBox14")
                txtbox.Text = Format(dtTable.Rows(iCompteur).Item(6), "#,##0;-#,##0;")

                txtbox = gridrow.FindControl("TextBox15")
                txtbox.Text = Format(dtTable.Rows(iCompteur).Item(7), "#,##0;-#,##0;")

                txtbox = gridrow.FindControl("TextBox16")
                txtbox.Text = Format(dtTable.Rows(iCompteur).Item(8), "#,##0;-#,##0;")

                txtbox = gridrow.FindControl("TextBox17")
                txtbox.Text = Format(dtTable.Rows(iCompteur).Item(9), "#,##0;-#,##0;")

                txtbox = gridrow.FindControl("TextBox18")
                'Affecte l'option d'afficher le calendrier au textbox
                txtbox.Attributes.Add("OnClick", "window.open('popup.aspx',null,'width=250,height=235,top=180,left=270,status=no, resizable= no, scrollbars= no, toolbar= no,location= no,menubar= no');")
                txtbox.Text = dtTable.Rows(iCompteur).Item(10)



                gridrow.Cells(12).Text = dtTable.Rows(iCompteur).Item(11)

                btn = gridrow.FindControl("Button4")
                btn.Text = "Done"
                btn.CommandName = "Done"

            End If

            iCompteur += 1
        Next
        remplitEmployee()
    End Sub

    Private Function getData(ByVal employees As Boolean) As DataTable
        Dim strReq As String
        Dim dtTable As New DataTable

        If employees = False Then
            strReq = "Select E.name, T.type, T.destination, T.CourseTitle, T.CostOfCourse, T.Carrental, T.Fares, T.Hotel,T.Meals, T.Entertainment, T.date, T.TravelBudgetID FROM tblTravelBudget AS T INNER JOIN tblemployee AS E ON T.employeeID=E.employeeID INNER JOIN tblbudget AS B ON T.budgetid = B.budgetID Where B.budgetID = " & Session("BudgetID")

        Else
            strReq = "Select E.employeeID, E.name from tblemployee AS E INNER JOIN tbldepartement AS D ON E.departmentID = D.departmentID Where d.description like '" & Session("department") & "' ORDER BY E.name"
        End If

        dtTable = LectureBD(strReq)

        Return dtTable
    End Function

    Private Sub remplitEmployee()
        Dim dtTable As New DataTable
        Dim footer As DataGridItem
        Dim employeebox As DropDownList
        Dim txtbox As TextBox


        footer = DataGrid1.Controls(0).Controls(DataGrid1.Controls(0).Controls.Count - 1)

        employeebox = footer.FindControl("DropDownList1")
        txtbox = footer.FindControl("TextBox8")

        'If Not Session("Date") Is Nothing Then
        '    txtbox.Text = Session("Date")
        'End If

        'Affecte l'option d'afficher le calendrier au textbox
        txtbox.Attributes.Add("OnClick", "window.open('popup.aspx',null,'width=250,height=235,top=180,left=270,status=no, resizable= no, scrollbars= no, toolbar= no,location= no,menubar= no');")
        dtTable = getData(True)

        'Remplis la liste des employés dans le dropdownlist
        employeebox.Items.Add(New ListItem("Choose employee..."))
        For i As Integer = 0 To dtTable.Rows.Count - 1
            employeebox.Items.Add(New ListItem(dtTable.Rows(i).Item(1), dtTable.Rows(i).Item(0)))
        Next

    End Sub
    Private Sub back(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Session("Date") = Nothing
        Response.Redirect("Forecast.aspx")
    End Sub

    Private Sub DataGrid1_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles DataGrid1.ItemCommand

        Dim strReq As String
        Dim textbox As TextBox
        Dim employee As DropDownList
        Dim dtTable As New DataTable
        Dim strTexT, strMSG As String

        If e.CommandName = "Add" Then

            employee = e.Item.Cells(0).FindControl("DropDownList1")

            strReq = "INSERT INTO tblTravelBudget VALUES("
            strReq += CType(Session("BudgetID"), String) & ","
            strReq += employee.SelectedItem.Value & ",'"
            employee = e.Item.Cells(1).FindControl("DropDownList2")
            strReq += employee.SelectedItem.Text & "','"
            textbox = e.Item.Cells(2).FindControl("TextBox7")
            strReq += setGuillemets(textbox.Text) & "','"

            textbox = e.Item.Cells(3).FindControl("TextBox1")
            strReq += setGuillemets(textbox.Text) & "',"

            textbox = e.Item.Cells(4).FindControl("TextBox2")
            strReq += CDbl(Isnull(textbox.Text)) & ","

            textbox = e.Item.Cells(5).FindControl("TextBox9")
            strReq += CDbl(Isnull(textbox.Text)) & ","

            textbox = e.Item.Cells(6).FindControl("TextBox3")
            strReq += CDbl(Isnull(textbox.Text)) & ","

            textbox = e.Item.Cells(7).FindControl("TextBox4")
            strReq += CDbl(Isnull(textbox.Text)) & ","

            textbox = e.Item.Cells(8).FindControl("TextBox5")
            strReq += CDbl(Isnull(textbox.Text)) & ","

            textbox = e.Item.Cells(9).FindControl("TextBox6")
            strReq += CDbl(Isnull(textbox.Text)) & ",'"

            textbox = e.Item.Cells(10).FindControl("TextBox8")
            strReq += textbox.Text + "')"

            Session("Date") = Nothing
            'Savegarder et afficher de nouveau seulement si l'utilisateur a choisit un employés, un type et une date
            Try
                If employee.SelectedItem.Text = "Choose..." Or textbox.Text = "" Then
                    Throw New Exception
                End If
                EcritureBD(strReq)
                dtTable = getData(False)
                DataGrid1.DataSource = dtTable
                Affiche(dtTable)
            Catch ee As Exception
                strTexT = """You must enter an employee name, a travel type, a destination and a date"""
                strMSG = "<script language=Javascript>alert("
                strMSG += strTexT
                strMSG += ");</script>"
                Response.Write(strMSG)
            End Try


        ElseIf e.CommandName = "Delete" Then
            If e.Item.ItemIndex = Me.DataGrid1.EditItemIndex Then
                Me.DataGrid1.EditItemIndex = -1

            ElseIf Me.DataGrid1.EditItemIndex > e.Item.ItemIndex Then
                Me.DataGrid1.EditItemIndex -= 1
            End If

            strReq = "DELETE FROM tblTravelBudget Where TravelBudgetID=" & e.Item.Cells(12).Text
            'Savegarder et afficher de nouveau
            EcritureBD(strReq)
            dtTable = getData(False)
            DataGrid1.DataSource = dtTable
            Affiche(dtTable)

        ElseIf e.CommandName = "Edit" And Me.DataGrid1.EditItemIndex = -1 Then
            Me.DataGrid1.EditItemIndex = e.Item.ItemIndex


            dtTable = getData(False)
            DataGrid1.DataSource = dtTable
            Affiche(dtTable)

        ElseIf e.CommandName = "Done" Then
            Dim btn As Button
            Dim txtbox As TextBox
            Dim list As DropDownList
            Me.DataGrid1.EditItemIndex = -1


            strReq = "UPDATE tblTravelBudget SET EmployeeID="
            list = e.Item.FindControl("DropDownList3")
            strReq += list.SelectedItem.Value & ",Type='"

            list = e.Item.FindControl("DropDownList4")
            strReq += list.SelectedItem.Text & "',Destination='"

            txtbox = e.Item.FindControl("TextBox10")
            strReq += setGuillemets(txtbox.Text) & "',CourseTitle='"


            txtbox = e.Item.FindControl("TextBox11")
            strReq += setGuillemets(txtbox.Text) & "',CostOfCourse="

            txtbox = e.Item.FindControl("TextBox12")
            strReq += CDbl(Isnull(txtbox.Text)) & ",CarRental="

            txtbox = e.Item.FindControl("TextBox13")
            strReq += CDbl(Isnull(txtbox.Text)) & ",Fares="

            txtbox = e.Item.FindControl("TextBox14")
            strReq += CDbl(Isnull(txtbox.Text)) & ",Hotel="

            txtbox = e.Item.FindControl("TextBox15")
            strReq += CDbl(Isnull(txtbox.Text)) & ",Meals="

            txtbox = e.Item.FindControl("TextBox16")
            strReq += CDbl(Isnull(txtbox.Text)) & ",Entertainment="

            txtbox = e.Item.FindControl("TextBox17")
            strReq += CDbl(Isnull(txtbox.Text)) & ",date='"

            txtbox = e.Item.FindControl("TextBox18")
            strReq += txtbox.Text & "' Where TravelBudgetID = " & e.Item.Cells(12).Text

            'Savegarder et afficher de nouveau
            EcritureBD(strReq)

            dtTable = getData(False)
            DataGrid1.DataSource = dtTable
            Affiche(dtTable)

        End If
    End Sub
    Private Sub ImageButton1_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        Dim datebox As TextBox

        'Add au textbox la valeur sélectionner du calendrier
        If Not Session("Date") Is Nothing Then
            If Me.DataGrid1.EditItemIndex = -1 Then
                datebox = DataGrid1.Controls(0).Controls(DataGrid1.Controls(0).Controls.Count - 1).FindControl("TextBox8")
            Else
                datebox = Me.DataGrid1.Items(Me.DataGrid1.EditItemIndex).Cells(10).FindControl("TextBox18")
            End If
            datebox.Text = Session("Date")
        End If
    End Sub


End Class
