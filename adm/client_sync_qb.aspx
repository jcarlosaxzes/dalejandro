<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="client_sync_qb.aspx.vb" Inherits="pasconcept20.client_sync_qb" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pas-container" style="width: 100%">
        <telerik:RadWizard ID="RadWizardQB" runat="server" DisplayCancelButton="false" DisplayProgressBar="false" DisplayNavigationButtons="false" RenderMode="Lightweight" Skin="Silk">
            <WizardSteps>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep1" Title="Connect To QuickBooks" StepType="Step">
                     <asp:Button ID="btnConnect" runat="server" Text="Connect to QuickBook" OnClick="btnConnect_Click" />&nbsp;&nbsp;  <asp:Label ID="lblResutl" runat="server" Text=""></asp:Label>
   
                </telerik:RadWizardStep>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep2" Title="Sync QuickBooks Customers" StepType="Step">
                </telerik:RadWizardStep>
            </WizardSteps>
        </telerik:RadWizard>
    </div>


         <asp:SqlDataSource ID="SqlDataSourceClientPending" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENT_Sync_QBO_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceQBLinked" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENT_linked_QBO_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
