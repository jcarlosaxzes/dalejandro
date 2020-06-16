<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/e2103445_8a47_49ff_808e_6008c0fe13a1/singclientportal.master" CodeBehind="singproposalsign.aspx.vb" Inherits="pasconcept20.singproposalsign" %>

<%@ MasterType VirtualPath="~/e2103445_8a47_49ff_808e_6008c0fe13a1/SingClientPortal.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <link rel="stylesheet" href='<%= ResolveUrl("~/Content/sing-theme/quote-fullview.css") %>' />
    <link rel="stylesheet" href='<%= ResolveUrl("~/Content/sing-theme/signature-pad.css") %>' />
    <style>
        hr {
            margin-top: 2px !important;
            margin-bottom: 2px !important;
        }

        .img-signature {
            width: 192px !important;
            height: 120px !important;
        }

        deny

        .no-margin-button {
            margin-bottom: 0 !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <%-- Modals and the like --%>
    <!-- DenyModal -->
    <div id="modal-deny" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h5 class="modal-title text-xl-center fw-bold mt" id="modal-deny-header">Warning</h5>
                </div>
                <div class="modal-body">
                    <p class="text-xl-center text-muted mt-sm fs-mini">
                        <strong>Are you sure you want to deny this proposal?</strong>
                    </p>
                </div>
                <!-- End of Modal body -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-gray" data-dismiss="modal">Cancel</button>
                    <asp:LinkButton ID="btnDenyProposal" runat="server" CssClass="btn btn-danger" Text="Deny" OnClick="btnDenyProposal_Click"></asp:LinkButton>
                </div>
                <!-- End of Modal Footer -->
            </div>
            <!-- End of Modal content -->
        </div>
        <!-- End of Modal dialog -->
    </div>
    <!-- End of DenyModal -->
    <!-- AcceptModal -->
    <div id="modal-accept" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h5 class="modal-title text-xl-center fw-bold mt" id="modal-deny-accept">Accept by signing below</h5>
                </div>
                <div class="modal-body">
                    <fieldset>
                        <div class="form-group row">
                            <label class="col-sm-4 form-control-label">Name</label>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txtSignName" runat="server" CssClass="form-control sign-name"></asp:TextBox>
                            </div>
                        </div>
                    </fieldset>
                </div>
                <div class="modal-body">
                    <div id="signature-pad" class="m-signature-pad">
                        <div class="m-signature-pad--body">
                            <canvas></canvas>
                        </div>
                    </div>
                </div>
                <!-- End of Modal body -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-gray" data-dismiss="modal">Cancel</button>
                    &nbsp;&nbsp;&nbsp;
                    <button type="button" class="btn btn-secondary" data-action="clear">Clear</button>
                    &nbsp;&nbsp;&nbsp;
                    <button id="btnSign" type="button" runat="server" data-action="save" class="btn btn-success" style="width: 100px">Sign</button>
                </div>
                <!-- End of Modal Footer -->
            </div>
            <!-- End of Modal content -->
        </div>
        <!-- End of Modal dialog -->
    </div>
    <!-- End of Accept -->
    <%-- End Modals and the like --%>
    <%-- Fixed Btns --%>
    <asp:Panel ID="pnlSideTools" runat="server">
        <div class="fixed-action-btns hidden-print">
            <div class="btn-group quote-popover">
                <table style="width: 100%">
                    <tr>
                        <td colspan="2" style="text-align: center">Sign on your mobile device
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center">
                            <telerik:RadBarcode runat="server" ID="RadBarcode1" Type="QRCode" Text="" Height="140px" Width="140px" OutputType="EmbeddedPNG" ToolTip="Sign on your mobile device">
                                <QRCodeSettings Version="5" DotSize="3" Mode="Byte" />
                            </telerik:RadBarcode>
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <button type="button" title="Accept proposal" id="btn-accept" class="btn btn-success mb-xs" data-toggle="modal" data-target="#modal-accept">
                                Accept&nbsp;
                                <span class="circle bg-white"><i class="fas fa-check"></i></span>
                            </button>
                        </td>
                        <td>
                            <button type="button" title="Deny proposal" id="btn-deny" class="btn btn-inverse mb-xs" data-toggle="modal" data-target="#modal-deny">
                                Deny&nbsp;
                                <span class="circle bg-white"><i class="glyphicon glyphicon-remove"></i></span>
                            </button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </asp:Panel>
    <%-- End of Fixed Btns --%>
    <%-- Main Content --%>
    <asp:FormView ID="mainProposalFormView" runat="server" RenderOuterTable="false" DataSourceID="SqlDataSourceProp1" DefaultMode="ReadOnly" DataKeyNames="Id">
        <ItemTemplate>
            <%-- Hidden Fields --%>
            <input type="hidden" id="hdn-clientname" value='<%# Eval("ClientName") %>' />
            <%-- First Page --%>
            <div class="row page">
                <div class="col-lg-12">
                    <section class="widget widget-invoice">
                        <header>
                            <div class="row">
                                <div class="col-sm-6 col-print-6">
                                    <img src="data:image/png;base64,<%: Base64StringCompanyLogo %>" alt="Company Logo" class="invoice-logo img-fluid" />
                                </div>
                                <div class="col-sm-6 col-print-6 text-sm-right text-xs-left">
                                    <h4><span class="fw-semi-bold"><%: CompanyName %></span>
                                    </h4>
                                    <address>
                                        <i class="fa fa-map-marker" aria-hidden="true"></i>
                                        <%: CompanyAddress %> <%: CompanyCity %>, <%: CompanyState %> <%: CompanyZipCode %><br>
                                        <i class="fa fa-envelope" aria-hidden="true"></i>
                                        <a href='mailto:<%: CompanyEmail %>'><%: CompanyEmail %></a><br>
                                        <i class="fa fa-phone" aria-hidden="true"></i>
                                        <a href="tel:<%: CompanyPhone %>" class="phone">
                                            <%: CompanyPhone %>
                                        </a>
                                        <br>
                                        <i class="fa fa-globe" aria-hidden="true"></i>
                                        <a href="<%: CompanyWebLink %>" target="_blank">
                                            <%: CompanyWebLink %>
                                        </a>
                                        <br>
                                    </address>
                                </div>
                            </div>
                        </header>
                        <div class="widget-body">
                            <div class="row mb-lg">
                                <section class="col-md-12 col-print-12">
                                    <h5 class="company-name m-t-1">Dear&nbsp;<%# Eval("ClientName")%>,</h5>
                                    <%# Eval("TextBegin")%>
                                </section>
                            </div>
                            <div class="row mb-lg">
                                <section class="col-sm-6 col-print-6">
                                    <div class="text-muted">
                                        <span class="fw-semi-bold">Client: </span><%# Eval("ClientName") %>
                                    </div>
                                    <div class="text-muted">
                                        <%# Eval("ClientCompany") %>
                                    </div>
                                    <address>
                                        <i class="fa fa-map-marker" aria-hidden="true"></i>
                                        <%# Eval("ClientFullAddress") %><br>
                                        <i class="fa fa-phone" aria-hidden="true"></i>
                                        <a href="tel:<%# Eval("Phone") %>" class="phone">
                                            <%# Eval("Phone") %><br>
                                        </a>
                                    </address>
                                </section>
                                <section class="col-sm-6 col-print-6 text-sm-right text-xs-left">
                                    <div class="text-muted">
                                        <span class="fw-semi-bold">Project: </span><%# Eval("ProjectName") %>
                                    </div>
                                    <address runat="server" visible='<%# Not String.IsNullOrEmpty(Eval("ProjectLocation")) %>' style="margin-bottom: 0;">
                                        <i class="fa fa-map-marker" aria-hidden="true"></i>
                                        <%# Eval("ProjectLocation") %>
                                    </address>
                                    <asp:Panel ID="pnlArea" runat="server" CssClass="text-muted" Visible='<%# Not String.IsNullOrEmpty(Eval("ProjectArea")) %>'>
                                        Area: <span><%# Eval("ProjectArea") %></span>
                                    </asp:Panel>
                                    <div class="text-muted">
                                        Emitted Date: <span><%# Eval("Date", "{0:d}") %></span>
                                    </div>
                                    <div class="text-muted">
                                        Proposal # <span><%# Eval("ProposalNumber") %></span>
                                    </div>
                                    <div class="text-muted">
                                        Proposal by: <span><%# Eval("Proposalby") %></span>
                                    </div>
                                </section>
                            </div>
                            <div class="row mb-lg">
                                <section class="col-md-12 col-print-12">
                                    <h3 class="company-name m-t-1">Service Fee(s)</h3>
                                    <telerik:RadGrid ID="RadGridTask" runat="server" DataSourceID="SqlDataSourcePropDetails" ShowFooter="true" Width="100%" 
                                        RenderMode="Lightweight" Skin="" GridLines="None" CssClass="table-responsive">
                                        <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSourcePropDetails" CssClass="table">
                                            <FooterStyle BorderStyle="None" />

                                            <Columns>
                                                <telerik:GridBoundColumn DataField="PhaseCode" HeaderText="" UniqueName="Phase"
                                                    HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                </telerik:GridBoundColumn>
                                                <%--                                <telerik:GridBoundColumn DataField="taskcode" HeaderText="" UniqueName="taskcode"
                                    HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                </telerik:GridBoundColumn>--%>
                                                <telerik:GridBoundColumn DataField="Description" HeaderText="DESCRIPTION" UniqueName="Description"
                                                    HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="GridColumn">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn DataField="Amount" HeaderText="QUANTITY" UniqueName="Amount"
                                                    HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" FooterStyle-CssClass="hidden-sm-down" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden-sm-down" ItemStyle-CssClass="hidden-sm-down">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAmount" runat="server" Text='<%# IIf(Eval("Amount") = 0, "N/A", Eval("Amount"))%>' />
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="Hours" HeaderText="HOURS" UniqueName="Hours"
                                                    HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" FooterStyle-CssClass="hidden-sm-down" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden-sm-down" ItemStyle-CssClass="hidden-sm-down">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblHours" runat="server" Text='<%# IIf(Eval("Hours") = 0, "N/A", Eval("Hours"))%>' />
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn DataField="Rates" DataType="System.Double" FooterStyle-CssClass="hidden-sm-down" HeaderText="RATES" UniqueName="Rates"
                                                    HeaderStyle-Width="110px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" Aggregate="None" DataFormatString="{0:C}"
                                                    ItemStyle-CssClass="GridColumn hidden-sm-down" HeaderStyle-CssClass="hidden-sm-down">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn DataField="TotalRow" HeaderText="TOTAL" UniqueName="TotalRow"
                                                    HeaderStyle-Width="200px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" Aggregate="Sum"
                                                    FooterAggregateFormatString="{0:C}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true" ItemStyle-CssClass="GridColumn">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTotal2" runat="server" ForeColor='<%# IIf(Eval("TotalRow") = 0,System.Drawing.Color.White,System.Drawing.Color.Black )%>' Text='<%# Eval("TotalRow","{0:C2}")%>' />
                                                    </ItemTemplate>

                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </section>
                            </div>
                             <%--Payments Schedule                                                           --%>
                            <div class="row mb-lg">
                                <section class="col-md-12 col-print-12">
                                    <asp:Panel ID="Panel1" runat="server" Visible='<%# Eval("IsPaymentSchedule") %>' width="100%">
                                        <h3 class="company-name m-t-1">Payments Schedule</h3>
                                        <telerik:RadGrid ID="RadGridPS" runat="server" 
                                            AutoGenerateColumns="False" DataSourceID="SqlDataSourcePS" HeaderStyle-HorizontalAlign="Center" Width="100%"
                                            RenderMode="Lightweight" Skin="" GridLines="None" CssClass="table-responsive">
                                            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourcePS" ShowFooter="true" CssClass="table">
                                                <FooterStyle BorderStyle="None" />
                                                <Columns>
                                                    <telerik:GridBoundColumn DataField="Id" HeaderText="ID" SortExpression="Id" UniqueName="Id" Display="False">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="Percentage" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center"
                                                        HeaderText="SCHEDULE" SortExpression="Percentage" UniqueName="Percentage" 
                                                        ItemStyle-CssClass="GridColumn">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Description"
                                                        HeaderText="DESCRIPTION" SortExpression="Description" UniqueName="Description"
                                                        ItemStyle-CssClass="GridColumn">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridTemplateColumn DataField="InvoiceNumberEmitted" HeaderStyle-Width="180px" ItemStyle-HorizontalAlign="Center"
                                                        HeaderText="" SortExpression="InvoiceNumberEmitted" UniqueName="InvoiceNumberEmitted"
                                                        ItemStyle-CssClass="GridColumn">
                                                        <ItemTemplate>
                                                            <a title="View Invoice Page" href='<%# Eval("invoiceId", "../adm/sharelink.aspx?ObjType=44&ObjId={0}")%>' target="_blank" aria-hidden="true">
                                                                <%# Eval("InvoiceNumberEmitted") %>
                                                            </a>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn DataField="Amount" HeaderText="TOTAL" 
                                                        SortExpression="Amount" DataFormatString="{0:N2}" UniqueName="Amount" Aggregate="Sum" HeaderStyle-HorizontalAlign="Right"
                                                        FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Right"
                                                        FooterStyle-HorizontalAlign="Right"
                                                        ItemStyle-CssClass="GridColumn">
                                                    </telerik:GridBoundColumn>
                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </asp:Panel>

                                </section>
                            </div>
                            <div class="row">
                                <div class="col-md-12 col-print-12">
                                    <small>
                                        <%# Eval("TextEnd") %>
                                    </small>
                                </div>
                            </div>
                            <div class="btn-toolbar mt-lg hidden-print print-buttons">
                                <button class="btn btn-inverse print">
                                    <i class="fa fa-print"></i>
                                    &nbsp;&nbsp;
                                Print
                                </button>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
            <%-- End of First Page --%>
            <%-- Second Page --%>
            <div class="row page">
                <div class="col-lg-12">
                    <section class="widget widget-invoice">
                        <header>
                            <div class="row">
                                <div class="col-sm-6 col-print-6">
                                    <img src="data:image/png;base64,<%: Base64StringCompanyLogo %>" alt="Company Logo" class="invoice-logo img-fluid" />
                                </div>
                                <div class="col-sm-6 col-print-6 text-sm-right text-xs-left">
                                    <h4><span class="fw-semi-bold"><%: CompanyName %></span>
                                    </h4>
                                    <address>
                                        <i class="fa fa-map-marker" aria-hidden="true"></i>
                                        <%: CompanyAddress %> <%: CompanyCity %>, <%: CompanyState %> <%: CompanyZipCode %><br>
                                        <i class="fa fa-envelope" aria-hidden="true"></i>
                                        <a href='mailto:<%: CompanyEmail %>'><%: CompanyEmail %></a><br>
                                        <i class="fa fa-phone" aria-hidden="true"></i>
                                        <a href="tel:<%: CompanyPhone %>" class="phone">
                                            <%: CompanyPhone %>
                                        </a>
                                        <br>
                                        <i class="fa fa-globe" aria-hidden="true"></i>
                                        <a href="<%: CompanyWebLink %>" target="_blank">
                                            <%: CompanyWebLink %>
                                        </a>
                                        <br>
                                    </address>
                                </div>
                            </div>
                        </header>
                        <div class="widget-body">
                            <asp:Panel ID="PanelPhase" runat="server" Visible='<%# Eval("IsPhases") = 1%>' CssClass="row mb-lg">
                                <section class="col-md-12 col-print-12">
                                    <h3 class="company-name m-t-1">Project Phases</h3>
                                    <asp:Repeater ID="rptrPhases" runat="server" DataSourceID="SqlDataSourcePHASES">
                                        <ItemTemplate>
                                            <h4 class="company-name m-t-1"><%# Eval("Code")%>&nbsp;&nbsp;<%# Eval("Name")%></h4>
                                            <span class="fw-semi-bold">
                                                <%# Eval("Period")%>
                                            </span>
                                            <%# Eval("Description")%>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </section>
                            </asp:Panel>
                            <div class="row mb-lg">
                                <section class="col-md-12 col-print-12">
                                    <h3 class="company-name m-t-1">Scope of Work</h3>
                                    <asp:Repeater ID="rptrScopeOfWork" runat="server" DataSourceID="SqlDataSourceSCOPEOFWORK">
                                        <ItemTemplate>
                                            <h4 class="company-name m-t-1"><%# Eval("PhaseCode")%>&nbsp;&nbsp;<%# Eval("Description")%></h4>
                                            <%# Eval("DescriptionPlus")%>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </section>
                            </div>
                            <div class="btn-toolbar mt-lg hidden-print print-buttons">
                                <button class="btn btn-inverse print">
                                    <i class="fa fa-print"></i>
                                    &nbsp;&nbsp;
                                Print
                                </button>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
            <%-- End of Second Page --%>
            <%-- Final Page --%>
            <div class="row page">
                <div class="col-lg-12">
                    <section class="widget widget-invoice">
                        <header>
                            <div class="row">
                                <div class="col-sm-6 col-print-6">
                                    <img src="data:image/png;base64,<%: Base64StringCompanyLogo %>" alt="Company Logo" class="invoice-logo img-fluid" />
                                </div>
                                <div class="col-sm-6 col-print-6 text-sm-right text-xs-left">
                                    <h4><span class="fw-semi-bold"><%: CompanyName %></span>
                                    </h4>
                                    <address>
                                        <i class="fa fa-map-marker" aria-hidden="true"></i>
                                        <%: CompanyAddress %> <%: CompanyCity %>, <%: CompanyState %> <%: CompanyZipCode %><br>
                                        <i class="fa fa-envelope" aria-hidden="true"></i>
                                        <a href='mailto:<%: CompanyEmail %>'><%: CompanyEmail %></a><br>
                                        <i class="fa fa-phone" aria-hidden="true"></i>
                                        <a href="tel:<%: CompanyPhone %>" class="phone">
                                            <%: CompanyPhone %>
                                        </a>
                                        <br>
                                        <i class="fa fa-globe" aria-hidden="true"></i>
                                        <a href="<%: CompanyWebLink %>" target="_blank">
                                            <%: CompanyWebLink %>
                                        </a>
                                        <br>
                                    </address>
                                </div>
                            </div>
                        </header>
                        <div class="widget-body">
                            <div class="row mb-lg">
                                <section class="col-md-12 col-print-12">
                                    <h3 class="company-name m-t-1">Professional Services Agreement</h3>
                                    <%# Eval("Agreements") %>
                                </section>
                            </div>
                            <asp:Panel ID="pnlSharedPublicLinks" runat="server" Visible='<%# ShareDocumentsPanelVisible(Eval("IsSharePublicLinks")) %>' CssClass="row mb-lg">
                                <section class="col-md-12 col-print-12">
                                    <h3 class="company-name m-t-1">Shared Documents</h3>
                                    <div class="table-responsive">
                                        <table class="table">
                                            <asp:Repeater ID="rptrSharedPublicLinks" runat="server" DataSourceID="SqlDataSourceAzureuploads">
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>
                                                            <a href='<%# Eval("url")%>' target="_blank" download='<%# Eval("Name") %>'><%# String.Concat(Eval("Name"), " -- (", Eval("Type"), ")")%></a>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </table>
                                    </div>
                                </section>
                            </asp:Panel>
                            <div class="row-mb-lg">
                                <section class="col-md-12 col-print-12">
                                    <div class="row">
                                        <div class="col-md-12 col-print-12">
                                            <h3 class="text-muted no-margin"></h3>
                                        </div>
                                    </div>
                                    <div class="row text-xs-center">
                                        <div class="col-md-6 col-print-6 text-xs-center">
                                            <h4></h4>
                                            <telerik:RadBinaryImage CssClass="img-signature" ID="imgEmpSignature" runat="server" AlternateText="Company Signature" DataValue='<%# IIf(Eval("CompanySing") Is DBNull.Value, Nothing, Eval("CompanySing"))%>' />
                                            <p><strong><%# Eval("CompanyContact") %></strong></p>
                                            <p><%# Eval("EmailDate", "{0:MMMM d, yyyy}")%></p>
                                        </div>
                                        <div class="col-md-6 col-print-6 text-xs-center">
                                            <asp:Panel ID="PanelSignature" runat="server" Visible='<%# Not Eval("AceptanceSignature") Is DBNull.Value %>'>
                                                <h4></h4>
                                                <telerik:RadBinaryImage CssClass="img-signature" ID="imgClientSignature" runat="server" AlternateText="Client Signature" DataValue='<%# IIf(Eval("AceptanceSignature") Is DBNull.Value, Nothing, Eval("AceptanceSignature"))%>' />
                                                <p><strong><%# Eval("AceptanceName") %></strong></p>
                                                <p><%# Eval("AceptedDate", "{0:MMMM d, yyyy}") %></p>
                                            </asp:Panel>
                                        </div>
                                    </div>
                                </section>
                            </div>
                            <div class="btn-toolbar mt-lg hidden-print print-buttons">
                                <button class="btn btn-inverse print">
                                    <i class="fa fa-print"></i>
                                    &nbsp;&nbsp;
                                Print
                                </button>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
            <%-- End of Final Page --%>
        </ItemTemplate>
    </asp:FormView>
    <%-- End of Main Content --%>

    <%-- SqlDataSources --%>
    <asp:SqlDataSource ID="SqlDataSourceProp1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="PROPOSAL_Page_v20_Select" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblProposalId" Name="ProposalId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSCOPEOFWORK" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="PROPOSAL_SCOPEOFWORK2_Select" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblProposalId" Name="ProposalId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePHASES" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="PROPOSAL_phases_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblProposalId" Name="ProposalId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePropDetails" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="PROPOSAL_Details_Page_Select" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblProposalId" Name="ProposalId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceAzureuploads" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Proposal_azureuploads_v20_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="ProposalId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourcePS" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Proposal_PaymentSchedule_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="ProposalId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


    <%-- End of SqlDataSources --%>
    <%-- Hidden Labels --%>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblGuiId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblProposalId" runat="server" Visible="False"></asp:Label>
    <%-- End of Hidden Labels --%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Scripts" runat="Server">
    <script src='<%= ResolveUrl("~/Scripts/sing-theme/js/dist/popover.js") %>'></script>
    <script src='<%= ResolveUrl("~/Scripts/sing-theme/js/dist/modal.js") %>'></script>
    <script src='<%= ResolveUrl("~/Scripts/sing-theme/js/ui-components.js") %>'></script>
    <script src='<%= ResolveUrl("~/Scripts/signature-pad/signature_pad.js") %>'></script>
    <script src='<%= ResolveUrl("~/Scripts/signature-pad/app.js") %>'></script>
    <script>
        var wrapper = document.getElementById("signature-pad"),
            $clearButton = $("[data-action=clear]"),
            $saveButton = $("[data-action=save]"),
            canvas = wrapper.querySelector("canvas"),
            signaturePad;

        // Adjust canvas coordinate space taking into account pixel ratio,
        // to make it look crisp on mobile devices.
        // This also causes canvas to be cleared.
        function resizeCanvas() {
            // When zoomed out to less than 100%, for some very strange reason,
            // some browsers report devicePixelRatio as less than 1
            // and only part of the canvas is cleared then.
            var ratio = Math.max(window.devicePixelRatio || 1, 1);
            canvas.width = canvas.offsetWidth * ratio;
            canvas.height = canvas.offsetHeight * ratio;
            canvas.getContext("2d").scale(ratio, ratio);
        }

        window.onresize = resizeCanvas;

        signaturePad = new SignaturePad(canvas);

        $clearButton.click(function (e) {
            signaturePad.clear();
        });

        $saveButton.click(function (e) {
            if (signaturePad.isEmpty()) {
                alert("Please provide signature first.");
            } else {
                $('#modal-accept').modal('hide'); // Force the modal to hide
                __doPostBack("btnSign", signaturePad.toDataURL()); // Finally do the AJAX sign action
            }
        });
        var clientName = $("#hdn-clientname").val();
        $('.sign-name').attr('value', clientName);
        $('#modal-accept').on('shown.bs.modal', function () {
            resizeCanvas();
        });
    </script>
</asp:Content>

