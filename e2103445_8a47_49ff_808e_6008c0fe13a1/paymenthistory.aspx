<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/e2103445_8a47_49ff_808e_6008c0fe13a1/ClientPortalMP.Master" CodeBehind="paymenthistory.aspx.vb" Inherits="pasconcept20.paymenthistory" %>

<%@ MasterType VirtualPath="~/e2103445_8a47_49ff_808e_6008c0fe13a1/ClientPortalMP.master" %>

<%@ Import Namespace="pasconcept20" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .main-content {
            text-align: center;
        }

            .main-content div {
                padding: 0 !important;
            }

        .widget {
            margin-top: 10px;
            margin-bottom: 10px;
        }

        .row .form-group {
            text-align: left !important;
        }
    </style>
    <div class="main-content">
        <div style="font-size: 16px">
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceClientBalance" Width="100%">
                <ItemTemplate>

                    <table class="table-sm" style="width: 100%">
                        <tr>
                            <td style="text-align: left; vertical-align: top; width: 33%">
                                <h2 style="margin: 0"><span class="navbar navbar-expand-md bg-dark text-white d-print-flex">Client</span></h2>
                                <table style="width: 100%">
                                    <tr>
                                        <td>
                                            <h3 style="margin: 3px"><%# Eval("ClientName")%></h3>
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
                                <h2 style="margin: 0"><span class="navbar navbar-expand-md bg-dark text-white d-print-flex">Projects</span></h2>
                                <table style="width: 85%">
                                    <tr>
                                        <td style="text-align: right"># Pending Proposals:</td>
                                        <td style="width: 120px; text-align: right">
                                            <h4 style="margin: 3px"><%# Eval("NumberPendingProposal", "{0:N0}") %></h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right">Accepted Proposals:</td>
                                        <td style="text-align: right">
                                            <h4 style="margin: 3px"><%# Eval("ProposalAmount", "{0:C2}") %></h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;">Jobs Total Amount:</td>
                                        <td style="text-align: right">
                                            <h4 style="margin: 3px"><%# Eval("ContractAmount", "{0:C2}") %></h4>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="text-align: right; vertical-align: top">
                                <h2 style="margin: 0"><span class="navbar navbar-expand-md bg-dark text-white d-print-flex">Balance</span></h2>
                                <table style="width: 85%">
                                    <tr>
                                        <td style="text-align: right;">Amount Paid:</td>
                                        <td>
                                            <h4 style="margin: 3px"><%# Eval("AmountPaid", "{0:C2}") %></h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;">Remaining Balance:</td>
                                        <td>
                                            <h4 style="margin: 3px"><%# Eval("Balance","{0:C2}") %></h4>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>


                </ItemTemplate>
            </asp:FormView>
            <br />
            <h2><span class="navbar navbar-expand-md bg-dark text-white">Invoices</span></h2>
            <telerik:RadGrid ID="RadGridInvoices" runat="server" DataSourceID="SqlDataSourceInvoicesPayments" ShowFooter="true" Width="100%" Skin="Bootstrap"
                ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small">
                <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSourceInvoicesPayments">
                    <FooterStyle BorderStyle="None" />

                    <Columns>
                        <telerik:GridTemplateColumn DataField="InvoiceNumber" HeaderText="Number" UniqueName="InvoiceNumber"
                            HeaderStyle-Width="140px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <a href='<%# LocalAPI.GetSharedLink_URL(4,Eval("Id"))%>' target="_blank" title="view invoice"><%# Eval("InvoiceNumber")%></a>
                            </ItemTemplate>

                        </telerik:GridTemplateColumn>

                        <telerik:GridBoundColumn DataField="FirstEmission" HeaderText="Date Emitted" UniqueName="FirstEmission" ItemStyle-Font-Size="Small"
                            HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:d}"
                            ItemStyle-CssClass="GridColumn">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="InvoiceAmount" HeaderText="Amount" UniqueName="InvoiceAmount"
                            HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" DataFormatString="{0:C}"
                            FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true" ItemStyle-CssClass="GridColumn">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="InvoiceNotes" HeaderText="Notes" UniqueName="InvoiceNotes"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                        </telerik:GridBoundColumn>

                        <telerik:GridTemplateColumn DataField="PaidInfo" HeaderText="Payment Info" UniqueName="PaidInfo" HeaderStyle-Width="230px"
                            HeaderStyle-HorizontalAlign="Center"  ItemStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <span title='<%# Eval("PastDueStatusTitle") %>' class="label badge-<%# IIf(Eval("PastDueStatus") = 5, "danger", IIf(Eval("PastDueStatus") = 4, "warning", IIf(Eval("PastDueStatus") = 3, "primary", IIf(Eval("PastDueStatus") = 2, "info", IIf(Eval("PastDueStatus") = 1, "default", "success"))))) %>"><%# Eval("PastDueStatusName") %></span>
                                <%# Eval("PaidInfo","{0:C}") %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridBoundColumn DataField="PaymentAmount" HeaderText="Amount Paid" UniqueName="PaymentAmount"
                            HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" DataFormatString="{0:C}"
                            FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true" ItemStyle-CssClass="GridColumn">
                        </telerik:GridBoundColumn>

                        <telerik:GridTemplateColumn DataField="AmountDue" HeaderText="Amount Due" UniqueName="AmountDue"
                            HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:C2}"
                            FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true" ItemStyle-CssClass="GridColumn">
                            <ItemTemplate>
                                <%# Eval("AmountDue","{0:C}") %>
                                <%--<br />
                                <span title='<%# Eval("Status") %>' class="label badge-<%# IIf(Eval("Status") = "PAID", "default", "primary") %>"><%# Eval("Status") %>--%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>

            <h2><span class="navbar navbar-expand-md bg-dark text-white">Statements</span></h2>
            <telerik:RadGrid ID="RadGridStatements" runat="server" DataSourceID="SqlDataSourceStatements" ShowFooter="true" Width="100%" Skin="Bootstrap">
                <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSourceStatements">
                    <FooterStyle BorderStyle="None" />

                    <Columns>
                        <telerik:GridTemplateColumn DataField="Number" HeaderText="Number" UniqueName="Number"
                            HeaderStyle-Width="140px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <a href='<%# LocalAPI.GetSharedLink_URL(55,Eval("Id"))%>' target="_blank" title="view statement"><%# Eval("Number")%></a>
                            </ItemTemplate>

                        </telerik:GridTemplateColumn>

                        <telerik:GridBoundColumn DataField="AmountBilled" HeaderText="Amount" UniqueName="AmountBilled"
                            HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" DataFormatString="{0:C}"
                            FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true" ItemStyle-CssClass="GridColumn">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="InvoiceNotes" HeaderText="Notes" UniqueName="InvoiceNotes"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Size="Small" ItemStyle-HorizontalAlign="Left">
                        </telerik:GridBoundColumn>

                        <telerik:GridTemplateColumn DataField="PaidInfo" HeaderText="Payment Info" UniqueName="PaidInfo" HeaderStyle-Width="150px"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Size="Small" ItemStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <span title='<%# Eval("PastDueStatusTitle") %>' class="label badge-<%# IIf(Eval("PastDueStatus") = 5, "danger", IIf(Eval("PastDueStatus") = 4, "warning", IIf(Eval("PastDueStatus") = 3, "primary", IIf(Eval("PastDueStatus") = 2, "info", IIf(Eval("PastDueStatus") = 1, "default", "success"))))) %>"><%# Eval("PastDueStatusName") %></span>

                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridBoundColumn DataField="PaymentAmount" HeaderText="Amount Paid" UniqueName="PaymentAmount"
                            HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" DataFormatString="{0:C}"
                            FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true" ItemStyle-CssClass="GridColumn">
                        </telerik:GridBoundColumn>

                        <telerik:GridTemplateColumn DataField="AmountDue" HeaderText="Amount Due" UniqueName="AmountDue"
                            HeaderStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:C2}"
                            FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true" ItemStyle-CssClass="GridColumn">
                            <ItemTemplate>
                                <%# Eval("AmountDue","{0:C}") %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>


            <%-- Fixed Blank --%>
            <div style="width: 100%; text-align: center; padding-top: 80px !important">
                <p class="text-muted">
                </p>
            </div>

        </div>
    </div>

 <asp:SqlDataSource ID="SqlDataSourceClientBalance" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Client_Balance" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblClientId" Name="ClientId" PropertyName="Text" Type="Int32" />
        </SelectParameters>

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceInvoicesPayments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENT_InvoicesAndPayments_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblClientId" Name="ClientId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSourceStatements" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENT_Statements_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblClientId" Name="ClientId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblClientId" runat="server" Visible="False"></asp:Label>


</asp:Content>

