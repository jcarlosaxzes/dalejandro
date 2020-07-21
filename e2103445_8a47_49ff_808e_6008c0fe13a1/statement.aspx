﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="statement.aspx.vb" MasterPageFile="~/e2103445_8a47_49ff_808e_6008c0fe13a1/ClientPortalMP.Master" Inherits="pasconcept20.statement1" Async="true" %>

<%@ MasterType VirtualPath="~/e2103445_8a47_49ff_808e_6008c0fe13a1/ClientPortalMP.master" %>

<%@ Import Namespace="pasconcept20" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
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

        .divcorners {
            border-radius: 15px;
            border: 2px solid black;
            padding: 5px;
        }
    </style>
    <telerik:RadAjaxManager ID="uxRadAjaxManager" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnAgreeCreditCard">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlModalCreditCard" LoadingPanelID="uxLoadingPanel" />
                    <telerik:AjaxUpdatedControl ControlID="pnlError" />
                    <telerik:AjaxUpdatedControl ControlID="pnlSuccess" />
                    <telerik:AjaxUpdatedControl ControlID="pnlSideTools" />
                    <telerik:AjaxUpdatedControl ControlID="FormView1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="uxLoadingPanel" runat="server"></telerik:RadAjaxLoadingPanel>
    <%-- Modals and the like --%>
    <div class="modal fade" id="modal-card">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">Credit Card Information</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <asp:Panel ID="pnlModalCreditCard" runat="server" CssClass="col-md-12">
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label>First Name</label>
                                    <telerik:RadTextBox ID="txtFirstName" Width="100%" Skin="" runat="server" CssClass="form-control" placeholder="First Name"></telerik:RadTextBox>
                                </div>
                                <!-- end form-group -->
                                <div class="form-group col-md-6">
                                    <label>Last Name</label>
                                    <telerik:RadTextBox ID="txtLastName" Width="100%" Skin="" runat="server" CssClass="form-control" placeholder="Last Name"></telerik:RadTextBox>
                                </div>
                                <!-- end form-group -->
                            </div>
                            <div class="row">
                                <div class="form-group col-md-12">
                                    <label>Email</label>
                                    <telerik:RadTextBox ID="txtEmail" InputType="Email" Width="100%" Skin="" runat="server" CssClass="form-control" placeholder="Email"></telerik:RadTextBox>
                                </div>
                                <!-- end form-group -->
                            </div>
                            <div class="row">
                                <div class="form-group col-md-12">
                                    <asp:HiddenField ID="hdnCardType" runat="server" />
                                    <label id="lbl-card-number">Card Number</label>
                                    <telerik:RadTextBox ID="txtCardNumber" Width="100%" MaxLength="19" runat="server" Skin="" CssClass="form-control input-card-number" placeholder="xxxxxxxxxxxxxxxx">
                                        <ClientEvents OnKeyPress="numberOnly" />
                                    </telerik:RadTextBox>
                                </div>
                                <!-- end form-group -->
                            </div>
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label>Card Expiration Month</label>
                                    <telerik:RadNumericTextBox ID="txtExpireMonth" Width="100%" MaxLength="2" MinValue="1" MaxValue="12" runat="server" Skin="" CssClass="form-control" placeholder="MM">
                                        <NumberFormat GroupSeparator="" DecimalDigits="0" />
                                    </telerik:RadNumericTextBox>
                                </div>
                                <!-- end form-group -->
                                <div class="form-group col-md-6">
                                    <label>Card Expiration Year</label>
                                    <telerik:RadNumericTextBox ID="txtExpireYear" Width="100%" MaxLength="4" MinValue="2016" runat="server" Skin="" CssClass="form-control" placeholder="YYYY">
                                        <NumberFormat GroupSeparator="" DecimalDigits="0" />
                                    </telerik:RadNumericTextBox>
                                </div>
                                <!-- end form-group -->
                            </div>
                            <div class="row">
                                <div class="form-group col-md-3">
                                    <label>CVV</label>
                                    <telerik:RadNumericTextBox ID="txtCVV" Width="100%" MaxLength="3" MinValue="0" MaxValue="999" runat="server" Skin="" CssClass="form-control" placeholder="xxx">
                                        <NumberFormat GroupSeparator="" DecimalDigits="0" />
                                    </telerik:RadNumericTextBox>
                                </div>
                                <!-- end form-group -->
                            </div>
                            <div class="row">
                                <div class="form-group col-md-12">
                                    <label>Address</label>
                                    <telerik:RadTextBox ID="txtAddress" Width="100%" runat="server" Skin="" CssClass="form-control" placeholder="Address Line">
                                    </telerik:RadTextBox>
                                </div>
                                <!-- end form-group -->
                            </div>
                            <div class="row">
                                <div class="form-group col-md-4">
                                    <label>City</label>
                                    <telerik:RadTextBox ID="txtCity" Width="100%" runat="server" Skin="" CssClass="form-control" placeholder="City">
                                    </telerik:RadTextBox>
                                </div>
                                <!-- end form-group -->
                                <div class="form-group col-md-4">
                                    <label>State</label>
                                    <telerik:RadTextBox ID="txtState" Width="100%" runat="server" Skin="" CssClass="form-control" MaxLength="2" placeholder="State">
                                    </telerik:RadTextBox>
                                </div>
                                <!-- end form-group -->
                                <div class="form-group col-md-4">
                                    <label>Zip Code</label>
                                    <telerik:RadNumericTextBox ID="txtZip" Width="100%" MaxLength="5" MinValue="0" MaxValue="99999" runat="server" Skin="" CssClass="form-control" placeholder="Zip">
                                        <NumberFormat GroupSeparator="" DecimalDigits="0" />
                                    </telerik:RadNumericTextBox>
                                </div>
                                <!-- end form-group -->
                            </div>
                        </asp:Panel>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <asp:LinkButton ID="btnAgreeCreditCard" runat="server" CssClass="btn btn-primary" OnClick="btnAgreeCreditCard_Click">Pay</asp:LinkButton>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
    <%-- End Modals and the like --%>
    <div class="main-content">
        <%-- Panel Error --%>
        <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger">
            <strong>Error</strong>
            <asp:Literal ID="ltrlError" runat="server"></asp:Literal>
        </asp:Panel>
        <%-- Panel Success --%>
        <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="alert alert-success">
            <strong>Success</strong>
            Your payment has been processed. Thank you for your business!!!
                        <asp:Literal ID="ltrlSuccess" runat="server"></asp:Literal>
        </asp:Panel>
        <div style="font-size: 16px">
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceStatement" Width="100%">
                <ItemTemplate>

                    <table style="width: 100%; background-color: white; margin-top: 20px">
                        <tr>
                            <td style="text-align: left; vertical-align: top; width: 45%">
                                
                                <div class="divcorners">
                                    <h3 style="text-align: center; margin:10px">Bill To</h3>
                                </div>
                                <h3 style="padding-top:15px;padding-bottom:5px;margin:0"><%# Eval("ClientName")%></h3>
                                <%# Eval("ClientCompany") %><br />
                                <%# Eval("ClientFullAddress")%><br />
                                <%# LocalAPI.PhoneHTML(Request.UserAgent, Eval("Phone"))%>
                            </td>
                            <td style="width: 10%"></td>
                            <td style="text-align: left; vertical-align: top">
                                <div class="divcorners" >
                                    <h3 style="text-align: center; margin:10px">Statement</h3>
                                </div>
                                <table style="width: 100%;">
                                    <tr>
                                        <td style="width: 180px; text-align: right; padding-right: 15px;padding-top:15px">Statement Number</td>
                                        <td style="width: 200px;padding-top:15px">
                                            <h4 style="margin: 3px"><%# Eval("StatementNumber") %></h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right; padding-right: 15px">Date Emitted</td>
                                        <td>
                                            <h4 style="margin: 3px"><%# Eval("LatestEmission","{0:d}") %></h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right; padding-right: 15px">Amount Billed</td>
                                        <td>
                                            <h4 style="margin: 3px"><%# Eval("AmountBilled", "{0:C2}") %></h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right; padding-right: 15px">Amount Paid</td>
                                        <td>
                                            <h4 style="margin: 3px"><%# Eval("AmountPaid", "{0:C2}") %></h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right; padding-right: 15px">
                                            <h4 style="margin: 3px">Amount Due</h4>
                                        </td>
                                        <td>
                                            <h4 style="margin: 3px"><%# Eval("AmountDue","{0:C2}") %></h4>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>

                    <div style="text-align: left; margin-top: 30px">
                        <h3 style="margin: 5px">Invoices of Statement</h3>
                        <telerik:RadGrid ID="RadGridInvoices" runat="server" DataSourceID="SqlDataSourceInvoices" ShowFooter="true" Width="100%" Skin="Bootstrap">
                            <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSourceInvoices" ShowFooter="false">
                                <FooterStyle BorderStyle="None" />

                                <Columns>

                                    <telerik:GridTemplateColumn DataField="Invoice" HeaderText="Invoice" UniqueName="Invoice"
                                        HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <span class="badge badge-secondary"><%# Eval("InvoiceNumber") %></span>
                                            <b><%# Eval("JobName") %></b>
                                            <br />
                                            <small>
                                                <%# Eval("Notes") %>
                                            </small>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>


                                    <%--                                    <telerik:GridBoundColumn DataField="InvoiceNumber" HeaderText="Invoice" UniqueName="InvoiceNumber"
                                        HeaderStyle-Width="140px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Size="Small">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="JobName" HeaderText="Job Name" UniqueName="JobName"
                                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="250px" ItemStyle-Font-Size="Small">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="Notes" HeaderText="Notes" UniqueName="Notes" HeaderStyle-HorizontalAlign="Center"
                                        Aggregate="None" FooterText="TOTAL: " FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true" ItemStyle-Font-Size="Small">
                                    </telerik:GridBoundColumn>--%>

                                    <telerik:GridBoundColumn DataField="PaidToDate" HeaderText="Amount Paid" UniqueName="PaidToDate"
                                        HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C2}" ItemStyle-Font-Size="Small">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AmountDue" HeaderText="Amount Due" UniqueName="AmountDue"
                                        HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C2}"
                                        ItemStyle-Font-Size="Small">
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                </ItemTemplate>
            </asp:FormView>
            <%-- Fixed Btns --%>
            <asp:Panel ID="pnlSideTools" runat="server" CssClass="row hidden-print" Visible="false">
                <div class="col-lg-12" style="margin-top: 10px">
                    <div class="row">
                        <div class="col-lg-6 col-lg-offset-6">
                            <h2><span class="navbar navbar-expand-md bg-dark text-white d-print-block">Payment method</span></h2>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-lg-offset-6">
                            <a id="btnModalCard" runat="server" title="Credit Card" data-toggle="tooltip" href="#" class="btn btn-primary width-100 btn-lg btn-modal-card" style="display: none;">Credit Card&nbsp;<i class="far fa-credit-card"></i></a>
                            <asp:LinkButton ID="btnPay" runat="server" title="PayPal" data-toggle="tooltip" class="btn btn-success width-100 btn-lg">
                                        Pay Here&nbsp;
                                        <i class="far fa-credit-card"></i>
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <%-- Fixed Blank --%>
            <div style="width: 100%; text-align: center; padding-top: 80px !important">
                <p class="text-muted">
                </p>
            </div>

        </div>
    </div>

    <asp:SqlDataSource ID="SqlDataSourceStatement" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="STATEMENT2_Adapter" SelectCommandType="StoredProcedure"
        InsertCommand="STATEMENT_PAYMENTS_INSERT" InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblStatementId" Name="statementId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblStatementId" Name="statementId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="CollectedDate" Type="DateTime" />
            <asp:Parameter Name="Method" />
            <asp:Parameter Name="CollectedNotes" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceInvoices" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="STATEMENT2_invoices_Adapter" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblStatementId" Name="statementId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblStatementId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblStatementGuid" runat="server" Visible="False"></asp:Label>

    <script
        src="https://code.jquery.com/jquery-3.1.1.min.js"
        integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
        crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <telerik:RadCodeBlock ID="RadCodeBlockInvoice" runat="server">
        <script>
            $(document).on('click', '.btn-modal-card', function (e) {
                e.preventDefault();
                $('#modal-card').modal('show');
            });
            var cardIcons = {
                visa: '<i class="pf pf-visa"></i>',
                mastercard: '<i class="pf pf-mastercard"></>',
                discover: '<i class="pf pf-discover"></>',
                amex: '<i class="pf pf-pf-american-express"></>',
                electron: '<i class="pf pf-visa-electron"></>',
                maestro: '<i class="pf pf-maestro"></>',
                dankort: '<i class="pf pf-dankort"></>',
                interpayment: '<i class="pf pf-wirecard"></>',
                unionpay: '<i class="pf pf-unionpay"></>',
                diners: '<i class="pf pf-diners"></>',
                jcb: '<i class="pf pf-jcb"></>',
                '': ''
            };
            function getCreditCardType(sender, eventArgs) {
                let number = $('#<%=txtCardNumber.ClientID %>').val();
                console.log(number);
                let type = detectCardType(number);
                console.log(type);
                $('#lbl-card-number').html('Card Number&nbsp;' + cardIcons[type]);
                $('#<%=hdnCardType.ClientID %>').val(type);
            }

            $('.input-card-number').keyup(function (e) {
                getCreditCardType();
            });
            function numberOnly(sender, eventArgs) {
                let k = eventArgs.get_keyCode();
                if (!(k >= 48 && k <= 57)) {
                    eventArgs.set_cancel(true);
                }
            }
        </script>
    </telerik:RadCodeBlock>

</asp:Content>

