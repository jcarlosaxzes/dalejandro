<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterJOB.Master" CodeBehind="job_rfps.aspx.vb" Inherits="pasconcept20.job_rfps" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/MasterJOB.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="container">

        <div class="pasconcept-bar">
            <span class="pasconcept-pagetitle">Expenses</span>
            <span style="float: right; vertical-align: middle;">
                <asp:LinkButton ID="btnNewSubconsultantFee" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="false" ToolTip="Insert Subconsultant Fee">
                    Add Subconsultant Fee
                </asp:LinkButton>

                <asp:LinkButton ID="btnSelectRFP" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" CausesValidation="false" ToolTip="Select Existing RFP">
                    Select Existing RFP
                </asp:LinkButton>
            </span>
        </div>
        <telerik:RadGrid ID="RadGridRFP" runat="server" DataSourceID="SqlDataSourceRFP" GridLines="None"
            ShowFooter="True" AutoGenerateColumns="False" CellSpacing="0" AllowAutomaticInserts="true" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true">
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceRFP" ShowFooter="True" FooterStyle-Font-Size="Small"
                ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small">
                <Columns>
                    <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column"
                        HeaderText="ID" ReadOnly="True" Display="false" SortExpression="Id" UniqueName="Id"
                        HeaderStyle-Width="30px" ItemStyle-HorizontalAlign="Center"
                        FooterStyle-HorizontalAlign="Center" FooterStyle-Width="30px">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="RFPNumber" DataType="System.Int32" FilterControlAltText="Filter RFPNumber column"
                        HeaderText="RFP Number" ReadOnly="True" SortExpression="RFPNumber" UniqueName="RFPNumber" HeaderStyle-HorizontalAlign="Center"
                        HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkRFPNumber" runat="server" CommandName="Edit" CommandArgument='<%# Eval("Id") %>'
                                Text='<%# Eval("RFPNumber") %>' Enabled='<%# Eval("AutomaticFee") = 1%>' ToolTip="Click to Edit (only inserted in this page)"></asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="ProjectName" FilterControlAltText="Filter ProjectName column" ReadOnly="True"
                        HeaderText="Project" SortExpression="ProjectName" UniqueName="ProjectName" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SubconsultanName" FilterControlAltText="Filter SubconsultanName column" ReadOnly="True"
                        HeaderText="Subconsultant" SortExpression="SubconsultanName" UniqueName="SubconsultanName" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="subconsultanId" FilterControlAltText="Filter subconsultanId column" Display="false"
                        HeaderText="Subconsultant" SortExpression="subconsultanId" UniqueName="subconsultanId">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ProjectDescription" FilterControlAltText="Filter ProjectDescription column"
                        HeaderText="Description" SortExpression="ProjectDescription" UniqueName="ProjectDescription" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="BillingContact" FilterControlAltText="Filter BillingContact column" ReadOnly="True" Display="false"
                        HeaderText="Billing Contact" SortExpression="BillingContact" UniqueName="BillingContact"
                        HeaderStyle-Width="160px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Total" FilterControlAltText="Filter Total column" HeaderText="Amount" SortExpression="Total" UniqueName="Total" Aggregate="Sum"
                        DataFormatString="{0:N2}" DataType="System.Double" FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Right" FooterStyle-Width="100px"
                        HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="AmountDue" FilterControlAltText="Filter AmountDue column"
                        HeaderText="Amount Due" SortExpression="AmountDue" UniqueName="AmountDue" Aggregate="Sum"
                        DataFormatString="{0:N2}" DataType="System.Double" FooterAggregateFormatString="{0:N2}"
                        FooterStyle-HorizontalAlign="Right" FooterStyle-Width="120px" HeaderStyle-HorizontalAlign="Center"
                        HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right" ReadOnly="True">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn AllowFiltering="False"
                        HeaderText="Pay Bill" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="80px"
                        UniqueName="PayBill" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnRFPPayment" runat="server" CssClass="badge-success label" UseSubmitBehavior="false" CommandName="PayBill" CommandArgument='<%# Eval("Id") %>'
                                ToolTip="Add Payments bill" CausesValidation="false" Visible='<%# Eval("AmountDue")%>'>
                                                            <i class="fas fa-dollar-sign"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="View" UniqueName="columnEmail" AllowFiltering="False"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                        HeaderStyle-Width="30px">
                        <ItemTemplate>

                            <a href='<%# LocalAPI.GetSharedLink_URL(2002, Eval("Id"))%>' target="_blank" title="Subconsultant View of RFP">
                                <i class="far fa-share-square"></i></a>
                            </a>

                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmDialogType="RadWindow" ConfirmText="Delete this fee?" ConfirmTitle="Delete" HeaderStyle-Width="50px"
                        HeaderText="" ItemStyle-HorizontalAlign="Center" Text="Delete" UniqueName="DeleteColumn" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings EditFormType="Template" CaptionFormatString="New Request For Proposal"
                    PopUpSettings-ZIndex="7001">
                    <PopUpSettings Modal="true" Width="660px" />
                    <FormTemplate>
                        <div style="padding-left: 10px; padding-top: 20px">
                            <table class="table-sm" style="width: 100%">
                                <tr>
                                    <td style="width: 150px; text-align: right">Subconsultant:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cboSubconsultant" runat="server" DataSourceID="SqlDataSourceSubconsultant" Height="300px" SelectedValue='<%# Bind("subconsultanId")%>'
                                            DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Width="400px" AppendDataBoundItems="true"
                                            Style="z-index: 7003">
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text="(Select Subconsultant…)" Value="-1" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right; vertical-align: top">Description: </td>
                                    <td>
                                        <telerik:RadTextBox ID="txtRFPDescription" runat="server" Rows="4" SelectionOnFocus="SelectAll" Text='<%# Bind("ProjectDescription")%>' TextMode="MultiLine" Width="100%">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Total:
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="RadNumericTextRFPTotal" runat="server" DbValue='<%# Bind("Total")%>' Width="120px">
                                        </telerik:RadNumericTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="text-align: right; padding-right: 50px; padding-top: 30px; padding-bottom: 15px">
                                        <asp:LinkButton ID="btnInsertRFP" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false"
                                            ValidationGroup="InsertFee" CausesValidation="true"
                                            CommandName='<%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "PerformInsert", "Update")%>'>
                                                        <i class="fas fa-plus"></i> <%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "Insert", "Update")%>
                                        </asp:LinkButton>
                                        &nbsp;&nbsp;
                                                    <asp:LinkButton ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False" CommandName="Cancel">
                                                    </asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:CompareValidator runat="server" ID="Comparevalidator1" Operator="NotEqual" ForeColor="Red"
                                            ControlToValidate="cboSubconsultant"
                                            ValueToCompare="(Select Subconsultant…)"
                                            ValidationGroup="InsertFee"
                                            ErrorMessage="(*) You must select subconsultant!">
                                        </asp:CompareValidator>
                                        <br />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                                            ControlToValidate="txtRFPDescription"
                                            ValidationGroup="InsertFee"
                                            ErrorMessage="(*) You must define Description!"></asp:RequiredFieldValidator>
                                        <br />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorTotal" runat="server" ForeColor="Red"
                                            ControlToValidate="RadNumericTextRFPTotal"
                                            ValidationGroup="InsertFee"
                                            ErrorMessage="(*) You must define Total!"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </FormTemplate>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>

        <div class="pasconcept-bar">
            <span class="pasconcept-pagetitle">Payment(s) Bill(s)</span>
        </div>
        <telerik:RadGrid ID="RadGridRFPpayments" runat="server" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
            AutoGenerateColumns="False" DataSourceID="SqlDataSourceRFPpayments" GridLines="None" ShowFooter="True"
            ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" HeaderStyle-HorizontalAlign="Center" FooterStyle-Font-Size="Small">
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceRFPpayments">
                <CommandItemSettings ExportToPdfText="Export to PDF" />
                <Columns>
                    <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" Display="False" HeaderText="ID" ReadOnly="True" SortExpression="Id" UniqueName="Id">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="RFPNumber" DataType="System.Int32" FilterControlAltText="Filter RFPNumber column"
                        HeaderText="RFP Number" ReadOnly="True" SortExpression="RFPNumber" UniqueName="RFPNumber"
                        HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkRFPpayment" runat="server" CommandName="Edit" CommandArgument='<%# Eval("Id") %>'
                                Text='<%# Eval("RFPNumber") %>' ToolTip="Click to Edit"></asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridDateTimeColumn DataField="PaymentDate" DataFormatString="{0:MM/dd/yy}" FilterControlAltText="Filter PaymentDate column"
                        HeaderStyle-Width="120px" HeaderText="Payment Date" ItemStyle-HorizontalAlign="Right" SortExpression="PaymentDate" UniqueName="PaymentDate">
                    </telerik:GridDateTimeColumn>
                    <telerik:GridTemplateColumn DataField="Method" HeaderStyle-Width="120px" HeaderText="Method" SortExpression="Method" UniqueName="Method">
                        <EditItemTemplate>
                            <telerik:RadComboBox ID="RadComboBoxPaymentBillMethod" runat="server" DataSourceID="SqlDataSourcePaymentMethod" DataTextField="Name" DataValueField="Id"
                                Filter="Contains" MarkFirstMatch="True" SelectedValue='<%# Bind("Method") %>' Width="430px">
                            </telerik:RadComboBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="PaymentMethodLabel2" runat="server" Text='<%# Eval("PaymentMethodName")%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn Aggregate="Sum" DataField="Amount" FilterControlAltText="Filter Amount column" FooterAggregateFormatString="{0:N2}"
                        FooterStyle-HorizontalAlign="Right" FooterStyle-Width="120px" HeaderStyle-Width="120px" HeaderText="Amount" ItemStyle-HorizontalAlign="Right"
                        SortExpression="Amount" UniqueName="Amount">
                        <EditItemTemplate>
                            <telerik:RadNumericTextBox ID="RadNumericTextBoxRate" runat="server" DbValue='<%# Bind("Amount")%>' Width="80px">
                            </telerik:RadNumericTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="AmountLabel" runat="server" Text='<%# Eval("Amount", "{0:N2}") %>'>
                            </asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="PaymentNotes" HeaderText="Payment Notes" SortExpression="PaymentNotes" UniqueName="PaymentNotes">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="PaymentNotesTextBox" runat="server" MaxLength="255" Text='<%# Bind("PaymentNotes")%>' TextMode="MultiLine" Width="430px">
                            </telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="PaymentNotesLabel" runat="server" Text='<%# Eval("PaymentNotes") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmDialogType="RadWindow" ConfirmText="Delete this payment?" ConfirmTitle="Delete"
                        HeaderStyle-Width="50px" HeaderText="" ItemStyle-HorizontalAlign="Center" Text="Delete" UniqueName="DeleteColumn">
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings>
                    <EditColumn ButtonType="PushButton" UniqueName="EditCommandColumn1">
                    </EditColumn>
                </EditFormSettings>
                <PagerStyle PageSizeControlType="RadComboBox" />
            </MasterTableView>
            <PagerStyle PageSizeControlType="RadComboBox" />
            <FilterMenu EnableImageSprites="False">
            </FilterMenu>
        </telerik:RadGrid>

        <div class="pasconcept-bar">
            <span class="pasconcept-pagetitle">Expense Report</span>
        </div>
        <telerik:RadGrid ID="RadGridReport" runat="server" AutoGenerateColumns="true" DataSourceID="SqlDataSourceJobsExpenses"
            ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" HeaderStyle-HorizontalAlign="Center"
            Skin="" RenderMode="Lightweight" AllowPaging="True" ItemStyle-HorizontalAlign="Center" AlternatingItemStyle-HorizontalAlign="Center">
            <MasterTableView DataSourceID="SqlDataSourceJobsExpenses" CommandItemDisplay="Top">
                <CommandItemSettings ShowExportToCsvButton="true" ShowAddNewRecordButton="false" ShowRefreshButton="true" ExportToCsvText="" RefreshText="" />
            </MasterTableView>
        </telerik:RadGrid>

    </div>
    <div>
        <telerik:RadToolTip ID="RadToolTipSelectExistinRFP" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

            <table class="table table-bordered" style="width: 800px">
                <tr>
                    <td>
                        <h2 style="margin: 0; text-align: center; color: white; width: 800px">
                            <span class="navbar navbar-expand-md bg-dark text-white">
                                <asp:Label ID="lblJob" runat="server"></asp:Label>
                            </span>
                        </h2>
                    </td>
                </tr>
                <tr>
                    <td>Select an existing Request For Proposal (Not Emitted, Sent, Submitted, Accepted or Closed), to associate it with the Job as Subconsultant Fee
                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadMultiColumnComboBox ID="cboRFP" runat="server" DataSourceID="SqlDataSourceSelectRFP" DataTextField="ProjectName" DataValueField="Id"
                            Width="100%" MarkFirstMatch="True" Filter="Contains" AutoFilter="True"
                            FilterFields="Name" Placeholder="(Select a RFP...)">
                            <ColumnsCollection>
                                <telerik:MultiColumnComboBoxColumn Field="RFPNumber" Title="RFP Number" Width="100px" />
                                <telerik:MultiColumnComboBoxColumn Field="ProjectName" Title="Project Name" />
                                <telerik:MultiColumnComboBoxColumn Field="SubconsultantName" Title="Subconsultant" Width="200px" />
                                <telerik:MultiColumnComboBoxColumn Field="Total" Title="Total" Width="120px">
                                    <Template>
                                        #= kendo.toString(data.Total, "n2") #
                                    </Template>
                                </telerik:MultiColumnComboBoxColumn>
                            </ColumnsCollection>
                        </telerik:RadMultiColumnComboBox>

                    </td>
                </tr>
                <tr>
                    <td style="text-align: center">
                        <br />
                        <br />
                        <br />
                        <asp:LinkButton ID="btnAcceptConfirm" runat="server" CssClass="btn btn-primary btn-lg" UseSubmitBehavior="false"
                            CausesValidation="true" ValidationGroup="SelectRFP">
                                    <i class="fas fa-check"></i> Accept
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
            <div>
                <asp:CompareValidator runat="server" ID="Comparevalidator1" ValueToCompare="(Select a RFP...)" ValidationGroup="SelectRFP"
                    Operator="NotEqual" ControlToValidate="cboRFP" ErrorMessage="(*) You must select associated Job!" ForeColor="red">
                </asp:CompareValidator>

            </div>
        </telerik:RadToolTip>
    </div>
    <asp:SqlDataSource ID="SqlDataSourceRFP" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="RFP_FEE_from_JOB_DELETE" DeleteCommandType="StoredProcedure"
        SelectCommand="RFP_FEE_from_JOB_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="RFP_FEE_from_JOB_INSERT" InsertCommandType="StoredProcedure"
        UpdateCommand="RFP_FEE_from_JOB_UPDATE" UpdateCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblJobId" Name="JobId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="subconsultanId" Type="Int32" />
            <asp:Parameter Name="ProjectDescription" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="Total" Type="Double" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="JobId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="subconsultanId" Type="Int32" />
            <asp:Parameter Name="ProjectDescription" />
            <asp:Parameter Name="Total" Type="Double" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceRFPpayments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [RequestForProposals_payments] WHERE [Id] = @Id"
        SelectCommand="SELECT RequestForProposals_payments.Id, RequestForProposals_payments.rfpId, dbo.RFPNumber(RequestForProposals_payments.rfpId) AS RFPNumber, RequestForProposals_payments.Method, RequestForProposals_payments.PaymentDate, RequestForProposals_payments.PaymentNotes, RequestForProposals_payments.Amount, Payment_methods.Name AS PaymentMethodName FROM RequestForProposals_payments INNER JOIN RequestForProposals ON RequestForProposals_payments.rfpId = RequestForProposals.Id LEFT OUTER JOIN Payment_methods ON RequestForProposals_payments.Method = Payment_methods.Id WHERE (RequestForProposals.JobId = @JobId) ORDER BY RequestForProposals_payments.PaymentDate, RequestForProposals_payments.Id"
        UpdateCommand="UPDATE [dbo].[RequestForProposals_payments] SET [Method] = @Method ,[PaymentDate] = @PaymentDate,[PaymentNotes] = @PaymentNotes,[Amount] = @Amount WHERE [Id] = @Id" InsertCommand="RFP_PAYMENTS_INSERT" InsertCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Method" />
            <asp:Parameter Name="PaymentDate" Type="DateTime" />
            <asp:Parameter Name="PaymentNotes" />
            <asp:Parameter Name="Amount" />
            <asp:Parameter Name="Id" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblRFPId" Name="rfpId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" DefaultValue="0" Name="JobId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSubconsultant" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM [SubConsultans] WHERE (companyId = @companyId) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePaymentMethod" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Payment_methods ORDER BY Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSelectRFP" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="RFP_Select_for_JOB_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="RFP_Select_for_JOB_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="JobId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboRFP" Name="RFPId" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceJobsExpenses" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JobsExpenses_3" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Name="code" />
            <asp:Parameter Name="departmentId" DefaultValue="0" />
            <asp:Parameter Name="DateFrom" />
            <asp:Parameter Name="DateTo" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblJobId" runat="server" Visible="false" Text="0"></asp:Label>
    <asp:Label ID="lblRFPId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>


