<%@ Page Language="vb" AutoEventWireup="false" Codebehind="GL.aspx.vb" Inherits="RevenueForecast.GL"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>GL</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body background="bk6.jpg" MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:button id="Button1" style="Z-INDEX: 101; LEFT: 8px; POSITION: absolute; TOP: 8px" runat="server"
				Text="Menu"></asp:button><asp:textbox id="TextBox1" style="Z-INDEX: 102; LEFT: 288px; POSITION: absolute; TOP: 120px"
				runat="server" Height="176px" TextMode="MultiLine" Width="368px"></asp:textbox><asp:button id="Button2" style="Z-INDEX: 103; LEFT: 440px; POSITION: absolute; TOP: 304px" runat="server"
				Text="Save" Width="56px"></asp:button><asp:label id="Label1" style="Z-INDEX: 104; LEFT: 368px; POSITION: absolute; TOP: 8px" runat="server"
				Font-Names="Elephant" Font-Size="XX-Large" ForeColor="DimGray" Font-Bold="True">GL codes</asp:label><asp:datagrid id="DataGrid1" style="Z-INDEX: 105; LEFT: 48px; POSITION: absolute; TOP: 336px"
				runat="server" Width="820px" AutoGenerateColumns="False" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" BackColor="White" CellPadding="4" GridLines="Horizontal">
				<FooterStyle HorizontalAlign="Center" ForeColor="Black" BackColor="Gainsboro"></FooterStyle>
				<SelectedItemStyle Font-Italic="True" Font-Bold="True" HorizontalAlign="Center" ForeColor="Black" BackColor="WhiteSmoke"></SelectedItemStyle>
				<ItemStyle HorizontalAlign="Center" ForeColor="Black" BackColor="WhiteSmoke"></ItemStyle>
				<HeaderStyle Font-Bold="True" HorizontalAlign="Center" ForeColor="White" BackColor="#336666"></HeaderStyle>
				<Columns>
					<asp:BoundColumn HeaderText="GL"></asp:BoundColumn>
					<asp:BoundColumn HeaderText="Description"></asp:BoundColumn>
					<asp:BoundColumn HeaderText="Help Preview"></asp:BoundColumn>
					<asp:TemplateColumn HeaderText="Edit Help">
						<ItemTemplate>
							<asp:Button id="Button3" runat="server" Text="View" CommandName="View"></asp:Button>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
				<PagerStyle HorizontalAlign="Center" ForeColor="White" BackColor="#336666" Mode="NumericPages"></PagerStyle>
			</asp:datagrid><asp:label id="Label2" style="Z-INDEX: 106; LEFT: 292px; POSITION: absolute; TOP: 96px" runat="server"
				Width="359px" Font-Bold="True" Font-Underline="True"></asp:label>
			<asp:Image id="Image1" style="Z-INDEX: 107; LEFT: 856px; POSITION: absolute; TOP: 8px" runat="server"
				ImageUrl="LCL.jpg"></asp:Image></form>
	</body>
</HTML>
