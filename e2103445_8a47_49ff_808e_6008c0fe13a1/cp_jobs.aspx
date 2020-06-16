<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/e2103445_8a47_49ff_808e_6008c0fe13a1/ClientPortalMP.Master" CodeBehind="cp_jobs.aspx.vb" Inherits="pasconcept20.cp_jobs" %>


<%@ MasterType VirtualPath="~/e2103445_8a47_49ff_808e_6008c0fe13a1/ClientPortalMP.master" %>

<%@ Import Namespace="pasconcept20" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-md-12">
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceClient" Width="100%">
                <ItemTemplate>

                    <table style="width: 100%; background-color: white; margin-top: 20px">
                        <tr>
                            <td style="text-align: left; vertical-align: top; width: 45%">
                                <h2>class="card bg-danger text-white"Client Info</span></h2>

                                <h3 style="margin: 0"><%# Eval("ClientName")%></h3>
                                <%# Eval("ClientCompany") %><br />
                                <%# Eval("ClientFullAddress")%><br />
                                <%# LocalAPI.PhoneHTML(Request.UserAgent, Eval("Phone"))%><br />
                            </td>
                            <td style="width: 10%"></td>
                            <td style="text-align: right; vertical-align: top">
                                <h2>class="card bg-danger text-white"Balance</span></h2>
                                <table style="width: 100%">
                                    <tr>
                                        <td style="text-align: right;">Contract Amount:</td>
                                        <td style="width: 120px;">
                                            <h4 style="margin: 3px"><%# Eval("ContractAmount","{0:C2}") %></h4>
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
            <hr />
        </div>

    </div>

    <div class="row">
        <div class="col-md-6">
            <telerik:RadTextBox ID="txtFind" runat="server" EmptyMessage="Find" Width="100%">
            </telerik:RadTextBox>

        </div>
        <div class="col-md-2">
            <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Search
            </asp:LinkButton>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <br />
            <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None"
                AllowSorting="True" Skin="Bootstrap"
                CellSpacing="0" AutoGenerateColumns="False">
                <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1" ShowFooter="True">
                    <PagerStyle Mode="Slider" AlwaysVisible="false" />
                    <Columns>
                        <telerik:GridTemplateColumn DataField="JobName" HeaderText="Project Info" SortExpression="JobName"
                            UniqueName="JobName" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="300px">
                            <ItemTemplate>
                                <div>
                                    <a href='<%# LocalAPI.GetSharedLink_URL(7,Eval("Id"))%>' target="_blank" title="view Job Roll-Up"><%# Eval("Code")%></a>
                                    <%# Eval("JobName") %>
                                </div>
                                <div style="font-size: x-small">
                                    <b><%#Eval("nStatus")%> -- </b>&nbsp;<%#Eval("ProjectManager") %>
                                </div>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn DataField="Open_date" DataType="System.DateTime" DataFormatString="{0:MM/dd/yyyy}"
                            ReadOnly="true" HeaderText="Date Opened" SortExpression="Open_date" UniqueName="Open_date"
                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="100px">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Budget" HeaderText="Contract Amount"
                            ReadOnly="true" SortExpression="Budget" UniqueName="Budget" DataFormatString="{0:N2}"
                            Aggregate="Sum" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                            FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="100px">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="TotalPaid" HeaderText="Amount Paid"
                            ReadOnly="True" SortExpression="TotalPaid" UniqueName="TotalPaid" DataFormatString="{0:N2}"
                            Aggregate="Sum" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                            FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="100px">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Balance" HeaderText="Remaining Balance"
                            ReadOnly="True" SortExpression="Balance" UniqueName="Balance" DataFormatString="{0:N2}"
                            Aggregate="Sum" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                            FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="100px">
                        </telerik:GridBoundColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
    </div>
                <%-- Fixed Blank --%>
            <div style="width: 100%; text-align: center; padding-top: 80px !important">
                <p class="text-muted">
                    
                </p>
            </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOBS_CLIENTPORTAL_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblClientId" Name="ClientId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Filter"
                PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Client_Balance" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblClientId" Name="ClientId" PropertyName="Text" Type="Int32" />
        </SelectParameters>

    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblClientId" runat="server" Visible="False"></asp:Label>
</asp:Content>

