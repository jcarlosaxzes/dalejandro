<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="sendticketpage.aspx.vb" Inherits="pasconcept20.sendticketpage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Send Ticket Page</title>
    <link href="~/Content/bootstrap.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" EnableCdn="true" runat="server">
        </telerik:RadScriptManager>

        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSent">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PanelEmail" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="btnSent" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting></telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />

        <h3 style="margin: 0">
            <asp:Label ID="lblJob" runat="server"></asp:Label>
        </h3>
        <asp:Panel ID="PanelEmail" runat="server">
            <table style="width: 100%" class="table-condensed">
                <tr>
                    <td>To:
                    </td>
                    <td style="width: 45%">
                        <telerik:RadTextBox ID="txtTo" runat="server" Width="100%" EmptyMessage="Business Client Email">
                        </telerik:RadTextBox>
                    </td>
                    <td>CC:
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtBCC" runat="server" Width="100%" EmptyMessage="Business Client Copy Email">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td>Subject:
                    </td>
                    <td colspan="3">
                        <telerik:RadTextBox ID="txtSubject" runat="server" Width="100%">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <telerik:RadEditor ID="txtBody" runat="server" Height="400px" RenderMode="Auto"
                            AllowScripts="True" EditModes="Design" Width="100%">
                            <Tools>
                                <telerik:EditorToolGroup>
                                    <telerik:EditorTool Name="Cut" />
                                    <telerik:EditorTool Name="Copy" />
                                    <telerik:EditorTool Name="Paste" />
                                </telerik:EditorToolGroup>
                            </Tools>
                        </telerik:RadEditor>
                    </td>
                </tr>

            </table>
            <div style="text-align:center">
                 <asp:LinkButton runat="server" ID="btnSent" CssClass="btn btn-info" ToolTip="Send Email" CausesValidation="true" ValidationGroup="Send">
                      <span class="glyphicon glyphicon-envelope"> Send</span>
                </asp:LinkButton>
            </div>
        </asp:Panel>
        <div>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ForeColor="Red" runat="server" ValidationGroup="Send" SetFocusOnError="true"
            ControlToValidate="txtTo"
            ErrorMessage="<span class='val-msg'><b>Email To/Module</b> is required</span>">
        </asp:RequiredFieldValidator>
        </div>

        <asp:Label ID="lblCompanyId" runat="server" Text="0" Visible="False"></asp:Label>
        <asp:Label ID="lblJobId" runat="server" Text="0" Visible="False"></asp:Label>
        <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblClientId" runat="server" Visible="False"></asp:Label>

    </form>
</body>
</html>
