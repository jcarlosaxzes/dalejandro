<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="memory.aspx.vb" Inherits="pasconcept20.memory" %>

<%@ Import Namespace="pasconcept20" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Memory</title>
    <script src="../Scripts/bootstrap.js"></script>
    <%--Bootstrap reference begin--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <%--Bootstrap reference end--%>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        </telerik:RadScriptManager>
        <div class="container">

            <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceEmployee">
                <ItemTemplate>
                    <div class="row">
                        <h2>Employee Memory <%# Eval("year") %></h2>
                        <div class="col-md-12">

                            <p>
                                Congratulations <code><%# Eval("Name") %></code> on another year as a <mark><%# Eval("Position") %></mark> with <code><%# Eval("Company") %></code>. 
                           
                            </p>
                            <p>
                                This year <%# Eval("year") %> you have used <mark><%# Eval("Vacations") %></mark> days of Vacations, <mark><%# Eval("EmployeeHollidays") %></mark> days of Holidays and <mark><%# Eval("Sick") %></mark> days of Personal/Sick Time.
                           
                            </p>
                            <p>
                                <h4>Net Annual Salary: <code><%# Eval("NetAnnualSalary","{0:C2}") %></code></h4>
                                Your presently  hourly wage is <mark><%# Eval("HourlyWage","{0:C2}") %></mark> which translates to a bi-weekly payment of <mark><%# Eval("BiWeeklySalary","{0:C2}") %></mark> over the course of this calendar year.  
                                You net salary totaled to <code><%# Eval("NetAnnualSalary","{0:C2}") %></code>
                                and your gross total salary of <mark><%# Eval("GrossAnnualSalary","{0:C2}") %></mark>. 
                                This results in a total cost to <%# Eval("Company") %> of <mark><%# Eval("TotalCostAnnualSalary","{0:C2}") %></mark>.
                               
                                <br />
                                In addition to this, utilizing the hours you have associated to a project in association with the number of working hours in the year, 
                                we have calculated your <code>Productivity Rate</code> as <code><%# Eval("ProductivityRate","{0:p}") %></code>. 
                               
                                <br />
                                We have calculated your <code>Efficiency</code> of <code><%# Eval("Efficiency","{0:p}") %></code> measures of the relation between Assigned hours account the Worked in projects this year.
                           
                            </p>

                            <p>
                                At our yearly employee review we will be going over the hours you have dedicated to your department a as well as your overall efficiency. To review this please see the additional tables below. 
                                We will be contacting you shortly to schedule your review.
                           
                            </p>
                            <p>
                                We presently, as of <small><%# DateTime.Now %></small>,  have the following address, email and primary phone number associated with you;
                               
                                <br />
                                <%# Eval("Email") %>
                                <br />
                                <%#  LocalAPI.PhoneHTML(Request.UserAgent, Eval("Phone")) %>
                                <br />
                                <%# Eval("Address") %>
                                <br />
                                In an  effort to keep our records up to date from year to year, should any of the information above no longer be accurate, please let us know at your yearly employee review.
                           
                            </p>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <h4>Hours by Departments</h4>
                            <telerik:RadGrid ID="RadGridDepartmentFTE" runat="server" DataSourceID="SqlDataSourceDepartmentFTE" AutoGenerateColumns="False" ShowFooter="true" Skin="" RenderMode="Lightweight"
                                FooterStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" FooterStyle-Font-Bold="true">
                                <MasterTableView DataSourceID="SqlDataSourceDepartmentFTE" DataKeyNames="DepartmentId">

                                    <Columns>
                                        <telerik:GridTemplateColumn DataField="Department" HeaderText="Department" SortExpression="Department"
                                            UniqueName="Department" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="400px" FooterStyle-HorizontalAlign="Center" >
                                            <ItemTemplate>
                                                <asp:Label ID="lblCompanyId" runat="server"
                                                    Text='<%# Eval("Department")%>'>
                                                </asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate><b>Totals</b></FooterTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridBoundColumn DataField="OpenWorkload" HeaderText="Open Workload" HeaderTooltip="OpenWorkload in Hours"
                                            SortExpression="OpenWorkload" UniqueName="OpenWorkload" DataFormatString="{0:N0}"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="130px"
                                            Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Center">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="BudgetAssigned" HeaderText="Budget Assigned" HeaderTooltip="Hours Assigned x HourlyRate x Multipler"
                                            SortExpression="BudgetAssigned" UniqueName="BudgetAssigned" DataFormatString="{0:C0}"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="130px"
                                            Aggregate="Sum" FooterAggregateFormatString="{0:C0}" FooterStyle-HorizontalAlign="Center">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="BudgetUsed" HeaderText="Budget Used" HeaderTooltip="Hours x HourlyRate"
                                            SortExpression="BudgetUsed" UniqueName="BudgetUsed" DataFormatString="{0:C0}"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="130px"
                                            Aggregate="Sum" FooterAggregateFormatString="{0:C0}" FooterStyle-HorizontalAlign="Center">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="FTE" HeaderText="FTE" HeaderTooltip="Full-Time Equivalent %"
                                            SortExpression="FTE" UniqueName="FTE" DataFormatString="{0:p}"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px"
                                            Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Center">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Profit" HeaderText="Efficiency" HeaderTooltip="Hours x HourlyRate"
                                            SortExpression="Profit" UniqueName="Profit" DataFormatString="{0:P0}"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px"
                                            Aggregate="Sum" FooterAggregateFormatString="{0:P0}" FooterStyle-HorizontalAlign="Center">
                                        </telerik:GridBoundColumn>

                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <br />
                            <h4>Jobs Employee Efficiency</h4>
                            <telerik:RadGrid ID="RadGridEfficiency" runat="server" DataSourceID="SqlDataSourceEfficiency" AutoGenerateColumns="False" ShowFooter="true" Skin="" RenderMode="Lightweight"
                                FooterStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" FooterStyle-Font-Bold="true">
                                <MasterTableView DataSourceID="SqlDataSourceEfficiency" DataKeyNames="jobId">

                                    <Columns>
                                        <telerik:GridTemplateColumn DataField="JobName" HeaderText="Job Name" SortExpression="JobName"
                                            UniqueName="JobName" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="450px" >
                                            <ItemTemplate>
                                                <asp:Label ID="lblCompanyId" runat="server"
                                                    Text='<%# Eval("JobName")%>'>
                                                </asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate><b>Totals</b></FooterTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridBoundColumn DataField="JobStatus" HeaderText="Status" HeaderTooltip="Job Status" SortExpression="JobStatus" UniqueName="JobStatus" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="180px">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="AssignedHours" HeaderText="Assigned Hours" HeaderTooltip="AssignedHours"
                                            SortExpression="AssignedHours" UniqueName="AssignedHours" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="180px"  Aggregate="Sum" FooterAggregateFormatString="{0:N0}">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="WorkedHours" HeaderText="Worked Hours" HeaderTooltip="WorkedHours" SortExpression="WorkedHours" UniqueName="WorkedHours" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="180px" Aggregate="Sum" FooterAggregateFormatString="{0:N0}">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Profit" HeaderText="Efficiency" SortExpression="Profit" UniqueName="Profit" DataFormatString="{0:P1}" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="180px"
                                            Aggregate="Avg" FooterAggregateFormatString="{0:P0}">
                                        </telerik:GridBoundColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                    </div>

                    <p>
                        <br />
                        Again, we would like to thank you for all the hard work you have provided to <code><%# Eval("Company") %></code>. 
                       
                        <br />
                        We know we wouldn’t be the company we are today without the hard work of our employees.
                   
                    </p>
                    <p>Best Regards,</p>

                </ItemTemplate>
            </asp:FormView>


        </div>
        <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="YearStadistic_EmployeeReport_SELECT" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" />
                <asp:ControlParameter ControlID="lblYear" Name="year" PropertyName="Text" />
                <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceDepartmentFTE" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="YearStadistic_v20_EmployeeDepartmentsList" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
                <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" />
                <asp:ControlParameter ControlID="lblYear" Name="year" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceEfficiency" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="YearStadistic_v20_EmployeeJobEfficiency" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" />
                <asp:ControlParameter ControlID="lblYear" Name="year" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblYear" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblEmployeeId" runat="server" Visible="False" Text="0"></asp:Label>
    </form>
</body>
</html>
