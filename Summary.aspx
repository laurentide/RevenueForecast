<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Summary.aspx.vb" Inherits="RevenueForecast.Summary"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Summary</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body background="bk6.jpg" MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:button id="Button1" style="Z-INDEX: 101; LEFT: 8px; POSITION: absolute; TOP: 8px" runat="server"
				Text="Back"></asp:button><asp:datagrid id="DataGrid1" style="Z-INDEX: 102; LEFT: 120px; POSITION: absolute; TOP: 136px"
				runat="server" GridLines="Horizontal" CellPadding="4" BackColor="White" BorderWidth="3px" BorderStyle="Double" BorderColor="#336666"
				Width="775px" AutoGenerateColumns="False">
				<FooterStyle HorizontalAlign="Center" ForeColor="Black" BackColor="Gainsboro"></FooterStyle>
				<SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#339966"></SelectedItemStyle>
				<ItemStyle HorizontalAlign="Center" ForeColor="Black" BackColor="WhiteSmoke"></ItemStyle>
				<HeaderStyle Font-Bold="True" HorizontalAlign="Center" ForeColor="White" BackColor="#336666"></HeaderStyle>
				<Columns>
					<asp:BoundColumn></asp:BoundColumn>
					<asp:TemplateColumn HeaderText="plan">
						<HeaderTemplate>
							<asp:Label id="Label1" runat="server"></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="Label10" runat="server" Width="96px"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="projected">
						<HeaderTemplate>
							<asp:Label id="Label2" runat="server"></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="Label7" runat="server">$</asp:Label>
							<asp:TextBox id="TextBox1" runat="server" Width="112px">0</asp:TextBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="actual">
						<HeaderTemplate>
							<asp:Label id="Label3" runat="server"></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="Label8" runat="server">$</asp:Label>
							<asp:TextBox id="TextBox3" runat="server" Width="112px">0</asp:TextBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="actual">
						<HeaderTemplate>
							<asp:Label id="Label5" runat="server"></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="Label9" runat="server">$</asp:Label>
							<asp:TextBox id="TextBox4" runat="server" Width="112px">0</asp:TextBox>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
				<PagerStyle HorizontalAlign="Center" ForeColor="White" BackColor="#336666" Mode="NumericPages"></PagerStyle>
			</asp:datagrid><asp:label id="Label4" style="Z-INDEX: 103; LEFT: 128px; POSITION: absolute; TOP: 56px" runat="server"
				Width="762px" Font-Names="Elephant" Font-Size="XX-Large" ForeColor="DimGray" Font-Underline="True"></asp:label><asp:textbox id="TextBox2" style="Z-INDEX: 104; LEFT: 120px; POSITION: absolute; TOP: 400px"
				runat="server" Width="779px" TextMode="MultiLine" Height="176px"></asp:textbox><asp:label id="Label6" style="Z-INDEX: 105; LEFT: 488px; POSITION: absolute; TOP: 376px" runat="server"
				Font-Size="Medium" Font-Bold="True">Comments :</asp:label>
			<asp:Image id="Image1" style="Z-INDEX: 106; LEFT: 856px; POSITION: absolute; TOP: 8px" runat="server"
				ImageUrl="LCL.jpg"></asp:Image></form>
	</body>
</HTML>
