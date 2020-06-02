<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="Default.aspx.vb" Inherits="pasconcept20._Default1" %>

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

    <telerik:RadDockLayout runat="server" ID="RadDockLayout1">

        <table style="width: 100%">

            <tr>
                <td>
                    <telerik:RadDockZone runat="server" ID="RadDockZone1">

                        <telerik:RadDock RenderMode="Lightweight" ID="RadDockProposalsJobsRates" runat="server" Title="Proposal/Jobs Hit Rate" EnableAnimation="true"
                            EnableRoundedCorners="true" CommandsAutoPostBack="false">
                            <ContentTemplate>
                                <table runat="server" id="tableCompany16" class="table-condensed" style="width: 100%">
                                    <tr>
                                        <td style='<%# iif(LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Type") = 16,"width:250px;text-align: center; vertical-align: top","width:0px") %>'>
                                            <asp:Panel ID="panelCompany16" runat="server" Visible='<%# LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Type") = 16 %>' Width="250px">
                                                <span class="label label-info center-block">"In Progress" Jobs </span>
                                                <telerik:RadListView ID="RadListView1" runat="server" DataSourceID="SqlDataSourceJobsInProgressByEmployee" DataKeyNames="Id"
                                                    ItemPlaceholderID="Container1"
                                                    BorderStyle="Solid" Height="380px" Width="100%"
                                                    AllowPaging="true">
                                                    <LayoutTemplate>
                                                        <fieldset style="width: 100%">
                                                            <asp:PlaceHolder ID="Container1" runat="server"></asp:PlaceHolder>
                                                        </fieldset>

                                                        <telerik:RadDataPager RenderMode="Lightweight" ID="RadDataPager1" runat="server" PageSize="4">
                                                            <Fields>
                                                                <telerik:RadDataPagerButtonField FieldType="Numeric"></telerik:RadDataPagerButtonField>
                                                            </Fields>
                                                        </telerik:RadDataPager>
                                                    </LayoutTemplate>
                                                    <ItemTemplate>
                                                        <fieldset class="thumbnail" style="float: left; width: 250px; margin: 1px">
                                                            <table style="width: 100%">
                                                                <tr>
                                                                    <td>

                                                                        <asp:LinkButton ID="btnEditJob" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Click to Edit Job"
                                                                            CommandName="EditJob" UseSubmitBehavior="false">                                                                                                                                                       
                                                                                <h4 style="margin: 0"><span class="center-block label label-success"><%# String.Concat(Eval("Code"), "  ", Eval("itemName"))%></span></h4>
                                                                        </asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:LinkButton ID="btnClient" runat="server" CommandArgument='<%# Eval("clientId")%>' ToolTip="Click to View/Edit Client"
                                                                            CommandName="EditClient" UseSubmitBehavior="false">                                                                                                                                                       
                                                                            <span class="center-block label label-warning"><%# Eval("ClientNameAndCompany")%></span>     
                                                                        </asp:LinkButton>

                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="padding-top: 5px; background-color: whitesmoke">
                                                                        <asp:LinkButton ID="btnEdit" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Click to View/Edit Job"
                                                                            CommandName="EditJob" UseSubmitBehavior="false" >
                                                                            <span aria-hidden="true" class="glyphicon glyphicon-pencil"></span>
                                                                        </asp:LinkButton>
                                                                        &nbsp;&nbsp;
                                                                        <asp:LinkButton ID="btnAccounting" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Click to View/Edit Accounting"
                                                                            CommandName="Accounting" UseSubmitBehavior="false" Visible='<%# LocalAPI.GetEmployeePermission(lblEmployeeId.Text, "Deny_InvoicesList") %>'>
                                                                            <span aria-hidden="true" class="glyphicon glyphicon-usd"></span>
                                                                        </asp:LinkButton>
                                                                        &nbsp;&nbsp;
                                                                        <asp:LinkButton ID="btnNewTime" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Click to Add New Time"
                                                                            CommandName="NewTime" UseSubmitBehavior="false">
                                                                            <span aria-hidden="true" class="glyphicon glyphicon-time"></span>
                                                                        </asp:LinkButton>
                                                                        &nbsp;&nbsp;
                                                                        <asp:LinkButton ID="btnTickets" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Click to View/Edit Tickets"
                                                                            CommandName="Tickets" UseSubmitBehavior="false">
                                                                                <i class="fa fa-clipboard-check"></i>
                                                                        </asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="background-color: whitesmoke">
                                                                        <table style="width: 100%">
                                                                            <tr>
                                                                                <td style="text-align: right; font-size: small; width: 20%">Job:&nbsp;
                                                                                </td>
                                                                                <td style="text-align: left; font-weight: bold; width: 30%">
                                                                                    <small title="[Job Balance] = JobInvoiceAmount - JobCollected - JobBadDebt"><%# Eval("JobBalance", "{0:C0}")%></small>
                                                                                </td>
                                                                                <td style="text-align: right; font-size: small; width: 20%">Client:&nbsp;
                                                                                </td>
                                                                                <td style="text-align: left; font-weight: bold">
                                                                                    <small title="[Client Balance] = ClientEmittedTotal - ClientPaymentTotal - ClientBadDebtTotal"><%# Eval("ClientBalance", "{0:C0}")%></small>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </fieldset>
                                                    </ItemTemplate>

                                                </telerik:RadListView>
                                            </asp:Panel>
                                        </td>
                                        <td>
                                            <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" DataSourceID="SqlDataSourcePropJobsBudgetsRate" Width="100%" Height="400px">
                                                <PlotArea>
                                                    <XAxis AxisCrossingValue="0" Color="black" MajorTickType="Outside" MinorTickType="Outside" Reversed="false" DataLabelsField="YearDate">
                                                        <TitleAppearance Visible="false" Position="Center" RotationAngle="0" Text="Years"></TitleAppearance>
                                                        <LabelsAppearance DataFormatString="{0}" RotationAngle="315" Skip="0" Step="1">
                                                            <TextStyle FontSize="10px" />
                                                        </LabelsAppearance>
                                                        <MajorGridLines Visible="false"></MajorGridLines>
                                                        <MinorGridLines Visible="false"></MinorGridLines>

                                                        <AxisCrossingPoints>
                                                            <telerik:AxisCrossingPoint Value="0" />
                                                            <telerik:AxisCrossingPoint Value="9999" />
                                                        </AxisCrossingPoints>
                                                    </XAxis>

                                                    <YAxis Name="LeftAxis"
                                                        AxisCrossingValue="0"
                                                        Color="Red"
                                                        Width="3"
                                                        MajorTickType="Outside"
                                                        MajorTickSize="4"
                                                        MinorTickType="None"
                                                        MinorTickSize="0"
                                                        Reversed="false">
                                                        <LabelsAppearance DataFormatString="{0:C0}" Skip="0" Step="2">
                                                            <TextStyle Color="#666666" FontSize="10px" />
                                                        </LabelsAppearance>
                                                        <MajorGridLines Visible="true" Color="#efefef" Width="1"></MajorGridLines>
                                                        <MinorGridLines Visible="true" Width="0"></MinorGridLines>
                                                        <TitleAppearance Text="$" Position="Center" RotationAngle="0" Visible="false">
                                                            <TextStyle Color="#555555" />
                                                        </TitleAppearance>
                                                    </YAxis>
                                                    <AdditionalYAxes>
                                                        <telerik:AxisY Name="RightAxis" Color="Green" Width="3">
                                                            <TitleAppearance Text="Hit Rate %" Visible="false"></TitleAppearance>
                                                            <LabelsAppearance DataFormatString="{0:N0}%">
                                                                <TextStyle FontSize="10px" />
                                                            </LabelsAppearance>
                                                        </telerik:AxisY>
                                                    </AdditionalYAxes>
                                                    <Series>
                                                        <telerik:AreaSeries DataFieldY="JobBudget" Name="Job Budgets" AxisName="LeftAxis">
                                                            <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                                            </LabelsAppearance>
                                                            <Appearance>
                                                                <FillStyle BackgroundColor="#214EA5" />
                                                            </Appearance>
                                                            <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                                        </telerik:AreaSeries>
                                                        <telerik:AreaSeries DataFieldY="PropBudget" Name="Proposal Budgets" AxisName="LeftAxis">
                                                            <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                                            </LabelsAppearance>
                                                            <Appearance>
                                                                <FillStyle BackgroundColor="#78A8F0" />
                                                            </Appearance>
                                                            <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                                        </telerik:AreaSeries>
                                                        <%-- <telerik:AreaSeries DataFieldY="DptoBudget" Name="Department Budgets" AxisName="LeftAxis">
                                                            <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                                            </LabelsAppearance>
                                                            <Appearance>
                                                                <FillStyle BackgroundColor="#ccff33" />
                                                            </Appearance>
                                                            <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                                        </telerik:AreaSeries>--%>
                                                    </Series>
                                                    <Series>
                                                        <telerik:LineSeries DataFieldY="Rate" Name="Hit Rate (#Jobs/#Proposal)" AxisName="RightAxis">
                                                            <LabelsAppearance Visible="false" DataFormatString="{0:C0}">
                                                            </LabelsAppearance>
                                                            <Appearance>
                                                                <FillStyle BackgroundColor="#7787A5" />
                                                            </Appearance>
                                                            <LineAppearance LineStyle="Smooth" Width="3" />
                                                            <TooltipsAppearance DataFormatString="{0:N0}" Color="White"></TooltipsAppearance>
                                                            <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                                        </telerik:LineSeries>
                                                    </Series>
                                                </PlotArea>
                                                <Legend>
                                                    <Appearance Visible="True" Position="Top"></Appearance>
                                                </Legend>
                                            </telerik:RadHtmlChart>
                                        </td>
                                    </tr>
                                </table>

                            </ContentTemplate>
                        </telerik:RadDock>
                        <telerik:RadDock RenderMode="Lightweight" ID="RadDockProposals" runat="server" Title="<a class='lnkGrid' href='Proposals' title='Go to Proposals List'>Proposals  / </a><a class='lnkGrid' href='Jobs' title='Go to Jobs List'>Jobs</a>" EnableAnimation="true"
                            EnableRoundedCorners="true" CommandsAutoPostBack="false">
                            <ContentTemplate>
                                <telerik:RadGrid ID="RadGridProposalJobs" runat="server" DataSourceID="SqlDataSourceProposalJobs" Width="100%" AutoGenerateColumns="False">
                                    <MasterTableView DataSourceID="SqlDataSourceProposalJobs" Width="100%">
                                        <ItemStyle CssClass="GridRow" />
                                        <AlternatingItemStyle CssClass="GridRow" />
                                        <Columns>
                                            <telerik:GridTemplateColumn DataField="CONCEPT" UniqueName="CONCEPT" HeaderStyle-Width="290px" ItemStyle-CssClass="CONCEPT">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel07" runat="server" CssClass="GridRow" Text='<%# Eval("CONCEPT")%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-4" UniqueName="year-4" HeaderText="year-4" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel171" runat="server" CssClass="GridRow" Text='<%# Eval("year-4", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-4"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-3" UniqueName="year-3" HeaderText="year-3" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel27" runat="server" CssClass="GridRow" Text='<%# Eval("year-3", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-3"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-2" UniqueName="year-2" HeaderText="year-2" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel37" runat="server" CssClass="GridRow" Text='<%# Eval("year-2", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-2"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-1" UniqueName="year-1" HeaderText="year-1" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel47" runat="server" CssClass="GridRow" Text='<%# Eval("year-1", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-1"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year" UniqueName="year" HeaderText="year" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel57" runat="server" CssClass="GridRow" Text='<%# Eval("year", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>

                                    </MasterTableView>
                                </telerik:RadGrid>
                            </ContentTemplate>
                        </telerik:RadDock>

                        <telerik:RadDock RenderMode="Lightweight" ID="RadDockJobs" runat="server" Title="<a class='lnkGrid' href='Jobs' title='Go to Jobs List'>Jobs</a>" EnableAnimation="true"
                            EnableRoundedCorners="true" CommandsAutoPostBack="false">
                            <ContentTemplate>
                                <telerik:RadGrid ID="RadGridJobs" runat="server" DataSourceID="SqlDataSourceJobs" Width="100%" AutoGenerateColumns="False">
                                    <MasterTableView DataSourceID="SqlDataSourceJobs" Width="100%">
                                        <ItemStyle CssClass="GridRow" />
                                        <AlternatingItemStyle CssClass="GridRow" />
                                        <Columns>
                                            <telerik:GridTemplateColumn DataField="CONCEPT" UniqueName="CONCEPT" ItemStyle-Width="290px" ItemStyle-CssClass="CONCEPT">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel08" runat="server" CssClass="GridRow" Text='<%# Eval("CONCEPT")%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-4" UniqueName="year-4" HeaderText="year-4" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel18" runat="server" CssClass="GridRow" Text='<%# Eval("year-4", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-4"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-3" UniqueName="year-3" HeaderText="year-3" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel28" runat="server" CssClass="GridRow" Text='<%# Eval("year-3", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-3"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-2" UniqueName="year-2" HeaderText="year-2" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel38" runat="server" CssClass="GridRow" Text='<%# Eval("year-2", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-2"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-1" UniqueName="year-1" HeaderText="year-1" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel48" runat="server" CssClass="GridRow" Text='<%# Eval("year-1", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-1"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year" UniqueName="year" HeaderText="year" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel58" runat="server" CssClass="GridRow" Text='<%# Eval("year", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>

                                    </MasterTableView>
                                </telerik:RadGrid>
                            </ContentTemplate>
                        </telerik:RadDock>

                        <telerik:RadDock RenderMode="Lightweight" ID="RadDockEmployeeStatistics" runat="server" Title="<a class='lnkGrid' href='TimesByPeriords' title='Go to Times By Periords'>Employee Statistics</a>" EnableAnimation="true"
                            EnableRoundedCorners="true" CommandsAutoPostBack="false">
                            <ContentTemplate>
                                <telerik:RadGrid ID="RadGridEmployeeStatistics" runat="server" DataSourceID="SqlDataSourceProposalEmployeeStatistics" Width="100%" AutoGenerateColumns="False" pag
                                    PageSize="10" AllowPaging="true">
                                    <MasterTableView DataSourceID="SqlDataSourceProposalEmployeeStatistics" Width="100%">
                                        <Columns>
                                            <telerik:GridTemplateColumn DataField="Name" UniqueName="Name" HeaderStyle-Width="290px" ItemStyle-CssClass="CONCEPT">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel07" runat="server" CssClass="GridRow" Text='<%# Eval("Name")%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="Workload" UniqueName="Workload" HeaderText="Workload" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" HeaderTooltip="# Hours assigned to active projects">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel172" runat="server" CssClass="GridRow" Text='<%# Eval("Workload", "{0:N0}")%>' ForeColor='<%# LocalAPI.DegradadoDeColorWorkload(Eval("Workload"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="EfficiencyAsPM" UniqueName="EfficiencyAsPM" HeaderText="Efficiency As PM" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" HeaderTooltip="Efficiency As Project Manager">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel173" runat="server" CssClass="GridRow" Text='<%# Eval("EfficiencyAsPM", "{0:N0}")%>' ForeColor='<%# LocalAPI.DegradadoDeEfficiency(Eval("EfficiencyAsPM"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="EfficiencyAsTM" UniqueName="EfficiencyAsTM" HeaderText="Efficiency As TM" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" HeaderTooltip="Efficiency As Team Member">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel174" runat="server" CssClass="GridRow" Text='<%# Eval("EfficiencyAsTM", "{0:N0}")%>' ForeColor='<%# LocalAPI.DegradadoDeEfficiency(Eval("EfficiencyAsTM"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="WeeklyHours" UniqueName="WeeklyHours" HeaderText="WeeklyHours" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" HeaderTooltip="Weekly Timesheet Hours">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel175" runat="server" CssClass="GridRow" Text='<%# Eval("WeeklyHours", "{0:N0}")%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="RemainingWeekDays" UniqueName="RemainingWeekDays" HeaderText="RemainingWeekDays" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" HeaderTooltip="Remaining Timesheet Week Days">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel17" runat="server" CssClass="GridRow" Text='<%# Eval("RemainingWeekDays", "{0:N0}")%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>

                                    </MasterTableView>
                                </telerik:RadGrid>
                            </ContentTemplate>
                        </telerik:RadDock>

                        <telerik:RadDock RenderMode="Lightweight" ID="RadDockClients" runat="server" Title="<a class='lnkGrid' href='Clients' title='Go to Clients List'>Clients</a>" EnableAnimation="true"
                            EnableRoundedCorners="true" CommandsAutoPostBack="false">
                            <ContentTemplate>
                                <telerik:RadGrid ID="RadGridClients" runat="server" DataSourceID="SqlDataSourceClients" Width="100%" AutoGenerateColumns="False">
                                    <MasterTableView DataSourceID="SqlDataSourceClients" Width="100%">
                                        <ItemStyle CssClass="GridRow" />
                                        <AlternatingItemStyle CssClass="GridRow" />
                                        <Columns>
                                            <telerik:GridTemplateColumn DataField="CONCEPT" UniqueName="CONCEPT" ItemStyle-Width="290px" ItemStyle-CssClass="CONCEPT">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel09" runat="server" CssClass="GridRow" Text='<%# Eval("CONCEPT")%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-4" UniqueName="year-4" HeaderText="year-4" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel19" runat="server" CssClass="GridRow" Text='<%# Eval("year-4", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-4"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-3" UniqueName="year-3" HeaderText="year-3" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel29" runat="server" CssClass="GridRow" Text='<%# Eval("year-3", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-3"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-2" UniqueName="year-2" HeaderText="year-2" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel39" runat="server" CssClass="GridRow" Text='<%# Eval("year-2", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-2"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-1" UniqueName="year-1" HeaderText="year-1" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel49" runat="server" CssClass="GridRow" Text='<%# Eval("year-1", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-1"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year" UniqueName="year" HeaderText="year" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel59" runat="server" CssClass="GridRow" Text='<%# Eval("year", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>

                                    </MasterTableView>
                                </telerik:RadGrid>
                            </ContentTemplate>
                        </telerik:RadDock>
                        <telerik:RadDock RenderMode="Lightweight" ID="RadDockSubconsultants" runat="server" Title="<a class='lnkGrid' href='SubConsultans' title='Go to SubConsultants List'>Subconsultants  / </a><a class='lnkGrid' href='RequestForProposals' title='Go to Jobs List'>Request for Proposals</a>" EnableAnimation="true"
                            EnableRoundedCorners="true" CommandsAutoPostBack="false">
                            <ContentTemplate>
                                <telerik:RadGrid ID="RadGridSubConsultants" runat="server" DataSourceID="SqlDataSourceSubConsultants" Width="100%" AutoGenerateColumns="False">
                                    <MasterTableView DataSourceID="SqlDataSourceSubConsultants" Width="100%">
                                        <ItemStyle CssClass="GridRow" />
                                        <AlternatingItemStyle CssClass="GridRow" />
                                        <Columns>
                                            <telerik:GridTemplateColumn DataField="CONCEPT" UniqueName="CONCEPT" ItemStyle-Width="290px" ItemStyle-CssClass="CONCEPT">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel00" runat="server" CssClass="GridRow" Text='<%# Eval("CONCEPT")%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-4" UniqueName="year-4" HeaderText="year-4" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel11" runat="server" CssClass="GridRow" Text='<%# Eval("year-4", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-4"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-3" UniqueName="year-3" HeaderText="year-3" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel22" runat="server" CssClass="GridRow" Text='<%# Eval("year-3", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-3"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-2" UniqueName="year-2" HeaderText="year-2" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel33" runat="server" CssClass="GridRow" Text='<%# Eval("year-2", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-2"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year-1" UniqueName="year-1" HeaderText="year-1" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="NameLabel44" runat="server" CssClass="GridRow" Text='<%# Eval("year-1", Eval("FormatString"))%>' Font-Bold='<%# Eval("IsRate") %>' ForeColor='<%# LocalAPI.DegradadoDeColorInverso(Eval("year-1"), Eval("IsRate"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="year" UniqueName="year" HeaderText="year" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
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

    <asp:Panel runat="server" ID="panelEmployeePortal" Visible="false">

        <span class="label label-default center-block">
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
                                                                        <span class="glyphicon glyphicon-time"></span>&nbsp;Go to Employee Portal
        </asp:LinkButton>
    </asp:Panel>

    <telerik:RadWindowManager ID="RadWindowManagerJob" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <asp:SqlDataSource ID="SqlDataSourceProposalJobs" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="YearStadistic_PROPOSALS_JOBS" SelectCommandType="StoredProcedure">
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
        SelectCommand="EmployeeStatistics_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourcePropJobsBudgetsRate" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="YearStadistic_PROPOSALS_JOBS_BUDGETS_RATE" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceJobsInProgressByEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JobsInProgressByEmployee_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="Employee" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:TextBox ID="lblUserEmail" runat="server" Visible="False"></asp:TextBox>

</asp:Content>
