<%@ Page Title="Send Digital Transmittal" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="sendtransmittal.aspx.vb" Inherits="pasconcept20.sendtransmittal" %>

<%@ MasterType VirtualPath="~/ADM/BasicMasterPage.master" %>
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
            <h4>Send Digital Transmittal</h4>
            <asp:Panel ID="PanelEmail" runat="server">
                <table style="width: 100%" class="table-sm" >

                    <tr>
                        <td>To:
                        </td>
                        <td style="width: 45%">
                            <telerik:RadTextBox ID="txtTo" runat="server" Width="100%">
                            </telerik:RadTextBox>
                        </td>
                        <td>CC:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtCC" runat="server" Width="100%">
                            </telerik:RadTextBox>
                        </td>
                    </tr>

                    <tr>
                        <td>Subject:
                        </td>
                        <td colspan="3">
                            <telerik:RadTextBox ID="txtSubject" runat="server" Width="700px">
                            </telerik:RadTextBox>
                            &nbsp;&nbsp;&nbsp;
                            <asp:LinkButton ID="btnEnviar" runat="server" ToolTip="Send Email with Statement information"
                                CssClass="btn btn-info btn" UseSubmitBehavior="false">
                                    <i class="far fa-envelope"></i> Send
                            </asp:LinkButton>
                        </td>
                        <td style="text-align:right">
                            
                        </td>
                    </tr>

                    <tr>
                        <td colspan="4">

                            <telerik:RadEditor ID="txtBody" runat="server" Height="380px" RenderMode="Auto"
                                AllowScripts="True" EditModes="Design,Preview" Width="100%">
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
                        <td colspan="4">
                            <asp:Label ID="lblMailResult" runat="server" Style="font-size: medium; color: #cc0000; font-family: Calibri, Verdana"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
    </div>


    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblTransmittalId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblOrigen" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
</asp:Content>

