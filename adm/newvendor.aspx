﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="newvendor.aspx.vb" Inherits="pasconcept20.newvendor" %>

<%@ MasterType VirtualPath="~/ADM/BasicMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td class="Titulo3">New Vendor
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName"
                    ErrorMessage="(*) Name is Required" Display="Dynamic"></asp:RequiredFieldValidator>
                &nbsp;               
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtCompany"
                    ErrorMessage="(*) Company is Required" Display="Dynamic"></asp:RequiredFieldValidator>

            </td>
        </tr>
    </table>
    <table class="table-condensed">
        <tr>
            <td style="text-align: right; width: 150px">(*) Full Name:
            </td>
            <td>
                <telerik:RadTextBox ID="txtName" runat="server" MaxLength="80" Width="400px" EmptyMessage="Required">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">Company:
            </td>
            <td>
                <telerik:RadTextBox ID="txtCompany" runat="server" MaxLength="80" Width="400px">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right" class="Normal">Type/Subtype:</td>
            <td>
                <telerik:RadComboBox ID="cboType" runat="server" DataSourceID="SqlDataSourceTypes"
                    DataTextField="Name" DataValueField="Id" Width="44%" AppendDataBoundItems="true" AutoPostBack="True">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="(Types Not Defined...)" Value="0" />
                    </Items>
                </telerik:RadComboBox>
                &nbsp;
                <telerik:RadComboBox ID="cboSubtype" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceSubtypes" DataTextField="Name" DataValueField="Id"
                    Width="44%">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="(Subtypes Not Defined...)" Value="0" />
                    </Items>
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">Position:
            </td>
            <td>
                <telerik:RadTextBox ID="txtPosition" runat="server" Width="400px" MaxLength="80">
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
            <td style="text-align: right">Address Line 1:
            </td>
            <td>
                <telerik:RadTextBox ID="txtAdress" runat="server" MaxLength="80" Width="400px">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">Address Line 2:
            </td>
            <td>
                <telerik:RadTextBox ID="txtDireccion2" runat="server" Width="400px" MaxLength="80">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">City:
            </td>
            <td>
                <telerik:RadTextBox ID="txtCity" runat="server" MaxLength="50" Width="400px">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">State:
            </td>
            <td>
                <telerik:RadTextBox ID="txtState" runat="server" MaxLength="50" Width="400px">
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
            <td style="text-align: right">Email:
            </td>
            <td>
                <telerik:RadTextBox ID="txtEmail" runat="server" MaxLength="80" Width="400px">
                </telerik:RadTextBox>

            </td>
        </tr>
        <tr>
            <td style="text-align: right">Phone:
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
            <td style="text-align: right">Fax:
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
                <telerik:RadTextBox ID="txtWeb" runat="server" MaxLength="50" Width="200px">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">Notes:
            </td>
            <td>
                <telerik:RadTextBox ID="txtNotes" runat="server" Text='<%# Bind("Notes") %>' MaxLength="1024"
                    Width="400px" TextMode="MultiLine">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">&nbsp;
            </td>
            <td style="text-align: right">
                <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                    <span class="glyphicon glyphicon-plus"></span> Vendor
                </asp:LinkButton>
            </td>
        </tr>
    </table>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="Vendor_INSERT" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="txtName" Name="Name" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtPosition" Name="Position" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtCompany" Name="Company" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboType" Name="Type" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboSubtype" Name="Subtype" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtAdress" Name="Address" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtDireccion2" Name="Address2" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtCity" Name="City" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtState" Name="State" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtZipCode" Name="ZipCode" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtPhone" Name="Phone" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtCellular" Name="Cellular" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtFax" Name="Fax" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtEmail" Name="Email" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtWeb" Name="Web" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtNotes" Name="Notes" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Direction="InputOutput" Name="Id_OUT" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Vendor_types] Where companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSubtypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Vendor_subtypes] Where typeId=@typeId ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboType" Name="typeId" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployee" runat="server" Visible="False"></asp:Label>
</asp:Content>
