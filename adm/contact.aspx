<%@ Page Title="Contact" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="contact.aspx.vb" Inherits="pasconcept20.contact1" %>

<%@ MasterType VirtualPath="~/ADM/BasicMasterPage.master" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
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
    <telerik:RadPageLayout ID="RadPageLayout1" runat="server" GridType="Fluid">
        <Rows>
            <telerik:LayoutRow>
                <Content>
                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSource1" Width="100%" DefaultMode="Edit">
                        <EditItemTemplate>
                            <table width="740px" class="table-sm">
                                <tr>
                                    <td style="width: 180px;"></td>
                                    <td style="text-align: right; padding-right: 25px">
                                        <telerik:RadButton ID="btnUpdateContact1" runat="server" CausesValidation="True" CommandName="Update" Text="Update Contact">
                                            <Icon PrimaryIconCssClass="rbSave"></Icon>
                                        </telerik:RadButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="Normal">Email:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>'
                                            MaxLength="80" Width="450px">
                                        </telerik:RadTextBox>
                                        <%--<asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="EmailTextBox" ErrorMessage="(*) Invalid Format"></asp:RegularExpressionValidator>--%>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="Normal">Name:
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="NameTextBox"
                                            ErrorMessage="(*)"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="80" Width="450px" EmptyMessage="First Name">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="Normal">Position:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="RadTextBoxPosition" runat="server" Text='<%# Bind("Position") %>' MaxLength="80" Width="450px" EmptyMessage="Position">
                                        </telerik:RadTextBox>


                                    </td>
                                </tr>
                                <tr>
                                    <td class="Normal">Company:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="CompanyTextBox" runat="server" Text='<%# Bind("Company") %>'
                                            MaxLength="80" Width="450px">
                                        </telerik:RadTextBox>

                                    </td>
                                </tr>

                                <tr>
                                    <td style="width: 150px" class="Normal">Class:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cboClass" runat="server" DataSourceID="SqlDataSourceClass"
                                            DataTextField="Name" DataValueField="Id" Width="300px" SelectedValue='<%# Bind("ClassId") %>'>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td style="width: 150px" class="Normal">Type:
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
                                    <td style="width: 150px" class="Normal">Subtype:
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
                                    <td class="Normal">Address Line 1:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="AddressTextBox" runat="server" Text='<%# Bind("Address") %>'
                                            MaxLength="80" Width="450px" CssClass="input-address">
                                        </telerik:RadTextBox>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="Normal">Address Line 2:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="Address2TextBox" runat="server" Text='<%# Bind("Address2") %>'
                                            MaxLength="80" Width="450px">
                                        </telerik:RadTextBox>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="Normal">City:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' MaxLength="50"
                                            Width="250px" CssClass="input-city">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="Normal">State:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="EstateTextBox" runat="server" Text='<%# Bind("State") %>'
                                            MaxLength="50" Width="250px" CssClass="input-state">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="Normal">Zip Code:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="ZipCodeTextBox" runat="server" Text='<%# Bind("ZipCode") %>'
                                            MaxLength="50" CssClass="input-zip">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="Normal">Telephone:
                                    </td>
                                    <td>
                                        <telerik:RadMaskedTextBox ID="PhoneTextBox" runat="server" Text='<%# Bind("Phone") %>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="Normal">Cell Phone:
                                    </td>
                                    <td>
                                        <telerik:RadMaskedTextBox ID="CellularTextBox" runat="server" Text='<%# Bind("Cellular") %>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="Normal">Fax:
                                    </td>
                                    <td>
                                        <telerik:RadMaskedTextBox ID="RadMaskedTextBoxFax" runat="server" Text='<%# Bind("Fax") %>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="Normal">Web:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txtWeb" runat="server" Text='<%# Bind("Web") %>'
                                            MaxLength="80" Width="450px">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="Normal">Business Email:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="RadTextBox1" runat="server" Text='<%# Bind("BusinessEmail") %>'
                                            MaxLength="80" Width="450px">
                                        </telerik:RadTextBox>
                                        <%--<asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="EmailTextBox" ErrorMessage="(*) Invalid Format"></asp:RegularExpressionValidator>--%>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="Normal">Notes:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="NotesTextBox" runat="server" Text='<%# Bind("Notes") %>'
                                            MaxLength="255" Width="450px" TextMode="MultiLine">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td style="text-align: right; padding-right: 25px">
                                        <telerik:RadButton ID="btnUpdate3" runat="server" CausesValidation="True" CommandName="Update" Text="Update Contact">
                                            <Icon PrimaryIconCssClass="rbSave"></Icon>
                                        </telerik:RadButton>
                                    </td>

                                </tr>
                            </table>
                        </EditItemTemplate>

                    </asp:FormView>
                </Content>
            </telerik:LayoutRow>
        </Rows>
    </telerik:RadPageLayout>

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

