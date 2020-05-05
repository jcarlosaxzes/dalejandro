<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="saveproposalastemplate.aspx.vb" Inherits="pasconcept20.saveproposalastemplate" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Save Proposal As Template</title>
</head>
<body>
    <script src="../jscript.js" type="text/javascript"></script>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        </telerik:RadScriptManager>
        <div style="padding-left: 20px; padding-top: 15px">
            <table width="470px">
                <tr>
                    <td style="padding-top:15px; text-align: center;" class="Normal">
                        You can save the Proposal as a Template (Proposal Type) for later use when creating New Proposal
                        <br />
                    </td>
                </tr>
                <tr>
                    <td style="padding-top:10px">Proposal Number:&nbsp;<asp:Label ID="lblProposalNumber" CssClass="Titulo4Negrita" runat="server" Width="250px"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="padding-top:15px">Template Name:
                        <telerik:RadTextBox ID="txtName" runat="server" LabelWidth="" Width="360px">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td style="padding-left: 30px;">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" ErrorMessage="! Template Name is required"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="height: 20px;">&nbsp;
                    </td>
                </tr>
                <tr>
                    <td style="height: 30px; vertical-align: bottom; text-align: center">
                        <telerik:RadButton ID="btnOk" runat="server" Text="Ok" >
                            <Icon PrimaryIconCssClass="rbOk" PrimaryIconLeft="4"  PrimaryIconTop="4"></Icon>
                        </telerik:RadButton>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <telerik:RadButton ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False" OnClientClicking="CerrarDialogo">
                            <Icon PrimaryIconCssClass="rbCancel" PrimaryIconLeft="4"  PrimaryIconTop="4"></Icon>
                        </telerik:RadButton>
                    </td>
                </tr>
            </table>
        </div>
        <asp:Label ID="lblProposalId" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblOption" runat="server" Visible="False" Text="0"></asp:Label>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>" 
            InsertCommand="PROPOSAL_SaveAsTEMPLATE" InsertCommandType="StoredProcedure">
         <InsertParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:ControlParameter ControlID="lblProposalId" Name="ProposalId" PropertyName="Text" Type="Int32" />
             <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
             <asp:ControlParameter ControlID="txtName" Name="TemplateName" PropertyName="Text" Type="String" />
        </InsertParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
