<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="proposal_save_as_template.aspx.vb" Inherits="pasconcept20.proposal_save_as_template" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">
            <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
                       Back
            </asp:LinkButton>
            Save Proposal As Template
        </span>
        <span style="float: right; vertical-align: middle;">

            <asp:LinkButton ID="btnOk" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false">
                    Save and Back
            </asp:LinkButton>

        </span>

    </div>
     <div class="pas-container" style="padding-left: 50px">
        
        <table class="table-sm" style="width: 800px">
            <tr>
                <td style="text-align: center;">You can save the Proposal as a Template (Proposal Type) for later use when creating New Proposal
                        <br />
                </td>
            </tr>
            <tr>
                <td style="padding-top: 10px">Proposal Number:&nbsp;<asp:Label ID="lblProposalNumber" CssClass="Titulo4Negrita" runat="server" Width="250px"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Template Name:
                        <telerik:RadTextBox ID="txtName" runat="server" LabelWidth="" Width="500px">
                        </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" ErrorMessage="! Template Name is required"></asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
    </div>
    <asp:Label ID="lblProposalId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblOption" runat="server" Visible="False" Text="0"></asp:Label>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="PROPOSAL_SaveAsTEMPLATE_Task" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:ControlParameter ControlID="lblProposalId" Name="ProposalId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="txtName" Name="TemplateName" PropertyName="Text" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>
