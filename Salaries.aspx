<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Salaries.aspx.vb" Inherits="RevenueForecast.CapitalExpenditure"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Salaries</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body bgColor="aliceblue" background="bk6.jpg" ms_positioning="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:label id="Label7" style="Z-INDEX: 105; LEFT: 24px; POSITION: absolute; TOP: 184px" runat="server"
				Width="360px" BorderColor="Black" BorderStyle="Solid" BorderWidth="3px" BackColor="#336666"
				ForeColor="White" Font-Bold="True" Font-Italic="True" Height="40px"></asp:label><asp:label id="Label11" style="Z-INDEX: 110; LEFT: 560px; POSITION: absolute; TOP: 200px" runat="server"
				Visible="False">%</asp:label><asp:textbox id="TextBox7" style="Z-INDEX: 108; LEFT: 416px; POSITION: absolute; TOP: 200px"
				runat="server" Width="40px" Visible="False" tabIndex="2">0</asp:textbox>&nbsp;<asp:datagrid id="DataGrid1" style="Z-INDEX: 101; LEFT: 24px; POSITION: absolute; TOP: 224px"
				runat="server" Width="962px" BorderColor="Black" BorderStyle="Double" BorderWidth="3px" BackColor="White" GridLines="Horizontal" CellPadding="3" AutoGenerateColumns="False"
				ShowFooter="True" tabIndex="4">
				<FooterStyle ForeColor="Black" BackColor="Gainsboro"></FooterStyle>
				<SelectedItemStyle Font-Bold="True" ForeColor="#F7F7F7" BackColor="#738A9C"></SelectedItemStyle>
				<AlternatingItemStyle BackColor="#F7F7F7"></AlternatingItemStyle>
				<ItemStyle ForeColor="Black" BackColor="WhiteSmoke"></ItemStyle>
				<HeaderStyle Font-Bold="True" ForeColor="White" BackColor="#336666"></HeaderStyle>
				<Columns>
					<asp:BoundColumn HeaderText="No"></asp:BoundColumn>
					<asp:BoundColumn HeaderText="Employee"></asp:BoundColumn>
					<asp:TemplateColumn HeaderText="Base Salary">
						<FooterTemplate>
							<asp:Label id="Label5" runat="server"></asp:Label>
						</FooterTemplate>
					</asp:TemplateColumn>
					<asp:BoundColumn ReadOnly="True" HeaderText="RRSP               "></asp:BoundColumn>
					<asp:TemplateColumn HeaderText="Points"></asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="-">
						<ItemTemplate>
							<asp:Label id="Label8" runat="server"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="% increase">
						<HeaderTemplate>
							<asp:TextBox id="TextBox2" runat="server" Width="40px" MaxLength="3">0</asp:TextBox>
							<asp:Label id="Label4" runat="server">%</asp:Label>
							<asp:Button id="Button1" runat="server" Height="24px" Width="16px" Text="V" CommandName="Inc"></asp:Button>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:TextBox id="TextBox1" runat="server" Width="40px" MaxLength="3" Enabled="False">0</asp:TextBox>
							<asp:Label id="Label2" runat="server">%</asp:Label>
							<asp:CheckBox id="CheckBox1" runat="server" Text=" "></asp:CheckBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Revised Salary">
						<ItemTemplate>
							<asp:Label id="Label3" runat="server">$</asp:Label>
							<asp:TextBox id="TextBox4" runat="server" Width="96px"></asp:TextBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="RRSP">
						<ItemTemplate>
							<asp:Label id="Label9" runat="server">$</asp:Label>
							<asp:TextBox id="TextBox3" runat="server" Width="96px"></asp:TextBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Points">
						<ItemTemplate>
							<asp:TextBox id="TextBox8" runat="server" Width="48px">0</asp:TextBox>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
				<PagerStyle HorizontalAlign="Right" ForeColor="#4A3C8C" BackColor="#E7E7FF" Mode="NumericPages"></PagerStyle>
			</asp:datagrid>
			<asp:button id="Button3" style="Z-INDEX: 102; LEFT: 456px; POSITION: absolute; TOP: 120px" runat="server"
				Width="72px" Text="Save" tabIndex="1"></asp:button><asp:label id="Label1" style="Z-INDEX: 103; LEFT: 280px; POSITION: absolute; TOP: 48px" runat="server"
				Width="441px" BorderColor="Transparent" BackColor="Transparent" ForeColor="DimGray" Font-Names="Elephant" Font-Size="XX-Large" Font-Underline="True">Employee Salaries</asp:label><asp:label id="Label6" style="Z-INDEX: 104; LEFT: 596px; POSITION: absolute; TOP: 184px" runat="server"
				Width="391px" BorderColor="Black" BorderStyle="Solid" BorderWidth="3px" BackColor="#336666" ForeColor="White" Font-Bold="True" Font-Italic="True" Height="40px">Proposed - x% increase</asp:label><asp:button id="Button7" style="Z-INDEX: 106; LEFT: 8px; POSITION: absolute; TOP: 8px" runat="server"
				Text="Back" tabIndex="5"></asp:button><asp:textbox id="TextBox6" style="Z-INDEX: 107; LEFT: 520px; POSITION: absolute; TOP: 200px"
				runat="server" Width="40px" Visible="False" tabIndex="3">0</asp:textbox><asp:label id="Label10" style="Z-INDEX: 109; LEFT: 456px; POSITION: absolute; TOP: 200px" runat="server"
				Visible="False">%</asp:label><asp:label id="Label12" style="Z-INDEX: 111; LEFT: 392px; POSITION: absolute; TOP: 176px" runat="server"
				Visible="False" Font-Underline="True">Group Insurance</asp:label><asp:label id="Label13" style="Z-INDEX: 112; LEFT: 504px; POSITION: absolute; TOP: 176px" runat="server"
				Visible="False" Font-Underline="True">Payroll Levies</asp:label>
			<asp:Image id="Image1" style="Z-INDEX: 113; LEFT: 856px; POSITION: absolute; TOP: 8px" runat="server"
				ImageUrl="LCL.jpg"></asp:Image></form>
	</body>
</HTML>
