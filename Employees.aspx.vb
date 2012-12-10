Imports System.DirectoryServices
Imports System.Data.SqlClient
Imports System.Data.OleDb
'REVENUE FORECAST
'CellularExpense
'description: Ce formulaire n'est pas utilisé dans le programme, il sera peut-etre utile un jour....
'Par: Francis Gauthier
'date: 27 juillet 2007
'contact: f.gauthier@cgodin.qc.ca

Imports System.Data
Imports System.Web.UI.WebControls
Public Class Employees
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Label1 As System.Web.UI.WebControls.Label
    Protected WithEvents Button2 As System.Web.UI.WebControls.Button
    Protected WithEvents TextBox1 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Button1 As System.Web.UI.WebControls.Button
    Protected WithEvents DataGrid1 As System.Web.UI.WebControls.DataGrid
    Protected WithEvents RadioButtonList1 As System.Web.UI.WebControls.RadioButtonList
    Protected WithEvents DataGrid2 As System.Web.UI.WebControls.DataGrid

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

        strReq = "EXEC prCurseur"

        dtTabble2.Columns.Add()
        dtTabble2.Columns.Add()
        dtTabble2.Columns.Add()
        cmdTable = New SqlCommand(strReq, dbConn)
        sqlAdapter = New SqlDataAdapter(cmdTable)
        'sqlAdapter.Fill(dtTable)

        For Each Table In dtTable.Tables
            icompteur = 0
            For Each row In Table.Rows
               
                row2 = dtTabble2.NewRow()
                row2(0) = row.Item(0)
                row2(1) = row.Item(1)
                row2(2) = row.Item(2)

                dtTabble2.Rows.Add(row2)
            Next
        Next
        Me.DataGrid2.DataSource = dtTabble2

        Me.DataGrid2.DataBind()


    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        Response.Redirect("Manager.aspx")
    End Sub

    Private Sub getemployeesAD(ByVal search As String)
        Dim adEntry As New DirectoryEntry("LDAP://OU=LCL_USER,adc.laurentidecontrols.com")

        ' define which fields to retrieve from AD
        Dim result As SearchResult
        Dim Searcher As New DirectorySearcher(adEntry)
        Dim dt As New DataTable("AD_Users")
        Dim intcompteur As Integer = 0


        'Searcher.Filter = "(&(objectCategory=person)(objectClass=group))"
        Searcher.Filter = "(&(objectCategory=person)(objectClass=user)"
        Searcher.PropertiesToLoad.Add("cn")
        Searcher.PropertiesToLoad.Add("name")
        Searcher.PropertiesToLoad.Add("sAMAccountName")


        Response.Write(Searcher.FindAll.Count)

        dt.Columns.Add(New DataColumn("cn", GetType(System.String)))

        dt.Columns.Add(New DataColumn("name", GetType(System.String)))

        dt.Columns.Add(New DataColumn("sAMAccountName", GetType(System.String)))

        Dim dr As DataRow

        Searcher.Sort.PropertyName = "name"

        For Each result In Searcher.FindAll()
            dr = dt.NewRow()
            intcompteur += 1
            ' Me.ListBox1.Items.Add(intcompteur & ", " & result.Properties("sAMAccountName")(0).ToString() & ", " & result.Properties("name")(0).ToString())
            dr(0) = result.Properties("cn")(0).ToString()

            dr(1) = result.Properties("name")(0).ToString()

            dr(2) = result.Properties("sAMAccountName")(0).ToString()

            dt.Rows.Add(dr)

        Next
        adEntry.Close()

    End Sub
    Private Sub getemployeesSQL(ByVal search As String)
        Dim strReq As String
        Dim cmdTable As SqlCommand
        Dim sqlAdapter As SqlDataAdapter
        Dim dtTable As New DataTable
        Dim strConn As String = "Server=localhost;uid=LCLADMIN;password=test;database=LCLAdmin"
        Dim dbConn As New SqlConnection(strConn)
        Dim intcompteur As Integer = 0
        Dim gridrow As DataGridItem
        Dim txbox As TextBox

        'Changer pour le compte de Dean
        If search <> "" Then
            strReq = "Select E.Name, E.UserName, ISNULL(E.BaseSalary,0)'Base Salary', D.Description 'Department' from tblEmployee AS E INNER JOIN tbldepartement AS D ON E.departmentID = D.departmentID Where E.name like '%" & search & "%' Or E.Username like '%" & search & "%' ORDER BY description,name,Username"
        Else
            strReq = "Select E.Name, E.UserName, ISNULL(E.BaseSalary,0) 'Base Salary', D.Description 'Department' from tblEmployee AS E INNER JOIN tbldepartement AS D ON E.departmentID = D.departmentID ORDER BY description,name,Username"
        End If

        cmdTable = New SqlCommand(strReq, dbConn)
        sqlAdapter = New SqlDataAdapter(cmdTable)
        sqlAdapter.Fill(dtTable)
        Me.DataGrid1.DataSource = dtTable
        Me.DataGrid1.DataBind()

        For Each gridrow In DataGrid1.Items
            txbox = gridrow.Cells(3).FindControl("TextBox2")
            gridrow.Cells(0).Text = intcompteur + 1
            gridrow.Cells(1).Text = dtTable.Rows(intcompteur).Item(0)
            gridrow.Cells(2).Text = dtTable.Rows(intcompteur).Item(1)
            txbox.Text = Format(dtTable.Rows(intcompteur).Item(2), "#,##0;-#,##0;")
            txbox.Enabled = False
            gridrow.Cells(4).Text = dtTable.Rows(intcompteur).Item(3)
            intcompteur += 1
        Next
    End Sub

    Private Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        If Me.RadioButtonList1.SelectedItem.Text = "Add" Then
            getemployeesAD(Me.TextBox1.Text)
        ElseIf Me.RadioButtonList1.SelectedItem.Text = "Edit" Then
            getemployeesSQL(Me.TextBox1.Text)
        End If
    End Sub

    Private Sub RadioButtonList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonList1.SelectedIndexChanged
        If Me.RadioButtonList1.SelectedItem.Text = "Add" Then
            getemployeesAD("")
        ElseIf Me.RadioButtonList1.SelectedItem.Text = "Edit" Then
            getemployeesSQL("")
        End If
    End Sub

    Private Sub DataGrid1_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles DataGrid1.ItemCommand
        Dim bnt As Button
        Dim txbox As TextBox
        bnt = e.Item.Cells(0).FindControl("Button3")
        Dim str(6) As String

        txbox = e.Item.Cells(3).FindControl("TextBox2")

        If e.CommandName = "Editt" Then
            bnt.Text = "Save"
            bnt.CommandName = "Save"

            txbox.Enabled = True


        ElseIf e.CommandName = "Save" Then
            bnt.Text = "Edit"
            bnt.CommandName = "Editt"
            txbox.Enabled = False
        End If
    End Sub

End Class
