<%@ Page Language="vb" AutoEventWireup="false" Codebehind="department.aspx.vb" Inherits="RevenueForecast.department"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>department</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body onscroll="javascript:setcoords()" background="bk6.jpg" MS_POSITIONING="GridLayout"
		onload="javascript:ScrollIt()">
		<form id="Form1" method="post" runat="server">
			<asp:datagrid id="DataGrid1" style="Z-INDEX: 101; LEFT: 8px; POSITION: absolute; TOP: 136px" runat="server"
				GridLines="Horizontal" CellPadding="4" BackColor="White" BorderWidth="3px" BorderStyle="Double"
				BorderColor="#336666" Width="982px" AutoGenerateColumns="False" ShowFooter="True">
				<FooterStyle HorizontalAlign="Center" ForeColor="Black" BackColor="Gainsboro"></FooterStyle>
				<SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#339966"></SelectedItemStyle>
				<ItemStyle HorizontalAlign="Center" ForeColor="Black" BackColor="WhiteSmoke"></ItemStyle>
				<HeaderStyle Font-Bold="True" HorizontalAlign="Center" ForeColor="White" BackColor="#336666"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn HeaderText="Name">
						<FooterTemplate>
							<asp:TextBox id="TextBox6" runat="server" Width="143px">LastName, FirstName</asp:TextBox>
						</FooterTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="User Name"></asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Base Salary">
						<ItemTemplate>
							<asp:Label id="Label3" runat="server">$</asp:Label>
							<asp:TextBox id="TextBox1" runat="server" Width="96px"></asp:TextBox>
						</ItemTemplate>
						<FooterTemplate>
							<asp:Label id="Label7" runat="server">$</asp:Label>
							<asp:TextBox id="TextBox8" runat="server" Width="96px">0</asp:TextBox>
						</FooterTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="%RRSP">
						<HeaderTemplate>
							<asp:TextBox id="TextBox4" runat="server" Width="32px" MaxLength="3">5</asp:TextBox>
							<asp:Label id="Label5" runat="server">%</asp:Label>
							<asp:Button id="Button3" runat="server" Width="16px" Text="V" CommandName="Inc"></asp:Button>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:TextBox id="TextBox5" runat="server" Width="32px" MaxLength="3">5</asp:TextBox>
							<asp:Label id="Label6" runat="server">%</asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="RRSP">
						<ItemTemplate>
							<asp:Label id="Label4" runat="server">$</asp:Label>
							<asp:TextBox id="TextBox2" runat="server" Width="96px">0</asp:TextBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Points">
						<ItemTemplate>
							<asp:TextBox id="TextBox3" runat="server" Width="48px">0</asp:TextBox>
						</ItemTemplate>
						<FooterTemplate>
							<asp:TextBox id="TextBox11" runat="server" Width="48px">0</asp:TextBox>
						</FooterTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Department">
						<FooterTemplate>
							<asp:Button id="Button1" runat="server" Text="Add" CommandName="Add"></asp:Button>
						</FooterTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Delete">
						<ItemTemplate>
							<asp:CheckBox id="chkDelete" runat="server"></asp:CheckBox>
						</ItemTemplate>
						<FooterTemplate>
							<asp:Button id="Button6" runat="server" Text="Delete" CommandName="Delete"></asp:Button>
						</FooterTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="EmployeeID"></asp:TemplateColumn>
				</Columns>
				<PagerStyle HorizontalAlign="Center" ForeColor="White" BackColor="#336666" Mode="NumericPages"></PagerStyle>
			</asp:datagrid><asp:dropdownlist id="DropDownList1" style="Z-INDEX: 102; LEFT: 488px; POSITION: absolute; TOP: 72px"
				tabIndex="1" runat="server" Width="145px" AutoPostBack="True" Font-Size="X-Small"></asp:dropdownlist><asp:label id="Label1" style="Z-INDEX: 103; LEFT: 352px; POSITION: absolute; TOP: 72px" runat="server"
				Width="128px" Font-Size="Medium" Font-Names="Franklin Gothic Heavy">Department: </asp:label><asp:label id="Label2" style="Z-INDEX: 104; LEFT: 400px; POSITION: absolute; TOP: 16px" runat="server"
				Font-Size="X-Large" Font-Names="Elephant" ForeColor="DimGray"> Employees</asp:label>
			<asp:Button id="Button2" style="Z-INDEX: 105; LEFT: 8px; POSITION: absolute; TOP: 8px" runat="server"
				Text="Menu"></asp:Button>
			<input id="PageY" style="Z-INDEX: 106; LEFT: 0px; POSITION: absolute; TOP: 32px" type="hidden"
				value="0" name="PageY" runat="server"><input id="PageX" style="Z-INDEX: 107; LEFT: 0px; POSITION: absolute; TOP: 8px" type="hidden"
				value="0" name="PageX" runat="server">
			<asp:Button id="Button4" style="Z-INDEX: 108; LEFT: 352px; POSITION: absolute; TOP: 104px" runat="server"
				Text="Refresh"></asp:Button>
			<asp:Button id="Button5" style="Z-INDEX: 109; LEFT: 576px; POSITION: absolute; TOP: 104px" runat="server"
				Width="56px" Text="Save"></asp:Button></form>
		<script language="javascript">
		var IE=document.all?true:false

function ScrollIt(){
    window.scrollTo(document.Form1.PageX.value, document.Form1.PageY.value);
    }
function setcoords(){
    var myPageX;
    var myPageY;
    if (document.all){
        myPageX = document.body.scrollLeft;
        myPageY = document.body.scrollTop;
        }
    else{
        myPageX = window.pageXOffset;
        myPageY = window.pageYOffset;
        }
    document.Form1.PageX.value = myPageX;
    document.Form1.PageY.value = myPageY;
    }
		</script>
	</body>
</HTML>
