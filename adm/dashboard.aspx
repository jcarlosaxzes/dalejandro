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

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Company Insights</span>
    </div>
    <table class="table-sm pas-container" style="width: 100%; text-align: center">
        
        <tr>
            <td colspan="2">

                <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" DataSourceID="SqlDataSourceCompanyHistory" Height="600px" Width="100%">
                    <ChartTitle Text="Production History">
                        <Appearance Align="Center" Position="Top">
                            <TextStyle Bold="true" FontSize="20px" Color="#317eac" />
                        </Appearance>
                    </ChartTitle>
                    <PlotArea>
                        <Series>
                            <telerik:AreaSeries DataFieldY="ProposalTotal" Name="Proposal Total">
                                <Appearance FillStyle-BackgroundColor="Blue"></Appearance>
                                <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                <TooltipsAppearance DataFormatString="{0:N0}" Color="White"></TooltipsAppearance>
                            </telerik:AreaSeries>
                        </Series>
                        <Series>
                            <telerik:AreaSeries DataFieldY="JobsTotal" Name="Jobs Total">
                                <Appearance FillStyle-BackgroundColor="Red"></Appearance>
                                <LabelsAppearance Visible="false"></LabelsAppearance>
                                <TooltipsAppearance DataFormatString="{0:N0}" Color="White"></TooltipsAppearance>
                            </telerik:AreaSeries>
                        </Series>
                        <Series>
                            <telerik:LineSeries DataFieldY="PaymentsTotal" Name="Received Payment">
                                <LabelsAppearance Visible="false" DataFormatString="{0:C0}">
                                </LabelsAppearance>
                                <Appearance>
                                    <FillStyle BackgroundColor="Green" />
                                </Appearance>
                                <LineAppearance LineStyle="Smooth" Width="3" />
                                <TooltipsAppearance DataFormatString="{0:N0}" Color="White"></TooltipsAppearance>
                                <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                            </telerik:LineSeries>
                        </Series>
                        <YAxis Name="LeftAxis" MajorTickSize="4" MajorTickType="Outside" Width="3">
                            <TitleAppearance Text="$"></TitleAppearance>
                            <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                            <MinorGridLines Visible="false"></MinorGridLines>
                        </YAxis>
                        <XAxis DataLabelsField="Year">
                            <TitleAppearance Text="Year"></TitleAppearance>
                            <MinorGridLines Visible="false"></MinorGridLines>
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

        </tr>
        <tr>
            <td style="width: 50%">
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
            </td>
            <td>
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
            </td>
        </tr>
        <tr>
            <td>
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
            </td>
            <td>
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
            </td>
        </tr>

    </table>


    <asp:SqlDataSource ID="SqlDataSourceCompanyHistory" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CompanyTimeLine_SELECT" SelectCommandType="StoredProcedure">
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

