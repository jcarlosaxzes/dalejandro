<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="pasconcept20._Default2" MasterPageFile="~/master/MasterPage.Master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ MasterType VirtualPath="~/master/MasterPage.Master" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="text-align: center">

        <br />
        <br />
        <br />
        <br />
        <table class="table-light" style="width: 100%">
            <tr>
                <td colspan="3">
                    <a href="CompanyList.aspx" target="_blank">
                        <h2>Companies
                        </h2>
                    </a>
                </td>
            </tr>
            <tr>
                <td style="width: 33%">
                    <a href="CompanyList.aspx?statusId=0" target="_blank">
                        <h4>Active Companies</h4>
                    </a>
                </td>
                <td style="width: 33%">
                    <a href="CompanyList.aspx?statusId=1" target="_blank">
                        <h4>Inactive Companies</h4>
                    </a>
                </td>
                <td>
                    <a href="CreateCompany" target="_blank">
                        <h4>New Company</h4>
                    </a>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <hr />
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <a href="Invoices.aspx" target="_blank">
                        <h2 style="color: darkred">Invoices</h2>
                    </a>
                </td>
            </tr>
            <tr>
                <td>
                    <a href="Invoices.aspx?statusId=1" target="_blank">

                        <h1 style="color: darkred"><%# Eval("PaidInvoices")%></h1>
                        <h4>Paid Invoices</h4>
                    </a>
                </td>
                <td>
                    <a href="Invoices.aspx?statusId=2" target="_blank">
                        <h4>Past Due Invoices</h4>
                    </a>
                </td>
                <td>
                    <a href="Invoices.aspx?statusId=0" target="_blank">
                        <h4>Pending Invoices</h4>
                    </a>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <hr />
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <a href="HistoryLog.aspx" target="_blank">
                        <h2>Company Activity</h2>
                    </a>
                </td>
            </tr>
            <tr>
                <td>
                    <a href="HistoryLog.aspx" target="_blank">
                        <h4>Last 24h Activity</h4>
                    </a>
                </td>
                <td>
                    <a href="HistoryLog.aspx" target="_blank">
                        <p class="text-info input-lg PanelRed">Last Week Activity</h4>
                    </a>
                </td>
                <td>
                    <a href="HistoryLog.aspx" target="_blank">
                        <h4>Last Month Activity</h4>
                    </a>
                </td>
            </tr>
        </table>
    </div>

</asp:Content>
