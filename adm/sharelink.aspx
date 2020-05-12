<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="sharelink.aspx.vb" Inherits="pasconcept20.sharelink" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Share Link</title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" EnableCdn="true" runat="server">
        </telerik:RadScriptManager>


        <table style="width: 480px" cellpadding="3" cellspacing="3">
            <tr>
                <td style="text-align:center; padding-top: 10px;" class="Titulo3" >
                    <asp:Image ID="Image2" runat="server" ImageUrl="~/Images/Toolbar/shrared_60x60.jpg" />
                </td>
            </tr>
            <tr>
                <td style="text-align:center; padding-top: 15px;" class="Titulo3" >Share Link Chooser
                </td>
            </tr>
            <tr>
                <td style="text-align:center; padding-top: 10px;">Share Link Chooser, get a private link of <b><asp:Label ID="lblObjType" runat="server" Text="Proposal"></asp:Label> &nbsp;Report</b> to copy and paste in email or browser
                    <br />To use this link, the user does not need to be logged to PASconcept</td>
            </tr>
            <tr>
                <td style="text-align:center;padding-top: 30px;">
                    <telerik:RadTextBox ID="txtURL" SelectionOnFocus="SelectAll" runat="server" EmptyMessage="Click buton to get link" Width="95%" Skin="MetroTouch">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align:right; padding-top: 50px; padding-right: 10px" class="Pequena">Anyone with this link can see the information
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
