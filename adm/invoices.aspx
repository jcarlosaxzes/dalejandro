<%@ Page Title="Receivable Invoices" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="invoices.aspx.vb" Inherits="pasconcept20.invoices" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%-- <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
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
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"  EnableEmbeddedSkins="false" />--%>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <script type="text/javascript">
        function onClientUploadFailed(sender, eventArgs) {
            alert(eventArgs.get_message())
        }
        function OnClientClose(sender, args) {
            var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
            masterTable.rebind();
        }
    </script>

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Receivable Invoices</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>
            <span id="spanViewSummary" runat="server">
                <button class="btn btn-secondary" type="button" data-toggle="collapse" data-target="#collapseSummary" aria-expanded="false" aria-controls="collapseSummary" title="Show/Hide Summary panel">
                    View Summary
                </button>
            </span>
            <asp:LinkButton ID="btnBulkSentToQB" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Sync  selected records Invoices with QuickBooks">
                Sync with QuickBooks
            </asp:LinkButton>
            <asp:LinkButton ID="btnNewInvoice" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Add Invoice Simple Change">
                    Add Invoice
            </asp:LinkButton>
        </span>

    </div>

    <div class="collapse" id="collapseFilter">
        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnRefresh">
            <table class="table-sm" style="width: 100%">
                <tr>
                    <td style="width: 200px">
                        <telerik:RadComboBox ID="cboPeriod" runat="server" Width="100%">
                            <Items>
                                <telerik:RadComboBoxItem Text="Last 30 days" Value="30" />
                                <telerik:RadComboBoxItem Text="Last 60 days" Value="60" />
                                <telerik:RadComboBoxItem Text="Last 90 days" Value="90" />
                                <telerik:RadComboBoxItem Text="Last 120 days" Value="120" />
                                <telerik:RadComboBoxItem Text="Last 180 days" Value="180" />
                                <telerik:RadComboBoxItem Text="Last 365 days" Value="365" />
                                <telerik:RadComboBoxItem Text="This year" Value="14" />
                                <telerik:RadComboBoxItem Text="This month" Value="16" />
                                <telerik:RadComboBoxItem Text="Last year" Value="15" />
                                <telerik:RadComboBoxItem Text="Last month" Value="17" />
                                <telerik:RadComboBoxItem Text="(All years...)" Value="13" Selected="true" />
                                <telerik:RadComboBoxItem Text="Custom Range..." Value="99" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 250px">
                        <telerik:RadComboBox ID="cboInvoiceStatus" runat="server" Width="100%" MarkFirstMatch="True">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="Pending Balance" Value="0" Selected="true" />
                                <telerik:RadComboBoxItem runat="server" Text="Not Yet Emitted" Value="1" />
                                <telerik:RadComboBoxItem runat="server" Text="Collected" Value="2" />
                                <telerik:RadComboBoxItem runat="server" Text="Bad Debts" Value="3" />
                                <telerik:RadComboBoxItem runat="server" Text="(All Invoices...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 350px">
                        <telerik:RadComboBox ID="cboDepartment" runat="server" DataSourceID="SqlDataSourceDepartments"
                            Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" AutoPostBack="true"
                            Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Departments...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 250px">
                        <telerik:RadComboBox ID="cboStatement" runat="server" Width="100%" MarkFirstMatch="True">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="Invoices Out Statements" Value="0" Selected="true" />
                                <telerik:RadComboBoxItem runat="server" Text="Invoices In Statements" Value="1" />
                                <telerik:RadComboBoxItem runat="server" Text="(All Invoices In/Out Statements...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>


                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" EmptyMessage="Additional search for Invoice Number, Job Name, Client Name, Description..."
                            LabelWidth="" Width="100%">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <telerik:RadComboBox ID="cboClients" runat="server" DataSourceID="SqlDataSourceClient"
                            Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" AutoPostBack="true"
                            Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Clients...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboJobs" runat="server" DataSourceID="SqlDataSourceJobs"
                            Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains"
                            Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Jobs...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboQB" runat="server" Width="100%" ToolTip="QuickBooks Filter">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="QuickBooks - Unfiltered" Value="0" Selected="true" />
                                <telerik:RadComboBoxItem runat="server" Text="Sync Clients" Value="1" />
                                <telerik:RadComboBoxItem runat="server" Text="Invoices Pending" Value="2" />
                                <telerik:RadComboBoxItem runat="server" Text="Invoices Synced" Value="3" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="text-align: right">
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
                        <td style="width: 13%; text-align: center; background-color: #43a047">
                            <span class="DashboardFont2">Collected</span><br />
                            <asp:Label ID="LabelblTotalBalance" runat="server" CssClass="DashboardFont1" Text='<%# Eval("CollectedTotal", "{0:C2}") %>'></asp:Label><br />
                            <span class="DashboardFont3">Collected</span>
                        </td>
                        <td></td>
                        <td style="width: 13%; text-align: center; background-color: #e53935">
                            <span class="DashboardFont2">Amount Due</span><br />
                            <asp:Label ID="lblTotalBilled" runat="server" CssClass="DashboardFont1" Text='<%# Eval("AmountDue", "{0:C2}") %>'></asp:Label><br />
                            <span class="DashboardFont3">Amount Due w/o Bad Debts and Not Emitted </span>
                        </td>
                        <td></td>
                        <td style="width: 13%; text-align: center; background-color: #343a40">
                            <span class="DashboardFont2">Amount Due Hit Rate</span><br />
                            <asp:Label ID="lblTotalPending" runat="server" CssClass="DashboardFont1" Text='<%# Eval("AmountDueHitRate", "{0:P2}") %>'></asp:Label><br />
                            <span class="DashboardFont3">Amount Due/(Collected + Not Collected)</span>
                        </td>
                        <td></td>
                        <td style="width: 13%; text-align: center; background-color: #343a40">
                            <span class="DashboardFont2">Collected Hit Rate</span><br />
                            <asp:Label ID="Label1" runat="server" CssClass="DashboardFont1" Text='<%# Eval("CollectionHitRate", "{0:P2}") %>'></asp:Label><br />
                            <span class="DashboardFont3">Collected/(Collected + Not Collected)</span>
                        </td>
                        <td></td>
                        <td style="width: 13%; text-align: center; background-color: #e53935">
                            <span class="DashboardFont2">Not Collected</span><br />
                            <asp:Label ID="lblTotalCollected" runat="server" CssClass="DashboardFont1" Text='<%# Eval("NotCollectedTotal", "{0:C2}") %>'></asp:Label><br />
                            <span class="DashboardFont3">Pending Collect</span>
                        </td>
                        <td></td>
                        <td style="width: 13%; text-align: center; background-color: #039be5">
                            <span class="DashboardFont2">Not Emitted</span><br />
                            <asp:Label ID="Label2" runat="server" CssClass="DashboardFont1" Text='<%# Eval("NotEmittedTotal", "{0:C2}") %>'></asp:Label><br />
                            <span class="DashboardFont3">Not Submitted to Client</span>
                        </td>
                        <td></td>
                        <td style="width: 13%; text-align: center; background-color: #e53935">
                            <span class="DashboardFont2">Bad Debts</span><br />
                            <asp:Label ID="Label3" runat="server" CssClass="DashboardFont1" Text='<%# Eval("BadDebtsTotal", "{0:C2}") %>'></asp:Label><br />
                            <span class="DashboardFont3">Bad Debts</span>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:FormView>
    </div>

    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSourceInvoices" ShowFooter="True" AutoGenerateColumns="False" AllowSorting="True" AllowAutomaticDeletes="True"
            AllowMultiRowSelection="True"
            PageSize="50" AllowPaging="true"
            Height="850px" RenderMode="Lightweight"
            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
            <ClientSettings Selecting-AllowRowSelect="true">
                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
            </ClientSettings>
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceInvoices" ShowFooter="True">
                <CommandItemSettings ShowExportToWordButton="true" ShowExportToExcelButton="true" ShowExportToPdfButton="true" ShowExportToCsvButton="true"
                    ShowRefreshButton="true" ShowAddNewRecordButton="false" />
                <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>

                <Columns>
                    <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" UniqueName="ClientSelectColumn">
                    </telerik:GridClientSelectColumn>

                    <telerik:GridBoundColumn DataField="Id" HeaderText="Id" HeaderStyle-Width="10px" UniqueName="Id" Display="false"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="qbCustomerId" HeaderText="qbCustomerId" HeaderStyle-Width="10px" UniqueName="qbCustomerId" Display="false"></telerik:GridBoundColumn>

                    <telerik:GridTemplateColumn DataField="InvoiceNumber" HeaderText="Number" SortExpression="InvoiceNumber" UniqueName="InvoiceNumber" HeaderStyle-Width="130px"
                        FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEditJob" runat="server" ToolTip="Click to Invoice" CommandArgument='<%# Eval("Id") %>' CommandName="EditInvoice" Text='<%# Eval("InvoiceNumber")%>' UseSubmitBehavior="false">
                            </asp:LinkButton>
                            <div style="float: right; vertical-align: top; margin: 0;">
                                <%--Three Point Action Menu--%>
                                <asp:HyperLink runat="server" ID="lblAction" NavigateUrl="javascript:void(0);" Style="text-decoration: none;">
                                            <i title="Click to menu for this Job" style="color:dimgray" class="fas fa-ellipsis-v"></i>
                                </asp:HyperLink>
                                <telerik:RadToolTip ID="RadToolTipAction" runat="server" TargetControlID="lblAction" RelativeTo="Element"
                                    RenderMode="Lightweight" EnableViewState="true" ShowCallout="false" RenderInPageRoot="true"
                                    Position="BottomRight" Modal="True" Title="" ShowEvent="OnClick"
                                    HideDelay="100" HideEvent="LeaveToolTip" IgnoreAltAttribute="true">
                                    <table class="table-borderless" style="width: 200px; font-size: medium">
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="btnEdit2" runat="server" UseSubmitBehavior="false" CommandName="EditInvoice" CommandArgument='<%# Eval("Id")%>' CssClass="dropdown-item">
                                                            <i class="fas fa-pencil-alt"></i>&nbsp;&nbsp;View/Edit Invoice
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="LinkButton1" runat="server" UseSubmitBehavior="false" CommandName="EditJobBilling" CommandArgument='<%# Eval("JobId")%>' CssClass="dropdown-item">
                                                            <i class="fas fa-dollar-sign"></i>&nbsp;&nbsp;View/Edit Job's Billing
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="dropdown-divider"></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="LinkButton6" runat="server" UseSubmitBehavior="false" CommandArgument='<%# Eval("Id")%>' CssClass="dropdown-item"
                                                    Visible='<%#IIf(Eval("qbCustomerId") <> 0 And Eval("qbInvoiceId ") <> 0, False, True) %>'>
                                                        <i class="far fa-envelope"></i>&nbsp;&nbsp;Send Invoice Email to Client
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href='<%# LocalAPI.GetSharedLink_URL(44, Eval("Id"), True)%>' target="_blank" class="dropdown-item">
                                                    <i class="fas fa-print"></i>&nbsp;&nbsp;Print Invoice Page
                                                </a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href='<%# LocalAPI.GetSharedLink_URL(44, Eval("Id"), False)%>' target="_blank" class="dropdown-item">
                                                    <i class="far fa-share-square"></i>&nbsp;&nbsp;View/Share Invoice Page
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
                                                <asp:LinkButton ID="LinkButton5" runat="server" UseSubmitBehavior="false" CommandName="RecivePayment" CommandArgument='<%# Eval("Id")%>' CssClass="dropdown-item" Visible='<%# Eval("AmountDue")%>'>
                                                            Receive Payment
                                                </asp:LinkButton>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td style="padding-left: 24px">
                                                <asp:LinkButton ID="LinkButton3" runat="server" UseSubmitBehavior="false" CommandName="BadDebt" CommandArgument='<%# Eval("Id")%>' CssClass="dropdown-item">
                                                            Mark Invoice as Bad Dept
                                                </asp:LinkButton>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td style="padding-left: 24px">
                                                <asp:LinkButton ID="LinkButton4" runat="server" UseSubmitBehavior="false" CommandName="SendQB" CommandArgument='<%# String.Concat(Eval("Id"), ",", Eval("qbCustomerId")) %>' CssClass="dropdown-item"
                                                    Visible='<%# iif(Eval("qbCustomerId") <> 0 And Eval("qbInvoiceId ") = 0 And IsQuickBooksEnable(), True, False) %>'>
                                                            Sync Invoice with QuickBooks
                                                </asp:LinkButton>
                                            </td>
                                        </tr>

                                    </table>
                                </telerik:RadToolTip>

                            </div>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="JobName" HeaderText="Client - Job Info" SortExpression="JobName"
                        UniqueName="JobName">
                        <ItemTemplate>
                            <asp:Label ID="lblBillingContact" runat="server" Text='<%# Eval("ClientName") %>'></asp:Label>
                            <br />
                            <%# Eval("JobInfo") %>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Amount" HeaderText="Amount" SortExpression="Amount" UniqueName="Amount"
                        Aggregate="Sum" FooterAggregateFormatString="{0:C2}"
                        HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <%# Eval("Amount", "{0:N2}") %>
                        </ItemTemplate>

                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="AmountDue" HeaderText="Amount Due" SortExpression="AmountDue" UniqueName="AmountDue"
                        Aggregate="Sum" FooterAggregateFormatString="{0:C2}" FooterStyle-ForeColor="Red"
                        HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <asp:Label ID="lblAmountDue4" runat="server" Text='<%# Eval("AmountDue", "{0:N2}") %>' Font-Strikeout='<%# iif(Eval("BadDebt") = 0, False, True) %>'
                                ToolTip='<%# iif(Eval("BadDebt") = 0, "Amount Due", "Bad Debt") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="MaturityDate" DataType="System.DateTime" HeaderText="Insights"
                        SortExpression="MaturityDate" UniqueName="Date" HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <table style="width: 100%">
                                <tr>
                                    <td style="text-align: right; width: 60px">
                                        <span style="font-size: x-small" title="First Emission Date"><%# Eval("FirstEmission", "{0:d}")%></span>
                                    </td>
                                    <td style="text-align: center; width: 30px">
                                        <span title="Number of times Sent to Client" class="badge badge-pill badge-secondary"><%#Eval("Emitted")%></span>
                                    </td>
                                    <td style="text-align: center; width: 30px">
                                        <span title="Number of times the Client has visited your Invoice Page" class="badge badge-pill badge-warning"><%#Eval("clientvisits")%></span>
                                    </td>
                                    <td style="text-align: center; width: 50px">
                                        <span title="Invoice Synced with QuickBooks" style='<%# IIf(Eval("qbInvoiceId ") <= 0,"display:none","display:normal")%>'>
                                            <img src="../Images/C2QB_green_btn_sm_default.png" height="14" /></span>
                                    </td>
                                    <td style="text-align: center;">
                                        <span title="Invoice Pending Synced with QuickBooks" style='<%# "color:red;" & IIf(Eval("qbInvoiceId ") = -1,"display:normal","display:none")%>'>qb</span>
                                    </td>
                                </tr>
                            </table>
                            <span title="Past Due Status" style="font-size: 12px; width: 100%" class='<%# LocalAPI.GetInvoicePastDueLabelCSS(Eval("pastdue_status")) %>'><%# Eval("pastdue_status") %></span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="InvoiceNotes" HeaderText="Invoice Description" SortExpression="InvoiceNotes" ItemStyle-Font-Size="X-Small"
                        UniqueName="InvoiceNotes">
                    </telerik:GridBoundColumn>
                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this Invoice?" ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn" HeaderText="" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                    </telerik:GridButtonColumn>

                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <telerik:RadToolTip ID="RadToolTipInsertPayment" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

        <h2 style="margin: 0; text-align: center; color: white; width: 600px">
            <span class="navbar navbar-expand-md bg-dark text-white">Receive Payment
            </span>
        </h2>
        <table class="table-sm" style="width: 600px">
            <tr>
                <td style="width: 140px; text-align: right">Collected Date:
                </td>
                <td>
                    <telerik:RadDatePicker ID="RadDatePickerPayment" runat="server" ZIndex="50001">
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Method:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboPaymentMethod_paym" runat="server" DataSourceID="SqlDataSourcePaymentMethod" DataTextField="Name" DataValueField="Id"
                        Filter="Contains" MarkFirstMatch="True" Width="100%" ZIndex="50001">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Amount:
                </td>
                <td>
                    <telerik:RadNumericTextBox ID="txtAmountPayment" runat="server" Width="180px">
                    </telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Notes:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtPaymentNotes" runat="server" Width="100%" MaxLength="1024" Rows="2">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">

                    <asp:LinkButton ID="btnInsertPayment" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false"
                        CommandName="Update"> Insert
                    </asp:LinkButton>

                    &nbsp;&nbsp;&nbsp;&nbsp;

                    <asp:LinkButton ID="btnCancelPayment" runat="server" CssClass="btn btn-secondary btn-lg" UseSubmitBehavior="false"
                        CommandName="Cancel"> Cancel
                    </asp:LinkButton>
                </td>
            </tr>

            <tr>
                <td colspan="2">
                    <asp:Panel ID="PanelUpload" runat="server" class="uploadfiles-canvas">
                        <%-- <span style="font-size: 36px">Drop Files here, or
                        </span>
                        <telerik:RadCloudUpload ID="RadCloudUpload1" runat="server" MultipleFileSelection="Disabled" OnClientUploadFailed="onClientUploadFailed"
                            OnFileUploaded="RadCloudUpload1_FileUploaded" ProviderType="Azure"
                            MaxFileSize="10145728"
                            CssClass="fileUploadRad"
                            DropZones=".uploadfiles-canvas">
                        </telerik:RadCloudUpload>--%>
                        <p style="text-align: center; vertical-align: middle; padding-top: 50px;">
                            <i style="font-size: 96px" class="fas fa-cloud-upload-alt"></i>
                            <br />
                            <span style="font-size: 36px">Drop Files here, or
                            </span>
                            <br />
                            <br />
                            <br />
                            <span style="font-size: 36px">
                                <telerik:RadCloudUpload ID="RadCloudUpload1" runat="server" RenderMode="Lightweight" ProviderType="Azure" MaxFileSize="10145728" MultipleFileSelection="Disabled"
                                    OnFileUploaded="RadCloudUpload1_FileUploaded"
                                    OnClientUploadFailed="onClientUploadFailed"
                                    CssClass="fileUploadRad"
                                    DropZones=".uploadfiles-canvas,#UploadPanel">
                                    <Localization SelectButtonText="Select Files" />
                                </telerik:RadCloudUpload>
                            </span>
                        </p>
                        <p style="text-align: center; margin: 0">
                            <asp:Label runat="server" ID="lblMaxSize" ForeColor="Gray" Font-Size="Small" Text="[Maximum upload size per file: 1MB]"></asp:Label>
                        </p>

                    </asp:Panel>
                </td>
            </tr>

        </table>
    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipEditInvoice" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; color: white; width: 600px">
            <span class="navbar navbar-expand-md bg-dark text-white">Edit Invoice
            </span>
        </h2>

        <asp:FormView ID="FormViewInvoice" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceInvoice" DefaultMode="Edit">
            <EditItemTemplate>
                <table class="table-sm" style="width: 600px">

                    <tr>
                        <td colspan="2">
                            <h4><%#IIf(Eval("InvoiceType") = 1, "Invoice Hourly Rate", "Invoice Simple Charge") %></h4>
                        </td>
                    </tr>

                    <tr>
                        <td style="width: 120px">Number:
                        </td>
                        <td>
                            <h4 style="margin: 0"><%# Eval("InvoiceNumber") %></h4>
                        </td>
                    </tr>
                    <tr>
                        <td>Created Date:
                        </td>
                        <td>
                            <telerik:RadDatePicker ID="RadDatePicker1" runat="server" ZIndex="50001" DbSelectedDate='<%# Bind("InvoiceDate") %>'>
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td>Due Date:
                        </td>
                        <td>
                            <telerik:RadDatePicker ID="RadDatePickerMaturityDate" runat="server" ZIndex="50001" DbSelectedDate='<%# Bind("MaturityDate") %>'>
                            </telerik:RadDatePicker>
                        </td>
                    </tr>


                    <tr>
                        <td>Amount:
                        </td>
                        <td>
                            <telerik:RadNumericTextBox ID="AmountRadNumericTextBoxInv" runat="server" DbValue='<%# Bind("Amount") %>'
                                Enabled='<%# iif(Eval("InvoiceType") = 1, "false", "true") %>'>
                            </telerik:RadNumericTextBox>
                        </td>
                    </tr>
                </table>
                <asp:Panel runat="server" ID="Panel1" Visible='<%#IIf(Eval("InvoiceType") = 1, "true", "false") %>'>
                    <table class="table-sm" style="width: 600px">
                        <tr>
                            <td style="width: 120px">Hours:</td>
                            <td>
                                <telerik:RadNumericTextBox ID="RadNumericTimeInv" runat="server" DbValue='<%# Bind("Time") %>'>
                                </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>x Rate</td>
                            <td>
                                <telerik:RadNumericTextBox ID="RadNumericTextBoxRateInv" runat="server" DbValue='<%# Bind("Rate") %>'>
                                </telerik:RadNumericTextBox>
                                <span class="small"><%#IIf(Eval("InvoiceType") = 1, "Invoice Amount update, affects the Job.Budget!!!", "") %></span>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <table class="table-sm" style="width: 600px">
                    <tr>
                        <td style="width: 120px">Notes</td>
                        <td>
                            <telerik:RadTextBox ID="txtInvoiceNotes" runat="server" MaxLength="1024" Text='<%# Bind("InvoiceNotes") %>'
                                TextMode="MultiLine" Width="100%" Rows="4">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Recurrence Days:</td>
                        <td>
                            <telerik:RadNumericTextBox ID="RadNumericTextBoxRecurrence" runat="server" DbValue='<%# Bind("EmissionRecurrenceDays") %>'
                                MinValue="0" MaxValue="365">
                                <NumberFormat DecimalDigits="0" />
                            </telerik:RadNumericTextBox>
                        </td>
                    </tr>
                </table>
                <table class="table-sm" style="width: 600px">
                    <tr>
                        <td style="text-align: center">
                            <asp:LinkButton ID="btnUpdateInvoice" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false"
                                CommandName="Update"> Update
                            </asp:LinkButton>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:LinkButton ID="btnCancelInvoice" runat="server" CssClass="btn btn-secondary btn" UseSubmitBehavior="false"
                                CommandName="Cancel"> Cancel
                            </asp:LinkButton>
                        </td>
                    </tr>

                </table>
            </EditItemTemplate>
        </asp:FormView>

    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipNewInvoice" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; color: white; width: 600px">
            <span class="navbar navbar-expand-md bg-dark text-white">New Invoice
            </span>
        </h2>

        <table class="table-sm" style="width: 600px">
            <tr>
                <td>
                    <telerik:RadComboBox ID="cboJobNewInvoice" runat="server" DataSourceID="SqlDataSourceJobs" ZIndex="50001" Label="Job:"
                        Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains"
                        Height="300px" AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(All Jobs...)" Value="-1" Selected="true" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <br />
                    <br />
                    <br />
                    <br />
                    <asp:LinkButton ID="btnNewSimpleChargeInvoice" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false"
                        CommandName="Update"> Insert
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Clients].[Id], [Name]+' [' + isnull(Company,'...') + ']' As Name FROM [Clients] inner join Jobs on [Clients].Id=Jobs.Client WHERE [Clients].companyId=@companyId GROUP BY [Clients].[Id], [Name], Company  ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceJobs" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT  Jobs.Id, Jobs.Code + ' ' + Jobs.Job + ' [' + isnull(Jobs_status.Name,'...')+']' AS [Name] FROM Jobs LEFT OUTER JOIN Jobs_status ON Jobs.Status = Jobs_status.Id WHERE companyId=@companyId  and Client=case when @ClientId=-1 then Client else @ClientId end ORDER BY Jobs.Code desc">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboClients" Name="ClientId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSourceInvoices" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Invoices_v20_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="INVOICE_DELETE" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="DateFrom" PropertyName="SelectedDate" Type="DateTime" DefaultValue="" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="DateTo" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboClients" Name="ClientId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboJobs" Name="JobId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboDepartment" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboInvoiceStatus" Name="InvoiceStatus" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboStatement" Name="StatementStatus" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboQB" Name="qbFilter" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Find" PropertyName="Text" Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceInvoice" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="INVOICE2_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="INVOICE2_UPDATE" UpdateCommandType="StoredProcedure"
        InsertCommand="INVOICE2_INSERT" InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblInvoiceId" Name="Id" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="lblInvoiceId" Name="Id" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="InvoiceDate" Type="DateTime" />
            <asp:Parameter Name="Time" Type="Double" />
            <asp:Parameter Name="Rate" Type="Double" />
            <asp:Parameter Name="Amount" Type="Double" />
            <asp:Parameter Name="InvoiceNotes" Type="String" />
            <asp:Parameter Name="MaturityDate" Type="DateTime" />
            <asp:Parameter Name="EmissionRecurrenceDays" Type="Int16" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="JobId" PropertyName="Text" />
            <asp:Parameter Name="InvoiceDate" Type="DateTime" />
            <asp:Parameter Name="Time" Type="Double" />
            <asp:Parameter Name="Rate" Type="Double" />
            <asp:Parameter Name="Amount" Type="Double" />
            <asp:Parameter Name="InvoiceNotes" Type="String" />
            <asp:Parameter Name="MaturityDate" Type="DateTime" />
            <asp:Parameter Name="EmissionRecurrenceDays" Type="Int16" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePaymentMethod" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Payment_methods ORDER BY Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourcePayments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="INVOICE_PAYMENTS_v20_INSERT" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblInvoiceId" Name="InvoiceId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="RadDatePickerPayment" Name="CollectedDate" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboPaymentMethod_paym" Name="Method" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtAmountPayment" Name="Amount" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtPaymentNotes" Name="CollectedNotes" PropertyName="Text" Type="String" />

            <asp:ControlParameter ControlID="lblOriginalFileName" Name="OriginalFileName" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="lblKeyName" Name="KeyName" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="lblContentBytes" Name="ContentBytes" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblContentType" Name="ContentType" PropertyName="Text" Type="String" />
            <asp:Parameter Name="paymentId" Direction="Output" Type="Int32" DefaultValue="0" />
            
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceViewSummary" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="InvoicesViewSummary_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="DateFrom" PropertyName="SelectedDate" Type="DateTime" DefaultValue="" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="DateTo" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboClients" Name="ClientId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboJobs" Name="JobId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboDepartment" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboStatement" Name="StatementStatus" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Find" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


    <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" DateFormat="MM/dd/yyyy" Culture="en-US" ToolTip="Date From for filter" Visible="false">
    </telerik:RadDatePicker>
    <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" DateFormat="MM/dd/yyyy" Culture="en-US" ToolTip="Date To for Filter" Visible="false">
    </telerik:RadDatePicker>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblInvoiceId" runat="server" Visible="False"></asp:Label>

    <asp:Label ID="lblOriginalFileName" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblKeyName" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblContentBytes" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblContentType" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblStatus" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
</asp:Content>
