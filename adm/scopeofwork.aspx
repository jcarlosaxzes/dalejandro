<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="scopeofwork.aspx.vb" Inherits="pasconcept20.scopeofwork" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Scope of Work</title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align:right">
            <asp:Button runat="server" ID="btnDownload" Text="Download" ></asp:Button>
        </div>
        <div>
            <h3>Scope of Work</h3>
            <asp:Label runat="server" ID="lblContent"></asp:Label>
        </div>

        <telerik:RadEditor ID="txtHTML" runat="server" Visible="false" >
                        </telerik:RadEditor>
        <asp:Label ID="lblProposalId" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblJobId" runat="server" Visible="False"></asp:Label>
    </form>
</body>
</html>
