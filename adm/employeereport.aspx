<%@ Page Title="Employee Report" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="employeereport.aspx.vb" Inherits="pasconcept20.employeereport" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="FormView1" />
                    <telerik:AjaxUpdatedControl ControlID="RadGridDepartmentFTE" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="FormView2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGridEfficiency"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="cboYear"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="cboEmployees"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="btnView"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" EnableEmbeddedSkins="false" />


    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Employee Report</span>

        <span style="float: right; vertical-align: middle;">
            <table>
                <tr>
                    <td>
                        <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                            <i class="fas fa-filter"></i>&nbsp;Filter
                        </button>
                    </td>
                    <td>
                        <asp:HyperLink ID="btnView" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false"
                            NavigateUrl='<%# String.Concat("~/adm/memory.aspx?companyId=", lblCompanyId.Text, "&year=", cboYear.SelectedValue, "&employeeId=", cboEmployees.SelectedValue) %>' Target="_blank"
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

    <div class="collapse" id="collapseFilter">
        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnRefresh">

            <table class="table-sm pasconcept-bar" style="width: 100%">
                <tr>
                    <td style="width: 150px">
                        <telerik:RadComboBox ID="cboYear" runat="server" DataSourceID="SqlDataSourceYear" DataTextField="nYear" Height="300px"
                            DataValueField="Year" Width="100%" CausesValidation="false" UseSubmitBehavior="false">
                        </telerik:RadComboBox>
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboEmployees" runat="server" DataSourceID="SqlDataSourceEmployees"
                            DataTextField="Name" DataValueField="Id" Height="300px" Width="300px" MarkFirstMatch="True" Filter="Contains">
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

        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceEmployee" RenderOuterTable="false">
            <ItemTemplate>
                <table style="width: 100%">
                    <tr>
                        <td>
                            <div style="width: 160px">
                                <asp:Image ID="ImageEmployeePhoto" ImageUrl='<%# LocalAPI.GetEmployeePhotoURL(employeeId:=Eval("Id")) %>' CssClass="photo150"
                                    runat="server" AlternateText="Employee Profile Picture"></asp:Image>
                            </div>
                        </td>
                        <td style="width: 300px; vertical-align: top">
                            <h4><%# Eval("Name") %></h4>
                            <%# Eval("Position") %><br />
                            <%# Eval("Address") %><br />
                            <%# Eval("Email") %><br />
                            <%#  LocalAPI.PhoneHTML(Request.UserAgent, Eval("Phone")) %><br />
                            <p>Starting at: <%# Eval("starting_Date", "{0:d}") %></p>
                        </td>
                        <td style="vertical-align: top">
                            <telerik:RadGrid ID="RadGridDepartmentFTE" runat="server" DataSourceID="SqlDataSourceDepartmentFTE"
                                GridLines="None" AllowSorting="True" AutoGenerateColumns="False" CellSpacing="0" ShowFooter="true"
                                HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small" FooterStyle-Font-Bold="true">
                                <MasterTableView DataSourceID="SqlDataSourceDepartmentFTE" DataKeyNames="DepartmentId">

                                    <Columns>
                                        <telerik:GridTemplateColumn DataField="Department" HeaderText="Department" SortExpression="Department"
                                            UniqueName="Department" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCompanyId" runat="server"
                                                    Text='<%# Eval("Department")%>'>
                                                </asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridBoundColumn DataField="OpenWorkload" HeaderText="Open Workload" HeaderTooltip="Pending hours assigned to projects"
                                            SortExpression="OpenWorkload" UniqueName="OpenWorkload" DataFormatString="{0:N0}"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="150px"
                                            Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Center">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="BudgetAssigned" HeaderText="Budget Assigned" HeaderTooltip="Hours Assigned x HourlyRate x Multipler"
                                            SortExpression="BudgetAssigned" UniqueName="BudgetAssigned" DataFormatString="{0:C0}"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="150px"
                                            Aggregate="Sum" FooterAggregateFormatString="{0:C0}" FooterStyle-HorizontalAlign="Center">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="BudgetUsed" HeaderText="Budget Used" HeaderTooltip="Hours x HourlyRate"
                                            SortExpression="BudgetUsed" UniqueName="BudgetUsed" DataFormatString="{0:C0}"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="150px"
                                            Aggregate="Sum" FooterAggregateFormatString="{0:C0}" FooterStyle-HorizontalAlign="Center">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="FTE" HeaderText="FTE" HeaderTooltip="Full-Time Equivalent %"
                                            SortExpression="FTE" UniqueName="FTE" DataFormatString="{0:p}"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px"
                                            Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Center">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Profit" HeaderText="Efficiency" 
                                            SortExpression="Profit" UniqueName="Profit" DataFormatString="{0:P0}"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px"
                                            Aggregate="Avg" FooterAggregateFormatString="{0:P0}" FooterStyle-HorizontalAlign="Center">
                                        </telerik:GridBoundColumn>

                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </td>
                        <td style="width: 20px; text-align: center; vertical-align: top">
                            <asp:HyperLink runat="server" ID="lblInfo" NavigateUrl="javascript:void(0);" Style="text-decoration: none;">
                                            <i class="fas fa-info"></i>
                            </asp:HyperLink>
                            <telerik:RadToolTip ID="RadToolTipRatioInfo" runat="server" TargetControlID="lblInfo"
                                RenderMode="Lightweight" EnableViewState="true" ShowCallout="false" RenderInPageRoot="true"
                                Position="Center" Modal="True" Title="" ShowEvent="OnClick"
                                HideDelay="100" HideEvent="LeaveToolTip" IgnoreAltAttribute="true"
                                RelativeTo="BrowserWindow" ManualClose="true">

                                <div class="pasconcept-bar noprint">
                                    <span class="pasconcept-pagetitle">Employee Statistics for Project/Departments</span>
                                </div>
                                <table class="table table-striped" style="width: 850px; font-size: medium;">
                                    <tr>
                                        <td style="width: 150px;text-align:right">
                                            <span class="badge badge-secondary">Open Workload = </span>
                                        </td>
                                        <td>
                                            The remaining number of hours budgeted to Active Jobs.
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
                                        <td>Hours Worked x Employee Houly Rate x Multiplier
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right">
                                            <span class="badge badge-success">FTE = </span>
                                        </td>
                                        <td>Full-time percent equivalent of Employee by Department
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right">
                                            <span class="badge badge-warning">Efficiency = </span>
                                        </td>
                                        <td>
                                            Net financial gain; rate between Budget assigned and amount spent (Budget Used)
                                        </td>
                                    </tr>

                                </table>
                            </telerik:RadToolTip>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:FormView>


    </div>

    <div>
        <asp:FormView ID="FormView2" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceEmployee" RenderOuterTable="false">
            <ItemTemplate>

                <table class="table  table-sm table-striped table-bordered">
                    <thead>
                        <tr>
                            <th></th>
                            <th style="text-align: center"><%# Eval("year") - 1 %></th>
                            <th style="text-align: center"><%# Eval("year") %></th>
                        </tr>
                    </thead>
                    <tr>
                        <td>Vacations (days)</td>
                        <td style="text-align: center"><%# Eval("Vacations_1") %></td>
                        <td style="text-align: center"><%# Eval("Vacations") %></td>
                    </tr>
                    <tr>
                        <td>Holidays (days)</td>
                        <td style="text-align: center"><%# Eval("EmployeeHollidays_1") %></td>
                        <td style="text-align: center"><%# Eval("EmployeeHollidays") %></td>
                    </tr>
                    <tr>
                        <td>Personal/Sick (days)</td>
                        <td style="text-align: center"><%# Eval("Sick_1") %></td>
                        <td style="text-align: center"><%# Eval("Sick") %></td>
                    </tr>
                    <tr>
                        <td>Salary Hours</td>
                        <td style="text-align: center"><%# Eval("Hours_1", "{0:N0}") %></td>
                        <td style="text-align: center"><%# Eval("Hours", "{0:N0}") %></td>
                    </tr>
                    <tr>
                        <td>Salary Net ($)</td>
                        <td style="text-align: center"><%# Eval("NetAnnualSalary_1", "{0:C2}") %></td>
                        <td style="text-align: center"><%# Eval("NetAnnualSalary", "{0:C2}") %></td>
                    </tr>
                    <tr>
                        <td>Salary Gross ($)</td>
                        <td style="text-align: center"><%# Eval("GrossAnnualSalary_1", "{0:C2}") %></td>
                        <td style="text-align: center"><%# Eval("GrossAnnualSalary", "{0:C2}") %></td>
                    </tr>
                    <tr>
                        <td>Salary Total Cost ($)</td>
                        <td style="text-align: center"><%# Eval("TotalCostAnnualSalary_1", "{0:C2}") %></td>
                        <td style="text-align: center"><%# Eval("TotalCostAnnualSalary", "{0:C2}") %></td>
                    </tr>
                    <tr>
                        <td>Bi-Weekly ($)</td>
                        <td style="text-align: center"><%# Eval("BiWeeklySalary_1", "{0:C2}") %></td>
                        <td style="text-align: center"><%# Eval("BiWeeklySalary", "{0:C2}") %></td>
                    </tr>
                    <tr>
                        <td>Hourly Wage ($)</td>
                        <td style="text-align: center"><%# Eval("HourlyWage_1", "{0:C2}") %></td>
                        <td style="text-align: center"><%# Eval("HourlyWage", "{0:C2}") %></td>
                    </tr>
                    <tr>
                        <td>Efficiency (%)</td>
                        <td style="text-align: center"><%# Eval("Efficiency_1", "{0:p}") %></td>
                        <td style="text-align: center"><%# Eval("Efficiency", "{0:p}") %></td>
                    </tr>
                    <tr>
                        <td>Productivity Rate (%)</td>
                        <td style="text-align: center"><%# Eval("ProductivityRate_1", "{0:p}") %></td>
                        <td style="text-align: center"><%# Eval("ProductivityRate", "{0:p}") %></td>
                    </tr>
                </table>
                <div style="margin: 0; font-size: x-small; font-style: italic">
                    (*) Salary Sources: Finances->Expenses->Payroll Details
                </div>

            </ItemTemplate>
        </asp:FormView>

    </div>

    <div>

        <table style="width: 100%">
            <tr>
                <td>
                    <h4>Jobs Employee Efficiency</h4>
                    <telerik:RadGrid ID="RadGridEfficiency" runat="server" DataSourceID="SqlDataSourceEfficiency"
                        GridLines="None" AllowSorting="True" AutoGenerateColumns="False" CellSpacing="0" ShowFooter="true"
                        HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Bold="true" FooterStyle-Font-Size="Small"
                        HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center">
                        <MasterTableView DataSourceID="SqlDataSourceEfficiency" DataKeyNames="jobId">

                            <Columns>
                                <telerik:GridTemplateColumn DataField="JobName" HeaderText="Job Name" SortExpression="JobName"
                                    UniqueName="JobName">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCompanyId" runat="server"
                                            Text='<%# Eval("JobName")%>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="JobStatus" HeaderText="Status" HeaderTooltip="Job Status" SortExpression="JobStatus" UniqueName="JobStatus" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="180px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="AssignedHours" HeaderText="Assigned Hours" HeaderTooltip="AssignedHours"
                                    SortExpression="AssignedHours" UniqueName="AssignedHours" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="180px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="WorkedHours" HeaderText="Worked Hours" HeaderTooltip="WorkedHours" SortExpression="WorkedHours" UniqueName="WorkedHours" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="180px" Aggregate="Sum" FooterAggregateFormatString="{0:N0}">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="BudgetAssigned" HeaderText="Budget Assigned" SortExpression="BudgetAssigned" UniqueName="BudgetAssigned" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="180px"
                                    Aggregate="Sum" FooterAggregateFormatString="{0:N0}">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="BudgetUsed" HeaderText="Budget Used" SortExpression="BudgetUsed" UniqueName="BudgetUsed" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="180px"
                                    Aggregate="Sum" FooterAggregateFormatString="{0:N0}">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="BudgetBalance" HeaderText="Budget Balance" SortExpression="BudgetBalance" UniqueName="BudgetBalance" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="180px" Aggregate="Sum" FooterAggregateFormatString="{0:N0}">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Profit" HeaderText="Efficiency" SortExpression="Profit" UniqueName="Profit" DataFormatString="{0:P1}" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="180px"
                                    Aggregate="Avg" FooterAggregateFormatString="{0:P0}">
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
                        <table class="table table-striped" style="width: 850px; font-size: medium; ">
                            <tr>
                                <td style="width: 150px;text-align:right">
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
                                    <span class="badge badge-warning">Efficiency = </span>
                                </td>
                                <td>Net financial gain; rate between Budget assigned and amount spent (Budget Used)
                                </td>
                            </tr>

                        </table>
                    </telerik:RadToolTip>
                </td>
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
        SelectCommand="YearStadistic_EmployeeReport_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboEmployees" DefaultValue="" Name="employeeId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceEfficiency" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="YearStadistic_v20_EmployeeJobEfficiency" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboEmployees" DefaultValue="" Name="employeeId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>



    <asp:SqlDataSource ID="SqlDataSourceDepartmentFTE" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="YearStadistic_v20_EmployeeDepartmentsList" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboEmployees" DefaultValue="" Name="employeeId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Year], nYear FROM Years ORDER BY [Year] DESC"></asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployee" runat="server" Visible="False"></asp:Label>
</asp:Content>

