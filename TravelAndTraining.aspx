<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TravelAndTraining.aspx.vb" Inherits="RevenueForecast.TravelAndTraining"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>TravelAndTraining</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body background="bk6.jpg" MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:datagrid id="DataGrid1" style="Z-INDEX: 101; LEFT: 0px; POSITION: absolute; TOP: 120px" runat="server"
				ShowFooter="True" Width="1006px" GridLines="Horizontal" CellPadding="4" BackColor="White"
				BorderWidth="3px" BorderStyle="Double" BorderColor="#336666" AutoGenerateColumns="False">
				<FooterStyle Font-Size="X-Small" HorizontalAlign="Center" ForeColor="Black" BackColor="Gainsboro"></FooterStyle>
				<SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#339966"></SelectedItemStyle>
				<ItemStyle Font-Size="X-Small" HorizontalAlign="Center" ForeColor="Black" BackColor="WhiteSmoke"></ItemStyle>
				<HeaderStyle Font-Size="X-Small" Font-Bold="True" HorizontalAlign="Center" ForeColor="White"
					BackColor="#336666"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn HeaderText="Employee">
						<FooterTemplate>
							<asp:DropDownList id="DropDownList1" runat="server" Width="152px" Font-Size="Smaller"></asp:DropDownList>
						</FooterTemplate>
						<EditItemTemplate>
							<asp:DropDownList id="DropDownList3" runat="server" Width="152px" Font-Size="XX-Small"></asp:DropDownList>
						</EditItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Type">
						<FooterTemplate>
							<asp:DropDownList id="DropDownList2" runat="server" Width="72px" Font-Size="Smaller">
								<asp:ListItem Value="Choose...">Choose...</asp:ListItem>
								<asp:ListItem Value="Training">Training</asp:ListItem>
								<asp:ListItem Value="Travel">Travel</asp:ListItem>
							</asp:DropDownList>
						</FooterTemplate>
						<EditItemTemplate>
							<asp:DropDownList id="DropDownList4" runat="server" Width="72px" Font-Size="XX-Small">
								<asp:ListItem Value="Training">Training</asp:ListItem>
								<asp:ListItem Value="Travel">Travel</asp:ListItem>
							</asp:DropDownList>
						</EditItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Destination">
						<FooterTemplate>
							<asp:TextBox id="TextBox7" runat="server" Width="73px" Font-Size="Smaller"></asp:TextBox>
						</FooterTemplate>
						<EditItemTemplate>
							<asp:TextBox id="TextBox10" runat="server" Width="73px" Font-Size="XX-Small"></asp:TextBox>
						</EditItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Course Title">
						<FooterTemplate>
							<asp:TextBox id="TextBox1" runat="server" Width="73px" Font-Size="Smaller"></asp:TextBox>
						</FooterTemplate>
						<EditItemTemplate>
							<asp:TextBox id="TextBox11" runat="server" Width="73px" Font-Size="XX-Small"></asp:TextBox>
						</EditItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Cost Course">
						<FooterTemplate>
							<asp:Label id="Label10" runat="server">$</asp:Label>
							<asp:TextBox id="TextBox2" runat="server" Width="41px" Font-Size="Smaller">0</asp:TextBox>
						</FooterTemplate>
						<EditItemTemplate>
							<asp:Label id="Label12" runat="server" Font-Size="X-Small">$</asp:Label>
							<asp:TextBox id="TextBox12" runat="server" Width="41px" Font-Size="XX-Small">0</asp:TextBox>
						</EditItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Car Rental">
						<FooterTemplate>
							<asp:Label id="Label11" runat="server">$</asp:Label>
							<asp:TextBox id="TextBox9" runat="server" Width="40px" Font-Size="Smaller">0</asp:TextBox>
						</FooterTemplate>
						<EditItemTemplate>
							<asp:Label id="Label13" runat="server" Font-Size="X-Small">$</asp:Label>
							<asp:TextBox id="TextBox13" runat="server" Width="40px" Font-Size="XX-Small">0</asp:TextBox>
						</EditItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Fares">
						<FooterTemplate>
							<asp:Label id="Label9" runat="server">$</asp:Label>
							<asp:TextBox id="TextBox3" runat="server" Width="41px" Font-Size="Smaller">0</asp:TextBox>
						</FooterTemplate>
						<EditItemTemplate>
							<asp:Label id="Label14" runat="server" Font-Size="X-Small">$</asp:Label>
							<asp:TextBox id="TextBox14" runat="server" Width="41px" Font-Size="XX-Small">0</asp:TextBox>
						</EditItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Hotel">
						<FooterTemplate>
							<asp:Label id="Label8" runat="server">$</asp:Label>
							<asp:TextBox id="TextBox4" runat="server" Width="41px" Font-Size="Smaller">0</asp:TextBox>
						</FooterTemplate>
						<EditItemTemplate>
							<asp:Label id="Label15" runat="server" Font-Size="X-Small">$</asp:Label>
							<asp:TextBox id="TextBox15" runat="server" Width="41px" Font-Size="XX-Small">0</asp:TextBox>
						</EditItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Meals">
						<FooterTemplate>
							<asp:Label id="Label5" runat="server">$</asp:Label>
							<asp:TextBox id="TextBox5" runat="server" Width="41px" Font-Size="Smaller">0</asp:TextBox>
						</FooterTemplate>
						<EditItemTemplate>
							<asp:Label id="Label16" runat="server">$</asp:Label>
							<asp:TextBox id="TextBox16" runat="server" Width="41px" Font-Size="XX-Small">0</asp:TextBox>
						</EditItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText=" Entertainment">
						<FooterTemplate>
							<asp:Label id="Label7" runat="server">$</asp:Label>
							<asp:TextBox id="TextBox6" runat="server" Width="41px" Font-Size="Smaller">0</asp:TextBox>
						</FooterTemplate>
						<EditItemTemplate>
							<asp:Label id="Label17" runat="server" Font-Size="X-Small">$</asp:Label>
							<asp:TextBox id="TextBox17" runat="server" Width="41px" Font-Size="XX-Small">0</asp:TextBox>
						</EditItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Date">
						<FooterTemplate>
							<asp:TextBox id="TextBox8" runat="server" Width="57px" Font-Size="Smaller"></asp:TextBox>
						</FooterTemplate>
						<EditItemTemplate>
							<asp:TextBox id="TextBox18" runat="server" Width="57px" Font-Size="XX-Small"></asp:TextBox>
						</EditItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Add/Delete">
						<ItemTemplate>
							<asp:Button id="Button4" runat="server" Text="Edit" CommandName="Edit"></asp:Button>
							<asp:Button id="Button2" runat="server" Width="32px" Font-Size="X-Small" Text="Del" Height="24px"
								CommandName="Delete"></asp:Button>
						</ItemTemplate>
						<FooterTemplate>
							<asp:Button id="Button3" runat="server" Text="Add" CommandName="Add"></asp:Button>
						</FooterTemplate>
					</asp:TemplateColumn>
					<asp:BoundColumn HeaderText="TravelID"></asp:BoundColumn>
				</Columns>
				<PagerStyle HorizontalAlign="Center" ForeColor="White" BackColor="#336666" Mode="NumericPages"></PagerStyle>
			</asp:datagrid><asp:label id="Label6" style="Z-INDEX: 103; LEFT: 320px; POSITION: absolute; TOP: 48px" runat="server"
				BackColor="Transparent" BorderColor="Transparent" Font-Names="Elephant" Font-Size="X-Large" Font-Underline="True"
				ForeColor="DimGray"></asp:label><asp:button id="Button1" style="Z-INDEX: 102; LEFT: 8px; POSITION: absolute; TOP: 8px" runat="server"
				Text="Back"></asp:button><asp:imagebutton id="ImageButton1" style="Z-INDEX: 104; LEFT: 688px; POSITION: absolute; TOP: 72px"
				runat="server" Width="8px" ImageUrl="bk6.jpg" Height="1px"></asp:imagebutton>
			<asp:Image id="Image1" style="Z-INDEX: 105; LEFT: 856px; POSITION: absolute; TOP: 8px" runat="server"
				ImageUrl="LCL.jpg"></asp:Image></form>
	</body>
</HTML>
