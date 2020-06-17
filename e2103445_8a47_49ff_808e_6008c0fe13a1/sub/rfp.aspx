<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="rfp.aspx.vb" MasterPageFile="~/e2103445_8a47_49ff_808e_6008c0fe13a1/sub/SubconsultantMasterPage.Master" Inherits="pasconcept20.rfp1" %>

<%@ MasterType VirtualPath="~/e2103445_8a47_49ff_808e_6008c0fe13a1/sub/SubconsultantMasterPage.Master" %>

<%@ Import Namespace="pasconcept20" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <link rel="stylesheet" href='<%= ResolveUrl("~/Content/sing-theme/quote-fullview.css") %>' />
    <link rel="stylesheet" href='<%= ResolveUrl("~/Content/sing-theme/signature-pad.css") %>' />
    <style>
        hr {
            margin-top: 2px !important;
            margin-bottom: 2px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function OnClientClose(sender, args) {
                var mFormView = $find("<%= mainProposalFormView.ClientID %>").get_masterTableView();
                masterTable.rebind();
            }

        </script>
    </telerik:RadCodeBlock>


    <%-- Main Content --%>
    <asp:FormView ID="mainProposalFormView" runat="server" RenderOuterTable="false" DataSourceID="SqlDataSourceRFP" DefaultMode="ReadOnly" DataKeyNames="Id">
        <ItemTemplate>
            <div class="row page" style="text-align: left">

                <table class="table-sm" style="width: 100%">
                    <tr>
                        <td></td>
                        <td style="width: 120px; text-align: right">
                            <asp:LinkButton ID="btnPAS" runat="server" CssClass="btn btn-primary btn-lg" UseSubmitBehavior="false" ToolTip="If you are PASconcept client, you can Respond using Proposal to clients"
                                Visible='<%# IsButtonFeesVisible(Eval("statusId")) %>' CommandName="ContinuePAS">
                                                    <i class="fas fa-sign-in-alt"></i>&nbsp;Continue with PASconcept
                            </asp:LinkButton>
                        </td>
                        <td style="width: 120px; text-align: right">
                            <asp:LinkButton ID="btnContinue" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false"
                                Visible='<%# IsButtonFeesVisible(Eval("statusId")) %>' CommandName="Continue">
                                                    Continue
                                                    <i class="fas fa-pen"></i>
                            </asp:LinkButton>
                            <td style="width: 120px; text-align: left">
                                <asp:LinkButton ID="btnReject" runat="server" CssClass="btn btn-danger  btn-lg" UseSubmitBehavior="false"
                                    Visible='<%# IsButtonFeesVisible(Eval("statusId")) %>' CommandName="Reject">
                                                    Reject
                                </asp:LinkButton>
                            </td>
                            <td></td>
                    </tr>
                </table>


                <div class="col-md-12">


                    <%--Page 1. Dear....--%>
                    <div class="row mb-lg">
                        <section class="col-md-12 col-print-12">
                            <h3 class="company-name m-t-1">Dear&nbsp;<%# Eval("SubconsultantName")%>,</h3>
                            <%# Eval("IntroductoryText")%>
                        </section>
                    </div>

                    <%--Page 1. Sunconsultan & Project brief--%>
                    <div class="row mb-lg">
                        <section class="col-md-6 col-print-6">
                            <h3 class="company-name m-t-1" style="margin: 0">Subconsultant</h3>
                            <div class="text-muted">
                                <h4 style="margin: 0"><%# Eval("SubconsultantName") %></h4>
                            </div>
                            <div class="text-muted">
                                <%# Eval("Organization") %>
                            </div>
                            <div class="text-muted">
                                <i class="fa fa-map-marker" aria-hidden="true"></i>
                                <%# Eval("FullAddress") %><br>
                            </div>
                            <div class="text-muted">
                                <i class="fa fa-phone" aria-hidden="true"></i>
                                <a href="tel:<%# Eval("Telephone") %>" class="phone">
                                    <%# Eval("Telephone") %>
                                </a>
                            </div>
                            <h3 class="company-name m-t-1" style="margin: 0">Sender</h3>
                            <div class="text-muted">
                                <%# Eval("Sender") %>
                            </div>
                            <div class="text-muted">
                                <i class="fa fa-email" aria-hidden="true"></i>
                                <%# Eval("SenderEmail") %>
                            </div>
                        </section>
                        <section class="col-md-6 col-print-6">
                            <h3 class="company-name m-t-1" style="margin: 0">Project</h3>
                            <div class="text-muted">
                                <h4 style="margin: 0"><%# Eval("ProjectName") %></h4>
                            </div>
                            <address runat="server" visible='<%# Not String.IsNullOrEmpty(Eval("ProjectLocation")) %>' style="margin-bottom: 0;">
                                <i class="fa fa-map-marker" aria-hidden="true"></i>
                                <%# Eval("ProjectLocation") %>
                            </address>
                            <div class="text-muted">
                                Created Date: <span><%# Eval("DateCreated", "{0:d}") %></span>
                            </div>
                            <div class="text-muted">
                                RFP #: <span><%# Eval("RFPNumber") %></span>
                            </div>
                            <div class="text-muted">
                                Proposal by: <span><%# Eval("Sender") %></span>
                            </div>
                            <div class="text-muted">
                                Status: <span class='<%# LocalAPI.GetRFPStatusLabelCSS(Eval("StateId")) %>'><%# Eval("Status") %></span>
                            </div>
                            <div class="text-muted">
                                Sent Date: <span><%# Eval("DateSended", "{0:d}") %></span>
                            </div>
                            <div class="text-muted">
                                Accepted Date: <span><%# Eval("AceptedDate", "{0:d}") %></span>
                            </div>
                        </section>
                    </div>

                    <%--Page 1. Project Description--%>
                    <div class="row mb-lg">
                        <section class="col-md-12 col-print-12">
                            <h3 class="company-name m-t-1">Project Description</h3>
                            <div style="text-align: left">
                                <%# Eval("ProjectDescription")%>
                            </div>

                        </section>
                    </div>

                    <%--Page 1. References--%>
                    <asp:Panel ID="pnlSharedPublicLinks" runat="server" CssClass="row mb-lg" Visible='<%# Eval("linkDocsCount") > 0 %>'>
                        <section class="col-md-12 col-print-12">
                            <h3 class="company-name m-t-1">References</h3>
                            <div class="table-responsive">
                                <table class="table">
                                    <asp:Repeater ID="rptrSharedPublicLinks" runat="server" DataSourceID="SqlDataSourceAzureuploads">
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <a href='<%# Eval("url")%>' target="_blank" download='<%# Eval("Name") %>'><%# Eval("Name")%></a>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </table>
                            </div>
                        </section>
                    </asp:Panel>

                    <%--Page 1. Payments Schedule--%>
                    <div class="row mb-lg">
                        <section class="col-md-12 col-print-12">
                            <h3 class="company-name m-t-1">Payments Schedule</h3>
                            <asp:Panel ID="PanelPS1" runat="server" Visible='<%# Eval("PaymentSchedule1") > 0%>' CssClass="table-responsive">
                                <table class="table no-margin-button">
                                    <thead>
                                        <tr>
                                            <th style="text-align: center; width: 100px"><b>SCHEDULE</b>
                                            </th>
                                            <th style="text-align: center"><b>DESCRIPTION</b>
                                            </th>
                                            <th style="text-align: center; width: 100px"><b>TOTAL</b>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td style="text-align: center; width: 100px">
                                                <asp:Label ID="TextBox8" runat="server" Text='<%# Eval("PaymentSchedule1") %>'>
                                                </asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="TextBox4" runat="server" Text='<%# Eval("PaymentText1") %>'>
                                                </asp:Label>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </asp:Panel>
                            <asp:Panel ID="PanelPS2" runat="server" Visible='<%# Eval("PaymentSchedule2") > 0%>' CssClass="table-responsive">
                                <table class="table no-margin-button">
                                    <tr>
                                        <td style="text-align: center; width: 100px">
                                            <asp:Label ID="RadTextBox2" runat="server" Text='<%# Eval("PaymentSchedule2") %>'>
                                            </asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="RadTextBox1" runat="server" Text='<%# Eval("PaymentText2")%>'>
                                            </asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <asp:Panel ID="PanelPS3" runat="server" Visible='<%# Eval("PaymentSchedule3") > 0%>' CssClass="table-responsive">
                                <table class="table no-margin-button">
                                    <tr>
                                        <td style="text-align: center; width: 100px">
                                            <asp:Label ID="RadTextBox3" runat="server" Text='<%# Eval("PaymentSchedule3") %>'>
                                            </asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="RadTextBox5" runat="server" Text='<%# Eval("PaymentText3")%>'>
                                            </asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <asp:Panel ID="PanelPS4" runat="server" Visible='<%# Eval("PaymentSchedule4") > 0%>' CssClass="table-responsive">
                                <table class="table no-margin-button">
                                    <tr>
                                        <td style="text-align: center; width: 100px">
                                            <asp:Label ID="RadTextBox4" runat="server" Text='<%# Eval("PaymentSchedule4") %>'>
                                            </asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="RadTextBox6" runat="server" Text='<%# Eval("PaymentText4")%>'>
                                            </asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <asp:Panel ID="PanelPS5" runat="server" Visible='<%# Eval("PaymentSchedule5") > 0%>' CssClass="table-responsive">
                                <table class="table no-margin-button">
                                    <tr>
                                        <td style="text-align: center; width: 100px">
                                            <asp:Label ID="RadTextBox7" runat="server" Text='<%# Eval("PaymentSchedule5")%>'>
                                            </asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="RadTextBox8" runat="server" Text='<%# Eval("PaymentText5")%>'>
                                            </asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <asp:Panel ID="PanelPS6" runat="server" Visible='<%# Eval("PaymentSchedule6") > 0%>' CssClass="table-responsive">
                                <table class="table no-margin-button">
                                    <tr>
                                        <td style="text-align: center; width: 100px">
                                            <asp:Label ID="RadTextBox9" runat="server" Text='<%# Eval("PaymentSchedule6") %>'>
                                            </asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="RadTextBox10" runat="server" Text='<%# Eval("PaymentText6")%>'>
                                            </asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <asp:Panel ID="PanelPS7" runat="server" Visible='<%# Eval("PaymentSchedule7") > 0%>' CssClass="table-responsive">
                                <table class="table no-margin-button">
                                    <tr>
                                        <td style="text-align: center; width: 100px">
                                            <asp:Label ID="RadTextBox11" runat="server" Text='<%# Eval("PaymentSchedule7") %>'>
                                            </asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="RadTextBox12" runat="server" Text='<%# Eval("PaymentText7")%>'>
                                            </asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <asp:Panel ID="PanelPS8" runat="server" Visible='<%# Eval("PaymentSchedule8") > 0%>' CssClass="table-responsive">
                                <table class="table no-margin-button">
                                    <tr>
                                        <td style="text-align: center; width: 100px">
                                            <asp:Label ID="RadTextBox13" runat="server" Text='<%# Eval("PaymentSchedule8") %>'>
                                            </asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="RadTextBox181" runat="server" Text='<%# Eval("PaymentText8")%>'>
                                            </asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <asp:Panel ID="PanelPS9" runat="server" Visible='<%# Eval("PaymentSchedule9") > 0%>' CssClass="table-responsive">
                                <table class="table no-margin-button">
                                    <tr>
                                        <td style="text-align: center; width: 100px">
                                            <asp:Label ID="RadTextBox15" runat="server" Text='<%# Eval("PaymentSchedule9") %>'>
                                            </asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="RadTextBox16" runat="server" Text='<%# Eval("PaymentText9")%>'>
                                            </asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <asp:Panel ID="PanelPS10" runat="server" Visible='<%# Eval("PaymentSchedule10") > 0%>' CssClass="table-responsive">
                                <table class="table no-margin-button">
                                    <tr>
                                        <td style="text-align: center; width: 100px">
                                            <asp:Label ID="RadTextBox17" runat="server" Text='<%# Eval("PaymentSchedule10") %>'>
                                            </asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="RadTextBox18" runat="server" Text='<%# Eval("PaymentText10")%>'>
                                            </asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </section>
                    </div>

                    <%--Page 1. Task & Fee(s)--%>
                    <div class="row mb-lg">
                        <section class="col-md-12 col-print-12">
                            <h3 class="company-name m-t-1">Task & Fee(s)</h3>
                            <div>
                                <telerik:RadGrid ID="RadGridTask" runat="server" DataSourceID="SqlDataSourceRFPDetails" ShowFooter="true" RenderMode="Lightweight" Width="100%" Skin="" GridLines="None" CssClass="table-responsive">
                                    <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSourceRFPDetails" CssClass="table">
                                        <FooterStyle BorderStyle="None" />

                                        <Columns>
                                            <telerik:GridBoundColumn DataField="Id" HeaderText="" UniqueName="Id"
                                                HeaderStyle-Width="40px" Display="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="TaskCode" HeaderText="" UniqueName="TaskCode"
                                                HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn DataField="Description" HeaderText="DESCRIPTION" UniqueName="Description"
                                                HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="GridColumn">
                                                <ItemTemplate>
                                                    <b><%# Eval("Description")%></b>
                                                    <br />
                                                    <small><%# Eval("DescriptionPlus")%></small>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="Quantity" HeaderText="QUANTITY" UniqueName="Quantity"
                                                HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" FooterStyle-CssClass="hidden-sm-down" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden-sm-down" ItemStyle-CssClass="hidden-sm-down">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblQuantity" runat="server" Text='<%# IIf(Eval("Quantity") = 0, "N/A", Eval("Quantity"))%>' />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="UnitPrice" HeaderText="Price" UniqueName="UnitPrice"
                                                HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" FooterStyle-CssClass="hidden-sm-down" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden-sm-down" ItemStyle-CssClass="hidden-sm-down">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUnitPrice" runat="server" Text='<%# IIf(Eval("UnitPrice") = 0, "N/A", Eval("UnitPrice", "{0:C2}"))%>' />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="LineTotal" HeaderText="TOTAL" UniqueName="LineTotal"
                                                HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" Aggregate="Sum"
                                                FooterAggregateFormatString="{0:C}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true" ItemStyle-CssClass="GridColumn">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTotal2" runat="server" ForeColor='<%# IIf(Eval("LineTotal") = 0, System.Drawing.Color.White, System.Drawing.Color.Black)%>' Text='<%# Eval("LineTotal", "{0:C2}")%>' />
                                                </ItemTemplate>

                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </div>
                        </section>
                    </div>

                    <%--Page 1. End Page--%>
                    <%--<div class="btn-toolbar mt-lg hidden-print print-buttons">
                        <button class="btn btn-inverse print">
                            <i class="fa fa-print"></i>
                            &nbsp;&nbsp;
                                Print
                        </button>
                    </div>--%>
                </div>
            </div>
            <%-- End of Page 1 --%>

            <%-- Page 2 --%>
            <div class="row page" style="text-align: left">

                <%--Page 2. Prime Agreements--%>
                <div class="row mb-lg">
                    <section class="col-md-12 col-print-12">
                        <h3 class="company-name m-t-1">Prime Agreements</h3>
                        <div style="text-align: left; padding-left: 50px">
                            <%# Eval("ProjectAgreements")%>
                        </div>
                    </section>
                </div>

                <%--Page 2. SubconsultantNotes--%>
                <div class="row mb-lg">
                    <section class="col-md-12 col-print-12">
                        <h3 class="company-name m-t-1">Subconsultant Notes</h3>
                        <div style="text-align: left; padding-left: 50px">
                            <%# Eval("SubconsultantNotes") %>
                        </div>
                    </section>
                </div>

                <%--Page 2. Professional Services Agreement--%>
                <div class="row mb-lg">
                    <section class="col-md-12 col-print-12">
                        <h3 class="company-name m-t-1">Professional Services Agreement</h3>
                        <div style="text-align: left; padding-left: 50px">
                            <%# Eval("SubconsultantAgreements") %>
                        </div>
                    </section>
                </div>

                <%--Page 2. End Page--%>
                <div class="col-md-12">
                    <section class="widget widget-invoice">
                        <div class="widget-body">

                            <%--<div class="btn-toolbar mt-lg hidden-print print-buttons">
                                <button class="btn btn-inverse print">
                                    <i class="fa fa-print"></i>
                                    &nbsp;&nbsp;
                                                Print
                                </button>
                            </div>--%>
                        </div>
                    </section>
                </div>

            </div>
        </ItemTemplate>
    </asp:FormView>
    <%-- End of Main Content --%>

    <%--Reject Dialog--%>
    <telerik:RadToolTip ID="RadToolTipReject" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

        <table class="table table-bordered" style="width: 600px">
            <tr>
                <td>
                    <h2 style="margin: 0; text-align: center; color:white; width: 600px">
                       <span class="navbar navbar-expand-md bg-dark text-white">Reject Proposal
                        </span>
                    </h2>

                </td>
            </tr>
            <tr>
                <td style="text-align: center">
                    <h4>Are you sure you reject this Request for Proposal?</h4>
                </td>
            </tr>

            <tr>
                <td>
                    <telerik:RadTextBox ID="txtReject" runat="server" Width="100%" EmptyMessage="Reject notes..." TextMode="MultiLine" Rows="3">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ForeColor="Red" runat="server" ValidationGroup="Reject" SetFocusOnError="true"
                        ControlToValidate="txtReject"
                        ErrorMessage="<span class='val-msg'><b>Reject Notes </b> is required</span>">
                    </asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="text-align: center">
                    <asp:LinkButton ID="btnRejectConfirm" runat="server" CssClass="btn btn-danger btn-lg" UseSubmitBehavior="false" Width="120px" CausesValidation="true" ValidationGroup="Reject">
                                     Reject
                    </asp:LinkButton>
                    &nbsp;
                    &nbsp;
                    &nbsp;
                    <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-secondary btn-lg" UseSubmitBehavior="false" Width="120px" CausesValidation="false">
                                     Cancel
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <%-- SqlDataSources --%>
    <asp:SqlDataSource ID="SqlDataSourceRFP" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="RFP_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblRFPId" Name="Id" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceRFPDetails" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="RFP_Details_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblRFPId" Name="rfpId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceAzureuploads" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="RequestForProposals_azureuploads_v20_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblRFPId" Name="requestforproposalId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <%-- End of SqlDataSources --%>
    <%-- Hidden Labels --%>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblGuiId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblRFPId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblIsReadOnly" runat="server" Visible="False" Text="0"></asp:Label>

    <%-- End of Hidden Labels --%>
</asp:Content>

