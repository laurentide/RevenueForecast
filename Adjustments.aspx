<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Adjustments.aspx.vb" Inherits="RevenueForecast.Adjustments"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Adjustments</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body background="bk6.jpg" MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:datagrid id="DataGrid1" style="Z-INDEX: 101; LEFT: 8px; POSITION: absolute; TOP: 176px" runat="server"
				ShowFooter="True" GridLines="Horizontal" CellPadding="4" BackColor="White" BorderWidth="3px"
				BorderStyle="Double" BorderColor="#336666" AutoGenerateColumns="False" Width="945px">
				<FooterStyle ForeColor="#333333" BackColor="Gainsboro"></FooterStyle>
				<SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#339966"></SelectedItemStyle>
				<ItemStyle ForeColor="Black" BackColor="WhiteSmoke"></ItemStyle>
				<HeaderStyle Font-Bold="True" HorizontalAlign="Center" ForeColor="White" BackColor="#336666"></HeaderStyle>
				<Columns>
					<asp:BoundColumn HeaderText="Expenses"></asp:BoundColumn>
					<asp:TemplateColumn HeaderText="Nomis YTD">
						<ItemTemplate>
							<asp:Label id="Label4" runat="server" Width="155px"></asp:Label>
						</ItemTemplate>
						<FooterTemplate>
							<asp:Label id="Label5" runat="server" Width="155px"></asp:Label>
						</FooterTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="PLAN YTD">
						<ItemTemplate>
							<asp:Label id="Label8" runat="server" Width="155px"></asp:Label>
						</ItemTemplate>
						<FooterTemplate>
							<asp:Label id="Label9" runat="server" Width="155px"></asp:Label>
						</FooterTemplate>
					</asp:TemplateColumn>
					<asp:BoundColumn HeaderText="RPTID"></asp:BoundColumn>
					<asp:TemplateColumn HeaderText="Adjustments">
						<ItemTemplate>
							<asp:Label id="Label2" runat="server">$</asp:Label>
							<asp:TextBox id="TextBox1" runat="server" Width="104px">0</asp:TextBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Forecast">
						<ItemTemplate>
							<asp:Label id="Label10" runat="server" Width="155px"></asp:Label>
						</ItemTemplate>
						<FooterTemplate>
							<asp:Label id="Label11" runat="server" Width="155px"></asp:Label>
						</FooterTemplate>
					</asp:TemplateColumn>
				</Columns>
				<PagerStyle HorizontalAlign="Center" ForeColor="White" BackColor="#336666" Mode="NumericPages"></PagerStyle>
			</asp:datagrid><asp:label id="Label1" style="Z-INDEX: 102; LEFT: 336px; POSITION: absolute; TOP: 24px" runat="server"
				Width="304px" ForeColor="DimGray" Font-Size="XX-Large" Font-Underline="True" Font-Names="Elephant">Adjustments</asp:label><asp:button id="Button1" style="Z-INDEX: 103; LEFT: 8px; POSITION: absolute; TOP: 8px" runat="server"
				Text="Menu"></asp:button><asp:dropdownlist id="DropDownList1" style="Z-INDEX: 104; LEFT: 448px; POSITION: absolute; TOP: 96px"
				runat="server" Width="192px" AutoPostBack="True"></asp:dropdownlist><asp:label id="Label3" style="Z-INDEX: 105; LEFT: 336px; POSITION: absolute; TOP: 96px" runat="server"
				ForeColor="DimGray" Font-Names="Elephant">Department :</asp:label><asp:button id="Button2" style="Z-INDEX: 106; LEFT: 448px; POSITION: absolute; TOP: 136px" runat="server"
				Width="56px" Text="Save"></asp:button><asp:image id="Image1" style="Z-INDEX: 108; LEFT: 856px; POSITION: absolute; TOP: 8px" runat="server"
				ImageUrl="LCL.jpg"></asp:image></form>
	</body>
</HTML>
