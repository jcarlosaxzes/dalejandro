<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="rfps.aspx.vb"  MasterPageFile="~/e2103445_8a47_49ff_808e_6008c0fe13a1/sub/SubconsultantMasterPage.Master" Inherits="pasconcept20.rfps1" %>


<%@ MasterType VirtualPath="~/e2103445_8a47_49ff_808e_6008c0fe13a1/sub/SubconsultantMasterPage.Master" %>

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
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceSubconsultantBalance" Width="100%">
                <ItemTemplate>

                    <table class="table-sm" style="width: 100%">
                        <tr>
                            <td style="text-align: left; vertical-align: top; width: 33%">
                                <h2 style="margin: 0"><span class="navbar navbar-expand-md bg-dark text-white">Subconsultant</span></h2>
                                <table style="width: 100%">
                                    <tr>
                                        <td>
                                            <h3 style="margin: 3px"><%# Eval("SubconsultanName")%></h3>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%# Eval("SubconsultanCompany") %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <small><%# Eval("SubconsultanFullAddress")%></small>
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
                                <h2 style="margin: 0"><span class="navbar navbar-expand-md bg-dark text-white">Projects</span></h2>
                                <table style="width: 85%">
                                    <tr>
                                        <td style="text-align: right"># Pending Proposals:</td>
                                        <td style="width: 120px; text-align: right">
                                            <h4 style="margin: 3px"><%# Eval("NumberPendingRFP", "{0:N0}") %></h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right">Accepted Proposals:</td>
                                        <td style="text-align: right">
                                            <h4 style="margin: 3px"><%# Eval("AmountAcceptedTotal", "{0:C2}") %></h4>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="text-align: right; vertical-align: top">
                                <h2 style="margin: 0"><span class="navbar navbar-expand-md bg-dark text-white">Balance</span></h2>
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
                                            <h4 style="margin: 3px"><%# Eval("Balance", "{0:C2}") %></h4>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>


                </ItemTemplate>
            </asp:FormView>
            <br />
            <h2><span class="navbar navbar-expand-md bg-dark text-white">Request for Proposals History</span></h2>
            <telerik:RadGrid ID="RadGridRFPs" runat="server" DataSourceID="SqlDataSourceRFP" AutoGenerateColumns="False" AllowSorting="True"
                        PageSize="10" AllowPaging="true"
                        ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" HeaderStyle-Font-Size="Small" FooterStyle-Font-Size="Small">
                        <ClientSettings>
                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                        </ClientSettings>
                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceRFP" ShowFooter="True" ClientDataKeyNames="Id">
                            <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                            <Columns>
                            <telerik:GridTemplateColumn DataField="Id" HeaderText="Number"
                                SortExpression="Id" UniqueName="Id" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                                <ItemTemplate>
                                 <a href='<%# LocalAPI.GetSharedLink_URL(2002, Eval("Id"))%>' title="Subconsultant View of RFP">
                                                    <%# Eval("RFPNumber") %></a>
                                                </a>
                                </ItemTemplate>

                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="DateCreated" DataFormatString="{0:d}"
                                DataType="System.DateTime" HeaderText="Date" SortExpression="DateCreated"
                                UniqueName="DateCreated" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right"
                                HeaderStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ProjectName" HeaderText="Project" SortExpression="ProjectName"
                                UniqueName="ProjectName" HeaderStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Discipline" FilterControlAltText="Filter Discipline column"
                                HeaderText="Discipline" SortExpression="Discipline" UniqueName="Discipline"
                                ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="140px"
                                HeaderStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Total" DataFormatString="{0:C2}"
                                Groupable="False" HeaderText="Total" SortExpression="Total" UniqueName="Total"
                                HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                                FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:C2}">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="AmountPaid" DataFormatString="{0:C2}"
                                Groupable="False" HeaderText="Amount Paid" SortExpression="AmountPaid" UniqueName="AmountPaid"
                                HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                                FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:C2}">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Balance" DataFormatString="{0:C2}"
                                Groupable="False" HeaderText="Balance" SortExpression="Balance" UniqueName="Balance"
                                HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                                FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:C2}">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="Status" HeaderText="Status" UniqueName="Status"
                                ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="110px"
                                HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <span title="Clic to edit Job Status" class='<%# LocalAPI.GetRFPStatusLabelCSS(Eval("StateId")) %>'><%# Eval("Status") %></span>
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

    <asp:SqlDataSource ID="SqlDataSourceSubconsultantBalance" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Subconsultant_Balance" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblSubconsultantId" Name="subconsultantId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceRFP" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="RFP_by_Subconsultant_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblSubconsultantId" Name="subconsultantId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSubconsultantId" runat="server" Visible="False"></asp:Label>
</asp:Content>

