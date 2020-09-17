<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="proposalpivotphases.aspx.vb" Inherits="pasconcept20.proposalpivotphases" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pasconcept-bar">
        <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
            Back
        </asp:LinkButton>

        <span class="pasconcept-pagetitle">&nbsp;&nbsp;Proposal Phase Pivot View:&nbsp;<asp:Label ID="lblProposal" runat="server"></asp:Label></span>

    </div>

    <div class="pasconcept-bar">
        <telerik:RadPivotGrid ID="RadPivotGrid1" runat="server" DataSourceID="SqlDataSource1"
            ShowColumnHeaderZone="false" ShowFilterHeaderZone="false" ShowRowHeaderZone="false" ShowDataHeaderZone="false"
            RowTableLayout="Compact"
            AllowPaging="false">
            <ClientSettings Scrolling-AllowVerticalScroll="true">
            </ClientSettings>
            <Fields>
<%--                <telerik:PivotGridColumnField DataField="Phase" SortOrder="Ascending">
                </telerik:PivotGridColumnField>--%>
                <telerik:PivotGridColumnField DataField="Position">
                </telerik:PivotGridColumnField>
                <telerik:PivotGridRowField DataField="Phase" SortOrder="Ascending" CellStyle-Width="300px">
                </telerik:PivotGridRowField>
                <telerik:PivotGridRowField DataField="Discipline" CellStyle-Width="150px">
                </telerik:PivotGridRowField>
                <telerik:PivotGridAggregateField DataField="TotalRow" Aggregate="Sum" DataFormatString="{0:N2}" TotalFormatString="{0:N2}" GrandTotalAggregateFormatString="{0:N2}">
                </telerik:PivotGridAggregateField>
            </Fields>
        </telerik:RadPivotGrid>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Proposal_Phases_Pivot_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblproposalId" DefaultValue="" Name="proposalId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblproposalId" runat="server" Visible="false"></asp:Label>
</asp:Content>