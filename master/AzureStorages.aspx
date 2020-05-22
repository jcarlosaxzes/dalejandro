<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AzureStorages.aspx.vb" Inherits="pasconcept20.AzureStorages" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Company Id&nbsp;&nbsp;
            <asp:TextBox ID="txtCompanyId" runat="server"></asp:TextBox>

            &nbsp;&nbsp;&nbsp;&nbsp;Count Files&nbsp;&nbsp;
            <asp:TextBox ID="txtCount" runat="server" Text="100"></asp:TextBox>

            <br />
            <br />
            <asp:Button ID="Button1" runat="server" Text="Move Jobs Files" />&nbsp;&nbsp;  <asp:Label ID="lbResutl" runat="server" Text=""></asp:Label>
            <br />
&nbsp;&nbsp;&nbsp;
            <br />

            <asp:Button ID="Button2" runat="server" Text="Move Proposal Files" />&nbsp;&nbsp;  <asp:Label ID="lblProposal" runat="server" Text=""></asp:Label>
            <br />
&nbsp;&nbsp;&nbsp;
            <br />
        </div>
    </form>
</body>
</html>
