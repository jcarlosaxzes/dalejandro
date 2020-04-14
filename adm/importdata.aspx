<%@ Page Title="Import Data" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="importdata.aspx.vb" Inherits="pasconcept20.importdata" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2>Import data from "CSV" files</h2>
    <div class="PanelFilter">
        <h3>Instructions</h3>
        <ol>
            <li>Select Target</li>
            <li>Download template XLS file</li>
            <li>MS-Excel. Open XLS file, fill the data by columns</li>
            <li>MS-Excel. Save file As "CSV (Comma delimited)(*.csv)"</li>
            <li>Select File "CSV (Comma delimited)(*.csv)"</li>
            <li>Clic Import button</li>
        </ol>
        <h3>Requirements</h3>
        <ol>
            <li>Name Unique and Not Empty</li>
            <li>Email Unique or Empty</li>
        </ol>
    </div>
    
    <table class="table-condensed" style="width: 800px" >
        <tr>
            <td colspan="2">
                <hr />
            </td>
        </tr>
        <tr>
            <td style="width: 150px; text-align: right">Select Target:</td>
            <td>
                <telerik:RadComboBox ID="cboDestino" runat="server" AutoPostBack="True" Width="100%">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="Contacts" Value="Contacts" />
                        <telerik:RadComboBoxItem runat="server" Text="Outlook Contacts" Value="OutlookContacts" />
                        <telerik:RadComboBoxItem runat="server" Text="Update Exported Contacts" Value="ExportedContacts" />
                        <telerik:RadComboBoxItem runat="server" Text="Clients" Value="Clients" />
                        <telerik:RadComboBoxItem runat="server" Text="Employees" Value="Employees" />
                        <telerik:RadComboBoxItem runat="server" Text="Subconsultants" Value="Subconsultants" />
                    </Items>
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">Character Separator:</td>
            <td>
                <telerik:RadComboBox ID="cboSeparator" runat="server">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="Comma (,)" Value="," />
                        <telerik:RadComboBoxItem runat="server" Text="Semicolon (;)" Value=";" />
                    </Items>
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">Download Template File:</td>
            <td>
                <asp:HyperLink ID="lnkSample" runat="server"
                    Target="_blank">.</asp:HyperLink>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;vertical-align:top">Source File (csv):</td>
            <td>
                <telerik:RadAsyncUpload ID="RadUpload1" runat="server" ControlObjectsVisibility="None" MultipleFileSelection="Disabled" EnableFileInputSkinning="true"
                        AllowedFileExtensions="csv,txt">
                    </telerik:RadAsyncUpload>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;padding-top:15px;padding-right:50px" colspan="2">
                <telerik:RadPushButton ID="btnImport" runat="server" Text="Import Data" ToolTip="Import records from CSV files" UseSubmitBehavior="false">
                    <Icon CssClass="rbUpload"></Icon>
                </telerik:RadPushButton>
            </td>
        </tr>
    </table>
    <asp:Label ID="lblMsg" runat="server" CssClass="Error"></asp:Label>
    <br />
    <br />
    <br />
    <br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"></asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>

