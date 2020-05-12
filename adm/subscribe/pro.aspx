<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="pro.aspx.vb" MasterPageFile="~/adm/BasicMasterPage.Master" Inherits="pasconcept20.pro" %>

<%@ MasterType VirtualPath="~/adm/BasicMasterPage.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="row">
        <div class="col-md-9" style="text-align: center">
            <h1>My Subscription Plan</h1>
        </div>
        <div class="col-md-3">
            <asp:Panel ID="pnlReturn" runat="server" Style="margin-top: 10px">
                <asp:LinkButton ID="btnHome" runat="server" title="Home" data-toggle="tooltip" class="btn btn-success width-100 btn-lg" PostBackUrl="~/ADM/Default.aspx">
                      Return&nbsp;<span class="circle bg-white"></span>
                </asp:LinkButton>
                <h5><span class="label label-default center-block"></span>No outstanding payments</h5>
            </asp:Panel>
        </div>
    </div>


    <form>
        <div class="form-group">
            <div class="row">
                <div class="col-md-3">
                    <label for="inputdefault">Selected company:</label>

                    <telerik:RadComboBox ID="cboCompany" runat="server" DataSourceID="SqlDataSourceCompany" ToolTip="Company" Width="100%"
                        DataTextField="Name" DataValueField="companyId" AutoPostBack="True">
                    </telerik:RadComboBox>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3">
                    <label for="inputdefault">Expiration Date:</label>
                    <asp:Label CssClass="form-control" ID="lblbillingExpirationDate" runat="server"></asp:Label>
                </div>
            </div>

            <div class="row">
                <div class="col-md-4">
                    <hr />
                    <label for="inputdefault">Plans for next billing period:</label>
                    <telerik:RadComboBox ID="cboPlans" runat="server" DataSourceID="SqlDataSourcePlans" DataTextField="Name" DataValueField="Id" AutoPostBack="true" Width="100%">
                    </telerik:RadComboBox>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="Name" DataSourceID="SqlDataSourceBillingPlan"
                        Width="100%">
                        <ItemTemplate>

                            <table class="table-condensed">
                                <tr>
                                    <td style="text-align: right;width:160px">
                                        <label for="inputdefault">Price/Period:</label>
                                    </td>
                                    <td style="text-align: left; padding-left: 10px">
                                        <asp:Label CssClass="form-control" ID="Label1" runat="server" Text='<%# Eval("Price","{0:C2}") %>'></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">
                                        <label for="inputdefault">Maximum number of users:</label>
                                    </td>
                                    <td style="text-align: left; padding-left: 10px">
                                        
                                        <asp:Label CssClass="form-control" ID="Label2" runat="server" Text='<%# Eval("MaxUsers") %>'></asp:Label>
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
                </div>
            </div>
        </div>

    </form>

    <asp:Panel ID="pnlSideTools" runat="server" CssClass="row hidden-print" Visible="false">
        <div class="col-lg-12" style="margin-top: 10px">
            <div class="row">
                <div class="col-lg-6 col-lg-offset-6">
                    <h2><span class="label label-default center-block">Payment method</span></h2>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6 col-lg-offset-6">
                    <a id="btnModalCard" runat="server" title="Credit Card" data-toggle="tooltip" href="#" class="btn btn-primary width-100 btn-lg btn-modal-card" style="display: none;">Credit Card&nbsp;<span class="circle bg-white"><i class="fa fa-credit-card" aria-hidden="true"></i></span></a>
                    <asp:LinkButton ID="btnPay" runat="server" title="PayPal" data-toggle="tooltip" class="btn btn-success width-100 btn-lg">
                                        Pay Here&nbsp;
                                        <span class="circle bg-white"><i class="fa credit-card" aria-hidden="true"></i></span>
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnAdminPay" runat="server" title="Check Pay" data-toggle="tooltip" class="btn btn-warning width-100 btn-lg" Visible="false">
                                        Pay (Admin)&nbsp;
                                        <span class="circle bg-white"><i class="fa fa-paypal" aria-hidden="true"></i></span>
                    </asp:LinkButton>
                </div>
            </div>
        </div>
    </asp:Panel>
    <div class="row" style="margin-top: 15px">
        <h2>Payment Activity</h2>
        <telerik:RadGrid ID="RadGridPayments" GridLines="None" runat="server" AllowPaging="True"
            AutoGenerateColumns="False" DataSourceID="SqlDataSourcePayment" Height="300px" PageSize="100">
            <ClientSettings>
                <Scrolling AllowScroll="True" SaveScrollPosition="true"></Scrolling>
            </ClientSettings>
            <MasterTableView DataKeyNames="Id"
                DataSourceID="SqlDataSourcePayment" HorizontalAlign="NotSet" AutoGenerateColumns="False">
                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                <Columns>
                    <telerik:GridBoundColumn DataField="PaymentNumber" HeaderText="PaymentNumber" HeaderStyle-Width="150px"
                        SortExpression="PaymentNumber" UniqueName="PaymentNumber">
                    </telerik:GridBoundColumn>
                    <telerik:GridDateTimeColumn DataField="ExpirationDate" HeaderStyle-Width="150px" PickerType="DatePicker" HeaderText="Expiration"
                        SortExpression="ExpirationDate" UniqueName="ExpirationDate" DataFormatString="{0:d}">
                    </telerik:GridDateTimeColumn>
                    <telerik:GridNumericColumn DataField="Amount" HeaderStyle-Width="150px" HeaderText="Amount"
                        SortExpression="Amount" UniqueName="Amount" DataFormatString="{0:N2}">
                    </telerik:GridNumericColumn>
                    <telerik:GridBoundColumn DataField="Status" HeaderText="Status" HeaderStyle-Width="150px"
                        SortExpression="Status" UniqueName="Status">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="InvoiceNotes" HeaderText="Notes" ItemStyle-Font-Size="Small"
                        SortExpression="InvoiceNotes" UniqueName="InvoiceNotes">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
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

    <asp:Label ID="lblError" runat="server" Visible="false"></asp:Label>
    

    <asp:SqlDataSource ID="SqlDataSourcePlans" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="COMPANY_BILLINGPLAN_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceBillingPlan" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Billing_plans].[Name], billing_baseprice as Price, billing_baseusers as MaxUsers, [Billing_periods].Name As BillingPeriod FROM [Billing_plans] inner join [Billing_periods] ON [Billing_plans].[billing_period_Id]=[Billing_periods].Id WHERE [Billing_plans].[Id]=@Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboPlans" Name="Id" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceCompany" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CompaniesUser_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblEmployeeEmail" Name="Email" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourcePayment" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Company_Payments_Select" SelectCommandType="StoredProcedure"
        InsertCommand="Company_Payments_INSERT" InsertCommandType="StoredProcedure"
        UpdateCommand="Company_Payments_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="CompanyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="CompanyId" PropertyName="Text" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="lblPaymentMethodId" Name="MetodId" Type="Int32" />
            <asp:ControlParameter ControlID="lblPayPalPaymentId" Name="PayPalPaymentId" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="CompanyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyPaymentsPendingId" Name="Id" PropertyName="Text" Type="Int32" />
        </UpdateParameters>

    </asp:SqlDataSource>


    <asp:Label ID="lblCompanyId" runat="server" Text="0" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyPaymentsPendingId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblPayPalPaymentId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblPaymentMethodId" runat="server" Visible="False"></asp:Label>

</asp:Content>

