<%@ Page Title="Proposals" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="proposals.aspx.vb" Inherits="pasconcept20.proposals" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
        <script type="text/javascript">
            function onRequestStart(sender, args) {
                if (args.get_eventTarget().indexOf("ExportTo") >= 0) {
                    args.set_enableAjax(false);
                }
            }

            $(document).on("click", ".toggle-on", function (event) {
                var masterTableView = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                var columnIndex = masterTableView.getColumnByUniqueName("Total").get_element().cellIndex;
                masterTableView.hideColumn(columnIndex);
                columnIndex = masterTableView.getColumnByUniqueName("DeleteColumn").get_element().cellIndex;
                masterTableView.hideColumn(columnIndex);
            });

            $(document).on("click", ".toggle-off", function (event) {
                var masterTableView = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                var columnIndex = masterTableView.getColumnByUniqueName("Total").get_element().cellIndex;
                masterTableView.showColumn(columnIndex);
                columnIndex = masterTableView.getColumnByUniqueName("DeleteColumn").get_element().cellIndex;
                masterTableView.showColumn(columnIndex);
            });

            function OnClientClose(sender, args) {
                var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                masterTable.rebind();
            }
        </script>
        <style>
            .table-sm td, .table-sm th {
                padding-top: .05rem;
                padding-bottom: .05rem;
            }
        </style>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <ClientEvents OnRequestStart="onRequestStart"></ClientEvents>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadDatePickerTo" />
                    <telerik:AjaxUpdatedControl ControlID="RadDatePickerFrom" />
                    <telerik:AjaxUpdatedControl ControlID="cboClients" />
                    <telerik:AjaxUpdatedControl ControlID="txtFind" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1" />
                    <telerik:AjaxUpdatedControl ControlID="FormViewViewSummary" />
                </UpdatedControls>

            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Proposals</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>

            <span id="spanViewSummary" runat="server">
                <button class="btn btn-secondary" type="button" data-toggle="collapse" data-target="#collapseSummary" aria-expanded="false" aria-controls="collapseSummary" title="Show/Hide Summary panel">
                    View Summary
                </button>
            </span>

            <asp:LinkButton ID="btnNewWizard" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                        Add Proposal
            </asp:LinkButton>
            <asp:LinkButton ID="btnPrivate" runat="server" UseSubmitBehavior="false" ToolTip="Private/Public Mode" Font-Underline="false">
                    <input type="checkbox" data-toggle="toggle" data-onstyle="danger" data-style="ios"/>
            </asp:LinkButton>
        </span>

    </div>


    <div class="collapse" id="collapseFilter">

        <asp:Panel ID="pnlFind" runat="server" class="pasconcept-bar" DefaultButton="btnRefresh">
            <table class="table-sm" style="width: 100%">
                <tr>
                    <td style="width: 200px">
                        <telerik:RadComboBox ID="cboPeriod" runat="server" Width="100%" MarkFirstMatch="True" DropDownAutoWidth="Enabled">
                            <Items>
                                <telerik:RadComboBoxItem Text="Last 30 days" Value="30" Selected="true" />
                                <telerik:RadComboBoxItem Text="Last 60 days" Value="60" />
                                <telerik:RadComboBoxItem Text="Last 90 days" Value="90" />
                                <telerik:RadComboBoxItem Text="Last 120 days" Value="120" />
                                <telerik:RadComboBoxItem Text="Last 180 days" Value="180" />
                                <telerik:RadComboBoxItem Text="Last 365 days" Value="365" />
                                <telerik:RadComboBoxItem Text="This year" Value="14" />
                                <telerik:RadComboBoxItem Text="This month" Value="16" />
                                <telerik:RadComboBoxItem Text="Last year" Value="15" />
                                <telerik:RadComboBoxItem Text="Last month" Value="17" />
                                <telerik:RadComboBoxItem Text="(All years...)" Value="13" />
                                <telerik:RadComboBoxItem Text="Custom Range..." Value="99" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 130px">
                        <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" DateFormat="MM/dd/yyyy" Width="100%" Culture="en-US" ToolTip="Date From for filter">
                        </telerik:RadDatePicker>
                    </td>
                    <td style="width: 130px">
                        <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" DateFormat="MM/dd/yyyy" Width="100%" Culture="en-US" ToolTip="Date To for Filter">
                        </telerik:RadDatePicker>
                    </td>
                    <td style="width: 350px">
                        <telerik:RadComboBox ID="cboDepartments" runat="server" DataSourceID="SqlDataSourceDepartments" DataTextField="Name"
                            DataValueField="Id" Width="100%" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Departments...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboEmployee" runat="server" DataSourceID="SqlDataSourceEmpl" MarkFirstMatch="True" ToolTip="Select Proposal By - Prepared By Employee"
                            Width="100%" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Proposal By or Prepared By...)" Value="0" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="3">
                        <telerik:RadComboBox ID="cboClients" runat="server" DataSourceID="SqlDataSourceClient"
                            DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Width="100%" Height="300px"
                            AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Clients...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboStatus" runat="server" DataSourceID="SqlDataSourceStatus"
                            DataTextField="Status" DataValueField="Id" Width="100%"
                            AppendDataBoundItems="True">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Status...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech"
                            EmptyMessage="Search for Proposal Number, Name,..."
                            Width="100%">
                        </telerik:RadTextBox>
                    </td>
                    <td style="text-align: right; width: 180px">
                        <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:Panel>

    </div>
    <div class="collapse" id="collapseSummary">
        <asp:FormView ID="FormViewViewSummary" runat="server" DataSourceID="SqlDataSourceViewSummary" Width="100%" CssClass="pasconcept-subbar">
            <ItemTemplate>
                <table class="table-sm" style="width: 100%">
                    <tr>
                        <td style="width: 19%; text-align: center; background-color: #039be5">
                            <span class="DashboardFont2">Total</span><br />
                            <asp:Label ID="lblTotalBudget" CssClass="DashboardFont1" runat="server" Text='<%# Eval("Total", "{0:C2}") %>'></asp:Label><br />
                            <span class="DashboardFont3">(Total) - (Not Emitted) - (Hold) - (D. Not Submitted) </span>
                        </td>
                        <td></td>
                        <td style="width: 19%; text-align: center; background-color: #43a047">
                            <span class="DashboardFont2">Total Accepted</span><br />
                            <asp:Label ID="lblTotalBilled" runat="server" CssClass="DashboardFont1" Text='<%# Eval("AcceptedTotal", "{0:C2}") %>'></asp:Label><br />
                            <span class="DashboardFont3">Total Accepted</span>
                        </td>
                        <td></td>
                        <td style="width: 19%; text-align: center; background-color: #343a40">
                            <span class="DashboardFont2">Hit Rate $</span><br />
                            <asp:Label ID="lblTotalPending" runat="server" CssClass="DashboardFont1" Text='<%# Eval("HitRate", "{0:P2}") %>'></asp:Label><br />
                            <span class="DashboardFont3">(Total Accepted + Jobs w/o Prop.) / (Total + Jobs w/o Prop.)</span>
                        </td>
                        <td></td>
                        <td style="width: 19%; text-align: center; background-color: #546e7a">
                            <span class="DashboardFont2">Total Pending</span><br />
                            <asp:Label ID="LabelblTotalBalance" runat="server" CssClass="DashboardFont1" Text='<%# Eval("PendingTotal", "{0:C2}") %>'></asp:Label><br />
                            <span class="DashboardFont3">Submitted to Client, Pending Accept/Decline</span>
                        </td>
                        <td></td>
                        <td style="width: 19%; text-align: center; background-color: #e53935">
                            <span class="DashboardFont2">Total Declined</span><br />
                            <asp:Label ID="lblTotalCollected" runat="server" CssClass="DashboardFont1" Text='<%# Eval("DeclinedTotal", "{0:C2}") %>'></asp:Label><br />
                            <span class="DashboardFont3">By Client + Not Competitive + Not Submitted</span>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:FormView>
    </div>
    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSourceProp" AutoGenerateColumns="False" AllowAutomaticDeletes="True" AllowSorting="True"
            PageSize="50" AllowPaging="true"
            Height="850px" RenderMode="Lightweight"
            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
            <ClientSettings>
                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
            </ClientSettings>
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceProp" ShowFooter="True" ClientDataKeyNames="Id">
                <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                <Columns>
                    <telerik:GridTemplateColumn DataField="Id" HeaderText="Number"
                        SortExpression="Id" UniqueName="Id" ItemStyle-HorizontalAlign="Center"
                        HeaderStyle-Width="130px" FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEditProp" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to View/Edit Proposal"
                                CommandName="EditProposal">
                                <%# Eval("ProposalNumber")%>
                            </asp:LinkButton>

                            <div style="float: right; vertical-align: top; margin: 0;">
                                <%--Three Point Action Menu--%>
                                <asp:HyperLink runat="server" ID="lblAction" NavigateUrl="javascript:void(0);" Style="text-decoration: none;">
                                            <i title="Click to menu for this row" style="color:dimgray" class="fas fa-ellipsis-v"></i>
                                </asp:HyperLink>

                                <telerik:RadToolTip ID="RadToolTipAction" runat="server" TargetControlID="lblAction" RelativeTo="Element"
                                    RenderMode="Lightweight" EnableViewState="true" ShowCallout="false" RenderInPageRoot="true"
                                    Position="BottomRight" Modal="True" Title="" ShowEvent="OnClick"
                                    HideDelay="100" HideEvent="LeaveToolTip" IgnoreAltAttribute="true">

                                    <table class="table-borderless" style="width: 200px; font-size: medium">
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="btnEdit2" runat="server" UseSubmitBehavior="false" CommandName="EditProposal" CommandArgument='<%# Eval("Id")%>' CssClass="dropdown-item">
                                                    <i class="fas fa-pencil-alt"></i>&nbsp;&nbsp;View/Edit Proposal (Form Page)
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="LinkButton1" runat="server" UseSubmitBehavior="false" CommandName="EditWizard" CommandArgument='<%# Eval("Id")%>' CssClass="dropdown-item">
                                                      <i class="fas fa-pencil-alt"></i>&nbsp;&nbsp;View/Edit Proposal (Wizard Page)
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="dropdown-divider"></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-left: 24px">
                                                <asp:LinkButton ID="btnEditJob2" runat="server" CommandArgument='<%# Eval("JobId") %>' CommandName="EditJob" Visible='<%# iif(Eval("JobId") = 0, False, True) %>' CssClass="dropdown-item">
                                                    View/Edit Job
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="btnUploadFiles" runat="server" CommandArgument='<%# Eval("Id")%>' CommandName="UploadFiles" UseSubmitBehavior="false" CssClass="dropdown-item">
                                                                <span aria-hidden="true" class="fas fa-cloud-upload-alt"></span>&nbsp;&nbsp;Upload Files
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:LinkButton runat="server" ID="btnSendProposal" CommandName="EmailPrint" CommandArgument='<%# Eval("Id") %>' CssClass="dropdown-item">
                                                    <i class="far fa-envelope"></i>&nbsp;&nbsp;Send Proposal Email to Client
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href='<%# LocalAPI.GetSharedLink_URL(111, Eval("Id"), True)%>' target="_blank" class="dropdown-item">
                                                    <i class="fas fa-print"></i>&nbsp;&nbsp;Print Proposal
                                                </a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href='<%# LocalAPI.GetSharedLink_URL(111, Eval("Id"), False)%>' target="_blank" class="dropdown-item">
                                                    <i class="far fa-share-square"></i>&nbsp;&nbsp;View/Share Client Proposal Page
                                                </a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="dropdown-divider"></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-left: 24px">
                                                <asp:LinkButton runat="server" ID="btnSaveAs1" CommandName="SaveProposalAs" CommandArgument='<%# Eval("Id") %>' CssClass="dropdown-item">
                                                    Save Proposal As...
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-left: 24px">
                                                <asp:LinkButton runat="server" ID="btnSaveAs2" CommandName="SaveProposalAsTemplate" CommandArgument='<%# Eval("Id") %>' CssClass="dropdown-item">
                                                    Save Proposal As Proposal Template...
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadToolTip>
                            </div>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="Date" DataFormatString="{0:MM/dd/yyyy}" DataType="System.DateTime"
                        HeaderText="Date" SortExpression="Date" UniqueName="Date"
                        ItemStyle-HorizontalAlign="Center" AllowFiltering="False" HeaderStyle-Width="100px">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="ProjectName" HeaderText="Project Name - Client"
                        SortExpression="ProjectName" UniqueName="ProjectName">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlkLocation" runat="server" NavigateUrl='<%# LocalAPI.urlProjectLocationGmap(Eval("ProjectLocation"))%>'
                                ToolTip='<%# String.Concat("Click to view [", Eval("ProjectLocation"), "] in Google Maps")%>' Target="_blank">
                                        <i class="fa fa-map-marker" aria-hidden="true"></i>
                            </asp:HyperLink>
                            <b><%# String.Concat(Eval("ProjectName"), Eval("Area"))%></b>
                            <br />
                            <asp:HyperLink ID="InitialsLabel" runat="server" NavigateUrl="javascript:void(0);"><%# Eval("ClientandCompany") %></asp:HyperLink>
                            <telerik:RadToolTip ID="RadToolTipContact" runat="server" TargetControlID="InitialsLabel" RelativeTo="Element"
                                RenderMode="Lightweight" EnableViewState="true" ShowCallout="false" RenderInPageRoot="true"
                                Position="BottomCenter" Modal="True" Title="" ShowEvent="OnClick"
                                HideDelay="300" HideEvent="ManualClose" IgnoreAltAttribute="true">
                                <table class="table-sm">
                                    <tr>
                                        <td colspan="2">
                                            <asp:LinkButton ID="btnEditCli" runat="server" CommandArgument='<%# Eval("clientId") %>'
                                                CommandName="EditClient" Text='<%# Eval("ClientName")%>' UseSubmitBehavior="false" Font-Size="Medium"
                                                CssClass="badge badge-info ">
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="margin-top: 10px">
                                            <%# Eval("Company") %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 60px">Phone:
                                        </td>
                                        <td>
                                            <telerik:RadMaskedTextBox ID="PhoneTextBox" runat="server" ReadOnly="true"
                                                Text='<%# LocalAPI.GetClientProperty(Eval("ClientId"), "Phone")%>' Mask="(###) ###-####" BorderStyle="None" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Cellular:
                                        </td>
                                        <td>
                                            <telerik:RadMaskedTextBox ID="RadMaskedTextBox1" runat="server" ReadOnly="true"
                                                Text='<%# LocalAPI.GetClientProperty(Eval("ClientId"), "Cellular")%>' Mask="(###) ###-####" BorderStyle="None" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Email:
                                        </td>
                                        <td>
                                            <a href='<%#String.Concat("mailto:", Eval("Email")) %>' title="Mail to"><%#Eval("Email") %></a>
                                        </td>
                                    </tr>
                                </table>
                            </telerik:RadToolTip>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="ProposalBy" HeaderText="Job Type - Template"
                        SortExpression="ProposalBy" UniqueName="ProposalBy" HeaderStyle-Width="250px">
                        <ItemTemplate>
                            <div>
                                <b><%# Eval("JobType") %></b>
                            </div>
                            <div>
                                <%# Eval("nType") %>
                            </div>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="ProposalBy" HeaderText="Proposal By - Prepared By"
                        SortExpression="ProposalBy" UniqueName="ProposalBy" HeaderStyle-Width="220px">
                        <ItemTemplate>
                            <div>
                                <b><%# Eval("ProposalBy") %></b>
                            </div>
                            <div>
                                <%# Eval("PreparedBy") %>
                            </div>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn AllowFiltering="False" DataField="Total" DataFormatString="{0:C2}" Display="false" HeaderText="Total" ReadOnly="True" SortExpression="Total"
                        UniqueName="Total" HeaderStyle-Width="130px" ItemStyle-HorizontalAlign="Right"
                        FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:C2}">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="Status" HeaderText="Status" SortExpression="Status" UniqueName="Status" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="170px">
                        <ItemTemplate>
                            <div style="font-size: 12px; width: 100%"
                                class='<%# LocalAPI.GetProposalStatusLabelCSS(Eval("StatusId")) %>'>
                                <%# Eval("Status") %>
                            </div>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="JobCode" HeaderText="Job" SortExpression="JobCode" UniqueName="JobCode" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="80px">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEditJob" runat="server" CommandArgument='<%# Eval("JobId") %>' ToolTip="Click to View/Edit Job"
                                CommandName="EditJob" Text='<%# Eval("JobCode")%>' ForeColor='<%# JobForeColor(Eval("JobId"), Eval("Status"))%>'>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Insights" UniqueName="Insights" AllowFiltering="False" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="150px">
                        <ItemTemplate>
                            <table style="width: 100%">
                                <tr>
                                    <%--<td style="text-align:center;width: 30px">
                                        <span title="Number of files uploaded" class="badge badge-pill badge-light" style='<%# IIf(Eval("ProposalUploadFiles")=0,"display:none","display:normal")%>'>
                                            <%#Eval("ProposalUploadFiles")%>
                                        </span>
                                    </td>--%>
                                    <td style="text-align:right;width: 60px">
                                        <spa style="font-size: x-small" title="Emitted Date"><%# Eval("EmailDate", "{0:d}") %></spa>
                                    </td>
                                    <td style="text-align:center;width: 30px">
                                        <span title="Number of times Sent to Client" class="badge badge-pill badge-secondary" style='<%# IIf(Eval("Emitted")=0,"display:none;vertical-align:middle","display:normal;vertical-align:middle")%>'>
                                            <%#Eval("Emitted")%>
                                        </span>
                                    </td>
                                    <td style="text-align:center;">
                                        <span title="Number of times the Client has visited your Proposal Page" class="badge badge-pill badge-warning" style='<%# IIf(Eval("Emitted")=0,"display:none","display:normal")%>'>
                                            <%#Eval("clientvisits")%>
                                        </span>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Note that the Proposal Accepted can not be eliminated. Delete this proposal?"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete" Display="false"
                        UniqueName="DeleteColumn" HeaderText=""
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                    </telerik:GridButtonColumn>
                </Columns>

            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENTS_for_ProposalsList_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProp" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Proposals_v20_SELECT" DeleteCommand="Proposal_DELETE" DeleteCommandType="StoredProcedure"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="DateFrom" PropertyName="SelectedDate" Type="DateTime" DefaultValue="" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="DateTo" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboClients" Name="Client" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboStatus" Name="StatusId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboDepartments" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboEmployee" Name="EmployeeId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Find" PropertyName="Text" Type="String" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [id], [Month] FROM [Months] ORDER BY [id]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceYears" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="select year([Date]) as Year from [dbo].[Proposal] where companyId=@companyId group by year([Date]) order by year([Date]) DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceStatus" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Status] FROM [Proposal_status] ORDER BY [Id]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceViewSummary" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="ProposalViewSummary_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="DateFrom" PropertyName="SelectedDate" Type="DateTime" DefaultValue="" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="DateTo" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboClients" Name="Client" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboDepartments" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Find" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmpl" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="EMPLOYEES2_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblProposalIdFromRfp" runat="server" Visible="False" Text="0"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False" Text="0"></asp:Label>

</asp:Content>
