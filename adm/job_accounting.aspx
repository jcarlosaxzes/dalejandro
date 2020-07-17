<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterJOB.Master" CodeBehind="job_accounting.aspx.vb" Inherits="pasconcept20.Job_accounting" Async="true" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/MasterJOB.master" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <script type="text/javascript">
        function onClientUploadFailed(sender, eventArgs) {
            alert(eventArgs.get_message())
        }
        function OnClientIncoicesClose(sender, args) {
            var masterTable = $find("<%= RadGridIncoices.ClientID%>").get_masterTableView();
            masterTable.rebind();
        }

    </script>
    <div class="container">

        <div class="row">
            <div class="col-12">
                <asp:FormView ID="FormViewClientBalance" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceClientBalance" Width="100%">
                    <ItemTemplate>

                        <table class="table-sm" style="width: 100%">
                            <tr>
                                <td style="text-align: left; vertical-align: top; width: 33%">
                                    <h3 style="margin: 0; text-align: center">
                                        <span class="navbar navbar-expand-md bg-dark text-white">Client</span>
                                    </h3>
                                        <table class="table-sm" style="width: 100%">
                                            <tr>
                                                <td>
                                                    <h4 style="margin: 3px"><%# Eval("ClientName")%></h4>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <%# Eval("ClientCompany") %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <small><%# Eval("ClientFullAddress")%></small>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <%# LocalAPI.PhoneHTML(Request.UserAgent, Eval("Phone"))%>
                                                </td>
                                            </tr>
                                        </table>
                                </td>
                                <td style="width: 33%; text-align: center; vertical-align: top">
                                    <h3 style="margin: 0; text-align: center"><span class="navbar navbar-expand-md bg-dark text-white">Projects</span></h3>
                                    </h3>
                                        <table class="table-sm" style="width: 100%">
                                            <tr>
                                                <td style="text-align: right"># Pending Proposals:</td>
                                                <td style="width: 120px; text-align: right">
                                                    <b><%# Eval("NumberPendingProposal", "{0:N0}") %></b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right">Accepted Proposals:</td>
                                                <td style="text-align: right">
                                                    <b><%# Eval("ProposalAmount", "{0:C2}") %></b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right;">Jobs Total Amount:</td>
                                                <td style="text-align: right">
                                                    <b><%# Eval("ContractAmount", "{0:C2}") %></b>
                                                </td>
                                            </tr>
                                        </table>
                                </td>
                                <td style="text-align: right; vertical-align: top">
                                    <h3 style="margin: 0; text-align: center"><span class="navbar navbar-expand-md bg-dark text-white">Balance</span></h3>
                                        <table class="table-sm" style="width: 100%">
                                            <tr>
                                                <td style="text-align: right;">Amount Paid:</td>
                                                <td>
                                                    <b><%# Eval("AmountPaid", "{0:C2}") %></b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right;">Remaining Balance:</td>
                                                <td>
                                                    <b><%# Eval("Balance","{0:C2}") %></b>
                                                </td>
                                            </tr>
                                        </table>
                                </td>
                            </tr>
                        </table>


                    </ItemTemplate>
                </asp:FormView>
                <hr style="margin: 0" />
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <table class="table-sm" style="width: 100%">
                    <tr>
                        <td style="width: 300px">
                            <telerik:RadComboBox ID="cboInvoicesType" runat="server" DataSourceID="SqlDataSourceInvoicesTypes"
                                DataTextField="Name" DataValueField="Id" Width="100%" MarkFirstMatch="True" Skin="Bootstrap"
                                Filter="Contains" Height="300px" AppendDataBoundItems="true">
                                <Items>
                                    <telerik:RadComboBoxItem Text="(Select Payment Schedules)" Value="-1" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                        <td style="width: 150px">
                            <asp:LinkButton ID="btnInvoice" runat="server" CssClass="btn btn-info btn-sm" UseSubmitBehavior="false" CausesValidation="false">
                                                                     <i class="fas fa-plus"></i> Schedules (%)
                            </asp:LinkButton>
                        </td>
                        <td style="width: 150px">
                            <asp:LinkButton ID="btnNewInvoice" runat="server" CssClass="btn btn-info btn-sm" UseSubmitBehavior="false" CausesValidation="false">
                                                                     <i class="fas fa-plus"></i> Simple Charge
                            </asp:LinkButton>
                        </td>
                        <td>
                            <asp:LinkButton ID="btnDiscount" runat="server" CssClass="btn btn-danger btn-sm" UseSubmitBehavior="false" CausesValidation="false">
                                Apply Discount
                            </asp:LinkButton>
                        </td>
                        <td style="text-align: right; width: 370px">
                            <telerik:RadComboBox ID="cboInvoiceFilterCode" runat="server" Width="100%" Skin="Bootstrap" AutoPostBack="true" Label="Invoices Filter:">
                                <Items>
                                    <telerik:RadComboBoxItem Text="Pending Balance Invoices" Value="1" />
                                    <telerik:RadComboBoxItem Text="All Invoices" Value="0" />
                                    <telerik:RadComboBoxItem Text="Paid Invoice" Value="2" />
                                    <telerik:RadComboBoxItem Text="Simple Charge Invoices" Value="3" />
                                    <telerik:RadComboBoxItem Text="Hourly Rate Invoices" Value="4" />
                                    <telerik:RadComboBoxItem Text="Non Emitted Invoices" Value="5" />
                                    <telerik:RadComboBoxItem Text="BadDept Invoices" Value="6" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                </table>
            </div>

        </div>
        <div class="row">
            <div class="col-12">
                <asp:FormView ID="FormViewStatus" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceJob" DefaultMode="Edit" Width="100%">
                    <EditItemTemplate>
                        <table style="width: 100%">
                            <tr>
                                <td>
                                    <h4>Invoices(s)</h4>
                                </td>
                                <td style="width: 180px">
                                    <telerik:RadNumericTextBox ID="txtBudgest" runat="server" DbValue='<%# Bind("Budget") %>' Width="100%" Label="Budget:">
                                    </telerik:RadNumericTextBox>
                                </td>

                                <td style="width: 180px; text-align: right">
                                    <telerik:RadCheckBox ID="chkAllowOpenBudget" runat="server" Checked='<%# Bind("AllowOpenBudget") %>' Text="Allow Open Budget"
                                        ToolTip="Automatically update the Budget when Invoices are inserted or updated. Budget=SUM(Invoices.Amount)" />
                                </td>

                                <td style="width: 280px; text-align: right">
                                    <telerik:RadComboBox ID="cboStatus" runat="server" SelectedValue='<%# Bind("Status") %>' Label="Status"
                                        DataSourceID="SqlDataSourceJobStatus" DataTextField="Name" DataValueField="Id" Width="90%">
                                    </telerik:RadComboBox>
                                </td>
                                <td style="width: 100px; text-align: right">
                                    <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success btn-sm" UseSubmitBehavior="false" ToolTip="Update Job Info" ValidationGroup="JobUpdate" CommandName="Update">
                                    Update Job
                                    </asp:LinkButton>
                                </td>
                                <td></td>
                            </tr>
                        </table>
                    </EditItemTemplate>
                </asp:FormView>
                <telerik:RadGrid ID="RadGridIncoices" runat="server" AllowAutomaticDeletes="True" HeaderStyle-HorizontalAlign="Center"
                    AutoGenerateColumns="False" DataSourceID="SqlDataSourceInvoices" 
                    ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" HeaderStyle-Font-Size="Small" FooterStyle-Font-Size="X-Small"
                    ShowFooter="True" Width="100%" >
                    <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceInvoices" AllowSorting="true"
                        >
                        <CommandItemSettings ExportToPdfText="Export to PDF" />
                        <RowIndicatorColumn>
                            <HeaderStyle Width="20px" />
                        </RowIndicatorColumn>
                        <ExpandCollapseColumn Resizable="False" Visible="False">
                            <HeaderStyle Width="20px" />
                        </ExpandCollapseColumn>
                        <Columns>
                            <telerik:GridTemplateColumn DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column"
                                HeaderText="Invoice" HeaderTooltip="Invoice Number" SortExpression="InvoiceNumber" UniqueName="InvoiceNumber" ReadOnly="true" Aggregate="Count" FooterAggregateFormatString="{0:N0}"
                                 HeaderStyle-Width="120px" FooterStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkEditInvoice" runat="server" CommandName="EditInvoice" CommandArgument='<%# Eval("Id") %>'
                                        Text='<%# Eval("InvoiceNumber") %>' ToolTip="Click to Edit Invoice"></asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="InvoiceType" DataType="System.Int32" ReadOnly="true"
                                FilterControlAltText="Filter InvoiceType column" HeaderText="Type" SortExpression="InvoiceType"
                                UniqueName="InvoiceType" 
                                ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="20px">
                                <ItemTemplate>
                                    <asp:Label ID="typeLabelInv" runat="server" Text='<%#IIf(Eval("InvoiceType") = 1, "hr", "sc") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridDateTimeColumn DataField="InvoiceDate" DataFormatString="{0:MM/dd/yy}"
                                FilterControlAltText="Filter InvoiceDate column" HeaderText="Date Created" SortExpression="InvoiceDate" Display="false"
                                UniqueName="InvoiceDate"  ItemStyle-HorizontalAlign="Right">
                            </telerik:GridDateTimeColumn>
                            <telerik:GridDateTimeColumn DataField="MaturityDate" DataFormatString="{0:MM/dd/yy}"
                                FilterControlAltText="Filter MaturityDate column" HeaderText="Due Date" HeaderStyle-Width="120px"
                                SortExpression="MaturityDate" UniqueName="MaturityDate">
                            </telerik:GridDateTimeColumn>
                            <telerik:GridTemplateColumn DataField="Amount" HeaderText="Amount" HeaderTooltip="Invoice Amount" SortExpression="Amount"
                                UniqueName="Amount" FilterControlAltText="Filter Amount column" HeaderStyle-Width="60px"  ItemStyle-HorizontalAlign="Right"
                                Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-Width="120px"
                                FooterStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <asp:Label ID="AmountLabelInv" runat="server" Text='<%# Eval("Amount", "{0:N2}") %>'
                                        ForeColor='<%# GetColor(Eval("Amount")) %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="AmountDue" HeaderText="Amount Due"  ReadOnly="True" SortExpression="AmountDue" UniqueName="AmountDue"
                                HeaderStyle-Width="60px"  ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}"
                                Aggregate="Sum" FooterAggregateFormatString="{0:N2}" FooterStyle-Width="120px" FooterStyle-HorizontalAlign="Right">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn HeaderText="Invoice Description" UniqueName="InvoiceNotes"
                                 DataField="InvoiceNotes" SortExpression="InvoiceNotes">
                                <ItemTemplate>
                                    <asp:Label ID="InvoiceNotesLabelInv" runat="server" Text='<%# Eval("InvoiceNotes") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="Emitted" 
                                HeaderText="Emitted" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="30px"
                                ReadOnly="true" SortExpression="Emitted" UniqueName="Emitted">
                            </telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="EmissionRecurrenceDays"  Display="false"
                                HeaderText="Emission Recurrence Days" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="30px" HeaderTooltip="Define frequency of automated email reccurence"
                                SortExpression="EmissionRecurrenceDays" UniqueName="EmissionRecurrenceDays">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="BadDebt" DataType="System.Boolean" FilterControlAltText="Filter BadDebt column" HeaderText="Bad Debt" ReadOnly="true"
                                SortExpression="BadDebt" UniqueName="BadDebt"  HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:CheckBox ID="BadDebtCheckBoxInv2" runat="server" Checked='<%# Eval("BadDebt")%>' Enabled="false" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Billing Contact" UniqueName="Billing_contact" HeaderStyle-Width="160px" Display="false"
                                 DataField="Billing_contact" SortExpression="Billing_contact">
                                <ItemTemplate>
                                    <%# Eval("Billing_contact") %><%# Eval("Billing_Telephone") %>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Actions" ReadOnly="true" UniqueName="Actions"  HeaderStyle-Width="180px" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>

                                    <asp:LinkButton ID="btnInvoiceInv44" runat="server" UseSubmitBehavior="false" CommandName="SendInvoice" CommandArgument='<%# Eval("Id") %>'
                                        ToolTip="Send Email with Invoice" CausesValidation="false">
                                                            <i class="far fa-envelope"></i>
                                    </asp:LinkButton>
                                    &nbsp;
                                                        <asp:LinkButton ID="btnPrintInvoice" runat="server" UseSubmitBehavior="false" ToolTip="Print Invoice"
                                                            CommandName="PDF" CommandArgument='<%# Eval("Id")%>'>
                                                               <i class="far fa-file-pdf"></i></a>
                                                        </asp:LinkButton>

                                    &nbsp;
                                                        <asp:LinkButton ID="btnShareLink" runat="server" UseSubmitBehavior="false" CommandName="GetSharedLink" CommandArgument='<%# Eval("Id") %>'
                                                            ToolTip="Get a link to copy and paste in an email or browser" CausesValidation="false">
                                                            <i class="far fa-share-square"></i>
                                                        </asp:LinkButton>
                                    &nbsp;
                                                        <asp:LinkButton ID="btnClone" runat="server" UseSubmitBehavior="false" ToolTip="Duplicate Invoice"
                                                            CommandName="Duplicate" CommandArgument='<%# Eval("Id")%>'>
                                                                <i class="far fa-clone"></i></a>
                                                        </asp:LinkButton>

                                    &nbsp;
                                                        <asp:LinkButton ID="btnInvoicePayment" runat="server" CssClass="badge-success label" UseSubmitBehavior="false" CommandName="RecivePayment" CommandArgument='<%# Eval("Id") %>'
                                                            ToolTip="Add Payments" CausesValidation="false" Visible='<%# Eval("AmountDue")%>'>
                                                            <i class="fas fa-dollar-sign"></i>
                                                        </asp:LinkButton>
                                    &nbsp;
                                                        <asp:LinkButton ID="btnBadDebt" runat="server" CssClass="badge-danger badge" UseSubmitBehavior="false" CommandName="BadDebt" CommandArgument='<%# Eval("Id") %>' Visible='<%# Eval("BadDebt")=0%>'
                                                            ToolTip="Mark Invoice as BadDept" CausesValidation="false">
                                                            B
                                                        </asp:LinkButton>

                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this Invoice?"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                UniqueName="DeleteColumn" HeaderText="" 
                                ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px">
                            </telerik:GridButtonColumn>


                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>

        </div>
        <div class="row">
            <div class="col-12">
                <h4>Payment(s)</h4>
                <telerik:RadGrid ID="RadGridPayments" runat="server" AllowAutomaticDeletes="True" HeaderStyle-HorizontalAlign="Center"
                    AutoGenerateColumns="False" DataSourceID="SqlDataSourcePayments"  ShowFooter="True">
                    <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourcePayments" ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" HeaderStyle-Font-Size="Small" FooterStyle-Font-Size="X-Small">
                        <CommandItemSettings ExportToPdfText="Export to PDF" />
                        <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
                        </RowIndicatorColumn>
                        <ExpandCollapseColumn Created="True" FilterControlAltText="Filter ExpandColumn column" Visible="True">
                        </ExpandCollapseColumn>
                        <Columns>
                            <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" HeaderText="Payment ID" ReadOnly="True"
                                HeaderStyle-Width="120px"  SortExpression="Id" UniqueName="Id">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="InvoiceNumber" FilterControlAltText="Filter Id column"
                                HeaderText="Invoice" SortExpression="InvoiceNumber" UniqueName="InvoiceNumber" HeaderStyle-Width="120px" ReadOnly="true">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkEditPayment" runat="server" CommandName="EditPayment" CommandArgument='<%# Eval("Id") %>'
                                        Text='<%# Eval("InvoiceNumber") %>' ToolTip="Click to Edit Payment"></asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridDateTimeColumn DataField="CollectedDate" DataFormatString="{0:MM/dd/yy}" FilterControlAltText="Filter CollectedDate column"  HeaderStyle-Width="120px" HeaderText="Collected Date" ItemStyle-HorizontalAlign="Right" SortExpression="CollectedDate" UniqueName="CollectedDate">
                            </telerik:GridDateTimeColumn>
                            <telerik:GridTemplateColumn DataField="Method"  HeaderStyle-Width="150px" HeaderText="Payment Method" SortExpression="Method" UniqueName="Method">
                                <ItemTemplate>
                                    <asp:Label ID="PaymentMethodLabel_paym" runat="server" Text='<%# Eval("PaymentMethodName")%>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn Aggregate="Sum" DataField="Amount" FilterControlAltText="Filter Amount column" FooterAggregateFormatString="{0:N2}"
                                FooterStyle-HorizontalAlign="Right" FooterStyle-Width="60px"  HeaderStyle-Width="150px" HeaderText="Amount Received" ItemStyle-HorizontalAlign="Right" SortExpression="Amount" UniqueName="Amount">
                                <ItemTemplate>
                                    <asp:Label ID="AmountLabel_paym" runat="server" Text='<%# Eval("Amount", "{0:N2}") %>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="CollectedNotes" HeaderText="Collected Notes" SortExpression="CollectedNotes" UniqueName="CollectedNotes" >
                                <ItemTemplate>
                                    <table>
                                        <tr>
                                            <td>
                                                <%# Eval("CollectedNotes")%>
                                            </td>
                                            <td>
                                                <asp:Panel ID="PanelUpload" runat="server" Visible='<%# len(Eval("Download_url"))>0 %>'>
                                                    &nbsp;<a class="fas fa-cloud-download-alt" href='<%# Eval("Download_url")%>' target="_blank"></a>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this note?"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                UniqueName="DeleteColumn" HeaderText="" 
                                ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px">
                            </telerik:GridButtonColumn>

                        </Columns>
                    </MasterTableView>
                    <PagerStyle PageSizeControlType="RadComboBox" />
                    <FilterMenu EnableImageSprites="False">
                    </FilterMenu>
                </telerik:RadGrid>
            </div>
            <br /><br />
        </div>
    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>


    <telerik:RadToolTip ID="RadToolTipInsertPayment" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; color: white; width: 500px">
           <span class="navbar navbar-expand-md bg-dark text-white">Receive Payment
            </span>
        </h2>
        <table class="table-sm" style="width: 500px">
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

                    <asp:LinkButton ID="btnCancelPayment" runat="server" CssClass="btn btn-secondary btn" UseSubmitBehavior="false"
                        CommandName="Cancel"> Cancel
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipEditInvoice" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; color: white; width: 600px">
           <span class="navbar navbar-expand-md bg-dark text-white">Invoice
            </span>
        </h2>
        <asp:FormView ID="FormViewInvoice" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceInvoice" DefaultMode="Edit">
            <EditItemTemplate>
                <table class="table-sm" style="width: 600px">
                    <tr>
                        <td colspan="2">
                            <h4><%# iif(Eval("InvoiceType")=1,"Invoice Hourly Rate","Invoice Simple Charge") %></h4>
                        </td>
                    </tr>

                    <tr>
                        <td style="width: 120px">Invoice Date:
                        </td>
                        <td>
                            <telerik:RadDatePicker ID="RadDatePicker1" runat="server" ZIndex="50001" DbSelectedDate='<%# Bind("InvoiceDate") %>'>
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px">Due Date:
                        </td>
                        <td>
                            <telerik:RadDatePicker ID="RadDatePickerMaturityDate" runat="server" ZIndex="50001" DbSelectedDate='<%# Bind("MaturityDate") %>'>
                            </telerik:RadDatePicker>
                        </td>
                    </tr>


                    <tr>
                        <td style="width: 120px">Amount:
                        </td>
                        <td>
                            <telerik:RadNumericTextBox ID="AmountRadNumericTextBoxInv" runat="server" DbValue='<%# Bind("Amount") %>'
                                Enabled='<%# iif(Eval("InvoiceType")=1,"false","true") %>'>
                            </telerik:RadNumericTextBox>
                        </td>
                    </tr>
                </table>
                <asp:Panel runat="server" ID="Panel1" Visible='<%# iif(Eval("InvoiceType")=1,"true","false") %>'>
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
                                <span class="small"><%# iif(Eval("InvoiceType")=1,"Invoice Amount update, affects the Job.Budget!!!","") %></span>
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
                        <td style="width: 120px">Recurrence Days:</td>
                        <td>
                            <telerik:RadNumericTextBox ID="RadNumericTextBoxRecurrence" runat="server" DbValue='<%# Bind("EmissionRecurrenceDays") %>'
                                MinValue="0" MaxValue="365">
                                <NumberFormat DecimalDigits="0" />
                            </telerik:RadNumericTextBox>
                        </td>
                    </tr>
                </table>
            </EditItemTemplate>
        </asp:FormView>
        <table class="table-sm" style="width: 600px">
            <tr>
                <td style="text-align: center">
                    <asp:LinkButton ID="btnUpdateInvoice" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false"
                        CommandName="Update"> Update
                    </asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCancelInvoice" runat="server" CssClass="btn btn-secondary btn" UseSubmitBehavior="false" Text=""
                        CommandName="Cancel"> Cancel
                    </asp:LinkButton>
                </td>
            </tr>

        </table>

    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipEditPayment" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; color: white; width: 600px">
           <span class="navbar navbar-expand-md bg-dark text-white">Payment
            </span>
        </h2>
        <asp:FormView ID="FormViewPayment" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourcePayment" DefaultMode="Edit">
            <EditItemTemplate>
                <table class="table-sm" style="width: 600px">
                    <tr>
                        <td style="width: 140px; text-align: right">Collected Date:
                        </td>
                        <td>
                            <telerik:RadDatePicker ID="RadDateEditPickerPayment" runat="server" ZIndex="50001" DbSelectedDate='<%# Bind("CollectedDate") %>'>
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Method:
                        </td>
                        <td>

                            <telerik:RadComboBox ID="cboEditPaymentMethod_paym2" runat="server" DataSourceID="SqlDataSourcePaymentMethod" DataTextField="Name" DataValueField="Id"
                                Filter="Contains" MarkFirstMatch="True" SelectedValue='<%# Bind("Method") %>' Width="100%" ZIndex="50001">
                            </telerik:RadComboBox>

                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Amount:
                        </td>
                        <td>
                            <telerik:RadNumericTextBox ID="txtEditAmountPayment" runat="server" Width="60px" DbValue='<%# Bind("Amount") %>'>
                            </telerik:RadNumericTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Notes:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtEditPaymentNotes" runat="server" Width="100%" MaxLength="1024" TextMode="MultiLine" Rows="4" Text='<%# Bind("CollectedNotes") %>'>
                            </telerik:RadTextBox>
                        </td>
                    </tr>

                </table>
            </EditItemTemplate>
        </asp:FormView>
        <table class="table-sm" style="width: 600px">
            <tr>
                <td style="text-align: center">
                    <asp:LinkButton ID="btnUpdatePayment" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false"
                        CommandName="Update"> Update
                    </asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCancelUpdatePayment" runat="server" CssClass="btn btn-secondary btn" UseSubmitBehavior="false"
                        CommandName="Cancel"> Cancel
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipInvoicesDiscount" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; color: white; width: 600px">
           <span class="navbar navbar-expand-md bg-dark text-white">Apply Invoices Discount
            </span>
        </h2>
        <p>
            Apply Discount Percent (%) or Discount Amount ($) to last Invoice scheduled and Job.Budget
        </p>
        <table class="table-sm" style="width: 600px">

            <tr>
                <td style="width: 120px">Discount Percent (%):
                </td>
                <td>
                    <telerik:RadNumericTextBox ID="txtDiscountPercent" runat="server" MinValue="0" MaxValue="100" MaxLength="2" Value="0">
                    </telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>
                <td>Discount Amount ($):
                </td>
                <td>
                    <telerik:RadNumericTextBox ID="txtDiscountAmount" runat="server" MinValue="1">
                    </telerik:RadNumericTextBox>
                </td>
            </tr>

            <tr>
                <td style="width: 120px">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtDiscountNotes" ValidationGroup="InvoiceDiscount"
                        Text="*" ErrorMessage="Define Notes" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    Discount Notes:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtDiscountNotes" runat="server" MaxLength="80" Width="100%"></telerik:RadTextBox>

                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <asp:LinkButton ID="btnApplyDiscount" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false" ValidationGroup="InvoiceDiscount"> 
                        Apply Discount
                    </asp:LinkButton>
                </td>
            </tr>
        </table>

    </telerik:RadToolTip>

    <asp:SqlDataSource ID="SqlDataSourceInvoices" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOB_INVOICES3_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="INVOICE_DELETE" DeleteCommandType="StoredProcedure"
        UpdateCommand="INVOICES_APPLYDISCOUNT" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="JobId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboInvoiceFilterCode" Name="FilterCode" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="JobId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="txtDiscountPercent" Name="DiscountPercent" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtDiscountAmount" Name="DiscountAmount" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtDiscountNotes" Name="DiscountNotes" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
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
    <asp:SqlDataSource ID="SqlDataSourceInvoicesTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Invoices_types WHERE (companyId = @companyId) ORDER BY Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePayments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="Payment_DELETE" DeleteCommandType="StoredProcedure"
        SelectCommand="Job_accountng_payments_SELECT" SelectCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" DefaultValue="0" Name="JobId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePaymentMethod" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Payment_methods ORDER BY Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePayment" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Payment_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="Payment_UPDATE" UpdateCommandType="StoredProcedure"
        InsertCommand="Invoice_Payment_v20_INSERT" InsertCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="Method" />
            <asp:Parameter Name="CollectedDate" Type="DateTime" />
            <asp:Parameter Name="CollectedNotes" />
            <asp:Parameter Name="Amount" />
            <asp:ControlParameter ControlID="lblPaymentId" Name="Id" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblPaymentId" Name="Id" PropertyName="Text" Type="Int32" />
        </SelectParameters>
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

            <asp:ControlParameter ControlID="lblEmployeeId" Name="EmployeeId" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceJobStatus" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Jobs_status] ORDER BY [OrderBy]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceJob" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Budget, Status, AllowOpenBudget=isnull(AllowOpenBudget,0) FROM Jobs WHERE Id=@Id"
        UpdateCommand="JOB_BudgetStatus_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="Id" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Budget" Type="Double" />
            <asp:Parameter Name="Status" Type="Int32" />
            <asp:Parameter Name="AllowOpenBudget" />
            <asp:ControlParameter ControlID="lblJobId" Name="Id" PropertyName="Text" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClientBalance" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Client_Balance" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblClientId" Name="ClientId" PropertyName="Text" Type="Int32" />
        </SelectParameters>

    </asp:SqlDataSource>


    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblJobId" runat="server" Visible="false" Text="0"></asp:Label>
    <asp:Label ID="lblClientId" runat="server" Visible="False"></asp:Label>

    <asp:Label ID="lblInvoiceId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblPaymentId" runat="server" Visible="False"></asp:Label>

    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>

    <asp:Label ID="lblOriginalFileName" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblKeyName" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblContentBytes" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblContentType" runat="server" Visible="False"></asp:Label>
</asp:Content>

