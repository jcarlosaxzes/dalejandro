<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="tandctemplate_form.aspx.vb" Inherits="pasconcept20.tandctemplate_form" %>

<%@ MasterType VirtualPath="~/ADM/BasicMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
        <h3 style="text-align: center">Terms & Conditions</h3>

        <table style="width: 95%" class="table-condensed">

            <tr>
                <td style="width: 150px; text-align: right">Name:
                </td>
                <td>
                    <telerik:RadTextBox ID="NameTextBox" runat="server" MaxLength="80" Width="100%">
                    </telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="NameTextBox" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>

                </td>
            </tr>
            <tr>
                <td style="text-align: right">Descripction:
                </td>
                <td>
                    <telerik:RadEditor ID="gridEditor" runat="server" Height="400px" AllowScripts="True" Width="800px"
                        ToolbarMode="Default" ToolsFile="~/BasicTools.xml" EditModes="All">
                    </telerik:RadEditor>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-primary btn-lg" UseSubmitBehavior="false" CausesValidation="true">
                                                <span class="glyphicon glyphicon-save"></span>&nbsp;Update
                    </asp:LinkButton>

                </td>
            </tr>

        </table>
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="INSERT INTO Proposal_TandCtemplates(Name, Descripction, companyId) VALUES (@Name, @Descripction, @companyId)"
        UpdateCommand="UPDATE Proposal_TandCtemplates SET Name = @Name, Descripction = @Descripction WHERE (Id = @Id)">
        <UpdateParameters>
            <asp:ControlParameter ControlID="NameTextBox" Name="Name" PropertyName="Text" />
            <asp:ControlParameter ControlID="gridEditor" Name="Descripction" PropertyName="Content" />
            <asp:ControlParameter ControlID="lblTemplateId" Name="Id" PropertyName="Text" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="NameTextBox" Name="Name" PropertyName="Text" />
            <asp:ControlParameter ControlID="gridEditor" Name="Descripction" PropertyName="Content" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblTemplateId" runat="server" Visible="False" Text="0"></asp:Label>

</asp:Content>

