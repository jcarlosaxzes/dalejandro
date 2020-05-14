<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="newsubconsultant.aspx.vb" Inherits="pasconcept20.newsubconsultant" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="Formulario">
        <table class="table-condensed" style="width: 100%">
            <tr>
                <td style="width: 120px">
                    <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="false">
                       Cancel
                    </asp:LinkButton>
                </td>
                <td style="text-align: center">
                    <h3 style="margin: 0">New Subconsultant</h3>
                </td>

            </tr>
        </table>
    </div>
    <div>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red"
            Font-Size="X-Small" HeaderText="Following error occurs:" ShowMessageBox="false" DisplayMode="BulletList" ShowSummary="true"
            ValidationGroup="Subconsultant" />

    </div>

    <div class="pas-container">

        <table class="table-condensed" style="width:100%">
            <tr>
                <td style="text-align: right; width: 200px">(*) Full Name:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtName" runat="server" MaxLength="80" Width="90%" EmptyMessage="Required">
                    </telerik:RadTextBox>

                </td>
            </tr>
            <tr>
                <td style="text-align: right">Discipline:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboDiscipline" runat="server" DataSourceID="SqlDataSourceDiscipline"
                        DataTextField="Name" DataValueField="Id" Width="250px">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Position:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtPosition" runat="server" Width="90%" MaxLength="80" EmptyMessage="Position">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Organization:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtCompany" runat="server" MaxLength="80" Width="90%">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">(*) Subconsultant Code:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtInitials" runat="server" MaxLength="5" Width="100px" EmptyMessage="Up to 5 characters">
                    </telerik:RadTextBox>

                </td>
            </tr>
            <tr>
                <td style="text-align: right">(*) Email:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtEmail" runat="server" MaxLength="80" Width="90%" EmptyMessage="Required">
                    </telerik:RadTextBox>

                </td>
            </tr>
            <tr>
                <td style="text-align: right">Full Address:</td>
                <td>
                    <telerik:RadTextBox ID="txtFullAddress" runat="server" EmptyMessage="Address, City, State, Zip"
                        Width="83%">
                    </telerik:RadTextBox>
                    &nbsp;&nbsp;
                <telerik:RadButton ID="btbParseAddress" runat="server" CausesValidation="False" Width="55px" Text="Apply">
                </telerik:RadButton>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Address Line 1:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtAdress" runat="server" MaxLength="80" Width="90%">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Address Line 2:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtDireccion2" runat="server" Width="90%" MaxLength="80">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">City:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtCity" runat="server" MaxLength="50" Width="90%">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">State:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtState" runat="server" MaxLength="50" Width="90%">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Zip Code:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtZipCode" runat="server" MaxLength="50" Width="100px">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Telephone:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtPhone" runat="server" MaxLength="25" Width="200px">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Cell Phone:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtCellular" runat="server" MaxLength="25" Width="200px">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Facsimile:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtFax" runat="server" MaxLength="25" Width="200px">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Web Page:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtWeb" runat="server" MaxLength="50" Width="90%">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Date Created:
                </td>
                <td>
                    <telerik:RadDatePicker ID="RadDatePickerStartingDate" runat="server" Culture="English (United States)"
                        MaxDate="2029-12-31" MinDate="1960-01-01">
                        <DatePopupButton></DatePopupButton>
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Billing Contact:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtBillingContact" runat="server" MaxLength="80" Width="90%">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Billing Telephone:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtBillingTelephone" runat="server" MaxLength="25" Width="90%">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Notes:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtNotes" runat="server" Text='<%# Bind("Notes") %>' MaxLength="1024"
                        Width="90%" TextMode="MultiLine">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn-lg" UseSubmitBehavior="false" CausesValidation="true" ValidationGroup="Subconsultant">
                    Create Subconsultant
                    </asp:LinkButton>
                </td>
            </tr>
        </table>

        <div>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" ValidationGroup="Subconsultant"
                ErrorMessage="Name is Required" Display="None"></asp:RequiredFieldValidator>
            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtInitials" ValidationGroup="Subconsultant"
                ErrorMessage="Subconsultant code is required" Display="None"></asp:RequiredFieldValidator>
            <br />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtEmail" ValidationGroup="Subconsultant"
                runat="server" ErrorMessage="(*) Enter an valid email address" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                Display="None"></asp:RegularExpressionValidator>
            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmail" ValidationGroup="Subconsultant"
                ErrorMessage="Email is Required" Display="None"></asp:RequiredFieldValidator>

        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSourceDiscipline" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, companyId, Name FROM SubConsultans_disciplines WHERE (companyId = @companyId) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployee" runat="server" Visible="False"></asp:Label>
</asp:Content>
