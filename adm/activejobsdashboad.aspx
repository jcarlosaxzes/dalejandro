﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="activejobsdashboad.aspx.vb" Inherits="pasconcept20.activejobsdashboad" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
            padding-left: 30px;

        }
    </style>
    <link rel="manifest" href="../manifest.json" />
    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <script type="text/javascript">  
          <%--  function OnClientClose(sender, args) {
                var masterTable2 = $find("<%= RadListViewFooter.ClientID %>").get_masterTableView();
                masterTable2.rebind();
            }--%>
            function OnClientClose(sender, args) {
                var masterTable = $find("<%= RadGridFooter.ClientID %>").get_masterTableView();
                masterTable.rebind();


            }

        </script>
    </telerik:RadCodeBlock>

    <%--Tools--%>
    <div class="Formulario">

        <table class="table-condensed">
            <tr>
                <td>
                    <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                        <span class="glyphicon glyphicon-filter"></span>&nbsp;Filter
                    </button>
                </td>
                <td>
                    <button class="btn btn-danger" type="button" data-toggle="collapse" data-target="#collapseChart" aria-expanded="false" aria-controls="collapseChart" title="Show/Hide Chart panel">
                        <span class="glyphicon glyphicon-stats"></span>&nbsp;Chart
                    </button>
                </td>
                <td style="text-align: right; width: 400px">
                    <telerik:RadComboBox ID="cboJobs" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceActiveJob" AutoPostBack="true"
                        DataTextField="Code" DataValueField="Id"
                        Width="100%" MarkFirstMatch="True" Filter="Contains" Height="400px">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Selected="True" Text="(Other Active Jobs...)" Value="-1" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td style="text-align: left">

                    <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-info btn" UseSubmitBehavior="false">
                    <span class="glyphicon glyphicon-plus"></span> Job to My List
                    </asp:LinkButton>
                </td>
                <td>
                    <asp:LinkButton ID="btnNewMiscellaneousTime" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" ToolTip="Miscellaneous Time">
                    <span class="glyphicon glyphicon-plus"></span> Miscellaneous Time
                    </asp:LinkButton>
                </td>
                <td style="text-align: right">You have submitted <strong>
                    <asp:Label ID="lblTotalWeekHours" Text="0" runat="server"></asp:Label></strong> hours this week. Remaining hours: 
                                <strong>
                                    <asp:Label ID="lblRemaining" Text="0" runat="server"></asp:Label></strong>
                </td>
            </tr>
        </table>

    </div>

    <%--Filter--%>
    <div class="collapse" id="collapseFilter">

        <asp:Panel ID="pnlFind" runat="server" class="Formulario" DefaultButton="btnRefresh">
            <table class="table-condensed" style="width: 100%">
                <tr>
                    <td style="width: 250px">
                        <telerik:RadComboBox ID="cboStatus" runat="server" DataSourceID="SqlDataSourceJobActiveStatus" DataTextField="Name" DataValueField="Id"
                            Width="100%" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" MarkFirstMatch="True" Filter="Contains">
                            <Localization AllItemsCheckedString="All Items Checked" CheckAllString="Check All..." ItemsCheckedString="items checked"></Localization>
                        </telerik:RadComboBox>
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech"
                            EmptyMessage="Search for Code, Job Name, Client Name ..."
                            Width="100%">
                        </telerik:RadTextBox>
                    </td>
                    <td style="text-align: left">
                        <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                    <span class="glyphicon glyphicon-search"></span> Search
                        </asp:LinkButton>

                    </td>
                </tr>
            </table>
        </asp:Panel>

    </div>

    <%--Chart--%>
    <div class="collapse Formulario" id="collapseChart">
        <table class="table-condensed" style="width: 100%">
            <tr>
                <td style="width: 50%">
                    <h4 style="text-align: center; margin: 0">Time Sheet Daily</h4>
                    <telerik:RadHtmlChart ID="RadHtmlChartTimeSheet" runat="server" DataSourceID="SqlDataSourceTimeSheet" Width="100%">
                        <PlotArea>
                            <Series>
                                <telerik:ColumnSeries DataFieldY="WorkHours" Name="Work Time" GroupName="Date">
                                    <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                    </LabelsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="DarkGreen" />
                                    </Appearance>
                                </telerik:ColumnSeries>
                                <telerik:ColumnSeries DataFieldY="NonWorkHours" Name="Other Time" GroupName="Date">
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
    <div class="Formulario">
        <span>To <span class="label label-primary">Add Time</span>, Click on the specific job </span>

        <telerik:RadListView ID="RadListView1" runat="server" DataSourceID="SqlDataSourceJobs" DataKeyNames="Id" ItemPlaceholderID="Container1"
            BorderStyle="Solid">
            <LayoutTemplate>
                <fieldset style="width: 100%">
                    <asp:PlaceHolder ID="Container1" runat="server"></asp:PlaceHolder>
                </fieldset>

            </LayoutTemplate>
            <ItemTemplate>
                <fieldset style="float: left; width: 250px; margin: 2px">
                    <fieldset class="thumbnail" style="margin: 0; width: 100%">
                        <asp:LinkButton ID="btnNewTime" runat="server" UseSubmitBehavior="false" ToolTip='<%# Eval("itemNameFull")%>'
                            CommandName="AddNewTime" CommandArgument='<%# Eval("Id")%>'>
                                 <table style="width: 100%">
                                <tr>
                                    <td>
                                        <h4 style="margin: 0"><span class="center-block label  <%# LocalAPI.GetJobStatusLabelCSS(Eval("statusId")) %>"><%# String.Concat(Eval("Code"), "  ", Eval("itemName"))%></span></h4>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table style="width:100%">
                                            <tr>
                                                <td style="width: 24px">
                                                    <small><span class="glyphicon glyphicon-plus" title="Add New Job Time"></small>
                                                </td>
                                                <td>
                                                    <small style="color: black">
                                                        <%# Eval("ClientCompany")%></small>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span style="margin:0;color: black"><b><%# Eval("ClientName")%></b></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <small style="color: black"><%# Eval("LastTime", "{0:d}")%> --<mark><%# Eval("HoursUsed")%>/<%# Eval("HoursAssigned")%></mark> -- <%# Eval("PM")%> </small>
                                    </td>
                                </tr>
                            </table>
                        </asp:LinkButton>

                    </fieldset>
                    <fieldset class="thumbnail" style="margin: 0; width: 100%">
                        <table style="width: 100%">
                            <tr>
                                <td>
                                    <asp:LinkButton ID="btnAddReview" runat="server" UseSubmitBehavior="false" ToolTip='<% GetAddRevisionToolTip() %>'
                                        CommandName="AddReview" CommandArgument='<%# Eval("Id")%>'>
                                                <small><span class="glyphicon glyphicon-plus"></small>
                                    </asp:LinkButton>
                                </td>
                                <td>
                                    <asp:LinkButton ID="btnEditReviews" runat="server" UseSubmitBehavior="false" ToolTip='<%# GetViewEditRevisionToolTip() %>'
                                        CommandName="EditReviews" CommandArgument='<%# Eval("Id")%>'>
                                                    <%# GetRevisionOrTicketLabel() %>&nbsp;<span class="badge"> <%#Eval("ReviewsCount")%></span>
                                    </asp:LinkButton>
                                </td>
                                <td>
                                    <a class="glyphicon glyphicon-share" title="Click to View Job" href='<%#String.Concat("../ADMCLI/Job.aspx?guid=", Eval("guid")) %>' target="_blank" aria-hidden="true"></a>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </fieldset>
            </ItemTemplate>

        </telerik:RadListView>
    </div>

    <%--Footer--%>
    <telerik:RadListView ID="RadListViewFooter" runat="server" DataSourceID="SqlDataSourceDateHours" DataKeyNames="Date" ItemPlaceholderID="Container1"
        BorderStyle="Solid">
        <LayoutTemplate>
            <div style="text-align: left">
                <b>Status Legend: </b>

                <span class="label  <%# LocalAPI.GetJobStatusLabelCSS(0) %>">Not in Progress</span>

                <span class="label  <%# LocalAPI.GetJobStatusLabelCSS(2) %>">In Progress</span>

                <span class="label  <%# LocalAPI.GetJobStatusLabelCSS(3) %>">On Hold</span>

                <span class="label  <%# LocalAPI.GetJobStatusLabelCSS(4) %>">Submitted</span>

                <span class="label  <%# LocalAPI.GetJobStatusLabelCSS(5) %>">Under Revision</span>
            </div>
            <fieldset style="width: 100%">
                <asp:PlaceHolder ID="Container1" runat="server"></asp:PlaceHolder>
            </fieldset>
        </LayoutTemplate>
    </telerik:RadListView>
    <div class="Formulario">
        <telerik:RadGrid ID="RadGridFooter" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceDateWORKHOURS" Width="100%" ShowHeader="false">
            <MasterTableView DataSourceID="SqlDataSourceDateWORKHOURS" ShowFooter="True" CommandItemDisplay="None">
                <Columns>
                    <telerik:GridTemplateColumn UniqueName="Column1" ItemStyle-Font-Size="Small">
                        <ItemTemplate>

                            
                                <div>
                                    <table class="table-condensed" style="width: 100%; border-color: gainsboro" border="1">
                                        <tr>
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
                                                    <div class="progress-bar" role="progressbar" aria-valuenow='<%# Eval("HoursPercentage9")  %>' aria-valuemin="0" aria-valuemax="100"
                                                        style='width: <%# Eval("HoursPercentage9") %>%;'>
                                                        <%# Eval("Hours9")%> Hrs
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="progress" style="margin-bottom: 0;">
                                                    <div class="progress-bar" role="progressbar" aria-valuenow='<%# Eval("HoursPercentage8")  %>' aria-valuemin="0" aria-valuemax="100"
                                                        style='width: <%# Eval("HoursPercentage8") %>%;'>
                                                        <%# Eval("Hours8")%> Hrs
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="progress" style="margin-bottom: 0;">
                                                    <div class="progress-bar" role="progressbar" aria-valuenow='<%# Eval("HoursPercentage7")  %>' aria-valuemin="0" aria-valuemax="100"
                                                        style='width: <%# Eval("HoursPercentage7") %>%;'>
                                                        <%# Eval("Hours7")%> Hrs
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="progress" style="margin-bottom: 0;">
                                                    <div class="progress-bar" role="progressbar" aria-valuenow='<%# Eval("HoursPercentage6")  %>' aria-valuemin="0" aria-valuemax="100"
                                                        style='width: <%# Eval("HoursPercentage6") %>%;'>
                                                        <%# Eval("Hours6")%> Hrs
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="progress" style="margin-bottom: 0;">
                                                    <div class="progress-bar" role="progressbar" aria-valuenow='<%# Eval("HoursPercentage5")  %>' aria-valuemin="0" aria-valuemax="100"
                                                        style='width: <%# Eval("HoursPercentage5") %>%;'>
                                                        <%# Eval("Hours5")%> Hrs
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="progress" style="margin-bottom: 0;">
                                                    <div class="progress-bar" role="progressbar" aria-valuenow='<%# Eval("HoursPercentage4")  %>' aria-valuemin="0" aria-valuemax="100"
                                                        style='width: <%# Eval("HoursPercentage4") %>%;'>
                                                        <%# Eval("Hours4")%> Hrs
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="progress" style="margin-bottom: 0;">
                                                    <div class="progress-bar" role="progressbar" aria-valuenow='<%# Eval("HoursPercentage3")  %>' aria-valuemin="0" aria-valuemax="100"
                                                        style='width: <%# Eval("HoursPercentage3") %>%;'>
                                                        <%# Eval("Hours3")%> Hrs
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="progress" style="margin-bottom: 0;">
                                                    <div class="progress-bar" role="progressbar" aria-valuenow='<%# Eval("HoursPercentage2")  %>' aria-valuemin="0" aria-valuemax="100"
                                                        style='width: <%# Eval("HoursPercentage2") %>%;'>
                                                        <%# Eval("Hours2")%> Hrs
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="progress" style="margin-bottom: 0;">
                                                    <div class="progress-bar" role="progressbar" aria-valuenow='<%# Eval("HoursPercentage1")  %>' aria-valuemin="0" aria-valuemax="100"
                                                        style='width: <%# Eval("HoursPercentage1") %>%;'>
                                                        <%# Eval("Hours1")%> Hrs
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


    <telerik:RadToolTip ID="RadToolTipMiscellaneous" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode"
        Skin="Default" Width="400px">

        <h4 class="text-center">New Miscellaneous Time</h4>

        <div class="panel panel-default">
            <div class="panel-heading">Category:</div>
            <div class="panel-body text-center">
                <telerik:RadComboBox ID="cboType" runat="server" DataSourceID="SqlDataSourceMiscellaneousType" DataTextField="Name" ZIndex="50001"
                    DataValueField="Id" Width="100%" MarkFirstMatch="True" Filter="Contains" Height="300px">
                </telerik:RadComboBox>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading">Time/day (in hours for each day):</div>
            <div class="panel-body text-center">
                <telerik:RadNumericTextBox ID="txtMiscellaneousHours" runat="server"
                    MinValue="0.25" ShowSpinButtons="True" ButtonsPosition="Right" ToolTip="Time in hours for each day"
                    Value="1" Width="100%" MaxValue="24">
                    <NumberFormat DecimalDigits="2" />
                    <IncrementSettings Step="1" />
                </telerik:RadNumericTextBox>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading">Date From:</div>
            <div class="panel-body text-center">
                <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server"
                    DateFormat="MM/dd/yyyy"
                    Culture="en-US"
                    ZIndex="50001"
                    Width="100%">
                </telerik:RadDatePicker>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading">Date To:</div>
            <div class="panel-body text-center">
                <telerik:RadDatePicker ID="RadDatePickerTo" runat="server"
                    DateFormat="MM/dd/yyyy"
                    Culture="en-US"
                    ZIndex="50001"
                    Width="100%">
                </telerik:RadDatePicker>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading">
                Notes:
            </div>
            <div class="panel-body text-center">
                <telerik:RadTextBox ID="txtNotes" runat="server" TextMode="MultiLine" Rows="2" Width="100%"
                    MaxLength="256">
                </telerik:RadTextBox>
            </div>
        </div>
        <div>
            <asp:LinkButton ID="btnOkNewMiscellaneousTime" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" ValidationGroup="AddRecord" Width="380px">
                        Add Time
            </asp:LinkButton>
        </div>

        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtNotes" Text="* Notes can not be empty"
            SetFocusOnError="true" ValidationGroup="AddRecord">
        </asp:RequiredFieldValidator>


        <table style="width: 100%; border: 1px solid #aeaeaf;">
            <tr>
                <td style="width: 25%"><b>Benefits</b></td>
                <td style="width: 25%; text-align: center"><b>Assigned</b></td>
                <td style="width: 25%; text-align: center"><b>Used</b></td>
                <td style="width: 25%; text-align: center"><b>Balance</b></td>
            </tr>
            <tr>
                <td>Vacations</td>
                <td style="text-align: center">
                    <asp:Label ID="lblVac1" runat="server" Text="0"></asp:Label></td>
                <td style="text-align: center">
                    <asp:Label ID="lblVac2" runat="server" Text="0"></asp:Label></td>
                <td style="text-align: center">
                    <asp:Label ID="lblVac3" runat="server" Text="0"></asp:Label></td>
            </tr>
            <tr>
                <td>Personal/Sick</td>
                <td style="text-align: center">
                    <asp:Label ID="lblPer1" runat="server" Text="0"></asp:Label></td>
                <td style="text-align: center">
                    <asp:Label ID="lblPer2" runat="server" Text="0"></asp:Label></td>
                <td style="text-align: center">
                    <asp:Label ID="lblPer3" runat="server" Text="0"></asp:Label></td>

            </tr>
        </table>

    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipReview" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode"
        Skin="Default">
        <h4 class="text-center">Add Revision</h4>
        <asp:ValidationSummary ID="ValidationSummaryJobUpdate" runat="server"
            Font-Size="X-Small" HeaderText="Following error occurs:" ShowMessageBox="false" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="review_insert" />

        <table class="table-condensed" style="width: 500px">
            <tr>
                <td style="text-align: right; width: 150px">Process Number:</td>
                <td>
                    <telerik:RadTextBox ID="txtReviewCode" runat="server" Width="50%" MaxLength="32" ValidationGroup="review_insert">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right;">Revision URL:</td>
                <td>
                    <telerik:RadTextBox ID="txtReviewURL" runat="server" Width="100%" MaxLength="128">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">City:</td>
                <td>
                    <telerik:RadComboBox ID="cboReviewCity" runat="server" DataSourceID="SqlDataSourceReviewCity" DataTextField="Name" DataValueField="Id"
                        Filter="Contains" MarkFirstMatch="True" Width="100%" ZIndex="50001" Height="300px"
                        AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select City...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Department:</td>
                <td>
                    <telerik:RadComboBox ID="cboReviewDepartment" runat="server" DataSourceID="SqlDataSourceReviewDepartment" DataTextField="Name" DataValueField="Id"
                        Filter="Contains" MarkFirstMatch="True" Width="100%" ZIndex="50001" Height="300px"
                        AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select Department...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">App. Date:</td>
                <td>
                    <telerik:RadDatePicker ID="RadDatePickerReviewSubmit" runat="server"
                        DateFormat="MM/dd/yyyy"
                        Culture="en-US"
                        ZIndex="50001"
                        Width="50%">
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Status:</td>
                <td>
                    <telerik:RadComboBox ID="cboPlanReview_status" runat="server" Width="100%" ZIndex="50001"
                        DataSourceID="SqlDataSourcePlanReview_status" DataTextField="Name" DataValueField="Id">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Disp. Date:</td>
                <td>
                    <telerik:RadDatePicker ID="RadDatePickerDateOut" runat="server"
                        DateFormat="MM/dd/yyyy"
                        Culture="en-US"
                        ZIndex="50001"
                        Width="50%">
                    </telerik:RadDatePicker>

                </td>
            </tr>
            <tr>
                <td style="text-align: right">Reviewed by:</td>
                <td>
                    <telerik:RadComboBox ID="cboReviewer" runat="server" DataSourceID="SqlDataSourceReviewer" DataTextField="Name" DataValueField="Id"
                        Filter="Contains" MarkFirstMatch="True" Width="100%" ZIndex="50001" Height="300px"
                        AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select Reviewer...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Notes:</td>
                <td>
                    <telerik:RadTextBox ID="txtRewiewNotes" runat="server" Width="100%" Rows="3" TextMode="MultiLine">
                    </telerik:RadTextBox>
                </td>
            </tr>
        </table>

        <br />
        <table style="width: 100%">
            <tr>
                <td style="text-align: center">
                    <asp:LinkButton ID="btnNewReview" runat="server" CssClass="btn btn-info btn-lg" UseSubmitBehavior="false" ValidationGroup="review_insert" Width="120px">
                        Add Rewiew
                    </asp:LinkButton>
                </td>
            </tr>
        </table>

    </telerik:RadToolTip>

    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtReviewCode" ErrorMessage="(*) Process Number is required"
        ValidationGroup="review_insert"></asp:RequiredFieldValidator>


    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
    </telerik:RadWindowManager>



    <asp:SqlDataSource ID="SqlDataSourceJobs" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="TIME4_EMP_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="Employee" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblStatusIdIN_List" ConvertEmptyStringToNull="False" Name="StatusIdIN_List" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Find" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceActiveJob" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOBS_EMP_non_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblEmployeeId" Name="Employee" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="Status" DefaultValue="-1" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceJobActiveStatus" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Jobs_status] WHERE Id in(0,2,3,4,5,7) ORDER BY [OrderBy]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceProposalTask" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="ProposalTaskNewTime_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblSelectedJob" Name="JobId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceCategory" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Employees_time_categories] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceMiscellaneousType" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="MiscellaneousType_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceReviewCity" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM PlanReview_Cities ORDER BY Name"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceReviewDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM PlanReview_Departments ORDER BY Name"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePlanReview_status" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [PlanReview_status]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceReviewer" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Contacts] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceJobsReviews" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="JobReview_INSERT" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="lblSelectedJob" Name="jobId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="txtReviewCode" Name="Code" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtReviewURL" Name="url" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="cboReviewCity" Name="cityId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboReviewDepartment" Name="deparmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="RadDatePickerReviewSubmit" Name="DateSubmit" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="RadDatePickerDateOut" Name="DateOut" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboPlanReview_status" Name="statusId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtRewiewNotes" Name="Notes" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="cboReviewer" Name="contactId" PropertyName="SelectedValue" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceDateWORKHOURS" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="WORKHOURS_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDateHours" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="WORKHOURS_EMP_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTimeSheet" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOBS_ResultByTimeSheet" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" />
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTimeUsed" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOBS_ResultByTimeUsed" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" />
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblStatusIdIN_List" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedJob" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblUserEmail" runat="server" Visible="False"></asp:Label>
</asp:Content>
