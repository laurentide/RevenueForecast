<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Manager.aspx.vb" Inherits="RevenueForecast.Manager"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Manager</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body bgColor="#f0f8ff" background="bk6.jpg" MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:label id="Label3" style="Z-INDEX: 102; LEFT: 232px; POSITION: absolute; TOP: 64px" runat="server"
				Font-Size="Large" Font-Names="Elephant" Width="233px" ForeColor="DimGray">Current Manager: </asp:label>
			<asp:linkbutton id="Linkbutton5" style="Z-INDEX: 108; LEFT: 400px; POSITION: absolute; TOP: 392px"
				runat="server" ForeColor="Desktop" Font-Bold="True" Visible="False" tabIndex="10">- Managers</asp:linkbutton><asp:label id="Label6" style="Z-INDEX: 106; LEFT: 360px; POSITION: absolute; TOP: 272px" runat="server"
				Font-Bold="True" Font-Size="Medium" ForeColor="#336666" Font-Underline="True" Visible="False" tabIndex="5">-Administrative Tools</asp:label><asp:label id="Label4" style="Z-INDEX: 101; LEFT: 464px; POSITION: absolute; TOP: 64px" runat="server"
				Font-Size="Large" Width="345px" Font-Names="Elephant" ForeColor="DimGray" tabIndex="1"></asp:label><asp:linkbutton id="LinkButton1" style="Z-INDEX: 103; LEFT: 400px; POSITION: absolute; TOP: 152px"
				runat="server" Font-Bold="True" ForeColor="Desktop" tabIndex="3">·New Budget</asp:linkbutton><asp:linkbutton id="LinkButton2" style="Z-INDEX: 104; LEFT: 400px; POSITION: absolute; TOP: 176px"
				runat="server" Font-Bold="True" ForeColor="Desktop" tabIndex="4">·Edit/Delete/Consult</asp:linkbutton><asp:label id="Label5" style="Z-INDEX: 105; LEFT: 360px; POSITION: absolute; TOP: 120px" runat="server"
				Font-Bold="True" Font-Size="Medium" ForeColor="#336666" Font-Underline="True" tabIndex="2">-Budget Forecast</asp:label><asp:linkbutton id="LinkButton4" style="Z-INDEX: 107; LEFT: 400px; POSITION: absolute; TOP: 368px"
				runat="server" Font-Bold="True" ForeColor="Desktop" Visible="False" tabIndex="9">- Edit Employees</asp:linkbutton>
			<asp:LinkButton id="LinkButton6" style="Z-INDEX: 109; LEFT: 400px; POSITION: absolute; TOP: 344px"
				runat="server" Font-Bold="True" ForeColor="Desktop" Visible="False" tabIndex="8">- Reports</asp:LinkButton>
			<asp:LinkButton id="LinkButton7" style="Z-INDEX: 110; LEFT: 400px; POSITION: absolute; TOP: 296px"
				runat="server" Font-Bold="True" ForeColor="Desktop" Font-Underline="True" Visible="False" tabIndex="6">- General Budget</asp:LinkButton>
			<asp:LinkButton id="LinkButton3" style="Z-INDEX: 111; LEFT: 400px; POSITION: absolute; TOP: 320px"
				runat="server" Font-Bold="True" ForeColor="Desktop" Font-Underline="True" Visible="False" tabIndex="7">- GL codes</asp:LinkButton>
			<asp:Image id="Image1" style="Z-INDEX: 112; LEFT: 856px; POSITION: absolute; TOP: 8px" runat="server"
				ImageUrl="LCL.jpg"></asp:Image>
			<asp:LinkButton id="LinkButton8" style="Z-INDEX: 113; LEFT: 400px; POSITION: absolute; TOP: 200px"
				runat="server" ForeColor="Desktop" Font-Bold="True">-Adjustments</asp:LinkButton></form>
	</body>
</HTML>
