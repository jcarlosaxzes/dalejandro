<%@ Page Title="History Log" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="historylog.aspx.vb" Inherits="pasconcept20.historylog" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnFind">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Email History Log</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>
        </span>
    </div>

    <div class="collapse" id="collapseFilter">
        <table style="width: 100%">
            <tr>
                <td class="PanelFilter">
                    <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
                        <table class="table-sm pasconcept-bar" style="width: 100%">
                            <tr>
                                <td>
                                    <telerik:RadTextBox ID="txtFind" runat="server" EmptyMessage="Search Email, Actions or Notes..." Width="90%">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width: 150px; text-align: right">
                                    <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                            <i class="fas fa-search"></i> Filter/Search
                                    </asp:LinkButton>

                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small"
            Width="100%" AutoGenerateColumns="False" CellSpacing="0" AllowSorting="True" AllowPaging="True" PageSize="100" Height="1200px">
            <ClientSettings>
                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
            </ClientSettings>
            <MasterTableView DataSourceID="SqlDataSource1">
                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                <Columns>
                    <telerik:GridBoundColumn DataField="Email" HeaderText="Email" SortExpression="Email" ItemStyle-HorizontalAlign="Left"
                        UniqueName="Email" HeaderStyle-HorizontalAlign="Center"
                        FilterControlAltText="Filter Email column" HeaderStyle-Width="180px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="sys_Actions" FilterControlAltText="Filter sys_Actions column"
                        HeaderText="Actions" SortExpression="sys_Actions" UniqueName="sys_Actions"
                        HeaderStyle-Width="160px" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="logDate" DataType="System.DateTime" FilterControlAltText="Filter logDate column"
                        HeaderText="Date" SortExpression="logDate" UniqueName="logDate"
                        HeaderStyle-Width="180px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Notes" FilterControlAltText="Filter Notes column" ItemStyle-HorizontalAlign="Left"
                        HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="log_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Filter"
                PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
