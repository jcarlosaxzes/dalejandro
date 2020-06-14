<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="calculator.aspx.vb" Inherits="pasconcept20.calculator" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PanelSample" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadHtmlChart1" />
                    <telerik:AjaxUpdatedControl ControlID="collapseFilterCalculate" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnCalculate">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PanelSample" />
                    <telerik:AjaxUpdatedControl ControlID="RadHtmlChart1"  />
                    <telerik:AjaxUpdatedControl ControlID="collapseFilterCalculate" LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnFind">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PanelSample" />
                    <telerik:AjaxUpdatedControl ControlID="RadHtmlChart1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                    <telerik:AjaxUpdatedControl ControlID="collapseFilterCalculate" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
    <div class="Formulario">
        <table class="table-condensed">
            <tr>
                <td>
                    <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                        <i class="fas fa-filter"></i>&nbsp;Filter
                    </button>
                </td>
                <td>
                    <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilterSample" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Sample panel">
                        <i class="fas fa-list"></i>&nbsp;Sample
                    </button>
                </td>
                <td style="text-align:right">
                    <div id="collapseFilterCalculate" runat="server" visible="false">
                        <table>
                            <tr>
                                <td style="text-align: center">
                                    <telerik:RadNumericTextBox ID="txtEstimatedUnit" runat="server" Width="180px" EmptyMessage="Estimated Unit?" ToolTip="Estimated Unit">
                                        <NumberFormat DecimalDigits="0" />
                                    </telerik:RadNumericTextBox>
                                </td>
                                <td style="text-align: center">
                                    <telerik:RadComboBox ID="cboEstimatedType" runat="server" Width="100%" AppendDataBoundItems="True" ToolTip="Rate" Label="Rate:" LabelCssClass="small">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="All MAX" Value="0" Selected="true" />
                                            <telerik:RadComboBoxItem runat="server" Text="All AVG" Value="1" />
                                            <telerik:RadComboBoxItem runat="server" Text="All MIN" Value="2" />
                                            <telerik:RadComboBoxItem runat="server" Text="Range MAX" Value="3" />
                                            <telerik:RadComboBoxItem runat="server" Text="Range AVG" Value="4" />
                                            <telerik:RadComboBoxItem runat="server" Text="Range MIN" Value="5" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                                <td style="text-align: center">
                                    <asp:LinkButton ID="btnCalculate" runat="server" CssClass="btn btn-primary" ValidationGroup="Calculate" Width="100%">
                                        Calculate
                                    </asp:LinkButton>
                                </td>
                                <td style="text-align: center">
                                    <telerik:RadNumericTextBox ID="txtCostRate" runat="server" Width="200px" Enabled="false" ForeColor="DarkGray" Font-Size="X-Small" Label="Cost Rate Used:" LabelCssClass="small">
                                        <NumberFormat DecimalDigits="2" />
                                    </telerik:RadNumericTextBox>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="lblEstimatedCost" runat="server" Font-Bold="true" ForeColor="Red" ToolTip="Estimated Cost"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <telerik:RadNumericTextBox ID="txtTimeRate" runat="server" Width="200px" Enabled="false" ForeColor="DarkGray" Font-Size="X-Small" Label="Time Rate Used:" LabelCssClass="small">
                                        <NumberFormat DecimalDigits="2" />
                                    </telerik:RadNumericTextBox>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="lblEstimatedTime" runat="server" Font-Bold="true" ForeColor="Blue" ToolTip="Estimated Time(days)"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </div>

    <div class="collapse noprint" id="collapseFilter">
        <div class="card card-body">
            <asp:Panel ID="pnlFind" runat="server">
                <table class=" table-condensed Formulario" style="width: 100%">
                    <tr>
                        <td style="width: 130px">
                            <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" Width="100%" Culture="en-US" ToolTip="Date From for filter">
                            </telerik:RadDatePicker>
                        </td>
                        <td colspan="2">
                            <telerik:RadComboBox ID="cboClients" runat="server" DataSourceID="SqlDataSourceClient"
                                Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Height="300px"
                                AppendDataBoundItems="true">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(All Clients...)" Value="-1" Selected="true" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                        <td colspan="2">
                            <telerik:RadComboBox ID="cboDepartments" runat="server" DataSourceID="SqlDataSourceDepartments" DataTextField="Name" DataValueField="Id"
                                Width="100%" CheckBoxes="true" Height="300px" EnableCheckAllItemsCheckBox="true" MarkFirstMatch="True" Filter="Contains" EmptyMessage="(Select Department...)">
                                <Localization AllItemsCheckedString="All Items Checked" CheckAllString="Check All..." ItemsCheckedString="items checked"></Localization>
                            </telerik:RadComboBox>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" Width="100%" Culture="en-US" ToolTip="Date To for filter">
                            </telerik:RadDatePicker>

                        </td>
                        <td style="width: 150px">
                            <telerik:RadComboBox ID="cboMeasure" runat="server"
                                DataSourceID="SqlDataSourceMeasure" DataTextField="Name" DataValueField="Id" Width="100%" AppendDataBoundItems="True">
                            </telerik:RadComboBox>

                        </td>
                        <td style="width: 300px">
                            <telerik:RadComboBox ID="cboJobType" runat="server" DataSourceID="SqlDataSourceType" DataTextField="Name"
                                DataValueField="Id" Width="100%" AppendDataBoundItems="True" MarkFirstMatch="True" Filter="Contains" Height="300px">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(Select Job Type...)" Value="0" />
                                </Items>
                            </telerik:RadComboBox>

                        </td>
                        <td style="width: 175px">
                            <telerik:RadNumericTextBox ID="txtUnitFrom" runat="server" Width="100%" ToolTip="Unit From" MinValue="1">
                                <NumberFormat DecimalDigits="0" />
                            </telerik:RadNumericTextBox>

                        </td>
                        <td style="width: 175px">
                            <telerik:RadNumericTextBox ID="txtUnitTo" runat="server" Width="100%" ToolTip="Unit To" MinValue="2">
                                <NumberFormat DecimalDigits="0" />
                            </telerik:RadNumericTextBox>

                        </td>
                        <td style="text-align: right">
                            <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-success btn">
                                            <i class="fas fa-search"></i> Search
                            </asp:LinkButton>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
    </div>

    <asp:Panel ID="PanelSample" runat="server" class="card card-body" Visible="false">

        <div class="collapse noprint" id="collapseFilterSample">
            <table class="table-bordered table-hover" style="width: 100%">
                <tr>
                    <th style="width: 250px; color: black">Sample
                    </th>
                    <th style="text-align: center; color: black">Unit From
                    </th>
                    <th style="text-align: center; color: black">Unit To
                    </th>
                    <th style="text-align: center; color: black">MIN Cost/Time
                    </th>
                    <th style="text-align: center; color: black">AVG Cost/Time
                    </th>
                    <th style="text-align: center; color: black">Max Cost/Time
                    </th>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label00" runat="server" Text="All Records"></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label01" runat="server"></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label02" runat="server"></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label03" runat="server"></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label04" runat="server"></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label05" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label10" runat="server" Text=""></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label11" runat="server"></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label12" runat="server"></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label13" runat="server"></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label14" runat="server"></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label15" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label20" runat="server" Text="">
                        </asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label21" runat="server"></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label22" runat="server"></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label23" runat="server"></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label24" runat="server"></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label25" runat="server"></asp:Label>
                    </td>

                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label30" runat="server" Text=""></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label31" runat="server"></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label32" runat="server"></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label33" runat="server"></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label34" runat="server"></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label35" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label40" runat="server" Text=""></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label41" runat="server"></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label42" runat="server"></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label43" runat="server"></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label44" runat="server"></asp:Label>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="Label45" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>

    </asp:Panel>


    <div>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEstimatedUnit" ValidationGroup="Calculate"
            Text="(*) Define Estimated Unit!" ErrorMessage="Define Estimated Unit!" SetFocusOnError="true"></asp:RequiredFieldValidator>
    </div>
    <table class="table-condensed" style="width: 100%">
        <tr>
            <td>
                <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" DataSourceID="SqlDataSource1" Height="300px" Width="100%">

                    <PlotArea>
                        <Series>
                            <telerik:LineSeries DataFieldY="CosteByUnit" Name="Coste by Unit">
                                <LabelsAppearance Visible="false" DataFormatString="{0:C2}">
                                </LabelsAppearance>
                                <Appearance>
                                    <FillStyle BackgroundColor="Red" />
                                </Appearance>
                                <LineAppearance LineStyle="Smooth" Width="3" />
                                <TooltipsAppearance DataFormatString="{0:N2}" Color="White"></TooltipsAppearance>
                                <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                            </telerik:LineSeries>
                            <telerik:LineSeries DataFieldY="BudgetByUnit" Name="Budget By Unit">
                                <LabelsAppearance Visible="false" DataFormatString="{0:C2}">
                                </LabelsAppearance>
                                <Appearance>
                                    <FillStyle BackgroundColor="Green" />
                                </Appearance>
                                <LineAppearance LineStyle="Smooth" Width="3" />
                                <TooltipsAppearance DataFormatString="{0:N2}" Color="White"></TooltipsAppearance>
                                <MarkersAppearance MarkersType="Square" BackgroundColor="White"></MarkersAppearance>
                            </telerik:LineSeries>
                            <telerik:LineSeries DataFieldY="AdjustedByUnit" Name="Adjusted By Unit">
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
                        <YAxis Name="LeftAxis" MajorTickSize="4" MajorTickType="Outside" Width="3">
                            <TitleAppearance Text="Ratio"></TitleAppearance>
                            <LabelsAppearance DataFormatString="{0:N2}" >
                                <TextStyle FontSize="8" />
                            </LabelsAppearance>
                            <MinorGridLines Visible="false"></MinorGridLines>
                        </YAxis>
                        <XAxis DataLabelsField="Unit">
                            <TitleAppearance Text="Unit"></TitleAppearance>
                            <LabelsAppearance RotationAngle="45" DataFormatString="{0:N0}" >
                                <TextStyle FontSize="8" />
                            </LabelsAppearance>
                            <MinorGridLines Visible="false"></MinorGridLines>
                        </XAxis>
                    </PlotArea>
                    <Legend>
                        <Appearance Visible="True" Position="Top"></Appearance>
                    </Legend>
                </telerik:RadHtmlChart>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None" HeaderStyle-Font-Size="X-Small" ItemStyle-Font-Size="X-Small"
                    AlternatingItemStyle-Font-Size="X-Small"
                    AutoGenerateColumns="False" AllowPaging="True" PageSize="25" AllowSorting="True" CellSpacing="0">
                    <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1">
                        <PagerStyle Mode="Slider" AlwaysVisible="false" />
                        <Columns>
                            <telerik:GridBoundColumn DataField="Open_date" DataFormatString="{0:MM/dd/yy}" DataType="System.DateTime"
                                HeaderText="Date" SortExpression="Open_date" UniqueName="Open_date"
                                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" AllowFiltering="False" HeaderStyle-Width="80px">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="Job" HeaderText="Job - Client" SortExpression="Job" UniqueName="Job"
                                ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <b><%# Eval("Job")%></b> -- <%# Eval("Client")%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="JobType" HeaderText="JobType" SortExpression="JobType" UniqueName="JobType"
                                ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="160px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Unit" HeaderText="Unit" SortExpression="Unit" UniqueName="Unit"
                                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Hours" HeaderText="Hours" SortExpression="Hours" UniqueName="Hours" DataFormatString="{0:N1}"
                                ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="Cost" HeaderText="Cost" SortExpression="Cost" UniqueName="Cost"
                                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" HeaderTooltip="[Cost]= SUM(Time)*EmployeeHR">
                                <ItemTemplate>
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="width: 24px">
                                                <asp:LinkButton ID="btnExclude" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Exclude record"
                                                    CommandName="Exclude" UseSubmitBehavior="false">
                                                    <i class="fas fa-list"></i>
                                                </asp:LinkButton>
                                            </td>
                                            <td style="text-align: right">
                                                <%# Eval("Cost", "{0:N2}") %>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="AdjustedToDate" HeaderText="Adjusted" SortExpression="AdjustedToDate" UniqueName="AdjustedToDate" DataFormatString="{0:N2}"
                                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" ItemStyle-ForeColor="Red" HeaderTooltip="[Adjusted To Date]= SUM(Time)*PositionHR">
                            </telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="CosteByUnit" HeaderText="C/Unit" SortExpression="CosteByUnit" UniqueName="CosteByUnit" DataFormatString="{0:N2}"
                                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="70px" HeaderTooltip="CosteByUnit=[Cost]/[Unit]">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="AdjustedByUnit" HeaderText="A/Unit" SortExpression="AdjustedByUnit" UniqueName="AdjustedByUnit" DataFormatString="{0:N2}"
                                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="70px" HeaderTooltip="AdjustedByUnit=[AdjustedToDate]/[Unit]" ItemStyle-ForeColor="Red">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="HourByUnit" HeaderText="H/Unit" SortExpression="HourByUnit" UniqueName="HourByUnit" DataFormatString="{0:N2}"
                                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="70px" HeaderTooltip="HourByUnit=[Hours]/[Unit]">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="BudgetByUnit" HeaderText="B/Unit" SortExpression="BudgetByUnit" UniqueName="BudgetByUnit" DataFormatString="{0:N2}"
                                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="70px" HeaderTooltip="BudgetByUnit=[Budget]/[Unit]">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOBS_Ratios_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="DateFrom" PropertyName="SelectedDate" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="DateTo" PropertyName="SelectedDate" />
            <asp:ControlParameter ControlID="cboMeasure" Name="measureId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtUnitFrom" Name="UnitFrom" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtUnitTo" Name="UnitTo" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblDepartmentIdIN_List" Name="DepartmentIdIN_List" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboJobType" Name="jobType" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="lblExcludeJobsList" Name="ExcludeJobsList" PropertyName="Text" ConvertEmptyStringToNull="False" />
            <asp:ControlParameter ControlID="cboClients" Name="clientId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <%-- <asp:Parameter Direction="InputOutput" Name="MIN_OUT" Type="Double" />
            <asp:Parameter Direction="InputOutput" Name="AVG_OUT" Type="Double" />
            <asp:Parameter Direction="InputOutput" Name="MAX_OUT" Type="Double" />--%>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Client] As Name FROM [Clients]  WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceMeasure" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Jobs_measures ORDER BY Id"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceType" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Jobs_types WHERE companyId=@companyId ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Text="0" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblDepartmentIdIN_List" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblExcludeJobsList" runat="server" Visible="False" Text=""></asp:Label>
    <asp:Label ID="lblRowCount" runat="server" Visible="False" Text="0"></asp:Label>
</asp:Content>


