<%@ Page Title="Save Proposal As" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="saveproposalas.aspx.vb" Inherits="pasconcept20.saveproposalas" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pas-container" style="padding-left: 50px">
        <h2>Save Proposal As</h2>
        <table class="table-condensed" style="width: 800px">
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
                    <asp:RadioButton ID="opcCopiar" runat="server" Text="Create an identical copy and modify it later" Checked="True" GroupName="1" AutoPostBack="True" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:RadioButton ID="opcRevisar" runat="server" Text="Reviewing a previously approved Proposal" GroupName="1" AutoPostBack="True" />
                </td>
            </tr>
            <tr>
                <td style="text-align: center">
                    <telerik:RadButton ID="btnOk" runat="server" Text="Ok" Primary="true">
                        <Icon PrimaryIconCssClass="rbOk"></Icon>
                    </telerik:RadButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <telerik:RadButton ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False">
                        </telerik:RadButton>
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
