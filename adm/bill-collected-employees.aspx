<%@ Page Title="Bill vs Collected by Employee" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="bill-collected-employees.aspx.vb" Inherits="pasconcept20.bill_collected_employees" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadHtmlChart1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="cboMultiDepartments" />
                    <telerik:AjaxUpdatedControl ControlID="lblDepartmentIdIN_List" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="btnRefresh2">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadHtmlChart2" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="cboMultiDepartments" />
                    <telerik:AjaxUpdatedControl ControlID="lblDepartmentIdIN_List" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="cboMultiDepartments">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lblDepartmentIdIN_List" />
                    <telerik:AjaxUpdatedControl ControlID="cboMultiEmployees" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="cboEmployeeStatus">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboMultiEmployees" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cboEmployeeStatus2">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboEmployees" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cboDepartments2">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboEmployees" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />

    <telerik:RadPageLayout ID="RadPageLayout1" runat="server" GridType="Fluid">
        <Rows>

            <telerik:LayoutRow>
                <Content>
                    <table class="Formulario" style="width: 100%">
                        <tr>
                            <td style="width: 120px">
                                <telerik:RadComboBox ID="cboYear" runat="server" DataSourceID="SqlDataSourceYear"
                                    DataTextField="Year" DataValueField="Year" Width="100%" AppendDataBoundItems="true">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Selected="true" Text="(All Years...)" Value="-1" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td style="width: 300px">

                                <telerik:RadComboBox ID="cboMultiDepartments" runat="server" DataSourceID="SqlDataSourceDepartments" DataTextField="Name" DataValueField="Id" AutoPostBack="true"
                                    Width="100%" CheckBoxes="true" Height="300px" EnableCheckAllItemsCheckBox="true" MarkFirstMatch="True" Filter="Contains" EmptyMessage="(All Departments...)">
                                    <Localization AllItemsCheckedString="All Items Checked" CheckAllString="Check All..." ItemsCheckedString="items checked"></Localization>
                                </telerik:RadComboBox>

                            </td>
                            <td style="width: 200px">

                                <telerik:RadComboBox ID="cboEmployeeStatus" runat="server" Width="100%" AppendDataBoundItems="true" AutoPostBack="true">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Selected="true" Text="Active" Value="0" />
                                        <telerik:RadComboBoxItem runat="server" Selected="true" Text="Inactive" Value="1" />
                                        <telerik:RadComboBoxItem runat="server" Selected="true" Text="(All Employees...)" Value="-1" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>

                            <td style="width: 300px">
                                <telerik:RadComboBox ID="cboMultiEmployees" runat="server" DataSourceID="SqlDataSourceEmployees" DataTextField="Name" DataValueField="Id"
                                    Width="100%" CheckBoxes="true" Height="300px" EnableCheckAllItemsCheckBox="true" MarkFirstMatch="True" Filter="Contains" EmptyMessage="(All Employees...)">
                                    <Localization AllItemsCheckedString="All Items Checked" CheckAllString="Check All..." ItemsCheckedString="items checked"></Localization>
                                </telerik:RadComboBox>
                            </td>
                            <td style="text-align: right">
                                <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                    <span class="glyphicon glyphicon-search"></span> Search
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </Content>
            </telerik:LayoutRow>
            <telerik:LayoutRow>
                <Content>
                    <hr />
                </Content>
            </telerik:LayoutRow>

            <telerik:LayoutRow>
                <Content>
                    <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" DataSourceID="SqlDataSourceChart" Height="400px" Width="100%" Skin="Material">
                        <PlotArea>
                            <Series>
                                <telerik:ColumnSeries DataFieldY="Bill" Name="Billing">
                                    <LabelsAppearance Visible="false" DataFormatString="{0:C0}">
                                    </LabelsAppearance>
                                    <TooltipsAppearance DataFormatString="{0:C0}"></TooltipsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="#03a9f4" />
                                    </Appearance>
                                </telerik:ColumnSeries>

                                <telerik:ColumnSeries DataFieldY="Collected" Name="Collected">
                                    <LabelsAppearance Visible="false" DataFormatString="{0:C0}">
                                    </LabelsAppearance>
                                    <TooltipsAppearance DataFormatString="{0:C0}"></TooltipsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="#8bc34a" />
                                    </Appearance>
                                </telerik:ColumnSeries>
                                <telerik:LineSeries DataFieldY="EmployeeCost" Name="Employee Cost">
                                    <LabelsAppearance Visible="false" DataFormatString="{0:C0}">
                                    </LabelsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="Red" />
                                    </Appearance>
                                    <LineAppearance LineStyle="Smooth" Width="2" />
                                    <TooltipsAppearance DataFormatString="{0:C0}"></TooltipsAppearance>
                                    <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                </telerik:LineSeries>
                                <telerik:LineSeries DataFieldY="EmployeeBudgetUsed" Name="Employee Budget Used">
                                    <LabelsAppearance Visible="false" DataFormatString="{0:C0}">
                                    </LabelsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="Blue" />
                                    </Appearance>
                                    <LineAppearance LineStyle="Step" Width="2" />
                                    <TooltipsAppearance DataFormatString="{0:C0}"></TooltipsAppearance>
                                    <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                </telerik:LineSeries>
                            </Series>
                            <XAxis DataLabelsField="Employee">
                                <TitleAppearance Text="Employees"></TitleAppearance>
                                <MinorGridLines Visible="false"></MinorGridLines>
                                <LabelsAppearance RotationAngle="270"></LabelsAppearance>
                            </XAxis>
                            <YAxis MajorTickSize="4" MajorTickType="Outside" MinorTickSize="1">
                                <LabelsAppearance DataFormatString="{0:C0}"></LabelsAppearance>
                                <MinorGridLines Visible="false"></MinorGridLines>
                            </YAxis>
                        </PlotArea>
                        <Legend>
                            <Appearance Visible="True" Position="Top"></Appearance>
                        </Legend>
                        <ChartTitle Text="Bill vs Collected by Employee">
                            <Appearance Visible="true"></Appearance>
                        </ChartTitle>
                    </telerik:RadHtmlChart>
                </Content>
            </telerik:LayoutRow>
            <telerik:LayoutRow>
                <Content>
                    <hr />
                </Content>
            </telerik:LayoutRow>

            <telerik:LayoutRow>
                <Content>
                    <table class="Formulario" style="width: 100%">
                        <tr>
                            <td style="width: 300px">
                                <telerik:RadComboBox ID="cboDepartments2" runat="server" DataSourceID="SqlDataSourceDepartments" MarkFirstMatch="True" AutoPostBack="true"
                                    Width="100%" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(Select Department...)" Value="-1" Selected="true" />
                                    </Items>
                                </telerik:RadComboBox>

                            </td>
                            <td style="width: 200px">
                                <telerik:RadComboBox ID="cboEmployeeStatus2" runat="server" Width="100%" AppendDataBoundItems="true" AutoPostBack="true">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Selected="true" Text="Active" Value="0" />
                                        <telerik:RadComboBoxItem runat="server" Selected="true" Text="Inactive" Value="1" />
                                        <telerik:RadComboBoxItem runat="server" Selected="true" Text="(All Employees...)" Value="-1" />
                                    </Items>
                                </telerik:RadComboBox>

                            </td>
                            <td style="width: 300px">
                                <telerik:RadComboBox ID="cboEmployees" runat="server" DataSourceID="SqlDataSourceEmployees2" MarkFirstMatch="True"
                                    Width="100%" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(Select Employees...)" Value="-1" Selected="true" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                             <td style="text-align: right">
                                <asp:LinkButton ID="btnRefresh2" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                    <span class="glyphicon glyphicon-search"></span> Search
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </Content>
            </telerik:LayoutRow>

            <telerik:LayoutRow>
                <Content>
                    <telerik:RadHtmlChart ID="RadHtmlChart2" runat="server" DataSourceID="SqlDataSourceByYear" Height="400px" Width="100%" Skin="Material">
                        <PlotArea>
                            <Series>
                                <telerik:ColumnSeries DataFieldY="Bill" Name="Billing">
                                    <LabelsAppearance Visible="false" DataFormatString="{0:C0}">
                                    </LabelsAppearance>
                                    <TooltipsAppearance DataFormatString="{0:C0}"></TooltipsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="#03a9f4" />
                                    </Appearance>
                                </telerik:ColumnSeries>

                                <telerik:ColumnSeries DataFieldY="Collected" Name="Collected">
                                    <LabelsAppearance Visible="false" DataFormatString="{0:C0}">
                                    </LabelsAppearance>
                                    <TooltipsAppearance DataFormatString="{0:C0}"></TooltipsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="#8bc34a" />
                                    </Appearance>
                                </telerik:ColumnSeries>

                                <telerik:LineSeries DataFieldY="EmployeeCost" Name="Employee Cost">
                                    <LabelsAppearance Visible="false" DataFormatString="{0:C0}">
                                    </LabelsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="Red" />
                                    </Appearance>
                                    <LineAppearance LineStyle="Smooth" Width="2" />
                                    <TooltipsAppearance DataFormatString="{0:C0}"></TooltipsAppearance>
                                    <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                </telerik:LineSeries>

                                <telerik:LineSeries DataFieldY="EmployeeBudgetUsed" Name="Employee Budget Used">
                                    <LabelsAppearance Visible="false" DataFormatString="{0:C0}">
                                    </LabelsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="Blue" />
                                    </Appearance>
                                    <LineAppearance LineStyle="Step" Width="2" />
                                    <TooltipsAppearance DataFormatString="{0:C0}"></TooltipsAppearance>
                                    <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                </telerik:LineSeries>

                            </Series>
                            <XAxis DataLabelsField="Year">
                                <TitleAppearance Text="Years"></TitleAppearance>
                                <MinorGridLines Visible="false"></MinorGridLines>
                            </XAxis>
                            <YAxis MajorTickSize="4" MajorTickType="Outside" MinorTickSize="1">
                                <LabelsAppearance DataFormatString="{0:C0}"></LabelsAppearance>
                                <MinorGridLines Visible="false"></MinorGridLines>
                            </YAxis>
                        </PlotArea>
                        <Legend>
                            <Appearance Visible="true" Position="Top"></Appearance>
                        </Legend>
                        <ChartTitle Text="Bill vs Collected by Year">
                            <Appearance Visible="true"></Appearance>
                        </ChartTitle>
                    </telerik:RadHtmlChart>
                </Content>
            </telerik:LayoutRow>
        </Rows>
    </telerik:RadPageLayout>


    <asp:SqlDataSource ID="SqlDataSourceChart" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="BILL_VS_COLLECTED4_by_Department" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" Type="Int32" />
            <%--<asp:ControlParameter ControlID="lblDepartmentIdIN_List" Name="DepartmentIdIN_List" PropertyName="Text" Type="String" ConvertEmptyStringToNull="False" />--%>
            <asp:ControlParameter ControlID="lblEmployeeIdIN_List" Name="EmployeeIdIN_List" PropertyName="Text" Type="String" ConvertEmptyStringToNull="False" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name]=[FullName]+case when isnull(Inactive,0)=1 then ' (I)' else '' end FROM [Employees] WHERE companyId=@companyId and DepartmentId IN(select value from dbo.fn_Split(@DepartmentIdIN_List,',')) and isnull(Inactive,0)=case when @employeeStatus=-1 then isnull(Inactive,0) else @employeeStatus end ORDER BY isnull(Inactive,0), [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblDepartmentIdIN_List" Name="DepartmentIdIN_List" PropertyName="Text" Type="String" ConvertEmptyStringToNull="False" />
            <asp:ControlParameter ControlID="cboEmployeeStatus" Name="employeeStatus" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployees2" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name]=[FullName]+case when isnull(Inactive,0)=1 then ' (I)' else '' end FROM [Employees] WHERE companyId=@companyId and DepartmentId=case when @DepartmentId>0 then @DepartmentId else DepartmentId end and isnull(Inactive,0)=case when @employeeStatus=-1 then isnull(Inactive,0) else @employeeStatus end ORDER BY isnull(Inactive,0), [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboDepartments2" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboEmployeeStatus2" Name="employeeStatus" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="select Year(InvoiceDate) as [Year] from Invoices INNER JOIN Jobs ON Invoices.JobId = Jobs.Id where Jobs.companyId=@companyId group by Year(InvoiceDate) order by Year(InvoiceDate) desc">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceByYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="BILL_VS_COLLECTED6_byYear" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboEmployees" Name="employeeId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:Label ID="lblDepartmentIdIN_List" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeIdIN_List" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
