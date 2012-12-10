'REVENUE FORECAST
'PopUp
'description: Ce formulaire "Pop Up" est un calendrier pour ajouter la date de travel/training
'Par: Francis Gauthier
'date: 27 juillet 2007
'contact: f.gauthier@cgodin.qc.ca

Imports System.Web.UI.HtmlControls.HtmlGenericControl
Public Class PopUp
    Inherits System.Web.UI.Page
    Protected WithEvents Button1 As System.Web.UI.WebControls.Button

    Protected WithEvents calDate As System.Web.UI.WebControls.Calendar

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        calDate.SelectedDate = Session("Date")
    End Sub

    Protected Sub Change_Date(ByVal sender As System.Object, ByVal e As System.EventArgs)
        
        Session("Date") = calDate.SelectedDate.ToString("MM/dd/yyyy")
        Response.Write("<script>window.opener.document.getElementById(""ImageButton1"").click();</script>")

    End Sub

    Protected Sub Close(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Response.Write("<script language='javascript'> { self.close() }</script>")
    End Sub

    Private Sub InitializeComponent()

    End Sub
End Class