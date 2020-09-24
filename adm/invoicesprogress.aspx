<%@ Page Title="Progress Invoice" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="invoicesprogress.aspx.vb" Inherits="pasconcept20.invoicesprogress" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pasconcept-bar">
        <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
            Back
        </asp:LinkButton>

        <span class="pasconcept-pagetitle">&nbsp;&nbsp;Progress Invoice&nbsp;<asp:Label ID="lblInvoiceNumber" runat="server"></asp:Label></span>

    </div>
    <div class="pasconcept-bar">
        <table class="table-sm" style="width: 100%">
            <tr>
                <td style="text-align: right; width: 180px">Client:
                </td>

                <td>
                    <asp:Label ID="lblClient" runat="server" Font-Bold="true"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="text-align: right;">Job:
                </td>

                <td>
                    <asp:Label ID="lblJob" runat="server" Font-Bold="true"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="text-align: right;">Created Date:
                </td>
                <td>
                    <telerik:RadDatePicker ID="RadDatePicker1" runat="server">
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td style="text-align: right;">Due Date:
                </td>
                <td>
                    <telerik:RadDatePicker ID="RadDatePickerMaturityDate" runat="server">
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td style="text-align: right;">Amount:
                </td>
                <td>
                    <asp:Label ID="lblInvoiceAmount" runat="server" Text="0.00"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="text-align: right;">Notes</td>
                <td>
                    <telerik:RadTextBox ID="txtInvoiceNotes" runat="server" MaxLength="1024"
                        TextMode="MultiLine" Width="100%" Rows="4">
                    </telerik:RadTextBox>
                </td>
            </tr>
        </table>

        <asp:Panel runat="server" ID="panelInsert" CssClass="pasconcept-bar" Visible="false">
            <table class="table-sm" style="width: 90%">
                <tr>
                    <td style="text-align: right; width: 180px">Source Refrence:
                    </td>

                    <td>
                        <telerik:RadComboBox runat="server" ID="cboProgressRefrence" CausesValidation="false" AppendDataBoundItems="true" Width="350px">
                            <Items>
                                <telerik:RadComboBoxItem Text="(Select Refrence...)" Value="-1" />
                                <telerik:RadComboBoxItem Text="Proposal Phases Completion" Value="1" />
                                <telerik:RadComboBoxItem Text="Proposal Task Completion" Value="2" />
                                <telerik:RadComboBoxItem Text="Previous Progress Invoice" Value="3" />
                                <telerik:RadComboBoxItem Text="Job Completion" Value="4" />
                            </Items>
                        </telerik:RadComboBox>

                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: right">
                        <asp:LinkButton ID="btnInsert" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" ValidationGroup="NewInvoice" Text="Add Progress Invoice">
                        </asp:LinkButton>
                    </td>

                </tr>
            </table>
            <div>
                <asp:ValidationSummary ID="vsPhase" runat="server" ValidationGroup="NewInvoice" ForeColor="Red"
                    HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were this errors:"></asp:ValidationSummary>
            </div>
            <div>
                <asp:CompareValidator runat="server" ID="Comparevalidator1" ValueToCompare="(Select Refrence...)" Display="None"
                    Operator="NotEqual" ControlToValidate="cboProgressRefrence" ErrorMessage="Define Refrence" SetFocusOnError="true" ValidationGroup="NewInvoice"> </asp:CompareValidator>
            </div>
        </asp:Panel>
        <asp:Panel runat="server" ID="panelEdit" CssClass="pasconcept-bar" Visible="false">
            <div class="pasconcept-bar">
                <span class="pasconcept-pagetitle">&nbsp;&nbsp;Invoice Items</span>
                <span style="float: right; vertical-align: middle;">
                    <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                        Add Invoice Item
                    </asp:LinkButton>
                </span>
            </div>
            <telerik:RadGrid ID="RadGrid1" runat="server" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CellSpacing="0" Width="100%"
                HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" FooterStyle-Font-Size="Small" FooterStyle-Font-Bold="TRUE">
                <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1" ShowFooter="true">
                    <Columns>
                        <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn" HeaderText="" HeaderStyle-Width="50px">
                        </telerik:GridEditCommandColumn>
                        <telerik:GridBoundColumn DataField="Id" HeaderText="ID" ReadOnly="True" SortExpression="Id" UniqueName="Id" Display="False">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Item" HeaderText="Item" SortExpression="Item" UniqueName="Item" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Description" HeaderText="Description" SortExpression="Description" UniqueName="Description">
                        </telerik:GridBoundColumn>
                        <telerik:GridNumericColumn DataField="Amount" HeaderText="Total Fee" SortExpression="Amount" UniqueName="Amount" HeaderStyle-Width="150px" NumericType="Currency" ItemStyle-HorizontalAlign="Right"
                            Aggregate="Sum" FooterAggregateFormatString="{0:C2}" FooterStyle-HorizontalAlign="Right">
                        </telerik:GridNumericColumn>
                        <telerik:GridNumericColumn DataField="Previous" HeaderText="Previously Invoiced Percent" SortExpression="Previous" UniqueName="Previous" HeaderStyle-Width="150px" MinValue="0" MaxValue="100" ItemStyle-HorizontalAlign="Center">
                        </telerik:GridNumericColumn>
                        <telerik:GridNumericColumn DataField="AmountPrev" HeaderText="Amount Previous Invoiced" ReadOnly="True" SortExpression="AmountPrev" UniqueName="AmountPrev" HeaderStyle-Width="150px" NumericType="Currency" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:C2}" FooterStyle-HorizontalAlign="Right">
                        </telerik:GridNumericColumn>
                        <telerik:GridNumericColumn DataField="Progress" HeaderText="Percent Complete<br/>To Date" SortExpression="Progress" UniqueName="Progress" HeaderStyle-Width="180px" MinValue="0" MaxValue="100" ItemStyle-HorizontalAlign="Center">
                        </telerik:GridNumericColumn>
                        <telerik:GridBoundColumn DataField="Total" HeaderText="Amount Due <br/>This Invoice" ReadOnly="True" SortExpression="Total" DataFormatString="{0:C2}" UniqueName="Total" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right" Aggregate="Sum"
                            FooterAggregateFormatString="{0:C2}" FooterStyle-HorizontalAlign="Right">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Balance" HeaderText="Balance To<br/>Complete" ReadOnly="True" SortExpression="Balance" DataFormatString="{0:C2}" UniqueName="Balance" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:C2}" FooterStyle-HorizontalAlign="Right">
                        </telerik:GridBoundColumn>
                        <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                            CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText=""
                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                        </telerik:GridButtonColumn>

                    </Columns>
                    <EditFormSettings>
                        <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                        </EditColumn>
                    </EditFormSettings>
                </MasterTableView>
            </telerik:RadGrid>

            <div style="text-align: right;padding-top:15px">
                <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" Text="Update">
                </asp:LinkButton>
                &nbsp;&nbsp;
                <asp:LinkButton ID="btnUpdateAndBack" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" Text="Update and Back">
                </asp:LinkButton>
            </div>


        </asp:Panel>

    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Invoices_progress_details_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="Invoices_progress_details_INSERT" InsertCommandType="StoredProcedure"
        UpdateCommand="Invoices_progress_details_UPDATE" UpdateCommandType="StoredProcedure"
        DeleteCommand="Invoices_progress_details_DELETE" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblinvoicelId" Name="invoicelId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Item" />
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="Amount" />
            <asp:Parameter Name="Previous" />
            <asp:Parameter Name="Progress" />
            <asp:ControlParameter ControlID="lblinvoicelId" Name="invoicelId" PropertyName="Text" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Item" />
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="Amount" />
            <asp:Parameter Name="Previous" />
            <asp:Parameter Name="Progress" />
            <asp:Parameter Name="Id" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblJobId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblinvoicelId" runat="server" Visible="false"></asp:Label>

</asp:Content>
