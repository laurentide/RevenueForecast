<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CapitalExpenditure.aspx.vb" Inherits="RevenueForecast.CapitalExpenditure1"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>CapitalExpenditure</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body background="bk6.jpg" MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:button id="Button1" style="Z-INDEX: 101; LEFT: 8px; POSITION: absolute; TOP: 8px" runat="server"
				Text="Back"></asp:button><asp:label id="Label1" style="Z-INDEX: 102; LEFT: 248px; POSITION: absolute; TOP: 56px" runat="server"
				Width="496px" ForeColor="DimGray" Font-Names="Elephant" Font-Size="XX-Large" Font-Underline="True">Capital Expenditure</asp:label><asp:datagrid id="DataGrid1" style="Z-INDEX: 103; LEFT: 8px; POSITION: absolute; TOP: 152px" runat="server"
				Width="715px" ShowFooter="True" AutoGenerateColumns="False" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" BackColor="White" CellPadding="4" GridLines="Horizontal">
				<FooterStyle HorizontalAlign="Center" ForeColor="Black" BackColor="Gainsboro"></FooterStyle>
				<SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#339966"></SelectedItemStyle>
				<ItemStyle HorizontalAlign="Center" ForeColor="Black" BackColor="WhiteSmoke"></ItemStyle>
				<HeaderStyle Font-Bold="True" HorizontalAlign="Center" ForeColor="White" BackColor="#336666"></HeaderStyle>
				<Columns>
					<asp:BoundColumn HeaderText="CAPITAL EXPENDITURE" FooterText="TOTAL CAPITAL"></asp:BoundColumn>
					<asp:BoundColumn HeaderText="%"></asp:BoundColumn>
					<asp:BoundColumn HeaderText="Capital"></asp:BoundColumn>
					<asp:BoundColumn HeaderText="Depreciation"></asp:BoundColumn>
					<asp:TemplateColumn HeaderText="Details">
						<ItemTemplate>
							<asp:Button id="Button4" runat="server" Text="Details" CommandName="Details"></asp:Button>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
				<PagerStyle HorizontalAlign="Center" ForeColor="White" BackColor="#336666" Mode="NumericPages"></PagerStyle>
			</asp:datagrid>
			<asp:ImageButton id="ImageButton1" style="Z-INDEX: 104; LEFT: 760px; POSITION: absolute; TOP: 16px"
				runat="server" Width="2px" ImageUrl="bk6.jpg" Height="8px"></asp:ImageButton>
			<asp:Image id="Image1" style="Z-INDEX: 105; LEFT: 856px; POSITION: absolute; TOP: 8px" runat="server"
				ImageUrl="LCL.jpg"></asp:Image>
			<asp:Button id="cmdRefresh" style="Z-INDEX: 106; LEFT: 64px; POSITION: absolute; TOP: 8px" runat="server"
				Text="Refresh" OnClick="cmdRefresh_Click"></asp:Button></form>
	</body>
</HTML>
