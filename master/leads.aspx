﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="leads.aspx.vb" Inherits="pasconcept20.leads" %>
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
                            <td style="width: 150px; text-align: right">
                                State:
                            </td>
                            <td style="width: 150px">
                               <telerik:RadTextBox ID="txtState" runat="server" MaxLength="15" Width="100%">
                                        </telerik:RadTextBox>
                            </td>
                            <td style="width: 150px; text-align: right">
                                Biginig Zip Code:
                            </td>
                            <td style="width: 150px">
                               <telerik:RadTextBox ID="txtZipCode" runat="server" Text="" MaxLength="10" Width="100%">
                                        </telerik:RadTextBox>
                            </td>
                            <td style="width: 150px; text-align: right">Biginig Phone:
                            </td>
                            <td style="width: 150px">
                               <telerik:RadTextBox ID="txtPhone" runat="server" Text="" MaxLength="10" Width="100%">
                                        </telerik:RadTextBox>
                            </td>
                            <td style="width: 150px; text-align: right">City:
                            </td>
                            <td>
                               <telerik:RadTextBox ID="txtCity" runat="server" Text="" MaxLength="50" Width="150px">
                                        </telerik:RadTextBox>
                            </td>
                           
                        </tr>
                        <tr>
                        <td style="text-align: right">Contain Tags:
                            </td>
                            <td>
                               <telerik:RadTextBox ID="txtTags" runat="server" Text="" MaxLength="100" Width="100%">
                                        </telerik:RadTextBox>
                            </td>
                            <td style="text-align: right">Not Contain Tags:
                            </td>
                            <td>
                               <telerik:RadTextBox ID="txtNoTags" runat="server" MaxLength="100" Width="100%">
                                        </telerik:RadTextBox>
                            </td>
                            <td style="text-align: right">Source:
                            </td>
                            <td>
                                <telerik:RadComboBox ID="cboSource" runat="server" DataSourceID="SqlDataSourceSources" DataTextField="Name" DataValueField="Id" Width="350px"
                                    AppendDataBoundItems="true" Height="300px" MarkFirstMatch="True">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(All Sources List...)" Value="-1" Selected="true" />
                                    </Items>
                                </telerik:RadComboBox>


                            </td>
                            <td>
                                <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    Filter/Search
                                </asp:LinkButton>
                            </td>
                            <td>
                                <span style="float: right; vertical-align: middle;">
                                    <asp:LinkButton ID="btnBulkTag" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" ToolTip="Tag Selected records">
                                         Bulk Tag
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnExport" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" ToolTip="Export and (optional)Tag current List">
                                         Export
                                    </asp:LinkButton>
                                </span>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None" Width="100%" AutoGenerateColumns="False" CellSpacing="0" AllowSorting="True"
                    AllowPaging="True" PageSize="100" ShowHeader="true" ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" HeaderStyle-HorizontalAlign="Center"
                    Height="800px" AllowMultiRowSelection="True">
                    <ClientSettings Selecting-AllowRowSelect="true">
                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                    </ClientSettings>
                    <MasterTableView DataSourceID="SqlDataSource1">
                        <Columns>
                            <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" UniqueName="ClientSelectColumn">
                            </telerik:GridClientSelectColumn>
                            <telerik:GridBoundColumn DataField="ID" HeaderText="ID" SortExpression="ID" UniqueName="ID" HeaderStyle-Width="60px" ItemStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Company" HeaderText="Company" SortExpression="Company" UniqueName="Company" HeaderStyle-Width="180px" ItemStyle-Font-Bold="true">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ContactName" HeaderText="Contact Name" SortExpression="ContactName" UniqueName="ContactName" HeaderStyle-Width="150px" ItemStyle-Font-Bold="true">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Position" HeaderText="Position" SortExpression="Position" UniqueName="Position"  HeaderStyle-Width="120px"  >
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="JobTitle" HeaderText="Job Title - Capabiliy" SortExpression="JobTitle" UniqueName="JobTitle" HeaderStyle-Width="280px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Email" HeaderText="Email" SortExpression="Email" UniqueName="Email" HeaderStyle-Width="150px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Phone" HeaderText="Phone" SortExpression="Phone" UniqueName="Phone"  HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="WebSite" HeaderText="WebSite" SortExpression="WebSite" UniqueName="WebSite" HeaderStyle-Width="150px">
                               <ItemTemplate>
                                   <a href='<%# Eval("WebSite") %>' target="_blank"><%# Eval("WebSite") %></a>
                               </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="Address" HeaderText="Address" SortExpression="Address" UniqueName="Address" HeaderStyle-Width="180px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Source" HeaderText="Source" SortExpression="Source" UniqueName="Source" HeaderStyle-Width="150px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Tags" HeaderText="Tags" SortExpression="Tags" UniqueName="Tags" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center">
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

     <telerik:RadToolTip ID="RadToolTipTagSelected" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h3 style="margin: 0; text-align: center; color: white; width: 600px">
            <span class="navbar navbar-expand-md bg-dark text-white">Bulk Tag Update
            </span>
        </h3>
        <table class="table-sm" style="width: 600px">
            <tr>
                <td style="text-align:right;width:150px">TAG (selected rows):
                </td>
                <td>
                    <telerik:RadTextBox ID="txtBulkTag" runat="server" Text="" MaxLength="100" Width="100%">
                                        </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center">
                    <asp:LinkButton ID="btnBulkTagConfirm" runat="server" CssClass="btn btn-success" Width="150px" UseSubmitBehavior="false">
                             Export 
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server"  ConnectionString="<%$ ConnectionStrings:cnnAxzesLeads %>"
        SelectCommand="Leads_SELECT" SelectCommandType="StoredProcedure" 
        UpdateCommand="Leads_Tags_Bulk_UPDATE" UpdateCommandType="StoredProcedure" 
        InsertCommand="Leads_Tags_UPDATE" InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtState" Name="State" PropertyName="Text" ConvertEmptyStringToNull="false"  />
            <asp:ControlParameter ControlID="txtZipCode" Name="ZipCode" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtPhone" Name="Phone" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtCity" Name="City" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtTags" Name="Tag" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtNoTags" Name="NoTag" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="cboSource" Name="sourceId" PropertyName="SelectedValue"  />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="txtState" Name="State" PropertyName="Text" ConvertEmptyStringToNull="false"  />
            <asp:ControlParameter ControlID="txtZipCode" Name="ZipCode" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtPhone" Name="Phone" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtCity" Name="City" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtNoTags" Name="NoTag" PropertyName="Text" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtExportTag" Name="UpdateTag" PropertyName="Text" ConvertEmptyStringToNull="false" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblSelected_ID" Name="ID" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtBulkTag" Name="Tag" PropertyName="Text" ConvertEmptyStringToNull="false" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSources" runat="server" ConnectionString="<%$ ConnectionStrings:cnnAxzesLeads %>"
        SelectCommand="SELECT [Id], [Name] FROM [Leads_sources] ORDER BY [Id]">
    </asp:SqlDataSource>

    <asp:Label ID="lblSelected_ID" runat="server" Visible="False"></asp:Label>

</asp:Content>
