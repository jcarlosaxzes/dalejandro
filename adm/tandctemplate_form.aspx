<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="tandctemplate_form.aspx.vb" Inherits="pasconcept20.tandctemplate_form" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="Formulario">
        <table class="table-condensed" style="width: 100%">
            <tr>
                <td style="width: 120px">
                    <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="false">
                       Back to List
                    </asp:LinkButton>
                </td>
                <td style="text-align: center">
                    <h3 style="margin: 0">Terms & Conditions</h3>
                </td>

            </tr>
        </table>
    </div>
     <div>
        <asp:ValidationSummary ID="vsPre_Project" runat="server" ValidationGroup="TandC"
            HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were errors on this step:"></asp:ValidationSummary>
    </div>
    <div class="pas-container">

        <table style="width: 99%" class="table-condensed">

            <tr>
                <td style="width: 150px; text-align: right">Name:
                </td>
                <td>
                    <telerik:RadTextBox ID="NameTextBox" runat="server" MaxLength="80" Width="100%">
                    </telerik:RadTextBox>
                    

                </td>
            </tr>
            <tr>
                <td style="text-align: right">Descripction:
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="margin-left:15px">
                    <telerik:RadEditor ID="gridEditor" runat="server" Height="800px" AllowScripts="True" Width="100%"
                        ToolbarMode="Default" ToolsFile="~/BasicTools.xml" EditModes="All">
                    </telerik:RadEditor>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" CausesValidation="true" ValidationGroup="TandC">
                                                <span class="glyphicon glyphicon-save"></span>&nbsp;Update
                    </asp:LinkButton>

                </td>
            </tr>

        </table>
    </div>
    <div>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="NameTextBox" 
            ErrorMessage=" Name is required" Display="None" ValidationGroup="TandC"></asp:RequiredFieldValidator>
    </div>
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

