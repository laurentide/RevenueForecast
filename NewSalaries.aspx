<%@ Page Language="vb" AutoEventWireup="false" Codebehind="NewSalaries.aspx.vb" Inherits="RevenueForecast.NewSalaries"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>NewSalaries</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body background="bk6.jpg" MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:datagrid id="DataGrid1" style="Z-INDEX: 101; LEFT: 48px; POSITION: absolute; TOP: 128px"
				runat="server" AutoGenerateColumns="False" Width="786px" BorderColor="#336666" BorderStyle="Double"
				BorderWidth="3px" BackColor="White" CellPadding="4" GridLines="Horizontal" ShowFooter="True">
				<FooterStyle HorizontalAlign="Center" ForeColor="Black" BackColor="Gainsboro"></FooterStyle>
				<SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#339966"></SelectedItemStyle>
				<ItemStyle HorizontalAlign="Center" ForeColor="Black" BackColor="WhiteSmoke"></ItemStyle>
				<HeaderStyle Font-Bold="True" HorizontalAlign="Center" ForeColor="White" BackColor="#336666"></HeaderStyle>
				<Columns>
					<asp:BoundColumn HeaderText="Projected employee"></asp:BoundColumn>
					<asp:TemplateColumn HeaderText="Position">
						<FooterTemplate>
							<asp:TextBox id="TextBox4" runat="server" Width="112px"></asp:TextBox>
						</FooterTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Base salary">
						<FooterTemplate>
							<asp:Label id="Label1" runat="server">$</asp:Label>
							<asp:TextBox id="TextBox1" runat="server" Width="80px">0</asp:TextBox>
						</FooterTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="RRSP">
						<FooterTemplate>
							<asp:Label id="Label2" runat="server">$</asp:Label>
							<asp:TextBox id="TextBox2" runat="server" Width="88px">0</asp:TextBox>
						</FooterTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Points">
						<FooterTemplate>
							<asp:TextBox id="TextBox3" runat="server" Width="48px">0</asp:TextBox>
						</FooterTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Add/Delete">
						<ItemTemplate>
							<asp:Button id="Button4" runat="server" Text="Delete" CommandName="Delete"></asp:Button>
						</ItemTemplate>
						<FooterTemplate>
							<asp:Button id="Button2" runat="server" Text="Add" CommandName="Add"></asp:Button>
						</FooterTemplate>
					</asp:TemplateColumn>
					<asp:BoundColumn HeaderText="ID"></asp:BoundColumn>
				</Columns>
				<PagerStyle HorizontalAlign="Center" ForeColor="White" BackColor="#336666" Mode="NumericPages"></PagerStyle>
			</asp:datagrid><asp:button id="Button1" style="Z-INDEX: 102; LEFT: 8px; POSITION: absolute; TOP: 8px" runat="server"
				Text="Back"></asp:button>
			<asp:Label id="Label3" style="Z-INDEX: 103; LEFT: 312px; POSITION: absolute; TOP: 40px" runat="server"
				Width="336px" ForeColor="DimGray" Font-Names="Elephant" Font-Size="XX-Large" Font-Underline="True">New Salaries</asp:Label>
			<asp:Image id="Image1" style="Z-INDEX: 104; LEFT: 856px; POSITION: absolute; TOP: 8px" runat="server"
				ImageUrl="LCL.jpg"></asp:Image></form>
	</body>
</HTML>
