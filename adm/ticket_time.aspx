<%@ Page Title="Ticket Time" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="ticket_time.aspx.vb" Inherits="pasconcept20.ticket_time" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">
            <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
                       Back to List
            </asp:LinkButton>
            Ticket Time
        </span>
    </div>

    <div class="pasconcept-bar">
        <asp:FormView ID="FormViewTicketBalance" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceTicketBalance" Width="100%">
            <ItemTemplate>
                <table class="table-sm" style="width: 100%">
                    <tr>
                        <td colspan="9">
                            <hr style="margin: 0" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="9" style="text-align: center">
                            <h2 style="margin: 0">Ticket: <%# Eval("Title")%>, <%# Eval("Status")%> </h2>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="9" style="text-align: center">
                            <h3 style="margin: 0">Job: <%# Eval("JobName")%> </h3>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="9" style="text-align: center">
                            <%# Eval("ClientDescription")%> 
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 23%; text-align: center; background-color: #039be5">
                            <span class="DashboardFont2">Estimates Hours:</span><br />
                            <asp:Label ID="lblTotalBudget" CssClass="DashboardFont1" runat="server" Text='<%# Eval("EstimatedHours", "{0:N0}") %>'></asp:Label>
                        </td>
                        <td></td>
                        <td style="width: 23%; text-align: center; background-color: #43a047">
                            <span class="DashboardFont2">Worked Hours</span><br />
                            <asp:Label ID="lblTotalCollected" runat="server" CssClass="DashboardFont1" Text='<%# Eval("WorkedHours", "{0:N0}") %>'></asp:Label>
                        </td>
                        <td></td>
                        <td style="width: 23%; text-align: center; background-color: #e53935">
                            <span class="DashboardFont2">Time Used</span><br />
                            <asp:Label ID="LabelblTotalBalance" runat="server" CssClass="DashboardFont1" Text='<%# Eval("TimeUsed", "{0:P0}") %>'></asp:Label>
                        </td>
                        <td></td>
                        <td style="width: 23%; text-align: center; background-color: #546e7a">
                            <span class="DashboardFont2">Invoice Ammount</span><br />
                            <asp:Label ID="lblTotalBilled" runat="server" CssClass="DashboardFont1" Text='<%# Eval("InvoiceAmount", "{0:C0}") %>'></asp:Label>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:FormView>
    </div>
    <div class="pasconcept-bar">
        <telerik:RadGrid ID="RadGridEmployees" runat="server" DataSourceID="SqlDataSourceTicketEmployees" ShowFooter="true"
            HeaderStyle-HorizontalAlign="Center">
            <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceTicketEmployees">
                <Columns>
                    <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" HeaderText="ID" SortExpression="Id" UniqueName="Id" Display="False">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Employee" HeaderText="Employee" SortExpression="Employee" UniqueName="Employee"
                        FooterAggregateFormatString="{0:N0}" Aggregate="Count" FooterStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="HoursWorked" HeaderText="H. Worked" SortExpression="HoursWorked" UniqueName="HoursWorked"
                        DataFormatString="{0:N0}" FooterAggregateFormatString="{0:N0}" FooterStyle-Font-Bold="true" HeaderTooltip="Hours Worked"
                        Aggregate="Sum" FooterStyle-HorizontalAlign="Center" HeaderStyle-Width="180px" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="FromDate" HeaderText="From" HeaderStyle-Width="180px" SortExpression="FromDate" UniqueName="FromDate"
                        DataFormatString="{0:d}" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ToDate" HeaderText="To" HeaderStyle-Width="180px" SortExpression="ToDate" UniqueName="ToDate" DataFormatString="{0:d}"
                        ItemStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="SqlDataSourceTicketEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Jobs_TicketEmployees_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblTicketId" Name="TicketId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTicketBalance" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Ticket_Balance" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblTicketId" Name="TicketId" PropertyName="Text" Type="Int32" />
        </SelectParameters>

    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblJobId" runat="server" Visible="False" Text="0"></asp:Label>
    <asp:Label ID="lblTicketId" runat="server" Visible="False"></asp:Label>
</asp:Content>
