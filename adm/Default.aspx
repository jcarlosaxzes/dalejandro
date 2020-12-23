﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="Default.aspx.vb" Inherits="pasconcept20._Default1" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link rel="manifest" href="../manifest.json" />
    <script src="https://cdn.onesignal.com/sdks/OneSignalSDK.js" async=""></script>
    <style type="text/css">
        .higherZIndex {
            z-index: 2;
        }

        .RadDockZone {
            min-width: 100px;
            min-height: 50px;
            padding: .35714286em;
            border-width: 1px;
            border-style: none !important;
            padding-top: 0px !important;
            top: 0px !important;
        }

        .RadDock {
            border-radius: 6px;
        }

            .RadDock .rdTitleWrapper {
                border-radius: 6px;
            }
    </style>

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Company Overview</span>
    </div>
    <telerik:RadDockLayout runat="server" ID="RadDockLayout1">

        <table class="table-sm" style="width: 100%">

            <tr>
                <td>
                    <telerik:RadDockZone runat="server" ID="RadDockZone1">

                        <telerik:RadDock RenderMode="Lightweight" ID="RadDockRates" runat="server" Title="Company Trends Over the Last 5 Years" EnableAnimation="true"
                            EnableRoundedCorners="true" CommandsAutoPostBack="false">
                            <ContentTemplate>
                                <table style="width: 100%" >
                                    <tr>
                                        <td>
                                            <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" DataSourceID="SqlDataSourceRates" Width="100%" Height="400px" Skin="Material">
                                                <PlotArea>
                                                    <XAxis AxisCrossingValue="0" Color="black" MajorTickType="Outside" MinorTickType="Outside" Reversed="false" DataLabelsField="Year">
                                                        <TitleAppearance Visible="false" Position="Center" RotationAngle="0" Text="Years"></TitleAppearance>
                                                        <LabelsAppearance DataFormatString="{0}" Skip="0" Step="1">
                                                            <TextStyle FontSize="24px" Bold="true" />
                                                        </LabelsAppearance>
                                                        <MajorGridLines Visible="false"></MajorGridLines>
                                                        <MinorGridLines Visible="false"></MinorGridLines>
                                                    </XAxis>

                                                    <YAxis Name="LeftAxis">
                                                        <TitleAppearance Text="Rate" Visible="false"></TitleAppearance>
                                                        <LabelsAppearance DataFormatString="{0:N2}">
                                                            <TextStyle FontSize="14px" Bold="true" />
                                                        </LabelsAppearance>
                                                    </YAxis>
                                                    <Series>
                                                        <telerik:LineSeries DataFieldY="ProposalSuccessRate" Name="Proposal Success Rate">
                                                            <LabelsAppearance Visible="false" DataFormatString="{0:N2}">
                                                            </LabelsAppearance>
                                                            <Appearance>
                                                                <FillStyle BackgroundColor="#7787A5" />
                                                            </Appearance>
                                                            <LineAppearance LineStyle="Smooth" Width="3" />
                                                            <TooltipsAppearance DataFormatString="{0:N2}" Color="White"></TooltipsAppearance>
                                                            <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                                        </telerik:LineSeries>
                                                        <telerik:LineSeries DataFieldY="ReturnOnInvestment" Name="R O I">
                                                            <LabelsAppearance Visible="false" DataFormatString="{0:N2}">
                                                            </LabelsAppearance>
                                                            <Appearance>
                                                                <FillStyle BackgroundColor="Red" />
                                                            </Appearance>
                                                            <LineAppearance LineStyle="Smooth" Width="3" />
                                                            <TooltipsAppearance DataFormatString="{0:N2}" Color="White"></TooltipsAppearance>
                                                            <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                                        </telerik:LineSeries>
                                                        <telerik:LineSeries DataFieldY="DirectLaborRate" Name="Direct Labor Rate">
                                                            <LabelsAppearance Visible="false" DataFormatString="{0:N2}">
                                                            </LabelsAppearance>
                                                            <Appearance>
                                                                <FillStyle BackgroundColor="Black" />
                                                            </Appearance>
                                                            <LineAppearance LineStyle="Smooth" Width="3" />
                                                            <TooltipsAppearance DataFormatString="{0:N2}" Color="White"></TooltipsAppearance>
                                                            <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                                        </telerik:LineSeries>
                                                        <telerik:LineSeries DataFieldY="ActiveClientRate" Name="Active Clients Rate">
                                                            <LabelsAppearance Visible="false" DataFormatString="{0:N2}">
                                                            </LabelsAppearance>
                                                            <Appearance>
                                                                <FillStyle BackgroundColor="DarkCyan" />
                                                            </Appearance>
                                                            <LineAppearance LineStyle="Smooth" Width="3" />
                                                            <TooltipsAppearance DataFormatString="{0:N2}" Color="White"></TooltipsAppearance>
                                                            <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                                        </telerik:LineSeries>
                                                        <telerik:LineSeries DataFieldY="BillingSuccessRate" Name="Billing Success Rate">
                                                            <LabelsAppearance Visible="false" DataFormatString="{0:N2}">
                                                            </LabelsAppearance>
                                                            <Appearance>
                                                                <FillStyle BackgroundColor="Orange" />
                                                            </Appearance>
                                                            <LineAppearance LineStyle="Smooth" Width="3" />
                                                            <TooltipsAppearance DataFormatString="{0:N2}" Color="White"></TooltipsAppearance>
                                                            <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                                        </telerik:LineSeries>
                                                        <telerik:LineSeries DataFieldY="EmployeeEfficiencyRate" Name="Employee Efficiency Rate">
                                                            <LabelsAppearance Visible="false" DataFormatString="{0:N2}">
                                                            </LabelsAppearance>
                                                            <Appearance>
                                                                <FillStyle BackgroundColor="Blue" />
                                                            </Appearance>
                                                            <LineAppearance LineStyle="Smooth" Width="3" />
                                                            <TooltipsAppearance DataFormatString="{0:N2}" Color="White"></TooltipsAppearance>
                                                            <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                                        </telerik:LineSeries>
                                                    </Series>
                                                </PlotArea>
                                                <Legend>
                                                    <Appearance Visible="True" Position="Top">
                                                        <TextStyle FontSize="14" Bold="true" FontFamily="Sans-Serif" />
                                                        <ClientTemplate>
                                                #= text #&nbsp;
                                                        </ClientTemplate>
                                                    </Appearance>

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
                                                    <span class="pasconcept-pagetitle">Company Trends (Ratios) Over the Last 5 Years</span>
                                                </div>
                                                <table class="table table-striped" style="width: 850px; font-size: medium;text-align:center;">
                                                    <tr>
                                                        <td style="width: 200px;">
                                                            <span class="badge badge-secondary">Proposal Success Rate = </span>
                                                        </td>
                                                        <td>
                                                            This rate demonstrates the proposals which have been successfully accepted in contrast to the total number of emitted proposals. This number is adjusted to include Jobs created without Proposals.
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <span class="badge badge-danger">Return On Investment = </span>
                                                        </td>
                                                        <td>
                                                            This figure represents the total collected from projects contrasted against the total spent on the projects. The total spent on the projects includes all Salary, Salary Taxes, and other Project Expenses including Subcontractor Costs. The total spent is adjusted to include the Company Multiplier to provide the most accurate figure. 
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <span class="badge badge-dark">Direct Labor Rate = </span>
                                                        </td>
                                                        <td>
                                                            This rate is determined by observing the Salary of Productive Employees (employees directly related to the project) contrasted by the Total Salary expenses of the company. This figure is adjusted to include the Company Multiplier to provide the most accurate figure. 
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <span class="badge badge-success">Active Client Rate = </span>
                                                        </td>
                                                        <td>
                                                            This rate is determined by observing the Salary of Productive Employees (employees directly related to the project) contrasted by the Total Salary expenses of the company. This figure is adjusted to include the Company Multiplier to provide the most accurate figure. 
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <span class="badge badge-warning">Billing Success Rate = </span>
                                                        </td>
                                                        <td>
                                                            This rate demonstrates the success of emitted invoices by contrasting the emitted past due invoices against the total emitted invoices.  
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <span class="badge badge-primary">Employee Efficiency Rate =</span>
                                                        </td>
                                                        <td>
                                                               This rate demonstrates the effectiveness of an employee by contrasting their assigned hours against their hours entered.

                                                        </td>
                                                    </tr>
                                                </table>
                                            </telerik:RadToolTip>
                                        </td>
                                    </tr>
                                </table>

                            </ContentTemplate>
                        </telerik:RadDock>
                        <telerik:RadDock RenderMode="Auto" ID="RadDockProposals" runat="server" Title="<a class='lnkGrid' href='Proposals' title='Go to Proposals List'>Proposals Over the Last 5 Years</a>" EnableAnimation="true"
                            EnableRoundedCorners="true" CommandsAutoPostBack="false">
                            <ContentTemplate>
                                <telerik:RadGrid ID="RadGridProposalJobs" runat="server" DataSourceID="SqlDataSourceProposalJobs" Width="100%" AutoGenerateColumns="False" RenderMode="Lightweight" HeaderStyle-HorizontalAlign="Center"
                                    EnableHeaderContextMenu="false" AllowFilteringByColumn="false">
                                    <MasterTableView DataSourceID="SqlDataSourceProposalJobs" Width="100%">
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="CONCEPT" UniqueName="CONCEPT">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn DataField="year-4" UniqueName="year-4" HeaderText="year-4"  ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="12%">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel171" runat="server" CssClass="GridRow" Text='<%# Eval("year-4", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-4"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-3" UniqueName="year-3" HeaderText="year-3"  ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="12%">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel27" runat="server" CssClass="GridRow" Text='<%# Eval("year-3", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-3"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-2" UniqueName="year-2" HeaderText="year-2"  ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="12%">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel37" runat="server" CssClass="GridRow" Text='<%# Eval("year-2", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-2"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-1" UniqueName="year-1" HeaderText="year-1"  ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="12%">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel47" runat="server" CssClass="GridRow" Text='<%# Eval("year-1", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-1"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year" UniqueName="year" HeaderText="year"  ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="12%">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel57" runat="server" CssClass="GridRow" Text='<%# Eval("year", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>

                                    </MasterTableView>
                                </telerik:RadGrid>
                            </ContentTemplate>
                        </telerik:RadDock>

                        <telerik:RadDock RenderMode="Lightweight" ID="RadDockJobs" runat="server" Title="<a class='lnkGrid' href='Jobs' title='Go to Jobs List'>Jobs Over the Last 5 Years</a>" EnableAnimation="true"
                            EnableRoundedCorners="true" CommandsAutoPostBack="false">
                            <ContentTemplate>
                                <telerik:RadGrid ID="RadGridJobs" runat="server" DataSourceID="SqlDataSourceJobs" Width="100%" AutoGenerateColumns="False" RenderMode="Lightweight" HeaderStyle-HorizontalAlign="Center">
                                    <MasterTableView DataSourceID="SqlDataSourceJobs" Width="100%">
                                        <Columns>
                                            <telerik:GridTemplateColumn DataField="CONCEPT" UniqueName="CONCEPT" ItemStyle-CssClass="CONCEPT">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel08" runat="server" CssClass="GridRow" Text='<%# Eval("CONCEPT")%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-4" UniqueName="year-4" HeaderText="year-4"  ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="12%">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel18" runat="server" CssClass="GridRow" Text='<%# Eval("year-4", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-4"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-3" UniqueName="year-3" HeaderText="year-3"  ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="12%">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel28" runat="server" CssClass="GridRow" Text='<%# Eval("year-3", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-3"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-2" UniqueName="year-2" HeaderText="year-2"  ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="12%">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel38" runat="server" CssClass="GridRow" Text='<%# Eval("year-2", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-2"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-1" UniqueName="year-1" HeaderText="year-1"  ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="12%">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel48" runat="server" CssClass="GridRow" Text='<%# Eval("year-1", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-1"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year" UniqueName="year" HeaderText="year"  ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="12%">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel58" runat="server" CssClass="GridRow" Text='<%# Eval("year", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </ContentTemplate>
                        </telerik:RadDock>

                        <telerik:RadDock RenderMode="Lightweight" ID="RadDockEmployeeStatistics" runat="server" Title="<a class='lnkGrid' href='TimesByPeriords' title='Go to Times By Periords'>Employee Historical Statistics</a>" EnableAnimation="true"
                            EnableRoundedCorners="true" CommandsAutoPostBack="false">
                            <ContentTemplate>
                                <telerik:RadGrid ID="RadGridEmployeeStatistics" runat="server" DataSourceID="SqlDataSourceProposalEmployeeStatistics" Width="100%" AutoGenerateColumns="False"
                                    AllowPaging="False" RenderMode="Lightweight" HeaderStyle-HorizontalAlign="Center" Height="400px">
                                    <ClientSettings Selecting-AllowRowSelect="true">
                                        <Scrolling AllowScroll="True"></Scrolling>
                                    </ClientSettings>

                                    <MasterTableView DataSourceID="SqlDataSourceProposalEmployeeStatistics" Width="100%">
                                        <Columns>
                                            <telerik:GridTemplateColumn DataField="Name" UniqueName="Name" ItemStyle-CssClass="CONCEPT">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel07" runat="server" CssClass="GridRow" Text='<%# Eval("Name")%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn DataField="Workload" UniqueName="Workload" HeaderText="Workload" HeaderStyle-Width="250px" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Total Hours assigned to active projects">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="ProductivityRate" UniqueName="ProductivityRate" HeaderText="Productivity Rate" HeaderStyle-Width="250px" DataFormatString="{0:P2}" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Productive Time vs Personal/Vacations/Non-Productive Time">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Efficiency" UniqueName="Efficiency" HeaderText="Budget Efficiency" HeaderStyle-Width="250px" DataFormatString="{0:P2}" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Net financial gain; rate between Budget Assigned and amount spent (Budget Used)">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="TimeEfficiency" UniqueName="TimeEfficiency" HeaderText="Time Efficiency" HeaderStyle-Width="250px" DataFormatString="{0:P2}" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Net financial gain; rate between Hours Assigned and amount used (Worked Hours)">
                                            </telerik:GridBoundColumn>
                                        </Columns>

                                    </MasterTableView>
                                </telerik:RadGrid>
                            </ContentTemplate>
                        </telerik:RadDock>

                        <telerik:RadDock RenderMode="Lightweight" ID="RadDockClients" runat="server" Title="<a class='lnkGrid' href='Clients' title='Go to Clients List'>Clients Over the Last 5 Years</a>" EnableAnimation="true"
                            EnableRoundedCorners="true" CommandsAutoPostBack="false">
                            <ContentTemplate>
                                <telerik:RadGrid ID="RadGridClients" runat="server" DataSourceID="SqlDataSourceClients" Width="100%" AutoGenerateColumns="False" RenderMode="Lightweight" HeaderStyle-HorizontalAlign="Center">
                                    <MasterTableView DataSourceID="SqlDataSourceClients" Width="100%">
                                        <Columns>
                                            <telerik:GridTemplateColumn DataField="CONCEPT" UniqueName="CONCEPT" ItemStyle-Width="290px" ItemStyle-CssClass="CONCEPT">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel09" runat="server" CssClass="GridRow" Text='<%# Eval("CONCEPT")%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-4" UniqueName="year-4" HeaderText="year-4"  ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel19" runat="server" CssClass="GridRow" Text='<%# Eval("year-4", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-4"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-3" UniqueName="year-3" HeaderText="year-3"  ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel29" runat="server" CssClass="GridRow" Text='<%# Eval("year-3", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-3"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-2" UniqueName="year-2" HeaderText="year-2"  ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel39" runat="server" CssClass="GridRow" Text='<%# Eval("year-2", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-2"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-1" UniqueName="year-1" HeaderText="year-1"  ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel49" runat="server" CssClass="GridRow" Text='<%# Eval("year-1", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-1"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year" UniqueName="year" HeaderText="year"  ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel59" runat="server" CssClass="GridRow" Text='<%# Eval("year", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>

                                    </MasterTableView>
                                </telerik:RadGrid>
                            </ContentTemplate>
                        </telerik:RadDock>
                        <telerik:RadDock RenderMode="Lightweight" ID="RadDockSubconsultants" runat="server" Title="<a class='lnkGrid' href='SubConsultans' title='Go to SubConsultants List'>Subconsultants Over the Last 5 Years</a>" EnableAnimation="true"
                            EnableRoundedCorners="true" CommandsAutoPostBack="false">
                            <ContentTemplate>
                                <telerik:RadGrid ID="RadGridSubConsultants" runat="server" DataSourceID="SqlDataSourceSubConsultants" Width="100%" AutoGenerateColumns="False" RenderMode="Lightweight" HeaderStyle-HorizontalAlign="Center">
                                    <MasterTableView DataSourceID="SqlDataSourceSubConsultants" Width="100%">
                                        <Columns>
                                            <telerik:GridTemplateColumn DataField="CONCEPT" UniqueName="CONCEPT" ItemStyle-Width="290px" ItemStyle-CssClass="CONCEPT">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel00" runat="server" CssClass="GridRow" Text='<%# Eval("CONCEPT")%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-4" UniqueName="year-4" HeaderText="year-4"  ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel11" runat="server" CssClass="GridRow" Text='<%# Eval("year-4", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-4"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-3" UniqueName="year-3" HeaderText="year-3"  ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel22" runat="server" CssClass="GridRow" Text='<%# Eval("year-3", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-3"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-2" UniqueName="year-2" HeaderText="year-2"  ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel33" runat="server" CssClass="GridRow" Text='<%# Eval("year-2", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-2"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-1" UniqueName="year-1" HeaderText="year-1"  ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel44" runat="server" CssClass="GridRow" Text='<%# Eval("year-1", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-1"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year" UniqueName="year" HeaderText="year"  ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel55" runat="server" CssClass="GridRow" Text='<%# Eval("year", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>

                                    </MasterTableView>
                                </telerik:RadGrid>
                            </ContentTemplate>
                        </telerik:RadDock>
                    </telerik:RadDockZone>
                </td>
            </tr>
        </table>


    </telerik:RadDockLayout>

    <asp:Panel runat="server" class="pasconcept-bar noprint" ID="MobileQRPanel" Style="text-align: right; vertical-align: middle;">
        <span class="pasconcept-pagetitle">Dashboard from your mobile device:</span>
        <telerik:RadBarcode runat="server" ID="RadBarcode1" Type="QRCode" Height="140px" Width="140px" OutputType="EmbeddedPNG" ToolTip="Dashboard from your mobile device" Text="">
            <QRCodeSettings Version="5" DotSize="3" Mode="Byte" />
        </telerik:RadBarcode>
    </asp:Panel>

    <asp:Panel runat="server" ID="panelEmployeePortal" Visible="false">

        <span class="navbar navbar-expand-md bg-dark text-white">
            <h2>PASconcept Application Home Page</h2>
        </span>
        <h3>PASconcept is your complete online platform for Project Administration Services</h3>
        <p>
            PASconcept is a complete, functional and efficient tool for project administration services. 
            It is a web-based application designed to provide an all-inclusive management system for architectural and engineering firms that want to facilitate the interaction between administrators, employees, sub-consultants and customers.
       
        </p>
        <br />
        <h3>Administrators
        </h3>
        <p>
            Oversee projects, subcontracts, clients, employees, fee proposals, billing and other administrative functions through an organized system of interactive data.
       
        </p>
        <br />

        <h3>Employees</h3>
        <p>
            Keep track of projects, manage billing, receive personal productivity reports and complete project-specific timesheets with a single site for employee-specific needs.
       
        </p>
        <asp:LinkButton ID="btnEmployeePortal" runat="server" CssClass="btn btn-info btn-lg"
            UseSubmitBehavior="false" CommandName="Login" ValidationGroup="Login2">
                                                                        <i class="fas fa-user-clock"></i>&nbsp;Go to Employee Portal
        </asp:LinkButton>
    </asp:Panel>

    <telerik:RadWindowManager ID="RadWindowManagerJob" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <asp:SqlDataSource ID="SqlDataSourceProposalJobs" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="YearStadistic_v20_PROPOSALS_JOBS" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceJobs" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="YearStadistic_JOBS" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClients" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="YearStadistic_CLIENTS" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSubConsultants" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="YearStadistic_SUBCONSULTANTS" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceProposalEmployeeStatistics" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="EmployeeStatistics_20_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceRates" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="YearStadistic_v20_RATES" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:TextBox ID="lblUserEmail" runat="server" Visible="False"></asp:TextBox>

</asp:Content>
