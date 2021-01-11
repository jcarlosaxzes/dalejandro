<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="companySubscription.aspx.vb" Inherits="pasconcept20.companySubscription" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ MasterType VirtualPath="~/master/MasterPage.Master" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table class="table-sm" style="width: 100%">

        <tr>
            <td style="width: 180px; text-align: right">Subcription Status:
            </td>
            <td style="width: 220px;">
                <telerik:RadComboBox ID="cboExpired" runat="server" Width="100%" AppendDataBoundItems="true">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="Subcription Expired" Value="0" Selected="true" />
                        <telerik:RadComboBoxItem runat="server" Text="Subcription Active" Value="1" />
                        <telerik:RadComboBoxItem runat="server" Text="All Subcription" Value="-1" />
                    </Items>
                </telerik:RadComboBox>
            </td>

            <td style="width: 120px; text-align: right">Active / Lock :
            </td>
            <td style="width: 290px;">
                <telerik:RadComboBox ID="cboStatus" runat="server" Width="100%" AppendDataBoundItems="true">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="Active When Subcription Expired" Value="0" />
                        <telerik:RadComboBoxItem runat="server" Text="Lock When Subcription Expired" Value="1" />
                        <telerik:RadComboBoxItem runat="server" Text="(All)" Value="-1" Selected="true" />
                    </Items>
                </telerik:RadComboBox>
            </td>

            <td style="text-align: center">
                <asp:Label ID="lblMsg" runat="server" Style="font-size: medium; color: #cc0000; font-family: Calibri, Verdana"></asp:Label>
            </td>
            <td style="width: 150px; text-align: right">
                <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                </asp:LinkButton>
            </td>
        </tr>
    </table>
    <table class="table-sm" style="width: 100%">
        <tr>
            <td>
                <telerik:RadGrid ID="RadGrid1" runat="server" CellSpacing="0" DataSourceID="SqlDataSource1" AllowAutomaticUpdates="false" AllowAutomaticDeletes="false" ShowFooter="true"
                    GridLines="None" AutoGenerateColumns="False" AllowSorting="True" Skin="Bootstrap"
                    ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" HeaderStyle-Font-Size="X-Small">
                    <MasterTableView DataKeyNames="companyId" DataSourceID="SqlDataSource1">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="ID" UniqueName="companyId" SortExpression="companyId"
                                ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:HyperLink ID="HyperLink1" runat="server" CssClass="PequenaNegrita" NavigateUrl='<%# Eval("companyId", "~/MASTER/Company.aspx?companyId={0}") %>'
                                        Text='<%# Eval("companyId") %>'></asp:HyperLink>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="billingStartDate" SortExpression="billingStartDate"
                                HeaderText="Start Date" UniqueName="billingStartDate" HeaderStyle-HorizontalAlign="Center" ReadOnly="true">
                                <ItemTemplate>
                                    <%# Eval("billingStartDate", "{0:d}")%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="billingExpirationDate" SortExpression="billingExpirationDate"
                                HeaderText="Expiration Date" UniqueName="billingExpirationDate" HeaderStyle-HorizontalAlign="Center" ReadOnly="true">
                                <ItemTemplate>
                                    <%# Eval("billingExpirationDate", "{0:d}")%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column" SortExpression="Name"
                                HeaderText="Name -- Type" UniqueName="Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left"
                                FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                                <ItemTemplate>
                                    <b><%# Eval("Name") %></b> -- <%# Eval("TypeName") %>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Contact" FilterControlAltText="Filter Contact column"
                                HeaderText="Contact info" UniqueName="Contact" HeaderStyle-HorizontalAlign="Center" SortExpression="Contact">
                                <ItemTemplate>
                                    <table style="width: 100%">
                                        <tr>
                                            <td>
                                                <span title='<%# Eval("Email") %> , <%# Eval("Phone") %>'><%# Eval("Contact") %></span>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="billingExpirationDate" SortExpression="billingExpirationDate"
                                HeaderText="Status" UniqueName="status" HeaderStyle-HorizontalAlign="Center" ReadOnly="true">
                                <ItemTemplate>
                                    <span title='<%# IIf(Eval("billingExpirationDate") < DateTime.Today, "Subscritption Expired", "Subscritption Active") %>' class="label badge-<%# IIf(Eval("billingExpirationDate") >= DateTime.Today, "success", IIf(Eval("BlockSubcriptionExpired") = 0, "warning", "danger")) %>">
                                        <%# IIf(Eval("billingExpirationDate") < DateTime.Today, "Subscritption Expired", "Subscritption Active") %>
                                    </span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="BillingPlan" FilterControlAltText="Filter Contact column" SortExpression="BillingPlan"
                                HeaderText="Billing Plan" UniqueName="BillingPlan" HeaderStyle-HorizontalAlign="Center" ReadOnly="true">
                                <ItemTemplate>
                                    <%# Eval("BillingPlan")%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="VersionName" FilterControlAltText="Filter Contact column" SortExpression="VersionName"
                                HeaderText="Version" UniqueName="VersionName" HeaderStyle-HorizontalAlign="Center" ReadOnly="true" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <%# Eval("VersionName") %>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="ActiveUsers" FilterControlAltText="Filter Contact column" SortExpression="ActiveUsers"
                                HeaderText="Active Users" UniqueName="ActiveUsers" HeaderStyle-HorizontalAlign="Center" ReadOnly="true" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <%# Eval("ActiveUsers")%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="LastSubscriptionPaymentDate" FilterControlAltText="Filter Contact column" SortExpression="LastSubscriptionPaymentDate"
                                HeaderText="Last Payment" UniqueName="LastSubscriptionPaymentDate" HeaderStyle-HorizontalAlign="Center" ReadOnly="true" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <%# Eval("LastSubscriptionPaymentDate", "{0:d}")%>     <%# Eval("LastSubscriptionPaymentAmount")%>$
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="InvoicesCount" FilterControlAltText="Filter Contact column" SortExpression="InvoicesCount"
                                HeaderText="Invoices" UniqueName="InvoicesCount" HeaderStyle-HorizontalAlign="Center" ReadOnly="true" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <%# Eval("InvoicesCount")%>/<%# Eval("InvoicesCountPaid")%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="NextPaymentAmount" FilterControlAltText="Filter Contact column" SortExpression="NextPaymentAmount"
                                HeaderText="Next Payment" UniqueName="NextPaymentAmount" HeaderStyle-HorizontalAlign="Center" ReadOnly="true" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <%# Eval("NextPaymentDate", "{0:d}")%>     <%# Eval("NextPaymentAmount")%>$
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Job" UniqueName="AxzesJobCode" SortExpression="AxzesJobCode"
                                ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:HyperLink ID="HyperLink2" runat="server" CssClass="PequenaNegrita" Target="_blank" NavigateUrl='<%# Eval("guid", "~/adm/job_accounting?guid={0}&backpage=jobs") %>'
                                        Text='<%# Eval("AxzesJobId") %>'></asp:HyperLink>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="SendRenewSubscription"
                                HeaderText="Count Email Send" UniqueName="Contact" HeaderStyle-HorizontalAlign="Center" SortExpression="Contact">
                                <ItemTemplate>
                                    <table style="width: 100%">
                                        <tr>
                                            <td>
                                                <span><%# Eval("SendRenewSubscription") %></span>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>

                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="Actions" HeaderStyle-HorizontalAlign="Center"
                                HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <table style="text-align: center; width: 100%">
                                        <tr>
                                            <td style="width: 30px">
                                                <asp:LinkButton ID="btnSentEmail" runat="server" CommandName="SendEmail" CommandArgument='<%# Eval("companyId") %>' UseSubmitBehavior="false"
                                                    ToolTip="Send Email with Subscription Expired">
                                                    <i class="far fa-envelope"></i>
                                                </asp:LinkButton>
                                            </td>
                                            <td style="width: 30px">
                                                <asp:HyperLink ID="LinkButton1" runat="server" Target="_blank" NavigateUrl='<%# "~/master/companySubscriptionInvoices?companyId=" + Eval("companyId").ToString() %>' UseSubmitBehavior="false"
                                                    ToolTip="View/Create Invoices">

                                                    <i class="fas fa-file-invoice-dollar"></i>
                                                                    
                                                </asp:HyperLink>
                                            </td>
                                            <td style="width: 30px">
                                                <asp:LinkButton ID="btnBlockCompany" runat="server" CommandName="BlockCompany" CommandArgument='<%# Eval("companyId") %>' UseSubmitBehavior="false"
                                                    ToolTip="Block Company when Subscription Expired">

                                                    <i class='<%# IIf(Eval("BlockSubcriptionExpired") = 0, "fas fa-unlock text-success", "fas fa-lock text-danger") %>'></i>
                                                                    
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>


                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>

                </telerik:RadGrid>
            </td>
        </tr>
    </table>

    <telerik:RadToolTip ID="RadToolTipBindAxzesClient" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

        <table class="table table-bordered" style="width: 650px">
            <tr>
                <td colspan="2">
                    <h2 style="margin: 0; text-align: center; color: white; width: 650px">
                        <span class="navbar navbar-expand-md bg-dark text-white">Send Subscription Expired Email
                        </span>
                    </h2>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <h3>
                        <asp:Label ID="lblCompanyName" runat="server"></asp:Label></h3>
                </td>
            </tr>
            <tr>
                <td style="width: 120px">To:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtTo" runat="server" Width="100%"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTo" SetFocusOnError="true"
                        CssClass="text-danger" Display="None" ValidationGroup="Email" ErrorMessage="Customer To is required." />
                </td>
            </tr>
            <tr>
                <td>Subject:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtSubject" runat="server" Width="100%"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSubject" SetFocusOnError="true"
                        CssClass="text-danger" Display="None" ValidationGroup="Email" ErrorMessage="Subject is required." />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <telerik:RadEditor ID="txtEmail" runat="server" Height="380px" EditModes="Design" Width="100%" BorderStyle="None" ContentAreaMode="Div">
                        <Tools>
                            <telerik:EditorToolGroup>
                            </telerik:EditorToolGroup>
                        </Tools>

                    </telerik:RadEditor>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" SetFocusOnError="true"
                        CssClass="text-danger" Display="None" ValidationGroup="Email" ErrorMessage="Message is required." />
                </td>
            </tr>
            <tr>
                <td style="text-align: center" colspan="2">
                    <asp:LinkButton ID="btnSendEmail" runat="server" CssClass="btn btn-primary btn-lg" UseSubmitBehavior="false" ValidationGroup="BindAxzesClient">
                                   Send Email
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="MasterCompanySubscription_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboStatus" Name="statusId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboExpired" Name="expired" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblSelectedCompanyId" runat="server" Visible="False" Text="0"></asp:Label>
</asp:Content>
