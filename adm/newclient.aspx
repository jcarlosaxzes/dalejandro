<%@ Page Title="New Client" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="newclient.aspx.vb" Inherits="pasconcept20.newclient" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
    <div class="pasconcept-bar">
        <table class="table-sm" style="width: 100%">
            <tr>
                <td style="width: 120px">
                    <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
                       Cancel
                    </asp:LinkButton>
                </td>
                <td style="text-align:center">
                    <h3 style="margin:0">New Client</h3>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <asp:ValidationSummary ID="vsClient" runat="server" ValidationGroup="UpdateClient" ForeColor="Red"
            HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were this errors:"></asp:ValidationSummary>
    </div>
    <div class="pasconcept-bar">
        <table style="width: 100%" class="table-sm">
            <tr>
                <td style="width: 200px; text-align: right">Source:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboSource" runat="server" DataSourceID="SqlDataSourceClientSources" AllowCustomText="true" AppendDataBoundItems="true"
                        MarkFirstMatch="True" Filter="Contains" DataTextField="Name" Width="300px" DataValueField="Id">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Client Source Not Defined...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>

            <tr>
                <td style="text-align: right">(*) Full Name:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtName" runat="server" MaxLength="80" Width="90%" EmptyMessage="Required">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Position:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtPosition" runat="server" Width="90%" MaxLength="80">
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
                <td style="text-align: right" class="auto-style2">(*) Email:
                </td>
                <td class="auto-style2">
                    <telerik:RadTextBox ID="txtEmail" runat="server" MaxLength="80" Width="90%" EmptyMessage="Required">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Type/Subtype:</td>
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
                <td style="text-align: right"><a href="https://www.census.gov/eos/www/naics/" target="_blank">NAICS</a> US Code:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboNAICS" runat="server" DataSourceID="SqlDataSourceNAICS"
                        DataTextField="CodeAndTitle" DataValueField="Code" Width="90%"
                        AppendDataBoundItems="true" MarkFirstMatch="True" Filter="Contains">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(NAICS Code Not Defined...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>

                </td>
            </tr>

            <tr>
                <td style="text-align: right">Address Line 1:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtAdress" runat="server" MaxLength="80" Width="90%" CssClass="input-address">
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
                <td style="text-align: right">City/State/Zip Code::
                </td>
                <td>
                    <telerik:RadTextBox ID="txtCity" runat="server" MaxLength="50" Width="200px" ToolTip="City" EmptyMessage="City" CssClass="input-city">
                    </telerik:RadTextBox>
                    <telerik:RadTextBox ID="txtState" runat="server" MaxLength="50" Width="100px" ToolTip="State" EmptyMessage="State" CssClass="input-state">
                    </telerik:RadTextBox>
                    <telerik:RadTextBox ID="txtZipCode" runat="server" MaxLength="50" Width="100px" EmptyMessage="Zip Code" CssClass="input-zip">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Phone/Cell:
                </td>
                <td>
                    <telerik:RadMaskedTextBox ID="txtPhone" runat="server" Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" Width="200px" ToolTip="Phone" />
                    <telerik:RadMaskedTextBox ID="txtCellular" runat="server" Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" Width="200px" ToolTip="Cell" />
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
                <td style="text-align: right">Billing Contact:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtBillingContact" runat="server" MaxLength="80" Width="90%" EmptyMessage="Name...">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Billing Phone/Email:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtBillingTelephone" runat="server" MaxLength="25" Width="200px" EmptyMessage="Phone...">
                    </telerik:RadTextBox>
                    <telerik:RadTextBox ID="txtBillingEmail" runat="server" MaxLength="80" Width="395px" EmptyMessage="Email...">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Client Code:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtInitials" runat="server" MaxLength="16" Width="150px" EmptyMessage="Up to 16 characters">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">TAGs:
                </td>
                <td>
                    <telerik:RadAutoCompleteBox RenderMode="Lightweight" ID="cboTags" runat="server" EnableClientFiltering="true" Width="90%"
                        DropDownHeight="150" DataSourceID="SqlDataSourceTags" DataTextField="Tag" EmptyMessage="Add Tags"
                        DataValueField="Tag">
                    </telerik:RadAutoCompleteBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center">
                    <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" CausesValidation="true" ValidationGroup="UpdateClient">
                                        Create Client
                    </asp:LinkButton>

                </td>
            </tr>
        </table>
    </div>
    <div>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName"
            ErrorMessage="(*) Name is Required" Display="None" ValidationGroup="UpdateClient"></asp:RequiredFieldValidator>
        <br />
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ValidationGroup="UpdateClient" ControlToValidate="txtEmail"
            runat="server" ErrorMessage="(*) Enter a valid email address" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
            Display="None"></asp:RegularExpressionValidator>
        <br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmail" ValidationGroup="UpdateClient"
            ErrorMessage="(*) Email is Required" Display="None"></asp:RequiredFieldValidator>
        <br />
        <br />
        <asp:CompareValidator runat="server" ID="Comparevalidator1" Operator="NotEqual" ValidationGroup="UpdateClient"
            ControlToValidate="cboSource"
            ValueToCompare="(Client Source Not Defined...)"
            ErrorMessage="(*) You must select Client Source!"
            Display="None">
        </asp:CompareValidator>

    </div>
    <asp:SqlDataSource ID="SqlDataSourceSubtypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Clients_Subtypes] Where typeId=@typeId ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboType" Name="typeId" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <telerik:RadDatePicker ID="RadDatePickerStartingDate" runat="server" Culture="English (United States)" Visible="false"
        MaxDate="2029-12-31" MinDate="1960-01-01">
        <DatePopupButton></DatePopupButton>
    </telerik:RadDatePicker>
    <asp:SqlDataSource ID="SqlDataSourceTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Clients_types] Where companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTags" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENT_TAGS_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClientSources" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Clients_sources] ORDER BY [Id]"></asp:SqlDataSource>
    
    <asp:SqlDataSource ID="SqlDataSourceNAICS" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="NAICS_US_Codes_FromCombobox_SELECT" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblBackSource" runat="server" Visible="False" Text="0"></asp:Label>
</asp:Content>
