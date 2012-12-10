'REVENUE FORECAST
'GL
'description: Ce formulaire s'occupe de la gestion des commentaires/aide pour les codes GL
'Par: Francis Gauthier
'date: 27 juillet 2007
'contact: f.gauthier@cgodin.qc.ca

Imports System.Data.SqlClient
Public Class GL
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Button1 As System.Web.UI.WebControls.Button
    Protected WithEvents TextBox1 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Button2 As System.Web.UI.WebControls.Button
    Protected WithEvents Label1 As System.Web.UI.WebControls.Label
    Protected WithEvents DataGrid1 As System.Web.UI.WebControls.DataGrid
    Protected WithEvents Label2 As System.Web.UI.WebControls.Label
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


        struser = Request.ServerVariables("LOGON_user").Substring(Request.ServerVariables("LOGON_user").IndexOf("\") + 1, Request.ServerVariables("LOGON_user").Length - (Request.ServerVariables("LOGON_user").IndexOf("\") + 1))
        If EstAdmin(struser) = False Then
            Response.Redirect("Denied.html")
        Else

            dtTable = getGL()
            Me.DataGrid1.DataSource = dtTable
            If Not IsPostBack Then
                Me.Label2.Style("text-align") = "center"
                Me.Label2.Text = "Choose a GL code..."
                Affiche(dtTable)
            End If
        End If

    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Response.Redirect("Manager.aspx")
    End Sub
    Private Sub save(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        Dim strReq As String
        Dim dtTable As New DataTable

        If Not Me.DataGrid1.SelectedItem Is Nothing Then
            strReq = "UPDATE tblGL SET Help = '" & setGuillemets(Me.TextBox1.Text) & "' Where GL ='" & Me.DataGrid1.SelectedItem.Cells(0).Text & "'"
            EcritureBD(strReq)
            dtTable = getGL()
            Affiche(dtTable)
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

        'Le Fameux curseur
        strReq = "EXEC prGeneral null"

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

                dtTabble2.Rows.Add(row2)
            Next
        Next
        Return dtTabble2
    End Function

    Private Sub DataGrid1_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles DataGrid1.ItemCommand
        Dim strReq As String
        Dim dtTable As New DataTable
        Dim intcompteur As Integer = 0
        Dim gridrow As DataGridItem
        Dim txbox As TextBox

        'Affichage du help
        If e.CommandName = "View" Then
            Me.DataGrid1.SelectedIndex = e.Item.ItemIndex

            strReq = "Select help from tblGL Where GL ='" & e.Item.Cells(0).Text & "'"
            dtTable = LectureBD(strReq)
            Me.Label2.Text = e.Item.Cells(1).Text
            Me.TextBox1.Text = dtTable.Rows(0).Item(0)

        End If
    End Sub

    Private Sub Affiche(ByVal dtTable As DataTable)
        Me.DataGrid1.DataBind()
        Dim gridrow As DataGridItem
        Dim iCompteur As Integer = 0

        For Each gridrow In DataGrid1.Items

            gridrow.Cells(0).Text = dtTable.Rows(iCompteur).Item(0)
            gridrow.Cells(2).Text = dtTable.Rows(iCompteur).Item(2)
            gridrow.Cells(1).Text = dtTable.Rows(iCompteur).Item(1)

            If gridrow.Cells(0).Text.EndsWith(".") = False And gridrow.Cells(0).Text.Trim <> "VARIOUS" Then

                Dim bnt As Button
                bnt = gridrow.Cells(3).FindControl("Button3")
                bnt.Visible = False
                gridrow.Cells(0).Text = ""
                gridrow.Cells(2).Text = ""
                gridrow.Cells(1).Font.Bold = True
                gridrow.Cells(1).Font.Underline = True
                gridrow.BackColor = Color.Gainsboro

            End If

            If CType(dtTable.Rows(iCompteur).Item(2), String).Length = 20 Then
                gridrow.Cells(2).Text = dtTable.Rows(iCompteur).Item(2) & "..."
            End If

            iCompteur += 1
        Next

    End Sub
End Class
