<%@ Page Language="vb" AutoEventWireup="false" Codebehind="FYdetails.aspx.vb" Inherits="RevenueForecast.FYdetails"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>FYdetails</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body background="bk5.jpg" MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:datagrid id="DataGrid1" style="Z-INDEX: 101; LEFT: 0px; POSITION: absolute; TOP: 0px" runat="server"
				ForeColor="Black" Width="360px" ShowFooter="True" AutoGenerateColumns="False" GridLines="Horizontal"
				CellPadding="3" BackColor="White" BorderWidth="3px" BorderStyle="Double" BorderColor="#336666">
				<FooterStyle ForeColor="Black" BackColor="Gainsboro"></FooterStyle>
				<SelectedItemStyle Font-Bold="True" ForeColor="#F7F7F7" BackColor="#738A9C"></SelectedItemStyle>
				<AlternatingItemStyle BackColor="#F7F7F7"></AlternatingItemStyle>
				<ItemStyle ForeColor="Black" BackColor="WhiteSmoke"></ItemStyle>
				<HeaderStyle Font-Bold="True" HorizontalAlign="Center" ForeColor="White" BackColor="#336666"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn HeaderText="Description">
						<HeaderTemplate>
							<asp:Button id="Button1" runat="server" Text="Print" CommandName="Print"></asp:Button>
							<asp:Label id="Label1" runat="server" Width="160px">Description</asp:Label>
						</HeaderTemplate>
					</asp:TemplateColumn>
					<asp:BoundColumn HeaderText="Amount"></asp:BoundColumn>
				</Columns>
				<PagerStyle HorizontalAlign="Right" ForeColor="#4A3C8C" BackColor="#E7E7FF" Mode="NumericPages"></PagerStyle>
			</asp:datagrid></form>
	</body>
</HTML>
