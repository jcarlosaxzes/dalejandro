<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="CreateJobFromProposal.aspx.vb" Inherits="pasconcept20.CreateJobFromProposal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel CssClass="PanelFilter noprint" ID="pnlFind" runat="server">
        <table class=" table-condensed pasconcept-bar" style="width: 100%">
            <tr>
                
                <td style="width: 350px">
                    <telerik:RadComboBox ID="cboCompany" runat="server" DataSourceID="SqlDataSourceCompany"
                        Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Height="300px"
                        AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(All Companies...)" Value="-1" Selected="true" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtProposalId" runat="server" x-webkit-speech="x-webkit-speech"
                        EmptyMessage="ProposalId" Width="100%">
                    </telerik:RadTextBox>
                </td>
                <td style="width: 100px">
                    <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false" OnClick="btnFind_Click">
                                            <i class="fas fa-search"></i> Create
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </asp:Panel>

    <asp:SqlDataSource ID="SqlDataSourceCompany" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id]=companyId, CONCAT(companyId,'-',  Name) as Name FROM [Company] ORDER BY [Name]"></asp:SqlDataSource>
</asp:Content>
