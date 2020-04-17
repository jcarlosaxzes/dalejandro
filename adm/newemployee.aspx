<%@ Page Title="New Employee" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="newemployee.aspx.vb" Inherits="pasconcept20.newemployee" %>

<%@ MasterType VirtualPath="~/ADM/BasicMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLuxW5zYQh_ClJfDEBpTLlT_tf8JVcxf0&libraries=places&callback=initAutocomplete"
            async defer></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
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

        <table style="width: 100%" class="table-condensed">
            <tr>
                <td style="text-align: center; padding-top: 15px; padding-bottom: 15px; width: 175px">
                    <asp:Image ID="Image8" runat="server"
                        ImageUrl="~/Images/Toolbar/new-employee-256.png" Width="64px" />
                </td>
                <td class="Titulo3">Enter New Employee Details
                        <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" CssClass="Error "
                        ErrorMessage=" (*) Name is Required"></asp:RequiredFieldValidator>
                    &nbsp;&nbsp;
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEmail" CssClass="Error "
                            ErrorMessage="(*) Email is Required" Display="Dynamic"></asp:RequiredFieldValidator>
                    &nbsp;<asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtEmail" CssClass="Error "
                        runat="server" ErrorMessage="(*) Enter an valid email address" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                        Display="Dynamic"></asp:RegularExpressionValidator>
                </td>
            </tr>
        </table>

        <div>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server"
                Font-Size="X-Small" HeaderText="Following error occurs:" ShowMessageBox="false" DisplayMode="BulletList" ShowSummary="true"
                ValidationGroup="Employee" />

        </div>
        <table style="width: 100%" class="table-condensed">
            <tr>
                <td style="text-align: right; width: 180px">
                    <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                        ControlToValidate="txtEmail"
                        Text="*"
                        ErrorMessage="Email Invalid Format"
                        ValidationGroup="Employee">
                    </asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                        ControlToValidate="txtEmail"
                        Text="*"
                        ErrorMessage="Email is required"
                        ValidationGroup="Employee">
                    </asp:RequiredFieldValidator>

                    Email/User Name:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtEmail" runat="server" Width="100%" EmptyMessage="(*)Required"
                        MaxLength="80">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                        ControlToValidate="txtName"
                        Text="*"
                        ErrorMessage="Firt Name is required"
                        ValidationGroup="Employee">
                    </asp:RequiredFieldValidator>
                    First Name:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtName" runat="server" Width="100%" EmptyMessage="(*)Required"
                        MaxLength="80">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                        ControlToValidate="txtLastName"
                        Text="*"
                        ErrorMessage="Last Name is required"
                        ValidationGroup="Employee">
                    </asp:RequiredFieldValidator>
                    Last Name:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtLastName" runat="server" Width="100%" EmptyMessage="(*)Required"
                        MaxLength="80">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Position:
                </td>
                <td>
                    <telerik:RadDropDownList runat="server" ID="cboPosition" DataValueField="Id" Width="100%" DropDownWidth="400px" DropDownHeight="250px"
                        DataTextField="Name" DataSourceID="SqlDataSourcePosition" AppendDataBoundItems="true">
                        <Items>
                            <telerik:DropDownListItem Text="(Select Position...)" Value="0" />
                        </Items>
                    </telerik:RadDropDownList>

                </td>
            </tr>

            <tr>
                <td style="text-align: right">
                    <asp:CompareValidator runat="server" ID="Comparevalidator5" ValueToCompare="(Select Department...)"
                        Operator="NotEqual" ControlToValidate="DepartmentDropDown" Text="*" ErrorMessage="Department is required" ValidationGroup="Employee">
                    </asp:CompareValidator>
                    Department:
                </td>
                <td>
                    <telerik:RadDropDownList runat="server" ID="DepartmentDropDown" DataValueField="Id" Width="100%" DropDownWidth="450px" DropDownHeight="250px"
                        DataTextField="Name" DataSourceID="SqlDataSourceDepartments" AppendDataBoundItems="true">
                        <Items>
                            <telerik:DropDownListItem Text="(Select Department...)" Value="0" />
                        </Items>
                    </telerik:RadDropDownList>
                </td>
            </tr>

            <tr>
                <td style="text-align: right">Address Line 1:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtDireccion" runat="server" Width="100%" MaxLength="80" CssClass="input-address">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Address Line 2:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtDireccion2" runat="server" Width="100%" MaxLength="80">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">City/State/Zip:
                </td>
                <td>
                    <table style="width: 100%">
                        <tr>
                            <td style="width: 33%">
                                <telerik:RadTextBox ID="txtCiudad" runat="server" Width="90%" MaxLength="50" CssClass="input-city" EmptyMessage="City">
                                </telerik:RadTextBox>
                            </td>
                            <td style="width: 33%; text-align: center">
                                <telerik:RadTextBox ID="txtState" runat="server" Width="90%" MaxLength="50" CssClass="input-state" EmptyMessage="State">
                                </telerik:RadTextBox>
                            </td>
                            <td style="width: 33%; text-align: right">
                                <telerik:RadTextBox ID="txtZipCode" runat="server" Width="90%" MaxLength="50" CssClass="input-zip" EmptyMessage="Zip Code">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Work Direct:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtTelefono" runat="server" Width="250px" MaxLength="25">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Cell Phone:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtCellular" runat="server" Width="250px" MaxLength="25">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">SSN:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtSS" runat="server" Width="250px" MaxLength="11">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">DOB:
                </td>
                <td>
                    <telerik:RadDatePicker ID="RadDatePickerDOB" runat="server" Culture="English (United States)"
                        MaxDate="2029-12-31" MinDate="1980-01-01">
                        <DateInput DateFormat="MM/dd/yyyy" DisplayDateFormat="MM/dd/yyyy">
                        </DateInput>
                        <Calendar>
                        </Calendar>
                        <DatePopupButton></DatePopupButton>
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Starting Date:
                </td>
                <td>
                    <telerik:RadDatePicker ID="RadDatePickerStartingDate" runat="server" Culture="English (United States)"
                        MaxDate="2030-12-31" MinDate="1960-01-01">
                        <DateInput DateFormat="MM/dd/yyyy" DisplayDateFormat="MM/dd/yyyy">
                        </DateInput>
                        <Calendar>
                        </Calendar>
                        <DatePopupButton></DatePopupButton>
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Hourly Rate:
                </td>
                <td>
                    <telerik:RadNumericTextBox ID="txtHourRate" runat="server" MinValue="0" MaxValue="999" Width="125"
                        ShowSpinButtons="True"
                        ButtonsPosition="Right">
                        <NumberFormat DecimalDigits="2" />
                        <IncrementSettings Step="0.5" />
                    </telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Producer Rate:
                </td>
                <td>
                    <telerik:RadNumericTextBox ID="txtProducerRate" runat="server" MinValue="0" Width="125" MaxValue="1" Value="0">
                        <NumberFormat DecimalDigits="2" />
                    </telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Vacations(Hours):
                </td>
                <td>
                    <telerik:RadNumericTextBox ID="txtVacations" runat="server" MinValue="0" MaxValue="160" Width="125" Value="40">
                                    <NumberFormat DecimalDigits="0" />
                                </telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Personal/Sicks (Hours):
                </td>
                <td>
                    <telerik:RadNumericTextBox ID="txtPersonal" runat="server" MinValue="0" MaxValue="32" Width="125" Value="16">
                                    <NumberFormat DecimalDigits="0" />
                                </telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Gender:
                </td>
                <td>
                    <telerik:RadDropDownList runat="server" ID="cboGender" Width="150px">
                        <Items>
                            <telerik:DropDownListItem Text="(Select Gender...)" Value="0" />
                            <telerik:DropDownListItem Text="Male" Value="M" />
                            <telerik:DropDownListItem Text="Female" Value="F" />
                        </Items>
                    </telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Notes:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtNotes" runat="server" MaxLength="255" Width="100%" >
                    </telerik:RadTextBox>
                </td>
            </tr>
           <%-- <tr>
                <td style="text-align: right">Admin Portal Access:
                </td>
                <td>
                    <asp:CheckBox ID="chkAdmin" runat="server" />
                </td>
            </tr>--%>

            <tr>
                <td style="text-align: right">Employee Role:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboSourceRole" runat="server" AppendDataBoundItems="true"
                        Width="100%" DataSourceID="SqlDataSourceRoles" DataTextField="Name" DataValueField="Id" Height="200px" AutoPostBack="true">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select Role...)" Value="-1" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>


            <tr>
                <td colspan="2" style="text-align: right">
                    <asp:LinkButton ID="btnNuevo" runat="server" CssClass="btn btn-primary btn-lg" UseSubmitBehavior="false" ValidationGroup="Employee">
                         <span class="glyphicon glyphicon-plus"></span>&nbsp;Employee
                    </asp:LinkButton>
                </td>
            </tr>
        </table>

    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="EMPLOYEE_INSERT" InsertCommandType="StoredProcedure"
        UpdateCommand="empl_COPY_ROLE" UpdateCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="txtEmail" Name="Email" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtName" Name="Name" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtLastName" Name="LastName" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtDireccion" Name="Address" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtDireccion2" Name="Address2" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtCiudad" Name="City" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtState" Name="State" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtZipCode" Name="ZipCode" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtTelefono" Name="Phone" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtCellular" Name="Cellular" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtSS" Name="SS" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="RadDatePickerDOB" Name="DOB" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboGender" Name="Gender" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="txtNotes" Name="Notes" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="DepartmentDropDown" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboPosition" Name="PositionId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtVacations" Name="Benefits_vacations" PropertyName="Value"  />
            <asp:ControlParameter ControlID="txtPersonal" Name="Benefits_personals" PropertyName="Value"  />
            <asp:ControlParameter ControlID="RadDatePickerStartingDate" Name="starting_Date" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="txtHourRate" Name="HourRate" PropertyName="Value"  />
            <asp:ControlParameter ControlID="txtProducerRate" Name="ProducerRate" PropertyName="Value" />
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="Id_OUT" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="cboSourceRole" Name="roleId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblNewEmployeeInsertedId" Name="empl_Dest" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceRoles" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Select Id, Name from Employees_roles where companyId=@companyId order by Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Select Id, Name from Company_Department where companyId=@companyId Order By Name">
        <SelectParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourcePosition" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Select Id, Name from Employees_Position where companyId=@companyId Order By Name">
        <SelectParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployee" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblNewEmployeeInsertedId" runat="server" Visible="False"></asp:Label>
</asp:Content>
