'REVENUE FORECAST
'department
'description: Ce formulaire s'occupe de la gestion des employés
'Par: Francis Gauthier
'date: 27 juillet 2007
'contact: f.gauthier@cgodin.qc.ca

Imports System.Data
Imports System.Web.UI.WebControls
Public Class department
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents DataGrid1 As System.Web.UI.WebControls.DataGrid
    Protected WithEvents DropDownList1 As System.Web.UI.WebControls.DropDownList
    Protected WithEvents Label1 As System.Web.UI.WebControls.Label
    Protected WithEvents Label2 As System.Web.UI.WebControls.Label
    Protected WithEvents Button2 As System.Web.UI.WebControls.Button
    Protected WithEvents PageY As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents PageX As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents Button4 As System.Web.UI.WebControls.Button
    Protected WithEvents Button5 As System.Web.UI.WebControls.Button

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

        If struser <> "DeanW" And struser <> "ClaireD" And struser <> "d2dadmin" Then
            Response.Redirect("Denied.html")
        Else

            strReq = "Select * from tbldepartement ORDER BY description"

            dtTable = LectureBD(strReq)

            If Not IsPostBack Then
                Me.DropDownList1.Items.Add(New ListItem("Choose department..."))
                For i As Int16 = 0 To dtTable.Rows.Count - 1
                    Me.DropDownList1.Items.Add(New ListItem(dtTable.Rows(i).Item(1), dtTable.Rows(i).Item(0)))
                Next
                Me.DropDownList1.SelectedIndex = 0

            End If
            Me.Button5.Enabled = False
        End If

    End Sub
    Private Sub DropDownList1_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles DropDownList1.SelectedIndexChanged
        getEmployes(Me.DropDownList1.SelectedItem.Text)
        'empecher la saisie de lettres =)
        'txtbox.Attributes.Add("onKeyPress", "if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;")
        Me.DropDownList1.Items.Remove("Choose department...")
    End Sub

    Private Sub getEmployes(ByVal departement As String)
        Dim strReq As String
        Dim dtTable As New DataTable
        Dim intcompteur As Integer = 0
        Dim gridrow As DataGridItem
        Dim txbox As TextBox

        'Changer pour le compte de Dean

        strReq = "Select E.Name, E.UserName, ISNULL(E.BaseSalary,0) 'Base Salary', ISNULL(E.RRSP,0) 'RRSP', ISNULL(E.Points,0) 'Points', D.Description 'Department',E.EmployeeID from tblEmployee AS E INNER JOIN tbldepartement AS D ON E.departmentID = D.departmentID Where d.description like '" & departement & "' AND name not like '(Projected employees)' ORDER BY name"

        dtTable = LectureBD(strReq)
        Me.DataGrid1.DataSource = dtTable
        Me.DataGrid1.DataBind()

        For Each gridrow In DataGrid1.Items

            gridrow.Cells(0).Text = dtTable.Rows(intcompteur).Item(0)
            gridrow.Cells(1).Text = dtTable.Rows(intcompteur).Item(1)

            txbox = gridrow.Cells(2).FindControl("TextBox1")
            txbox.Text = Format(dtTable.Rows(intcompteur).Item(2), "#,##0;-#,##0;")
            txbox.Style("text-align") = "right"

            txbox = gridrow.Cells(4).FindControl("TextBox2")
            txbox.Text = Format(dtTable.Rows(intcompteur).Item(3), "#,##0;-#,##0;")
            txbox.Style("text-align") = "right"

            txbox = gridrow.Cells(5).FindControl("TextBox3")
            txbox.Text = Format(dtTable.Rows(intcompteur).Item(4), "#,##0;-#,##0;")
            txbox.Style("text-align") = "right"


            gridrow.Cells(6).Text = dtTable.Rows(intcompteur).Item(5)
            gridrow.Cells(8).Text = dtTable.Rows(intcompteur).Item(6)
            intcompteur += 1
        Next

    End Sub
    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        Response.Redirect("Manager.aspx")
    End Sub

    Private Sub DataGrid1_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles DataGrid1.ItemCommand
        Dim bnt As Button
        Dim txbox As TextBox
        Dim txbox2 As TextBox
        Dim txbox3 As TextBox
        Dim gridrow As DataGridItem
        Dim chkbox As CheckBox
        Dim strReq As String
        Dim pourcentage As TextBox
        Dim header As TextBox


        If e.CommandName = "Inc" Then

            txbox = e.Item.Cells(2).FindControl("TextBox1")
            txbox2 = e.Item.Cells(3).FindControl("TextBox2")
            txbox3 = e.Item.Cells(4).FindControl("TextBox3")
            For Each gridrow In DataGrid1.Items

                pourcentage = gridrow.FindControl("TextBox5")
                header = DataGrid1.Controls(0).Controls(0).FindControl("Textbox4")
                pourcentage.Text = CDbl(Isnull(header.Text))
            Next
        ElseIf e.CommandName = "Add" Then

            txbox = e.Item.Cells(0).FindControl("TextBox6")
            'txbox2 = e.Item.Cells(1).FindControl("TextBox7")
            If UCase(txbox.Text.Trim) Like "*, *" And UCase(txbox.Text.Trim) <> "LASTNAME, FIRSTNAME" Then

                txbox3 = e.Item.Cells(2).FindControl("TextBox8")
                strReq = "INSERT INTO tblemployee VALUES('" & setGuillemets(txbox.Text) & "','" & setGuillemets(txbox.Text.Substring(txbox.Text.IndexOf(" ") + 1, (txbox.Text.Length - 1) - txbox.Text.IndexOf(" ")) & txbox.Text.Substring(0, 1)) & "','" & Me.DropDownList1.SelectedItem.Value & "'," & CDbl(Isnull(txbox3.Text)) & ","

                txbox = e.Item.Cells(3).FindControl("TextBox11")

                strReq += "0," & CDbl(Isnull(txbox.Text)) & ")"
                EcritureBD(strReq)
                getEmployes(Me.DropDownList1.SelectedItem.Text)
            Else
                Dim strMSG As String
                strMSG = "<script language=Javascript>alert(""Invalid name format, The name format is 'Lastname, FirstName'"");</script>"
                Response.Write(strMSG)
            End If
        ElseIf e.CommandName = "Delete" Then
            'For all rows in grid 
            '   if checkbox is checked
            '       delete row from employee table
            '   end if
            'End for
            'Refresh datagrid
            For Each gridrow In DataGrid1.Items
                chkbox = gridrow.FindControl("chkDelete")
                If chkbox.Checked Then
                    strReq = "Delete From tblemployee Where name = '" & gridrow.Cells(0).Text & "'"
                    EcritureBD(strReq)
                End If
            Next
            getEmployes(Me.DropDownList1.SelectedItem.Text)
        End If
    End Sub

    'Private Sub saveSalary(ByVal name As String, ByVal user As String, ByVal montant As Double, ByVal RRSP As Double, ByVal Points As Integer)
    '    Dim strReq As String
    '    Dim gridrow As DataGridItem
    '    Dim txbox As TextBox

    '    strReq = "UPDATE tblemployee SET baseSalary = " & montant & ",RRSP = " & RRSP & ",Points=" & Points & " WHERE name LIKE '" & setGuillemets(name) & "' AND USERNAME LIKE '" & user & "'"
    '    EcritureBD(strReq)

    'End Sub

    Private Sub saveSalary(ByVal EmployeeID As Integer, ByVal montant As Double, ByVal RRSP As Double, ByVal Points As Integer)
        Dim strReq As String
        Dim gridrow As DataGridItem
        Dim txbox As TextBox

        strReq = "UPDATE tblemployee SET baseSalary = " & montant & ",RRSP = " & RRSP & ",Points=" & Points & " WHERE EmployeeID = " & EmployeeID
        EcritureBD(strReq)

    End Sub

    Private Sub Button5_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button5.Click
        Dim gridrow As DataGridItem
        Dim txbox As TextBox
        Dim txbox2 As TextBox
        Dim txbox3 As TextBox

        For Each gridrow In DataGrid1.Items
            txbox = gridrow.Cells(2).FindControl("TextBox1")
            txbox2 = gridrow.Cells(3).FindControl("TextBox2")
            txbox3 = gridrow.Cells(4).FindControl("TextBox3")

            saveSalary(CInt(gridrow.Cells(8).Text), CDbl(Isnull(txbox.Text)), CDbl(Isnull(txbox2.Text)), CDbl(Isnull(txbox3.Text)))
        Next
        Me.Button5.Enabled = False
    End Sub

    Private Sub Button4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button4.Click
        Dim gridrow As DataGridItem
        Dim txbox As TextBox
        Dim txbox2 As TextBox

        Dim pourcentage As TextBox

        For Each gridrow In DataGrid1.Items
            txbox = gridrow.Cells(2).FindControl("TextBox1")
            txbox2 = gridrow.Cells(3).FindControl("TextBox2")
            pourcentage = gridrow.Cells(4).FindControl("TextBox5")

            txbox2.Text = Format(CDbl(Isnull(txbox.Text)) * 0.01 * Val(pourcentage.Text), "#,##0;-#,##0;")
            If CDbl(Isnull(txbox2.Text)) > 3500 Then
                txbox2.Text = "3500"
            End If
        Next
        Me.Button5.Enabled = True
    End Sub
End Class
