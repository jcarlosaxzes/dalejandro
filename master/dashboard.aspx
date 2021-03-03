<%@ Page Title="Dashboard" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="dashboard.aspx.vb" Inherits="pasconcept20.dashboard1" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ MasterType VirtualPath="~/master/MasterPage.Master" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        h1 {
            font-size: 72px;
        }

        h2 {
            font-size: 40px;
        }
        .PanelGreen{
            font-size:24px;
            color:black;
            font-weight:bold;
            background-color:rgb(145, 199, 148);
        }
        .PanelRed{
            font-size:24px;
            color:black;
            font-weight:bold;
            background-color:rgb(214, 76, 76);
        }
        .PanelBlue{
            font-size:24px;
            color:black;
            font-weight:bold;
            background-color:rgb(92, 194, 241);
        }
    </style>


    <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1" Width="100%">
        <ItemTemplate>
            <div style="text-align: center">
                <table class="table-bordered" style="width: 100%">
                    <tr>
                        <td colspan="3">
                            <a href="https://www.pasconcept.com/master/CompanyList.aspx" target="_blank">
                                <h2>Companies
                                </h2>
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 33%">
                            <a href="https://www.pasconcept.com/master/CompanyList.aspx?statusId=0" target="_blank">
                                <h1 style="color: darkgreen"><%# Eval("ActiveCompanies")%></h1>
                                <p class="text-success input-lg PanelGreen">Active</p>
                            </a>
                        </td>
                        <td style="width: 33%">
                            <a href="https://www.pasconcept.com/master/CompanyList.aspx?statusId=1" target="_blank">
                                <h1 style="color: darkgreen"><%# Eval("PastDueCompanies")%></h1>
                                <p class="text-danger input-lg PanelRed">Past Due</p>
                            </a>
                        </td>
                        <td>
                            <a href="https://www.pasconcept.com/master/CompanyList.aspx?statusId=-1" target="_blank">
                                <h1 style="color: darkgreen"><%# Eval("TotalCompanies")%></h1>
                                <p class="text-info input-lg PanelBlue">Total</p>
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <a href="https://www.pasconcept.com/master/Invoices.aspx" target="_blank">
                                <h2 style="color: darkred">Invoices</h2>
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a href="https://www.pasconcept.com/master/Invoices.aspx?statusId=1" target="_blank">
                                
                                <h1 style="color: darkred"><%# Eval("PaidInvoices")%></h1>
                                <p class="text-success input-lg PanelGreen">Paid: <small style="color:white"><%# Eval("PaidInvoicesAmount", "{0:C2}")%></small></p>
                            </a>
                        </td>
                        <td>
                            <a href="https://www.pasconcept.com/master/Invoices.aspx?statusId=2" target="_blank">
                                <h1 style="color: darkred"><%# Eval("PastDueInvoices")%></h1>
                                <p class="text-danger input-lg PanelRed">Past Due</p>
                            </a>
                        </td>
                        <td>
                            <a href="https://www.pasconcept.com/master/Invoices.aspx?statusId=0" target="_blank">
                                <h1 style="color: darkred"><%# Eval("Pendingnvoices")%></h1>
                                <p class="text-info input-lg PanelBlue">Pending</p>
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <a href="https://www.pasconcept.com/master/HistoryLog.aspx" target="_blank">
                                <h2>Active Companies</h2>
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a href="https://www.pasconcept.com/master/HistoryLog.aspx" target="_blank">
                                <h1><%# Eval("Last24h")%></h1>
                                <p class="text-success input-lg PanelGreen">Last 24h</p>
                            </a>
                        </td>
                        <td>
                            <a href="https://www.pasconcept.com/master/HistoryLog.aspx" target="_blank">
                                <h1><%# Eval("LastWeek")%></h1>
                                <p class="text-info input-lg PanelRed">Last Week</p>
                            </a>
                        </td>
                        <td>
                            <a href="https://www.pasconcept.com/master/HistoryLog.aspx" target="_blank">
                                <h1><%# Eval("LastMonth")%></h1>
                                <p class="text-danger input-lg PanelBlue">Last Month</p>
                            </a>
                        </td>
                    </tr>
                </table>
            </div>
        </ItemTemplate>
    </asp:FormView>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="MASTER_Dashboard_SELECT" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

</asp:Content>
