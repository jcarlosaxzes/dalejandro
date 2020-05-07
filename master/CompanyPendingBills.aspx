<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="companypendingbills.aspx.vb" Inherits="pasconcept20.CompanyPendingBills" %>


<%@ MasterType VirtualPath="~/master/MasterPage.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2>Company Billing</h2>

    <table class="table-condensed" style="width: 100%">
        <tr>
            <td>
        <telerik:RadComboBox ID="cboStatus" runat="server" Width="450px" Label="Payment Status:" AutoPostBack="true">
            <Items>
                <telerik:RadComboBoxItem Text="Pending" Value="0" Selected="true" />
                <telerik:RadComboBoxItem Text="Paid" Value="1" />
                <telerik:RadComboBoxItem Text="All Bills" Value="-1" />
            </Items>
        </telerik:RadComboBox>

            </td>
        </tr>
    </table>
    <telerik:RadGrid ID="RadGridPayments" GridLines="None" runat="server" AllowPaging="True"
        AutoGenerateColumns="False" DataSourceID="SqlDataSourcePayment" Height="700px" PageSize="100">
        <ClientSettings>
            <Scrolling AllowScroll="True" SaveScrollPosition="true"></Scrolling>
        </ClientSettings>
        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourcePayment" AutoGenerateColumns="False">
            <PagerStyle Mode="Slider" AlwaysVisible="false" />
            <Columns>
                <telerik:GridBoundColumn DataField="PaymentNumber" HeaderText="PaymentNumber" HeaderStyle-Width="150px"
                    SortExpression="PaymentNumber" UniqueName="PaymentNumber">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Name" HeaderText="Company"
                    SortExpression="Name" UniqueName="Name">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Contact" HeaderText="Contact"
                    SortExpression="Contact" UniqueName="Contact">
                </telerik:GridBoundColumn>
                <telerik:GridDateTimeColumn DataField="CreateDate" HeaderStyle-Width="150px" HeaderText="Create"
                    SortExpression="CreateDate" UniqueName="CreateDate" DataFormatString="{0:d}">
                </telerik:GridDateTimeColumn>
                <telerik:GridDateTimeColumn DataField="ExpirationDate" HeaderStyle-Width="150px" PickerType="DatePicker" HeaderText="Expiration"
                    SortExpression="ExpirationDate" UniqueName="ExpirationDate" DataFormatString="{0:d}">
                </telerik:GridDateTimeColumn>
                <telerik:GridNumericColumn DataField="Amount" HeaderStyle-Width="150px" HeaderText="Amount"
                    SortExpression="Amount" UniqueName="Amount" DataFormatString="{0:N2}">
                </telerik:GridNumericColumn>
                <telerik:GridBoundColumn DataField="Status" HeaderText="Status" HeaderStyle-Width="150px"
                    SortExpression="Status" UniqueName="Status">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="MethodName" HeaderText="Method" ItemStyle-Font-Size="Small"
                    SortExpression="MethodName" UniqueName="MethodName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="InvoiceNotes" HeaderText="Notes" ItemStyle-Font-Size="Small"
                    SortExpression="InvoiceNotes" UniqueName="InvoiceNotes">
                </telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource ID="SqlDataSourcePayment" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CompanyPendingBills_Select" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboStatus" Name="status" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

