<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/e2103445_8a47_49ff_808e_6008c0fe13a1/smarth/mastersmarth.Master" CodeBehind="salesstatus.aspx.vb" Inherits="pasconcept20.salesstatus" %>

<%@ Import Namespace="pasconcept20" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div id="main-section-header" class="row">
        <asp:Label ID="lblMonthYear" runat="server" CssClass="Titulo1"></asp:Label><br />
        <asp:Label ID="lblNow" runat="server" Font-Size="X-Small"></asp:Label>
        <table class="table table-striped">
            <tr>
                <td style="width:45%">
                    <asp:Label ID="lblMonthTargetLabel" runat="server" CssClass="section-label-movil"></asp:Label></td>
                <td>
                    <asp:Label ID="lblTotalTargetMonth" runat="server" Text="0" CssClass="stats-label"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblMonthCurrentLabel" runat="server" CssClass="section-label-movil"></asp:Label></td>
                <td>
                    <asp:Label ID="lblTotalCurrentMonth" runat="server" Text="0" CssClass="stats-label"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblMonthBalanceLabel" runat="server" CssClass="section-label-movil"></asp:Label></td>
                <td>
                    <asp:Label ID="lblTotalBalanceMonth" runat="server" Text="0" CssClass="stats-label"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label1" runat="server" CssClass="section-label-movil" Text="Accumulated"></asp:Label></td>
                <td>
                    <asp:Label ID="lblBalanceYear" runat="server" Text="0" CssClass="stats-label"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblYearCurrent" runat="server" CssClass="section-label-movil"></asp:Label></td>
                <td>
                    <asp:Label ID="lblTotalCurrentYear" runat="server" Text="0" CssClass="stats-label"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblMonthBilledLabel" runat="server" CssClass="section-label-movil"></asp:Label></td>
                <td>
                    <asp:Label ID="lblMonthBilled" runat="server" Text="0" CssClass="stats-label"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblMonthCollectedLabel" runat="server" CssClass="section-label-movil"></asp:Label></td>
                <td>
                    <asp:Label ID="lblMonthCollected" runat="server" Text="0" CssClass="stats-label"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblMonthProposalLabel" runat="server" CssClass="section-label-movil"></asp:Label></td>
                <td>
                    <asp:Label ID="lblMonthProposal" runat="server" CssClass="stats-label" Text="0.0"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblYearProposalLabel" runat="server" CssClass="section-label-movil"></asp:Label></td>
                <td>
                    <asp:Label ID="lblYearProposal" runat="server" Text="0" CssClass="stats-label"></asp:Label></td>
            </tr>
        </table>
    </div>
    `   
    <asp:Label ID="lblCompanyId" runat="server" Text="0" Visible="False"></asp:Label>
</asp:Content>
