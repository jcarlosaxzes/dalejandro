<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SingProposalSignPrint.aspx.vb" Inherits="pasconcept20.SingProposalSignPrint" %>

<%@ Import Namespace="pasconcept20" %>
<!DOCTYPE html>

<html lang="en">
<head runat="server">
    <title>PASconcept -- Client Portal</title>
    

    <%-- Favicons and the like --%>
    <link rel="apple-touch-icon" sizes="180x180" href="<%@ LocalAPI.GetHostAppSite()%>/Content/favicons/apple-touch-icon.png" />
    <link rel="icon" type="image/png" sizes="32x32" href="<%# LocalAPI.GetHostAppSite()%>/Content/favicons/favicon-32x32.png" />
    <link rel="icon" type="image/png" sizes="16x16" href="<%# LocalAPI.GetHostAppSite()%>/Content/favicons/favicon-16x16.png" />
    <link rel="manifest" href="<%# LocalAPI.GetHostAppSite()%>/Content/favicons/site.webmanifest" />

    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="DESCRIPTION" content="A web-based application conceived and designed to provide an all-inclusive management tool for architectural and engineering firms who wish to integrate the interaction." />
    <meta name="AUTHOR" content="AXZES, LLC" />
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">    
</head>
<body class="nav-collapsed">
    <form runat="server" class="main-form">
        <asp:ScriptManager runat="server">
        </asp:ScriptManager>

        <div class="content-wrap no-sidebar">
            <main id="content" class="content" role="main">

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
                                                <telerik:GridBoundColumn DataField="Description" HeaderText="DESCRIPTION" UniqueName="Description"
                                                    HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="GridColumn">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn DataField="Amount" HeaderText="QUANTITY" UniqueName="Amount"
                                                    HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" FooterStyle-CssClass="hidden-sm-down" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden-sm-down" ItemStyle-CssClass="hidden-sm-down">
                                                    <ItemTemplate>
                                                        <%# Eval("Amount")%>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="Hours" HeaderText="HOURS" UniqueName="Hours"
                                                    HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" FooterStyle-CssClass="hidden-sm-down" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden-sm-down" ItemStyle-CssClass="hidden-sm-down">
                                                    <ItemTemplate>
                                                        <%# Eval("Hours")%>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn DataField="Rates" FooterStyle-CssClass="hidden-sm-down" HeaderText="RATES" UniqueName="Rates"
                                                    HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" Aggregate="None" DataFormatString="{0:C}"
                                                    ItemStyle-CssClass="GridColumn hidden-sm-down" HeaderStyle-CssClass="hidden-sm-down">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn DataField="TotalRow" HeaderText="TOTAL" UniqueName="TotalRow"
                                                    HeaderStyle-Width="200px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" Aggregate="Sum"
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
                        </div>
                    </section>
                </div>
            </div>
            <p>
                <br></br>
                <br></br>
            </p>
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
                            
                        </div>
                    </section>
                </div>
            </div>            
            <p>
                <br></br>
                <br></br>
            </p>
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
                        </div>
                    </section>
                </div>
            </div>
            
            <p>
                <br></br>
                <br></br>
            </p>
            <%-- End of Final Page --%>
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
    

        </main>
        </div>
        </form>

  
  
</body>
</html>
