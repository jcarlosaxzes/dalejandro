<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="saveproposalas.aspx.vb" Inherits="pasconcept20.SaveProposalAs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Save Proposal As</title>
</head>
<body>
    <script src="../jscript.js" type="text/javascript"></script>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" EnableCdn="true" runat="server">
        </telerik:RadScriptManager>
        <div style="padding-left: 20px; padding-top: 20px">
            <table width="470px">
                <tr>
                    <td style="padding-top:15px">Proposal Number:&nbsp;<asp:Label ID="lblProposalNumber" CssClass="Titulo4Negrita" runat="server" Width="250px"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="padding-top:15px">Project Name:
                        <telerik:RadTextBox ID="txtName" runat="server" LabelWidth="" Width="350px">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td style="padding-left: 30px;">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" ErrorMessage="! Project Name is required"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="height: 20px;">You <b>Save As</b> a Proposal to:
                    </td>
                </tr>
                <tr>
                    <td style="padding-left: 30px; padding-top: 5px">
                        <asp:RadioButton ID="opcCopiar" runat="server" Text="Create an identical copy and modify it later" Checked="True" GroupName="1" AutoPostBack="True" />
                    </td>
                </tr>
                <tr>
                    <td style="padding-left: 30px; padding-top: 5px">
                        <asp:RadioButton ID="opcRevisar" runat="server" Text="Reviewing a previously approved Proposal" GroupName="1" AutoPostBack="True" />
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
    </form>
</body>
</html>
