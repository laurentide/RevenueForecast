
'REVENUE FORECAST
'Managers
'description: Ce formulaire s'occupe de la gestion des gérant, seul les administrateur y ont droit
'Par: Francis Gauthier
'date: 27 juillet 2007
'contact: f.gauthier@cgodin.qc.ca

Imports System.Data
Imports System.Web.UI.WebControls
Public Class Managers
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Label2 As System.Web.UI.WebControls.Label
    Protected WithEvents Label3 As System.Web.UI.WebControls.Label
    Protected WithEvents Dropdownlist1 As System.Web.UI.WebControls.DropDownList
    Protected WithEvents ListBox1 As System.Web.UI.WebControls.ListBox
    Protected WithEvents ListBox2 As System.Web.UI.WebControls.ListBox
    Protected WithEvents Button1 As System.Web.UI.WebControls.Button
    Protected WithEvents Button2 As System.Web.UI.WebControls.Button
    Protected WithEvents Label4 As System.Web.UI.WebControls.Label
    Protected WithEvents Label5 As System.Web.UI.WebControls.Label
    Protected WithEvents Button3 As System.Web.UI.WebControls.Button

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
        Dim dtTable2 As New DataTable
      
        Dim struser As String


        struser = Request.ServerVariables("LOGON_user").Substring(Request.ServerVariables("LOGON_user").IndexOf("\") + 1, Request.ServerVariables("LOGON_user").Length - (Request.ServerVariables("LOGON_user").IndexOf("\") + 1))

        'Changer pour le compte de Dean
        If struser <> "DeanW" And struser <> "ClaireD" And struser <> "d2dadmin" Then
            Response.Redirect("Denied.html")
        Else

            strReq = "Select * from tbldepartement ORDER BY description"

            dtTable = LectureBD(strReq)

            strReq = "Select name from tblemployee where name not like '(Projected employees)' ORDER BY name"

            dtTable2 = LectureBD(strReq)

            'Affichage départements et de tous les employés
            If Not IsPostBack Then

                Me.Dropdownlist1.Items.Add(New ListItem("Choose department..."))
                For i As Int16 = 0 To dtTable.Rows.Count - 1
                    Me.Dropdownlist1.Items.Add(New ListItem(dtTable.Rows(i).Item(1)))
                Next
                Me.Dropdownlist1.SelectedIndex = 0

                For i As Int16 = 0 To dtTable2.Rows.Count - 1
                    Me.ListBox2.Items.Add(New ListItem(dtTable2.Rows(i).Item(0)))
                Next
                Me.ListBox2.SelectedIndex = 0
                Me.Dropdownlist1.SelectedIndex = 0
                getManagers(Me.Dropdownlist1.Items(0).Text)
            End If
        End If
    End Sub

    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button3.Click
        Response.Redirect("Manager.aspx")
    End Sub

    Private Sub Dropdownlist1_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Dropdownlist1.SelectedIndexChanged
        getManagers(Me.Dropdownlist1.SelectedItem.Text)
        Me.Dropdownlist1.Items.Remove("Choose department...")
    End Sub

    Private Sub getManagers(ByVal departement As String)
        Dim strReq As String
        Dim dtTable As New DataTable
        Dim intcompteur As Integer = 0
        Dim gridrow As DataGridItem
        Dim txbox As TextBox

        'get data
        strReq = "Select E.name From tblManager AS M INNER JOIN tblEmployee AS E ON M.employeeID=E.employeeID INNER JOIN tblDepartement AS D ON M.departmentID = D.departmentID Where d.description like '" & departement & "'"

         dtTable = LectureBD(strReq)
        'Affiche les managers
        Me.ListBox1.Items.Clear()
        For i As Int16 = 0 To dtTable.Rows.Count - 1
            Me.ListBox1.Items.Add(New ListItem(dtTable.Rows(i).Item(0)))
        Next
        Me.ListBox1.SelectedIndex = 0
    End Sub

    Private Sub Add(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click

        If Not Me.ListBox2.SelectedItem Is Nothing Then
            If Not Me.ListBox1.Items.Contains(Me.ListBox2.SelectedItem) And Me.Dropdownlist1.SelectedItem.Text <> "Choose department..." Then
                callprocedure("insert", setGuillemets(Me.ListBox2.SelectedItem.Text))
                Me.ListBox1.Items.Add(Me.ListBox2.SelectedItem.Text)
                Me.ListBox1.SelectedIndex = Me.ListBox1.Items.Count - 1
            End If
        End If

    End Sub

    Private Sub Del(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click

        If Not Me.ListBox1.SelectedItem Is Nothing Then
            callprocedure("delete", setGuillemets(Me.ListBox1.SelectedItem.Text))
            Me.ListBox1.Items.Remove(Me.ListBox1.SelectedItem.Text)
            Me.ListBox1.SelectedIndex = 0
        End If
    End Sub

    Private Sub callprocedure(ByVal operation As String, ByVal name As String)
        Dim strReq As String
        strReq = "EXEC dbo.prManagers '" & name & "','" & Me.Dropdownlist1.SelectedItem.Text & "','" & operation & "'"

        EcritureBD(strReq)
    End Sub
End Class
