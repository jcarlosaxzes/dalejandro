<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="proposalschedule.aspx.vb" Inherits="pasconcept20.proposalschedule" %>

<%@ MasterType VirtualPath="~/ADM/BasicMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="text-align: right; padding-right: 50px; padding-top: 10px; padding-bottom: 10px" class="pasconcept-bar">
        <telerik:RadButton ID="btnCancel" runat="server" Text="Back" Width="150px" CausesValidation="false">
            <Icon PrimaryIconCssClass=" rbPrevious" PrimaryIconLeft="4" PrimaryIconTop="4"></Icon>
        </telerik:RadButton>
    </div>

    <div style="text-align: left; width: 860px; padding-top: 15px; height: 660px" >
        <telerik:RadGantt ID="RadGantt1" runat="server" ReadOnly="true" Height="660px" AutoGenerateColumns="true" Width="100%" EnablePdfExport="true"
            SelectedView="MonthView"
            DataSourceID="SqlDataSource1"
            ShowCurrentTimeMarker="true">
            <YearView UserSelectable="true" />
            <ExportSettings>
                <Pdf FileName="Proposal_Schedule.pdf"  />
            </ExportSettings>
            <DataBindings>
                <TasksDataBindings IdField="ID" TitleField="Title" StartField="StartDay" EndField="EndDay" ParentIdField="ParentID" SummaryField="Summary" PercentCompleteField="PercentComplete" />
            </DataBindings>
        </telerik:RadGantt>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Proposal_Grantt_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblproposalId" Name="proposalId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblproposalId" runat="server" Visible="false"></asp:Label>
</asp:Content>

