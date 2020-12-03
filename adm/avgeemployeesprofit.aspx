<%@ Page Title="Employees Efficiency Graphic" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="avgeemployeesprofit.aspx.vb" Inherits="pasconcept20.avgeemployeesprofit" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Employees Efficiency Chart</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
           
            </button>
        </span>
    </div>

    <div class="collapse" id="collapseFilter">
        <table class="table-sm pasconcept-bar" style="width: 100%">
            <tr>
                <td style="width: 150px;">
                    <telerik:RadComboBox ID="cboYear" runat="server" DataSourceID="SqlDataSourceYear"
                        DataTextField="nYear" DataValueField="Year" Width="100%" AppendDataBoundItems="True">
                        <Items>
                            <telerik:RadComboBoxItem Selected="True" runat="server" Text="(All Years... )" Value="-1" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td style="width: 400px">
                    <telerik:RadComboBox ID="cboClients" runat="server" AppendDataBoundItems="True"
                        DataSourceID="SqlDataSourceClients" DataTextField="Name" DataValueField="Id"
                        Width="100%">
                        <Items>
                            <telerik:RadComboBoxItem Selected="True" runat="server" Text="(All Clients... )"
                                Value="-1" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td style="width: 350px">
                    <telerik:RadComboBox ID="cboDepartments" runat="server" DataSourceID="SqlDataSourceDepartments" DataTextField="Name" DataValueField="Id"
                        Width="100%" CheckBoxes="true" Height="300px" EnableCheckAllItemsCheckBox="true" MarkFirstMatch="True" Filter="Contains">
                        <Localization AllItemsCheckedString="All Departments Checked" CheckAllString="Check All..." ItemsCheckedString="items checked"></Localization>
                    </telerik:RadComboBox>
                </td>
                <td style="text-align: right">
                    <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </div>

    <div class="pasconcept-bar">
        <telerik:RadWizard ID="RadWizard1" runat="server" DisplayCancelButton="false" RenderMode="Lightweight" Skin="Silk" DisplayNavigationButtons="false" DisplayProgressBar="false">
            <WizardSteps>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep1" Title="Average Chart" StepType="Step">

                    <table style="width: 100%">
                        <tr>
                            <td>

                                <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" DataSourceID="SqlDataSource1" Height="630px" Width="100%">
                                    <ChartTitle Text="Average Budget Used(%) by Employee">
                                        <Appearance Align="Center" BackgroundColor="White" Position="Top"></Appearance>
                                    </ChartTitle>
                                    <PlotArea>
                                        <Series>
                                            <telerik:ColumnSeries DataFieldY="EfficiencyPercent" Name="Efficiency %" AxisName="LeftAxis">
                                                <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                                </LabelsAppearance>
                                                <Appearance>
                                                    <FillStyle BackgroundColor="YellowGreen" />
                                                </Appearance>
                                                <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                            </telerik:ColumnSeries>
                                        </Series>
                                        <Series>
                                            <telerik:LineSeries DataFieldY="Jobs_Count" Name="Number of Jobs" AxisName="RightAxis">
                                                <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                                </LabelsAppearance>
                                                <Appearance>
                                                    <FillStyle BackgroundColor="Red" />
                                                </Appearance>
                                                <LineAppearance LineStyle="Smooth" Width="2" />
                                                <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                                <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                            </telerik:LineSeries>
                                        </Series>
                                        <YAxis Name="LeftAxis" MajorTickSize="4" MajorTickType="Outside" MinorTickSize="1" Step="25" Color="MediumSeaGreen" Width="3">
                                            <TitleAppearance Text="% Budget Used"></TitleAppearance>
                                            <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                            <MinorGridLines Visible="false"></MinorGridLines>
                                        </YAxis>
                                        <AdditionalYAxes>
                                            <telerik:AxisY Name="RightAxis" Color="Red" Width="3">
                                                <TitleAppearance Text="# Jobs"></TitleAppearance>
                                            </telerik:AxisY>
                                        </AdditionalYAxes>
                                        <XAxis DataLabelsField="EmployeeName">
                                            <TitleAppearance Text="Employee"></TitleAppearance>
                                            <MinorGridLines Visible="false"></MinorGridLines>
                                            <LabelsAppearance RotationAngle="315"></LabelsAppearance>
                                            <AxisCrossingPoints>
                                                <telerik:AxisCrossingPoint Value="0" />
                                                <telerik:AxisCrossingPoint Value="9999" />
                                            </AxisCrossingPoints>
                                        </XAxis>
                                    </PlotArea>
                                    <Legend>
                                        <Appearance Visible="True" Position="Top"></Appearance>
                                    </Legend>

                                </telerik:RadHtmlChart>
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
                                        <span class="pasconcept-pagetitle">Employees Efficiency Chart</span>
                                    </div>
                                    <table class="table table-striped" style="width: 850px; font-size: medium; text-align: center;">
                                        <tr>
                                            <td style="width: 200px;">
                                                <span class="badge badge-secondary">Consistency % = </span>
                                            </td>
                                            <td>Consistency expression.
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <span class="badge badge-danger">Efficiency % = </span>
                                            </td>
                                            <td>Efficiency % expression
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <span class="badge badge-dark">Number of Jobs = </span>
                                            </td>
                                            <td>Number of Jobs in which the employee has participated in the selected Year / Client. 
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadToolTip>
                            </td>
                        </tr>
                    </table>
                </telerik:RadWizardStep>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep2" Title="Profit Chart" StepType="Step">
                    <telerik:RadHtmlChart ID="RadHtmlChart2" runat="server" DataSourceID="SqlDataSource1" Height="630px" Width="100%">
                        <ChartTitle Text="Profit Chart by Employee">
                            <Appearance Align="Center" BackgroundColor="White" Position="Top"></Appearance>
                        </ChartTitle>
                        <PlotArea>
                            <Series>
                                <telerik:ColumnSeries DataFieldY="BudgetUsed" Name="Budget Used" GroupName="EmployeeId">
                                    <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                    </LabelsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="OrangeRed" />
                                    </Appearance>
                                    <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                </telerik:ColumnSeries>
                                <telerik:ColumnSeries DataFieldY="Profit" Name="Profit" GroupName="EmployeeId">
                                    <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                    </LabelsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="YellowGreen" />
                                    </Appearance>
                                    <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                </telerik:ColumnSeries>
                            </Series>
                            <YAxis Name="LeftAxis">
                                <TitleAppearance Text="$"></TitleAppearance>
                                <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                <MinorGridLines Visible="false"></MinorGridLines>
                            </YAxis>
                            <XAxis DataLabelsField="EmployeeName">
                                <TitleAppearance Text="Employee"></TitleAppearance>
                                <MinorGridLines Visible="false"></MinorGridLines>
                                <LabelsAppearance RotationAngle="315"></LabelsAppearance>
                                <AxisCrossingPoints>
                                    <telerik:AxisCrossingPoint Value="0" />
                                    <telerik:AxisCrossingPoint Value="9999" />
                                </AxisCrossingPoints>
                            </XAxis>
                        </PlotArea>
                        <Legend>
                            <Appearance Visible="True" Position="Top"></Appearance>
                        </Legend>

                    </telerik:RadHtmlChart>
                </telerik:RadWizardStep>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep3" Title="Data Sheet" StepType="Step">
                    <table style="width: 100%">
                        <tr>
                            <td>
                                <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" PageSize="250" Height="620px" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowFooter="true"
                                    HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                    </ClientSettings>
                                    <MasterTableView DataSourceID="SqlDataSource1" DataKeyNames="EmployeeId">
                                        <PagerStyle Mode="Slider" AlwaysVisible="false" />
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderText="" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" ReadOnly="true">
                                                <ItemTemplate>
                                                    <asp:Image ID="ImageEmployeePhoto" ImageUrl='<%# LocalAPI.GetEmployeePhotoURL(employeeId:=Eval("EmployeeId"))%>' CssClass="photo50"
                                                        runat="server" AlternateText=""></asp:Image>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn DataField="EmployeeName" HeaderText="Employee" SortExpression="EmployeeName" Aggregate="Count"
                                                UniqueName="EmployeeName" HeaderStyle-HorizontalAlign="Center"
                                                FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Center" ReadOnly="true">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Jobs_Count" HeaderText="Jobs (#)"
                                                ReadOnly="True" SortExpression="Jobs_Count" UniqueName="Jobs_Count" DataFormatString="{0:N0}"
                                                ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px"
                                                Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Center">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="Uptime" HeaderText="Uptime" HeaderTooltip="Total amount of employee productive time dedicated towards the completion of a job/project"
                                                ReadOnly="True" SortExpression="Uptime" UniqueName="Uptime" DataFormatString="{0:N0}"
                                                ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px"
                                                Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Center">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Downtime" HeaderText="Downtime" HeaderTooltip="Total amount of employee miscellaneous time dedicated to tasks not related to a specific job/project"
                                                ReadOnly="True" SortExpression="Downtime" UniqueName="Downtime" DataFormatString="{0:N0}"
                                                ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px"
                                                Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Center">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="EfficiencyPercent" DataType="System.Double" HeaderText="Efficiency (%)" HeaderStyle-Width="120px"
                                                ReadOnly="True" SortExpression="EfficiencyPercent" UniqueName="EfficiencyPercent" DataFormatString="{0:N2}" HeaderTooltip="Weighted average of % Budget Used based on individual job/project budget weight with respect to Revenue per employee"
                                                ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Revenue" HeaderText="Revenue" HeaderTooltip="Gross financial income as per contract agreement, including outsourcing"
                                                ReadOnly="True" SortExpression="Revenue" UniqueName="Revenue" DataFormatString="{0:N2}" HeaderStyle-Width="120px"
                                                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                                                Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Right">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="BudgetUsed" HeaderText="Budget Used" HeaderStyle-Width="120px" HeaderTooltip="Amount utilized from available budget"
                                                ReadOnly="True" SortExpression="BudgetUsed" UniqueName="BudgetUsed" DataFormatString="{0:N2}"
                                                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                                                Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Right">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Profit" HeaderText="Profit" HeaderStyle-Width="120px" HeaderTooltip="Net financial gain; difference between amount earned (Revenue) and amount spent (Budget Used)"
                                                ReadOnly="True" SortExpression="Profit" UniqueName="Profit" DataFormatString="{0:N2}"
                                                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                                                Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Right">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn DataField="EmployeeHR" HeaderText="Employee HR" SortExpression="EmployeeHR" UniqueName="EmployeeHR" HeaderStyle-Width="120px"
                                                HeaderTooltip="Value of 'Hourly Rate' in employee profile"
                                                ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label ID="lnkEdit" runat="server" Text='<%# Eval("EmployeeHR", "{0:N2}")%>' ToolTip="Click to edit"></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn DataField="ProductionHR" HeaderText="Production HR" HeaderTooltip="The sum of the Revenue generated by an employee divided by the sum of production time (Uptime)"
                                                ReadOnly="True" SortExpression="ProductionHR" UniqueName="ProductionHR" DataFormatString="{0:N2}"
                                                ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px"
                                                Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Center">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="HourlyRate" HeaderText="Hourly Rate" HeaderTooltip="The sum of the Revenue generated by an employee divided by the sum of total time (Uptime and Downtime)"
                                                ReadOnly="True" SortExpression="HourlyRate" UniqueName="HourlyRate" DataFormatString="{0:N2}"
                                                ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px"
                                                Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Center">
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </td>
                            <td style="width: 20px; text-align: center; vertical-align: top">
                                <asp:HyperLink runat="server" ID="lblInfoGrid1" NavigateUrl="javascript:void(0);" Style="text-decoration: none;">
                                            <i class="fas fa-info"></i>
                                </asp:HyperLink>
                                <telerik:RadToolTip ID="RadToolTipGrid1" runat="server" TargetControlID="lblInfoGrid1"
                                    RenderMode="Lightweight" EnableViewState="true" ShowCallout="false" RenderInPageRoot="true"
                                    Position="Center" Modal="True" Title="" ShowEvent="OnClick"
                                    HideDelay="100" HideEvent="LeaveToolTip" IgnoreAltAttribute="true"
                                    RelativeTo="BrowserWindow" ManualClose="true">

                                    <div class="pasconcept-bar noprint">
                                        <span class="pasconcept-pagetitle">Employees Efficiency Data Sheet</span>
                                    </div>
                                    <table class="table table-striped" style="width: 850px; font-size: medium; text-align: center;">
                                        <tr>
                                            <td style="width: 200px;">
                                                <span class="badge badge-secondary">Job (#)</span>
                                            </td>
                                            <td>Number of Jobs as Team Member in the time period.
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <span class="badge badge-danger">Uptime = </span>
                                            </td>
                                            <td>Number of hours (Productive Time) entered in Jobs
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <span class="badge badge-dark">Downtime</span>
                                            </td>
                                            <td>Number of hours (Non-Productive Time) entered. 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <span class="badge badge-dark">Efficiency (%)</span>
                                            </td>
                                            <td>Percentage of Average Profit obtained in Jobs as a member of the team affected by the FTE (Time * Hourly Rate) / (Budged - SubFees)*FTE * 100)
                                            </td>
                                        </tr>
                                        
                                    </table>
                                </telerik:RadToolTip>
                            </td>
                        </tr>
                    </table>
                </telerik:RadWizardStep>
            </WizardSteps>
        </telerik:RadWizard>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="YearStadistic_v20_EMPLOYES_PROFIT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboClients" Name="Client" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="lblDepartmentIdIN_List" Name="DepartmentIdIN_List" PropertyName="Text" Type="String" ConvertEmptyStringToNull="False" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT * FROM [Years] where [Year]&gt;2000 ORDER BY [Year]DESC "></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClients" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Client] As Name FROM [Clients]  WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblDepartmentIdIN_List" runat="server" Visible="False" Text=""></asp:Label>
</asp:Content>
