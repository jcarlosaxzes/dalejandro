<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="masscommunication.aspx.vb" Inherits="pasconcept20.masscommunication" %>


<%@ MasterType VirtualPath="~/master/MasterPage.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnEnviar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PanelEmail" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />


    <div class="row">
        <div class="col-md-12">
            <h2>AXZES Mass Email Communication</h2>
            <table style="width: 100%" class="table-condensed">
                <tr>
                    <td style="width: 150px; text-align: right">To:
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboTo" runat="server" Width="600px" EnableTextSelection="true" AllowCustomText="true" EmptyMessage="">
                            <Items>
                                <telerik:RadComboBoxItem Text="(Type Emails comma separated or Select option:...)" Value="0" Selected="true" />
                                <telerik:RadComboBoxItem Text="Active Company (Master Contact)" Value="4" />
                                <telerik:RadComboBoxItem Text="Inactive Company (Master Contact)" Value="5" />
                                <telerik:RadComboBoxItem Text="All Active/Inactive Company (Master Contact)" Value="6" />
                                <telerik:RadComboBoxItem Text="Active Employee Users" Value="1" />
                                <telerik:RadComboBoxItem Text="Inactive Employee Users " Value="2" />
                                <telerik:RadComboBoxItem Text="Active/Inactive Employee Users " Value="3" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>

                <tr>
                    <td style="text-align: right">Subject:
                    </td>
                    <td colspan="3">
                        <telerik:RadTextBox ID="txtSubject" runat="server" Width="100%">
                        </telerik:RadTextBox>
                    </td>
                </tr>

                <tr>
                    <td colspan="2">
                        <telerik:RadEditor ID="txtBody" runat="server" Height="380px" RenderMode="Auto" EmptyMessage="Body"
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
                <tr>
                    <td colspan="2" style="text-align: right; padding-right: 50px">
                        <asp:LinkButton ID="btnSend" runat="server" ToolTip="Send aass Email Communication" CausesValidation="true" ValidationGroup="Send"
                            CssClass="btn btn-info btn-lg" UseSubmitBehavior="false">
                                    <i class="far fa-envelope"></i> Send
                        </asp:LinkButton>

                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Label ID="lblMailResult" runat="server" Style="font-size: medium; color: #cc0000; font-family: Calibri, Verdana"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div>
        <asp:CompareValidator runat="server" ID="Comparevalidator3" SetFocusOnError="true" Display="None" Operator="NotEqual"
            ControlToValidate="cboTo"
            ErrorMessage="Select To is required"
            ValueToCompare="(Type Emails comma separated or Select option:...)"
            ValidationGroup="Send">
        </asp:CompareValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="None" ValidationGroup="Send" SetFocusOnError="true"
            ControlToValidate="txtSubject"
            ErrorMessage="Subject is required">
        </asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="None" ValidationGroup="Send" SetFocusOnError="true"
            ControlToValidate="txtBody"
            ErrorMessage="Body is required">
        </asp:RequiredFieldValidator>
    </div>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblStatementId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblOrigen" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>


</asp:Content>

