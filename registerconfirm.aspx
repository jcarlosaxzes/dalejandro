<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="registerconfirm.aspx.vb" Inherits="pasconcept20.registerconfirm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Register Confirm</title>
</head>
<body style="background-color: white; padding-top: 200px;">
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" EnableCdn="true" runat="server">
        </telerik:RadScriptManager>
        <table align="center" class="RegisterCentralPanel" style="width:550px">
            <tr>
                <td style="text-align: center">
                    <asp:Image ID="Image3" runat="server" ImageUrl="~/Images/logo.png" />
                </td>
            </tr>
            <tr>
                <td class="Titulo3" align="center">
                    <asp:Label ID="lblTitle" runat="server" Text="Registration completed"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="padding-left: 15px; padding-top: 15px; height: 160px; text-align: center">
                    <br />
                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                    &nbsp;<asp:HyperLink ID="lnkBegin" runat="server" NavigateUrl="~/ADMCLI/Roles.aspx">click here</asp:HyperLink>
                </td>
            </tr>
        </table>
        <table align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td align="center">
                    <asp:HyperLink ID="lnkHelp" runat="server" CssClass="EnlaceGrisSmall" NavigateUrl="http://blog.pasconcept.com"
                        Target="_blank">Help</asp:HyperLink>
                    &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;
                    <asp:HyperLink ID="HyperLink2" runat="server" CssClass="EnlaceGrisSmall"
                        NavigateUrl="https://pasconcept.com/Legal/ENG/Terms.html" Target="_blank">Terms & Conditions</asp:HyperLink>
                    &nbsp;</td>
            </tr>
        </table>
        <asp:Label ID="lblVersion" runat="server" Text="0" Visible="false"></asp:Label>
    </form>
</body>
</html>
