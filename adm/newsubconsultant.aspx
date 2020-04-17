<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="newsubconsultant.aspx.vb" Inherits="pasconcept20.newsubconsultant" %>

<%@ MasterType VirtualPath="~/ADM/BasicMasterPage.master" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="text-align: center; padding-top: 15px; padding-bottom: 15px; width: 125px">
                <asp:Image ID="Image8" runat="server"
                    ImageUrl="~/Images/Toolbar/new-subconsultant-256.jpg" Width="64px" />
            </td>
            <td class="Titulo3">New Subconsultant
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName"
                    ErrorMessage="(*) Name is Required" Display="Dynamic"></asp:RequiredFieldValidator>
                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtInitials"
                    ErrorMessage=" (*) Subconsultant code is required"></asp:RequiredFieldValidator>
                <br />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtEmail"
                    runat="server" ErrorMessage="(*) Enter an valid email address" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                    Display="Dynamic"></asp:RegularExpressionValidator>
                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="(*) Email is Required" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>
    <table class="table-condensed" >
        <tr>
            <td style="text-align:right;width:150px">(*) Full Name:
            </td>
            <td>
                <telerik:RadTextBox ID="txtName" runat="server" MaxLength="80" Width="400px" EmptyMessage="Required">
                </telerik:RadTextBox>

            </td>
        </tr>
        <tr>
            <td style="text-align:right"> Discipline:
            </td>
            <td>
                <telerik:RadComboBox ID="cboDiscipline" runat="server" DataSourceID="SqlDataSourceDiscipline"
                    DataTextField="Name" DataValueField="Id" Width="250px">
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td style="text-align:right"> Position:
            </td>
            <td>
                <telerik:RadTextBox ID="txtPosition" runat="server" Width="400px" MaxLength="80" EmptyMessage="Position">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align:right">Organization:
            </td>
            <td>
                <telerik:RadTextBox ID="txtCompany" runat="server" MaxLength="80" Width="400px">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align:right">(*) Subconsultant Code:
            </td>
            <td>
                <telerik:RadTextBox ID="txtInitials" runat="server" MaxLength="5" Width="100px" EmptyMessage="Up to 5 characters">
                </telerik:RadTextBox>

            </td>
        </tr>
        <tr>
            <td style="text-align:right">(*) Email:
            </td>
            <td>
                <telerik:RadTextBox ID="txtEmail" runat="server" MaxLength="80" Width="400px" EmptyMessage="Required">
                </telerik:RadTextBox>

            </td>
        </tr>
        <tr>
            <td align="right" class="Normal" style="width: 150px">Full Address:</td>
            <td>
                <telerik:RadTextBox ID="txtFullAddress" runat="server" EmptyMessage="Address, City, State, Zip"
                    Width="400px">
                </telerik:RadTextBox>
                &nbsp;&nbsp;
                <telerik:RadButton ID="btbParseAddress" runat="server" CausesValidation="False" Width="55px" Text="Apply">
                </telerik:RadButton>
            </td>
        </tr>
        <tr>
            <td style="text-align:right">Address Line 1:
            </td>
            <td>
                <telerik:RadTextBox ID="txtAdress" runat="server" MaxLength="80" Width="400px">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align:right">Address Line 2:
            </td>
            <td>
                <telerik:RadTextBox ID="txtDireccion2" runat="server" Width="400px" MaxLength="80">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align:right">City:
            </td>
            <td>
                <telerik:RadTextBox ID="txtCity" runat="server" MaxLength="50" Width="400px">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align:right">State:
            </td>
            <td>
                <telerik:RadTextBox ID="txtState" runat="server" MaxLength="50" Width="400px">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align:right">Zip Code:
            </td>
            <td>
                <telerik:RadTextBox ID="txtZipCode" runat="server" MaxLength="50" Width="100px">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align:right">Telephone:
            </td>
            <td>
                <telerik:RadTextBox ID="txtPhone" runat="server" MaxLength="25" Width="200px">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align:right">Cell Phone:
            </td>
            <td>
                <telerik:RadTextBox ID="txtCellular" runat="server" MaxLength="25" Width="200px">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align:right">Facsimile:
            </td>
            <td>
                <telerik:RadTextBox ID="txtFax" runat="server" MaxLength="25" Width="200px">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align:right">Web Page:
            </td>
            <td>
                <telerik:RadTextBox ID="txtWeb" runat="server" MaxLength="50" Width="200px">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align:right">Date Created:
            </td>
            <td>
                <telerik:RadDatePicker ID="RadDatePickerStartingDate" runat="server" Culture="English (United States)"
                    MaxDate="2029-12-31" MinDate="1960-01-01">
                    <DateInput DateFormat="MM/dd/yyyy" DisplayDateFormat="MM/dd/yyyy">
                    </DateInput>
                    <Calendar>
                    </Calendar>
                    <DatePopupButton></DatePopupButton>
                </telerik:RadDatePicker>
            </td>
        </tr>
        <tr>
            <td style="text-align:right">Billing Contact:
            </td>
            <td>
                <telerik:RadTextBox ID="txtBillingContact" runat="server" MaxLength="80" Width="400px">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align:right">Billing Telephone:
            </td>
            <td>
                <telerik:RadTextBox ID="txtBillingTelephone" runat="server" MaxLength="25" Width="400px">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align:right">Notes:
            </td>
            <td>
                <telerik:RadTextBox ID="txtNotes" runat="server" Text='<%# Bind("Notes") %>' MaxLength="1024"
                    Width="400px" TextMode="MultiLine">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align:right">&nbsp;
            </td>
            <td style="text-align:right">
                 <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                    <span class="glyphicon glyphicon-plus"></span> Subconsultant
                </asp:LinkButton>
            </td>
        </tr>
    </table>
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
