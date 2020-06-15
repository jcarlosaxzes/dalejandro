<%@ Page Title="Payments" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="payments.aspx.vb" Inherits="pasconcept20.payments" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function onClientUploadFailed(sender, eventArgs) {
            alert(eventArgs.get_message())
        }
    </script>

    <table style="width: 100%">
        <tr>
            <td class="PanelFilter">
                <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnRefresh">
                    <table class="Formulario" style="width: 100%">
                        <tr>
                            <td>From:
                                <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" DateFormat="MM/dd/yyyy" Width="110px" Culture="en-US" ToolTip="Date From of the filter">
                                </telerik:RadDatePicker>
                                &nbsp;To:
                                <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" DateFormat="MM/dd/yyyy" Width="110px" Culture="en-US">
                                </telerik:RadDatePicker>

                                &nbsp;

                                <telerik:RadComboBox ID="cboClients" runat="server" AppendDataBoundItems="true" DataSourceID="SqlDataSourceClient" ToolTip="Clients"
                                    DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" MarkFirstMatch="True" Width="200px" DropDownAutoWidth="Enabled">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Selected="true" Text="(All Clients...)" Value="-1" />
                                    </Items>
                                </telerik:RadComboBox>

                                &nbsp;

                                <telerik:RadComboBox ID="cboDepartments" runat="server" AppendDataBoundItems="true"
                                    DataSourceID="SqlDataSourceDepartments" DataTextField="Name" DataValueField="Id" Filter="Contains"
                                    Height="300px" MarkFirstMatch="True" Width="180px">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Selected="true" Text="(All Departments...)" Value="-1" />
                                    </Items>
                                </telerik:RadComboBox>

                                &nbsp;

                                <telerik:RadComboBox ID="cboPaymentMethod" runat="server" AppendDataBoundItems="true"
                                    DataSourceID="SqlDataSourcePaymentMethod" DataTextField="Name" DataValueField="Id"
                                    Filter="Contains" MarkFirstMatch="True" Width="180px" Height="300px">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Selected="true" Text="(All Method...)" Value="-1" />
                                        <telerik:RadComboBoxItem runat="server" Selected="true" Text="Check w/ image" Value="-2" />
                                        <telerik:RadComboBoxItem runat="server" Selected="true" Text="Check w/o image" Value="-3" />
                                    </Items>
                                </telerik:RadComboBox>

                                &nbsp;

                                <telerik:RadTextBox ID="txtFind" runat="server" EmptyMessage="Search for Invoice/Statement, Job/Client, Notes..."
                                    Width="250px" x-webkit-speech="x-webkit-speech">
                                </telerik:RadTextBox>

                            </td>
                            <td style="text-align: right; width: 110px">
                                <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Search
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>
    <div style="text-align: center">
        <h3 style="margin: 0">Payments
        </h3>
    </div>
    <div>
        <telerik:RadGrid ID="RadGridPayments" runat="server" DataSourceID="SqlDataSource1" ShowFooter="true" Width="100%" Skin="Bootstrap" AllowSorting="true"
            AllowAutomaticDeletes="True"
            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
            <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSource1" DataKeyNames="Id">
                <FooterStyle BorderStyle="None" />

                <Columns>

                    <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" HeaderText="Payment ID" ReadOnly="True"
                        HeaderStyle-Width="120px" SortExpression="Id" UniqueName="Id">
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
                        HeaderStyle-Width="130px" ItemStyle-HorizontalAlign="Center">
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
                        HeaderText="Payment Date" SortExpression="PaymentDate" UniqueName="PaymentDate" AllowSorting="true"
                        HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <%# Eval("PaymentDate","{0:d}")%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="ClientName" HeaderText="Client (Job)<br/>Notes" UniqueName="ClientName"
                        ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <div>
                                <b><%# Eval("ClientName")%></b> (<%# Eval("JobName")%>)
                            </div>
                            <div>
                                <table>
                                    <tr>
                                        <td>
                                            <%# Eval("InvoiceNotes")%>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="InvoiceAmount" HeaderText="Amount" UniqueName="InvoiceAmount" AllowSorting="true"
                        HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" DataFormatString="{0:C}"
                        FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="PaymentMethod" HeaderText="Method" UniqueName="PaymentMethod" HeaderStyle-Width="180px" AllowSorting="true"
                        ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <table style="width: 100%">
                                <tr>
                                    <td>
                                        <b><%# Eval("PaymentMethod") %></b>
                                    </td>
                                    <td style="width: 40px; text-align: right">
                                        <asp:Panel ID="PanelUpload" runat="server" Visible='<%# len(Eval("Download_url"))>0 %>'>
                                            &nbsp;<a class="fas fa-cloud-download-alt" href='<%# Eval("Download_url")%>' target="_blank"></a>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <small><%# Eval("PaymentNotes")%></small>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="PaymentAmount" HeaderText="Amount Paid" UniqueName="PaymentAmount" AllowSorting="true"
                        HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" DataFormatString="{0:C}"
                        FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                    </telerik:GridBoundColumn>

                    <telerik:GridTemplateColumn DataField="AmountDue" HeaderText="Amount Due" UniqueName="AmountDue" AllowSorting="true"
                        HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:C2}"
                        FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                        <ItemTemplate>
                            <%# Eval("AmountDue","{0:C}") %>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmDialogType="RadWindow" ConfirmText="Delete this payment?" ConfirmTitle="Delete" HeaderStyle-Width="50px" HeaderText="" ItemStyle-HorizontalAlign="Center" Text="Delete" UniqueName="DeleteColumn">
                    </telerik:GridButtonColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>


    <telerik:RadToolTip ID="RadToolTipEditPayment" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; color:white; width: 600px">
            <span class="navbar bg-dark">Payment
            </span>
        </h2>
        <asp:FormView ID="FormViewPayment" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourcePayment" DefaultMode="Edit">
            <EditItemTemplate>
                <table class="table table-condensed" style="width: 600px">
                    <tr>
                        <td style="width: 140px; text-align: right" class="Normal">Collected Date:
                        </td>
                        <td>
                            <telerik:RadDatePicker ID="RadDateEditPickerPayment" runat="server" ZIndex="50001" DbSelectedDate='<%# Bind("CollectedDate") %>'>
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right" class="Normal">Method:
                        </td>
                        <td>

                            <telerik:RadComboBox ID="cboEditPaymentMethod_paym2" runat="server" DataSourceID="SqlDataSourcePaymentMethod" DataTextField="Name" DataValueField="Id"
                                Filter="Contains" MarkFirstMatch="True" SelectedValue='<%# Bind("Method") %>' Width="100%" ZIndex="50001">
                            </telerik:RadComboBox>

                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right" class="Normal">Amount:
                        </td>
                        <td>
                            <telerik:RadNumericTextBox ID="txtEditAmountPayment" runat="server" Width="60px" DbValue='<%# Bind("Amount") %>'>
                            </telerik:RadNumericTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right" class="Normal">Notes:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtEditPaymentNotes" runat="server" Width="100%" MaxLength="1024" TextMode="MultiLine" Rows="4" Text='<%# Bind("CollectedNotes") %>'>
                            </telerik:RadTextBox>
                        </td>
                    </tr>

                </table>
            </EditItemTemplate>
        </asp:FormView>
        <table class="table table-condensed" style="width: 600px">
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

    <asp:SqlDataSource ID="SqlDataSourcePayment" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Payment_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="Payment3_UPDATE" UpdateCommandType="StoredProcedure"
        DeleteCommand="Payment_DELETE" DeleteCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="Method" />
            <asp:Parameter Name="CollectedDate" Type="DateTime" />
            <asp:Parameter Name="CollectedNotes" />
            <asp:Parameter Name="Amount" />

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
        SelectCommand="Payments_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="Payment_DELETE" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="PaymentDateFrom" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="PaymentDateTo" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboClients" Name="ClientId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboDepartments" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboPaymentMethod" Name="PaymentMethodId" PropertyName="SelectedValue" Type="Int32" />
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

