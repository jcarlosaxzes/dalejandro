<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="jobprogressrollup.aspx.vb" MasterPageFile="~/e2103445_8a47_49ff_808e_6008c0fe13a1/ClientPortalMP.Master" Inherits="pasconcept20.jobprogressrollup" %>

<%@ MasterType VirtualPath="~/e2103445_8a47_49ff_808e_6008c0fe13a1/ClientPortalMP.Master" %>

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
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceJob" Width="100%">
                <ItemTemplate>

                    <table style="width: 100%; background-color: white; margin-top: 20px">
                        <tr>
                            <td style="text-align: left; vertical-align: top; width: 45%">
                                <h2><span class="navbar navbar-expand-md bg-dark text-white">Client</span></h2>

                                <h3 style="margin: 0"><%# Eval("ClientName")%></h3>
                                <%# Eval("ClientCompany") %><br />
                                <%# Eval("ClientFullAddress")%><br />
                                <%# LocalAPI.PhoneHTML(Request.UserAgent, Eval("Phone"))%><br />
                            </td>
                            <td style="width: 10%"></td>
                            <td style="text-align: right; vertical-align: top">
                                <h2><span class="navbar navbar-expand-md bg-dark text-white">Project Information</span></h2>
                                <h3 style="margin: 0"><%# Eval("ProjectName") %></h3>
                                <%# Eval("ProjectLocation") %><br />
                                <table style="width: 100%">
                                    <tr>
                                        <td style="text-align: right;">Contract Amount:</td>
                                        <td style="width: 120px;">
                                            <h4 style="margin: 3px"><%# Eval("Budget","{0:C2}") %></h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;">Amount Paid:</td>
                                        <td>
                                            <h4 style="margin: 3px"><%# Eval("TotalPaid","{0:C2}") %></h4>
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
            <telerik:RadGrid ID="RadGridInvoices" runat="server" DataSourceID="SqlDataSourceJobInvoicesAndPayments" ShowFooter="true" Width="100%" Skin="Bootstrap">
                <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSourceJobInvoicesAndPayments">
                    <FooterStyle BorderStyle="None" />

                    <Columns>
                        <telerik:GridTemplateColumn DataField="InvoiceNumber" HeaderText="Invoice" UniqueName="InvoiceNumber"
                            HeaderStyle-Width="140px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <a href='<%# LocalAPI.GetSharedLink_URL(4,Eval("Id"))%>' target="_blank" title="view invoice"><%# Eval("InvoiceNumber")%></a>
                            </ItemTemplate>

                        </telerik:GridTemplateColumn>

                        <telerik:GridBoundColumn DataField="InvoiceAmount" HeaderText="Amount" UniqueName="InvoiceAmount"
                            HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" DataFormatString="{0:C}"
                            FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true" ItemStyle-CssClass="GridColumn">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="InvoiceNotes" HeaderText="Notes" UniqueName="InvoiceNotes"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Size="Small" ItemStyle-HorizontalAlign="Left">
                        </telerik:GridBoundColumn>

                        <telerik:GridTemplateColumn DataField="PaidInfo" HeaderText="Payment Info" UniqueName="PaidInfo" HeaderStyle-Width="230px"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Size="Small" ItemStyle-HorizontalAlign="Left">
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


            <%-- Fixed Btns --%>
            <div style="width: 100%; text-align: center; padding-top: 80px !important">
                <p class="text-muted">
                    <br />
                    Thanks for letting us serve you!
                </p>
            </div>
            <div style="width: 100%; text-align: right; font-size: small; font-style: italic; padding-top: 50px">
                This REPORT was generated and sent using <a href="https://pasconcept.com/" target="_blank">pasconcept.com</a>

            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="SqlDataSourceJob" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOB_Adapter" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="llJobId" Name="JobId" PropertyName="Text" Type="Int32" />
        </SelectParameters>

    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceJobInvoicesAndPayments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOB_InvoicesAndPayments_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="llJobId" Name="JobId" PropertyName="Text" Type="Int32" />
        </SelectParameters>

    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="llJobId" runat="server" Visible="False"></asp:Label>


</asp:Content>

