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
                <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseSummary" aria-expanded="false" aria-controls="collapseSummary" title="Show/Hide Summary panel">
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
                                <telerik:RadComboBoxItem Text="(Last 30 days)" Value="30" Selected="true" />
                                <telerik:RadComboBoxItem Text="(Last 60 days)" Value="60" />
                                <telerik:RadComboBoxItem Text="(Last 90 days)" Value="90" />
                                <telerik:RadComboBoxItem Text="(Last 120 days)" Value="120" />
                                <telerik:RadComboBoxItem Text="(Last 180 days)" Value="180" />
                                <telerik:RadComboBoxItem Text="(Last 365 days)" Value="365" />
                                <telerik:RadComboBoxItem Text="(This year)" Value="14" />
                                <telerik:RadComboBoxItem Text="(Last year)" Value="15" />
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
                        <telerik:RadComboBox ID="cboStatus" runat="server" DataSourceID="SqlDataSourceStatus"
                            DataTextField="Status" DataValueField="Id" Width="100%"
                            AppendDataBoundItems="True">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Status...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>


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
                        <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech"
                            EmptyMessage="Search for Proposal Number, Name,..."
                            Width="100%">
                        </telerik:RadTextBox>
                    </td>
                    <td style="text-align: right;">
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
            PageSize="50" AllowPaging="true" Height="1000px" RenderMode="Auto" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
            <ClientSettings>
                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
            </ClientSettings>
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceProp" ShowFooter="True" ClientDataKeyNames="Id">
                <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                <Columns>
                    <telerik:GridTemplateColumn DataField="Id" HeaderText="Number"
                        SortExpression="Id" UniqueName="Id" ItemStyle-HorizontalAlign="Center"
                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEditProp" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to View/Edit Proposal"
                                CommandName="EditProposal">
                                <%# Eval("ProposalNumber")%>
                                 <span title="Number of files uploaded" class="badge badge-pill badge-light" style='<%# IIf(Eval("ProposalUploadFiles")=0,"display:none","display:normal")%>'>
                                                <%#Eval("ProposalUploadFiles")%>
                                            </span>
                            </asp:LinkButton>
                            <div style="text-align: center">
                                <asp:LinkButton ID="btnEditWizard" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Click to Edit Wizard"
                                    CommandName="EditWizard" UseSubmitBehavior="false">
                                                <i class="far fa-edit"></i>
                                </asp:LinkButton>

                                &nbsp;

                                        <a class="far fa-share-square" title="Preview Proposal " href='<%# Eval("Id", "../adm/sharelink.aspx?ObjType=111&ObjId={0}")%>' target="_blank" aria-hidden="true"></a>
                                &nbsp;
                                <asp:LinkButton ID="btnUploadFiles" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Click to Upload Files"
                                    CommandName="UploadFiles" UseSubmitBehavior="false">
                                                <span aria-hidden="true" class="fas fa-cloud-upload-alt"></span>
                                </asp:LinkButton>

                            </div>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="ProjectName" HeaderText="Project Name - Template - Job Type"
                        SortExpression="ProjectName" UniqueName="ProjectName" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <asp:HyperLink ID="hlkProjectName" runat="server" Text='<%# Eval("ProjectName")%>' NavigateUrl='<%# LocalAPI.urlProjectLocationGmap(Eval("ProjectLocation"))%>'
                                            ToolTip='<%# String.Concat("Click to view [", Eval("ProjectLocation"), "] in Google Maps")%>' Target="_blank"></asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%# String.Concat(Eval("nType"), " - ", Eval("JobType")) %>
                                    </td>
                                    <td>
                                        <%# Eval("Area") %>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="ProposalBy" HeaderText="Proposal By - Prepared By /Client"
                        SortExpression="ProposalBy" UniqueName="ProposalBy" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <div>
                                <%# String.Concat(Eval("ProposalBy"), " - ", Eval("PreparedBy")) %>
                            </div>
                            <div>
                                <asp:Label ID="ClientNameLabel" runat="server" Text='<%# Eval("ClientName")%>'></asp:Label>
                                <%# String.Concat(" - ",Eval("Company")) %>
                                <telerik:RadToolTip ID="RadToolTipContact" runat="server" TargetControlID="ClientNameLabel" RelativeTo="Element"
                                    Position="BottomCenter" RenderInPageRoot="true" Modal="True" Title="" ShowEvent="OnClick"
                                    HideDelay="300" HideEvent="LeaveTargetAndToolTip" IgnoreAltAttribute="true">
                                    <table>
                                        <tr>
                                            <td colspan="2">
                                                <asp:LinkButton ID="btnEditCli" runat="server" CommandArgument='<%# Eval("ClientId") %>'
                                                    CommandName="EditClient" Text='<%# String.Concat(LocalAPI.GetClientProperty(Eval("ClientId"), "Name")," - ",LocalAPI.GetClientProperty(Eval("ClientId"), "Company"))%>' UseSubmitBehavior="false">
                                                </asp:LinkButton>
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
                                                <telerik:RadTextBox ID="EmailText" runat="server" ReadOnly="true"
                                                    Text='<%# LocalAPI.GetClientProperty(Eval("ClientId"), "Email")%>'>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadToolTip>
                            </div>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn AllowFiltering="False" DataField="Total" DataFormatString="{0:N}" Display="false"
                        Groupable="False" HeaderText="Proposal Amount" ReadOnly="True" SortExpression="Total"
                        UniqueName="Total" HeaderStyle-Width="90px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                        FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:N}" FooterStyle-Width="90px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Date" DataFormatString="{0:MM/dd/yy}" DataType="System.DateTime"
                        HeaderText="Date" SortExpression="Date" UniqueName="Date"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" AllowFiltering="False" HeaderStyle-Width="80px">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="JobCode" HeaderText="Status - Job No." SortExpression="JobCode"
                        UniqueName="JobCode" ItemStyle-HorizontalAlign="Center"
                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="160px">
                        <ItemTemplate>
                            <div>
                                <span class='<%# LocalAPI.GetProposalStatusLabelCSS(Eval("StatusId")) %>'><%# Eval("Status") %></span>
                            </div>
                            <div>
                                <asp:LinkButton ID="btnEditJob" runat="server" CommandArgument='<%# Eval("JobId") %>' ToolTip="Click to View/Edit Job"
                                    CommandName="EditJob" Text='<%# Eval("JobCode")%>' ForeColor='<%# JobForeColor(Eval("JobId"), Eval("Status"))%>'>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="columnEmail" AllowFiltering="False"
                        ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                        <ItemTemplate>
                            <div style="vertical-align: top; padding-top: 5px">
                                <asp:LinkButton runat="server" ID="btnSendProposal" CommandName="EmailPrint" CommandArgument='<%# Eval("Id") %>' ToolTip="Send Email with Proposal information">
                                    <i class="far fa-envelope"></i>
                                </asp:LinkButton>
                            </div>
                            <asp:Label ID="lblEmitted" runat="server" Text='<%# Eval("EmailDate", "{0:d}") %>' Font-Size="X-Small" ToolTip="Emitted Date"></asp:Label>
                            <span title="Number of times sent" class="badge badge-pill badge-light" style='<%# IIf(Eval("Emitted")=0,"display:none","display:normal")%>'>
                                <%#Eval("Emitted")%>
                            </span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Note that the Proposal Accepted can not be eliminated. Delete this proposal?"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete" Display="false"
                        UniqueName="DeleteColumn" HeaderText="" HeaderStyle-HorizontalAlign="Center"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px">
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
        SelectCommand="PROPOSAL_v20_SELECT" DeleteCommand="Proposal_DELETE" DeleteCommandType="StoredProcedure"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="DateFrom" PropertyName="SelectedDate" Type="DateTime" DefaultValue="" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="DateTo" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboClients" Name="Client" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboStatus" Name="StatusId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboDepartments" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
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

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblProposalIdFromRfp" runat="server" Visible="False" Text="0"></asp:Label>

</asp:Content>
