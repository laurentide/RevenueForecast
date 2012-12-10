<%@ Page Language="vb" AutoEventWireup="false" Codebehind="NewMenu.aspx.vb" Inherits="RevenueForecast.WebForm2"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Menu</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body bgColor="#f0f8ff" MS_POSITIONING="GridLayout" background="bk6.jpg">
		<form id="Form1" method="post" runat="server">
			<asp:listbox id="ListBox1" style="Z-INDEX: 101; LEFT: 248px; POSITION: absolute; TOP: 152px"
				runat="server" Width="143px" tabIndex="1"></asp:listbox><asp:label id="Label1" style="Z-INDEX: 102; LEFT: 280px; POSITION: absolute; TOP: 120px" runat="server"
				Font-Bold="True" Font-Underline="True">Departments</asp:label><asp:listbox id="ListBox2" style="Z-INDEX: 103; LEFT: 456px; POSITION: absolute; TOP: 152px"
				runat="server" Width="144px" Height="32px" tabIndex="2"></asp:listbox><asp:label id="Label2" style="Z-INDEX: 104; LEFT: 504px; POSITION: absolute; TOP: 120px" runat="server"
				Width="48px" Font-Bold="True" Font-Underline="True">Year</asp:label><asp:label id="Label3" style="Z-INDEX: 105; LEFT: 232px; POSITION: absolute; TOP: 64px" runat="server"
				Font-Size="Large" Width="230px" Font-Names="Elephant" ForeColor="DimGray">Current Manager: </asp:label><asp:label id="Label4" style="Z-INDEX: 106; LEFT: 464px; POSITION: absolute; TOP: 64px" runat="server"
				Font-Size="Large" Width="356px" Font-Names="Elephant" ForeColor="DimGray"></asp:label><asp:button id="Button1" style="Z-INDEX: 107; LEFT: 376px; POSITION: absolute; TOP: 232px" runat="server"
				Width="104px" Text="Ok" tabIndex="3"></asp:button><asp:datagrid id="DataGrid1" style="Z-INDEX: 108; LEFT: 80px; POSITION: absolute; TOP: 120px"
				runat="server" Width="726px" AutoGenerateColumns="False" BorderColor="Black" BorderStyle="Double" BorderWidth="2px" BackColor="White" CellPadding="3"
				GridLines="Horizontal">
				<FooterStyle ForeColor="Black" BackColor="Gainsboro"></FooterStyle>
				<SelectedItemStyle Font-Bold="True" ForeColor="#F7F7F7" BackColor="#738A9C"></SelectedItemStyle>
				<AlternatingItemStyle BackColor="#F7F7F7"></AlternatingItemStyle>
				<ItemStyle ForeColor="Black" BackColor="WhiteSmoke"></ItemStyle>
				<HeaderStyle Font-Bold="True" ForeColor="White" BackColor="#336666"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn HeaderText="No">
						<HeaderTemplate>
							<asp:Label id="Label5" runat="server" Width="24px">No</asp:Label>
							<asp:ImageButton id="ImageButton1" runat="server" CommandName="B.BudgetID" ImageUrl="arrow1.gif"></asp:ImageButton>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:LinkButton id="LinkButton1" runat="server" CommandName="EditForeCast"></asp:LinkButton>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Year">
						<HeaderTemplate>
							<asp:Label id="Label7" runat="server" Width="40px">Year</asp:Label>
							<asp:ImageButton id="ImageButton2" runat="server" CommandName="B.Year" ImageUrl="arrow1.gif"></asp:ImageButton>
						</HeaderTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Creator">
						<HeaderTemplate>
							<asp:Label id="Label8" runat="server" Width="60px">Creator</asp:Label>
							<asp:ImageButton id="ImageButton3" runat="server" ImageUrl="arrow1.gif" CommandName="E.name"></asp:ImageButton>
						</HeaderTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Department">
						<HeaderTemplate>
							<asp:Label id="Label9" runat="server" Width="88px">Department</asp:Label>
							<asp:ImageButton id="ImageButton4" runat="server" CommandName="D.Description" ImageUrl="arrow1.gif"></asp:ImageButton>
						</HeaderTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Annual Amount">
						<HeaderTemplate>
							<asp:Label id="Label6" runat="server" Width="112px">Annual Amount</asp:Label>
							<asp:ImageButton id="ImageButton6" runat="server" ImageUrl="arrow1.gif" CommandName="'Total' desc"></asp:ImageButton>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="Label11" runat="server" Width="112px"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Date">
						<HeaderTemplate>
							<asp:Label id="Label10" runat="server" Width="40px">Date</asp:Label>
							<asp:ImageButton id="ImageButton5" runat="server" CommandName="B.Date" ImageUrl="arrow1.gif"></asp:ImageButton>
						</HeaderTemplate>
					</asp:TemplateColumn>
				</Columns>
				<PagerStyle HorizontalAlign="Right" ForeColor="#4A3C8C" BackColor="#E7E7FF" Mode="NumericPages"></PagerStyle>
			</asp:datagrid><asp:button id="Button2" style="Z-INDEX: 109; LEFT: 8px; POSITION: absolute; TOP: 8px" runat="server"
				Text="Menu" tabIndex="4"></asp:button>
			<asp:Image id="Image1" style="Z-INDEX: 110; LEFT: 856px; POSITION: absolute; TOP: 8px" runat="server"
				ImageUrl="LCL.jpg"></asp:Image></form>
		<TABLE id="Table1" height="1" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<TR>
				<TD noWrap align="left"><asp:label id="LabelTitle" runat="server" Font-Size="8pt" Font-Names="Tahoma" Font-Bold="True"
						ForeColor="Blue">NORTHWIND ORDERS</asp:label></TD>
			</TR>
			<TR>
				<TD noWrap align="left">
					<asp:datagrid id="Datagrid2" runat="server" ForeColor="Black" AllowSorting="True" AllowPaging="True"
						GridLines="Vertical" CellPadding="3" BackColor="White" BorderWidth="1px" BorderStyle="Solid"
						BorderColor="#999999" Width="60%" AutoGenerateColumns="False">
						<SelectedItemStyle Font-Bold="True" HorizontalAlign="Left" ForeColor="White" VerticalAlign="Top" BackColor="#000099"></SelectedItemStyle>
						<EditItemStyle HorizontalAlign="Left" VerticalAlign="Top"></EditItemStyle>
						<AlternatingItemStyle HorizontalAlign="Left" BackColor="#CCCCCC"></AlternatingItemStyle>
						<ItemStyle Font-Size="8pt" Font-Names="Tahoma" HorizontalAlign="Left" VerticalAlign="Top"></ItemStyle>
						<HeaderStyle Font-Bold="True" ForeColor="White" BackColor="Black"></HeaderStyle>
						<FooterStyle BackColor="#CCCCCC"></FooterStyle>
						<Columns>
							<asp:HyperLinkColumn Text="+"></asp:HyperLinkColumn>
							<asp:BoundColumn Visible="False" DataField="OrderID" ReadOnly="True" HeaderText="OrderID"></asp:BoundColumn>
							<asp:BoundColumn Visible="False" DataField="CustomerID" HeaderText="CustomerID"></asp:BoundColumn>
							<asp:BoundColumn Visible="False" DataField="EmployeeID" HeaderText="EmployeeID"></asp:BoundColumn>
							<asp:BoundColumn DataField="ShipName" SortExpression="ShipName" HeaderText="Name"></asp:BoundColumn>
							<asp:BoundColumn DataField="ShipAddress" SortExpression="ShipAddress" HeaderText="Address"></asp:BoundColumn>
							<asp:BoundColumn DataField="ShipCity" SortExpression="ShipCity" HeaderText="City"></asp:BoundColumn>
							<asp:BoundColumn DataField="ShipRegion" SortExpression="ShipRegion" HeaderText="Region"></asp:BoundColumn>
							<asp:BoundColumn DataField="ShipPostalCode" SortExpression="ShipPostalCode" HeaderText="Postal"></asp:BoundColumn>
							<asp:BoundColumn DataField="ShipCountry" SortExpression="ShipCountry" HeaderText="Country"></asp:BoundColumn>
						</Columns>
						<PagerStyle HorizontalAlign="Center" ForeColor="Black" BackColor="#999999" Mode="NumericPages"></PagerStyle>
					</asp:datagrid></TD>
			</TR>
			<TR>
				<TD noWrap align="left">
					<asp:button id="ButtonSample" runat="server" Font-Size="8pt" Font-Names="Tahoma" Text="What happens during a postback?"></asp:button>
					<div style="DISPLAY: block; VISIBILITY: visible">
						<asp:textbox id="txtExpandedDivs" runat="server" Font-Size="8pt" Font-Names="Tahoma" Width="400px"></asp:textbox>
					</div>
				</TD>
			</TR>
			<TR>
				<TD style="HEIGHT: 2px" noWrap align="left"><asp:label id="LabelWhatHappens" runat="server" Font-Size="8pt" Font-Names="Tahoma" Font-Bold="True"
						Width="100%">What are we storing in the hidden textbox field (txtExpandedDivs TextBox Control)?</asp:label></TD>
			</TR>
			<TR>
				<TD noWrap align="left"><asp:label id="LabelPostBack" runat="server" Font-Size="8pt" Font-Names="Tahoma" Width="100%"></asp:label></TD>
			</TR>
		</TABLE>
	</body>
</HTML>
