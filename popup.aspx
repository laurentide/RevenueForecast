<%@ Page Language="vb" AutoEventWireup="false" Codebehind="popup.aspx.vb" Inherits="RevenueForecast.PopUp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Calendar</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body background="bk5.jpg" MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:calendar id="calDate" BorderColor="Black" BorderWidth="2px" BorderStyle="Double" Runat="server"
				OnSelectionChanged="Change_Date">
				<DayStyle BackColor="WhiteSmoke"></DayStyle>
				<NextPrevStyle Font-Size="Larger" Font-Bold="True" ForeColor="White" BackColor="Transparent"></NextPrevStyle>
				<DayHeaderStyle BackColor="Gainsboro"></DayHeaderStyle>
				<SelectedDayStyle Font-Underline="True" Font-Bold="True" ForeColor="White" BackColor="#336666"></SelectedDayStyle>
				<TitleStyle Font-Bold="True" ForeColor="White" BackColor="#336666"></TitleStyle>
			</asp:calendar><asp:button id="Button1" style="Z-INDEX: 101; LEFT: 112px; POSITION: absolute; TOP: 208px" onclick="Close"
				runat="server" Text="Done"></asp:button></form>
	</body>
</HTML>
