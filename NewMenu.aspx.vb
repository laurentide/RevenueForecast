Public Class WebForm2

    Inherits System.Web.UI.Page



#Region " Web Form Designer Generated Code "



    'This call is required by the Web Form Designer.

    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Protected WithEvents LabelTitle As System.Web.UI.WebControls.Label

    Protected WithEvents DataGrid1 As System.Web.UI.WebControls.DataGrid

    Protected WithEvents ButtonSample As System.Web.UI.WebControls.Button

    Protected WithEvents txtExpandedDivs As System.Web.UI.WebControls.TextBox

    Protected WithEvents LabelWhatHappens As System.Web.UI.WebControls.Label

    Protected WithEvents LabelPostBack As System.Web.UI.WebControls.Label
    Protected WithEvents ListBox1 As System.Web.UI.WebControls.ListBox
    Protected WithEvents Label1 As System.Web.UI.WebControls.Label
    Protected WithEvents ListBox2 As System.Web.UI.WebControls.ListBox
    Protected WithEvents Label2 As System.Web.UI.WebControls.Label
    Protected WithEvents Label3 As System.Web.UI.WebControls.Label
    Protected WithEvents Label4 As System.Web.UI.WebControls.Label
    Protected WithEvents Button1 As System.Web.UI.WebControls.Button
    Protected WithEvents Button2 As System.Web.UI.WebControls.Button
    Protected WithEvents Image1 As System.Web.UI.WebControls.Image
    Protected WithEvents Datagrid2 As System.Web.UI.WebControls.DataGrid



    'NOTE: The following placeholder declaration is required by the Web Form Designer.

    'Do not delete or move it.

    Private designerPlaceholderDeclaration As System.Object



    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) _
         Handles MyBase.Init

        'CODEGEN: This method call is required by the Web Form Designer

        'Do not modify it using the code editor.



        InitializeComponent()



    End Sub



#End Region



    Dim connectionstring = "Server=localhost;uid=LCLADMIN;password=test;database=LCLAdmin"



    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) _
         Handles MyBase.Load



        'Clear the contents of the Label 

        Me.LabelPostBack.Text = ""



        If Not Page.IsPostBack Then

            'Bind Master Details 

            BindData()

        Else

            For i As Integer = 0 To Me.DataGrid1.Items.Count - 1

                'After Postback ID's get lost. Javascript will not work without it, 

                'so we must set them back. 

                Me.DataGrid1.Items(i).Cells(0).ID = "CellInfo" + i.ToString()

            Next



            'If it is a postback that is not from the grid, we have to expand the rows 

            'the user had expanded before. We have to check first who called this postback 

            'by checking the Event Target. The reason we check this, is because we don't 
            'need 

            'to expand if it is changing the page of the datagrid, or sorting, etc... 

            If Request("__EVENTTARGET") Is Nothing Then

                Return

            Else

                Dim strEventTarget As String = Request("__EVENTTARGET").ToString().ToLower()



                'datagrid1 is the name of the grid. If you modify the grid name, 

                'make sure to modify this if statement. 

                If strEventTarget.IndexOf("datagrid1") = -1 Then

                    If Not Page.IsStartupScriptRegistered("ShowDataJS") Then

                        Page.RegisterStartupScript("ShowDataJS", "<script>ShowExpandedDivInfo('" + Me.txtExpandedDivs.ClientID + "','" + Me.DataGrid1.ClientID + "');</script>")



                    End If

                End If



            End If

        End If

    End Sub



    Private Sub ButtonSample_Click(ByVal sender As System.Object, ByVal e As _
         System.EventArgs) Handles ButtonSample.Click



        LabelPostBack.ForeColor = System.Drawing.Color.DarkRed



        If (txtExpandedDivs.Text.Length = 0) Then

            LabelPostBack.Text = "A Postback has occurred. txtExpandedDivs has no content!"

        Else

            LabelPostBack.Text = "A Postback has occurred. txtExpandedDivs has contents: " + _
                "<BR/><B>" + txtExpandedDivs.Text + "</B>"

        End If

    End Sub



