<%@ Page Title="Payroll Calendar" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="paiddaylist.aspx.vb" Inherits="pasconcept20.paiddaylist" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGridHourlyWage">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridHourlyWage" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadGridPayroll" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadGridHourlyWage" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnInsert">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cboEmployees">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridPayroll" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadGridHourlyWage" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnImport">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridPayroll" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cboDepartments">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboEmployees" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Payroll</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>

            <asp:LinkButton ID="btnNewVendor" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                    Add Vendor
            </asp:LinkButton>

        </span>
    </div>


    <div class="collapse" id="collapseFilter">

        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnRefresh">
            <table class="table-sm pasconcept-bar" style="width: 100%">
                <tr>
                    <td style="width: 150px">

                        <telerik:RadComboBox ID="cboYear" runat="server" DataSourceID="SqlDataSourceYear"
                            DataTextField="nYear" DataValueField="Year" Width="100px">
                        </telerik:RadComboBox>
                    </td>

                    <td style="width: 300px">
                        <telerik:RadComboBox ID="cboDepartments" runat="server" DataSourceID="SqlDataSourceDepartments" MarkFirstMatch="True" AutoPostBack="true"
                            Width="100%" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(Select Department...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>

                    <td style="width: 300px">
                        <telerik:RadComboBox ID="cboEmployees" runat="server" DataSourceID="SqlDataSourceEmployees" MarkFirstMatch="True" AutoPostBack="true"
                            Width="100%" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Employees...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>


                    <td style="text-align: right;">
                        <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>


    <telerik:RadWizard ID="RadWizard1" runat="server" Width="100%" Height="800px" Skin="Silk"
        DisplayProgressBar="false" DisplayCancelButton="false" DisplayNavigationButtons="false">
        <WizardSteps>

            <telerik:RadWizardStep runat="server" Title="Employee Hourly Wage">
                <div class="container" style="width: 100% !important">
                    <div class="row">
                        <table class="table-sm" style="width: 100%">
                            <tr>
                                <td style="width: 140px;">

                                    <asp:LinkButton ID="btnAddHourlyWage" runat="server" ToolTip="Add Hourly Wage Record "
                                        CssClass="btn btn-info btn" UseSubmitBehavior="false">
                                    <i class="fas fa-plus"></i> New Record
                                    </asp:LinkButton>

                                </td>
                                <td style="width: 200px">
                                    <asp:LinkButton ID="btnInitialize" runat="server" ToolTip="Initialize(insert) all Active Employees for this year"
                                        CssClass="btn btn-info btn" UseSubmitBehavior="false">
                                     Initialize
                                    </asp:LinkButton>
                                </td>
                                <td></td>
                            </tr>
                        </table>
                    </div>
                    <div class="row">
                        <telerik:RadGrid ID="RadGridHourlyWage" runat="server" DataSourceID="SqlDataSourceHourlyWage"
                            AutoGenerateColumns="False" AllowPaging="True" PageSize="50" AllowSorting="True" Height="600px" ShowFooter="true"
                            AllowAutomaticDeletes="true" AllowAutomaticInserts="true" AllowAutomaticUpdates="true"
                            HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
                            </ClientSettings>
                            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceHourlyWage">
                                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" HeaderText="Id" ReadOnly="True" UniqueName="Id"
                                        HeaderStyle-Width="40px" Display="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="employeeId" FilterControlAltText="Filter Employee column"
                                        HeaderText="Employee" SortExpression="Employee" UniqueName="employeeId" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton runat="server" ID="lblName" CommandName="Edit"
                                                ForeColor='<%# iif(Eval("Status")="Inactive",System.Drawing.Color.LightGray,System.Drawing.Color.DarkBlue) %>'> 
                                                <%# Eval("Employee") %>
                                                <span style="font-size:x-small" class="badge badge-pill badge-danger" title="weeks this year"><%# Eval("weekthisyear") %></span>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="cboEmployees2" runat="server" DataSourceID="SqlDataSourceEmployees" MarkFirstMatch="True" HeaderStyle-HorizontalAlign="Center"
                                                Width="100%" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" AppendDataBoundItems="true"
                                                SelectedValue='<%# Bind("employeeId") %>'>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text="(Select Employees...)" Value="0" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>

                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="Department" FilterControlAltText="Filter Department column" HeaderText="Department" HeaderStyle-HorizontalAlign="Center"
                                        SortExpression="Department" UniqueName="Department" ReadOnly="true">
                                        <ItemTemplate>
                                            <small><%# Eval("Department") %></small>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="Date" FilterControlAltText="Filter Date column" HeaderText="Date From" HeaderStyle-HorizontalAlign="Center"
                                        SortExpression="Date" UniqueName="Date" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right" Display="false">
                                        <ItemTemplate>
                                            <%# Eval("Date","{0:d}") %>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadDatePicker ID="RadDatePicker1" runat="server" Culture="en-US" DbSelectedDate='<%# Bind("Date") %>'>
                                            </telerik:RadDatePicker>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="DateEnd" FilterControlAltText="Filter DateEnd column" HeaderText="Date To" HeaderStyle-HorizontalAlign="Center"
                                        SortExpression="DateEnd" UniqueName="DateEnd" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right" Display="false">
                                        <ItemTemplate>
                                            <%# Eval("DateEnd", "{0:d}") %>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadDatePicker ID="RadDatePicker2" runat="server" Culture="en-US" DbSelectedDate='<%# Bind("DateEnd") %>'>
                                            </telerik:RadDatePicker>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="Amount" FilterControlAltText="Filter Amount column" HeaderText="$/Hour" HeaderStyle-HorizontalAlign="Center"
                                        SortExpression="Amount" UniqueName="Amount" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right"
                                        HeaderTooltip="Hourly Wage Rate">
                                        <ItemTemplate>
                                            <%# Eval("Amount","{0:C2}") %>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadNumericTextBox ID="txtAmount" runat="server" DbValue='<%# Bind("Amount") %>'>
                                            </telerik:RadNumericTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="HourPerWeek" FilterControlAltText="Filter HourPerWeek column" HeaderText="Hours per Week" HeaderStyle-HorizontalAlign="Center"
                                        SortExpression="HourPerWeek" UniqueName="HourPerWeek" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" Display="false">
                                        <EditItemTemplate>
                                            <telerik:RadNumericTextBox ID="txtHourPerWeek" runat="server" DbValue='<%# Bind("HourPerWeek") %>'>
                                            </telerik:RadNumericTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Benefits_vacations" FilterControlAltText="Filter Benefits_vacations column" HeaderText="Vacations(hours)" HeaderStyle-HorizontalAlign="Center"
                                        SortExpression="Benefits_vacations" UniqueName="Benefits_vacations" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right" Display="false">
                                        <EditItemTemplate>
                                            <telerik:RadNumericTextBox ID="txtBenefits_vacations" runat="server" DbValue='<%# Bind("Benefits_vacations") %>'>
                                            </telerik:RadNumericTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Benefits_personals" FilterControlAltText="Filter Benefits_personals column" HeaderText="Personals(hours)" HeaderStyle-HorizontalAlign="Center"
                                        SortExpression="Benefits_personals" UniqueName="Benefits_personals" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right" Display="false">
                                        <EditItemTemplate>
                                            <telerik:RadNumericTextBox ID="txtBenefits_personals" runat="server" DbValue='<%# Bind("Benefits_personals") %>'>
                                            </telerik:RadNumericTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridNumericColumn DataField="AnnualSalary" FilterControlAltText="Filter AnnualSalary column" HeaderText="Annual" HeaderStyle-HorizontalAlign="Center"
                                        SortExpression="AnnualSalary" UniqueName="AnnualSalary" DataFormatString="{0:N0}" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" ReadOnly="true"
                                        HeaderTooltip="Annual Salary Calculated">
                                    </telerik:GridNumericColumn>
                                    <telerik:GridTemplateColumn DataField="ProductiveSalary" FilterControlAltText="Filter ProductiveSalary column" HeaderText="Productive" HeaderStyle-HorizontalAlign="Center"
                                        SortExpression="ProductiveSalary" UniqueName="ProductiveSalary" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" ReadOnly="true"
                                        HeaderTooltip="Annual Salary - (Non-productive hours)*$/Hour">
                                        <ItemTemplate>
                                            <%# Eval("ProductiveSalary","{0:N0}") %>
                                            <span style="font-size: x-small" class="badge badge-pill badge-danger" title="productive weeks this year"><%# Eval("productiveweekthisyear","{0:N0}") %></span>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="Increase" FilterControlAltText="Filter Increase column" HeaderText="Increase" HeaderStyle-HorizontalAlign="Center"
                                        SortExpression="Increase" UniqueName="Increase" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right"
                                        HeaderTooltip="Planned increase ($/Hours) for next year">
                                        <ItemTemplate>
                                            <%# Eval("Increase","{0:C2}") %>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadNumericTextBox ID="txtIncrease" runat="server" DbValue='<%# Bind("Increase") %>'>
                                            </telerik:RadNumericTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridNumericColumn DataField="Producer" FilterControlAltText="Filter Producer column" HeaderText="Producer" HeaderStyle-HorizontalAlign="Center"
                                        SortExpression="Producer" UniqueName="Producer" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Center" Display="false">
                                    </telerik:GridNumericColumn>

                                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ButtonType="ImageButton"
                                        HeaderText="" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn"
                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <EditFormSettings>
                                    <PopUpSettings Modal="true" Width="600px" />
                                    <EditColumn ButtonType="PushButton" UniqueName="EditCommandColumn1">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                        </telerik:RadGrid>

                    </div>
                </div>
            </telerik:RadWizardStep>

            <telerik:RadWizardStep runat="server" Title="Payroll Calendar">
                <div class="container" style="width: 100% !important">
                    <div class="row">
                        <table class="table-sm">
                            <tr>
                                <td>
                                    <telerik:RadDatePicker ID="RadDatePicker1" runat="server" Culture="en-US" DateInput-Label="Closing" Width="100%">
                                    </telerik:RadDatePicker>

                                </td>
                                <td>
                                    <asp:LinkButton ID="btnInsert" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                    <i class="fas fa-plus"></i> Insert
                                    </asp:LinkButton>
                                </td>
                                <td>
                                    <asp:LinkButton ID="btnInicializeCalendar" runat="server" ToolTip="Initialize Calendar this year"
                                        CssClass="btn btn-info btn" UseSubmitBehavior="false">
                                     Initialize 
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="row">
                        <table class="table-sm" style="width: 100%">
                            <tr>
                                <td style="width: 200px">
                                    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource5" GridLines="None"
                                        AutoGenerateColumns="False" AllowAutomaticDeletes="True" Width="100%" AllowAutomaticUpdates="True"
                                        AllowPaging="True" CellSpacing="0" AllowSorting="True" PageSize="50" Height="600px"
                                        HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                        </ClientSettings>
                                        <MasterTableView DataKeyNames="PaidDay" DataSourceID="SqlDataSource5">
                                            <PagerStyle Mode="Slider" AlwaysVisible="false" />
                                            <Columns>
                                                <telerik:GridTemplateColumn DataField="PaidDay" DataType="System.DateTime" HeaderText="Closing Date" ItemStyle-Font-Size="X-Small"
                                                    SortExpression="PaidDay" UniqueName="PaidDay" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label ID="PaidDayLabel" runat="server" Text='<%# Eval("PaidDay", "{0:d}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ButtonType="ImageButton"
                                                    HeaderText="" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn"
                                                    HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="45px">
                                                </telerik:GridButtonColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                                <td>
                                    <telerik:RadScheduler RenderMode="Native" runat="server" ID="RadScheduler1" SelectedView="YearView" Skin="Material"
                                        DataSourceID="SqlDataSource5" Height="600px" DataKeyField="PaidDay" DataSubjectField="PaidDay" DataStartField="PaidDay"
                                        DataEndField="PaidDay" ReadOnly="true" ShowHeader="false" Enabled="false">
                                        <YearView UserSelectable="true" ShowDateHeaders="false" ReadOnly="true" />
                                        <TimelineView UserSelectable="false"></TimelineView>
                                        <MultiDayView UserSelectable="false"></MultiDayView>
                                        <DayView UserSelectable="false"></DayView>
                                        <WeekView UserSelectable="false"></WeekView>
                                        <MonthView UserSelectable="false"></MonthView>

                                    </telerik:RadScheduler>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </telerik:RadWizardStep>

            <telerik:RadWizardStep runat="server" Title="Payroll Report">
                <div class="container" style="width: 100% !important">
                    <div class="row">
                        <table style="width: 100%">
                            <tr>
                                <td></td>
                                <td style="width: 200px; text-align: right">
                                    <telerik:RadAsyncUpload ID="RadUpload1" runat="server" Width="100%" ControlObjectsVisibility="None" MultipleFileSelection="Disabled" EnableFileInputSkinning="true" RenderMode="Classic"
                                        AllowedFileExtensions="csv,txt">
                                    </telerik:RadAsyncUpload>
                                </td>
                                <td style="width: 110px; text-align: right">

                                    <asp:LinkButton ID="btnImport" runat="server" ToolTip="Import Payroll CSV file('Check Date,Name,Net Amount,Total Hours,Gross Amount')"
                                        CssClass="btn btn-info btn" UseSubmitBehavior="false">
                                       Upload
                                    </asp:LinkButton>

                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="row">
                        <telerik:RadGrid ID="RadGridPayroll" runat="server" DataSourceID="SqlDataSource1"
                            AutoGenerateColumns="False" AllowPaging="True" PageSize="50" AllowSorting="True" Height="600px" ShowFooter="true">
                            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>

                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
                            </ClientSettings>
                            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1" EditMode="InPlace">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="Employee" FilterControlAltText="Filter Employee column" HeaderText="Employee" SortExpression="Employee" UniqueName="Employee" HeaderStyle-HorizontalAlign="Center" Aggregate="CountDistinct" FooterAggregateFormatString="{0:N0}">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SalaryDate" DataType="System.DateTime" FilterControlAltText="Filter SalaryDate column" HeaderText="Date" SortExpression="SalaryDate" UniqueName="SalaryDate" DataFormatString="{0:d}" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                        HeaderStyle-Width="150px">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Hours" DataType="System.Double" FilterControlAltText="Filter Hours column" HeaderText="Hours" SortExpression="Hours" UniqueName="Hours" Aggregate="Sum" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" FooterAggregateFormatString="{0:N1}"
                                        HeaderStyle-Width="100px">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NetAmount" DataType="System.Double" FilterControlAltText="Filter NetAmount column" HeaderText="Net Amount" SortExpression="NetAmount" UniqueName="NetAmount" Aggregate="Sum" DataFormatString="{0:C2}" FooterAggregateFormatString="{0:C2}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" HeaderTooltip="Net Salary"
                                        HeaderStyle-Width="150px">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="GrossAmount" DataType="System.Double" FilterControlAltText="Filter GrossAmount column" HeaderText="Gross Amount" SortExpression="GrossAmount" UniqueName="GrossAmount" Aggregate="Sum" DataFormatString="{0:C2}" FooterAggregateFormatString="{0:C2}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" HeaderTooltip="Gross Salary"
                                        HeaderStyle-Width="150px">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TotalCost" DataType="System.Double" FilterControlAltText="Filter TotalCost column" HeaderText="Gross Amount" SortExpression="TotalCost" UniqueName="TotalCost" Aggregate="Sum" DataFormatString="{0:C2}" FooterAggregateFormatString="{0:C2}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" HeaderTooltip="Total Cost"
                                        HeaderStyle-Width="150px">
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                </div>
            </telerik:RadWizardStep>
        </WizardSteps>
    </telerik:RadWizard>

    <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [PaidDays] WHERE [PaidDay] = @PaidDay"
        SelectCommand="SELECT [PaidDay] FROM [PaidDays] WHERE companyId=@companyId and Year(PaidDay)=@year ORDER BY [PaidDay] DESC"
        UpdateCommand="UPDATE PaidDays SET PaidDay = CONVERT(DATETIME, @PaidDay, 102)">
        <DeleteParameters>
            <asp:Parameter Name="PaidDay" Type="DateTime" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="PaidDay" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Employee_Payroll_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="PayrollInitialize_INSERT" InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboEmployees" Name="employeeId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceHourlyWage" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [Employee_HourlyWageHistory] WHERE Id = @Id"
        SelectCommand="Employees_HourlyWageHistory_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="Employee_HourlyWageHistory_INSERT" InsertCommandType="StoredProcedure"
        UpdateCommand="Employee_HourlyWageHistoryExt_UPDATE" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboDepartments" Name="departmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboEmployees" Name="employeeId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="employeeId" />
            <asp:Parameter Name="Date" />
            <asp:Parameter Name="DateEnd" />
            <asp:Parameter Name="Amount" />
            <asp:Parameter Name="HourPerWeek" />
            <asp:Parameter Name="Producer" />
            <asp:Parameter Name="Increase" />
            <asp:Parameter Name="Benefits_vacations" />
            <asp:Parameter Name="Benefits_personals" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="employeeId" />
            <asp:Parameter Name="Date" />
            <asp:Parameter Name="DateEnd" />
            <asp:Parameter Name="Amount" />
            <asp:Parameter Name="HourPerWeek" />
            <asp:Parameter Name="Producer" />
            <asp:Parameter Name="Increase" />
            <asp:Parameter Name="Benefits_vacations" />
            <asp:Parameter Name="Benefits_personals" />
            <asp:Parameter Name="Id" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceChart" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="select [Date], [Amount] from [Employee_HourlyWageHistory] where employeeId=@employeeId order by Date">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="employeeId" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name]=[FullName]+case when isnull(Inactive,0)=1 then ' (I)' else '' end FROM [Employees] WHERE companyId=@companyId and DepartmentId=case when @DepartmentId>0 then @DepartmentId else DepartmentId end ORDER BY isnull(Inactive,0), [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboDepartments" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT * FROM [Years] where [Year]&gt;2000 ORDER BY [Year]DESC "></asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
