<%@ Page Title="Company Multiplier" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="companymultiplier.aspx.vb" Inherits="pasconcept20.companymultiplier" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .MostInnerHeaderStyle {
            font-size: 12px !important;
        }

        .MostInnerItemStyle {
            font-size: 12px !important;
        }

        .MostInnerAlernatingItemStyle {
            font-size: 12px !important;
        }
    </style>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Company Multiplier</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>
        </span>
    </div>


    <div class="collapse" id="collapseFilter">

        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
            <table class="table-sm pasconcept-bar" style="width: 100%">
                <tr>
                    <td style="width:200px">
                        <telerik:RadComboBox ID="cboYear" runat="server" DataSourceID="SqlDataSourceYears"
                            DataTextField="nYear" DataValueField="Year" Width="100%">
                        </telerik:RadComboBox>
                    </td>
                    <td style="width:350px">
                        <telerik:RadComboBox ID="cboDepartments" runat="server" DataSourceID="SqlDataSourceDepartments" MarkFirstMatch="True" 
                            Width="100%" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(Select Department...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboEmployees" runat="server" DataSourceID="SqlDataSourceEmployees" MarkFirstMatch="True" 
                            Width="350px" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Employees...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 150px; text-align: right">
                        <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>
                    </td>

                </tr>
            </table>
        </asp:Panel>
    </div>

    <div class="pasconcept-bar" style="padding-top: 15px">
        <telerik:RadWizard ID="RadWizard1" runat="server" DisplayCancelButton="false" RenderMode="Lightweight" Skin="Silk" DisplayNavigationButtons="false" DisplayProgressBar="false">
            <WizardSteps>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep1" Title="Company Multiplier" StepType="Step">
                    <div>
                        <table class="table-sm" style="width: 100%">
                            <tr>
                                <td>
                                    <asp:LinkButton ID="btnNewMultiplier" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" ToolTip="Add Multiplier Record">
                                        <i class="fas fa-plus"></i> Year
                                    </asp:LinkButton>
                                </td>
                                <td>
                                    <asp:LinkButton ID="btnCalculateMultiplier" runat="server" CssClass="btn btn-danger" UseSubmitBehavior="false" ToolTip="Calculate">
                                        Calculate
                                    </asp:LinkButton>
                                </td>
                                <td>
                                    <small>
                                        <b>Calculate:</b> Estimate Salary and Productive Salary from Employees Profile Information, Calculate Multiplier=[Total Estimated Expenses] * [Desired Profit] / [Estimate Productive Salary] for selected year
                                        <br />
                                        <b>Estimated Income:</b> [Total Estimated Expenses] + [$ Desired Profit]
                                        <br />
                                        <b>Actual Income:</b> [Collected invoices] of Year(Jobs Date)
                                    </small>
                                </td>

                            </tr>
                        </table>
                        <table class="table-sm" style="width: 100%">
                            <tr>
                                <td>
                                    <telerik:RadGrid ID="RadGridMultiplier" GridLines="None" runat="server" AllowAutomaticDeletes="True"
                                        AllowAutomaticInserts="True" AllowAutomaticUpdates="True"
                                        AutoGenerateColumns="False" DataSourceID="SqlDataSourceMultiplier" ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" HeaderStyle-HorizontalAlign="Center">
                                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceMultiplier" AutoGenerateColumns="False" CommandItemDisplay="Top">
                                            <CommandItemSettings ShowAddNewRecordButton="false" />
                                            <ColumnGroups>
                                                <telerik:GridColumnGroup HeaderText="Estimated Expenses" Name="EstimatedGroup" HeaderStyle-HorizontalAlign="Center">
                                                </telerik:GridColumnGroup>
                                                <telerik:GridColumnGroup HeaderText="Desired Profit" Name="ProfitGroup" HeaderStyle-HorizontalAlign="Center">
                                                </telerik:GridColumnGroup>
                                            </ColumnGroups>


                                            <Columns>

                                                <telerik:GridTemplateColumn DataField="Year" HeaderStyle-Width="60px" HeaderText="Year"
                                                    SortExpression="Year" UniqueName="Year" ItemStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="btnYear" runat="server" ToolTip="Click to Edit Row" CommandName="Edit" UseSubmitBehavior="false">
                                            <%#Eval("Year")%> 
                                                        </asp:LinkButton>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <telerik:RadTextBox ID="txtYearMult" runat="server" Text='<%# Bind("Year") %>' />
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridNumericColumn DataField="Salary" HeaderText="Salary"
                                                    SortExpression="Salary" UniqueName="Salary" DataFormatString="{0:N2}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right"
                                                    ColumnGroupName="EstimatedGroup">
                                                </telerik:GridNumericColumn>

                                                <telerik:GridNumericColumn DataField="SalaryTax" HeaderText="Salary Tax"
                                                    SortExpression="SalaryTax" UniqueName="SalaryTax" DataFormatString="{0:N2}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right"
                                                    ColumnGroupName="EstimatedGroup">
                                                </telerik:GridNumericColumn>

                                                <telerik:GridNumericColumn DataField="ProductiveSalary" HeaderText="Productive S"
                                                    SortExpression="ProductiveSalary" UniqueName="ProductiveSalary" DataFormatString="{0:N2}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right"
                                                    ColumnGroupName="EstimatedGroup">
                                                </telerik:GridNumericColumn>

                                                <telerik:GridNumericColumn DataField="SubContracts" HeaderText="SubContracts"
                                                    SortExpression="SubContracts" UniqueName="SubContracts" DataFormatString="{0:N2}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right"
                                                    ColumnGroupName="EstimatedGroup">
                                                </telerik:GridNumericColumn>

                                                <telerik:GridNumericColumn DataField="Rent" HeaderText="Rent"
                                                    SortExpression="Rent" UniqueName="Rent" DataFormatString="{0:N2}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right"
                                                    ColumnGroupName="EstimatedGroup">
                                                </telerik:GridNumericColumn>

                                                <telerik:GridNumericColumn DataField="Others" HeaderText="Others"
                                                    SortExpression="Others" UniqueName="Others" DataFormatString="{0:N2}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right"
                                                    ColumnGroupName="EstimatedGroup">
                                                </telerik:GridNumericColumn>

                                                <telerik:GridNumericColumn DataField="Total" HeaderText="Total"
                                                    SortExpression="Total" UniqueName="Total" DataFormatString="{0:N2}" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right"
                                                    ColumnGroupName="EstimatedGroup">
                                                </telerik:GridNumericColumn>

                                                <telerik:GridNumericColumn DataField="Profit" HeaderStyle-Width="80px" HeaderText="(%)"
                                                    SortExpression="Profit" UniqueName="Profit" DataFormatString="{0:N1}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                                    ColumnGroupName="ProfitGroup">
                                                </telerik:GridNumericColumn>

                                                <telerik:GridNumericColumn DataField="DesiredProfitAmount" HeaderText="($)"
                                                    SortExpression="DesiredProfitAmount" UniqueName="DesiredProfitAmount" DataFormatString="{0:N2}" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right"
                                                    ColumnGroupName="ProfitGroup">
                                                </telerik:GridNumericColumn>

                                                <telerik:GridTemplateColumn DataField="TotalAndProfit" HeaderText="Necesary Income<br/>Estimated:....<br/>Actual:.......%"
                                                    SortExpression="TotalAndProfit" UniqueName="TotalAndProfit" ReadOnly="true" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <table style="width: 100%">
                                                            <tr>
                                                                <td style="font-size: small; text-align: center; font-weight: bold">
                                                                    <%#Eval("TotalAndProfit", "{0:N2}")%>
                                                                    <hr style="margin: 0" />
                                                                </td>
                                                                <td></td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: small; color: darkgreen; text-align: center; font-weight: bold">
                                                                    <%#Eval("ActualIncome", "{0:N2}")%> 
                                                                </td>
                                                                <td style="font-size: smaller; text-align: right">
                                                                    <%#Eval("IncomePercent", "{0:N0}") %> %
                                                                </td>
                                                            </tr>
                                                        </table>

                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridNumericColumn DataField="Multiplier" HeaderStyle-Width="80px" HeaderText="Multiplier"
                                                    SortExpression="Multiplier" UniqueName="Multiplier" DataFormatString="{0:N2}" ReadOnly="true" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Size="Small" ItemStyle-Font-Bold="true">
                                                </telerik:GridNumericColumn>
                                                <telerik:GridButtonColumn ConfirmText="Delete this record?" ConfirmDialogType="RadWindow"
                                                    ConfirmTitle="Delete" HeaderText="" HeaderStyle-Width="30px"
                                                    CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">
                                                </telerik:GridButtonColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <h3>Multiplier Chart</h3>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" DataSourceID="SqlDataSourceMultiplier" Width="100%">
                                        <ChartTitle>
                                            <Appearance Visible="false"></Appearance>
                                        </ChartTitle>
                                        <PlotArea>

                                            <Series>
                                                <telerik:AreaSeries DataFieldY="TotalAndProfit" Name="Estimated Income" AxisName="LeftAxis">
                                                    <Appearance FillStyle-BackgroundColor="Red"></Appearance>
                                                    <LabelsAppearance Visible="false"></LabelsAppearance>
                                                    <TooltipsAppearance DataFormatString="{0:N0}" Color="White"></TooltipsAppearance>
                                                </telerik:AreaSeries>

                                                <telerik:AreaSeries DataFieldY="ActualIncome" Name="Actual Income" AxisName="LeftAxis">
                                                    <Appearance FillStyle-BackgroundColor="LightGreen"></Appearance>
                                                    <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                                    <TooltipsAppearance DataFormatString="{0:N0}" Color="White"></TooltipsAppearance>
                                                </telerik:AreaSeries>
                                                <telerik:LineSeries DataFieldY="Multiplier" Name="Multiplier" AxisName="RightAxis">
                                                    <LabelsAppearance Visible="false" DataFormatString="{0:C2}">
                                                    </LabelsAppearance>
                                                    <Appearance>
                                                        <FillStyle BackgroundColor="Blue" />
                                                    </Appearance>
                                                    <LineAppearance LineStyle="Smooth" Width="3" />
                                                    <TooltipsAppearance DataFormatString="{0:N2}" Color="White"></TooltipsAppearance>
                                                    <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                                </telerik:LineSeries>
                                            </Series>

                                            <XAxis Name="LeftAxis" DataLabelsField="Year" Reversed="true">
                                                <TitleAppearance Text="Year"></TitleAppearance>
                                                <MinorGridLines Visible="false"></MinorGridLines>
                                                <AxisCrossingPoints>
                                                    <telerik:AxisCrossingPoint Value="0" />
                                                    <telerik:AxisCrossingPoint Value="9999" />
                                                </AxisCrossingPoints>
                                            </XAxis>
                                            <YAxis Name="LeftAxis" MajorTickSize="4" MajorTickType="Outside" Width="3">
                                                <TitleAppearance Text="$"></TitleAppearance>
                                                <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                                <MinorGridLines Visible="false"></MinorGridLines>
                                            </YAxis>
                                            <AdditionalYAxes>
                                                <telerik:AxisY Name="RightAxis" Color="Blue" Width="3">
                                                    <TitleAppearance Text="Multiplier"></TitleAppearance>
                                                </telerik:AxisY>
                                            </AdditionalYAxes>



                                        </PlotArea>
                                        <Legend>
                                            <Appearance Visible="True" Position="Right"></Appearance>
                                        </Legend>
                                    </telerik:RadHtmlChart>
                                </td>
                            </tr>
                        </table>

                    </div>
                </telerik:RadWizardStep>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep2" Title="Employee Hourly Wage" StepType="Step">

                    <table class="table-sm" style="width: 100%">
                        <tr>
                            <td>
                                <h3>Employee Hourly Wage</h3>
                            </td>
                            <td>
                                <asp:LinkButton ID="btnInitialize" runat="server" ToolTip="Selected year for Initialize Hourly Wage for all Active Employees"
                                    CssClass="btn btn-danger" UseSubmitBehavior="false">
                                     Initialize All Employee
                                </asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
                                    <script type="text/javascript">
                                        function OnClientClose(sender, args) {
                                            var masterTable = $find("<%= RadGridHourlyWage.ClientID %>").get_masterTableView();
                                            masterTable.rebind();
                                        }
                                    </script>
                                    <telerik:RadGrid ID="RadGridHourlyWage" runat="server" DataSourceID="SqlDataSourceHourlyWageGroup"
                                        AutoGenerateColumns="False" AllowSorting="True" ShowFooter="true" FooterStyle-HorizontalAlign="Center">
                                        <MasterTableView DataKeyNames="employeeId" DataSourceID="SqlDataSourceHourlyWageGroup" ShowFooter="true">
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="Photo" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px">
                                                    <ItemTemplate>
                                                        <asp:Image ID="ImageEmployeePhoto" ImageUrl='<%#LocalAPI.GetEmployeePhotoURL(employeeId:=Eval("employeeId"))%>' CssClass="photo50"
                                                            runat="server" AlternateText=""></asp:Image>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn DataField="employeeId" FilterControlAltText="Filter Employee column"
                                                    HeaderText="Employee" SortExpression="Employee" UniqueName="employeeId" HeaderStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                                                    <ItemTemplate>

                                                        <asp:LinkButton ID="btnEdit"
                                                            runat="server" ToolTip="Click to View/Edit Employee Hourly Wage"
                                                            CommandArgument='<%# Eval("employeeId") %>'
                                                            CommandName="EditHourlyWage"
                                                            Text='<%# Eval("Employee")%>' UseSubmitBehavior="false"
                                                            ForeColor='<%#IIf(Eval("Inactive"), System.Drawing.Color.LightGray, System.Drawing.Color.DarkBlue) %>'>
                                                                <span style="font-size:x-small" class="badge badge-pill badge-danger" title="weeks this year"><%# Eval("weekthisyear", "{0:N1}") %></span>
                                                        </asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="Department" FilterControlAltText="Filter Department column" HeaderText="Department" HeaderStyle-HorizontalAlign="Center"
                                                    SortExpression="Department" UniqueName="Department" ReadOnly="true">
                                                    <ItemTemplate>
                                                        <small><%# Eval("Department") %></small>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridNumericColumn DataField="Producer" FilterControlAltText="Filter Producer column" HeaderText="P.Rate" HeaderStyle-HorizontalAlign="Center"
                                                    SortExpression="Producer" UniqueName="Producer" DataFormatString="{0:N2}" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" Aggregate="Avg" FooterAggregateFormatString="{0:N2}" ReadOnly="true"
                                                    HeaderTooltip="Producer Rate 0 to 1">
                                                </telerik:GridNumericColumn>
                                                <telerik:GridTemplateColumn DataField="Amount" FilterControlAltText="Filter Amount column" HeaderText="$/Hour" HeaderStyle-HorizontalAlign="Center"
                                                    SortExpression="Amount" UniqueName="Amount" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right"
                                                    HeaderTooltip="Hourly Wage Rate">
                                                    <ItemTemplate>
                                                        <%# Eval("Amount", "{0:C2}") %>
                                                        <span style="font-size: x-small" class="badge badge-pill badge-danger" title="# Increase"><%# Eval("NumberOfRecords") %></span>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridNumericColumn DataField="AnnualSalary" FilterControlAltText="Filter AnnualSalary column" HeaderText="Annual" HeaderStyle-HorizontalAlign="Center"
                                                    SortExpression="AnnualSalary" UniqueName="AnnualSalary" DataFormatString="{0:N0}" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" ReadOnly="true"
                                                    HeaderTooltip="Annual Salary Calculated">
                                                </telerik:GridNumericColumn>
                                                <telerik:GridTemplateColumn DataField="ProductiveSalary" FilterControlAltText="Filter ProductiveSalary column" HeaderText="Productive" HeaderStyle-HorizontalAlign="Center"
                                                    SortExpression="ProductiveSalary" UniqueName="ProductiveSalary" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" ReadOnly="true"
                                                    HeaderTooltip="Annual Salary - (Non-productive hours)*$/Hour">
                                                    <ItemTemplate>
                                                        <%# Eval("ProductiveSalary", "{0:N0}") %>
                                                        <span style="font-size: x-small" class="badge badge-pill badge-danger" title="productive weeks this year"><%# Eval("productiveweekthisyear", "{0:N1}") %></span>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </telerik:RadCodeBlock>
                            </td>
                        </tr>
                    </table>

                </telerik:RadWizardStep>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep3" Title="Monthly Salary Calculation" StepType="Step">
                    <div>
                        <table class="table-sm" style="width: 100%">
                            <tr>
                                <td>
                                    <h3>Monthly Salary Calculation</h3>
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cboMonthSalary" runat="server" MarkFirstMatch="True" AutoPostBack="true"
                                        Width="250px" Filter="Contains" AppendDataBoundItems="true">
                                        <Items>
                                            <telerik:RadComboBoxItem Text="January" Value="1" />
                                            <telerik:RadComboBoxItem Text="February" Value="2" />
                                            <telerik:RadComboBoxItem Text="March" Value="3" />
                                            <telerik:RadComboBoxItem Text="April" Value="4" />
                                            <telerik:RadComboBoxItem Text="May" Value="5" />
                                            <telerik:RadComboBoxItem Text="June" Value="6" />
                                            <telerik:RadComboBoxItem Text="July" Value="7" />
                                            <telerik:RadComboBoxItem Text="August" Value="8" />
                                            <telerik:RadComboBoxItem Text="September" Value="9" />
                                            <telerik:RadComboBoxItem Text="October" Value="10" />
                                            <telerik:RadComboBoxItem Text="November" Value="11" />
                                            <telerik:RadComboBoxItem Text="December" Value="12" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                        </table>
                        <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
                            <script type="text/javascript">
                                function OnClientClose1(sender, args) {
                                    var masterTable = $find("<%= RadGridMonthlySalaryCalculation.ClientID %>").get_masterTableView();
                                    masterTable.rebind();
                                }
                            </script>
                        </telerik:RadCodeBlock>
                        <telerik:RadGrid ID="RadGridMonthlySalaryCalculation" runat="server" DataSourceID="SqlDataSourceMonthlySalaryCalculation"
                            AutoGenerateColumns="False" AllowSorting="True" ShowFooter="true"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" FooterStyle-Font-Size="X-Small" HeaderStyle-Font-Size="X-Small" FooterStyle-HorizontalAlign="Center">
                            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceMonthlySalaryCalculation" CommandItemDisplay="Top">
                                <CommandItemSettings ShowAddNewRecordButton="false" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" HeaderText="Id" ReadOnly="True" UniqueName="Id" Display="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Department" HeaderText="Department" SortExpression="Department" UniqueName="Department">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="employeeId" FilterControlAltText="Filter Employee column"
                                        HeaderText="Employee" SortExpression="Employee" UniqueName="employeeId" HeaderStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                                        <ItemTemplate>

                                            <asp:LinkButton ID="btnEdit"
                                                runat="server" ToolTip="Click to View/Edit Employee Hourly Wage"
                                                CommandArgument='<%# Eval("employeeId") %>'
                                                CommandName="EditHourlyWage"
                                                Text='<%# Eval("Employee")%>' UseSubmitBehavior="false">
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>




                                    <telerik:GridBoundColumn DataField="Month" HeaderText="Month" SortExpression="Month" UniqueName="Month"
                                        ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" HeaderStyle-Width="70px">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="StarDate" HeaderText="Star Date" SortExpression="StarDate" UniqueName="StarDate"
                                        DataFormatString="{0:d}" HeaderStyle-Width="70px">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EndDate" HeaderText="End Date" SortExpression="EndDate" UniqueName="EndDate"
                                        DataFormatString="{0:d}" HeaderStyle-Width="70px">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ProductiveDays" HeaderText="Prod.Days" SortExpression="ProductiveDays" UniqueName="ProductiveDays"
                                        ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="70px">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NonProductiveDays" HeaderText="NonProd.Days" SortExpression="NonProductiveDays" UniqueName="NonProductiveDays"
                                        ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}" Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="70px">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Personal" HeaderText="Pers." SortExpression="Personal" UniqueName="Personal"
                                        ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}" Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="70px">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Vac" HeaderText="Vac." SortExpression="Vac" UniqueName="Vac"
                                        ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}" Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="70px">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Holliday" HeaderText="Holl." SortExpression="Holliday" UniqueName="Holliday"
                                        ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}" Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="70px">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Amount" FilterControlAltText="Filter Amount column" HeaderText="$/Hour" SortExpression="Amount" UniqueName="Amount"
                                        ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}" Aggregate="Sum" FooterAggregateFormatString="{0:C2}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="70px">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="HourPerDay" FilterControlAltText="Filter HourPerDay column" HeaderText="Hours/Day" SortExpression="HourPerDay" UniqueName="HourPerDay"
                                        ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}" Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="70px">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ProducerRate" FilterControlAltText="Filter ProducerRate column" HeaderText="P.Rate" SortExpression="ProducerRate" UniqueName="ProducerRate" HeaderTooltip="Producer Rate (0 to 1): 0:Administrative, 1:Producer "
                                        ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}" Aggregate="Avg" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="70px">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Productive" HeaderText="Productive" SortExpression="Productive" UniqueName="Productive"
                                        ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}" Aggregate="Sum" FooterAggregateFormatString="{0:C2}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="70px">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Salary" HeaderText="Salary" SortExpression="Salary" UniqueName="Salary"
                                        ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}" Aggregate="Sum" FooterAggregateFormatString="{0:C2}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="70px">
                                    </telerik:GridBoundColumn>

                                </Columns>

                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                </telerik:RadWizardStep>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep4" Title="Department Monthly Target" StepType="Step">
                    <div>
                        <h3>Department Monthly Target</h3>
                        <telerik:RadGrid ID="RadGridDptoTarget" runat="server" DataSourceID="SqlDataSourceDptoTarget" AllowMultiRowSelection="True"
                            AutoGenerateColumns="False" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" AllowSorting="True" ShowFooter="true">
                            <ClientSettings>
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceDptoTarget" CommandItemDisplay="Top">
                                <CommandItemSettings ShowAddNewRecordButton="false" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" HeaderText="Id" ReadOnly="True" UniqueName="Id" Display="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="30px" HeaderStyle-HorizontalAlign="Center">
                                    </telerik:GridClientSelectColumn>
                                    <telerik:GridTemplateColumn DataField="Department" FilterControlAltText="Filter Department column" HeaderText="Department" SortExpression="Department" UniqueName="Department"
                                        HeaderStyle-HorizontalAlign="Center" ReadOnly="true">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEdit" runat="server" CommandArgument='<%# Eval("Id") %>' CommandName="Edit" Text='<%# Eval("Department")%>' ToolTip="Click to edit" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="Jan" DataType="System.Double" FilterControlAltText="Filter Jan column" HeaderText="Jan" SortExpression="Jan" UniqueName="Jan"
                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="70px" ItemStyle-Font-Size="X-Small" FooterStyle-Font-Size="X-Small">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Feb" DataType="System.Double" FilterControlAltText="Filter Feb column" HeaderText="Feb" SortExpression="Feb" UniqueName="Feb"
                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="70px" ItemStyle-Font-Size="X-Small" FooterStyle-Font-Size="X-Small">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Mar" DataType="System.Double" FilterControlAltText="Filter Mar column" HeaderText="Mar" SortExpression="Mar" UniqueName="Mar"
                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="70px" ItemStyle-Font-Size="X-Small" FooterStyle-Font-Size="X-Small">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Apr" DataType="System.Double" FilterControlAltText="Filter Apr column" HeaderText="Apr" SortExpression="Apr" UniqueName="Apr"
                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="70px" ItemStyle-Font-Size="X-Small" FooterStyle-Font-Size="X-Small">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="May" DataType="System.Double" FilterControlAltText="Filter May column" HeaderText="May" SortExpression="May" UniqueName="May"
                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="70px" ItemStyle-Font-Size="X-Small" FooterStyle-Font-Size="X-Small">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Jun" DataType="System.Double" FilterControlAltText="Filter Jun column" HeaderText="Jun" SortExpression="Jun" UniqueName="Jun"
                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="70px" ItemStyle-Font-Size="X-Small" FooterStyle-Font-Size="X-Small">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Jul" DataType="System.Double" FilterControlAltText="Filter Jul column" HeaderText="Jul" SortExpression="Jul" UniqueName="Jul"
                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="70px" ItemStyle-Font-Size="X-Small" FooterStyle-Font-Size="X-Small">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Aug" DataType="System.Double" FilterControlAltText="Filter Aug column" HeaderText="Aug" SortExpression="Aug" UniqueName="Aug"
                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="70px" ItemStyle-Font-Size="X-Small" FooterStyle-Font-Size="X-Small">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Sep" DataType="System.Double" FilterControlAltText="Filter Sep column" HeaderText="Sep" SortExpression="Sep" UniqueName="Sep"
                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="70px" ItemStyle-Font-Size="X-Small" FooterStyle-Font-Size="X-Small">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Oct" DataType="System.Double" FilterControlAltText="Filter Oct column" HeaderText="Oct" SortExpression="Oct" UniqueName="Oct"
                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="70px" ItemStyle-Font-Size="X-Small" FooterStyle-Font-Size="X-Small">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Nov" DataType="System.Double" FilterControlAltText="Filter Nov column" HeaderText="Nov" SortExpression="Nov" UniqueName="Nov"
                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="70px" ItemStyle-Font-Size="X-Small" FooterStyle-Font-Size="X-Small">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Dec" DataType="System.Double" FilterControlAltText="Filter Dec column" HeaderText="Dec" SortExpression="Dec" UniqueName="Dec"
                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="70px" ItemStyle-Font-Size="X-Small" FooterStyle-Font-Size="X-Small">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Total" DataType="System.Double" FilterControlAltText="Filter Total column" HeaderText="Total" ReadOnly="True" SortExpression="Total" UniqueName="Total"
                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="70px" ItemStyle-Font-Size="X-Small" FooterStyle-Font-Size="X-Small">
                                    </telerik:GridBoundColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                </telerik:RadWizardStep>
            </WizardSteps>
        </telerik:RadWizard>

    </div>
    <telerik:RadToolTip ID="RadToolTipInitialize" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <table class="table-sm" style="width: 650px">
            <tr>
                <td style="text-align: center">
                    <h2 style="margin: 0; text-align: center; color: white;">
                        <span class="navbar navbar-expand-md bg-dark text-white">Hourly Wage for Selected Year
                        </span>
                    </h2>
                </td>
            </tr>
            <tr>
                <td>
                    <p>
                        Initialize the records of all active employees, based on their history of the year prior to the one selected. using the 'Increase' parameter to define their Salary($/Hour)
                    </p>
                    <p>
                        This procedure does not overwrite records of existing employees in the selected year
                    </p>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadNumericTextBox ID="txtInitializeYear" runat="server" Label="Year:"
                        MinValue="2015" MaxValue="2029">
                        <NumberFormat DecimalDigits="0" GroupSeparator="" />
                    </telerik:RadNumericTextBox>

                </td>
            </tr>
            <tr>
                <td style="text-align: right; padding-right: 10px; padding-top: 50px">
                    <asp:LinkButton ID="btnInitializeOk" runat="server" ToolTip="Initialize(insert) all Active Employees for selected year"
                        CssClass="btn btn-warning btn" UseSubmitBehavior="false">
                                     Confirm Initialize
                    </asp:LinkButton>
                </td>

            </tr>
        </table>
    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipCalculateMultiplier" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <table class="table-sm" style="width: 650px">
            <tr>
                <td style="text-align: center">
                    <h2 style="margin: 0; text-align: center; color: white;">
                        <span class="navbar navbar-expand-md bg-dark text-white">Calculate Multiplier
                        </span>
                    </h2>
                </td>
            </tr>
            <tr>
                <td>
                    <p>
                        Update the Salary, Salary Tax and Productive Salary columns calculated from 'Employee Hourly Wage', on row of selected year. 
                        <br />
                        These changes affect the company's Multiplier column. 
                    </p>
                    <p>
                        The remaining columns (SubContracts, Rent and Others) must be edited to change their values.
                    </p>
                </td>
            </tr>
            <tr>
                <td>These changes affect Department Monthly Target. 
                    <br />
                    Select the month since this condition will occur:
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadComboBox ID="cboMonth" runat="server" MarkFirstMatch="True" ZIndex="50001"
                        Width="250px" Filter="Contains" AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem Text="January" Value="1" />
                            <telerik:RadComboBoxItem Text="February" Value="2" />
                            <telerik:RadComboBoxItem Text="March" Value="3" />
                            <telerik:RadComboBoxItem Text="April" Value="4" />
                            <telerik:RadComboBoxItem Text="May" Value="5" />
                            <telerik:RadComboBoxItem Text="June" Value="6" />
                            <telerik:RadComboBoxItem Text="July" Value="7" />
                            <telerik:RadComboBoxItem Text="August" Value="8" />
                            <telerik:RadComboBoxItem Text="September" Value="9" />
                            <telerik:RadComboBoxItem Text="October" Value="10" />
                            <telerik:RadComboBoxItem Text="November" Value="11" />
                            <telerik:RadComboBoxItem Text="December" Value="12" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadNumericTextBox ID="txtMultiplierYear" runat="server" Label="Year:"
                        MinValue="2010" MaxValue="2029">
                        <NumberFormat DecimalDigits="0" GroupSeparator="" />
                    </telerik:RadNumericTextBox>

                </td>
            </tr>
            <tr>
                <td style="text-align: right; padding-right: 10px; padding-top: 50px">
                    <asp:LinkButton ID="btnCalculateMultiplierOk" runat="server" ToolTip="Update Salary and Productive Salary"
                        CssClass="btn btn-warning btn" UseSubmitBehavior="false">
                                     Confirm Calculate
                    </asp:LinkButton>
                </td>

            </tr>
        </table>
    </telerik:RadToolTip>

    <asp:SqlDataSource ID="SqlDataSourceMultiplier" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CompanyMultiplier_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="INSERT INTO Company_MultiplierByYear([Year],[Salary],[SalaryTax],[SubContracts],[Rent],[Others],[ProductiveSalary],[Profit],[companyId]) 
                                            VALUES (@Year,@Salary,@SalaryTax,@SubContracts,@Rent,@Others,@ProductiveSalary,@Profit,@companyId)"
        DeleteCommand="DELETE FROM Company_MultiplierByYear WHERE Id=@Id"
        UpdateCommand="UPDATE Company_MultiplierByYear SET [Year] = @Year,[Salary] = @Salary, [SalaryTax]=@SalaryTax, [SubContracts] = @SubContracts,[Rent] = @Rent,[Others] = @Others,[ProductiveSalary] = @ProductiveSalary,[Profit] = @Profit WHERE Id=@Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Year" />
            <asp:Parameter Name="Salary" />
            <asp:Parameter Name="SalaryTax" />
            <asp:Parameter Name="SubContracts" />
            <asp:Parameter Name="Rent" />
            <asp:Parameter Name="Others" />
            <asp:Parameter Name="ProductiveSalary" />
            <asp:Parameter Name="Profit" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="Year" />
            <asp:Parameter Name="Salary" />
            <asp:Parameter Name="SalaryTax" />
            <asp:Parameter Name="SubContracts" />
            <asp:Parameter Name="Rent" />
            <asp:Parameter Name="Others" />
            <asp:Parameter Name="ProductiveSalary" />
            <asp:Parameter Name="Profit" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceHourlyWageGroup" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Employee_HourlyWageHistory_Group_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboDepartments" Name="departmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboEmployees" Name="employeeId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name]=[FullName]+case when isnull(Inactive,0)=1 then ' (I)' else '' end FROM [Employees] WHERE companyId=@companyId and DepartmentId=case when @DepartmentId>0 then @DepartmentId else DepartmentId end ORDER BY isnull(Inactive,0), [Name]"
        InsertCommand="PayrollInitialize_INSERT" InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboDepartments" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="txtInitializeYear" Name="Year" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceYears" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Year, nYear FROM Years ORDER BY Year DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceMonthlySalaryCalculation" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="MonthlySalaryCalculation_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboMonthSalary" Name="Month" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboDepartments" Name="departmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceDptoTarget" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Company_Department_Budget.Id, [Year], Company_Department.Name As Department, Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, [Dec], Total 
                        FROM Company_Department_Budget INNER JOIN Company_Department ON Company_Department_Budget.departmentId = Company_Department.Id 
                        WHERE Company_Department_Budget.companyId=@companyId and [Year]=@Year and isnull(Company_Department.Productive,0)=1 ORDER BY [Year], Company_Department.Name"
        InsertCommand="BudgetDepartments_INIT" InsertCommandType="StoredProcedure"
        UpdateCommand="UPDATE [Company_Department_Budget] SET [Jan]=@Jan,[Feb]=@Feb,[Mar]=@Mar,[Apr]=@Apr,[May]=@May,[Jun]=@Jun,[Jul]=@Jul,[Aug]=@Aug,[Sep]=@Sep,[Oct]=@Oct,[Nov]=@Nov,[Dec]=@Dec WHERE Id=@Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="RETURN_VALUE" Direction="ReturnValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtPercent" Name="Increase" PropertyName="Value" Type="Double" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Jan" />
            <asp:Parameter Name="Feb" />
            <asp:Parameter Name="Mar" />
            <asp:Parameter Name="Apr" />
            <asp:Parameter Name="May" />
            <asp:Parameter Name="Jun" />
            <asp:Parameter Name="Jul" />
            <asp:Parameter Name="Aug" />
            <asp:Parameter Name="Sep" />
            <asp:Parameter Name="Oct" />
            <asp:Parameter Name="Nov" />
            <asp:Parameter Name="Dec" />
            <asp:Parameter Name="Id" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceInit" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Company_Department_Budget.Id, [Year], Company_Department.Name As Department, Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, [Dec], Total 
                        FROM Company_Department_Budget INNER JOIN Company_Department ON Company_Department_Budget.departmentId = Company_Department.Id 
                        WHERE Company_Department_Budget.companyId=@companyId and [Year]=@Year and isnull(Company_Department.Productive,0)=1 ORDER BY [Year], Company_Department.Name"
        InsertCommand="BudgetDepartments_INIT" InsertCommandType="StoredProcedure"
        UpdateCommand="UPDATE [Company_Department_Budget] SET [Jan]=@Jan,[Feb]=@Feb,[Mar]=@Mar,[Apr]=@Apr,[May]=@May,[Jun]=@Jun,[Jul]=@Jul,[Aug]=@Aug,[Sep]=@Sep,[Oct]=@Oct,[Nov]=@Nov,[Dec]=@Dec WHERE Id=@Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="RETURN_VALUE" Direction="ReturnValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtPercent" Name="Increase" PropertyName="Value" Type="Double" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Jan" />
            <asp:Parameter Name="Feb" />
            <asp:Parameter Name="Mar" />
            <asp:Parameter Name="Apr" />
            <asp:Parameter Name="May" />
            <asp:Parameter Name="Jun" />
            <asp:Parameter Name="Jul" />
            <asp:Parameter Name="Aug" />
            <asp:Parameter Name="Sep" />
            <asp:Parameter Name="Oct" />
            <asp:Parameter Name="Nov" />
            <asp:Parameter Name="Dec" />
            <asp:Parameter Name="Id" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>