#Region "Database Methods"

    Private Sub BindData()



        '==========Query For Master Rows================== 

        Dim QueryString As String = "Select E.name,B.Year,D.description, B.date, ISNULL((SELECT sum(C.Montant) " & _
                                    "FROM tblComponents AS C INNER JOIN tblBudgetDetails AS DD ON C.detailID = DD.detailID " & _
                                    "INNER JOIN tblGL AS G ON DD.nogl = G.gl Where DD.BudgetID = B.budgetID AND g.catID = 1),0) - ISNULL((SELECT sum(C.Montant) " & _
                                    "FROM tblComponents AS C INNER JOIN tblBudgetDetails AS DD ON C.detailID = DD.detailID INNER JOIN tblGL AS G ON DD.nogl = G.gl " & _
                                    "Where DD.BudgetID = B.budgetID AND g.catID between 2 and 6),0) - " & _
                                    "ISNULL((SELECT isnull(sum(T.costofcourse),0) + isnull(sum(T.fares),0) + isnull(sum(T.meals),0) " & _
                                    "+ isnull(sum(T.hotel),0) + isnull(sum(T.entertainment),0) + isnull(sum(T.carrental),0) FROM tblTravelBudget AS T INNER JOIN " & _
                                    "tblBudget AS BB ON T.budgetID = BB.budgetID Where T.BudgetID = B.budgetID),0) 'Total' from tblBudget AS B INNER JOIN tblemployee AS E ON B.creator = E.employeeid INNER JOIN tblDepartement AS D ON B.departmentid = D.departmentid where B.departmentid IN (SELECT M.departmentid FROM tblManager AS M INNER JOIN tblemployee AS E ON M.employeeId = E.employeeID) "

        If ViewState("sortby") Is Nothing Then

            QueryString = QueryString + " "

        Else

            QueryString = QueryString + " order by " + ViewState("sortby").ToString()

        End If

        '================================================= 



        Dim conn As New System.Data.SqlClient.SqlConnection

        Try

            conn.ConnectionString = connectionstring

            If conn.State = System.Data.ConnectionState.Closed Then

                conn.Open()

            End If



            Dim adapter As New System.Data.SqlClient.SqlDataAdapter(QueryString, conn)

            Dim ds As New DataSet

            adapter.Fill(ds)

            DataGrid1.DataSource = ds



            DataGrid1.DataBind()

        Catch ex1 As Exception

            Response.Write("An error has occurred: ")

            Response.Write(ex1.Message.ToString())

            Response.End()

        Finally

            If conn.State = System.Data.ConnectionState.Open Then

                conn.Close()

            End If

        End Try

    End Sub



    Private Function RunQuery(ByVal QueryString As String) As DataSet

        Dim conn As New System.Data.SqlClient.SqlConnection



        Try

            conn.ConnectionString = connectionstring

            If conn.State = System.Data.ConnectionState.Closed Then

                conn.Open()

            End If



            Dim adapter As New System.Data.SqlClient.SqlDataAdapter(QueryString, conn)

            Dim ds As New DataSet

            adapter.Fill(ds)

            Return ds

        Catch ex1 As Exception

            Response.Write("An Error has occurred.<BR />")

            Response.Write(ex1.Message.ToString())

            Response.[End]()

            'This line below will never execute. 

            Return Nothing

        Finally

            If conn.State = System.Data.ConnectionState.Open Then

                conn.Close()

            End If

        End Try

    End Function

#End Region



