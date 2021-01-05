<%@ Page Title="Reports" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="reports.aspx.vb" Inherits="pasconcept20.reports" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cboGroups">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboNames"  />
                    <telerik:AjaxUpdatedControl ControlID="cboDepartment" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cboTimeFrame">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadDatePickerFrom" />
                    <telerik:AjaxUpdatedControl ControlID="RadDatePickerTo"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"  EnableEmbeddedSkins="false" />

    <div class="pasconcept-bar noprint" style="margin: 0px;">
        <span class="pasconcept-pagetitle">Reports</span>
        <table style="float: right; vertical-align: middle;">
            <tr>
                <td style="width: 180px">
                    <telerik:RadComboBox ID="cboGroups" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceGroups" ToolTip="Group of Reports"
                        DataTextField="RPTGroup" DataValueField="RPTGroup" Width="100%" MarkFirstMatch="True" AppendDataBoundItems="True" OnDataBound="cboGroups_DataBound">
                    </telerik:RadComboBox>
                </td>
                <td style="width: 300px">
                    <telerik:RadComboBox ID="cboNames" runat="server" DataSourceID="SqlDataSourceName" ToolTip="Report Name"
                        DataTextField="Name" DataValueField="Id" Width="100%" MarkFirstMatch="True" AppendDataBoundItems="True">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select Report...)" Value="-1" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td style="width: 250px">
                    <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-info btn" UseSubmitBehavior="false">
                                <i class="fas fa-redo"></i> Refresh
                    </asp:LinkButton>
                </td>
                <td>
                    <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                        <i class="fas fa-filter"></i>&nbsp;Filter
                    </button>
                    <asp:LinkButton ID="btnExport" runat="server" CssClass="btn btn-secondary btn" UseSubmitBehavior="false" ToolTip="Export Report to Excel file format (.CSV)">
                        <i class="fas fa-cloud-download-alt"></i> Export
                    </asp:LinkButton>
                </td>
            </tr>

        </table>
    </div>
    <div class="collapse" id="collapseFilter">

        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnRefresh">
            <table class="table-sm pasconcept-bar" style="width: 100%">
                <tr>
                    <td style="width: 180px">
                        <telerik:RadComboBox ID="cboTimeFrame" runat="server" Width="100%" AppendDataBoundItems="True" MarkFirstMatch="True" ToolTip="Select Timeframe">
                            <Items>
                                <telerik:RadComboBoxItem Text="All Years" Value="1" />
                                <telerik:RadComboBoxItem Text="Last Year" Value="2" />
                                <telerik:RadComboBoxItem Text="This Year" Value="3" />
                                <telerik:RadComboBoxItem Text="Last Quarter" Value="4" />
                                <telerik:RadComboBoxItem Text="This Quarter" Value="5" />
                                <telerik:RadComboBoxItem Text="Last Month" Value="6" />
                                <telerik:RadComboBoxItem Text="This Month" Value="7" />
                                <telerik:RadComboBoxItem Text="Last 30 Days" Value="8" />
                                <telerik:RadComboBoxItem Text="Last 15 Days" Value="9" />
                                <telerik:RadComboBoxItem Text="Last 7 Days" Value="10" />
                                <telerik:RadComboBoxItem Text="Last Day" Value="11" />
                                <telerik:RadComboBoxItem Text="ToDay" Value="12" />
                                <telerik:RadComboBoxItem Text="MTD Past Year" Value="13" />
                                <telerik:RadComboBoxItem Text="MTD" Value="14" />
                                <telerik:RadComboBoxItem Text="QTD Past Year" Value="15" />
                                <telerik:RadComboBoxItem Text="QTD" Value="16" />
                                <telerik:RadComboBoxItem Text="YTD Past Year" Value="17" />
                                <telerik:RadComboBoxItem Text="YTD" Value="18" />

                                <telerik:RadComboBoxItem Text="(Custom Range...)" Value="99" />
                            </Items>
                        </telerik:RadComboBox>

                    </td>
                    <td style="width: 130px">
                        <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" DateFormat="MM/dd/yyyy" Culture="en-US" MinDate="01/01/2000">
                        </telerik:RadDatePicker>
                    </td>
                    <td style="width: 130px">
                        <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" DateFormat="MM/dd/yyyy" Culture="en-US" MinDate="01/01/2000">
                        </telerik:RadDatePicker>
                    </td>
                    <td style="width: 150px">
                        <telerik:RadTextBox ID="txtCode" runat="server" EmptyMessage="Project Code" Width="100%" MaxLength="80">
                        </telerik:RadTextBox>
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboDepartment" runat="server" DataSourceID="SqlDataSourceDepartments"
                            DataTextField="Name" DataValueField="Id" Width="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Departments...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
            </table>
        </asp:Panel>

    </div>

    <div class="container" style="padding:0px;">
        <telerik:RadGrid ID="RadGrid1" runat="server" AllowSorting="True" DataSourceID="SqlDataSource1" RenderMode="Lightweight"
            AllowPaging="True" PageSize="250" Height="850px" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small">
            <ClientSettings>
                <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
            </ClientSettings>

            <MasterTableView DataSourceID="SqlDataSource1" ShowFooter="True" CssClass="table-sm">
                <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="SqlDataSourceGroups" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT RPTGroup FROM Reports GROUP BY RPTGroup ORDER BY RPTGroup"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceName" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, [Name] FROM [Reports] WHERE ([RPTGroup] = @RPTGroup) ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboGroups" Name="RPTGroup" PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT * FROM [Years] ORDER BY [Year] DESC "></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Report_v20_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboNames" Name="ReportId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboDepartment" Name="departmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="DateFrom" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="DateTo" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="txtCode" ConvertEmptyStringToNull="False" Name="Code" PropertyName="Text" Type="String" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
