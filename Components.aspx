<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Components.aspx.vb" Inherits="RevenueForecast.Components"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Expenses</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body onscroll="javascript:setcoords()" bgProperties="fixed" bgColor="#f0f8ff" background="bk5.jpg"
		onload="javascript:ScrollIt()" MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:datagrid id="DataGrid1" style="Z-INDEX: 101; LEFT: 0px; POSITION: absolute; TOP: 0px" runat="server"
				ForeColor="Black" Width="360px" ShowFooter="True" AutoGenerateColumns="False" GridLines="Horizontal"
				CellPadding="3" BackColor="White" BorderWidth="3px" BorderStyle="Double" BorderColor="#336666">
				<FooterStyle ForeColor="Black" BackColor="Gainsboro"></FooterStyle>
				<SelectedItemStyle Font-Bold="True" ForeColor="#F7F7F7" BackColor="#738A9C"></SelectedItemStyle>
				<AlternatingItemStyle BackColor="#F7F7F7"></AlternatingItemStyle>
				<ItemStyle ForeColor="Black" BackColor="WhiteSmoke"></ItemStyle>
				<HeaderStyle Font-Bold="True" HorizontalAlign="Center" ForeColor="White" BackColor="#336666"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn HeaderText="Description">
						<ItemTemplate>
							<asp:Label id="Label4" runat="server"></asp:Label>
						</ItemTemplate>
						<FooterTemplate>
							<asp:TextBox id="TextBox4" runat="server"></asp:TextBox>
						</FooterTemplate>
						<EditItemTemplate>
							<asp:TextBox id="TextBox3" runat="server"></asp:TextBox>
						</EditItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Amount">
						<ItemTemplate>
							<asp:Label id="Label3" runat="server" Width="80px"></asp:Label>
						</ItemTemplate>
						<FooterTemplate>
							<asp:Label id="Label2" runat="server">$</asp:Label>
							<asp:TextBox id="TextBox2" runat="server" Width="72px">0</asp:TextBox>
						</FooterTemplate>
						<EditItemTemplate>
							<asp:Label id="Label1" runat="server">$</asp:Label>
							<asp:TextBox id="TextBox1" runat="server" Width="72px">0</asp:TextBox>
						</EditItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Add/Delete">
						<ItemTemplate>
							<asp:Button id="Button4" runat="server" CommandName="Edit" Text="Edit"></asp:Button>
							<asp:Button id="Button1" runat="server" Width="48px" CommandName="Delete" Text="Delete"></asp:Button>
						</ItemTemplate>
						<FooterTemplate>
							<asp:Button id="Button2" runat="server" CommandName="Add" Text="Add"></asp:Button>
							<asp:Button id="Button3" runat="server" CommandName="end" Text="Finish"></asp:Button>
						</FooterTemplate>
					</asp:TemplateColumn>
					<asp:BoundColumn HeaderText="ComponentID"></asp:BoundColumn>
				</Columns>
				<PagerStyle HorizontalAlign="Right" ForeColor="#4A3C8C" BackColor="#E7E7FF" Mode="NumericPages"></PagerStyle>
			</asp:datagrid><input id="PageY" style="Z-INDEX: 102; LEFT: 0px; POSITION: absolute; TOP: 32px" type="hidden"
				value="0" name="PageY" runat="server"><input id="PageX" style="Z-INDEX: 103; LEFT: 0px; POSITION: absolute; TOP: 8px" type="hidden"
				value="0" name="PageX" runat="server"></form>
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
    document.Form1.PageY.value = 10000000;
    }
		</script>
	</body>
</HTML>
