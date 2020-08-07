<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="leads.aspx.vb" Inherits="pasconcept20.leads" %>
<%@ MasterType VirtualPath="~/master/MasterPage.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnFind">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnFind"  LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                    <telerik:AjaxUpdatedControl ControlID="lblSELECTed_ID" />
                    
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnConfirmExport">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnConfirmExport"  LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipExport" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />--%>

        <table style="width: 100%">
        <tr>
            <td colspan="2">
                <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
                    <table class="table-sm pasconcept-bar" style="width: 100%">
                        <tr>
                            <td style="width: 60px; text-align: right">State:
                            </td>
                            <td style="width: 60px">
                               <telerik:RadTextBox ID="txtState" runat="server" Text="FL" MaxLength="15" Width="100%">
                                        </telerik:RadTextBox>
                            </td>
                            <td style="width: 150px; text-align: right">Biginig of Zip Code:
                            </td>
                            <td style="width: 100px">
                               <telerik:RadTextBox ID="txtZipCode" runat="server" Text="" MaxLength="10" Width="100%">
                                        </telerik:RadTextBox>
                            </td>
                            <td style="width: 150px; text-align: right">Biginig of Phone:
                            </td>
                            <td style="width: 100px">
                               <telerik:RadTextBox ID="txtPhone" runat="server" Text="" MaxLength="10" Width="100%">
                                        </telerik:RadTextBox>
                            </td>
                            <td style="width: 50px; text-align: right">City:
                            </td>
                            <td style="width: 100px">
                               <telerik:RadTextBox ID="txtCity" runat="server" Text="" MaxLength="50" Width="100%">
                                        </telerik:RadTextBox>
                            </td>
                            <td style="width: 100px; text-align: right">Contain Tags:
                            </td>
                            <td style="width: 150px">
                               <telerik:RadTextBox ID="txtTags" runat="server" Text="" MaxLength="100" Width="100%">
                                        </telerik:RadTextBox>
                            </td>
                            <td style="width: 150px; text-align: right">Not Contain Tags:
                            </td>
                            <td style="width: 150px">
                               <telerik:RadTextBox ID="txtNoTags" runat="server" Text="FL305" MaxLength="100" Width="100%">
                                        </telerik:RadTextBox>
                            </td>
                            <td>
                                <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    Filter/Search
                                </asp:LinkButton>
                            </td>
                            <td style="text-align: right">
                                <asp:LinkButton ID="btnExport" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false">
                                     Export
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None" Width="100%" AutoGenerateColumns="False" CellSpacing="0" AllowSorting="True"
                    AllowPaging="True" PageSize="100" ShowHeader="true" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-HorizontalAlign="Center">
                    <MasterTableView DataSourceID="SqlDataSource1">
                        <Columns>
                            <telerik:GridBoundColumn DataField="ID" HeaderText="ID" SortExpression="ID" UniqueName="ID" HeaderStyle-Width="100px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ContactName" HeaderText="Contact Name" SortExpression="ContactName" UniqueName="ContactName">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Company" HeaderText="Company" SortExpression="Company" UniqueName="Company">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Email" HeaderText="Email" SortExpression="Email" UniqueName="Email">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Phone" HeaderText="Phone" SortExpression="Phone" UniqueName="Phone">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Address" HeaderText="Address" SortExpression="Address" UniqueName="Address">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Tags" HeaderText="Tags" SortExpression="Tags" UniqueName="Tags">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SourceId" HeaderText="SourceId" SortExpression="SourceId" UniqueName="SourceId">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>

    <telerik:RadToolTip ID="RadToolTipExport" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h3 style="margin: 0; text-align: center; color: white; width: 600px">
            <span class="navbar navbar-expand-md bg-dark text-white">Export to CSV File
            </span>
        </h3>
        <table class="table-sm" style="width: 600px">
            <tr>
                <td style="text-align:right;width:150px">TAG (exported rows):
                </td>
                <td>
                    <telerik:RadTextBox ID="txtExportTag" runat="server" Text="" MaxLength="100" Width="100%">
                                        </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center">
                    <asp:LinkButton ID="btnConfirmExport" runat="server" CssClass="btn btn-success" Width="150px" UseSubmitBehavior="false">
                             Export 
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server"  ConnectionString="<%$ ConnectionStrings:cnnAxzesLeads %>"
        SelectCommand="Leads_SELECT" SelectCommandType="StoredProcedure" 
        UpdateCommand="Leads_Tags_Bulk_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtState" Name="State" PropertyName="Text" ConvertEmptyStringToNull="false"  />
            <asp:ControlParameter ControlID="txtZipCode" Name="ZipCode" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtPhone" Name="Phone" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtCity" Name="City" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtTags" Name="Tag" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtNoTags" Name="NoTag" PropertyName="Text" ConvertEmptyStringToNull="false" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="txtState" Name="State" PropertyName="Text" ConvertEmptyStringToNull="false"  />
            <asp:ControlParameter ControlID="txtZipCode" Name="ZipCode" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtPhone" Name="Phone" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtCity" Name="City" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtNoTags" Name="NoTag" PropertyName="Text" ConvertEmptyStringToNull="false" />

            <asp:ControlParameter ControlID="txtExportTag" Name="UpdateTag" PropertyName="Text" ConvertEmptyStringToNull="false" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblSELECTed_ID" runat="server" Visible="False" Text=""></asp:Label>

</asp:Content>
