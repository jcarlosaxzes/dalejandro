<%@ Page Title="Invoices" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="invoices.aspx.vb" Inherits="pasconcept20.invoices" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function onRequestStart(sender, args) {
            if (args.get_eventTarget().indexOf("ExportTo") >= 0) {
                args.set_enableAjax(false);
            }
        }
        function onClientUploadFailed(sender, eventArgs) {
            alert(eventArgs.get_message())
        }
        function OnClientClose(sender, args) {
            var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
            masterTable.rebind();
        }
    </script>

    <%--    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
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
                    <telerik:AjaxUpdatedControl ControlID="lblStatus" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />--%>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
    </telerik:RadWindowManager>


    <div class="Formulario">
        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnRefresh">
            <table class="table-condensed" style="width:100%">
                <tr>
                    <td width="150px" align="left">
                        <telerik:RadComboBox ID="cboPeriod" runat="server" Width="100%">
                            <Items>
                                <telerik:RadComboBoxItem Text="(Last 30 days)" Value="30" />
                                <telerik:RadComboBoxItem Text="(Last 60 days)" Value="60" />
                                <telerik:RadComboBoxItem Text="(Last 90 days)" Value="90" />
                                <telerik:RadComboBoxItem Text="(Last 120 days)" Value="120" />
                                <telerik:RadComboBoxItem Text="(Last 180 days)" Value="180" />
                                <telerik:RadComboBoxItem Text="(Last 365 days)" Value="365" />
                                <telerik:RadComboBoxItem Text="(This year)" Value="14" />
                                <telerik:RadComboBoxItem Text="(All years...)" Value="13" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td width="250px">
                        <telerik:RadComboBox ID="cboInvoiceStatus" runat="server" Width="100%" MarkFirstMatch="True">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="Not Collected or Partially" Value="0" Selected="true" />
                                <telerik:RadComboBoxItem runat="server" Text="Pending to Emit" Value="1" />
                                <telerik:RadComboBoxItem runat="server" Text="Collected" Value="2" />
                                <telerik:RadComboBoxItem runat="server" Text="Bad Debts" Value="3" />
                                <telerik:RadComboBoxItem runat="server" Text="(All Invoices...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="width:250px">
                        <telerik:RadComboBox ID="cboStatement" runat="server" Width="100%" MarkFirstMatch="True">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="Invoices Out Statements" Value="0" Selected="true" />
                                <telerik:RadComboBoxItem runat="server" Text="Invoices In Statements" Value="1" />
                                <telerik:RadComboBoxItem runat="server" Text="(All Invoices In/Out Statements...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>

                    </td>
                    <td style="width:250px">
                        <telerik:RadComboBox ID="cboDepartment" runat="server" DataSourceID="SqlDataSourceDepartments"
                            Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" AutoPostBack="true"
                            Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Departments...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>

                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" EmptyMessage="Additional search for Invoice Number, Job Name, Client Name, Description..."
                            LabelWidth="" Width="100%">
                        </telerik:RadTextBox>
                    </td>
                </tr>
            </table>
            <table class="table-condensed" style="width:100%">
                <tr>
                    <td>
                        <telerik:RadComboBox ID="cboClients" runat="server" DataSourceID="SqlDataSourceClient"
                            Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" AutoPostBack="true"
                            Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Clients...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td colspan="2">
                        <telerik:RadComboBox ID="cboJobs" runat="server" DataSourceID="SqlDataSourceJobs"
                            Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains"
                            Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Jobs...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 100px; text-align: right">
                        <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                    <span class="glyphicon glyphicon-search"></span> Search
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:Panel>

    </div>
    <div class="Formulario">
        <table class="table-condensed" style="width: 100%">
            <tr>
                <td>
                    <asp:LinkButton ID="btnNewInvoice" runat="server" CssClass="btn btn-info btn" UseSubmitBehavior="false" ToolTip="Add New Invoice">
                    <span class="glyphicon glyphicon-plus"></span> Simple Charge
                    </asp:LinkButton>
                </td>
                <td style="text-align: right; padding-right: 50px">
                    <asp:Label ID="lblStatus" runat="server"></asp:Label>
                </td>

            </tr>
        </table>
    </div>
    <div>
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
            <script type="text/javascript">
                var popUp;
                function PopUpShowing(sender, eventArgs) {
                    popUp = eventArgs.get_popUp();
                    var gridWidth = sender.get_element().offsetWidth;
                    var gridHeight = sender.get_element().offsetHeight;
                    var popUpWidth = popUp.style.width.substr(0, popUp.style.width.indexOf("px"));
                    var popUpHeight = "800px"//popUp.style.height.substr(0, popUp.style.height.indexOf("px"));
                    popUp.style.left = ((gridWidth - popUpWidth) / 2 + sender.get_element().offsetLeft).toString() + "px";
                    popUp.style.top = "0px";
                }
            </script>
        </telerik:RadCodeBlock>
        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSourceInvoices" ShowFooter="True" AutoGenerateColumns="False" AllowSorting="True"
            PageSize="100" AllowPaging="true"  AllowAutomaticDeletes="True"
            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small">
            <ClientSettings>
                <ClientEvents OnPopUpShowing="PopUpShowing" />
            </ClientSettings>
            <MasterTableView DataKeyNames="Id" ClientDataKeyNames="Id" DataSourceID="SqlDataSourceInvoices" ShowFooter="True"
                EditMode="PopUp">
                <CommandItemSettings ShowExportToWordButton="true" ShowExportToExcelButton="true" ShowExportToPdfButton="true" ShowExportToCsvButton="true"
                    ShowRefreshButton="true" ShowAddNewRecordButton="false" />
                <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>

                <Columns>
                    <telerik:GridTemplateColumn DataField="Id" FilterControlAltText="Filter Id column"
                        HeaderText="Number" SortExpression="InvoiceNumber" UniqueName="Id"
                        HeaderStyle-Width="120px"
                        FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEditJob" runat="server" ToolTip="Click to Invoice" CommandArgument='<%# Eval("Id") %>' Font-Size="Small"
                                CommandName="EditInvoice" Text='<%# Eval("InvoiceNumber")%>' UseSubmitBehavior="false">
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="JobName" HeaderText="Client/Job Info" SortExpression="JobName"
                        UniqueName="JobName">
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td>

                                        <asp:Label ID="lblBillingContact" runat="server" Text='<%# Eval("ClientName") %>' CssClass="lnkGrid"></asp:Label>
                                        <telerik:RadToolTip ID="RadToolTipContact" runat="server" TargetControlID="lblBillingContact" RelativeTo="Element"
                                            Position="MiddleLeft" RenderInPageRoot="true" Modal="True" Title="<b>Billing Contact Information</b>" ShowEvent="OnClick"
                                            HideDelay="300" HideEvent="LeaveTargetAndToolTip" IgnoreAltAttribute="true">
                                            <table>
                                                <tr>
                                                    <td>Billing Contact:&nbsp;<b><%# Eval("BillingContact")%></b></td>
                                                </tr>
                                                <tr>
                                                    <td>Client Name:&nbsp;<b><%# Eval("ClientName")%></b></td>
                                                </tr>
                                                <tr>
                                                    <td>Phone:&nbsp;<b><%# Eval("Phone")%></b></td>
                                                </tr>
                                                <tr>
                                                    <td>Cellular:&nbsp;<b><%# Eval("Cellular")%></b></td>
                                                </tr>
                                                <tr>
                                                    <td>Email:&nbsp;<b><%# Eval("Email")%></b></td>
                                                </tr>
                                            </table>
                                        </telerik:RadToolTip>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="color: darkblue">
                                        <%# Eval("JobInfo") %>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="MaturityDate" DataType="System.DateTime" HeaderText="Emitted<br/>Past Due"
                        SortExpression="MaturityDate" UniqueName="Date" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblEmitted" runat="server" Text='<%# String.Concat(Eval("FirstEmission", "{0:d}"), " (", Eval("Emitted").ToString, ")")%>' CssClass="lnkGrid"></asp:Label>
                                        <telerik:RadToolTip ID="RadToolTipEmitted" runat="server" TargetControlID="lblEmitted" RelativeTo="Element"
                                            Position="MiddleLeft" RenderInPageRoot="true" Modal="True" Title="<b>Emitted Information</b>" ShowEvent="OnClick"
                                            HideDelay="300" HideEvent="LeaveTargetAndToolTip" IgnoreAltAttribute="true">
                                            <table>
                                                <tr>
                                                    <td>Emitted:&nbsp;<b><%# Eval("Emitted")%></b>&nbsp;time(s)
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>First time:&nbsp;<b><%# Eval("FirstEmission", "{0:d}")%></b></td>
                                                </tr>
                                                <tr>
                                                    <td>Last time:&nbsp;<b><%# Eval("LatestEmission", "{0:d}")%></b></td>
                                                </tr>
                                            </table>
                                        </telerik:RadToolTip>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: center">
                                        <span title="Past Due Status" class="<%# LocalAPI.GetInvoicePastDueLabelCSS(Eval("pastdue_status")) %>"><%# Eval("pastdue_status") %></span>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="AmountDue" HeaderText="Amount<br/>Amount Due" SortExpression="AmountDue" UniqueName="AmountDue"
                        Aggregate="Sum" FooterAggregateFormatString="{0:C2}" FooterStyle-ForeColor="Red"
                        HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <%# Eval("Amount", "{0:N2}") %>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="color: darkred">
                                        <asp:Label ID="lblAmountDue4" runat="server" Text='<%# Eval("AmountDue", "{0:N2}") %>' Font-Strikeout='<%# iif(Eval("BadDebt") = 0, False, True) %>'
                                            tooltip='<%# iif(Eval("BadDebt") = 0, "Amount Due", "Bad Debt") %>'></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>

                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="InvoiceNotes" HeaderText="Invoice Description" SortExpression="InvoiceNotes"
                        UniqueName="InvoiceNotes">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="column"
                        HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnInvoiceInv44" runat="server" UseSubmitBehavior="false" CommandName="SendInvoice" CommandArgument='<%# Eval("Id") %>'
                                ToolTip="Send Email with Invoice information" CausesValidation="false">
                                        <span class="glyphicon glyphicon-envelope"></span>
                            </asp:LinkButton>
                            &nbsp;
                                    <a class="glyphicon glyphicon-share" title="View Invoice Page to share link" href='<%# Eval("Id", "../ADMCLI/ShareLink.aspx?ObjType=44&ObjId={0}")%>' target="_blank" aria-hidden="true"></a>
                            &nbsp;
                                    <asp:LinkButton ID="btnInvoicePayment" runat="server" CssClass="label-success label" UseSubmitBehavior="false" CommandName="RecibePayment" CommandArgument='<%# Eval("Id") %>'
                                        ToolTip="Add New Payments" CausesValidation="false" Visible='<%# Eval("AmountDue")%>'>
                                        <span class="glyphicon glyphicon-usd"></span>
                                    </asp:LinkButton>
                            &nbsp;
                                    <asp:LinkButton ID="btnBadDebt" runat="server" CssClass="label-danger label" UseSubmitBehavior="false" CommandName="BadDebt" CommandArgument='<%# Eval("Id") %>' Visible='<%# Eval("BadDebt") = 0%>'
                                        ToolTip="Mark Invoice as BadDept" CausesValidation="false">
                                        <span class="glyphicon glyphicon-bitcoin"></span>
                                    </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this Invoice?"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn" HeaderText="" HeaderStyle-HorizontalAlign="Center"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px">
                    </telerik:GridButtonColumn>

                </Columns>
            </MasterTableView>

            <ClientSettings>
                <Virtualization EnableVirtualization="false" InitiallyCachedItemsCount="1000" LoadingPanelID="RadAjaxLoadingPanel1"
                    ItemsPerView="100" EnableCurrentPageScrollOnly="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="680px" />
            </ClientSettings>
        </telerik:RadGrid>

    </div>

    <telerik:RadToolTip ID="RadToolTipInsertPayment" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode"
        Title="<b>Receive Payment</b>">
        <table class="table table-condensed" style="width: 500px">
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
                    <telerik:RadNumericTextBox ID="txtAmountPayment" runat="server" Width="60px">
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
                <td colspan="2">
                    <asp:Panel ID="PanelUpload" runat="server" class="DropZone1">
                        <h4>Select or Drag and Drop files (up to 10Mb)</h4>
                        <telerik:RadCloudUpload ID="RadCloudUpload1" runat="server" MultipleFileSelection="Disabled" OnClientUploadFailed="onClientUploadFailed"
                            OnFileUploaded="RadCloudUpload1_FileUploaded" ProviderType="Azure"
                            MaxFileSize="10145728"
                            DropZones=".DropZone1">
                        </telerik:RadCloudUpload>
                    </asp:Panel>
                </td>
            </tr>

            <tr>
                <td colspan="2" style="text-align: center">

                    <asp:LinkButton ID="btnInsertPayment" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false"
                        CommandName="Update"> Insert
                    </asp:LinkButton>

                    &nbsp;&nbsp;&nbsp;&nbsp;

                    <asp:LinkButton ID="btnCancelPayment" runat="server" CssClass="btn btn-default btn" UseSubmitBehavior="false"
                        CommandName="Cancel"> Cancel
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipEditInvoice" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode"
        Title="<b>Edit Invoice</b>">
        <asp:FormView ID="FormViewInvoice" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceInvoice" DefaultMode="Edit">
            <EditItemTemplate>
                <table class="table table-condensed" style="width: 600px">
                    
                    <tr>
                        <td colspan="2">
                            <h4><%#IIf(Eval("InvoiceType") = 1, "Invoice Hourly Rate", "Invoice Simple Charge") %></h4>
                        </td>
                    </tr>

                    <tr>
                        <td style="width: 120px">Number:
                        </td>
                        <td>
                            <h4 style="margin:0"><%# Eval("InvoiceNumber") %></h4>
                        </td>
                    </tr>
                    <tr>
                        <td >Created Date:
                        </td>
                        <td>
                            <telerik:RadDatePicker ID="RadDatePicker1" runat="server" ZIndex="50001" DbSelectedDate='<%# Bind("InvoiceDate") %>'>
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td >Due Date:
                        </td>
                        <td>
                            <telerik:RadDatePicker ID="RadDatePickerMaturityDate" runat="server" ZIndex="50001" DbSelectedDate='<%# Bind("MaturityDate") %>'>
                            </telerik:RadDatePicker>
                        </td>
                    </tr>


                    <tr>
                        <td >Amount:
                        </td>
                        <td>
                            <telerik:RadNumericTextBox ID="AmountRadNumericTextBoxInv" runat="server" DbValue='<%# Bind("Amount") %>'
                                Enabled='<%# iif(Eval("InvoiceType") = 1, "false", "true") %>'>
                            </telerik:RadNumericTextBox>
                        </td>
                    </tr>
                </table>
                <asp:Panel runat="server" ID="Panel1" Visible='<%#IIf(Eval("InvoiceType") = 1, "true", "false") %>'>
                    <table class="table table-condensed" style="width: 600px">
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
                <table class="table table-condensed" style="width: 600px">
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
                <table class="table table-condensed" style="width: 600px">
                    <tr>
                        <td style="text-align: center">
                            <asp:LinkButton ID="btnUpdateInvoice" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false"
                                CommandName="Update"> Update
                            </asp:LinkButton>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:LinkButton ID="btnCancelInvoice" runat="server" CssClass="btn btn-default btn" UseSubmitBehavior="false" Text=""
                                CommandName="Cancel"> Cancel
                            </asp:LinkButton>
                        </td>
                    </tr>

                </table>
            </EditItemTemplate>
        </asp:FormView>

    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipNewInvoice" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode"
        Title="<b>New Invoice</b>">
        <table class="table table-condensed" style="width: 600px">
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
                    <asp:LinkButton ID="btnNewSimpleChargeInvoice" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false"
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
        SelectCommand="INVOICES4_SELECT" SelectCommandType="StoredProcedure"
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
        InsertCommand="INVOICE_PAYMENTS3_INSERT" InsertCommandType="StoredProcedure">
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
        </InsertParameters>
    </asp:SqlDataSource>
    <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" DateFormat="MM/dd/yyyy" Width="100%" Culture="en-US" ToolTip="Date From for filter" Visible="false">
    </telerik:RadDatePicker>
    <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" DateFormat="MM/dd/yyyy" Width="100%" Culture="en-US" ToolTip="Date To for Filter" Visible="false">
    </telerik:RadDatePicker>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblInvoiceId" runat="server" Visible="False"></asp:Label>

    <asp:Label ID="lblOriginalFileName" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblKeyName" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblContentBytes" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblContentType" runat="server" Visible="False"></asp:Label>

</asp:Content>
