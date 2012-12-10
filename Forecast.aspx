<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Forecast.aspx.vb" Inherits="RevenueForecast.Forecast" buffer="True"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Forecast</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body onscroll="javascript:setcoords()" bgProperties="fixed" bgColor="#ffffff" background="bk6.jpg"
		onload="javascript:ScrollIt()" MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:datagrid id="DataGrid1" style="Z-INDEX: 101; LEFT: 16px; POSITION: absolute; TOP: 192px"
				runat="server" ShowFooter="True" ForeColor="Black" AutoGenerateColumns="False" GridLines="Horizontal"
				CellPadding="4" BackColor="Black" BorderWidth="3px" BorderStyle="Double" BorderColor="#336666"
				Width="754px" tabIndex="6">
				<FooterStyle ForeColor="Black" BackColor="Gainsboro"></FooterStyle>
				<SelectedItemStyle Font-Italic="True" Font-Bold="True" ForeColor="Black" BackColor="WhiteSmoke"></SelectedItemStyle>
				<ItemStyle ForeColor="Black" BackColor="WhiteSmoke"></ItemStyle>
				<HeaderStyle Font-Bold="True" ForeColor="White" BackColor="#336666"></HeaderStyle>
				<Columns>
					<asp:BoundColumn HeaderText="GL" FooterText="Total Amount"></asp:BoundColumn>
					<asp:TemplateColumn HeaderText="Description">
						<ItemTemplate>
							<asp:Label id="Label5" runat="server"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Help">
						<ItemTemplate>
							<asp:Button id="Button5" runat="server" Text="?" CommandName="Help"></asp:Button>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Annual Amount">
						<ItemTemplate>
							<asp:Label id="Label7" runat="server" Width="104px"></asp:Label>
						</ItemTemplate>
						<FooterTemplate>
							<asp:Label id="Label8" runat="server" Width="104px"></asp:Label>
						</FooterTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Expenses">
						<ItemTemplate>
							<asp:Button id="Button1" runat="server" Text="Edit" CommandName="Edit" CausesValidation="false"></asp:Button>
						</ItemTemplate>
						<EditItemTemplate>
							&nbsp;
						</EditItemTemplate>
					</asp:TemplateColumn>
					<asp:BoundColumn HeaderText="Colonne1"></asp:BoundColumn>
					<asp:TemplateColumn HeaderText="Colonne2">
						<ItemTemplate>
							<asp:Button id="Button6" runat="server" Width="48px" Text="Details" CommandName="Details"></asp:Button>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
				<PagerStyle HorizontalAlign="Center" ForeColor="White" BackColor="#336666" Mode="NumericPages"></PagerStyle>
			</asp:datagrid><asp:label id="Label1" style="Z-INDEX: 102; LEFT: 304px; POSITION: absolute; TOP: 128px" runat="server"
				Width="136px" Font-Names="Franklin Gothic Heavy" Font-Size="Larger">Budget Area: </asp:label><asp:label id="Label2" style="Z-INDEX: 103; LEFT: 304px; POSITION: absolute; TOP: 152px" runat="server"
				Font-Names="Franklin Gothic Heavy" Font-Size="Larger">Budget Holder:</asp:label><asp:label id="Label3" style="Z-INDEX: 104; LEFT: 448px; POSITION: absolute; TOP: 128px" runat="server"
				Width="320px" Font-Names="Franklin Gothic Heavy" Font-Size="Larger"></asp:label><asp:label id="Label4" style="Z-INDEX: 105; LEFT: 448px; POSITION: absolute; TOP: 152px" runat="server"
				Width="320px" Font-Names="Franklin Gothic Heavy" Font-Size="Larger"></asp:label><asp:label id="Label6" style="Z-INDEX: 106; LEFT: 328px; POSITION: absolute; TOP: 48px" runat="server"
				ForeColor="DimGray" BackColor="Transparent" BorderColor="Transparent" Font-Names="Elephant" Font-Size="XX-Large" Font-Underline="True"></asp:label><asp:button id="Button2" style="Z-INDEX: 107; LEFT: 8px; POSITION: absolute; TOP: 8px" runat="server"
				Text="Back" tabIndex="7"></asp:button><input id="PageY" style="Z-INDEX: 108; LEFT: 0px; POSITION: absolute; TOP: 32px" type="hidden"
				value="0" name="PageY" runat="server"> <input id="xvalue" style="Z-INDEX: 109; LEFT: 0px; POSITION: absolute; TOP: 56px" type="hidden"
				value="0" name="xvalue" runat="server"> <input id="yvalue" style="Z-INDEX: 110; LEFT: 0px; POSITION: absolute; TOP: 80px" type="hidden"
				value="0" name="yvalue" runat="server"><input id="PageX" style="Z-INDEX: 111; LEFT: 0px; POSITION: absolute; TOP: 8px" type="hidden"
				value="0" name="PageX" runat="server">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<asp:button id="Button4" style="Z-INDEX: 112; LEFT: 32px; POSITION: absolute; TOP: 88px" runat="server"
				Width="145px" Text="Travel and Training" tabIndex="2"></asp:button><asp:imagebutton id="ImageButton1" style="Z-INDEX: 113; LEFT: 576px; POSITION: absolute; TOP: 56px"
				runat="server" Width="8px" ImageUrl="bk6.jpg" Height="1px"></asp:imagebutton><asp:button id="Button3" style="Z-INDEX: 114; LEFT: 32px; POSITION: absolute; TOP: 152px" runat="server"
				Width="145px" Text="Summary" tabIndex="4"></asp:button><asp:button id="Button7" style="Z-INDEX: 115; LEFT: 32px; POSITION: absolute; TOP: 120px" runat="server"
				Width="145" Text="Capital Expenditure" tabIndex="3"></asp:button><asp:button id="Button8" style="Z-INDEX: 116; LEFT: 32px; POSITION: absolute; TOP: 56px" runat="server"
				Width="145px" Text="Salaries" tabIndex="1"></asp:button>
			<asp:Image id="Image1" style="Z-INDEX: 117; LEFT: 856px; POSITION: absolute; TOP: 8px" runat="server"
				ImageUrl="LCL.jpg"></asp:Image></form>
		<script language="javascript">
		var IE=document.all?true:false
		//document.onmousemove=getMousepoints;  code pour mousex, y
		var mousex=0;
		var mousey=0;

function getMousepoints(){   
mousex=event.clientX+document.body.scrollLeft 
mousey=event.clientY+document.body.scrollTop


document.Form1.xvalue.value=mousex;  
document.Form1.yvalue.value=mousey;  
  return true;      
}
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
