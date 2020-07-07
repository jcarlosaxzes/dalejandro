<%@ Page Title="Department Report" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="departmentreport.aspx.vb" Inherits="pasconcept20.departmentreport" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Department Report</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>
        </span>


    </div>


    <div class="collapse" id="collapseFilter">
        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnRefresh">

            <table class="table-sm pasconcept-bar" style="width: 100%">
                <tr>
                    <td style="width: 150px">
                        <telerik:RadDropDownList ID="cboYear" runat="server" DataSourceID="SqlDataSourceYear" DataTextField="nYear"
                            DataValueField="Year" Width="100px" AutoPostBack="true" CausesValidation="false" UseSubmitBehavior="false">
                        </telerik:RadDropDownList>
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboDepartments" runat="server" DataSourceID="SqlDataSourceDepartments"
                            DataTextField="Name" DataValueField="Id" Height="300px" Width="400px">
                        </telerik:RadComboBox>


                    </td>
                    <td style="width: 150px; text-align: right">
                        <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false"
                            ToolTip="Refresh data" CausesValidation="false">
                            <i class="fas fa-redo"></i> Refresh
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>

        </asp:Panel>
    </div>


    <div class="row">
        <div class="col-md-6">
            <%--[Insert table with Employees and their FTE]--%>
            <telerik:RadGrid ID="RadGridEmpls" runat="server" DataSourceID="SqlDataSourceEmployees" AllowPaging="True" PageSize="8"
                GridLines="None" AllowSorting="True" AutoGenerateColumns="False" CellSpacing="0" ShowFooter="true" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                <MasterTableView DataSourceID="SqlDataSourceEmployees" DataKeyNames="EmployeeId">
                    <PagerStyle Mode="Slider" AlwaysVisible="false" />
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                            <ItemTemplate>
                                <asp:Image ID="ImageEmployeePhoto" ImageUrl='<%# LocalAPI.GetEmployeePhotoURL(employeeId:=Eval("EmployeeId"))%>'
                                    runat="server" Width="45" CssClass="img-thumbnail"></asp:Image>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn DataField="EmployeeName" HeaderText="Employee" SortExpression="" Aggregate="Count"
                            UniqueName="" HeaderStyle-HorizontalAlign="Center"
                            FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <strong><%# Eval("EmployeeName")%></strong><br />
                                <small>
                                    <%# Eval("Position")%>
                                </small>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn DataField="Department" HeaderText="Department" SortExpression="Department"
                            UniqueName="Department" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label ID="lblCompanyId" runat="server"
                                    Text='<%# Eval("Department")%>'
                                    Font-Bold='<%# Eval("IsHead")%>'
                                    Font-Italic='<%# Eval("DD")=0 %>'>
                                </asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridBoundColumn DataField="FTE" HeaderText="FTE" HeaderTooltip="Full-Time Equivalent %"
                            SortExpression="FTE" UniqueName="FTE" DataFormatString="{0:p}"
                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="90px"
                            Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Center">
                        </telerik:GridBoundColumn>

                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
        <div class="col-md-3">
            <%--[INSERT FUNNEL GRAPH]--%>
            <h4 style="text-align: center">Department Funnel</h4>
            <telerik:RadHtmlChart ID="FunnelChart1" runat="server" DataSourceID="SqlDataSourceFunnelChart" Height="320px" Width="100%">
                <PlotArea>
                    <Series>
                        <telerik:FunnelSeries DataFieldY="Total" Name="Title" DynamicSlopeEnabled="true" SegmentSpacing="5" DataNameField="Title">
                            <LabelsAppearance Align="Center" Position="Center" Color="Black">
                                <ClientTemplate> 
                                    #=kendo.format(\'{0:C0}\', value)#\n
                                    #=category#
                                </ClientTemplate>
                            </LabelsAppearance>
                            <LabelsAppearance Align="Center" Position="Center"></LabelsAppearance>
                            <TooltipsAppearance Color="White" Visible="false"></TooltipsAppearance>
                        </telerik:FunnelSeries>
                    </Series>
                    <CommonTooltipsAppearance Visible="false"></CommonTooltipsAppearance>
                </PlotArea>
                <Legend>
                    <Appearance Visible="False"></Appearance>
                </Legend>
            </telerik:RadHtmlChart>
            <h4 style="text-align: center">Department ROI:
                            <asp:Label ID="lblROI" runat="server" Text="ROI value">
                            </asp:Label></h4>

            <%-- [ROI=(GAINS-COSTS)/COSTS]--%>
        </div>
        <div class="col-md-3">
            <h4 style="text-align: center; margin: 0">Proposal Weight<%--[INSERT PROPOSAL PIE]--%></h4>
            <telerik:RadHtmlChart runat="server" ID="PieChart1" Transitions="true" DataSourceID="SqlDataSourcePieProposalsChart" Height="200px" Width="100%">
                <Legend>
                    <Appearance Visible="false">
                    </Appearance>
                </Legend>
                <PlotArea>
                    <Series>
                        <telerik:PieSeries DataFieldY="PercentValue" ExplodeField="Exploded" NameField="Name" ColorField="Color">
                            <LabelsAppearance Position="OutsideEnd" DataFormatString="{0} %">
                                <ClientTemplate>#if(dataItem.Exploded==1) {# #= value# % #}#</ClientTemplate>
                            </LabelsAppearance>
                            <TooltipsAppearance Color="White" DataFormatString="{0} %"></TooltipsAppearance>
                        </telerik:PieSeries>
                    </Series>
                </PlotArea>
            </telerik:RadHtmlChart>
            <h4 style="text-align: center; margin: 0">Job Weight<%--[INSERT JOB PIE]--%></h4>
            <telerik:RadHtmlChart runat="server" ID="PieChart2" Transitions="true" DataSourceID="SqlDataSourcePieJobsChart" Height="200px" Width="100%">
                <Legend>
                    <Appearance Visible="false">
                    </Appearance>
                </Legend>
                <PlotArea>
                    <Series>
                        <telerik:PieSeries DataFieldY="PercentValue" ExplodeField="Exploded" NameField="Name" ColorField="Color">
                            <LabelsAppearance Position="OutsideEnd" DataFormatString="{0} %">
                                <ClientTemplate>#if(dataItem.Exploded==1) {# #= value# % #}#</ClientTemplate>
                            </LabelsAppearance>
                            <TooltipsAppearance Color="White" DataFormatString="{0} %"></TooltipsAppearance>
                        </telerik:PieSeries>
                    </Series>
                </PlotArea>
            </telerik:RadHtmlChart>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <h4>Average Project Life-cycle:</h4>
            <%--[Insert Graph, Graph should contain the following]
            Average Project Life-cycle:
            Proposal Acceptance: [Average time]
            Job Completion: [Average time]
            Invoice from Emmited to Paid: [Average time]--%>
            <%--             DataLowerField="lower"
                        DataQ1Field="q1"
                        DataMedianField="median"
                        DataQ3Field="q3"
                        DataMeanField="mean"
                        DataUpperField="upper"
                        DataOutliersField="outliers--%>

            <telerik:RadHtmlChart runat="server" ID="BoxPlotChartLifeCycle" DataSourceID="SqlDataSourceLifeCycle" Width="100%" Height="250px">
                <PlotArea>
                    <Series>
                        <telerik:VerticalBoxPlotSeries
                            DataLowerField="lower"
                            DataQ1Field="q1"
                            DataMedianField="median"
                            DataQ3Field="q3"
                            DataUpperField="upper"
                            ColorField="Color">
                            <TooltipsAppearance Color="White" DataFormatString="{0:N0}"></TooltipsAppearance>
                        </telerik:VerticalBoxPlotSeries>
                    </Series>
                    <XAxis DataLabelsField="Title">
                    </XAxis>
                </PlotArea>
            </telerik:RadHtmlChart>

        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <h2>Financial Summary</h2>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-2">
            <asp:RadioButton runat="server" ID="month" GroupName="datepart" AutoPostBack="true" Checked="true" Text="month view" />
        </div>
        <div class="col-md-2">
            <asp:RadioButton runat="server" ID="year" GroupName="datepart" AutoPostBack="true" Text="year view" />
        </div>
        <div class="col-md-4"></div>


        <div class="col-md-12">
            <%--TOOL TIP: The Following Graph demonstrates the departments expenses. Expenses are calculated as company overhead divided by FTE plus salary and wages.--%>
            <%--TOOL TIP:The following graph demonstrates the departments revenue.--%>
            <%--TOOL TIP: The following graph demonstrates the departments total profit expenses. Profit is calculated as revenue minus expenses.--%>
            <telerik:RadHtmlChart runat="server" Width="100%" Height="500px" ID="RadChartFinancialSummary" Transitions="true"
                DataSourceID="SqlDataSourceFinancialSummary">
                <PlotArea>
                    <Series>
                        <telerik:LineSeries DataFieldY="Profit" Name="Profit">
                            <Appearance>
                                <FillStyle BackgroundColor="Red" />
                            </Appearance>
                            <LineAppearance LineStyle="Smooth" Width="2" />
                            <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                            <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                            <LabelsAppearance Color="Red" RotationAngle="300" Position="Above" DataFormatString="{0:N0}"></LabelsAppearance>
                        </telerik:LineSeries>
                        <telerik:ColumnSeries DataFieldY="Revenue" Name="Revenue">
                            <Appearance>
                                <FillStyle BackgroundColor="ForestGreen" />
                            </Appearance>
                            <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                            <LabelsAppearance DataFormatString="{0:N0}" Visible="False">
                            </LabelsAppearance>
                        </telerik:ColumnSeries>
                        <telerik:ColumnSeries DataFieldY="Expence" Name="Expence">
                            <Appearance>
                                <FillStyle BackgroundColor="#000099" />
                            </Appearance>
                            <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                            <LabelsAppearance DataFormatString="{0:N0}" Visible="False">
                            </LabelsAppearance>
                        </telerik:ColumnSeries>
                    </Series>

                    <XAxis DataLabelsField="DateTimeName">
                        <LabelsAppearance RotationAngle="300">
                        </LabelsAppearance>
                        <TitleAppearance Text="">
                        </TitleAppearance>
                        <MinorGridLines Visible="false"></MinorGridLines>
                        <AxisCrossingPoints>
                            <telerik:AxisCrossingPoint Value="0" />
                            <telerik:AxisCrossingPoint Value="9999" />
                        </AxisCrossingPoints>
                    </XAxis>
                    <YAxis Name="LeftAxis" MajorTickSize="4" MajorTickType="Outside" MinorTickSize="1" Color="Red" Width="3">
                        <TitleAppearance Text="$"></TitleAppearance>
                        <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                        <MinorGridLines Visible="false"></MinorGridLines>
                    </YAxis>
                </PlotArea>
                <Legend>
                    <Appearance Visible="true" Position="Bottom">
                    </Appearance>
                </Legend>
            </telerik:RadHtmlChart>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <h2>Customer/Client Summary</h2>
        </div>
    </div>
    <div class="row">
        <div class="col-md-3">
            <h4>Average Customer Value:</h4>
            <h5>
                <asp:Label ID="lblCustomer1" runat="server" ToolTip="Total dollar value of all jobs related to this department divided by the total number of department customers"></asp:Label></h5>
        </div>
        <div class="col-md-3">
            <h4>Average Customer Revenue:</h4>
            <h5>
                <asp:Label ID="lblCustomer2" runat="server" ToolTip="Total dollar value of all collected inviced related to this department divided by the total number of department customers"></asp:Label></h5>
        </div>
        <div class="col-md-2">
            <h4>Total Number of Customer:</h4>
            <h5>
                <asp:Label ID="lblCustomer3" runat="server" ToolTip="Total number of customers of department"></asp:Label></h5>
        </div>
        <div class="col-md-2">
            <h4>Total Number of New Clients: </h4>
            <h5>
                <asp:Label ID="lblCustomer4" runat="server" ToolTip="Total number of new customers of department" Text="0"></asp:Label></h5>
        </div>
        <div class="col-md-2">
            <h4>Total Number of Recurrent Customers:</h4>
            <h5>
                <asp:Label ID="lblCustomer5" runat="server" ToolTip="Total number of recurrent customers of department" Text="0"></asp:Label></h5>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <h2>Department Breakout</h2>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <h4>Average Department Cost Breakdown: </h4>
            <p>
                Total Annual Salary:
                <asp:Label ID="lblDepartmentSalarySum" runat="server" ToolTip="Total salary of department"></asp:Label>
            </p>
            <p>
                Average Monthly Salary:
                <asp:Label ID="lblDepartmentSalaryAvg" runat="server" ToolTip="Average salary of department"></asp:Label>
            </p>
            <p>
                Total Annual Overhead: 
                <asp:Label ID="lblDepartmentOverhead_Direct" runat="server" ToolTip="Overhead of all employees of department"></asp:Label>
            </p>
        </div>
        <div class="col-md-6">
            <telerik:RadHtmlChart ID="RadHtmlChartSalary" runat="server" DataSourceID="SqlDataSourceDepartmentSalary" Height="350px" Width="100%">
                <ChartTitle Text="Monthly Salary Total vs Average">
                    <Appearance Align="Center" BackgroundColor="White" Position="Top"></Appearance>
                </ChartTitle>
                <PlotArea>
                    <Series>
                        <telerik:VerticalBulletSeries DataCurrentField="Total" DataTargetField="Average" Name="Department Monthly Salary">
                        </telerik:VerticalBulletSeries>
                    </Series>

                    <YAxis Name="LeftAxis" MajorTickSize="4" MajorTickType="Outside" Width="3">
                        <TitleAppearance Text="$"></TitleAppearance>
                        <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                    </YAxis>
                    <XAxis DataLabelsField="monthName">
                        <TitleAppearance Text="Month"></TitleAppearance>
                    </XAxis>
                </PlotArea>
                <Legend>
                    <Appearance Visible="false">
                    </Appearance>
                </Legend>
            </telerik:RadHtmlChart>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <telerik:RadHtmlChart ID="RadHtmlChartDepartmentWorkload" runat="server" DataSourceID="SqlDataSourceDepartmentWorkload" Height="350px" Width="100%">
                <ChartTitle Text="Monthly Workload in Hours">
                    <Appearance Align="Center" BackgroundColor="White" Position="Top"></Appearance>
                </ChartTitle>
                <PlotArea>
                    <Series>
                        <telerik:ColumnSeries DataFieldY="WorkLoad" Name="Workload">
                            <TooltipsAppearance Color="White" DataFormatString="{0:N0}" />
                            <LabelsAppearance Visible="false"></LabelsAppearance>
                        </telerik:ColumnSeries>
                    </Series>


                    <YAxis Name="LeftAxis" MajorTickSize="4" MajorTickType="Outside" Width="3">
                        <TitleAppearance Text="hours"></TitleAppearance>
                        <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                    </YAxis>
                    <XAxis DataLabelsField="monthName">
                        <TitleAppearance Text="Month"></TitleAppearance>
                    </XAxis>
                </PlotArea>
                <Legend>
                    <Appearance Visible="false">
                    </Appearance>
                </Legend>
            </telerik:RadHtmlChart>
        </div>

        <div class="col-md-6">
            <telerik:RadHtmlChart ID="RadHtmlChartDepartmmentOverhead" runat="server" DataSourceID="SqlDataSourceDepartmmentOverhead" Height="350px" Width="100%">
                <ChartTitle Text="Monthly Overhead Department vs Company">
                    <Appearance Align="Center" BackgroundColor="White" Position="Top"></Appearance>
                </ChartTitle>
                <PlotArea>
                    <Series>
                        <telerik:VerticalBulletSeries DataCurrentField="CompanyOverhead" DataTargetField="DptoOverhead" Name="Department Monthly Overhead">
                        </telerik:VerticalBulletSeries>
                    </Series>

                    <YAxis Name="LeftAxis" MajorTickSize="4" MajorTickType="Outside" Width="3">
                        <TitleAppearance Text="$"></TitleAppearance>
                        <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                    </YAxis>
                    <XAxis DataLabelsField="monthName">
                        <TitleAppearance Text="Month"></TitleAppearance>
                    </XAxis>
                </PlotArea>
                <Legend>
                    <Appearance Visible="false">
                    </Appearance>
                </Legend>
            </telerik:RadHtmlChart>
        </div>

        <div class="row">
            <div class="col-md-12">
                <h4>Detailed Employees</h4>
                <%--[Same as standard employee chart but filtered to this department]--%>
                <telerik:RadGrid ID="RadGridDetailedEmployees" runat="server" DataSourceID="SqlDataSourceDetailedEmployees" PageSize="10" AllowPaging="True"
                    GridLines="None" AllowSorting="True" AutoGenerateColumns="False" CellSpacing="0" ShowFooter="true" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                    <ClientSettings>
                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                    </ClientSettings>
                    <MasterTableView DataSourceID="SqlDataSourceDetailedEmployees" DataKeyNames="EmployeeId">
                        <PagerStyle Mode="Slider" AlwaysVisible="false" />
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Photo" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="70px" ReadOnly="true">
                                <ItemTemplate>
                                    <asp:Image ID="ImageEmployeePhoto" ImageUrl='<%# LocalAPI.GetEmployeePhotoURL(employeeId:=Eval("EmployeeId"))%>'
                                        runat="server" Width="45" Height="50" AlternateText='<%# Eval("EmployeeName", "{0} photo") %>'></asp:Image>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="EmployeeName" HeaderText="Employee" SortExpression="EmployeeName" Aggregate="Count"
                                UniqueName="EmployeeName" HeaderStyle-HorizontalAlign="Center"
                                FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Center" ReadOnly="true">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Jobs_Count" HeaderText="Jobs (#)"
                                ReadOnly="True" SortExpression="Jobs_Count" UniqueName="Jobs_Count" DataFormatString="{0:N0}"
                                ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="60px"
                                Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="Uptime" HeaderText="Uptime" HeaderTooltip="Total amount of employee productive time dedicated towards the completion of a job/project"
                                ReadOnly="True" SortExpression="Uptime" UniqueName="Uptime" DataFormatString="{0:N0}"
                                ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="70px"
                                Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Downtime" HeaderText="Downtime" HeaderTooltip="Total amount of employee miscellaneous time dedicated to tasks not related to a specific job/project"
                                ReadOnly="True" SortExpression="Downtime" UniqueName="Downtime" DataFormatString="{0:N0}"
                                ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px"
                                Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="ConsistencyPercent" DataType="System.Double" HeaderText="Consistency (%)" HeaderStyle-Width="100px"
                                ReadOnly="True" SortExpression="ConsistencyPercent" UniqueName="ConsistencyPercent" DataFormatString="{0:N2}" HeaderTooltip="Simple average of % Budget Used disregarding individual job/project budget weight with respect to Revenue per employee"
                                ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="EfficiencyPercent" DataType="System.Double" HeaderText="Efficiency (%)" HeaderStyle-Width="100px"
                                ReadOnly="True" SortExpression="EfficiencyPercent" UniqueName="EfficiencyPercent" DataFormatString="{0:N2}" HeaderTooltip="Weighted average of % Budget Used based on individual job/project budget weight with respect to Revenue per employee"
                                ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Revenue" HeaderText="Revenue" HeaderTooltip="Gross financial income as per contract agreement, including outsourcing"
                                ReadOnly="True" SortExpression="Revenue" UniqueName="Revenue" DataFormatString="{0:N2}" HeaderStyle-Width="100px"
                                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                                Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Right">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="BudgetUsed" HeaderText="Budget Used" HeaderStyle-Width="100px" HeaderTooltip="Amount utilized from available budget"
                                ReadOnly="True" SortExpression="BudgetUsed" UniqueName="BudgetUsed" DataFormatString="{0:N2}"
                                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                                Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Right">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Profit" HeaderText="Profit" HeaderStyle-Width="100px" HeaderTooltip="Net financial gain; difference between amount earned (Revenue) and amount spent (Budget Used)"
                                ReadOnly="True" SortExpression="Profit" UniqueName="Profit" DataFormatString="{0:N2}"
                                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                                Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Right">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="EmployeeHR" HeaderText="Employee HR" SortExpression="EmployeeHR" UniqueName="EmployeeHR" HeaderStyle-Width="100px"
                                HeaderTooltip="Value of 'Hourly Rate' in employee profile"
                                ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lnkEdit" runat="server" Text='<%# Eval("EmployeeHR", "{0:N2}")%>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="ProductionHR" HeaderText="Production HR" HeaderTooltip="The sum of the Revenue generated by an employee divided by the sum of production time (Uptime)"
                                ReadOnly="True" SortExpression="ProductionHR" UniqueName="ProductionHR" DataFormatString="{0:N2}"
                                ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px"
                                Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="HourlyRate" HeaderText="Hourly Rate" HeaderTooltip="The sum of the Revenue generated by an employee divided by the sum of total time (Uptime and Downtime)"
                                ReadOnly="True" SortExpression="HourlyRate" UniqueName="HourlyRate" DataFormatString="{0:N2}"
                                ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px"
                                Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
        </div>
        <asp:SqlDataSource ID="SqlDataSourceFunnelChart" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="YearStadistic_DepartmentFunnelChart" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
                <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="cboDepartments" DefaultValue="" Name="dptoId" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>


        <asp:SqlDataSource ID="SqlDataSourcePieProposalsChart" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="YearStadistic_DepartmentPieChart" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
                <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
                <asp:Parameter DefaultValue="1" Name="compareferomId" Type="Int32" />
                <asp:ControlParameter ControlID="cboDepartments" DefaultValue="" Name="dptoId" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>


        <asp:SqlDataSource ID="SqlDataSourcePieJobsChart" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="YearStadistic_DepartmentPieChart" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
                <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
                <asp:Parameter DefaultValue="2" Name="compareferomId" Type="Int32" />
                <asp:ControlParameter ControlID="cboDepartments" DefaultValue="" Name="dptoId" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="SELECT [Year], nYear FROM Years ORDER BY [Year] DESC"></asp:SqlDataSource>


        <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="YearStadistic_DepartmentEmployeesList" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
                <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="cboDepartments" DefaultValue="" Name="dptoId" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceLifeCycle" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="YearStadistic_DepartmentAvgProjectLifeCycle" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
                <asp:ControlParameter ControlID="cboDepartments" DefaultValue="" Name="dptoId" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceFinancialSummary" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="YearStadistic_DepartmentExpencesRevenueProfit" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="cboDepartments" DefaultValue="" Name="dptoId" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="lblDatePart" Name="datepart" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>


        <asp:SqlDataSource ID="SqlDataSourceDepartmentSalary" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="YearStadistic_DepartmentSalary" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="cboDepartments" DefaultValue="" Name="dptoId" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceDepartmmentOverhead" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="YearStadistic_DepartmmentOverhead" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="cboDepartments" DefaultValue="" Name="dptoId" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceDepartmentWorkload" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="YearStadistic_DepartmentWorkload" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="cboDepartments" DefaultValue="" Name="dptoId" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceDetailedEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="YearStadistic_DepartmentEMPLOYEES_Profit" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="cboDepartments" DefaultValue="" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblDatePart" runat="server" Visible="False" Text="month"></asp:Label>
</asp:Content>

