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
            <br />

             <asp:Button ID="Button3" runat="server" Text="Move Client Files" />&nbsp;&nbsp;  <asp:Label ID="lblCliet" runat="server" Text=""></asp:Label>
            <br />
&nbsp;&nbsp;&nbsp;
            <br />
            <br />

             <asp:Button ID="Button4" runat="server" Text="Move RequestFroProporsal Files" />&nbsp;&nbsp;  <asp:Label ID="lblrfproporsal" runat="server" Text=""></asp:Label>
            <br />
&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <br />

             <asp:Button ID="Invoices_payment" runat="server" Text="Move Invoces payments Files" />&nbsp;&nbsp;  <asp:Label ID="lblInvoice_payment" runat="server" Text=""></asp:Label>
            <br />
&nbsp;&nbsp;&nbsp;
            <br />

        </div>
    </form>
</body>
</html>
