<%@ Page Title="Contact" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="contact.aspx.vb" Inherits="pasconcept20.contact" %>

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
        <div>
            <asp:ValidationSummary ID="vsClient" runat="server" ValidationGroup="Contact" ForeColor="Red"
                HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were this errors:"></asp:ValidationSummary>
        </div>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSource1" Width="100%" DefaultMode="Edit">
            <EditItemTemplate>
                <div class="pasconcept-bar">
                    <span class="pasconcept-pagetitle">
                        <a href="contacts.aspx" class="btn btn-dark">Back to List
                        </a>
                        Contact
                    </span>
                    <span style="float: right; vertical-align: middle;">
                        <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="True" CommandName="Update" ValidationGroup="Contact">
                            Update
                        </asp:LinkButton>
                    </span>
                </div>
                <table class="table-sm" style="width: 100%">
                    <tr>
                        <td style="text-align: right; width: 180px">Email:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>'
                                MaxLength="80" Width="100%">
                            </telerik:RadTextBox>

                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Name:
                                        
                        </td>
                        <td>
                            <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="80" Width="100%" EmptyMessage="First Name">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Position:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="RadTextBoxPosition" runat="server" Text='<%# Bind("Position") %>' MaxLength="80" Width="100%" EmptyMessage="Position">
                            </telerik:RadTextBox>


                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Company:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="CompanyTextBox" runat="server" Text='<%# Bind("Company") %>'
                                MaxLength="80" Width="100%">
                            </telerik:RadTextBox>

                        </td>
                    </tr>

                    <tr>
                        <td style="text-align: right">Class:
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cboClass" runat="server" DataSourceID="SqlDataSourceClass"
                                DataTextField="Name" DataValueField="Id" Width="300px" SelectedValue='<%# Bind("ClassId") %>'>
                            </telerik:RadComboBox>
                        </td>
                    </tr>

                    <tr>
                        <td style="text-align: right">Type:
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cboType" runat="server" DataSourceID="SqlDataSourceTypes"
                                DataTextField="Name" DataValueField="Id" Width="300px" SelectedValue='<%# Bind("Type") %>' AppendDataBoundItems="true" AutoPostBack="True">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(Types Not Defined...)" Value="0" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Subtype:
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cboSubtype" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceSubtypes" DataTextField="Name" DataValueField="Id"
                                SelectedValue='<%# DataBinder.Eval(Container.DataItem, "Subtype")%>' Width="300px">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(Subtypes Not Defined...)" Value="0" />
                                </Items>
                            </telerik:RadComboBox>
                            <asp:SqlDataSource ID="SqlDataSourceSubtypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
                                SelectCommand="SELECT [Id], [Name] FROM [Contact_subtypes] Where typeId=@typeId ORDER BY Name">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="cboType" Name="typeId" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Address Line 1:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="AddressTextBox" runat="server" Text='<%# Bind("Address") %>'
                                MaxLength="80" Width="100%" CssClass="input-address">
                            </telerik:RadTextBox>

                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Address Line 2:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="Address2TextBox" runat="server" Text='<%# Bind("Address2") %>'
                                MaxLength="80" Width="100%">
                            </telerik:RadTextBox>

                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">City:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' MaxLength="50"
                                Width="250px" CssClass="input-city">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">State:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="EstateTextBox" runat="server" Text='<%# Bind("State") %>'
                                MaxLength="50" Width="250px" CssClass="input-state">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Zip Code:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="ZipCodeTextBox" runat="server" Text='<%# Bind("ZipCode") %>'
                                MaxLength="50" CssClass="input-zip">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Telephone:
                        </td>
                        <td>
                            <telerik:RadMaskedTextBox ID="PhoneTextBox" runat="server" Text='<%# Bind("Phone") %>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Cell Phone:
                        </td>
                        <td>
                            <telerik:RadMaskedTextBox ID="CellularTextBox" runat="server" Text='<%# Bind("Cellular") %>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Fax:
                        </td>
                        <td>
                            <telerik:RadMaskedTextBox ID="RadMaskedTextBoxFax" runat="server" Text='<%# Bind("Fax") %>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Web:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtWeb" runat="server" Text='<%# Bind("Web") %>'
                                MaxLength="80" Width="100%">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Business Email:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="RadTextBox1" runat="server" Text='<%# Bind("BusinessEmail") %>'
                                MaxLength="80" Width="100%">
                            </telerik:RadTextBox>
                            <%--<asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="EmailTextBox" ErrorMessage="(*) Invalid Format"></asp:RegularExpressionValidator>--%>

                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Notes:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="NotesTextBox" runat="server" Text='<%# Bind("Notes") %>'
                                MaxLength="255" Width="100%" TextMode="MultiLine">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                </table>
                <div>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="NameTextBox" Display="None" ValidationGroup="Contact" ErrorMessage="Name is required"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="EmailTextBox" ErrorMessage="Invalid Format" ValidationGroup="Contact"></asp:RegularExpressionValidator>
                </div>

            </EditItemTemplate>

        </asp:FormView>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        UpdateCommand="Contact_UPDATE"
        SelectCommand="Contact_SELECT" SelectCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblContactId" Name="Id" PropertyName="Text" Type="Int32" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Company" Type="String" />
            <asp:Parameter Name="Position" Type="String" />
            <asp:Parameter Name="ClassId" />
            <asp:Parameter Name="Type" />
            <asp:Parameter Name="Subtype" />
            <asp:Parameter Name="Address" Type="String" />
            <asp:Parameter Name="Address2" Type="String" />
            <asp:Parameter Name="City" Type="String" />
            <asp:Parameter Name="State" Type="String" />
            <asp:Parameter Name="ZipCode" Type="String" />
            <asp:Parameter Name="Phone" Type="String" />
            <asp:Parameter Name="Cellular" Type="String" />
            <asp:Parameter Name="Fax" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="BusinessEmail" Type="String" />
            <asp:Parameter Name="Web" Type="String" />
            <asp:Parameter Name="Notes" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Select Id, Name from Company_Department where companyId=@companyId Order By Name">
        <SelectParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePosition" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Select Id, Name from Contacts_Position where companyId=@companyId Order By Name">
        <SelectParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClass" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Select Id, Name from Contacts_class Order By Name"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceBoss" runat="server"
        ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, FullName As Name From Contacts Where companyId=@companyId Order By FullName">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Contact_types] Where companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblContactId" runat="server" Visible="False"></asp:Label>
</asp:Content>
