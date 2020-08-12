<%@ Page Title="Payments" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="payments.aspx.vb" Inherits="pasconcept20.payments" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function onClientUploadFailed(sender, eventArgs) {
            alert(eventArgs.get_message())
        }
    </script>


    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Payments</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>
            <asp:LinkButton ID="btnBulkReconcile" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Reconcile selected payments records with bank statements">
                Bulk Reconcile
            </asp:LinkButton>

        </span>

    </div>

    <div class="collapse" id="collapseFilter">
        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnRefresh">
            <table class="table-sm pasconcept-bar" style="width: 100%">
                <tr>
                    <td style="width: 160px">From:
                        <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" DateFormat="MM/dd/yyyy" Width="130px" Culture="en-US" ToolTip="Date From of the filter">
                        </telerik:RadDatePicker>
                    </td>
                    <td style="width: 160px">To:
                                <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" DateFormat="MM/dd/yyyy" Width="130px" Culture="en-US">
                                </telerik:RadDatePicker>

                    </td>
                    <td style="width: 300px">
                        <telerik:RadComboBox ID="cboDepartments" runat="server" AppendDataBoundItems="true"
                            DataSourceID="SqlDataSourceDepartments" DataTextField="Name" DataValueField="Id" Filter="Contains"
                            Height="300px" MarkFirstMatch="True" Width="100%">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Selected="true" Text="(All Departments...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>

                    </td>
                    <td style="width: 250px">
                        <telerik:RadComboBox ID="cboPaymentMethod" runat="server" AppendDataBoundItems="true"
                            DataSourceID="SqlDataSourcePaymentMethod" DataTextField="Name" DataValueField="Id"
                            Filter="Contains" MarkFirstMatch="True" Width="100%" Height="300px">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Selected="true" Text="(All Method...)" Value="-1" />
                                <telerik:RadComboBoxItem runat="server" Selected="true" Text="Check w/ image" Value="-2" />
                                <telerik:RadComboBoxItem runat="server" Selected="true" Text="Check w/o image" Value="-3" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <telerik:RadComboBox ID="cboClients" runat="server" AppendDataBoundItems="true" DataSourceID="SqlDataSourceClient" ToolTip="Clients"
                            DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" MarkFirstMatch="True" Width="100%">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Selected="true" Text="(All Clients...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboReconcile" runat="server" AppendDataBoundItems="true"
                            Filter="Contains" MarkFirstMatch="True" Width="100%">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Selected="true" Text="(All Reconciled/Not Reconciled Payments...)" Value="-1" />
                                <telerik:RadComboBoxItem runat="server" Selected="true" Text="Reconciled" Value="1" />
                                <telerik:RadComboBoxItem runat="server" Selected="true" Text="Not Reconciled" Value="0" />
                            </Items>
                        </telerik:RadComboBox>

                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtFind" runat="server" EmptyMessage="Search for Invoice/Statement, Job/Client, Notes..."
                            Width="100%" x-webkit-speech="x-webkit-speech">
                        </telerik:RadTextBox>
                    </td>
                    <td style="text-align: right; width: 150px">
                        <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
    <div>
        <telerik:RadGrid ID="RadGridPayments" runat="server" DataSourceID="SqlDataSource1" ShowFooter="true" Width="100%" Skin="Bootstrap" AllowSorting="true" AllowAutomaticDeletes="True"
            AllowMultiRowSelection="True"
            PageSize="50" AllowPaging="true"
            Height="1500px" RenderMode="Lightweight"
            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
            <ClientSettings Selecting-AllowRowSelect="true">
                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSource1" DataKeyNames="Id">
                <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                <Columns>

                    <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" UniqueName="ClientSelectColumn">
                    </telerik:GridClientSelectColumn>

                    <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" HeaderText="Payment ID" ReadOnly="True"
                        HeaderStyle-Width="100px" SortExpression="Id" UniqueName="Id" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>


                    <telerik:GridTemplateColumn DataField="StatementNumber" HeaderText="Statement" UniqueName="StatementNumber"
                        HeaderStyle-Width="130px" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <%# Eval("StatementNumber")%>
                                    </td>
                                    <td style="padding-left: 3px">
                                        <asp:Panel runat="server" Visible='<%# Eval("statementId")>0 %>'>
                                            <a class="far fa-share-square" title="View Invoice"
                                                href='<%# LocalAPI.GetSharedLink_URL(55,Eval("statementId"))%>'
                                                target="_blank" aria-hidden="true"></a>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>

                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="InvoiceNumber" HeaderText="Invoice" UniqueName="InvoiceNumber"
                        HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lnkEditPayment" runat="server" CommandName="EditPayment" CommandArgument='<%# Eval("Id") %>'
                                            Text='<%# Eval("InvoiceNumber") %>' ToolTip="Click to Edit Payment"></asp:LinkButton>
                                    </td>
                                    <td style="padding-left: 3px">
                                        <asp:Panel runat="server" Visible='<%# Eval("InvoicesId")>0 %>'>
                                            <a class="far fa-share-square" title="View Invoice"
                                                href='<%# LocalAPI.GetSharedLink_URL(4,Eval("InvoicesId"))%>'
                                                target="_blank" aria-hidden="true"></a>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>

                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="PaymentDate" DataType="System.DateTime" FilterControlAltText="Filter PaymentDate column"
                        HeaderText="Date" SortExpression="PaymentDate" UniqueName="PaymentDate" AllowSorting="true"
                        HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Payment Date">
                        <ItemTemplate>
                            <%# Eval("PaymentDate","{0:d}")%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="ClientName" HeaderText="Client - Job - Notes" UniqueName="ClientName"
                        ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <div>
                                <b><%# Eval("ClientName")%></b> (<%# Eval("JobName")%>)
                            </div>
                            <div>
                                <div>
                                    <small><%# Eval("InvoiceNotes")%></small>
                                </div>
                            </div>

                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="InvoiceAmount" HeaderText="Amount" UniqueName="InvoiceAmount" AllowSorting="true"
                        HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" DataFormatString="{0:C}"
                        FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="PaymentAmount" HeaderText="Amount Paid" UniqueName="PaymentAmount" AllowSorting="true"
                        HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" DataFormatString="{0:C}"
                        FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                    </telerik:GridBoundColumn>

                    <telerik:GridTemplateColumn DataField="AmountDue" HeaderText="Amount Due" UniqueName="AmountDue" AllowSorting="true"
                        HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:C2}"
                        FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                        <ItemTemplate>
                            <%# Eval("AmountDue", "{0:C}") %>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="PaymentMethod" HeaderText="Method" UniqueName="PaymentMethod" HeaderStyle-Width="180px" AllowSorting="true"
                        ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <div>
                                <b><%# Eval("PaymentMethod") %></b>
                                <span style="float: right; vertical-align: middle;">
                                    <asp:Panel ID="PanelUpload" runat="server" Visible='<%#Len(Eval("Download_url")) %>'>
                                        <a class="fas fa-cloud-download-alt" href='<%# Eval("Download_url")%>' target="_blank"></a>
                                    </asp:Panel>
                                </span>

                            </div>
                            <div>
                                <small><%# Eval("PaymentNotes")%></small>
                            </div>

                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridCheckBoxColumn DataField="ReconciledBank" DataType="System.Boolean" HeaderText="R" HeaderTooltip="Reconciled Bank"
                        SortExpression="ReconciledBank" UniqueName="ReconciledBank" HeaderStyle-Width="40px" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridCheckBoxColumn>

                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmDialogType="RadWindow" ConfirmText="Delete this payment?" ConfirmTitle="Delete" HeaderStyle-Width="50px" HeaderText="" ItemStyle-HorizontalAlign="Center" Text="Delete" UniqueName="DeleteColumn">
                    </telerik:GridButtonColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>


    <telerik:RadToolTip ID="RadToolTipEditPayment" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; color: white; width: 600px">
            <span class="navbar navbar-expand-md bg-dark text-white">Payment
            </span>
        </h2>
        <asp:FormView ID="FormViewPayment" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourcePayment" DefaultMode="Edit">
            <EditItemTemplate>
                <table class="table-sm" style="width: 600px">
                    <tr>
                        <td style="width: 160px; text-align: right">Collected Date:
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
                            <telerik:RadNumericTextBox ID="txtEditAmountPayment" runat="server" Width="180px" DbValue='<%# Bind("Amount") %>'>
                            </telerik:RadNumericTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right; vertical-align: top">Notes:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtEditPaymentNotes" runat="server" Width="100%" MaxLength="1024" TextMode="MultiLine" Rows="3" Text='<%# Bind("CollectedNotes") %>'>
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Is Reconciled with Bank:
                        </td>
                        <td>
                            <telerik:RadCheckBox runat="server" ID="chkReconciledBank" Checked='<%# Bind("ReconciledBank")%>' AutoPostBack="false"></telerik:RadCheckBox>
                        </td>
                    </tr>

                </table>
            </EditItemTemplate>
        </asp:FormView>
        <table class="table-sm" style="width: 600px">
            <tr>
                <td>
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

    <telerik:RadToolTip ID="RadToolTipBulkReconcile" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

        <table class="table table-bordered" style="width: 500px">
            <tr>
                <td colspan="2">
                    <h2 style="margin: 0; text-align: center; color: white; width: 600px">
                        <span class="navbar navbar-expand-md bg-dark text-white">Update Reconcile Status</span>
                    </h2>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <small>Check / Uncheck (selected) payments records as <b>Reconcilied</b> with Bank Statements</small>
                </td>
            </tr>
            <tr>
                <td style="width: 160px; text-align: right" class="Normal">Reconcile Status:
                </td>
                <td>

                    <telerik:RadComboBox ID="cboBulkReconcile" runat="server" AppendDataBoundItems="true" ValidationGroup="Reconcile"
                        Filter="Contains" MarkFirstMatch="True" Width="100%" ZIndex="50001">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Selected="true" Text="(Select Status ...)" Value="-1" />
                            <telerik:RadComboBoxItem runat="server" Selected="true" Text="Reconciled" Value="1" />
                            <telerik:RadComboBoxItem runat="server" Selected="true" Text="Not Reconciled" Value="0" />
                        </Items>
                    </telerik:RadComboBox>


                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:CompareValidator runat="server" ID="Comparevalidator2" ValueToCompare="(Select Status ...)" ForeColor="Red"
                        Operator="NotEqual" ControlToValidate="cboBulkReconcile" ErrorMessage="Select Reconcile Status!" SetFocusOnError="true" ValidationGroup="Reconcile"> </asp:CompareValidator>

                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <asp:LinkButton ID="btnConfirmReconcileStatus" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" Width="120px" ValidationGroup="Reconcile">
                                    <i class="fas fa-check"></i> Update
                    </asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCanceReconcile" runat="server" CssClass="btn btn-secondary btn" CausesValidation="false" UseSubmitBehavior="false" Width="120px">
                                     Cancel
                    </asp:LinkButton>

                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <asp:SqlDataSource ID="SqlDataSourcePayment" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Payment_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="Payment_v20_UPDATE" UpdateCommandType="StoredProcedure"
        DeleteCommand="Payment_DELETE" DeleteCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="Method" />
            <asp:Parameter Name="CollectedDate" Type="DateTime" />
            <asp:Parameter Name="CollectedNotes" />
            <asp:Parameter Name="Amount" />
            <asp:Parameter Name="ReconciledBank" />

            <asp:ControlParameter ControlID="lblOriginalFileName" Name="OriginalFileName" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="lblKeyName" Name="KeyName" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="lblContentBytes" Name="ContentBytes" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblContentType" Name="ContentType" PropertyName="Text" Type="String" />

            <asp:ControlParameter ControlID="lblPaymentId" Name="Id" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblPaymentId" Name="Id" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="lblPaymentId" Name="Id" PropertyName="Text" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Payments_v20_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="Payment_DELETE" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="PaymentDateFrom" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="PaymentDateTo" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboClients" Name="ClientId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboDepartments" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboPaymentMethod" Name="PaymentMethodId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboReconcile" Name="ReconciledId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Find" PropertyName="Text" Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Client] As Name FROM [Clients]  WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourcePaymentMethod" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Payment_methods ORDER BY Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblPaymentId" runat="server" Visible="False"></asp:Label>

    <asp:Label ID="lblOriginalFileName" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblKeyName" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblContentBytes" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblContentType" runat="server" Visible="False"></asp:Label>

</asp:Content>

