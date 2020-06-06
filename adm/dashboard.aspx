<%@ Page Title="Dashboard" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="dashboard.aspx.vb" Inherits="pasconcept20.dashboard" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--
    RadPageLayout uses the following 5 breakpoints:
        extra small resolutions (or xs)
        small resolutions (or sm)
        medium resolutions (or md)
        large resolutions (or lg)
        extra large resolutions (or xl) 

 The following table describes the resolutions and the corresponding viewport breakpoints.

    Resolution 				Screen size 				Device type

    max-width: 360px			extra small resolutions (or xs)		mobile phone (viewed in portrait)

    min-width: 361px			
    max-width: 768px			small resolutions (or sm)		mobile phone (viewed in landscape)

    min-width: 769px
    max-width: 1024px			medium resolutions (or md)		tablet (viewed in landscape)

    min-width: 1025px							
    max-width: 1366px			large resolutions (or lg)		laptop	

    min-width: 1367px			extra large resolutions (or xl)		desktop
    --%>


    <div class="Formulario">
        <table class="table-condensed" style="width: 100%">
            <tr>
                <td style="text-align: center">
                    <h3 style="margin: 0">Company Insights
                    </h3>
                </td>
            </tr>
        </table>


    </div>

    <div class="pas-container">
        <telerik:RadPageLayout ID="RadPageLayout1" runat="server" GridType="Fluid">
            <Rows>
                <telerik:LayoutRow>
                    <Columns>
                        <telerik:LayoutColumn Span="6" SpanXs="12" SpanSm="12">
                            <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" DataSourceID="SqlDataSourcePropJobs" Layout="Stock" Width="90%">
                                <ChartTitle Text="Proposal vs Jobs">
                                    <Appearance Align="Center" Position="Top">
                                        <TextStyle Bold="true" FontSize="20px" Color="#317eac" />
                                    </Appearance>
                                </ChartTitle>
                                <PlotArea>
                                    <XAxis AxisCrossingValue="0" Color="#aaaaaa" DataLabelsField="DateValue" Type="Date" MinorTickType="None">
                                        <LabelsAppearance RotationAngle="0" Skip="0">
                                            <TextStyle Color="#666666" />
                                            <DateFormats MonthsFormat="MMM-yy" WeeksFormat="MMM-dd" DaysFormat="M-dd" YearsFormat="yyyy-MM" />
                                        </LabelsAppearance>
                                        <MajorGridLines Visible="false"></MajorGridLines>
                                        <MinorGridLines Visible="false"></MinorGridLines>
                                        <TitleAppearance Position="Center" RotationAngle="0" Text="Date">
                                            <TextStyle Color="#555555" />
                                        </TitleAppearance>
                                    </XAxis>
                                    <YAxis Name="LeftAxis" AxisCrossingValue="0" Color="#aaaaaa" MajorTickType="Outside" MajorTickSize="4" MinorTickType="None" MinorTickSize="0" Reversed="false">
                                        <LabelsAppearance DataFormatString="{0:N0}" Skip="0" Step="2">
                                            <TextStyle Color="#666666" />
                                        </LabelsAppearance>
                                        <MajorGridLines Visible="true" Color="#efefef" Width="1"></MajorGridLines>
                                        <MinorGridLines Visible="true" Width="0"></MinorGridLines>
                                        <TitleAppearance Text="$" Position="Center" RotationAngle="0">
                                            <TextStyle Color="#555555" />
                                        </TitleAppearance>
                                    </YAxis>
                                    <Series>
                                        <telerik:AreaSeries DataFieldY="JobBudget" Name="Job Budgets" AxisName="LeftAxis">
                                            <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                            </LabelsAppearance>
                                            <Appearance>
                                                <FillStyle BackgroundColor="#5184c4" />
                                            </Appearance>
                                            <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                        </telerik:AreaSeries>
                                        <telerik:AreaSeries DataFieldY="PropBudget" Name="Proposal Budgets" AxisName="LeftAxis">
                                            <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                            </LabelsAppearance>
                                            <Appearance>
                                                <FillStyle BackgroundColor="OrangeRed" />
                                            </Appearance>
                                            <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                        </telerik:AreaSeries>
                                    </Series>
                                </PlotArea>
                                <Legend>
                                    <Appearance Visible="True" Position="Top"></Appearance>
                                </Legend>
                                <Navigator Visible="true">
                                    <SelectionHint Visible="true" DataFormatString="From {0:d} to {1:d}" />
                                    <Series>
                                        <telerik:AreaSeries DataFieldY="JobBudget">
                                            <Appearance>
                                                <FillStyle BackgroundColor="#5184c4"></FillStyle>
                                            </Appearance>
                                        </telerik:AreaSeries>
                                        <telerik:AreaSeries DataFieldY="PropBudget">
                                            <Appearance>
                                                <FillStyle BackgroundColor="LightSalmon"></FillStyle>
                                            </Appearance>
                                        </telerik:AreaSeries>
                                    </Series>
                                    <XAxis>
                                        <LabelsAppearance>
                                            <TextStyle Color="#666666" FontSize="8px" />
                                        </LabelsAppearance>
                                    </XAxis>
                                </Navigator>
                            </telerik:RadHtmlChart>

                        </telerik:LayoutColumn>
                        <telerik:LayoutColumn Span="6" SpanXs="12" SpanSm="12">
                            <telerik:RadHtmlChart ID="RadHtmlChartBillCollected" runat="server" DataSourceID="SqlDataSourceBillCollected" Layout="Stock" Width="90%">
                                <ChartTitle Text="Bill vs Collected">
                                    <Appearance Align="Center" Position="Top">
                                        <TextStyle Bold="true" FontSize="20px" Color="#317eac" />
                                    </Appearance>
                                </ChartTitle>
                                <PlotArea>
                                    <XAxis AxisCrossingValue="0" Color="#aaaaaa" DataLabelsField="DateValue" Type="Date" MinorTickType="None">
                                        <LabelsAppearance RotationAngle="0" Skip="0">
                                            <TextStyle Color="#666666" />
                                            <DateFormats MonthsFormat="MMM-yy" WeeksFormat="MMM-dd" DaysFormat="M-dd" YearsFormat="yyyy-MM" />
                                        </LabelsAppearance>
                                        <MajorGridLines Visible="false"></MajorGridLines>
                                        <MinorGridLines Visible="false"></MinorGridLines>
                                        <TitleAppearance Position="Center" RotationAngle="0" Text="Date">
                                            <TextStyle Color="#555555" />
                                        </TitleAppearance>
                                    </XAxis>
                                    <YAxis Name="LeftAxis" AxisCrossingValue="0" Color="#aaaaaa" MajorTickType="Outside" MajorTickSize="4" MinorTickType="None" MinorTickSize="0" Reversed="false">
                                        <LabelsAppearance DataFormatString="{0:N0}" Skip="0" Step="2">
                                            <TextStyle Color="#666666" />
                                        </LabelsAppearance>
                                        <MajorGridLines Visible="true" Color="#efefef" Width="1"></MajorGridLines>
                                        <MinorGridLines Visible="true" Width="0"></MinorGridLines>
                                        <TitleAppearance Text="$" Position="Center" RotationAngle="0">
                                            <TextStyle Color="#555555" />
                                        </TitleAppearance>
                                    </YAxis>
                                    <Series>
                                        <telerik:ColumnSeries DataFieldY="Bill" Name="Bill" AxisName="LeftAxis">
                                            <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                            </LabelsAppearance>
                                            <Appearance>
                                                <FillStyle BackgroundColor="#990000" />
                                            </Appearance>
                                            <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                        </telerik:ColumnSeries>
                                        <telerik:ColumnSeries DataFieldY="Collected" Name="Collected" AxisName="LeftAxis">
                                            <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                            </LabelsAppearance>
                                            <Appearance>
                                                <FillStyle BackgroundColor="#006600" />
                                            </Appearance>
                                            <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                        </telerik:ColumnSeries>
                                    </Series>
                                </PlotArea>
                                <Legend>
                                    <Appearance Visible="True" Position="Top"></Appearance>
                                </Legend>
                                <Navigator Visible="true">
                                    <SelectionHint Visible="true" DataFormatString="From {0:d} to {1:d}" />
                                    <Series>
                                        <telerik:LineSeries DataFieldY="Bill">
                                            <Appearance>
                                                <FillStyle BackgroundColor="#990000"></FillStyle>
                                            </Appearance>
                                        </telerik:LineSeries>
                                        <telerik:LineSeries DataFieldY="Collected">
                                            <Appearance>
                                                <FillStyle BackgroundColor="#006600"></FillStyle>
                                            </Appearance>
                                        </telerik:LineSeries>
                                    </Series>
                                    <XAxis>
                                        <LabelsAppearance>
                                            <TextStyle Color="#666666" FontSize="8px" />
                                        </LabelsAppearance>
                                    </XAxis>
                                </Navigator>
                            </telerik:RadHtmlChart>
                        </telerik:LayoutColumn>
                    </Columns>
                </telerik:LayoutRow>

                <telerik:LayoutRow>
                    <Columns>
                        <telerik:LayoutColumn Span="12">
                            <hr />
                        </telerik:LayoutColumn>
                    </Columns>
                </telerik:LayoutRow>

                <telerik:LayoutRow>
                    <Columns>
                        <telerik:LayoutColumn Span="6" SpanXs="12" SpanSm="12">
                            <telerik:RadHtmlChart ID="RadHtmlChartSector" runat="server" DataSourceID="SqlDataSourceJobsBySector" Width="90%">
                                <ChartTitle Text="% Budget By Sectors">
                                    <Appearance Align="Center" Position="Top">
                                        <TextStyle Bold="true" FontSize="20px" Color="#317eac" />
                                    </Appearance>
                                </ChartTitle>
                                <Legend>
                                    <Appearance Position="Right" Visible="true">
                                    </Appearance>
                                </Legend>
                                <PlotArea>
                                    <Series>
                                        <telerik:DonutSeries DataFieldY="Budget" StartAngle="90">
                                            <LabelsAppearance Position="OutsideEnd" DataFormatString="{0:N0} %" Visible="true">
                                                <ClientTemplate>
                                     #=dataItem.Sector#&nbsp;#=dataItem.Budget# %
                                                </ClientTemplate>
                                            </LabelsAppearance>
                                            <TooltipsAppearance>
                                                <ClientTemplate>
                                     #=dataItem.Sector#<br/>#=dataItem.Budget# %
                                                </ClientTemplate>
                                            </TooltipsAppearance>
                                        </telerik:DonutSeries>
                                    </Series>
                                </PlotArea>
                            </telerik:RadHtmlChart>
                        </telerik:LayoutColumn>
                        <telerik:LayoutColumn Span="6" SpanXs="12" SpanSm="12">
                            <telerik:RadHtmlChart ID="RadHtmlChartUse" runat="server" DataSourceID="SqlDataSourceJobsByUse" Width="90%">
                                <ChartTitle Text="% Jobs By Use">
                                    <Appearance Align="Center" Position="Top">
                                        <TextStyle Bold="true" FontSize="20px" Color="#317eac" />
                                    </Appearance>
                                </ChartTitle>
                                <Legend>
                                    <Appearance Position="Right" Visible="true" BackgroundColor="White">
                                    </Appearance>
                                </Legend>
                                <PlotArea>
                                    <Appearance>
                                        <FillStyle BackgroundColor="White" />
                                    </Appearance>
                                    <Series>
                                        <telerik:DonutSeries DataFieldY="Budget" StartAngle="90">
                                            <LabelsAppearance Position="OutsideEnd" Visible="true">
                                                <ClientTemplate>
                                     #=dataItem.Use#&nbsp;#=dataItem.Budget# %
                                                </ClientTemplate>
                                            </LabelsAppearance>
                                            <TooltipsAppearance DataFormatString="{0:N0} %" />
                                            <TooltipsAppearance>
                                                <ClientTemplate>
                                     #=dataItem.Use#<br/>#=dataItem.Budget# %
                                                </ClientTemplate>
                                            </TooltipsAppearance>
                                        </telerik:DonutSeries>
                                    </Series>
                                </PlotArea>
                            </telerik:RadHtmlChart>
                        </telerik:LayoutColumn>
                    </Columns>
                </telerik:LayoutRow>

                <telerik:LayoutRow>
                    <Columns>
                        <telerik:LayoutColumn Span="12">
                            <hr />
                        </telerik:LayoutColumn>
                    </Columns>
                </telerik:LayoutRow>

                <telerik:LayoutRow>
                    <Columns>
                        <telerik:LayoutColumn Span="6" SpanXs="12" SpanSm="12">
                            <telerik:RadHtmlChart ID="RadHtmlChartClientsByType" runat="server" DataSourceID="SqlDataSourceClientsByType" Width="90%">
                                <ChartTitle Text="% Clients by Type">
                                    <Appearance Align="Center" Position="Top">
                                        <TextStyle Bold="true" FontSize="20px" Color="#317eac" />
                                    </Appearance>
                                </ChartTitle>
                                <Legend>
                                    <Appearance Position="Right" Visible="true">
                                    </Appearance>
                                </Legend>
                                <PlotArea>
                                    <Series>
                                        <telerik:DonutSeries DataFieldY="Clients" StartAngle="90">
                                            <LabelsAppearance Position="OutsideEnd" DataFormatString="{0:N0} %" Visible="true">
                                                <ClientTemplate>
                                     #=dataItem.Type#&nbsp;#=dataItem.Clients# %
                                                </ClientTemplate>
                                            </LabelsAppearance>
                                            <TooltipsAppearance>
                                                <ClientTemplate>
                                     #=dataItem.Type#<br/>#=dataItem.Clients# %
                                                </ClientTemplate>
                                            </TooltipsAppearance>
                                        </telerik:DonutSeries>
                                    </Series>
                                </PlotArea>
                            </telerik:RadHtmlChart>
                        </telerik:LayoutColumn>
                        <telerik:LayoutColumn Span="6" SpanXs="12" SpanSm="12">
                            <telerik:RadHtmlChart ID="RadHtmlChartClientsByStatus" runat="server" DataSourceID="SqlDataSourceClientsByStatus" Width="90%">
                                <ChartTitle Text="% Clients by Status">
                                    <Appearance Align="Center" Position="Top">
                                        <TextStyle Bold="true" FontSize="20px" Color="#317eac" />
                                    </Appearance>
                                </ChartTitle>
                                <Legend>
                                    <Appearance Position="Right" Visible="true" BackgroundColor="White">
                                    </Appearance>
                                </Legend>
                                <PlotArea>
                                    <Appearance>
                                        <FillStyle BackgroundColor="White" />
                                    </Appearance>
                                    <Series>
                                        <telerik:DonutSeries DataFieldY="Clients" StartAngle="90">
                                            <LabelsAppearance Position="OutsideEnd" Visible="true">
                                                <ClientTemplate>
                                     #=dataItem.Status#&nbsp;#=dataItem.Clients# %
                                                </ClientTemplate>
                                            </LabelsAppearance>
                                            <TooltipsAppearance DataFormatString="{0:N0} %" />
                                            <TooltipsAppearance>
                                                <ClientTemplate>
                                     #=dataItem.Status#<br/>#=dataItem.Clients# %
                                                </ClientTemplate>
                                            </TooltipsAppearance>
                                        </telerik:DonutSeries>
                                    </Series>
                                </PlotArea>
                            </telerik:RadHtmlChart>
                        </telerik:LayoutColumn>

                    </Columns>
                </telerik:LayoutRow>
            </Rows>
        </telerik:RadPageLayout>

    </div>


    <asp:SqlDataSource ID="SqlDataSourcePropJobs" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="YearStadistic_PROPOSALS_JOBS3" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceBillCollected" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="YearStadistic_BillvsCollected2" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceJobsBySector" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOBS_ResultBySector" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceJobsByUse" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOBS_ResultByUse" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClientsByType" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENTS_ResultByType" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClientsByStatus" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENTS_ResultByStatus" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>

