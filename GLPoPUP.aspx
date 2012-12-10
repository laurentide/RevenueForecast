<%@ Page Language="vb" AutoEventWireup="false" Codebehind="GLPoPUP.aspx.vb" Inherits="RevenueForecast.GLPoPUP"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Help</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</HEAD>
	<body MS_POSITIONING="GridLayout" background="bk5.jpg">
		<form id="Form1" method="post" runat="server">
			<asp:TextBox id="TextBox1" style="Z-INDEX: 101; LEFT: 8px; POSITION: absolute; TOP: 40px" runat="server"
				Width="368px" Height="176px" ReadOnly="True" TextMode="MultiLine"></asp:TextBox>
			<asp:Label id="Label1" style="Z-INDEX: 102; LEFT: 16px; POSITION: absolute; TOP: 8px" runat="server"
				Font-Bold="True" Font-Underline="True" Width="360px"></asp:Label>
			<asp:Button id="Button1" style="Z-INDEX: 103; LEFT: 168px; POSITION: absolute; TOP: 224px" runat="server"
				Text="Close"></asp:Button>
		</form>
	</body>
</HTML>