#Region "Datagrid Methods"

    Private Sub DataGrid1_ItemDataBound(ByVal sender As System.Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles DataGrid1.ItemDataBound

        'If your page size is 10, only 10 sub queries will be done. 

        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then



            Dim DetailsQuery As String = ""





            'Here I am grabbing the additional data and putting it into mini datagrids... 

            'If you wish to just use labels, or other controls, just bind the data as you 

            'wish, and render to html as I did. 

            Dim ds As DataSet = Me.RunQuery(DetailsQuery)

            Dim NewDg As New DataGrid

            NewDg.AutoGenerateColumns = True

            NewDg.Width = Unit.Percentage(100)

            NewDg.DataSource = ds

            NewDg.DataBind()



            SetProps(NewDg)



            Dim sw As New System.IO.StringWriter

            Dim htw As New System.Web.UI.HtmlTextWriter(sw)

            NewDg.RenderControl(htw)



            Dim DivStart As String = "<DIV id='uniquename" + e.Item.ItemIndex.ToString(+"' style='DISPLAY: none;'>")



            Dim DivBody As String = sw.ToString()

            Dim DivEnd As String = "</DIV>"

            Dim FullDIV As String = DivStart + DivBody + DivEnd



            Dim LastCellPosition As Integer = e.Item.Cells.Count - 1

            Dim NewCellPosition As Integer = e.Item.Cells.Count - 2



            e.Item.Cells(0).ID = "CellInfo" + e.Item.ItemIndex.ToString()



            If e.Item.ItemType = ListItemType.Item Then

                e.Item.Cells(LastCellPosition).Text() = e.Item.Cells(LastCellPosition).Text + "</td><tr><td bgcolor='f5f5f5'></td><td colspan='" + _
                NewCellPosition.ToString(+"'>" + FullDIV)

            Else

                e.Item.Cells(LastCellPosition).Text = e.Item.Cells(LastCellPosition).Text + "</td><tr><td bgcolor='d3d3d3'></td><td colspan='" + _
                NewCellPosition.ToString(+"'>" + FullDIV)

            End If



            e.Item.Cells(0).Attributes("onclick") = "HideShowPanel('uniquename" + _
               e.Item.ItemIndex.ToString() + "'); ChangePlusMinusText('" + _
               e.Item.Cells(0).ClientID + "'); SetExpandedDIVInfo('" + _
               e.Item.Cells(0).ClientID + "','" + Me.txtExpandedDivs.ClientID + _
               "', 'uniquename" + e.Item.ItemIndex.ToString() + "');"



            e.Item.Cells(0).Attributes("onmouseover") = "this.style.cursor='pointer'"

            e.Item.Cells(0).Attributes("onmouseout") = "this.style.cursor='pointer'"

        End If

    End Sub



    Private Sub DataGrid1_PageIndexChanged(ByVal source As System.Object, ByVal e As _
         System.Web.UI.WebControls.DataGridPageChangedEventArgs) _
         Handles DataGrid1.PageIndexChanged



        'clean up expanded records. 

        Me.txtExpandedDivs.Text = ""

        DataGrid1.CurrentPageIndex = e.NewPageIndex

        BindData()

    End Sub



    Private Sub DataGrid1_SortCommand(ByVal source As System.Object, ByVal e As _
            System.Web.UI.WebControls.DataGridSortCommandEventArgs) _
            Handles DataGrid1.SortCommand



        Me.txtExpandedDivs.Text = ""

        Dim sortby As String = "[" + e.SortExpression + "]"



        If ViewState("sortby") Is Nothing Then

            sortby = sortby + " ASC"

            ViewState("sortby") = sortby

            BindData()

        Else

            If ViewState("sortby").ToString() = sortby + " ASC" Then

                sortby = sortby + " DESC"

                ViewState("sortby") = sortby

                BindData()

            ElseIf ViewState("sortby").ToString() = sortby + " DESC" Then

                sortby = sortby + " ASC"

                ViewState("sortby") = sortby

                BindData()

            Else

                sortby = sortby + " ASC"

                ViewState("sortby") = sortby

                BindData()

            End If

        End If



    End Sub



    Public Sub SetProps(ByVal DG As System.Web.UI.WebControls.DataGrid)

        '*************************************************** 

        DG.Font.Size = System.Web.UI.WebControls.FontUnit.Parse("8")

        DG.Font.Bold = False

        DG.Font.Name = "tahoma"



        '*****************Professional 2*******************



        'Border Props 

        DG.GridLines = GridLines.Both

        DG.CellPadding = 3

        DG.CellSpacing = 0

        DG.BorderColor = System.Drawing.Color.FromName("#CCCCCC")

        DG.BorderWidth = System.Web.UI.WebControls.Unit.Pixel(1)





        'Header Props 

        DG.HeaderStyle.BackColor = System.Drawing.Color.SteelBlue

        DG.HeaderStyle.ForeColor = System.Drawing.Color.White

        DG.HeaderStyle.Font.Bold = True

        DG.HeaderStyle.Font.Size = System.Web.UI.WebControls.FontUnit.Parse("8")

        DG.HeaderStyle.Font.Name = "tahoma"



        DG.ItemStyle.BackColor = System.Drawing.Color.LightSteelBlue



    End Sub



#End Region



End Class
