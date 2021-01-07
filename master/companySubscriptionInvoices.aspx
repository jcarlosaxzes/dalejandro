<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="companySubscriptionInvoices.aspx.vb" Inherits="pasconcept20.companySubscriptionInvoices" %>

<%@ MasterType VirtualPath="~/master/MasterPage.Master" %>

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


            <table class="table-sm" style="width: 100%">
                <tr>
                    <td style="text-align: left; vertical-align: top; width: 33%">
                        <h2 style="margin: 0"><span class="navbar navbar-expand-md bg-dark text-white d-print-flex">Company</span></h2>
                        <table style="width: 85%">
                            <tr>
                                <td style="width: 100%; text-align: right">
                                    <asp:FormView ID="FormView2" runat="server" DataKeyNames="Name" DataSourceID="SqlDataSourceBillingPlan"
                                        Width="100%">
                                        <ItemTemplate>

                                            <table class="table-sm">
                                                <tr>
                                                    <td style="width: 160px">
                                                        <label>Name:</label>
                                                    </td>
                                                    <td style="text-align: left; padding-left: 10px">
                                                        <h3 style="margin: 3px"><%# Eval("Name")%></h3>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label>Contact:</label>
                                                    </td>
                                                    <td style="text-align: left; padding-left: 10px">
                                                        <h3 style="margin: 3px"><%# Eval("Contact")%></h3>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label>Email:</label>
                                                    </td>
                                                    <td style="text-align: left; padding-left: 10px">
                                                        <h3 style="margin: 3px"><%# Eval("Email")%></h3>

                                                    </td>
                                                </tr>
                                            </table>

                                        </ItemTemplate>
                                    </asp:FormView>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="width: 33%; text-align: center; vertical-align: top">
                        <h2 style="margin: 0"><span class="navbar navbar-expand-md bg-dark text-white d-print-flex">Billing Plan</span></h2>
                        <table style="width: 85%">
                            <tr>
                                <td style="width: 100%; text-align: right">
                                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="Name" DataSourceID="SqlDataSourceBillingPlan"
                                        Width="100%">
                                        <ItemTemplate>

                                            <table class="table-sm">
                                                <tr>
                                                    <td style="text-align: right; width: 160px">
                                                        <label for="inputdefault">Price/Period:</label>
                                                    </td>
                                                    <td style="text-align: left; padding-left: 10px">
                                                        <asp:Label CssClass="form-control" ID="Label1" runat="server" Text='<%# Eval("billing_baseprice", "{0:C2}") %>'></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: right">
                                                        <label for="inputdefault">Maximum number of users:</label>
                                                    </td>
                                                    <td style="text-align: left; padding-left: 10px">

                                                        <asp:Label CssClass="form-control" ID="Label2" runat="server" Text='<%# Eval("billing_baseusers") %>'></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: right">
                                                        <label for="inputdefault">Billing Period:</label>
                                                    </td>
                                                    <td style="text-align: left; padding-left: 10px">
                                                        <asp:Label CssClass="form-control" ID="Label3" runat="server" Text='<%# Eval("BillingPeriod") %>'></asp:Label>

                                                    </td>
                                                </tr>
                                            </table>

                                        </ItemTemplate>
                                    </asp:FormView>
                                </td>
                            </tr>
                        </table>
                    </td>

                </tr>
            </table>

            <br />
            <h2><span class="navbar navbar-expand-md bg-dark text-white">Invoices</span></h2>
            <asp:Panel ID="pnlReturn" runat="server" Style="margin-top: 10px; text-align: left;">
                <asp:LinkButton ID="btnCreateInvoice" runat="server" title="Create Invoice" data-toggle="tooltip" class="btn btn-success width-100 btn-lg">
                      Create Invoice
                </asp:LinkButton>
            </asp:Panel>
            <br />


            <telerik:RadGrid ID="RadGridInvoices" runat="server" DataSourceID="SqlDataSourceInvoicesPayments" ShowFooter="true" Width="100%" Skin="Bootstrap"
                ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small">
                <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSourceInvoicesPayments">
                    <FooterStyle BorderStyle="None" />

                    <Columns>
                        <telerik:GridTemplateColumn DataField="InvoiceNumber" HeaderText="Number" UniqueName="InvoiceNumber"
                            HeaderStyle-Width="140px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <a href='<%# LocalAPI.GetSharedLink_URL(4, Eval("Id"))%>' target="_blank" title="view invoice"><%# Eval("InvoiceNumber")%></a>
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
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <span title='<%# Eval("PastDueStatusTitle") %>' class="label badge-<%# IIf(Eval("PastDueStatus") = 5, "danger", IIf(Eval("PastDueStatus") = 4, "warning", IIf(Eval("PastDueStatus") = 3, "primary", IIf(Eval("PastDueStatus") = 2, "info", IIf(Eval("PastDueStatus") = 1, "default", "success"))))) %>"><%# Eval("PastDueStatusName") %></span>
                                <%# Eval("PaidInfo", "{0:C}") %>
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
                                <%# Eval("AmountDue", "{0:C}") %>
                                <%--<br />
                                <span title='<%# Eval("Status") %>' class="label badge-<%# IIf(Eval("Status") = "PAID", "default", "primary") %>"><%# Eval("Status") %>--%>
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


    <telerik:RadToolTip ID="RadToolTipCreateInvoice" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; color: white; width: 600px">
            <span class="navbar navbar-expand-md bg-dark text-white">Create Invoice
            </span>
        </h2>

        <table class="table-sm" style="width: 600px">

            <tr>
                <td>From:
                </td>
                <td>
                    <telerik:RadDatePicker ID="dpFrom" runat="server" ZIndex="50001">
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td>To:
                </td>
                <td>
                    <telerik:RadDatePicker ID="dpTo" runat="server" ZIndex="50001">
                    </telerik:RadDatePicker>
                </td>

            </tr>
            <tr>
                <td>Year Amount:
                </td>
                <td>
                    <telerik:RadNumericTextBox ID="txtyearAmount" runat="server">
                    </telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>
                <td>Billing period:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboBillingPeriod" runat="server" AutoPostBack="true" DataSourceID="SqlDataSourceBillingPeriod" DataTextField="Name" DataValueField="Id" Width="100%" ZIndex="50001">
                    </telerik:RadComboBox>
                </td>
            </tr>

            <tr>
                <td>Period Amount:
                </td>
                <td>
                    <telerik:RadNumericTextBox ID="txtperiodAmount" runat="server">
                    </telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 120px">Notes</td>
                <td>
                    <telerik:RadTextBox ID="txtInvoiceNotes" runat="server" MaxLength="1024"
                        TextMode="MultiLine" Width="100%" Rows="4">
                    </telerik:RadTextBox>
                </td>
            </tr>


            <tr>
                <td style="text-align: center" colspan="2">
                    <asp:LinkButton ID="btnSaveInvoice" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false"> Create
                    </asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:LinkButton ID="btnCancelInvoice" runat="server" CssClass="btn btn-secondary btn" UseSubmitBehavior="false"
                                > Cancel
                            </asp:LinkButton>
                </td>
            </tr>
        </table>



    </telerik:RadToolTip>



    <asp:SqlDataSource ID="SqlDataSourceInvoicesPayments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOB_InvoicesAndPaymentsSubscription_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblJobId" Name="JobId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>



    <asp:SqlDataSource ID="SqlDataSourceBillingPlan" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="select company.[companyId],company.[Name],company.[Contact],company.[Email], company.billingExpirationDate , Billing_plans.Name AS BillingPlan ,Billing_plans.billing_baseprice,Billing_plans.billing_baseusers,Billing_periods.Name As BillingPeriod from company LEFT OUTER JOIN  Billing_plans ON Company.Billing_plan = Billing_plans.Id LEFT  OUTER JOIN Billing_periods on Billing_periods.Id = Billing_plans.billing_period_Id where companyId = @companyId">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceBillingPeriod" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id],[Name],[Code] FROM [dbo].[Billing_periods]"></asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblJobId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>

</asp:Content>

