<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="register.aspx.vb" Inherits="pasconcept20.register1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Register</title>
</head>
<body style="background-color: white; padding-top: 200px;">
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        </telerik:RadScriptManager>
        <table align="center" class="RegisterCentralPanel">
            <tr>
                <td style="text-align: center">
                    <asp:Image ID="Image3" runat="server" ImageUrl="~/Images/logo.png" meta:resourcekey="Image3Resource1" />
                </td>
            </tr>
            <tr>
                <td  class="Titulo3" align="center">
                    <asp:Label ID="lblVersinoName" runat="server" Text="30 days Free Trial"></asp:Label> 
                </td>
            </tr>
            <tr>
                <td style="padding-left:15px;text-align:center">
                    <br />
                    To create your <b>30 days Trial PASconcept account</b>, enter your email address and the characters shown below.<br />
                    <asp:Label ID="lblMsg" runat="server" CssClass="Error" meta:resourcekey="lblMsgResource1"></asp:Label>
                    <br />
                    </td>
            </tr>
            <tr>
                <td style="text-align: left; padding-left: 50px">
                    <br />
                    <telerik:RadTextBox ID="txtEmail" runat="server" Skin="MetroTouch" EmptyMessage="Email" LabelWidth="64px" Resize="None" Width="400px" meta:resourcekey="txtEmailResource1">
                    </telerik:RadTextBox>
                    &nbsp;<br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtEmail" ValidationGroup="SubmitInfo"
                        runat="server" ErrorMessage="(*) Enter an valid email address" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                        Display="Dynamic" meta:resourcekey="RegularExpressionValidator1Resource1"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmail" ValidationGroup="SubmitInfo"
                        ErrorMessage="(*) Email is Required" Display="Dynamic" meta:resourcekey="RequiredFieldValidator2Resource1"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="text-align: left; padding-left: 50px;padding-top:15px">
                    <telerik:RadCaptcha ID="RadCaptcha1" runat="server" Skin="MetroTouch" ValidationGroup="SubmitInfo" 
                        CaptchaTextBoxLabel="" CaptchaTextBoxLabelCssClass="Normal" EnableRefreshImage="True" meta:resourcekey="RadCaptcha1Resource1" CaptchaLinkButtonText="Generate new image">
                        <CaptchaImage LineNoise="Low" TextLength="4" BackgroundColor="#dff3ff" />
                    </telerik:RadCaptcha>
                </td>
            </tr>
            <tr>
                <td style="text-align: right; padding-right: 40px; padding-bottom:15px; height: 40px; vertical-align: middle">&nbsp;
                    <br />
                    <telerik:RadButton ID="btbCreate" runat="server" Text="Create PASconcept account" Skin="BlackMetroTouch" ValidationGroup="SubmitInfo" meta:resourcekey="btbCreateResource1">
                </telerik:RadButton>
                    <br />
                </td>
            </tr>
        </table>
        <table align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td align="center">
                    <asp:HyperLink ID="lnkHelp" runat="server" CssClass="EnlaceGrisSmall" NavigateUrl="http://blog.pasconcept.com"
                        Target="_blank" meta:resourcekey="lnkHelpResource1">Help</asp:HyperLink>
                    &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; <asp:HyperLink ID="HyperLink2" runat="server" CssClass="EnlaceGrisSmall"
                        NavigateUrl="https://pasconcept.com/Legal/ENG/Terms.html" Target="_blank" meta:resourcekey="HyperLink2Resource1">Terms & Condition</asp:HyperLink>
                    &nbsp;</td>
            </tr>
        </table>
        <asp:Label ID="lblVersion" runat="server" Text="0" Visible="False" meta:resourcekey="lblVersionResource1"></asp:Label>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>" 
            InsertCommand="sys_preUser_INSERT" InsertCommandType="StoredProcedure">
            <InsertParameters>
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                <asp:ControlParameter ControlID="txtEmail" Name="Email" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="lblVersion" Name="Version" PropertyName="Text" Type="Int32" />
                <asp:Parameter Direction="Output" Name="GUID_OUT" DbType="Guid" />
            </InsertParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
