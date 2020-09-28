<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/e2103445_8a47_49ff_808e_6008c0fe13a1/singclientportal.master" CodeBehind="singproposalsign.aspx.vb" Inherits="pasconcept20.singproposalsign" Async="true" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/e2103445_8a47_49ff_808e_6008c0fe13a1/SingClientPortal.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <link rel="stylesheet" href='<%= ResolveUrl("~/Content/sing-theme/quote-fullview.css?v=1") %>' />
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

        @media print {
            .pagebreak {
                page-break-before: always;
            }
            /* page-break-after works, as well */
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <%-- Modals and the like --%>
    <asp:Panel ID="pnlModals" runat="server">
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
    </asp:Panel>


    <asp:Panel ID="pnlPrint" runat="server" CssClass="hidden-print noprint">
        <div class="fixed-action-btn-print hidden-print  .d-sm-none .d-md-block hidden-lg-down">
            <div class="btn-toolbar mt-lg hidden-print print-buttons">
                <button class="btn btn-inverse print" style="display: block;">
                    <i class="fa fa-print"></i>
                    &nbsp;&nbsp;Print
                </button>
                <div class="d-none d-xl-block col-xl-2 bd-toc" style="margin-top: 5px;">
                    <ul class="section-nav list-unstyled" style="font-size: 1rem; width: 150px;">
                        <li><a href="#" class="hidden-print">Top</a></li>
                        <li><a href="#ScopeofWork" class="hidden-print">Scope of Work</a></li>
                        <li><a href="#ServiceFee" class="hidden-print">Service Fee(s)</a></li>
                        <li><a href="#PaymentsSchedule" class="hidden-print">Payments Schedule</a></li>
                        <li><a href="#TermsConditions" class="hidden-print">Terms and Conditions</a></li>
                        <li><a href="#Signature" class="hidden-print">Signature</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </asp:Panel>
    <%-- Fixed print Btn --%>
    <%-- End of Fixed print Btn --%>
    <%-- Fixed Action Btns --%>
    <asp:Panel ID="pnlSideTools" runat="server" CssClass="noprint">
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
                                <i class="fas fa-check-circle"></i>
                            </button>
                        </td>
                        <td>
                            <button type="button" title="Deny proposal" id="btn-deny" class="btn btn-dark mb-xs" data-toggle="modal" data-target="#modal-deny">
                                Deny&nbsp;
                                <i class="far fa-times-circle"></i>
                            </button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </asp:Panel>
    <%-- End of Fixed Action Btns --%>
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

                            <div class="row mb-lg" style="text-align: center">
                                <section class="col-md-12 col-print-12">
                                    <h4><span class="fw-semi-bold">Professional Services Agreement</span>
                                </section>
                            </div>

                            <%--Client / Project--%>
                            <div class="row mb-lg">
                                <section class="col-sm-6 col-print-6">
                                    <div>
                                        <h4><span class="fw-semi-bold"><%# Eval("ClientName") %></span></h4>
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
                                    <div>
                                        <h4><span class="fw-semi-bold"><%# Eval("ProjectName") %></span></h4>
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

                            <%--Dear Client Text Begin--%>
                            <div class="row mb-lg">
                                <section class="col-md-12 col-print-12">
                                    Dear&nbsp;<%# Eval("ClientName")%>,<br />
                                    <%# Eval("TextBegin")%>
                                </section>
                            </div>

                            <%--Project Phases Hide?--%>
                            <div id="ScopeofWork">
                                <asp:Panel ID="PanelPhase" runat="server" Visible='<%# Eval("IsPhases") = 1%>' CssClass="row mb-lg">
                                    <div class="row mb-lg">
                                        <section class="col-md-12 col-print-12">
                                            <section class="col-md-12 col-print-12">
                                                <h4><span class="fw-semi-bold">Scope of Work</h4>
                                                <asp:Repeater ID="rptrPhases" runat="server" DataSourceID="SqlDataSourcePHASES" OnItemDataBound="rptrPhases_ItemDataBound">
                                                    <ItemTemplate>
                                                        <h4 class="company-name m-t-1"><%# Eval("Name")%>&nbsp;&nbsp;(<%# Eval("Code")%>)</h4>
                                                        <span class="fw-semi-bold">
                                                            <%# Eval("Period")%>
                                                        </span>
                                                        <br />
                                                        <%# Eval("Description")%>
                                                        <div style="padding-left:25px">
                                                            <asp:Repeater ID="rptrScopeOfWorkByPhase" runat="server" DataSourceID="SqlDataSourceScopeOfWorkByPhase">
                                                                <ItemTemplate>
                                                                    <h5 class="company-name m-t-1"><%# Eval("Description") %></h5>
                                                                    <%# Eval("DescriptionPlus")%>
                                                                    <hr />
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                        <asp:SqlDataSource ID="SqlDataSourceScopeOfWorkByPhase" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
                                                            SelectCommand="Proposal_ScopeOfWorkByPhase_Select" SelectCommandType="StoredProcedure">
                                                            <SelectParameters>
                                                                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                                                                <asp:ControlParameter ControlID="lblProposalId" Name="ProposalId" PropertyName="Text" Type="Int32" />
                                                                <asp:Parameter Name="PhaseId" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>


                                                    </ItemTemplate>
                                                </asp:Repeater>

                                            </section>

                                        </section>
                                    </div>
                                </asp:Panel>

                                <%--Scope of Work No Phases Hide?--%>
                                <asp:Panel ID="Panel2" runat="server" Visible='<%# Eval("IsPhases") = 0%>' CssClass="row mb-lg">
                                    <div class="row mb-lg">
                                        <section class="col-md-12 col-print-12">
                                            <h4><span class="fw-semi-bold">Scope of Work</h4>
                                            <asp:Repeater ID="rptrScopeOfWork" runat="server" DataSourceID="SqlDataSourceSCOPEOFWORK">
                                                <ItemTemplate>
                                                    <h5 class="company-name m-t-1"><%# IIf(Len(Eval("PhaseCode")) > 0, String.Concat(Eval("PhaseCode"), "  ", Eval("Description")), Eval("Description"))  %></h5>
                                                    <%# Eval("DescriptionPlus")%>
                                                </ItemTemplate>
                                            </asp:Repeater>

                                        </section>
                                    </div>
                                </asp:Panel>

                            </div>
                            <%--Service Fee(s)--%>
                            <div class="row mb-lg pagebreak">
                                <section class="col-md-12 col-print-12">
                                    <h4 class="fw-semi-bold" id="ServiceFee">Service Fee(s)</h4>
                                    <telerik:RadGrid ID="RadGridTask" runat="server" DataSourceID="SqlDataSourcePropDetails" OnPreRender="RadGridFees_PreRender"
                                        HeaderStyle-HorizontalAlign="Center" ShowFooter="true" Width="100%"
                                        RenderMode="Lightweight" Skin="" GridLines="None" CssClass="table-responsive">
                                        <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSourcePropDetails" CssClass="table">
                                            <FooterStyle BorderStyle="None" />
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="PhaseCode" HeaderText="Phase" UniqueName="Phase" 
                                                    HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="taskcode" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center"
                                                    HeaderText="ID" SortExpression="taskcode" UniqueName="taskcode">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="Description" HeaderText="TASK NAME" UniqueName="Description"
                                                    HeaderStyle-HorizontalAlign="Left" ItemStyle-CssClass="GridColumn">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn DataField="Amount" HeaderText="QTY" UniqueName="Amount" HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center"
                                                    ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="GridColumn">
                                                    <ItemTemplate>
                                                        <%# Eval("Amount")%>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="Hours" HeaderText="HOURS" UniqueName="Hours"
                                                    HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="GridColumn">
                                                    <ItemTemplate>
                                                        <%# Eval("Hours")%>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="Rates" HeaderText="RATE" UniqueName="Rates" ItemStyle-CssClass="GridColumn"
                                                    HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" Aggregate="None">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTotal2" runat="server" Visible='<%# IIf(Eval("Amount") Is DBNull.Value And Eval("Hours") Is DBNull.Value, False, True)%>' Text='<%# Eval("Rates", "{0:C2}")%>' />
                                                    </ItemTemplate>

                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="TotalRow" HeaderText="TOTAL" UniqueName="TotalRow"
                                                    HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" Aggregate="Sum"
                                                    FooterAggregateFormatString="{0:C}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true" ItemStyle-CssClass="GridColumn">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTotal2" runat="server" Visible='<%# IIf(Eval("TotalRow") = 0 Or Eval("LumpSum") = 1, False, True)%>' Text='<%# Eval("TotalRow", "{0:C2}")%>' />
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
                                    <asp:Panel ID="Panel1" runat="server" Visible='<%# Eval("IsPaymentSchedule") %>' Width="100%">
                                        <h4 class="fw-semi-bold" id="PaymentsSchedule">Payments Schedule</h4>
                                        <telerik:RadGrid ID="RadGridPS" runat="server"
                                            AutoGenerateColumns="False" DataSourceID="SqlDataSourcePS" HeaderStyle-HorizontalAlign="Center" Width="100%"
                                            RenderMode="Lightweight" Skin="" GridLines="None" CssClass="table-responsive">

                                            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourcePS" ShowFooter="true" CssClass="table">
                                                <FooterStyle BorderStyle="None" />
                                                <Columns>
                                                    <telerik:GridBoundColumn DataField="Id" HeaderText="ID" SortExpression="Id" UniqueName="Id" Display="False">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="taskcode" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center"
                                                        HeaderText="Task" SortExpression="taskcode" UniqueName="taskcode">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Description" HeaderStyle-HorizontalAlign="Left"
                                                        HeaderText="DESCRIPTION" SortExpression="Description" UniqueName="Description"
                                                        ItemStyle-CssClass="GridColumn">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="Percentage" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center"
                                                        HeaderText="%" SortExpression="Percentage" UniqueName="Percentage"
                                                        ItemStyle-CssClass="GridColumn">
                                                    </telerik:GridBoundColumn>

                                                    <%--  <telerik:GridTemplateColumn DataField="InvoiceNumberEmitted" HeaderStyle-Width="180px" ItemStyle-HorizontalAlign="Center"
                                                        HeaderText="" SortExpression="InvoiceNumberEmitted" UniqueName="InvoiceNumberEmitted"
                                                        ItemStyle-CssClass="GridColumn">
                                                        <ItemTemplate>
                                                            <a title="View Invoice Page" href='<%# Eval("invoiceId", "../adm/sharelink.aspx?ObjType=44&ObjId={0}")%>' target="_blank" aria-hidden="true">
                                                                <%# Eval("InvoiceNumberEmitted") %>
                                                            </a>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>--%>
                                                    <telerik:GridBoundColumn DataField="Amount" HeaderText="TOTAL"
                                                        SortExpression="Amount" DataFormatString="{0:C2}" UniqueName="Amount" Aggregate="Sum" HeaderStyle-HorizontalAlign="Center" FooterStyle-Font-Bold="true"
                                                        FooterAggregateFormatString="{0:C2}" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right"
                                                        FooterStyle-HorizontalAlign="Right"
                                                        ItemStyle-CssClass="GridColumn">
                                                    </telerik:GridBoundColumn>
                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </asp:Panel>

                                </section>
                            </div>

                            <%--Text End--%>
                            <div class="row">
                                <div class="col-md-12 col-print-12">
                                    <%# Eval("TextEnd") %>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
            <%-- End of First Page --%>

            <%-- Final Page --%>
            <div class="row page">
                <div class="col-lg-12">
                    <section class="widget widget-invoice">
                        <div class="widget-body">
                            <div class="row mb-lg">
                                <section class="col-md-12 col-print-12">
                                    <h4 class="fw-semi-bold" id="TermsConditions">Terms and Conditions</h4>
                                    <%# Eval("Agreements") %>
                                </section>
                            </div>
                            <asp:Panel ID="pnlSharedPublicLinks" runat="server" Visible='<%# ShareDocumentsPanelVisible(Eval("IsSharePublicLinks")) %>' CssClass="row mb-lg">
                                <section class="col-md-12 col-print-12">
                                    <h4 class="fw-semi-bold" id="Documents">Documents</h3>
                                    <div class="table-responsive">
                                        <table class="table">
                                            <asp:Repeater ID="rptrSharedPublicLinks" runat="server" DataSourceID="SqlDataSourceAzureuploads">
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>
                                                            <%# LocalAPI.CreateIcon(Eval("ContentType"), Eval("url"), Eval("Name"), 16)%>
                                                            &nbsp;&nbsp;
                                                            <%# String.Concat(Eval("Name"), " -- (", Eval("nType"), ")")%>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </table>
                                    </div>
                                </section>
                            </asp:Panel>

                            <div class="row mb-lg">

                                <section class="col-md-12 col-print-12">
                                    <div class="row text-xs-center" id="Signature">
                                        <div>
                                            <telerik:RadBinaryImage CssClass="img-signature" ID="imgEmpSignature" runat="server" AlternateText="Company Signature" DataValue='<%# IIf(Eval("CompanySing") Is DBNull.Value, Nothing, Eval("CompanySing"))%>' />
                                            <br />
                                            ____________________________________________
                                            <br />
                                            <strong><%# Eval("CompanyContact") %></strong>
                                            &nbsp;&nbsp;<%# Eval("EmailDate", "{0:MMMM d, yyyy}")%>
                                            <br />
                                            <br />
                                        </div>

                                        <div>
                                            <asp:Panel ID="PanelSignature" runat="server" Visible='<%# Not Eval("AceptanceSignature") Is DBNull.Value %>'>
                                                <telerik:RadBinaryImage CssClass="img-signature" ID="imgClientSignature" runat="server" AlternateText="Client Signature" DataValue='<%# IIf(Eval("AceptanceSignature") Is DBNull.Value, Nothing, Eval("AceptanceSignature"))%>' />
                                                <br />
                                                ____________________________________________
                                                <br />
                                                <strong><%# Eval("AceptanceName") %></strong>
                                                &nbsp;&nbsp;<%# Eval("AceptedDate", "{0:MMMM d, yyyy}") %>
                                            </asp:Panel>
                                        </div>
                                    </div>
                                </section>
                            </div>


                        </div>
                </div>
                </section>
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
        SelectCommand="PROPOSAL_SCOPEOFWORK_v20_Select" SelectCommandType="StoredProcedure">
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
        SelectCommand="PROPOSAL_Details_ClientPage_Select" SelectCommandType="StoredProcedure">
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
        (function () {
            var wrapper = document.getElementById("signature-pad");
            if (!wrapper) {
                // Safety check
                return;
            }
            var $clearButton = $("[data-action=clear]");
            var $saveButton = $("[data-action=save]");
            var canvas = wrapper.querySelector("canvas");
            var signaturePad;

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

            signaturePad = new SignaturePad(canvas, {
                minWidth: 4,
                maxWidth: 8,
                penColor: "rgb(0, 0, 0)"
            });

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
        })();
    </script>
</asp:Content>

