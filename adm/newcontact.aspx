﻿<%@ Page Title="New Contact" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="newcontact.aspx.vb" Inherits="pasconcept20.newcontact" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLuxW5zYQh_ClJfDEBpTLlT_tf8JVcxf0&libraries=places&callback=initAutocomplete"
            async defer></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.0/jquery.mask.min.js"></script>
        <script>
            // Autocompletes all address inputs using google maps js api
            function initAutocomplete() {
                // Address Fields
                var addressInput = document.getElementsByClassName("input-address")[0];
                var cityInput = document.getElementsByClassName("input-city")[0];
                var stateInput = document.getElementsByClassName("input-state")[0];
                var zipInput = document.getElementsByClassName("input-zip")[0];
                // autocomplete var
                var autocomplete = new google.maps.places.Autocomplete(addressInput);

                autocomplete.addListener('place_changed', function () {
                    var place = autocomplete.getPlace();
                    var components = place.address_components;
                    // Getting all separate fields from place object
                    var loader = {
                        locality: '',
                        administrative_area_level_1: '',
                        postal_code: '',
                        street_number: '',
                        route: '',
                        subpremise: ''
                    }
                    for (var i = 0; i < components.length; i++) {
                        var ac = components[i];
                        var types = ac.types;
                        if (types) {
                            t = types[0];
                            loader[t] = ac.short_name;
                        }
                    }

                    // Setting results
                    cityInput.value = loader.locality;
                    stateInput.value = loader.administrative_area_level_1;
                    zipInput.value = loader.postal_code;
                    // Just mandatory formats for address_line
                    // route
                    if (loader.route !== '')
                        loader.route = ' ' + loader.route;
                    // apt number
                    if (loader.subpremise !== '')
                        load.subpremise = ' #' + loader.subpremise
                    // complete address line
                    addressInput.value = loader.street_number + loader.route + loader.subpremise;
                });
            }
        </script>
    </telerik:RadCodeBlock>
    <div>
            <asp:ValidationSummary ID="vsClient" runat="server" ValidationGroup="Contact" ForeColor="Red"
                HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were this errors:"></asp:ValidationSummary>
        </div>

    <span class="pasconcept-pagetitle">
        <a href="contacts.aspx" class="btn btn-dark">Cancel
        </a>
        New Contact
    </span>

    <span style="float: right; vertical-align: middle;">
        <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" ValidationGroup="Contact" CausesValidation="true" >
                                        Add Contact
                </asp:LinkButton>
    </span>


    <table style="width: 100%" class="table-sm">
        <tr>
            <td class="Normal" style="width: 140px; text-align: right">(*) Full Name:
            </td>
            <td>
                <telerik:RadTextBox ID="txtName" runat="server" MaxLength="80" Width="100%" EmptyMessage="Required">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td class="Normal" style="text-align: right">Position:
            </td>
            <td>
                <telerik:RadTextBox ID="txtPosition" runat="server" Width="100%" MaxLength="80">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right" class="Normal">Company:
            </td>
            <td>
                <telerik:RadTextBox ID="txtCompany" runat="server" MaxLength="80" Width="100%">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right" class="auto-style2">Email:
            </td>
            <td class="auto-style2">
                <telerik:RadTextBox ID="txtEmail" runat="server" MaxLength="80" Width="100%" >
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right" class="auto-style2">Business Email:
            </td>
            <td class="auto-style2">
                <telerik:RadTextBox ID="txtBusinessEmail" runat="server" MaxLength="80" Width="100%" >
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right" class="Normal">Type/Subtype:</td>
            <td>
                <telerik:RadComboBox ID="cboType" runat="server" DataSourceID="SqlDataSourceTypes"
                    DataTextField="Name" DataValueField="Id" Width="200px" AppendDataBoundItems="true" AutoPostBack="True">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="(Types Not Defined...)" Value="0" />
                    </Items>
                </telerik:RadComboBox>
                &nbsp;
                <telerik:RadComboBox ID="cboSubtype" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceSubtypes" DataTextField="Name" DataValueField="Id"
                    Width="200px">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="(Subtypes Not Defined...)" Value="0" />
                    </Items>
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right" class="Normal">Address Line 1:
            </td>
            <td>
                <telerik:RadTextBox ID="txtAdress" runat="server" MaxLength="80" Width="100%" CssClass="input-address">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right" class="Normal">Address Line 2:
            </td>
            <td>
                <telerik:RadTextBox ID="txtDireccion2" runat="server" Width="100%" MaxLength="80">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right" class="Normal">City/State/Zip Code:
            </td>
            <td>
                <telerik:RadTextBox ID="txtCity" runat="server" MaxLength="50" Width="50%" ToolTip="City" EmptyMessage="City" CssClass="input-city">
                </telerik:RadTextBox>
                <telerik:RadTextBox ID="txtState" runat="server" MaxLength="50" Width="150px" ToolTip="State" EmptyMessage="State" CssClass="input-state">
                </telerik:RadTextBox>
                <telerik:RadTextBox ID="txtZipCode" runat="server" MaxLength="50" Width="150px" EmptyMessage="Zip Code" CssClass="input-zip">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right" class="Normal">Phone/Cell:
            </td>
            <td>
                <telerik:RadMaskedTextBox ID="txtPhone" runat="server" Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" Width="300px" ToolTip="Phone" />
                <telerik:RadMaskedTextBox ID="txtCellular" runat="server" Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" Width="300px" ToolTip="Cell" />
            </td>
        </tr>
        
        <tr>
            <td style="text-align: right" class="Normal">Web Page:
            </td>
            <td>
                <telerik:RadTextBox ID="txtWeb" runat="server" MaxLength="50" Width="100%">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right" class="auto-style2">Notes:
            </td>
            <td class="auto-style2">
                <telerik:RadTextBox ID="txtNotes" runat="server" MaxLength="80" Width="100%" >
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right" class="Normal">&nbsp;
            </td>
            <td>
                
            </td>
        </tr>
    </table>

    <div>
         <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" ErrorMessage="Name is Required" Display="None"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtEmail" ErrorMessage="Invalid Email Format" ValidationGroup="Contact"></asp:RegularExpressionValidator>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="Contact_INSERT" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:ControlParameter ControlID="txtName" Name="Name" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtCompany" Name="Company" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtPosition" Name="Position" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="cboType" Name="Type" PropertyName="SelectedValue" Type="Int16" />
            <asp:ControlParameter ControlID="cboSubtype" Name="Subtype" PropertyName="SelectedValue" Type="Int16" />
            <asp:ControlParameter ControlID="txtAdress" Name="Address" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtDireccion2" Name="Address2" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtCity" Name="City" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtState" Name="State" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtZipCode" Name="ZipCode" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtPhone" Name="Phone" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtCellular" Name="Cellular" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtEmail" Name="Email" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtWeb" Name="Web" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtBusinessEmail" Name="BusinessEmail" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtNotes" Name="Notes" PropertyName="Text" Type="String" />
            
        </InsertParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSourceSubtypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Contact_subtypes] Where typeId=@typeId ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboType" Name="typeId" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Contact_types] Where companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployee" runat="server" Visible="False"></asp:Label>
</asp:Content>
