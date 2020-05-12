<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="baddebt.aspx.vb" Inherits="pasconcept20.baddebt" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BadDebt</title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" EnableCdn="true" runat="server">
        </telerik:RadScriptManager>
        <div>
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceInvoice" Width="100%">
                <ItemTemplate>
                    <h2 style="margin-top: 10px; margin-bottom: 0">Bill To</h2>

                    <h3 style="margin: 0"><%# Eval("ClientName")%></h3>
                    <%# Eval("ClientCompany") %><br />

                    <h2 style="margin-top: 10px; margin-bottom: 0">Project Information</h2>
                    <h3 style="margin: 0"><%# Eval("ProjectName") %></h3>
                    <%# Eval("ProjectLocation") %><br />
                    Contract Amount:&nbsp;<span style="margin: 3px; font-weight: bold"><%# Eval("Budget","{0:C2}") %></span>

                    <h2 style="margin-top: 10px; margin-bottom: 0">Invoice</h2>
                    <table>
                        <tr>
                            <td style="width: 180px;">Invoice Number</td>
                            <td style="width: 200px;">
                                <h4 style="margin: 3px"><%# Eval("InvoiceNumber") %></h4>
                            </td>
                        </tr>
                        <tr>
                            <td>Amount Paid</td>
                            <td>
                                <h4 style="margin: 3px"><%# Eval("TotalPaid","{0:C2}") %></h4>
                            </td>
                        </tr>
                        <tr>
                            <td>Remaining Balance</td>
                            <td>
                                <h4 style="margin: 3px"><%# Eval("Balance","{0:C2}") %></h4>
                            </td>
                        </tr>
                        <tr>
                            <td>Amount Due</td>
                            <td>
                                <h4 style="margin: 3px"><%# Eval("AmountDue","{0:C2}") %></h4>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <%# Eval("Notes")%>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <div>
                        To mark a Invoice as BadDept, is recomended:
                 <ul>
                     <li>Amount Due > 0</li>
                     <li>Not in a Statement</li>
                 </ul>
                    </div>
                </ItemTemplate>
            </asp:FormView>
            <asp:Label ID="lblMsg" runat="server" Visible="False"></asp:Label>
            <br />
            <div id="divBtn" runat="server" class="divBtn">
                <telerik:RadButton ID="btnUpdate" runat="server" Text="Record Invoice as BAD DEBT" Primary="true">
                    <Icon PrimaryIconCssClass="rbSave"></Icon>
                </telerik:RadButton>
            </div>
        </div>

        <asp:SqlDataSource ID="SqlDataSourceInvoice" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="INVOICE3_Adapter" SelectCommandType="StoredProcedure"
            UpdateCommand="INVOICE_BadDebt_UPDATE" UpdateCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                <asp:ControlParameter ControlID="lblInvoiceId" Name="InvoiceId" PropertyName="Text" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="lblInvoiceId" Name="Id" PropertyName="Text" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblInvoiceId" runat="server" Visible="False"></asp:Label>
    </form>
</body>
</html>
