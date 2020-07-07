<%@ Page Title="Employee Report" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="employeereport.aspx.vb" Inherits="pasconcept20.employeereport" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Employee Report</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>

            <asp:HyperLink ID="btnView" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false"
                NavigateUrl='<%# GetMemoryUrl() %>' Target="_blank"
                ToolTip="View page of employee year memory" CausesValidation="false">
                            <i class="far fa-eye"></i>View
            </asp:HyperLink>
            <asp:LinkButton ID="btnMemory" runat="server" CssClass="btn btn-secondary btn" UseSubmitBehavior="false"
                ToolTip="Send year memory link to employee" CausesValidation="false">
                            <i class="far fa-envelope"></i> Send
            </asp:LinkButton>


        </span>


    </div>

    <div class="collapse" id="collapseFilter">
        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnRefresh">

            <table class="table-sm pasconcept-bar" style="width: 100%">
                <tr>
                    <td style="width:150px">
                        <telerik:RadDropDownList ID="cboYear" runat="server" DataSourceID="SqlDataSourceYear" DataTextField="nYear"
                            DataValueField="Year" Width="100%" CausesValidation="false" UseSubmitBehavior="false">
                        </telerik:RadDropDownList>
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboEmployees" runat="server" DataSourceID="SqlDataSourceEmployees"
                            DataTextField="Name" DataValueField="Id" Height="300px" Width="300px">
                        </telerik:RadComboBox>

                    </td>
                    <td style="width: 150px; text-align: right">
                        <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-info btn" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Search
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>

        </asp:Panel>
    </div>

    
    <div class="row">
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceEmployee" RenderOuterTable="false">
            <ItemTemplate>
                <div class="col-md-2">
                    <asp:Image ID="ImageEmployeePhoto" ImageUrl='<%# LocalAPI.GetEmployeePhotoURL(employeeId:=Eval("Id")) %>' CssClass="photo150"
                        runat="server" AlternateText="Employee Profile Picture"></asp:Image>
                </div>
                <div class="col-md-2">
                    <h4><%# Eval("Name") %></h4>
                    <%# Eval("Position") %>
                    <p><%# Eval("Address") %></p>
                    <p><%# Eval("Email") %></p>
                    <p><%#  LocalAPI.PhoneHTML(Request.UserAgent, Eval("Phone")) %></p>
                    <p>Starting at: <%# Eval("starting_Date","{0:d}") %></p>
                </div>
            </ItemTemplate>
        </asp:FormView>
        <div class="col-md-8">
            <%--This chart should list each department this employee has entered hours for, their FTE, their total workload for that department, and the percet of that workload completed.--%>
            <telerik:RadGrid ID="RadGridDepartmentFTE" runat="server" DataSourceID="SqlDataSourceDepartmentFTE"
                GridLines="None" AllowSorting="True" AutoGenerateColumns="False" CellSpacing="0" ShowFooter="true"
                HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
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

                        <telerik:GridBoundColumn DataField="workload" HeaderText="Workload" HeaderTooltip="Workload in Hours"
                            SortExpression="workload" UniqueName="workload" DataFormatString="{0:N0}"
                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px"
                            Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Center">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Revenue" HeaderText="Revenue" HeaderTooltip="Hours x HourlyRate x Efficiency"
                            SortExpression="Revenue" UniqueName="Revenue" DataFormatString="{0:N0}"
                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px"
                            Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Center">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Overhead" HeaderText="Overhead" HeaderTooltip="Hours x HourlyRate"
                            SortExpression="Overhead" UniqueName="Overhead" DataFormatString="{0:N0}"
                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px"
                            Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Center">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="FTE" HeaderText="FTE" HeaderTooltip="Full-Time Equivalent %"
                            SortExpression="FTE" UniqueName="FTE" DataFormatString="{0:p}"
                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px"
                            Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Center">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Profit" HeaderText="Profit" HeaderTooltip="Hours x HourlyRate"
                            SortExpression="Profit" UniqueName="Profit" DataFormatString="{0:N0}"
                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px"
                            Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Center">
                        </telerik:GridBoundColumn>

                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
    </div>

    <div class="row">
        <asp:FormView ID="FormView2" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceEmployee" RenderOuterTable="false">
            <ItemTemplate>
                <div class="col-md-12">
                    <table class="table  table-sm table-striped table-bordered">
                        <thead>
                            <tr>
                                <th></th>
                                <th style="text-align: center"><%# Eval("year")-1 %></th>
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
                            <td>Salary Net ($)</td>
                            <td style="text-align: center"><%# Eval("NetAnnualSalary_1","{0:C2}") %></td>
                            <td style="text-align: center"><%# Eval("NetAnnualSalary","{0:C2}") %></td>
                        </tr>
                        <tr>
                            <td>Gross Net ($)</td>
                            <td style="text-align: center"><%# Eval("GrossAnnualSalary_1","{0:C2}") %></td>
                            <td style="text-align: center"><%# Eval("GrossAnnualSalary","{0:C2}") %></td>
                        </tr>
                        <tr>
                            <td>Total Cost ($)</td>
                            <td style="text-align: center"><%# Eval("TotalCostAnnualSalary_1","{0:C2}") %></td>
                            <td style="text-align: center"><%# Eval("TotalCostAnnualSalary","{0:C2}") %></td>
                        </tr>
                        <tr>
                            <td>Bi-Weekly ($)</td>
                            <td style="text-align: center"><%# Eval("BiWeeklySalary_1","{0:C2}") %></td>
                            <td style="text-align: center"><%# Eval("BiWeeklySalary","{0:C2}") %></td>
                        </tr>
                        <tr>
                            <td>Hourly Wage ($)</td>
                            <td style="text-align: center"><%# Eval("HourlyWage_1","{0:C2}") %></td>
                            <td style="text-align: center"><%# Eval("HourlyWage","{0:C2}") %></td>
                        </tr>
                        <tr>
                            <td>Efficiency (%)</td>
                            <td style="text-align: center"><%# Eval("Efficiency_1","{0:p}") %></td>
                            <td style="text-align: center"><%# Eval("Efficiency","{0:p}") %></td>
                        </tr>
                        <tr>
                            <td>Productivity Rate (%)</td>
                            <td style="text-align: center"><%# Eval("ProductivityRate_1","{0:p}") %></td>
                            <td style="text-align: center"><%# Eval("ProductivityRate","{0:p}") %></td>
                        </tr>
                    </table>
                </div>
            </ItemTemplate>
        </asp:FormView>
    </div>

    <div class="row">
        <div class="col-md-12">
            <h4>Jobs (Done or Inactive) Employee Efficiency</h4>
            <telerik:RadGrid ID="RadGridEfficiency" runat="server" DataSourceID="SqlDataSourceEfficiency"
                GridLines="None" AllowSorting="True" AutoGenerateColumns="False" CellSpacing="0" ShowFooter="true"
                HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                <MasterTableView DataSourceID="SqlDataSourceEfficiency" DataKeyNames="jobId">

                    <Columns>
                        <telerik:GridTemplateColumn DataField="JobName" HeaderText="Job Name" SortExpression="JobName"
                            UniqueName="JobName" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label ID="lblCompanyId" runat="server"
                                    Text='<%# Eval("JobName")%>'>
                                </asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridBoundColumn DataField="AssignedHours" HeaderText="Assigned Hours" HeaderTooltip="AssignedHours"
                            SortExpression="AssignedHours" UniqueName="AssignedHours" DataFormatString="{0:N0}"
                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="180px"
                            Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Center">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="WorkedHours" HeaderText="Worked Hours" HeaderTooltip="WorkedHours"
                            SortExpression="WorkedHours" UniqueName="WorkedHours" DataFormatString="{0:N0}"
                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="180px"
                            Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Center">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Efficiency" HeaderText="Efficiency" HeaderTooltip="Efficiency is calculated by comparing the hours assigned vs hours worked as it pertains to Jobs listed as done or inactive"
                            SortExpression="Efficiency" UniqueName="Efficiency" DataFormatString="{0:p}"
                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="180px">
                        </telerik:GridBoundColumn>

                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
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
        SelectCommand="YearStadistic_EmployeeJobEfficiency" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboEmployees" DefaultValue="" Name="employeeId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>



    <asp:SqlDataSource ID="SqlDataSourceDepartmentFTE" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="YearStadistic_EmployeeDepartmentsList" SelectCommandType="StoredProcedure">
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

