'REVENUE FORECAST
'Menu
'description: Ce formulaire s'occupe de l'ajout ou l'édition d'un budget
'Par: Francis Gauthier
'date: 27 juillet 2007
'contact: f.gauthier@cgodin.qc.ca

Public Class Menu
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents ListBox1 As System.Web.UI.WebControls.ListBox
    Protected WithEvents Label1 As System.Web.UI.WebControls.Label
    Protected WithEvents ListBox2 As System.Web.UI.WebControls.ListBox
    Protected WithEvents Label2 As System.Web.UI.WebControls.Label
    Protected WithEvents Label3 As System.Web.UI.WebControls.Label
    Protected WithEvents Label4 As System.Web.UI.WebControls.Label
    Protected WithEvents Button1 As System.Web.UI.WebControls.Button
    Protected WithEvents DataGrid1 As System.Web.UI.WebControls.DataGrid
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
        Dim bouton As LinkButton
        Dim iCompteur As Integer
        Dim gridrow As DataGridItem
        Dim lbl As Label

        struser = Request.ServerVariables("LOGON_user").Substring(Request.ServerVariables("LOGON_user").IndexOf("\") + 1, Request.ServerVariables("LOGON_user").Length - (Request.ServerVariables("LOGON_user").IndexOf("\") + 1))
        'Vérifie le user
        If EstManager(struser) = False Then
            Response.Redirect("Denied.html")
        Else
            'Afficvhage du nom du manager
            strReq = "Select E.name, M.departmentid,D.description from tblmanager AS M INNER JOIN tblemployee AS E ON M.employeeid = E.employeeid INNER JOIN tblDepartement AS D ON M.departmentid = D.departmentid where E.UserName= '" & struser & "'"

            dtTable = LectureBD(strReq)

            Me.Label4.Text = dtTable.Rows(0).Item(0)

            If Session("Open mode") = "add" Then
                'Affichage de l'année et des départements possible
                Me.DataGrid1.Visible = False
                If Not IsPostBack Then

                    For i As Int16 = 0 To dtTable.Rows.Count - 1
                        Me.ListBox1.Items.Add(New ListItem(dtTable.Rows(i).Item(2)))
                    Next


                    Me.ListBox2.Items.Add(New ListItem(GetFY(Month(Now())) + 1))


                    Me.ListBox2.SelectedIndex = 0
                    Me.ListBox1.SelectedIndex = 0
                End If

            ElseIf Session("Open mode") = "edit" Then
                'Affichage de tous les budgets déja crée des départements d'un manager
                Me.ListBox1.Visible = False
                Me.ListBox2.Visible = False
                Me.Button1.Visible = False

                dtTable.Clear()
                dtTable = New DataTable


                strReq = "Select E.name,B.Year,D.description, B.date, ISNULL((SELECT sum(C.Montant) FROM tblComponents AS C INNER JOIN tblBudgetDetails AS DD ON C.detailID = DD.detailID INNER JOIN tblGL AS G ON DD.nogl = G.gl Where DD.BudgetID = B.budgetID AND g.catID = 1),0) - ISNULL((SELECT sum(C.Montant) FROM tblComponents AS C INNER JOIN tblBudgetDetails AS DD ON C.detailID = DD.detailID INNER JOIN tblGL AS G ON DD.nogl = G.gl Where DD.BudgetID = B.budgetID AND g.catID between 2 and 6),0) - ISNULL((SELECT isnull(sum(T.costofcourse),0) + isnull(sum(T.fares),0) + isnull(sum(T.meals),0) + isnull(sum(T.hotel),0) + isnull(sum(T.entertainment),0) + isnull(sum(T.carrental),0) FROM tblTravelBudget AS T INNER JOIN tblBudget AS BB ON T.budgetID = BB.budgetID Where T.BudgetID = B.budgetID),0) 'Total' from tblBudget AS B INNER JOIN tblemployee AS E ON B.creator = E.employeeid INNER JOIN tblDepartement AS D ON B.departmentid = D.departmentid where B.departmentid IN (SELECT M.departmentid FROM tblManager AS M INNER JOIN tblemployee AS E ON M.employeeId = E.employeeID  Where B.Year > 2010 and E.username like '" & struser & "') and b.year in ('2012','2013') "

                dtTable = LectureBD(strReq)

                Me.DataGrid1.DataSource = dtTable
                If Not IsPostBack Then
                    DataGrid1.DataBind()


                    For Each gridrow In DataGrid1.Items
                        bouton = gridrow.Cells(0).FindControl("LinkButton1")
                        lbl = gridrow.Cells(4).FindControl("Label11")

                        bouton.Text = iCompteur + 1


                        gridrow.Cells(1).Text = dtTable.Rows(iCompteur).Item(1)
                        gridrow.Cells(2).Text = dtTable.Rows(iCompteur).Item(0)
                        gridrow.Cells(3).Text = dtTable.Rows(iCompteur).Item(2)
                        gridrow.Cells(5).Text = dtTable.Rows(iCompteur).Item(3)
                        lbl.Text = Format(dtTable.Rows(iCompteur).Item(4), "$#,##0;-$#,##0;")
                        lbl.Style("text-align") = "right"
                        iCompteur += 1
                    Next
                End If

            End If
        End If


    End Sub

    Private Sub New_ForeCast(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim strReq As String

        Dim struser As String
        Dim strMSG As String
        Dim strTexT As String

        'Affectation du département

        Session("department") = Me.ListBox1.SelectedItem.Text
        Session("Year") = Me.ListBox2.SelectedItem.Text


        'Ajout budget

        struser = Request.ServerVariables("LOGON_user").Substring(Request.ServerVariables("LOGON_user").IndexOf("\") + 1, Request.ServerVariables("LOGON_user").Length - (Request.ServerVariables("LOGON_user").IndexOf("\") + 1))
        strReq = "EXEC dbo.prAjoutBudget " & Me.ListBox2.SelectedItem.Text & ",'" & struser & "','" & Me.ListBox1.SelectedItem.Text & "'"


        Try
            EcritureBD(strReq)

            'Formulaire Budget

            Response.Redirect("Forecast.aspx")

        Catch ex As System.Data.OleDb.OleDbException
            'affichage message d'erreur, le budget existe déja
            strTexT = "There is already a " & Me.ListBox2.SelectedItem.Text & " budget for the " & Me.ListBox1.SelectedItem.Text & " department."
            strMSG = "<script language=Javascript>alert(""The budget already exists, you must edit it."");</script>"
            Response.Write(strMSG)
        End Try
    End Sub

    Private Sub DataGrid1_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles DataGrid1.ItemCommand

        If e.CommandName = "EditForeCast" Then
            Session("department") = e.Item.Cells(3).Text
            Session("Year") = CDbl(e.Item.Cells(1).Text)
            Response.Redirect("Forecast.aspx")
        End If
    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        Response.Redirect("Manager.aspx")
    End Sub

    Private Sub Sort_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        Dim strReq As String
        Dim dtTable As New DataTable
        Dim struser As String
        Dim iCompteur As Integer
        Dim bouton As LinkButton
        Dim btn As ImageButton = sender
        Dim lbl As Label

        'get data
        struser = Request.ServerVariables("LOGON_user").Substring(Request.ServerVariables("LOGON_user").IndexOf("\") + 1, Request.ServerVariables("LOGON_user").Length - (Request.ServerVariables("LOGON_user").IndexOf("\") + 1))
        strReq = "Select E.name,B.Year,D.description, B.date, ISNULL((SELECT sum(C.Montant) " & _
                 " FROM tblComponents AS C INNER JOIN tblBudgetDetails AS DD ON C.detailID = DD.detailID INNER JOIN " & _
                 " tblGL AS G ON DD.nogl = G.gl Where DD.BudgetID = B.budgetID AND g.catID = 1),0) - ISNULL((SELECT sum(C.Montant) " & _
                 " FROM tblComponents AS C INNER JOIN tblBudgetDetails AS DD ON C.detailID = DD.detailID INNER JOIN tblGL AS G ON DD.nogl = G.gl " & _
                 " Where DD.BudgetID = B.budgetID AND g.catID between 2 and 6),0) - ISNULL((SELECT isnull(sum(T.costofcourse),0) + isnull(sum(T.fares),0) + isnull(sum(T.meals),0) + isnull(sum(T.hotel),0) + isnull(sum(T.entertainment),0) + isnull(sum(T.carrental),0) FROM tblTravelBudget AS T INNER JOIN tblBudget AS BB ON T.budgetID = BB.budgetID Where T.BudgetID = B.budgetID),0) 'Total' from tblBudget AS B INNER JOIN tblemployee AS E ON B.creator = E.employeeid INNER JOIN tblDepartement AS D ON B.departmentid = D.departmentid where B.departmentid IN (SELECT M.departmentid FROM tblManager AS M INNER JOIN tblemployee AS E ON M.employeeId = E.employeeID  Where E.username like '" & struser & "') and b.year in ('2012','2013') ORDER BY " & btn.CommandName

        dtTable = LectureBD(strReq)

        'Affichage selon l'ordre voulu
        Me.DataGrid1.DataSource = dtTable
        DataGrid1.DataBind()
        Dim gridrow As DataGridItem

        For Each gridrow In DataGrid1.Items
            lbl = gridrow.Cells(4).FindControl("Label11")
            bouton = gridrow.Cells(0).FindControl("LinkButton1")
            bouton.Text = iCompteur + 1

            gridrow.Cells(1).Text = dtTable.Rows(iCompteur).Item(1)
            gridrow.Cells(2).Text = dtTable.Rows(iCompteur).Item(0)
            gridrow.Cells(3).Text = dtTable.Rows(iCompteur).Item(2)
            gridrow.Cells(5).Text = dtTable.Rows(iCompteur).Item(3)
            lbl.Text = Format(dtTable.Rows(iCompteur).Item(4), "$#,##0;-$#,##0;")
            lbl.Style("text-align") = "right"

            iCompteur += 1
        Next
    End Sub
    Private Sub DataGrid1_ItemCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles DataGrid1.ItemCreated
        Dim btn As ImageButton
        If e.Item.ItemType = ListItemType.Header Then
            btn = e.Item.Cells(0).FindControl("ImageButton1")
            AddHandler btn.Click, AddressOf Sort_Click

            btn = e.Item.Cells(1).FindControl("ImageButton2")
            AddHandler btn.Click, AddressOf Sort_Click

            btn = e.Item.Cells(2).FindControl("ImageButton3")
            AddHandler btn.Click, AddressOf Sort_Click

            btn = e.Item.Cells(3).FindControl("ImageButton4")
            AddHandler btn.Click, AddressOf Sort_Click

            btn = e.Item.Cells(5).FindControl("ImageButton5")
            AddHandler btn.Click, AddressOf Sort_Click

            btn = e.Item.Cells(4).FindControl("ImageButton6")
            AddHandler btn.Click, AddressOf Sort_Click

        End If
    End Sub


End Class
