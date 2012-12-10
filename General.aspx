<%@ Page Language="vb" AutoEventWireup="false" Codebehind="General.aspx.vb" Inherits="RevenueForecast.General"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>General</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body background="bk6.jpg" MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:label id="Label1" style="Z-INDEX: 101; LEFT: 400px; POSITION: absolute; TOP: 88px" runat="server"
				Width="32px" Font-Bold="True">Year:</asp:label>
			<asp:label id="Label6" style="Z-INDEX: 105; LEFT: 280px; POSITION: absolute; TOP: 8px" runat="server"
				Font-Size="XX-Large" Font-Names="Elephant" BorderColor="Transparent" BackColor="Transparent"
				ForeColor="DimGray" Font-Underline="True">General Budget</asp:label><asp:datagrid id="DataGrid1" style="Z-INDEX: 102; LEFT: 8px; POSITION: absolute; TOP: 144px" runat="server"
				Width="950px" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" BackColor="White" CellPadding="4" GridLines="Horizontal" ShowFooter="True">
				<FooterStyle Font-Size="X-Small" HorizontalAlign="Center" ForeColor="Black" BackColor="Gainsboro"></FooterStyle>
				<SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#339966"></SelectedItemStyle>
				<ItemStyle Font-Size="X-Small" HorizontalAlign="Center" ForeColor="Black" BackColor="WhiteSmoke"></ItemStyle>
				<HeaderStyle Font-Size="Small" Font-Bold="True" HorizontalAlign="Center" ForeColor="White" BackColor="#336666"></HeaderStyle>
				<PagerStyle HorizontalAlign="Center" ForeColor="White" BackColor="#336666" Mode="NumericPages"></PagerStyle>
			</asp:datagrid><asp:dropdownlist id="DropDownList1" style="Z-INDEX: 103; LEFT: 440px; POSITION: absolute; TOP: 88px"
				runat="server" Width="120px" AutoPostBack="True"></asp:dropdownlist><asp:button id="Button1" style="Z-INDEX: 104; LEFT: 8px; POSITION: absolute; TOP: 8px" runat="server"
				Text="Menu"></asp:button>
			<asp:Button id="Button2" style="Z-INDEX: 106; LEFT: 576px; POSITION: absolute; TOP: 88px" runat="server"
				Text="Show months" Visible="False"></asp:Button>
			<asp:Image id="Image1" style="Z-INDEX: 107; LEFT: 856px; POSITION: absolute; TOP: 8px" runat="server"
				ImageUrl="LCL.jpg"></asp:Image></form>
	</body>
</HTML>
