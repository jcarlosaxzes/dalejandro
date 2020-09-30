<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="proposal_save_copy.aspx.vb" Inherits="pasconcept20.proposal_save_copy" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">
            <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
                       Back
            </asp:LinkButton>
            Save Proposal As
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
                <td>Proposal Number:&nbsp;<asp:Label ID="lblProposalNumber" CssClass="Titulo4Negrita" runat="server" Width="250px"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Project Name:
                        <telerik:RadTextBox ID="txtName" runat="server" LabelWidth="" Width="500px">
                        </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" ErrorMessage="! Project Name is required"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>You <b>Save As</b> a Proposal to:
                </td>
            </tr>
            <tr>
                <td>
                    <asp:RadioButton ID="opcCopiar" runat="server" Text="&nbsp;&nbsp;Create an identical copy and modify it later" Checked="True" GroupName="1" AutoPostBack="True" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:RadioButton ID="opcRevisar" runat="server" Text="&nbsp;&nbsp;Reviewing a previously approved Proposal" GroupName="1" AutoPostBack="True" />
                </td>
            </tr>
        </table>
    </div>
    <asp:Label ID="lblProposalId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblOption" runat="server" Visible="False" Text="0"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="ProposalSaveAsExt" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter DefaultValue="" Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblProposalId" Name="ProposalSourceId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="txtName" Name="ProjectName" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="lblOption" Name="Option" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="ProposalId" Type="Int32" Direction="InputOutput" />
        </InsertParameters>
    </asp:SqlDataSource>

</asp:Content>
