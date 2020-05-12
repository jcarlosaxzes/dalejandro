<%@ Page Title="Proposal Phases" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="proposalphases.aspx.vb" Inherits="pasconcept20.proposalphases" %>

<%@ MasterType VirtualPath="~/ADM/BasicMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadPivotGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadPivotGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>
    
    <div style="text-align: right; padding-right: 50px; padding-top: 10px;padding-bottom:10px" class="Formulario">
        <telerik:RadButton ID="btnExcel" runat="server" Text="Export to Excel" UseSubmitBehavior="false">
        </telerik:RadButton>
        &nbsp;&nbsp;&nbsp;
        <telerik:RadButton ID="btnCancel" runat="server" Text="Back" Width="150px" CausesValidation="false">
            <Icon PrimaryIconCssClass=" rbPrevious" PrimaryIconLeft="4" PrimaryIconTop="4"></Icon>
        </telerik:RadButton>
    </div>

    <div style="text-align: left; width: 860px; padding-top: 15px;height:660px" >
        <telerik:RadPivotGrid ID="RadPivotGrid1" runat="server" DataSourceID="SqlDataSource1" Height="650px"
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

