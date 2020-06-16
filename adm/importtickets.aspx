<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="importtickets.aspx.vb" Inherits="pasconcept20.importtickets" %>

<%@ MasterType VirtualPath="~/ADM/BasicMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2 style="margin: 0; text-align: center; color:white; width: 100%">
        <span class="navbar navbar-expand-md bg-dark text-white">
            <asp:Label ID="lblJob" runat="server"></asp:Label>
        </span>
    </h2>
    <br /><br /><br />
    <table class="table-sm" style="width: 100%; text-align: left">
        <tr>
            <td style="width: 150px; text-align: right">Source:
            </td>
            <td>
                <telerik:RadDropDownList ID="cboSource" runat="server" AppendDataBoundItems="true" Width="350px">
                    <Items>
                        <telerik:DropDownListItem Text="PASconcept Tickets CSV" />
                        <telerik:DropDownListItem Text="Jira Cards CSV" />
                    </Items>
                </telerik:RadDropDownList>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <telerik:RadAsyncUpload ID="RadUpload1" runat="server" ControlObjectsVisibility="None" MultipleFileSelection="Disabled" EnableFileInputSkinning="true"
                    AllowedFileExtensions="csv,txt">
                </telerik:RadAsyncUpload>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center">
                <br /><br />
                <asp:LinkButton ID="btnImport" runat="server" CssClass="btn btn-success btn-lg" ToolTip="Import records from CSV file" UseSubmitBehavior="false">
                    <i class="fas fa-upload"></i>    
                    Import
                </asp:LinkButton>
            </td>
        </tr>
    </table>
    <div>
        <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
            <p style="color: red"><%: SuccessMessageText %></p>
        </asp:PlaceHolder>
    </div>

    <asp:Label ID="lblCompanyId" runat="server" Text="0" Visible="False"></asp:Label>
    <asp:Label ID="lblJobId" runat="server" Text="0" Visible="False"></asp:Label>

</asp:Content>

