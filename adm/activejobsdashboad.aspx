<%@ Page Title="Time Activity" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="activejobsdashboad.aspx.vb" Inherits="pasconcept20.activejobsdashboad" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadListView1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadListView1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridFooter" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadListView1" />
                    <telerik:AjaxUpdatedControl ControlID="RadListView2" />
                    <telerik:AjaxUpdatedControl ControlID="RadListView3" />
                    <telerik:AjaxUpdatedControl ControlID="RadListViewProposal1" />
                    <telerik:AjaxUpdatedControl ControlID="RadListViewProposal2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cboEmployee">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridFooter" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadListView1" />
                    <telerik:AjaxUpdatedControl ControlID="RadListView2" />
                    <telerik:AjaxUpdatedControl ControlID="RadListView3" />
                    <telerik:AjaxUpdatedControl ControlID="RadListViewProposal1" />
                    <telerik:AjaxUpdatedControl ControlID="RadListViewProposal2" />

                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="btnNewMiscellaneousTime">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipMiscellaneous" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>


        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" EnableEmbeddedSkins="false" />

    <style>
        .panel-heading {
            padding: 10px 15px;
            padding-bottom: 5px;
            padding-top: 5px;
        }

        .panel {
            margin-bottom: 10px;
        }

        .panel-body {
            padding: 5px;
            padding-left: 10px;
        }

        .card-body {
            padding: 0.25rem;
        }

        .card-header {
            padding: 0 .50rem;
        }
    </style>
    <link rel="manifest" href="../manifest.json" />
    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <script type="text/javascript">  
          <%--  function OnClientClose(sender, args) {
                var masterTable2 = $find("<%= RadListViewFooter.ClientID %>").get_masterTableView();
                masterTable2.rebind();
            }--%>
            <%--function OnClientClose(sender, args) {
                var masterTable = $find("<%= RadGridFooter.ClientID %>").get_masterTableView();
                masterTable.rebind();


            }--%>

        </script>
    </telerik:RadCodeBlock>

    <%--Tools--%>
    <div class="pasconcept-bar noprint">

        <span class="pasconcept-pagetitle">Time Activity</span>

        <span style="float: right; vertical-align: middle;">
            <telerik:RadComboBox ID="cboEmployee" runat="server" DataSourceID="SqlDataSourceEmpl_activos" MarkFirstMatch="True" ToolTip="Select active Employye"
                Width="300px" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" AutoPostBack="true">
            </telerik:RadComboBox>

            <span style="padding-right: 150px">
                <telerik:RadComboBox ID="cboJobs" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceActiveJob" AutoPostBack="true"
                    DataTextField="Code" DataValueField="Id"
                    Width="400px" MarkFirstMatch="True" Filter="Contains" Height="400px">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Selected="True" Text="(Other Active Jobs...)" Value="-1" />
                    </Items>
                </telerik:RadComboBox>
                <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-info btn" UseSubmitBehavior="false">
                    <i class="fas fa-plus"></i> Job to Employee
                </asp:LinkButton>
            </span>

            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
           
            </button>
            <button class="btn btn-danger" type="button" data-toggle="collapse" data-target="#collapseChart" aria-expanded="false" aria-controls="collapseChart" title="Show/Hide Chart panel">
                <i class="fas fa-chart-bar"></i>&nbsp;Chart
           
            </button>

            <asp:LinkButton ID="btnNewMiscellaneousTime" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" ToolTip="Add Non-Productive Time">
                    Add Non-Productive Time
            </asp:LinkButton>
        </span>

    </div>

    <%--Filter--%>
    <div class="collapse" id="collapseFilter">

        <asp:Panel ID="pnlFind" runat="server" class="pasconcept-bar" DefaultButton="btnRefresh">
            <table class="table-sm" style="width: 100%">
                <tr>
                    <td>
                        <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech"
                            EmptyMessage="Search for Code, Job Name, Client Name ..."
                            Width="100%">
                        </telerik:RadTextBox>
                    </td>
                    <td style="width: 150px; text-align: right">
                        <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>

                    </td>
                </tr>
            </table>
        </asp:Panel>

    </div>

    <%--Chart--%>
    <div class="collapse pasconcept-bar" id="collapseChart">
        <table class="table-sm" style="width: 100%">
            <tr>
                <td style="width: 50%">
                    <h4 style="text-align: center; margin: 0">Time Sheet Daily</h4>
                    <telerik:RadHtmlChart ID="RadHtmlChartTimeSheet" runat="server" DataSourceID="SqlDataSourceTimeSheet" Width="100%">
                        <PlotArea>
                            <Series>
                                <telerik:ColumnSeries DataFieldY="WorkHours" Name="Productive Time" GroupName="Date">
                                    <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                    </LabelsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="DarkGreen" />
                                    </Appearance>
                                </telerik:ColumnSeries>
                                <telerik:ColumnSeries DataFieldY="NonWorkHours" Name="Productive Time" GroupName="Date">
                                    <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                    </LabelsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="OrangeRed" />
                                    </Appearance>
                                </telerik:ColumnSeries>
                                <telerik:ColumnSeries DataFieldY="Hollidays" Name="Holliday" GroupName="Date">
                                    <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                    </LabelsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="Blue" />
                                    </Appearance>
                                </telerik:ColumnSeries>
                            </Series>
                            <YAxis Name="LeftAxis" Step="2">
                                <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                <MinorGridLines Visible="false"></MinorGridLines>
                            </YAxis>
                            <XAxis DataLabelsField="Date" Type="Date" BaseUnit="Days">
                                <MinorGridLines Visible="false"></MinorGridLines>
                                <LabelsAppearance RotationAngle="315" DataFormatString="{0:MM/dd}">
                                    <TextStyle FontSize="10" />
                                </LabelsAppearance>
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
                <td>
                    <h4 style="text-align: center; margin: 0">Time Used in 'In Progress' Jobs</h4>
                    <telerik:RadHtmlChart ID="RadHtmlChartTimeUsed" runat="server" DataSourceID="SqlDataSourceTimeUsed" Width="100%">
                        <PlotArea>
                            <Series>
                                <telerik:ColumnSeries DataFieldY="RegularUsedHours" Name="Used Hours" GroupName="Job">
                                    <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                    </LabelsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="Orange" />
                                    </Appearance>
                                    <TooltipsAppearance>
                                        <ClientTemplate>
                                                #=dataItem.Job#,&nbsp;Used:&nbsp;#=dataItem.RegularUsedHours#&nbsp;Hours
                                        </ClientTemplate>
                                    </TooltipsAppearance>
                                </telerik:ColumnSeries>
                                <telerik:ColumnSeries DataFieldY="PendingHours" Name="Pending Hours" GroupName="Job">
                                    <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                    </LabelsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="YellowGreen" />
                                    </Appearance>
                                    <TooltipsAppearance>
                                        <ClientTemplate>
                                                #=dataItem.Job#,&nbsp;Pending:&nbsp;#=dataItem.PendingHours#&nbsp;Hours
                                        </ClientTemplate>
                                    </TooltipsAppearance>
                                </telerik:ColumnSeries>
                                <telerik:ColumnSeries DataFieldY="ExtraUsedHours" Name="Extra Hours" GroupName="Job">
                                    <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                    </LabelsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="Red" />
                                    </Appearance>
                                    <TooltipsAppearance>
                                        <ClientTemplate>
                                                #=dataItem.Job#,&nbsp;Extra Hours:&nbsp;#=dataItem.ExtraUsedHours#&nbsp;Hours
                                        </ClientTemplate>
                                    </TooltipsAppearance>
                                </telerik:ColumnSeries>
                            </Series>
                            <YAxis Name="LeftAxis">
                                <TitleAppearance></TitleAppearance>
                                <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                <MinorGridLines Visible="false"></MinorGridLines>
                            </YAxis>
                            <XAxis DataLabelsField="Code">
                                <TitleAppearance></TitleAppearance>
                                <MinorGridLines Visible="false"></MinorGridLines>
                                <LabelsAppearance RotationAngle="315">
                                    <TextStyle FontSize="10" />
                                </LabelsAppearance>
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
        </table>
    </div>

    <%--Body--%>
    <div class="pasconcept-bar" style="margin-top: 5px">
        <div style="margin-top: 5px;">
            <telerik:RadGrid ID="RadGridFooter" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceDateWORKHOURS" Width="100%" BorderStyle="None"
                ShowHeader="false" ShowFooter="false" RenderMode="Lightweight">
                <MasterTableView DataSourceID="SqlDataSourceDateWORKHOURS" ShowFooter="false" CommandItemDisplay="None" BorderStyle="None">
                    <Columns>
                        <telerik:GridTemplateColumn UniqueName="Column1" ItemStyle-Font-Size="Small">
                            <ItemTemplate>
                                <div>
                                    <table class="table-sm" style="width: 100%; text-align: center">
                                        <tr>
                                            <td style='<%# GetDateOfWeekStyle(Eval("Date14"))%>'>
                                                <%# String.Concat(Eval("weekOFday14"), ":", Eval("Date14", "{0:d}")) %>
                                            </td>
                                            <td style='<%# GetDateOfWeekStyle(Eval("Date13"))%>'>
                                                <%# String.Concat(Eval("weekOFday13"), ":", Eval("Date13", "{0:d}")) %>
                                            </td>
                                            <td style='<%# GetDateOfWeekStyle(Eval("Date12"))%>'>
                                                <%# String.Concat(Eval("weekOFday12"), ":", Eval("Date12", "{0:d}")) %>
                                            </td>
                                            <td style='<%# GetDateOfWeekStyle(Eval("Date11"))%>'>
                                                <%# String.Concat(Eval("weekOFday11"), ":", Eval("Date11", "{0:d}")) %>
                                            </td>
                                            <td style='<%# GetDateOfWeekStyle(Eval("Date10"))%>'>
                                                <%# String.Concat(Eval("weekOFday10"), ":", Eval("Date10", "{0:d}")) %>
                                            </td>


                                            <td style='<%# GetDateOfWeekStyle(Eval("Date9"))%>'>
                                                <%# String.Concat(Eval("weekOFday9"), ":", Eval("Date9", "{0:d}")) %>
                                            </td>
                                            <td style='<%# GetDateOfWeekStyle(Eval("Date8"))%>'>
                                                <%# String.Concat(Eval("weekOFday8"), ":", Eval("Date8", "{0:d}")) %>
                                            </td>
                                            <td style='<%# GetDateOfWeekStyle(Eval("Date7"))%>'>
                                                <%# String.Concat(Eval("weekOFday7"), ":", Eval("Date7", "{0:d}")) %>
                                            </td>
                                            <td style='<%# GetDateOfWeekStyle(Eval("Date6"))%>'>
                                                <%# String.Concat(Eval("weekOFday6"), ":", Eval("Date6", "{0:d}")) %>
                                            </td>
                                            <td style='<%# GetDateOfWeekStyle(Eval("Date5"))%>'>
                                                <%# String.Concat(Eval("weekOFday5"), ":", Eval("Date5", "{0:d}")) %>
                                            </td>
                                            <td style='<%# GetDateOfWeekStyle(Eval("Date4"))%>'>
                                                <%# String.Concat(Eval("weekOFday4"), ":", Eval("Date4", "{0:d}")) %>
                                            </td>
                                            <td style='<%# GetDateOfWeekStyle(Eval("Date3"))%>'>
                                                <%# String.Concat(Eval("weekOFday3"), ":", Eval("Date3", "{0:d}")) %>
                                            </td>
                                            <td style='<%# GetDateOfWeekStyle(Eval("Date2"))%>'>
                                                <%# String.Concat(Eval("weekOFday2"), ":", Eval("Date2", "{0:d}")) %>
                                            </td>
                                            <td style='<%# GetDateOfWeekStyle(Eval("Date1"))%>'>
                                                <%# String.Concat(Eval("weekOFday1"), ":", Eval("Date1", "{0:d}")) %>
                                            </td>
                                        </tr>
                                        <tr>


                                            <td>
                                                <div class="progress" style="margin-bottom: 0;">
                                                    <div class="progress-bar" role="progressbar" aria-valuenow='<%# Eval("HoursPercentage14")  %>' aria-valuemin="0" aria-valuemax="100"
                                                        style='width: <%# Eval("HoursPercentage14") %>%; font-size: small!important'>
                                                        <%# Eval("Hours14")%> hrs
                                               
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="progress" style="margin-bottom: 0;">
                                                    <div class="progress-bar" role="progressbar" aria-valuenow='<%# Eval("HoursPercentage13")  %>' aria-valuemin="0" aria-valuemax="100"
                                                        style='width: <%# Eval("HoursPercentage13") %>%; font-size: small!important'>
                                                        <%# Eval("Hours13")%> hrs
                                               
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="progress" style="margin-bottom: 0;">
                                                    <div class="progress-bar" role="progressbar" aria-valuenow='<%# Eval("HoursPercentage12")  %>' aria-valuemin="0" aria-valuemax="100"
                                                        style='width: <%# Eval("HoursPercentage12") %>%; font-size: small!important'>
                                                        <%# Eval("Hours11")%> hrs
                                               
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="progress" style="margin-bottom: 0;">
                                                    <div class="progress-bar" role="progressbar" aria-valuenow='<%# Eval("HoursPercentage11")  %>' aria-valuemin="0" aria-valuemax="100"
                                                        style='width: <%# Eval("HoursPercentage11") %>%; font-size: small!important'>
                                                        <%# Eval("Hours11")%> hrs
                                               
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="progress" style="margin-bottom: 0;">
                                                    <div class="progress-bar" role="progressbar" aria-valuenow='<%# Eval("HoursPercentage10")  %>' aria-valuemin="0" aria-valuemax="100"
                                                        style='width: <%# Eval("HoursPercentage10") %>%; font-size: small!important'>
                                                        <%# Eval("Hours10")%> hrs
                                               
                                                    </div>
                                                </div>
                                            </td>


                                            <td>
                                                <div class="progress" style="margin-bottom: 0;">
                                                    <div class="progress-bar" role="progressbar" aria-valuenow='<%# Eval("HoursPercentage9")  %>' aria-valuemin="0" aria-valuemax="100"
                                                        style='width: <%# Eval("HoursPercentage9") %>%; font-size: small!important'>
                                                        <%# Eval("Hours9")%> hrs
                                               
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="progress" style="margin-bottom: 0;">
                                                    <div class="progress-bar" role="progressbar" aria-valuenow='<%# Eval("HoursPercentage8")  %>' aria-valuemin="0" aria-valuemax="100"
                                                        style='width: <%# Eval("HoursPercentage8") %>%; font-size: small!important'>
                                                        <%# Eval("Hours8")%> hrs
                                               
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="progress" style="margin-bottom: 0;">
                                                    <div class="progress-bar" role="progressbar" aria-valuenow='<%# Eval("HoursPercentage7")  %>' aria-valuemin="0" aria-valuemax="100"
                                                        style='width: <%# Eval("HoursPercentage7") %>%; font-size: small!important'>
                                                        <%# Eval("Hours7")%> hrs
                                               
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="progress" style="margin-bottom: 0;">
                                                    <div class="progress-bar" role="progressbar" aria-valuenow='<%# Eval("HoursPercentage6")  %>' aria-valuemin="0" aria-valuemax="100"
                                                        style='width: <%# Eval("HoursPercentage6") %>%; font-size: small!important'>
                                                        <%# Eval("Hours6")%> hrs
                                               
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="progress" style="margin-bottom: 0;">
                                                    <div class="progress-bar" role="progressbar" aria-valuenow='<%# Eval("HoursPercentage5")  %>' aria-valuemin="0" aria-valuemax="100"
                                                        style='width: <%# Eval("HoursPercentage5") %>%; font-size: small!important'>
                                                        <%# Eval("Hours5")%> hrs
                                               
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="progress" style="margin-bottom: 0;">
                                                    <div class="progress-bar" role="progressbar" aria-valuenow='<%# Eval("HoursPercentage4")  %>' aria-valuemin="0" aria-valuemax="100"
                                                        style='width: <%# Eval("HoursPercentage4") %>%; font-size: small!important'>
                                                        <%# Eval("Hours4")%> hrs
                                               
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="progress" style="margin-bottom: 0;">
                                                    <div class="progress-bar" role="progressbar" aria-valuenow='<%# Eval("HoursPercentage3")  %>' aria-valuemin="0" aria-valuemax="100"
                                                        style='width: <%# Eval("HoursPercentage3") %>%; font-size: small!important'>
                                                        <%# Eval("Hours3")%> hrs
                                               
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="progress" style="margin-bottom: 0;">
                                                    <div class="progress-bar" role="progressbar" aria-valuenow='<%# Eval("HoursPercentage2")  %>' aria-valuemin="0" aria-valuemax="100"
                                                        style='width: <%# Eval("HoursPercentage2") %>%; font-size: small!important'>
                                                        <%# Eval("Hours2")%> hrs
                                               
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="progress" style="margin-bottom: 0;">
                                                    <div class="progress-bar" role="progressbar" aria-valuenow='<%# Eval("HoursPercentage1")  %>' aria-valuemin="0" aria-valuemax="100"
                                                        style='width: <%# Eval("HoursPercentage1") %>%; font-size: small!important'>
                                                        <%# Eval("Hours1")%> hrs
                                               
                                                    </div>
                                                </div>
                                            </td>

                                        </tr>
                                    </table>
                                </div>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>

        <telerik:RadWizard ID="RadWizard1" runat="server" Height="800px" DisplayCancelButton="false" DisplayNavigationButtons="false" DisplayProgressBar="false" RenderMode="Lightweight" Skin="Material">
            <WizardSteps>
                <telerik:RadWizardStep runat="server" ID="RadWizardStepJobs" Title="Jobs" StepType="Start">
                    <%--Job Lists--%>
                    <table class="table-sm" style="width: 100%; text-align: center; margin-top: 10px">
                        <tr>
                            <td style="width: 17%; text-align: center; vertical-align: top;">
                                <div style="width: 100%; background-color: #f5f5f5">
                                    <h4>Not in Progress</h4>
                                </div>
                                <div style="text-align: center;">
                                    <telerik:RadListView ID="RadListView1" runat="server" DataSourceID="SqlDataSourceJobsNotInProgress" DataKeyNames="Id" ItemPlaceholderID="Container1" BorderStyle="Solid">
                                        <LayoutTemplate>
                                            <fieldset style="width: 100%; text-align: center">
                                                <asp:PlaceHolder ID="Container1" runat="server"></asp:PlaceHolder>
                                            </fieldset>

                                        </LayoutTemplate>
                                        <ItemTemplate>

                                            <div class="card" style="float: left; width: 270px; margin: 1px">
                                                <div class="card-header">
                                                    <table class="table-sm" style="width: 100%">
                                                        <tr>
                                                            <td style="text-align: left">
                                                                <h4 style="margin: 0"><%# Eval("Code")%></h4>
                                                            </td>
                                                            <td style="width: 32px; text-align: right; font-size: 24px;">
                                                                <asp:LinkButton ID="btnNewTime" runat="server" UseSubmitBehavior="false" ToolTip='<%# Eval("itemNameFull")%>'
                                                                    CommandName="AddNewTime" CommandArgument='<%# Eval("Id")%>'>
                                                                        <i title="Add Productive Time" class="fas fa-user-clock" style='<%# LocalAPI.GetJobStatusColorCSS(Eval("statusId")) %>'></i>
                                                                </asp:LinkButton>
                                                            </td>
                                                            <td style="width: 40px; text-align: right">
                                                                <a class="far fa-share-square" style="font-size: 24px; color: black" title="Click to View Job" href='<%#String.Concat("../e2103445_8a47_49ff_808e_6008c0fe13a1/job.aspx?guid=", Eval("guid")) %>' target="_blank" aria-hidden="true"></a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div class="card-body" style="text-align: center">
                                                    <asp:LinkButton ID="btnNewTime2" runat="server" UseSubmitBehavior="false" CommandName="AddNewTime" CommandArgument='<%# Eval("Id")%>' ForeColor="Black" Font-Underline="false">
                                                        <p style="width: 100%; text-align: center; margin: 0; flex-wrap: nowrap; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;">
                                                            <b><%# Eval("itemName")%></b><br />
                                                            <%# Eval("ClientCompany")%><br />
                                                            <%# Eval("ClientName")%><br />
                                                            PM: <%# Eval("PM")%>
                                                        </p>
                                                        <table style="width: 100%">
                                                            <tr>
                                                                <td style="width: 100px; text-align: right">
                                                                    <%# Eval("HoursUsed", "{0:N1}")%>/<%# Eval("HoursAssigned", "{0:N0}")%>
                                                                </td>
                                                                <td>
                                                                    <telerik:RadProgressBar ID="RadProgressBar1" runat="server"
                                                                        RenderMode="Lightweight"
                                                                        Height="18px" ShowLabel="false"
                                                                        BarType="Value"
                                                                        Skin="Material"
                                                                        MaxValue='<%# Eval("HoursAssigned")%>'
                                                                        Value='<%# Eval("HoursUsed")%>'
                                                                        Width="100%"
                                                                        CssClass='<%# LocalAPI.GetBudgetUsedCss(Eval("HourUsedPercent"))%>'>
                                                                        <AnimationSettings Duration="0" />
                                                                    </telerik:RadProgressBar>

                                                                </td>
                                                                <td style="width: 100px; text-align: left">
                                                                    <%# Eval("HourUsedPercent", "{0:N0}")%> %
                                                                </td>

                                                            </tr>
                                                        </table>
                                                    </asp:LinkButton>

                                                </div>
                                            </div>

                                        </ItemTemplate>

                                    </telerik:RadListView>
                                </div>
                            </td>
                            <td style="width: 50%; text-align: center; vertical-align: top">
                                <div style="width: 100%; background-color: #e2f4e2">
                                    <h4>In Progress</h4>
                                </div>
                                <div style="text-align: center;">
                                    <telerik:RadListView ID="RadListView2" runat="server" DataSourceID="SqlDataSourceJobsInProgress" DataKeyNames="Id" ItemPlaceholderID="Container1" BorderStyle="Solid">
                                        <LayoutTemplate>
                                            <fieldset style="width: 100%; text-align: center">
                                                <asp:PlaceHolder ID="Container1" runat="server"></asp:PlaceHolder>
                                            </fieldset>

                                        </LayoutTemplate>
                                        <ItemTemplate>

                                            <div class="card" style="float: left; width: 270px; margin: 1px">
                                                <div class="card-header">
                                                    <table class="table-sm" style="width: 100%">
                                                        <tr>
                                                            <td style="text-align: left">
                                                                <h4 style="margin: 0"><%# Eval("Code")%></h4>
                                                            </td>
                                                            <td style="width: 32px; text-align: right; font-size: 24px;">
                                                                <asp:LinkButton ID="btnNewTime" runat="server" UseSubmitBehavior="false" ToolTip='<%# Eval("itemNameFull")%>' CommandName="AddNewTime" CommandArgument='<%# Eval("Id")%>'>
                                                                    <i title="Add Productive Time" class="fas fa-user-clock" style='<%# LocalAPI.GetJobStatusColorCSS(Eval("statusId")) %>'></i>
                                                                </asp:LinkButton>
                                                            </td>
                                                            <td style="width: 40px; text-align: right">
                                                                <a class="far fa-share-square" style="font-size: 24px; color: black" title="Click to View Job" href='<%#String.Concat("../e2103445_8a47_49ff_808e_6008c0fe13a1/job.aspx?guid=", Eval("guid")) %>' target="_blank" aria-hidden="true"></a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div class="card-body" style="text-align: center">
                                                    <asp:LinkButton ID="btnNewTime2" runat="server" UseSubmitBehavior="false" CommandName="AddNewTime" CommandArgument='<%# Eval("Id")%>' ForeColor="Black" Font-Underline="false">
                                                        <p style="width: 100%; text-align: center; margin: 0; flex-wrap: nowrap; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;">
                                                            <b><%# Eval("itemName")%></b><br />
                                                            <%# Eval("ClientCompany")%><br />
                                                            <%# Eval("ClientName")%><br />
                                                            PM: <%# Eval("PM")%>
                                                        </p>
                                                        <table style="width: 100%">
                                                            <tr>
                                                                <td style="width: 100px; text-align: right">
                                                                    <%# Eval("HoursUsed", "{0:N1}")%>/<%# Eval("HoursAssigned", "{0:N0}")%>
                                                                </td>
                                                                <td>
                                                                    <telerik:RadProgressBar ID="RadProgressBar1" runat="server"
                                                                        RenderMode="Lightweight"
                                                                        Height="18px" ShowLabel="false"
                                                                        BarType="Value"
                                                                        Skin="Material"
                                                                        MaxValue='<%# Eval("HoursAssigned")%>'
                                                                        Value='<%# Eval("HoursUsed")%>'
                                                                        Width="100%"
                                                                        CssClass='<%# LocalAPI.GetBudgetUsedCss(Eval("HourUsedPercent"))%>'>
                                                                        <AnimationSettings Duration="0" />
                                                                    </telerik:RadProgressBar>

                                                                </td>
                                                                <td style="width: 100px; text-align: left">
                                                                    <%# Eval("HourUsedPercent", "{0:N0}")%> %
                                                                </td>

                                                            </tr>
                                                        </table>
                                                    </asp:LinkButton>

                                                </div>
                                            </div>

                                        </ItemTemplate>

                                    </telerik:RadListView>
                                </div>

                            </td>
                            <td style="text-align: center; vertical-align: top">
                                <div style="width: 100%; background-color: #f5e3c4">
                                    <h4>On Hold, Done, Submitted, Under Revision</h4>
                                </div>
                                <div style="text-align: center;">
                                    <telerik:RadListView ID="RadListView3" runat="server" DataSourceID="SqlDataSourceJobsOthers" DataKeyNames="Id" ItemPlaceholderID="Container1" BorderStyle="Solid">
                                        <LayoutTemplate>
                                            <fieldset style="width: 100%; text-align: center">
                                                <asp:PlaceHolder ID="Container1" runat="server"></asp:PlaceHolder>
                                            </fieldset>

                                        </LayoutTemplate>
                                        <ItemTemplate>

                                            <div class="card" style="float: left; width: 270px; margin: 1px">
                                                <div class="card-header">
                                                    <table class="table-sm" style="width: 100%">
                                                        <tr>
                                                            <td style="text-align: left">
                                                                <h4 style="margin: 0"><%# Eval("Code")%></h4>
                                                            </td>
                                                            <td style="width: 32px; text-align: right; font-size: 24px;">
                                                                <asp:LinkButton ID="btnNewTime4" runat="server" UseSubmitBehavior="false" ToolTip='<%# Eval("itemNameFull")%>' CommandName="AddNewTime" CommandArgument='<%# Eval("Id")%>'>
                                                                    <i title="Add Productive Time" class="fas fa-user-clock" style='<%# LocalAPI.GetJobStatusColorCSS(Eval("statusId")) %>'></i>
                                                                </asp:LinkButton>
                                                            </td>
                                                            <td style="width: 40px; text-align: right">
                                                                <a class="far fa-share-square" style="font-size: 24px; color: black" title="Click to View Job" href='<%#String.Concat("../e2103445_8a47_49ff_808e_6008c0fe13a1/job.aspx?guid=", Eval("guid")) %>' target="_blank" aria-hidden="true"></a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div class="card-body" style="text-align: center">
                                                    <asp:LinkButton ID="btnNewTime5" runat="server" UseSubmitBehavior="false" CommandName="AddNewTime" CommandArgument='<%# Eval("Id")%>' ForeColor="Black" Font-Underline="false">
                                                        <p style="width: 100%; text-align: center; margin: 0; flex-wrap: nowrap; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;">
                                                            <b><%# Eval("itemName")%></b><br />
                                                            <%# Eval("ClientCompany")%><br />
                                                            <%# Eval("ClientName")%><br />
                                                            PM: <%# Eval("PM")%>
                                                        </p>
                                                        <table style="width: 100%">
                                                            <tr>
                                                                <td style="width: 100px; text-align: right">
                                                                    <%# Eval("HoursUsed", "{0:N1}")%>/<%# Eval("HoursAssigned", "{0:N0}")%>
                                                                </td>
                                                                <td>
                                                                    <telerik:RadProgressBar ID="RadProgressBar3" runat="server"
                                                                        RenderMode="Lightweight"
                                                                        Height="18px" ShowLabel="false"
                                                                        BarType="Value"
                                                                        Skin="Material"
                                                                        MaxValue='<%# Eval("HoursAssigned")%>'
                                                                        Value='<%# Eval("HoursUsed")%>'
                                                                        Width="100%"
                                                                        CssClass='<%# LocalAPI.GetBudgetUsedCss(Eval("HourUsedPercent"))%>'>
                                                                        <AnimationSettings Duration="0" />
                                                                    </telerik:RadProgressBar>

                                                                </td>
                                                                <td style="width: 100px; text-align: left">
                                                                    <%# Eval("HourUsedPercent", "{0:N0}")%> %
                                                                </td>

                                                            </tr>
                                                        </table>
                                                    </asp:LinkButton>

                                                </div>
                                            </div>

                                        </ItemTemplate>

                                    </telerik:RadListView>
                                </div>
                            </td>
                        </tr>
                    </table>

                </telerik:RadWizardStep>
                <telerik:RadWizardStep runat="server" ID="RadWizardStepProposals" Title="Proposals" StepType="Start">

                    <table class="table-sm" style="width: 100%; text-align: center; margin-top: 10px">
                        <tr>
                            <td style="width: 50%; text-align: center; vertical-align: top;">

                                <div style="width: 100%; background-color: #f5f5f5">
                                    <h4>Not Emitted</h4>
                                </div>
                                <div style="text-align: center;">
                                    <telerik:RadListView ID="RadListViewProposal1" runat="server" DataSourceID="SqlDataSourceProposalsNotEmitted" DataKeyNames="Id" ItemPlaceholderID="Container1" BorderStyle="Solid">
                                        <LayoutTemplate>
                                            <fieldset style="width: 100%; text-align: center">
                                                <asp:PlaceHolder ID="Container1" runat="server"></asp:PlaceHolder>
                                            </fieldset>

                                        </LayoutTemplate>
                                        <ItemTemplate>

                                            <div class="card" style="float: left; width: 270px; margin: 1px">
                                                <div class="card-header">
                                                    <table class="table-sm" style="width: 100%">
                                                        <tr>
                                                            <td style="text-align: left">
                                                                <h4 style="margin: 0"><%# Eval("Code")%></h4>
                                                            </td>
                                                            <td style="width: 32px; text-align: right; font-size: 24px;">
                                                                <asp:LinkButton ID="btnNewProposalTime" runat="server" UseSubmitBehavior="false" ToolTip='<%# Eval("itemNameFull")%>' CommandName="AddNewTime" CommandArgument='<%# Eval("Id")%>'>
                                                                        <i title="Add Non-Productive Time" class="fas fa-user-clock" style='<%# LocalAPI.GetProposalStatusColorCSS(Eval("statusId")) %>'></i>
                                                                </asp:LinkButton>
                                                            </td>
                                                            <td style="width: 40px; text-align: right">
                                                                <a class="far fa-share-square" style="font-size: 24px; color: black" title="Click to View Proposal" href='<%# LocalAPI.GetSharedLink_URL(111, Eval("Id"), False)%>' target="_blank" aria-hidden="true"></a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div class="card-body" style="text-align: center">
                                                    <asp:LinkButton ID="btnNewTime2" runat="server" UseSubmitBehavior="false" CommandName="AddNewTime" CommandArgument='<%# Eval("Id")%>' ForeColor="Black" Font-Underline="false">
                                                        <p style="width: 100%; text-align: center; margin: 0; flex-wrap: nowrap; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;">
                                                            <b><%# Eval("itemName")%></b><br />
                                                            <%# Eval("ClientCompany")%><br />
                                                            <%# Eval("ClientName")%><br />
                                                            PM: <%# Eval("PM")%>
                                                        </p>
                                                        <table style="width: 100%">
                                                            <tr>
                                                                <td style="width: 100px; text-align: right">
                                                                    <%# Eval("HoursUsed", "{0:N1}")%>/<%# Eval("HoursAssigned", "{0:N0}")%>
                                                                </td>
                                                                <td>
                                                                    <telerik:RadProgressBar ID="RadProgressBar1" runat="server"
                                                                        RenderMode="Lightweight"
                                                                        Height="18px" ShowLabel="false"
                                                                        BarType="Value"
                                                                        Skin="Material"
                                                                        MaxValue='<%# Eval("HoursAssigned")%>'
                                                                        Value='<%# Eval("HoursUsed")%>'
                                                                        Width="100%"
                                                                        CssClass='<%# LocalAPI.GetBudgetUsedCss(Eval("HourUsedPercent"))%>'>
                                                                        <AnimationSettings Duration="0" />
                                                                    </telerik:RadProgressBar>

                                                                </td>
                                                                <td style="width: 100px; text-align: left">
                                                                    <%# Eval("HourUsedPercent", "{0:N0}")%> %
                                                                </td>

                                                            </tr>
                                                        </table>
                                                    </asp:LinkButton>
                                                </div>
                                            </div>

                                        </ItemTemplate>

                                    </telerik:RadListView>
                                </div>


                            </td>
                            <td style="text-align: center; vertical-align: top">
                                <div style="width: 100%; background-color: #f5e3c4">
                                    <h4>Pending</h4>
                                </div>
                                <div style="text-align: center">
                                    <telerik:RadListView ID="RadListViewProposal2" runat="server" DataSourceID="SqlDataSourceProposalsPending" DataKeyNames="Id" ItemPlaceholderID="Container1" BorderStyle="Solid">
                                        <LayoutTemplate>
                                            <fieldset style="width: 100%; text-align: center">
                                                <asp:PlaceHolder ID="Container1" runat="server"></asp:PlaceHolder>
                                            </fieldset>

                                        </LayoutTemplate>
                                        <ItemTemplate>

                                            <div class="card" style="float: left; width: 270px; margin: 1px">
                                                <div class="card-header">
                                                    <table class="table-sm" style="width: 100%">
                                                        <tr>
                                                            <td style="text-align: left">
                                                                <h4 style="margin: 0"><%# Eval("Code")%></h4>
                                                            </td>
                                                            <td style="width: 32px; text-align: right; font-size: 24px;">
                                                                <asp:LinkButton ID="btnNewProposalTime" runat="server" UseSubmitBehavior="false" ToolTip='<%# Eval("itemNameFull")%>' CommandName="AddNewTime" CommandArgument='<%# Eval("Id")%>'>
                                                                        <i title="Add Non-Productive Time" class="fas fa-user-clock" style='<%# LocalAPI.GetProposalStatusColorCSS(Eval("statusId")) %>'></i>
                                                                </asp:LinkButton>
                                                            </td>
                                                            <td style="width: 40px; text-align: right">
                                                                <a class="far fa-share-square" style="font-size: 24px; color: black" title="Click to View Proposal" href='<%# LocalAPI.GetSharedLink_URL(111, Eval("Id"), False)%>' target="_blank" aria-hidden="true"></a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div class="card-body" style="text-align: center">
                                                    <asp:LinkButton ID="btnNewTime2" runat="server" UseSubmitBehavior="false" CommandName="AddNewTime" CommandArgument='<%# Eval("Id")%>' ForeColor="Black" Font-Underline="false">
                                                        <p style="width: 100%; text-align: center; margin: 0; flex-wrap: nowrap; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;">
                                                            <b><%# Eval("itemName")%></b><br />
                                                            <%# Eval("ClientCompany")%><br />
                                                            <%# Eval("ClientName")%><br />
                                                            PM: <%# Eval("PM")%>
                                                        </p>
                                                        <table style="width: 100%">
                                                            <tr>
                                                                <td style="width: 100px; text-align: right">
                                                                    <%# Eval("HoursUsed", "{0:N1}")%>/<%# Eval("HoursAssigned", "{0:N0}")%>
                                                                </td>
                                                                <td>
                                                                    <telerik:RadProgressBar ID="RadProgressBar1" runat="server"
                                                                        RenderMode="Lightweight"
                                                                        Height="18px" ShowLabel="false"
                                                                        BarType="Value"
                                                                        Skin="Material"
                                                                        MaxValue='<%# Eval("HoursAssigned")%>'
                                                                        Value='<%# Eval("HoursUsed")%>'
                                                                        Width="100%"
                                                                        CssClass='<%# LocalAPI.GetBudgetUsedCss(Eval("HourUsedPercent"))%>'>
                                                                        <AnimationSettings Duration="0" />
                                                                    </telerik:RadProgressBar>

                                                                </td>
                                                                <td style="width: 100px; text-align: left">
                                                                    <%# Eval("HourUsedPercent", "{0:N0}")%> %
                                                                </td>

                                                            </tr>
                                                        </table>
                                                    </asp:LinkButton>
                                                </div>
                                            </div>

                                        </ItemTemplate>

                                    </telerik:RadListView>
                                </div>

                            </td>
                        </tr>
                    </table>
                </telerik:RadWizardStep>
            </WizardSteps>
        </telerik:RadWizard>


    </div>

    <%--Legend--%>
    <asp:Panel runat="server" ID="PanelLegend">
        <div style="text-align: left">
            <b>Status Legend: </b>

            <span class='<%# LocalAPI.GetJobStatusLabelCSS(0) %>'>Not in Progress</span>

            <span class='<%# LocalAPI.GetJobStatusLabelCSS(2) %>'>In Progress</span>

            <span class='<%# LocalAPI.GetJobStatusLabelCSS(3) %>'>On Hold</span>

            <span class='<%# LocalAPI.GetJobStatusLabelCSS(4) %>'>Submitted</span>

            <span class='<%# LocalAPI.GetJobStatusLabelCSS(5) %>'>Under Revision</span>
        </div>
    </asp:Panel>
    <div>
        You have submitted <strong>
            <asp:Label ID="lblTotalWeekHours" Text="0" runat="server"></asp:Label></strong> hours this week. Remaining hours: 
                               
        <asp:Label ID="lblRemaining" Text="0" Font-Bold="true" runat="server"></asp:Label>
    </div>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>



    <asp:SqlDataSource ID="SqlDataSourceJobsNotInProgress" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Jobs_OfEmployee_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="cboEmployee" Name="Employee" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="StatusIdIN_List" DefaultValue="0" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Find" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceJobsInProgress" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Jobs_OfEmployee_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="cboEmployee" Name="Employee" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="StatusIdIN_List" DefaultValue="2" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Find" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceJobsOthers" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Jobs_OfEmployee_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="cboEmployee" Name="Employee" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="StatusIdIN_List" DefaultValue="3,4,5,7" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Find" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSourceActiveJob" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOBS_EMP_non_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboEmployee" Name="Employee" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="Status" DefaultValue="-1" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceDateWORKHOURS" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="WORKHOURS_Period_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboEmployee" Name="employeeId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTimeSheet" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOBS_ResultByTimeSheet" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboEmployee" Name="employeeId" PropertyName="SelectedValue" />
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTimeUsed" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOBS_ResultByTimeUsed" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboEmployee" Name="employeeId" PropertyName="SelectedValue" />
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmpl_activos" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, FullName as Name FROM Employees WHERE companyId=@companyId and isnull(Inactive,0)=0 ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSourceProposalsNotEmitted" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Proposals_OfEmployee_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="cboEmployee" Name="Employee" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="StatusIdIN_List" DefaultValue="0" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Find" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceProposalsPending" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Proposals_OfEmployee_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="cboEmployee" Name="Employee" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="StatusIdIN_List" DefaultValue="1" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Find" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:Label ID="lblLogedEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedJob" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblUserEmail" runat="server" Visible="False"></asp:Label>
</asp:Content>
