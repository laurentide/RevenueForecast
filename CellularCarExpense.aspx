<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CellularCarExpense.aspx.vb" Inherits="RevenueForecast.CellularExpense"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>CellularExpense</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</HEAD>
	<body MS_POSITIONING="GridLayout" background="bk6.jpg">
		<form id="Form1" method="post" runat="server">
			<asp:Button id="Button1" style="Z-INDEX: 101; LEFT: 8px; POSITION: absolute; TOP: 8px" runat="server"
				Text="Back"></asp:Button>
			<asp:datagrid id="Datagrid1" style="Z-INDEX: 102; LEFT: 248px; POSITION: absolute; TOP: 144px"
				runat="server" AutoGenerateColumns="False" Width="561px" BorderColor="#336666" BorderStyle="Double"
				BorderWidth="3px" BackColor="Black" CellPadding="4" GridLines="Horizontal" ForeColor="Black"
				ShowFooter="True">
				<FooterStyle HorizontalAlign="Left" ForeColor="Black" BackColor="Gainsboro"></FooterStyle>
				<SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#339966"></SelectedItemStyle>
				<ItemStyle ForeColor="Black" BackColor="WhiteSmoke"></ItemStyle>
				<HeaderStyle Font-Bold="True" ForeColor="White" BackColor="#336666"></HeaderStyle>
				<Columns>
					<asp:BoundColumn HeaderText="Employee"></asp:BoundColumn>
					<asp:TemplateColumn HeaderText="Amount">
						<HeaderTemplate>
							<asp:Label id="Label1" runat="server">$</asp:Label>
							<asp:TextBox id="TextBox1" runat="server" Width="80px">0</asp:TextBox>
							<asp:Button id="Button2" runat="server" Text="V" CommandName="Amount"></asp:Button>
							<asp:Label id="Label3" runat="server">Amount</asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="Label2" runat="server">$</asp:Label>
							<asp:TextBox id="TextBox2" runat="server" Width="80px"></asp:TextBox>
							<asp:CheckBox id="CheckBox1" runat="server"></asp:CheckBox>
						</ItemTemplate>
						<FooterTemplate>
							<asp:Label id="Label4" runat="server" Width="90px"></asp:Label>
						</FooterTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Clear/Save">
						<HeaderTemplate>
							<asp:Button id="Button3" runat="server" Text="Clear" CommandName="Clear"></asp:Button>
						</HeaderTemplate>
						<FooterTemplate>
							<asp:Button id="Button4" runat="server" Text="Save" CommandName="Save"></asp:Button>
						</FooterTemplate>
					</asp:TemplateColumn>
				</Columns>
				<PagerStyle HorizontalAlign="Center" ForeColor="White" BackColor="#336666" Mode="NumericPages"></PagerStyle>
			</asp:datagrid>
			<asp:Label id="Label5" style="Z-INDEX: 103; LEFT: 248px; POSITION: absolute; TOP: 48px" runat="server"
				ForeColor="DimGray" Font-Size="XX-Large" Font-Names="Elephant" Font-Underline="True" Width="558px"></asp:Label>
			<asp:Image id="Image1" style="Z-INDEX: 104; LEFT: 872px; POSITION: absolute; TOP: 8px" runat="server"
				ImageUrl="LCL.jpg"></asp:Image>
		</form>
	</body>
</HTML>
