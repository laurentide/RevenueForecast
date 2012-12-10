'REVENUE FORECAST
'Components
'description: Ce formulaire "pop up" savegarde tous les dépenses de chaque détails d'un budget
'Par: Francis Gauthier
'date: 27 juillet 2007
'contact: f.gauthier@cgodin.qc.ca

Public Class Components
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents DataGrid1 As System.Web.UI.WebControls.DataGrid
    Protected WithEvents PageY As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents PageX As System.Web.UI.HtmlControls.HtmlInputHidden

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

        'Affichage data et du titre de la dépense
        Response.Write("<title>" + CType(Session("Expense"), String) + "</title>")
        dtTable = getData()
        DataGrid1.DataSource = dtTable
        If Not IsPostBack Then
            Affiche(dtTable)
        End If
    End Sub

    Private Sub DataGrid1_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles DataGrid1.ItemCommand
        Dim strReq As String
        Dim textboxCost As TextBox
        Dim textboxDescription As TextBox
        Dim dtTable As New DataTable


        If e.CommandName = "Add" Then
            textboxCost = e.Item.Cells(1).FindControl("TextBox2")
            textboxDescription = e.Item.Cells(0).FindControl("TextBox4")

            strReq = "INSERT INTO tblComponents VALUES(" & Session("DetailID") & "," & CDbl(Isnull(textboxCost.Text)) & ",'" & setGuillemets(textboxDescription.Text) & "',0,0,0)"

             EcritureBD(strReq)
            dtTable = getData()
            DataGrid1.DataSource = dtTable
            Affiche(dtTable)
            'Refresh
            Response.Write("<script>window.opener.document.getElementById(""ImageButton1"").click();</script>")
        ElseIf e.CommandName = "Delete" Then

            If e.Item.ItemIndex = Me.DataGrid1.EditItemIndex Then
                Me.DataGrid1.EditItemIndex = -1

            ElseIf Me.DataGrid1.EditItemIndex > e.Item.ItemIndex Then
                Me.DataGrid1.EditItemIndex -= 1
            End If
            strReq = "DELETE FROM tblComponents Where ComponentID = " & e.Item.Cells(3).Text
            EcritureBD(strReq)
            dtTable = getData()
            DataGrid1.DataSource = dtTable
            Affiche(dtTable)
            'Refresh
            Response.Write("<script>opener.document.getElementById(""ImageButton1"").click();</script>")

        ElseIf e.CommandName = "Edit" And Me.DataGrid1.EditItemIndex = -1 Then
            Me.DataGrid1.EditItemIndex = e.Item.ItemIndex

            dtTable = getData()
            DataGrid1.DataSource = dtTable
            Affiche(dtTable)

        ElseIf e.CommandName = "Done" Then
            Dim btn As Button
            Dim txtbox As TextBox
            Me.DataGrid1.EditItemIndex = -1


            txtbox = e.Item.FindControl("TextBox3")
            strReq = "UPDATE tblComponents SET description='" & setGuillemets(txtbox.Text) & "',Montant="
            txtbox = e.Item.FindControl("TextBox1")

            strReq += CDbl(Isnull(txtbox.Text)) & " Where ComponentID = " & e.Item.Cells(3).Text
            EcritureBD(strReq)

            dtTable = getData()
            DataGrid1.DataSource = dtTable
            Affiche(dtTable)
            'Refresh
            Response.Write("<script>opener.document.getElementById(""ImageButton1"").click();</script>")

        ElseIf e.CommandName = "end" Then
            'close pop up
            Response.Write("<script language='javascript'> { self.close() }</script>")
        End If
    End Sub

    Private Sub Affiche(ByVal dtTable As DataTable)
        Dim gridrow As DataGridItem
        Dim iCompteur As Integer = 0
        Dim lbl As Label
        Dim txtbox As TextBox

        Me.DataGrid1.Columns(3).Visible = False
        DataGrid1.DataBind()
        For Each gridrow In DataGrid1.Items
            If gridrow.ItemIndex <> Me.DataGrid1.EditItemIndex Then
                lbl = gridrow.FindControl("Label4")
                lbl.Text = dtTable.Rows(iCompteur).Item(0)
                lbl = gridrow.FindControl("Label3")
                lbl.Text = Format(dtTable.Rows(iCompteur).Item(1), "$#,##0;-$#,##0;")
                lbl.Style("text-align") = "right"

            Else
                Dim btn As Button
                txtbox = gridrow.FindControl("TextBox3")
                txtbox.Text = dtTable.Rows(iCompteur).Item(0)
                txtbox = gridrow.FindControl("TextBox1")
                txtbox.Text = Format(dtTable.Rows(iCompteur).Item(1), "#,##0;-#,##0;")

                btn = gridrow.FindControl("Button4")
                btn.Text = "Done"
                btn.CommandName = "Done"
            End If
            gridrow.Cells(3).Text = dtTable.Rows(iCompteur).Item(2)
            iCompteur += 1
        Next
    End Sub

    Private Function getData() As DataTable
        Dim strReq As String
        Dim dtTable As New DataTable
       
        strReq = "Select Description, Montant, ComponentID FROM tblComponents Where DetailID = " + CType(Session("DetailID"), String)
        dtTable = LectureBD(strReq)

        Return dtTable
    End Function
End Class
