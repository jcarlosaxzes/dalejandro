<%@ Page Title="Company Monthly Expenses" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="monthlyexpenses.aspx.vb" Inherits="pasconcept20.monthlyexpenses" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGridMonthly">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridMonthly" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadHtmlChartMonthly" />
                    <telerik:AjaxUpdatedControl ControlID="RadHtmlChartYearly" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cboYear">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridMonthly" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadHtmlChartMonthly" />
                    <telerik:AjaxUpdatedControl ControlID="RadHtmlChartYearly" />
                    <telerik:AjaxUpdatedControl ControlID="FloatedTilesListView" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />--%>
    <style>
        .RadListView .rlvFloated {
            display: block;
        }

        .RadListView .rlvAutoScroll .rlvI, .RadListView .rlvAutoScroll .rlvA, .RadListView .rlvAutoScroll .rlvISel, .RadListView .rlvAutoScroll .rlvIEmpty, .RadListView .rlvAutoScroll .rlvIEdit {
            overflow: auto;
        }

        .RadListView .rlvFloated .rlvI, .RadListView .rlvFloated .rlvA, .RadListView .rlvFloated .rlvISel, .RadListView .rlvFloated .rlvIEmpty, .RadListView .rlvFloated .rlvIEdit {
            float: left;
            display: inline;
            border: 1px solid;
        }

        .RadListView div.rlvI, .RadListView div.rlvA, .RadListView div.rlvISel, .RadListView div.rlvIEmpty, .RadListView div.rlvIEdit {
            border-bottom: 1px solid;
            padding-top: 5px;
            padding-bottom: 4px;
        }

        .productItemWrapper {
            height: 220px;
            width: 310px;
            margin: 5px;
            padding-left: 15px;
        }
    </style>
    <table class="table-condensed Formulario" style="width: 100%">
        <tr>
            <td style="width: 200px">
                <telerik:RadComboBox ID="cboYear" runat="server" DataSourceID="SqlDataSourceYear" Label="  Year:"
                    DataTextField="nYear" DataValueField="Year" Width="100%" AppendDataBoundItems="True" AutoPostBack="true">
                    <Items>
                        <telerik:RadComboBoxItem Selected="True" runat="server" Text="(All Years... )"
                            Value="-1" />
                    </Items>
                </telerik:RadComboBox>

            </td>
            <td style="text-align: center">
                <h3 style="margin: 0">Expenses
                </h3>
            </td>

        </tr>
    </table>

    <telerik:RadWizard ID="RadWizard1" runat="server" Width="100%" Height="730px" DisplayProgressBar="false" DisplayCancelButton="false" DisplayNavigationButtons="false" Skin="Silk">
        <WizardSteps>
            <telerik:RadWizardStep Title="Monthly Expenses">
                <div class="form-group">
                    <asp:LinkButton ID="btnMonthlyNew" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" CausesValidation="false">
                                <span class="glyphicon glyphicon-plus"></span> Expense
                    </asp:LinkButton>
                </div>

                <div class="row">
                    <div class="col-md-5">
                        <telerik:RadGrid ID="RadGridMonthly" runat="server" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                            AllowAutomaticInserts="true" ShowFooter="true" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small"
                            AutoGenerateColumns="False" DataSourceID="SqlDataSourceMonthly" AllowPaging="true" PageSize="12"
                            HeaderStyle-HorizontalAlign="Center">
                            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceMonthly">
                                <Columns>
                                    <telerik:GridEditCommandColumn ButtonType="ImageButton" HeaderText="Edit" HeaderStyle-Width="50px" UniqueName="EditCommandColumn">
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridNumericColumn DataField="Year" HeaderText="Year" SortExpression="Year" UniqueName="Year" DecimalDigits="0" MinValue="2000" MaxValue="2099" ItemStyle-HorizontalAlign="Center">
                                    </telerik:GridNumericColumn>
                                    <telerik:GridNumericColumn DataField="Month" HeaderText="Month" SortExpression="Month" UniqueName="Month" DecimalDigits="0" MinValue="1" MaxValue="12" ItemStyle-HorizontalAlign="Center">
                                    </telerik:GridNumericColumn>
                                    <telerik:GridNumericColumn DataField="Amount" HeaderText="Amount" SortExpression="Amount" UniqueName="Amount" DecimalDigits="2" MinValue="0" DataFormatString="{0:C2}" ItemStyle-HorizontalAlign="Right"
                                        Aggregate="Sum" FooterAggregateFormatString="{0:C2}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                                    </telerik:GridNumericColumn>
                                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this record?" ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                        UniqueName="DeleteColumn" HeaderText="" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                                    </telerik:GridButtonColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                    <div class="col-md-7">
                        <telerik:RadHtmlChart ID="RadHtmlChartMonthly" runat="server" DataSourceID="SqlDataSourceChartByMonth" Height="450px" Width="95%">
                            <PlotArea>
                                <Series>
                                    <telerik:AreaSeries DataFieldY="Amount" Name="Expenses by Month">
                                        <Appearance FillStyle-BackgroundColor="Red"></Appearance>
                                        <LabelsAppearance Visible="false"></LabelsAppearance>
                                        <TooltipsAppearance DataFormatString="{0:N0}" Color="White"></TooltipsAppearance>
                                    </telerik:AreaSeries>
                                </Series>
                                <YAxis Name="LeftAxis" MajorTickSize="4" MajorTickType="Outside" Width="3">
                                    <TitleAppearance Text="$"></TitleAppearance>
                                    <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                    <MinorGridLines Visible="false"></MinorGridLines>
                                </YAxis>
                                <XAxis DataLabelsField="Month">
                                    <TitleAppearance Text="Month"></TitleAppearance>
                                    <MinorGridLines Visible="false"></MinorGridLines>
                                    <AxisCrossingPoints>
                                        <telerik:AxisCrossingPoint Value="0" />
                                        <telerik:AxisCrossingPoint Value="9999" />
                                    </AxisCrossingPoints>
                                </XAxis>
                            </PlotArea>
                            <Legend>
                                <Appearance Visible="false"></Appearance>
                            </Legend>
                        </telerik:RadHtmlChart>

                        <telerik:RadHtmlChart ID="RadHtmlChartYearly" runat="server" DataSourceID="SqlDataSourceChartByYear" Height="400px" Width="95%" Visible="false">
                            <PlotArea>
                                <Series>
                                    <telerik:ColumnSeries DataFieldY="Amount" Name="Billing">
                                        <LabelsAppearance Visible="false" DataFormatString="{0:C0}">
                                        </LabelsAppearance>
                                        <TooltipsAppearance DataFormatString="{0:C0}"></TooltipsAppearance>
                                        <Appearance>
                                            <FillStyle BackgroundColor="Red" />
                                        </Appearance>
                                    </telerik:ColumnSeries>
                                </Series>
                                <XAxis DataLabelsField="Year">
                                    <TitleAppearance Text="Year"></TitleAppearance>
                                    <MinorGridLines Visible="false"></MinorGridLines>
                                </XAxis>
                                <YAxis MajorTickSize="4" MajorTickType="Outside" MinorTickSize="1">
                                    <LabelsAppearance DataFormatString="{0:C0}"></LabelsAppearance>
                                    <MinorGridLines Visible="false"></MinorGridLines>
                                </YAxis>
                            </PlotArea>
                            <Legend>
                                <Appearance Visible="false"></Appearance>
                            </Legend>
                        </telerik:RadHtmlChart>
                    </div>
                </div>


            </telerik:RadWizardStep>

            <telerik:RadWizardStep Title="Expenses (Other) by Category">
                <telerik:RadListView runat="server" ID="FloatedTilesListView" RenderMode="Lightweight" AllowPaging="True"
                    DataKeyNames="Category" DataSourceID="SqlDataSource1">
                    <AlternatingItemTemplate>

                        <div class="rlvA productItemWrapper">
                            <h4 style="margin: 0; text-align: center">
                                <asp:Label ID="lblAlternatingCategory" runat="server" Font-Bold="true" Text='<%# Eval("Category") %>'></asp:Label>
                            </h4>

                            <h5 style="margin: 0; text-align: right; padding-right: 5px; font-weight: bold"><%# Eval("Tot","{0:C2}")%></h4>
                            <telerik:RadHtmlChart ID="RainfallChart" runat="server" Width="100%" Height="160px" DataSourceID="SqlDataSourceItemAlternating">
                                <Legend>
                                    <Appearance Visible="false">
                                    </Appearance>
                                </Legend>
                                <PlotArea>
                                    <CommonTooltipsAppearance Color="White" />
                                    <Series>
                                        <telerik:ColumnSeries DataFieldY="Amount" Name="Amount">
                                            <Appearance FillStyle-BackgroundColor="DodgerBlue"></Appearance>
                                            <LabelsAppearance Visible="false"></LabelsAppearance>
                                            <TooltipsAppearance DataFormatString="{0:C2}"></TooltipsAppearance>
                                        </telerik:ColumnSeries>
                                    </Series>
                                    <XAxis DataLabelsField="MonthCode">
                                        <MajorGridLines Visible="false" />
                                        <MinorGridLines Visible="false" />
                                    </XAxis>
                                    <YAxis>
                                        <MajorGridLines Visible="true" />
                                        <MajorGridLines Color="#EFEFEF" Width="1"></MajorGridLines>
                                        <MinorGridLines Visible="false" />
                                    </YAxis>
                                </PlotArea>
                            </telerik:RadHtmlChart>

                                <asp:SqlDataSource ID="SqlDataSourceItemAlternating" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
                                    SelectCommand="YearStadistic_ExpensesItem_Chart" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
                                        <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
                                        <asp:ControlParameter ControlID="lblAlternatingCategory" Name="category" PropertyName="Text" />

                                    </SelectParameters>
                                </asp:SqlDataSource>
                        </div>
                    </AlternatingItemTemplate>
                    <ItemTemplate>
                        <div class="rlvI productItemWrapper">
                            <h4 style="margin: 0; text-align: center">
                                <asp:Label ID="lblItemCategory" runat="server" Font-Bold="true" Text='<%# Eval("Category") %>'></asp:Label>
                            </h4>
                            <h5 style="margin: 0; text-align: right; padding-right: 5px; font-weight: bold"><%# Eval("Tot","{0:C2}")%></h5>
                            <telerik:RadHtmlChart ID="SunshineChart" runat="server" Width="100%" Height="160px" DataSourceID="SqlDataSourceItem">
                                <Legend>
                                    <Appearance Visible="false">
                                    </Appearance>
                                </Legend>
                                <PlotArea>
                                    <CommonTooltipsAppearance Color="White" />
                                    <Series>
                                        <telerik:ColumnSeries DataFieldY="Amount" Name="Amount">
                                            <Appearance FillStyle-BackgroundColor="OrangeRed"></Appearance>
                                            <LabelsAppearance Visible="false"></LabelsAppearance>
                                            <TooltipsAppearance DataFormatString="{0:C2}"></TooltipsAppearance>
                                        </telerik:ColumnSeries>
                                    </Series>
                                    <XAxis DataLabelsField="MonthCode">
                                        <MajorGridLines Visible="false" />
                                        <MinorGridLines Visible="false" />
                                    </XAxis>
                                    <YAxis>
                                        <MajorGridLines Visible="true" />
                                        <MajorGridLines Color="#EFEFEF" Width="1"></MajorGridLines>
                                        <MinorGridLines Visible="false" />
                                    </YAxis>
                                </PlotArea>
                            </telerik:RadHtmlChart>

                            <asp:SqlDataSource ID="SqlDataSourceItem" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
                                SelectCommand="YearStadistic_ExpensesItem_Chart" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
                                    <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
                                    <asp:ControlParameter ControlID="lblItemCategory" Name="category" PropertyName="Text" />

                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </ItemTemplate>
                    <EmptyDataTemplate>
                        <div class="RadListView RadListView_<%# Container.Skin %>">
                            <div class="rlvEmpty">
                                There are no items to be displayed.
                            </div>
                        </div>
                    </EmptyDataTemplate>
                    <LayoutTemplate>
                        <div class="RadListView RadListViewFloated ">
                            <div class="rlvFloated rlvAutoScroll">
                                <div id="itemPlaceholder" runat="server">
                                </div>
                            </div>
                            <telerik:RadDataPager RenderMode="Lightweight" ID="RadDataPager1" runat="server" PageSize="60">
                                <Fields>
                                    <telerik:RadDataPagerButtonField FieldType="Numeric"></telerik:RadDataPagerButtonField>
                                </Fields>
                            </telerik:RadDataPager>
                        </div>
                    </LayoutTemplate>
                </telerik:RadListView>

            </telerik:RadWizardStep>
        </WizardSteps>
    </telerik:RadWizard>

    <asp:SqlDataSource ID="SqlDataSourceMonthly" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [Company_Monthly_Expenses] WHERE [Id] = @Id"
        SelectCommand="SELECT [Id],[Year],[Month],[Amount] FROM [Company_Monthly_Expenses] WHERE [companyId]=@companyId and [Year]=case when @Year>0 then @Year else [Year] end ORDER BY [Year] desc,[Month] desc"
        UpdateCommand="UPDATE [Company_Monthly_Expenses] SET [Year]=@Year, [Month]=@Month, [Amount]=@Amount WHERE [Id]=@Id"
        InsertCommand="INSERT INTO [Company_Monthly_Expenses] ([Year],[Month],[Amount],[companyId]) VALUES (@Year,@Month,@Amount,@companyId)">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Year" />
            <asp:Parameter Name="Month" />
            <asp:Parameter Name="Amount" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Year" />
            <asp:Parameter Name="Month" />
            <asp:Parameter Name="Amount" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceChartByMonth" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Month],[Amount] FROM [Company_Monthly_Expenses] WHERE [companyId]=@companyId and [Year]=@Year ORDER BY [Month]">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceChartByYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Year], sum([Amount]) as [Amount] FROM [Company_Monthly_Expenses] Where companyId=@companyId Group By [Year] Order By [Year]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="YearStadistic_Expenses_Chart" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="category" DefaultValue="" Type="String" />

        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT * FROM [Years] ORDER BY [Year] DESC "></asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>

