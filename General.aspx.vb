Imports System.Data.SqlClient
'REVENUE FORECAST
'General
'description: Ce formulaire affiche le total des dépenses d'une année, il regroupe tous les départements
'Par: Francis Gauthier
'date: 27 juillet 2007
'contact: f.gauthier@cgodin.qc.ca

Imports System.Data
Imports System.Web.UI.WebControls
Public Class General
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Label1 As System.Web.UI.WebControls.Label
    Protected WithEvents DataGrid1 As System.Web.UI.WebControls.DataGrid
    Protected WithEvents DropDownList1 As System.Web.UI.WebControls.DropDownList
    Protected WithEvents Button1 As System.Web.UI.WebControls.Button
    Protected WithEvents Label6 As System.Web.UI.WebControls.Label
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

        'Changer pour le compte de Dean
        If EstAdmin(struser) = False Then
            Response.Redirect("Denied.html")
        Else
            'get data
            strReq = "Select year from tblbudget group by year ORDER BY year"
            dtTable = LectureBD(strReq)

            'Affichage des années
            If Not IsPostBack Then
                Me.DropDownList1.Items.Add(New ListItem("Choose a year..."))
                For i As Int16 = 0 To dtTable.Rows.Count - 1
                    Me.DropDownList1.Items.Add(New ListItem(dtTable.Rows(i).Item(0)))
                Next

                Me.DropDownList1.SelectedIndex = 0
            End If
        End If

    End Sub

    Private Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList1.SelectedIndexChanged
        'Affichage du budget général selon l'année
        getGeneralBudget(CDbl(Me.DropDownList1.SelectedItem.Text), False)
        Me.Button2.Text = "Show months"
        Me.DropDownList1.Items.Remove("Choose a year...")
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Response.Redirect("Manager.aspx")
    End Sub

    Private Sub getGeneralBudget(ByVal year As Integer, ByVal months As Boolean)
        Dim strReq As String
        
        Dim dtTable As New DataTable
      
        Dim gridrow As DataGridItem
        Dim footer As DataGridItem
        Dim dblTotal As Double = 0
        Dim index As Integer
        Dim dtTable2 As New DataTable
        Dim dblGL As Double
        Dim header As DataGridItem


        'get data
        index = 3
        dtTable = getGL()
        Me.DataGrid1.DataSource = dtTable
        Me.DataGrid1.DataBind()

        'affichage entete
        header = DataGrid1.Controls(0).Controls(0)
        header.Cells(2).Style("text-align") = "right"
        header.Cells(3).Style("text-align") = "right"

        'get dépense travel/training
        strReq = "SELECT isnull(sum(T.costofcourse),0), isnull(sum(T.fares),0), isnull(sum(T.hotel),0), isnull(sum(T.meals),0) + isnull(sum(T.entertainment),0), isnull(sum(Carrental),0) from tblTravelBudget AS T INNER JOIN tblbudget AS B ON T.budgetID=B.budgetID Where B.year = " & Me.DropDownList1.SelectedItem.Text

        dtTable2 = LectureBD(strReq)

        'Affichage
        footer = DataGrid1.Controls(0).Controls(DataGrid1.Controls(0).Controls.Count - 1)
        For Each gridrow In Me.DataGrid1.Items
            dblGL = 0
            If gridrow.Cells(0).Text.Trim = "08.0800310." Then

                dblGL += dtTable2.Rows(0).Item(1)

            ElseIf UCase(gridrow.Cells(1).Text.Trim) = "MEALS & ENTERTAINMENT" Then

                dblGL += dtTable2.Rows(0).Item(3)


            ElseIf gridrow.Cells(0).Text.Trim = "08.0800610." Then

                dblGL += dtTable2.Rows(0).Item(2)

            ElseIf UCase(gridrow.Cells(1).Text.Trim) = "TRAINING" Then

                dblGL += dtTable2.Rows(0).Item(0)

            ElseIf UCase(gridrow.Cells(1).Text.Trim) = "CAR RENTAL" Then

                dblGL += dtTable2.Rows(0).Item(4)
            End If

            If gridrow.Cells(0).Text.EndsWith(".") = True Or gridrow.Cells(0).Text.Trim = "VARIOUS" Then
                gridrow.Cells(index).Text = Format(CDbl(gridrow.Cells(index).Text.Remove(gridrow.Cells(index).Text.IndexOf("$"), 1)) + dblGL, "$#,##0;-$#,##0;")
                gridrow.Cells(index - 1).Text = Format(CDbl(gridrow.Cells(index).Text.Remove(gridrow.Cells(index).Text.IndexOf("$"), 1)) / 12, "$#,##0;-$#,##0;")
                If gridrow.Cells(0).Text.StartsWith("06.") Then
                    dblTotal += CDbl(gridrow.Cells(index).Text.Remove(gridrow.Cells(index).Text.IndexOf("$"), 1))
                Else
                    dblTotal -= CDbl(gridrow.Cells(index).Text.Remove(gridrow.Cells(index).Text.IndexOf("$"), 1))
                End If
            Else
                gridrow.Cells(1).Font.Bold = True
                gridrow.Cells(1).Font.Underline = True
                gridrow.Cells(index - 1).Text = ""
                gridrow.Cells(0).Text = ""
                gridrow.Cells(index).Text = ""
                gridrow.BackColor = Color.Gainsboro

            End If
            gridrow.Cells(index).Style("text-align") = "right"
            gridrow.Cells(index - 1).Style("text-align") = "right"
        Next

        'Affichage total
        footer.Cells(0).Text = "Total "
        footer.Cells(1).Text = "Year: " & year
        footer.Cells(index).Text = Format(dblTotal, "$#,##0;-$#,##0;")
        footer.Cells(index).Style("text-align") = "right"

        footer.Font.Bold = True

        For i As Integer = 2 To index - 1
            footer.Cells(i).Text = Format(dblTotal / 12, "$#,##0;-$#,##0;")
            footer.Cells(i).Style("text-align") = "right"
        Next


    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        'Cacher/voir les mois
        If Me.DropDownList1.SelectedItem.Text <> "Choose a year..." Then
            If Me.Button2.Text = "Show months" Then
                getGeneralBudget(CDbl(Me.DropDownList1.SelectedItem.Text), True)
                Me.Button2.Text = "Hide months"
            Else
                getGeneralBudget(CDbl(Me.DropDownList1.SelectedItem.Text), False)
                Me.Button2.Text = "Show months"
            End If
        End If
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

        'On va chercher mon super curseur en SQL =)
        strReq = "EXEC prGeneral " & Me.DropDownList1.SelectedItem.Text

        dtTabble2.Columns.Add("GL")
        dtTabble2.Columns.Add("Description")
        dtTabble2.Columns.Add("Per Month")
        dtTabble2.Columns.Add("Total")
      
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
End Class
