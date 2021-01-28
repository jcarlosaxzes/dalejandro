<%@ Page Title="Terms & Conditions" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterPROPOSAL.Master" CodeBehind="pro_termandconditions.aspx.vb" Inherits="pasconcept20.pro_termandconditions" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/adm/MasterPROPOSAL.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">Terms & Conditions</span>
        <span style="float: right; vertical-align: middle;">
            <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" ToolTip="Update">
                Update
            </asp:LinkButton>
        </span>
    </div>
    <div>
        <table class="table-sm" style="width: 100%;">
            <tr>
                <td style="text-align: right; width: 180px">Select Template:
                </td>
                <td style="width: 500px">
                    <telerik:RadComboBox ID="cboTandCtemplates" runat="server" DataSourceID="SqlDataSourceTandCtemplates"
                        DataTextField="Name" DataValueField="Id" Width="100%" MarkFirstMatch="True" AppendDataBoundItems="true"
                        Filter="Contains"
                        ToolTip="Select Terms & Conditions to define first time or modify the current">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select other Terms & Conditions...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td>
                    <asp:LinkButton ID="btnGenerateTandC" runat="server" CssClass="btn btn-success" UseSubmitBehavior="false"
                        ToolTip="Define Payment Schedules" CausesValidation="false">
                                            Apply
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DefaultMode="Edit" DataSourceID="SqlDataSource1" Width="100%" EnableViewState="false">
            <EditItemTemplate>
                <div>
                    <telerik:RadEditor ID="radEditorTerms" runat="server" Content='<%# Bind("Agreements") %>'
                        Height="700px" ToolsFile="~/BasicTools.xml" AllowScripts="True" EditModes="Design,Preview" RenderMode="Auto"
                        Width="100%">
                    </telerik:RadEditor>
                </div>
            </EditItemTemplate>
        </asp:FormView>
        
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Agreements FROM Proposal WHERE (Id = @Id)"
        UpdateCommand="Proposal_TC_Ext_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="Id" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Agreements" Type="String" />
            <asp:ControlParameter ControlID="lblProposalId" Name="Id" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTandCtemplates" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM [Proposal_TandCtemplates] WHERE ([companyId] = @companyId) ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceProposalTCUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        UpdateCommand="Proposal_TC_v20_UPDATE" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:ControlParameter ControlID="cboTandCtemplates" Name="termandconditionsId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblProposalId" Name="Id" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblProposalId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblOriginalStatus" runat="server" Visible="False"></asp:Label>
</asp:Content>
