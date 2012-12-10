<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Employees.aspx.vb" Inherits="RevenueForecast.Employees"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Employees</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body background="bk6.jpg" MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:label id="Label1" style="Z-INDEX: 101; LEFT: 248px; POSITION: absolute; TOP: 24px" runat="server"
				Font-Names="Elephant" ForeColor="DimGray" Font-Size="X-Large">Employees Editing</asp:label><asp:button id="Button2" style="Z-INDEX: 102; LEFT: 184px; POSITION: absolute; TOP: 32px" runat="server"
				Text="Back"></asp:button><asp:textbox id="TextBox1" style="Z-INDEX: 103; LEFT: 392px; POSITION: absolute; TOP: 128px"
				runat="server"></asp:textbox><asp:button id="Button1" style="Z-INDEX: 104; LEFT: 272px; POSITION: absolute; TOP: 128px" runat="server"
				Text="Search"></asp:button><asp:datagrid id="DataGrid1" style="Z-INDEX: 105; LEFT: 40px; POSITION: absolute; TOP: 176px"
				runat="server" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" BackColor="White" CellPadding="4" GridLines="Horizontal"
				Width="782px" AutoGenerateColumns="False">
				<FooterStyle HorizontalAlign="Center" ForeColor="#404040" BackColor="Gainsboro"></FooterStyle>
				<SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#339966"></SelectedItemStyle>
				<EditItemStyle HorizontalAlign="Center"></EditItemStyle>
				<ItemStyle HorizontalAlign="Center" ForeColor="Black" BackColor="WhiteSmoke"></ItemStyle>
				<HeaderStyle Font-Bold="True" HorizontalAlign="Center" ForeColor="White" BackColor="#336666"></HeaderStyle>
				<Columns>
					<asp:BoundColumn HeaderText="No"></asp:BoundColumn>
					<asp:BoundColumn HeaderText="Name"></asp:BoundColumn>
					<asp:BoundColumn HeaderText="User Name"></asp:BoundColumn>
					<asp:TemplateColumn HeaderText="Base Salary">
						<ItemTemplate>
							<asp:Label id="Label2" runat="server">$</asp:Label>
							<asp:TextBox id="TextBox2" runat="server" Width="93px" Enabled="False"></asp:TextBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:BoundColumn HeaderText="Department"></asp:BoundColumn>
					<asp:TemplateColumn HeaderText="Edit Employee">
						<ItemTemplate>
							<asp:Button id="Button3" runat="server" Text="Edit" CommandName="Editt" CausesValidation="false"></asp:Button>
						</ItemTemplate>
						<EditItemTemplate>
							&nbsp;
						</EditItemTemplate>
					</asp:TemplateColumn>
				</Columns>
				<PagerStyle HorizontalAlign="Center" ForeColor="White" BackColor="#336666" Mode="NumericPages"></PagerStyle>
			</asp:datagrid><asp:radiobuttonlist id="RadioButtonList1" style="Z-INDEX: 106; LEFT: 336px; POSITION: absolute; TOP: 80px"
				runat="server" Height="24px" RepeatDirection="Horizontal">
				<asp:ListItem Value="Add">Add</asp:ListItem>
				<asp:ListItem Value="Edit" Selected="True">Edit</asp:ListItem>
			</asp:radiobuttonlist>
			<asp:DataGrid id="DataGrid2" style="Z-INDEX: 107; LEFT: 328px; POSITION: absolute; TOP: 408px"
				runat="server"></asp:DataGrid></form>
	</body>
</HTML>
