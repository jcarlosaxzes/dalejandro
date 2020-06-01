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
                    <telerik:AjaxUpdatedControl ControlID="cboNames" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="cboDepartment" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cboTimeFrame">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadDatePickerFrom" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadDatePickerTo" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />

    <div style="text-align: left" class="PanelFilter noprint">
        <table style="width: 100%" class="Formulario">
            <tr>
                <td style="width: 80px; text-align: right">Period:</td>
                <td style="width: 180px; text-align: right">
                    <telerik:RadComboBox ID="cboTimeFrame" runat="server" Width="100%" AppendDataBoundItems="True" MarkFirstMatch="True" AutoPostBack="true" ToolTip="Select Timeframe">
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
                <td style="width: 120px">
                    <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" DateFormat="MM/dd/yyyy" Width="130px" Culture="en-US" MinDate="01/01/1930">
                    </telerik:RadDatePicker>
                </td>
                <td style="width: 60px; text-align: right">To:
                </td>
                <td style="width: 120px">
                    <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" DateFormat="MM/dd/yyyy" Width="130px" Culture="en-US" MinDate="01/01/1930">
                    </telerik:RadDatePicker>
                </td>
                <td style="width: 90px; text-align: right">Department:</td>
                <td style="width: 380px">
                    <telerik:RadComboBox ID="cboDepartment" runat="server" DataSourceID="SqlDataSourceDepartments"
                        DataTextField="Name" DataValueField="Id" Width="100%" AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(All Departments...)" Value="-1" Selected="true" />
                        </Items>
                    </telerik:RadComboBox>

                </td>
                <td></td>
            </tr>
            <tr>
                <td style="text-align: right">Group:
                </td>
                <td colspan="2">
                    <telerik:RadComboBox ID="cboGroups" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceGroups" ToolTip="Group of Reports"
                        DataTextField="RPTGroup" DataValueField="RPTGroup" Width="100%" MarkFirstMatch="True" AppendDataBoundItems="True" OnDataBound="cboGroups_DataBound">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select Group...)" Value="-1" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td style="text-align: right">Report:
                </td>
                <td colspan="3">
                    <telerik:RadComboBox ID="cboNames" runat="server" DataSourceID="SqlDataSourceName" ToolTip="Report Name"
                        DataTextField="Name" DataValueField="Id" Width="100%" MarkFirstMatch="True" AppendDataBoundItems="True">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select Report...)" Value="-1" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td style="text-align: right">
                    <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                         <span class="glyphicon glyphicon-refresh"></span> Refresh
                    </asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnExport" runat="server" CssClass="btn btn-default btn" UseSubmitBehavior="false" Width="80px" ToolTip="Export Report to Excel file format (.CSV)">
                        <span class="glyphicon glyphicon-export"></span> Export
                    </asp:LinkButton>

                </td>
            </tr>
        </table>
    </div>
    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" AllowSorting="True" DataSourceID="SqlDataSource1" Skin="Bootstrap"
            AllowPaging="True" PageSize="250" Height="650px" AllowFilteringByColumn="True" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
            <ClientSettings>
                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
            </ClientSettings>
            <MasterTableView DataSourceID="SqlDataSource1" ShowFooter="True">
            </MasterTableView>
            <ExportSettings SuppressColumnDataFormatStrings="false">
                <Excel Format="Biff"></Excel>
            </ExportSettings>
        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="SqlDataSourceGroups" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT RPTGroup FROM Reports GROUP BY RPTGroup ORDER BY RPTGroup"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceName" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, [Name] FROM [Reports] WHERE ([RPTGroup] = @RPTGroup) ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboGroups" Name="RPTGroup" PropertyName="SelectedValue"
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT * FROM [Years] ORDER BY [Year] DESC "></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Report_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboNames" Name="ReportId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboDepartment" Name="departmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="DateFrom" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="DateTo" PropertyName="SelectedDate" Type="DateTime" />
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
