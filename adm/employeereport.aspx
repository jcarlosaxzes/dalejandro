<%@ Page Title="Employee Report" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="employeereport.aspx.vb" Inherits="pasconcept20.employeereport" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="FormView1" />
                    <telerik:AjaxUpdatedControl ControlID="FormView2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGridDepartmentFTE" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGridEfficiency"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="cboYear"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="cboEmployees"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="cboJobStatus"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="btnView"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" EnableEmbeddedSkins="false" />--%>


    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Employee Report</span>

        <span style="float: right; vertical-align: middle;">
            <table>
                <tr>
                    <td>
                        <asp:HyperLink ID="btnView" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false"
                            NavigateUrl='<%# String.Concat("~/adm/memory.aspx?companyId=", lblCompanyId.Text, "&year=", cboYear.SelectedValue, "&employeeId=", cboEmployees.SelectedValue, "&JobStatusIN_List=", GetMultiCheckInList(cboJobStatus)) %>' Target="_blank"
                            ToolTip="View page of employee year memory" CausesValidation="false">
                            <i class="far fa-eye"></i>&nbsp;View
                        </asp:HyperLink>
                    </td>
                    <td>
                        <asp:LinkButton ID="btnMemory" runat="server" CssClass="btn btn-secondary btn" UseSubmitBehavior="false"
                            ToolTip="Send year memory link to employee" CausesValidation="false">
                            <i class="far fa-envelope"></i>&nbsp;Send
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
        </span>


    </div>

    <div>
        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnRefresh">

            <table class="table-sm pasconcept-bar" style="width: 100%">
                <tr>
                    <td style="width: 175px">
                        <telerik:RadComboBox ID="cboYear" runat="server" DataSourceID="SqlDataSourceYear" DataTextField="nYear" Height="300px"
                            DataValueField="Year" Width="100%" CausesValidation="false" UseSubmitBehavior="false">
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 250px;">
                        <telerik:RadComboBox ID="cboEmployees" runat="server" DataSourceID="SqlDataSourceEmployees"
                            DataTextField="Name" DataValueField="Id" Height="300px" Width="100%" MarkFirstMatch="True" Filter="Contains">
                        </telerik:RadComboBox>

                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboJobStatus" runat="server" AppendDataBoundItems="True" Width="350px" MarkFirstMatch="True" Filter="Contains" CheckBoxes="true" EnableCheckAllItemsCheckBox="true">
                            <Localization AllItemsCheckedString="All Job Status Checked" CheckAllString="Check All..." ItemsCheckedString="Job Status checked"></Localization>
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="Not in Progress" Value="0" Checked="False" />
                                <telerik:RadComboBoxItem runat="server" Text="In Progress" Value="2" Checked="False" />
                                <telerik:RadComboBoxItem runat="server" Text="On Hold" Value="3" Checked="False" />
                                <telerik:RadComboBoxItem runat="server" Text="Submitted" Value="4" Checked="False" />
                                <telerik:RadComboBoxItem runat="server" Text="Under Revision" Value="5" Checked="False" />
                                <telerik:RadComboBoxItem runat="server" Text="Approved" Value="6" Checked="False" />
                                <telerik:RadComboBoxItem runat="server" Text="Done" Value="7" Checked="True" />
                                <telerik:RadComboBoxItem runat="server" Text="Inactive" Value="1" Checked="True" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 150px; text-align: right">
                        <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>

        </asp:Panel>
    </div>


    <div>
        <table style="width: 100%">
            <tr>
                <td style="width: 975px; vertical-align: top">
                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceEmployee" RenderOuterTable="false">
                        <ItemTemplate>
                            <table style="width: 100%">
                                <tr>
                                    <td style="width: 175px; vertical-align: top">
                                        <asp:Image ID="ImageEmployeePhoto" ImageUrl='<%# LocalAPI.GetEmployeePhotoURL(employeeId:=Eval("Id")) %>' CssClass="photo150"
                                            runat="server" AlternateText="Employee Profile Picture"></asp:Image>
                                    </td>
                                    <td style="width: 250px; vertical-align: top">
                                        <h4><%# Eval("Position") %></h4>
                                        <%# Eval("Address") %><br />
                                        <%# Eval("Email") %><br />
                                        <%#  LocalAPI.PhoneHTML(Request.UserAgent, Eval("Phone")) %><br />
                                        <p>Starting at: <%# Eval("starting_Date", "{0:d}") %></p>
                                    </td>

                                    <td style="width: 500px; vertical-align: top">
                                        <table class="table-sm table-bordered">
                                            <thead>
                                                <tr>
                                                    <th style="width: 200px"></th>
                                                    <th style="text-align: center; width: 150px">
                                                        <h4 style="margin: 0"><%# Eval("year") - 1 %></h4>
                                                    </th>
                                                    <th style="text-align: center; width: 150px">
                                                        <h4 style="margin: 0"><%# Eval("year") %></h4>
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tr>
                                                <td style="text-align: right">Vacations (days)</td>
                                                <td style="text-align: center"><%# Eval("Vacations_1") %></td>
                                                <td style="text-align: center; font-weight: bold"><%# Eval("Vacations") %></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right">Holidays (days)</td>
                                                <td style="text-align: center"><%# Eval("EmployeeHollidays_1") %></td>
                                                <td style="text-align: center; font-weight: bold"><%# Eval("EmployeeHollidays") %></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right">Personal/Sick (days)</td>
                                                <td style="text-align: center"><%# Eval("Sick_1") %></td>
                                                <td style="text-align: center; font-weight: bold"><%# Eval("Sick") %></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right">Hours</td>
                                                <td style="text-align: center"><%# Eval("Hours_1", "{0:N0}") %></td>
                                                <td style="text-align: center; font-weight: bold"><%# Eval("Hours", "{0:N0}") %></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right">Salary Net</td>
                                                <td style="text-align: center"><%# Eval("NetAnnualSalary_1", "{0:C2}") %></td>
                                                <td style="text-align: center; font-weight: bold"><%# Eval("NetAnnualSalary", "{0:C2}") %></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right">Salary Total Cost</td>
                                                <td style="text-align: center"><%# Eval("TotalCostAnnualSalary_1", "{0:C2}") %></td>
                                                <td style="text-align: center; font-weight: bold"><%# Eval("TotalCostAnnualSalary", "{0:C2}") %></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right">Bi-Weekly</td>
                                                <td style="text-align: center"><%# Eval("BiWeeklySalary_1", "{0:C2}") %></td>
                                                <td style="text-align: center; font-weight: bold"><%# Eval("BiWeeklySalary", "{0:C2}") %></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right">Hourly Wage</td>
                                                <td style="text-align: center"><%# Eval("HourlyWage_1", "{0:C2}") %></td>
                                                <td style="text-align: center; font-weight: bold"><%# Eval("HourlyWage", "{0:C2}") %></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right"><b>Budget Efficiency</b></td>
                                                <td style="text-align: center">
                                                    <div class="badge badge-secondary" style="font-size: 16px; width: 150px"><%# Eval("Efficiency_1", "{0:P0}") %></div>
                                                </td>
                                                <td style="text-align: center;">
                                                    <div class="badge badge-danger" style="font-size: 16px; width: 150px"><%# Eval("Efficiency", "{0:P0}") %></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right"><b>Time Efficiency</b></td>
                                                <td style="text-align: center">
                                                    <div class="badge badge-secondary" style="font-size: 16px; width: 150px"><%# Eval("TimeEfficiency_1", "{0:P0}") %></div>
                                                </td>
                                                <td style="text-align: center;">
                                                    <div class="badge badge-primary" style="font-size: 16px; width: 150px"><%# Eval("TimeEfficiency", "{0:P0}") %></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right"><b>Productive Time Rate</b></td>
                                                <td style="text-align: center">
                                                    <div class="badge badge-secondary" style="font-size: 16px; width: 150px"><%# Eval("ProductiveRate_1", "{0:P0}") %></div>
                                                </td>
                                                <td style="text-align: center;">
                                                    <div class="badge badge-success" style="font-size: 16px; width: 150px"><%# Eval("ProductiveRate", "{0:P0}") %></div>
                                                </td>
                                            </tr>
                                        </table>
                                        <div style="margin: 0; font-size: x-small; font-style: italic; text-align: left">
                                            (*) Salary Sources: Finances->Expenses->Payroll Details
                                        </div>
                                    </td>
                                    <td></td>
                        </ItemTemplate>
                    </asp:FormView>
                </td>
                <td style="vertical-align: top">
                    <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" DataSourceID="SqlDataSourceEfficiencyHistory" Height="400px" Width="97%"
                        Transitions="true">
                        <PlotArea>
                            <Series>
                                <telerik:LineSeries DataFieldY="Efficiency" Name="Time Efficiency">
                                    <TooltipsAppearance DataFormatString="{0:P0}"></TooltipsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="Red" />
                                    </Appearance>
                                    <LineAppearance LineStyle="Smooth" Width="2" />
                                    <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                    <LabelsAppearance Color="Red" Position="Above" Visible="False" DataFormatString="{0:P0}">
                                        <TextStyle FontSize="10" />
                                    </LabelsAppearance>
                                </telerik:LineSeries>
                                <telerik:LineSeries DataFieldY="TimeEfficiency" Name="Budget Efficiency">
                                    <TooltipsAppearance DataFormatString="{0:P0}"></TooltipsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="Blue" />
                                    </Appearance>
                                    <LineAppearance LineStyle="Smooth" Width="2" />
                                    <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                    <LabelsAppearance Color="Blue" Position="Below" Visible="False" DataFormatString="{0:P0}">
                                        <TextStyle FontSize="10" />
                                    </LabelsAppearance>
                                </telerik:LineSeries>
                                <telerik:LineSeries DataFieldY="ProductiveRate" Name="Productive Time Rate">
                                    <TooltipsAppearance DataFormatString="{0:P0}"></TooltipsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="Green" />
                                    </Appearance>
                                    <LineAppearance LineStyle="Smooth" Width="2" />
                                    <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                    <LabelsAppearance Color="Green" Position="Below" Visible="False" DataFormatString="{0:P0}">
                                        <TextStyle FontSize="10" />
                                    </LabelsAppearance>
                                </telerik:LineSeries>
                            </Series>
                            <YAxis Name="LeftAxis" MajorTickSize="6" MajorTickType="Outside" Color="Red" Width="3">
                                <TitleAppearance Text="Efficiency"></TitleAppearance>
                                <LabelsAppearance DataFormatString="{0:P0}">
                                    <TextStyle FontSize="10" />
                                </LabelsAppearance>
                                <MinorGridLines Visible="false"></MinorGridLines>
                            </YAxis>
                            <XAxis DataLabelsField="Year">
                                <TitleAppearance Text="Year" Visible="False"></TitleAppearance>
                                <MinorGridLines Visible="false"></MinorGridLines>
                                <AxisCrossingPoints>
                                    <telerik:AxisCrossingPoint Value="0" />
                                    <telerik:AxisCrossingPoint Value="9999" />
                                </AxisCrossingPoints>
                            </XAxis>
                        </PlotArea>
                        <Legend>
                            <Appearance Visible="true" Position="Bottom"></Appearance>
                        </Legend>
                    </telerik:RadHtmlChart>
                </td>
            </tr>
        </table>


    </div>

    <div>
        <table style="width: 100%">
            <tr>
                <td>
                    <h4>Department Employee Efficiency</h4>
                    <telerik:RadGrid ID="RadGridDepartmentFTE" runat="server" DataSourceID="SqlDataSourceReportByDepartment"
                        GridLines="None" AllowSorting="True" AutoGenerateColumns="False" CellSpacing="0" ShowFooter="true" HeaderStyle-HorizontalAlign="Center"
                        HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small" FooterStyle-Font-Bold="true" FooterStyle-HorizontalAlign="Center">
                        <MasterTableView DataSourceID="SqlDataSourceReportByDepartment">

                            <Columns>
                                <telerik:GridTemplateColumn DataField="Department" HeaderText="Department" SortExpression="Department"
                                    UniqueName="Department">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCompanyId" runat="server"
                                            Text='<%# Eval("Department")%>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridBoundColumn DataField="AssignedHours" HeaderText="Assigned Hours" HeaderTooltip="AssignedHours"
                                    SortExpression="AssignedHours" UniqueName="AssignedHours" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="180px"
                                    Aggregate="Sum" FooterAggregateFormatString="{0:N0}">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="WorkedHours" HeaderText="Worked Hours" HeaderTooltip="WorkedHours" SortExpression="WorkedHours" UniqueName="WorkedHours" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="180px" Aggregate="Sum" FooterAggregateFormatString="{0:N0}">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="BudgetAssigned" HeaderText="Budget Assigned" SortExpression="BudgetAssigned" UniqueName="BudgetAssigned" DataFormatString="{0:C2}" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="180px"
                                    Aggregate="Sum" FooterAggregateFormatString="{0:C2}">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="BudgetUsed" HeaderText="Budget Used" SortExpression="BudgetUsed" UniqueName="BudgetUsed" DataFormatString="{0:C2}" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="180px"
                                    Aggregate="Sum" FooterAggregateFormatString="{0:C2}">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="BudgetBalance" HeaderText="Budget Balance" SortExpression="BudgetBalance" UniqueName="BudgetBalance" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="180px" Aggregate="Sum" FooterAggregateFormatString="{0:N0}">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Profit" HeaderText="Budget Efficiency" SortExpression="Profit" UniqueName="Profit" DataFormatString="{0:P1}" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="180px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TimeEfficiency" HeaderText="Time Efficiency" SortExpression="TimeEfficiency" UniqueName="TimeEfficiency" DataFormatString="{0:P1}" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="180px">
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </td>
                <td style="width: 20px; text-align: center; vertical-align: top">
                    <asp:HyperLink runat="server" ID="lblEfficiency" NavigateUrl="javascript:void(0);" Style="text-decoration: none;">
                                            <i class="fas fa-info"></i>
                    </asp:HyperLink>
                    <telerik:RadToolTip ID="RadToolTipRatioJobsEfficiency" runat="server" TargetControlID="lblEfficiency"
                        RenderMode="Lightweight" EnableViewState="true" ShowCallout="false" RenderInPageRoot="true"
                        Position="Center" Modal="True" Title="" ShowEvent="OnClick"
                        HideDelay="100" HideEvent="LeaveToolTip" IgnoreAltAttribute="true"
                        RelativeTo="BrowserWindow" ManualClose="true">

                        <div class="pasconcept-bar noprint">
                            <span class="pasconcept-pagetitle">Jobs Employee Efficiency</span>
                        </div>
                        <table class="table table-striped" style="width: 850px; font-size: medium;">
                            <tr>
                                <td style="width: 150px; text-align: right">
                                    <span class="badge badge-secondary">Assigned Hours = </span>
                                </td>
                                <td>Hours assigned to the employee in this Job.
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">
                                    <span class="badge badge-danger">Worked Hours = </span>
                                </td>
                                <td>Hours recorded in the Employee's TimeSheet in this Job. 
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">
                                    <span class="badge badge-success">Budget Assigned = </span>
                                </td>
                                <td>Hours Assigned By Job x Position Hourly Rate
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">
                                    <span class="badge badge-danger">Budget Used = </span>
                                </td>
                                <td>'Worked Hours' x 'Horly Rate' of the employee in the Job.
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">
                                    <span class="badge badge-warning">Budget Balance = </span>
                                </td>
                                <td>Budget Assigned - Budget Used
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">
                                    <span class="badge badge-danger">Budget Efficiency = </span>
                                </td>
                                <td>Net financial gain; rate between Budget Assigned and amount spent (Budget Used)
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">
                                    <span class="badge badge-success">Time Efficiency = </span>
                                </td>
                                <td>Net financial gain; rate between Hours Assigned and amount used (Worked Hours)
                                </td>
                            </tr>

                        </table>
                    </telerik:RadToolTip>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Details panel">
        <i class="fas fa-list"></i>&nbsp;Jobs Employee Efficiency
    </button>
    <div class="collapse" id="collapseFilter">
        <table style="width: 100%">
            <tr>
                <td>
                    <telerik:RadGrid ID="RadGridEfficiency" runat="server" DataSourceID="SqlDataSourceReportByJobs"
                        GridLines="None" AllowSorting="True" AutoGenerateColumns="False" CellSpacing="0" ShowFooter="true"
                        HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Bold="true" FooterStyle-Font-Size="Small"
                        HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center">
                        <MasterTableView DataSourceID="SqlDataSourceReportByJobs" DataKeyNames="jobId">

                            <Columns>
                                <telerik:GridTemplateColumn DataField="JobName" HeaderText="Job Name" SortExpression="JobName"
                                    UniqueName="JobName">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCompanyId" runat="server"
                                            Text='<%# Eval("JobName")%>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="JobStatus" HeaderText="Status" HeaderTooltip="Job Status" SortExpression="JobStatus" UniqueName="JobStatus" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="AssignedHours" HeaderText="Assigned Hours" HeaderTooltip="AssignedHours"
                                    SortExpression="AssignedHours" UniqueName="AssignedHours" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px"
                                    Aggregate="Sum" FooterAggregateFormatString="{0:N0}">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="WorkedHours" HeaderText="Worked Hours" HeaderTooltip="WorkedHours" SortExpression="WorkedHours" UniqueName="WorkedHours" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" Aggregate="Sum" FooterAggregateFormatString="{0:N0}">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="BudgetAssigned" HeaderText="Budget Assigned" SortExpression="BudgetAssigned" UniqueName="BudgetAssigned" DataFormatString="{0:C2}" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="180px"
                                    Aggregate="Sum" FooterAggregateFormatString="{0:C2}">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="BudgetUsed" HeaderText="Budget Used" SortExpression="BudgetUsed" UniqueName="BudgetUsed" DataFormatString="{0:C2}" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="180px"
                                    Aggregate="Sum" FooterAggregateFormatString="{0:C2}">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="BudgetBalance" HeaderText="Budget Balance" SortExpression="BudgetBalance" UniqueName="BudgetBalance" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="180px" Aggregate="Sum" FooterAggregateFormatString="{0:N0}">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Profit" HeaderText="Budget Efficiency" SortExpression="Profit" UniqueName="Profit" DataFormatString="{0:P1}" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="180px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TimeEfficiency" HeaderText="Time Efficiency" SortExpression="TimeEfficiency" UniqueName="TimeEfficiency" DataFormatString="{0:P1}" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="180px">
                                </telerik:GridBoundColumn>

                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </td>
                <td style="width: 20px; text-align: center; vertical-align: top"></td>
            </tr>
        </table>

    </div>

    <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], FullName As Name FROM [Employees] WHERE companyId=@companyId and isnull(Inactive,0)=0 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="EmployeeReport_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboEmployees" DefaultValue="" Name="employeeId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="JobStatusIN_List" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceReportByJobs" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="EmployeeReportByJobs_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboEmployees" DefaultValue="" Name="employeeId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="JobStatusIN_List" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceReportByDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="EmployeeReportByDepartment_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboEmployees" DefaultValue="" Name="employeeId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="JobStatusIN_List" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Year], nYear FROM Years ORDER BY [Year] DESC"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceEfficiencyHistory" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="EmployeeEfficiencyHistory_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboEmployees" DefaultValue="" Name="employeeId" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="JobStatusIN_List" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployee" runat="server" Visible="False"></asp:Label>
</asp:Content>

