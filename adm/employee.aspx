<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="employee.aspx.vb" Inherits="pasconcept20.employee" MasterPageFile="~/adm/ADM_Main_Responsive.Master" %>

<%@ MasterType VirtualPath="~/adm/ADM_Main_Responsive.Master" %>
<%@ Import Namespace="pasconcept20" %>
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
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function OnClientClose(sender, args) {
                var Photo = document.getElementById('<%=FormView1.FindControl("ImageEmployeePhoto").ClientID%>');
                //var FormView = document.getElementById('<%= "Formview1.ClientID"%>');
                Photo.reBind();
            }
        </script>
    </telerik:RadCodeBlock>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">

            <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
                       Back to List
            </asp:LinkButton>
            Employee Profile
        </span>
        <span style="float: right; vertical-align: middle;">
            <asp:LinkButton ID="btnTotals" runat="server" CssClass="btn btn-secondary" UseSubmitBehavior="false">
                       View Summary
            </asp:LinkButton>
        </span>

    </div>

    <div>
        <asp:FormView ID="FormViewEmployeeBalance" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceEmployeeBalance" Width="100%" CssClass="pasconcept-subbar">
            <ItemTemplate>
                <table class="table-sm" style="width: 100%">
                    <tr>
                        <td colspan="11" style="text-align: center">
                            <h2 style="margin: 0"><%# Eval("EmployeeName")%></h2>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 15%; text-align: center; background-color: #039be5">
                            <span class="DashboardFont2">Vacations</span><br />
                            <asp:Label ID="lblTotalBudget" CssClass="DashboardFont1" runat="server" Text='<%# Eval("Pending_vacations", "{0:N0}") %>'></asp:Label><br />
                            <span class="DashboardFont3">Pending This Year</span>
                        </td>
                        <td></td>
                        <td style="width: 15%; text-align: center; background-color: #039be5">
                            <span class="DashboardFont2">Personals Days</span><br />
                            <asp:Label ID="Label1" CssClass="DashboardFont1" runat="server" Text='<%# Eval("Pending_personals", "{0:N0}") %>'></asp:Label><br />
                            <span class="DashboardFont3">Pending This Year</span>
                        </td>
                        <td></td>
                        <td style="width: 15%; text-align: center; background-color: #e53935">
                            <span class="DashboardFont2">Cost</span><br />
                            <asp:Label ID="Label2" CssClass="DashboardFont1" runat="server" Text='<%# Eval("EmployeeCost", "{0:N0}") %>'></asp:Label><br />
                            <span class="DashboardFont3">This Year</span>
                        </td>
                        <td></td>
                        <td style="width: 15%; text-align: center; background-color: #43a047">
                            <span class="DashboardFont2">Revenue</span><br />
                            <asp:Label ID="Label3" CssClass="DashboardFont1" runat="server" Text='<%# Eval("EmployeeRevenue", "{0:N0}") %>'></asp:Label><br />
                            <span class="DashboardFont3">This Year</span>
                        </td>
                        <td></td>
                        <td style="width: 15%; text-align: center; background-color: #43a047">
                            <span class="DashboardFont2">FTE</span><br />
                            <asp:Label ID="lblTotalPending" runat="server" CssClass="DashboardFont1" Text='<%# Eval("EmployeeFTE", "{0:N2}") %>'></asp:Label><br />
                            <span class="DashboardFont3">Full Time Employment</span>
                        </td>
                        <td></td>
                        <td style="width: 15%; text-align: center; background-color: #546e7a">
                            <span class="DashboardFont2">Efficiency</span><br />
                            <asp:Label ID="LabelblTotalBalance" runat="server" CssClass="DashboardFont1" Text='<%# Eval("EmployeeEfficiency", "{0:P0}") %>'></asp:Label><br />
                            <span class="DashboardFont3">Assigned/Worked Hours</span>

                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:FormView>
    </div>

    <div class="pasconcept-bar">
        <telerik:RadWizard ID="RadWizard1" runat="server" DisplayCancelButton="false" RenderMode="Lightweight" Skin="Silk" DisplayNavigationButtons="false" DisplayProgressBar="false">
            <WizardSteps>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep1" Title="Employee Details" StepType="Step">
                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSource1" Width="100%" DefaultMode="Edit">
                        <EditItemTemplate>
                            <div>
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server"
                                    Font-Size="X-Small" HeaderText="Following error occurs:" ShowMessageBox="false" DisplayMode="BulletList" ShowSummary="true"
                                    ValidationGroup="Employee" />

                            </div>
                            <table class="table-sm" style="width: 100%">
                                <tr>
                                    <td style="width: 180px;">
                                        <asp:Image ID="ImageEmployeePhoto" ImageUrl='<%# LocalAPI.GetEmployeePhotoURL(employeeId:=Eval("Id"))%>'
                                            runat="server" Width="45" Height="50" AlternateText='<%# Eval("Name", "{0} photo")%>'></asp:Image>
                                    </td>
                                    <td>
                                        <table style="width: 100%">
                                            <tr>
                                                <td>
                                                    <asp:LinkButton ID="btnPhoto" runat="server" CommandName="Photo" ToolTip="Upload Employee Photo"
                                                        CssClass="btn btn-secondary" UseSubmitBehavior="false" Visible="false">
                                                            <i class="fas fa-user"></i> Employee Photo
                                                    </asp:LinkButton>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="True" CommandName="Update" ValidationGroup="Contact">
                                                        Update
                                                    </asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>

                                    </td>

                                </tr>
                                <tr>
                                    <td>
                                        <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                            ControlToValidate="EmailTextBox"
                                            ErrorMessage="Email Invalid Format"
                                            ValidationGroup="Employee"
                                            Display="None">
                                        </asp:RegularExpressionValidator>
                                        Email:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>'
                                            MaxLength="80" Width="100%">
                                        </telerik:RadTextBox>

                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                            ControlToValidate="NameTextBox"
                                            ErrorMessage="Firt Name is required"
                                            ValidationGroup="Employee"
                                            Display="None"></asp:RequiredFieldValidator>
                                        First Name:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="80" Width="100%" EmptyMessage="First Name">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                            ControlToValidate="txtLastName"
                                            ErrorMessage="Last Name is required"
                                            ValidationGroup="Employee"
                                            Display="None">
                                        </asp:RequiredFieldValidator>
                                        Last Name:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txtLastName" runat="server" Text='<%# Bind("LastName")%>' MaxLength="80" Width="100%" EmptyMessage="Last Name">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Department:
                                    </td>
                                    <td>
                                        <telerik:RadDropDownList runat="server" ID="DepartmentDropDown" DataValueField="Id" Width="100%" DropDownWidth="100%" DropDownHeight="250px"
                                            DataTextField="Name" DataSourceID="SqlDataSourceDepartments" AppendDataBoundItems="true" SelectedValue='<%# Bind("DepartmentId")%>'>
                                            <Items>
                                                <telerik:DropDownListItem Text="(Select Department...)" Value="0" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Boss:
                                    </td>
                                    <td>
                                        <telerik:RadDropDownList runat="server" ID="DepartmentDropDownParent" DataValueField="Id" Width="100%" DropDownWidth="100%" DropDownHeight="250px"
                                            DataTextField="Name" DataSourceID="SqlDataSourceBoss" AppendDataBoundItems="true" SelectedValue='<%# Bind("ParentID")%>'>
                                            <Items>
                                                <telerik:DropDownListItem Text="(Select Department...)" Value="0" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                            ControlToValidate="Employee_CodeTextBox"
                                            ValidationGroup="Employee" Display="None"
                                            ErrorMessage="Employee code is required"></asp:RequiredFieldValidator>
                                        Employee Code:
                                    </td>
                                    <td>
                                        <table style="width: 100%">
                                            <tr>
                                                <td>
                                                    <telerik:RadTextBox ID="Employee_CodeTextBox" runat="server" Text='<%# Bind("Employee_Code") %>'
                                                        MaxLength="5" EmptyMessage="Required" Width="200px">
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td>Suffix:
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="RadTextBoxSuffix" runat="server" Text='<%# Bind("Suffix") %>'
                                                        MaxLength="80" Width="100%">
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>

                                        </table>

                                    </td>
                                </tr>
                                <tr>
                                    <td>Position:
                                    </td>
                                    <td>
                                        <telerik:RadDropDownList runat="server" ID="cboPosition" DataValueField="Id" Width="100%" DropDownWidth="100%" DropDownHeight="250px"
                                            DataTextField="Name" DataSourceID="SqlDataSourcePosition" AppendDataBoundItems="true" SelectedValue='<%# Bind("PositionId")%>'>
                                            <Items>
                                                <telerik:DropDownListItem Text="(Select Position...)" Value="0" />
                                            </Items>
                                        </telerik:RadDropDownList>

                                    </td>
                                </tr>
                                <tr>
                                    <td>Address Line 1:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="AddressTextBox" runat="server" Text='<%# Bind("Address") %>'
                                            MaxLength="80" Width="100%" CssClass="input-address">
                                        </telerik:RadTextBox>

                                    </td>
                                </tr>
                                <tr>
                                    <td>Address Line 2:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="Address2TextBox" runat="server" Text='<%# Bind("Address2") %>'
                                            MaxLength="80" Width="100%">
                                        </telerik:RadTextBox>

                                    </td>
                                </tr>
                                <tr>
                                    <td>City/State/Zip:
                                    </td>
                                    <td>
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 33%">
                                                    <telerik:RadTextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' MaxLength="50"
                                                        Width="90%" CssClass="input-city" EmptyMessage="City">
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td style="width: 33%; text-align: center">
                                                    <telerik:RadTextBox ID="EstateTextBox" runat="server" Text='<%# Bind("Estate") %>'
                                                        MaxLength="50" Width="90%" CssClass="input-state" EmptyMessage="State">
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td style="width: 33%; text-align: right">
                                                    <telerik:RadTextBox ID="ZipCodeTextBox" runat="server" Text='<%# Bind("ZipCode") %>'
                                                        MaxLength="50" Width="90%" CssClass="input-zip" EmptyMessage="Zip Code">
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Work Direct:
                                    </td>
                                    <td>
                                        <telerik:RadMaskedTextBox ID="PhoneTextBox" runat="server" Text='<%# Bind("Phone") %>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" />
                                        &nbsp;&nbsp;&nbsp;
                                        Cell Phone:
                                        &nbsp;
                                       
                                        <telerik:RadMaskedTextBox ID="CellularTextBox" runat="server" Text='<%# Bind("Cellular") %>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" />
                                    </td>
                                </tr>

                                <tr>
                                    <td>Work Phone:
                                    </td>
                                    <td>
                                        <telerik:RadMaskedTextBox ID="txtWorkPhone" runat="server" Text='<%# Bind("WorkPhone") %>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" />
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        Work Ext:
                                        &nbsp;
                                       
                                        <telerik:RadTextBox ID="txtExt" runat="server" Text='<%# Bind("Ext") %>' Width="100px"
                                            MaxLength="4">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td>Contact Phone:
                                    </td>
                                    <td>
                                        <table style="width: 100%">
                                            <tr>
                                                <td>
                                                    <telerik:RadMaskedTextBox ID="RadMaskedTextBox1" runat="server" Text='<%# Bind("ContactPhone") %>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" ToolTip="Show Phone in MobileApp Contact Profile" />
                                                </td>
                                                <td>Contact Email:
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="RadTextBox3" runat="server" Text='<%# Bind("ContactEmail") %>'
                                                        MaxLength="80" Width="100%" ToolTip="Show Email in MobileApp Contact Profile">
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                        </table>

                                    </td>
                                </tr>
                                <tr>
                                    <td>Starting Date:
                                    </td>
                                    <td>
                                        <telerik:RadDatePicker ID="RadDatePickerstarting_Date" runat="server" DbSelectedDate='<%# Bind("starting_Date")%>'
                                            MaxDate="01/01/2099 0:00:00" MinDate="01/01/1900 0:00:00">
                                            <Calendar UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                                            </Calendar>
                                            <DateInput DateFormat="MM/dd/yyyy" DisplayDateFormat="MM/dd/yyyy">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Hourly Rate ($/hour):
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="HourRateTextBox" runat="server" Text='<%# Bind("HourRate") %>'>
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>SS Number:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="SSTextBox" runat="server" Text='<%# Bind("SS") %>' Width="250px"
                                            MaxLength="11">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>DOB:
                                    </td>
                                    <td>
                                        <telerik:RadDatePicker ID="RadDatePicker1" runat="server" DbSelectedDate='<%# Bind("DOB") %>'
                                            MaxDate="01/01/2099 0:00:00" MinDate="01/01/1900 0:00:00">
                                            <Calendar UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                                            </Calendar>
                                            <DateInput DateFormat="MM/dd/yyyy" DisplayDateFormat="MM/dd/yyyy">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Gender:
                                    </td>
                                    <td>
                                        <telerik:RadDropDownList runat="server" ID="cboGender" Width="250px" SelectedValue='<%# Bind("Gender")%>'>
                                            <Items>
                                                <telerik:DropDownListItem Text="(Select Gender...)" Value="0" />
                                                <telerik:DropDownListItem Text="Male" Value="M" />
                                                <telerik:DropDownListItem Text="Female" Value="F" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Vacations(Hours):
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="RadTextBox1" runat="server" Text='<%# Bind("Benefits_vacations") %>'>
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Personal/Sicks (Hours):
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="RadTextBox2" runat="server" Text='<%# Bind("Benefits_personals") %>'>
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Notes:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="NotesTextBox" runat="server" Text='<%# Bind("Notes") %>'
                                            MaxLength="255" Width="100%" TextMode="MultiLine">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Status:</td>
                                    <td>
                                        <table style="width: 100%">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="cboStatus" runat="server" Width="250px" AppendDataBoundItems="true" SelectedValue='<%# Bind("Inactive")%>' Enabled="false">
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text="Active" Value="0" />
                                                            <telerik:RadComboBoxItem runat="server" Text="Inactive" Value="1" />
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td>Inactive Date:</td>
                                                <td>
                                                    <asp:Label ID="Inactive_DateLabele" runat="server" Text='<%# Eval("Inactive_Date", "{0:d}")%>'></asp:Label></td>
                                            </tr>
                                        </table>

                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td style="color: darkred">
                                        <small>To change the status (Active / Inactive) of an employee, use the action in the "Status" column of Employee List
                                        </small>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Show your Address:
                                    </td>
                                    <td>
                                        <table style="width: 100%">
                                            <tr>
                                                <td>
                                                    <telerik:RadCheckBox ID="chkAddress" runat="server" Checked='<%# Bind("ShowAddress")%>'
                                                        ToolTip="Show address in MobileApp Contact Profile">
                                                    </telerik:RadCheckBox>
                                                </td>
                                                <td style="text-align: right">Weekly Timesheet Notification:</td>
                                                <td>
                                                    <telerik:RadComboBox ID="cboWeeklyTimesheetNotification" runat="server" Width="100px" AppendDataBoundItems="true" SelectedValue='<%# Bind("WeeklyTimesheetNotification")%>'>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text="No" Value="0" />
                                                            <telerik:RadComboBoxItem runat="server" Text="Yes" Value="1" />
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>

                                <tr>
                                    <td></td>
                                    <td style="text-align: right;">
                                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="True" CommandName="Update" ValidationGroup="Contact">
                                              Update
                                        </asp:LinkButton>
                                    </td>

                                </tr>
                            </table>
                        </EditItemTemplate>

                    </asp:FormView>
                </telerik:RadWizardStep>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep2" Title="Wage History" StepType="Step">
                    <div>
                        <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" DataSourceID="SqlDataSourceChart" Height="400px" Width="100%"
                            Transitions="true">
                            <PlotArea>
                                <Series>
                                    <telerik:LineSeries DataFieldY="Amount" Name="$/Hour" AxisName="LeftAxis">

                                        <TooltipsAppearance DataFormatString="{0:N2}"></TooltipsAppearance>

                                        <Appearance>
                                            <FillStyle BackgroundColor="Red" />
                                        </Appearance>

                                        <LineAppearance LineStyle="Smooth" Width="2" />
                                        <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                        <LabelsAppearance Color="Red" Position="Above">
                                            <TextStyle FontSize="10" />
                                        </LabelsAppearance>

                                    </telerik:LineSeries>
                                </Series>
                                <YAxis Name="LeftAxis" MajorTickSize="6" MajorTickType="Outside" Step="10" MinorTickSize="1" Color="Red" Width="3">
                                    <TitleAppearance Text="$/Hour"></TitleAppearance>
                                    <LabelsAppearance DataFormatString="{0:N2}">
                                        <TextStyle FontSize="10" />
                                    </LabelsAppearance>
                                    <MinorGridLines Visible="false"></MinorGridLines>

                                </YAxis>
                                <XAxis DataLabelsField="YearGroup">
                                    <TitleAppearance Text="Date" Visible="false"></TitleAppearance>
                                    <MinorGridLines Visible="false"></MinorGridLines>
                                    <MajorGridLines Visible="false" />
                                    <LabelsAppearance>
                                        <TextStyle FontSize="10" />
                                    </LabelsAppearance>
                                </XAxis>
                            </PlotArea>
                            <Legend>
                                <Appearance Visible="false" Position="Top"></Appearance>
                            </Legend>
                        </telerik:RadHtmlChart>
                    </div>
                    <div>
                        <telerik:RadGrid ID="RadGridHourlyWage" runat="server" DataSourceID="SqlDataSourceHourlyWage"
                            AutoGenerateColumns="False" AllowSorting="True" HeaderStyle-Font-Size="X-Small"
                            AllowAutomaticDeletes="true" AllowAutomaticInserts="true" AllowAutomaticUpdates="true">
                            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceHourlyWage">
                                <Columns>
                                    <telerik:GridTemplateColumn DataField="Date" FilterControlAltText="Filter Date column" HeaderText="Date From" HeaderStyle-HorizontalAlign="Center"
                                        SortExpression="Date" UniqueName="Date" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Eval("Date", "{0:d}") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="DateEnd" FilterControlAltText="Filter DateEnd column" HeaderText="Date To" HeaderStyle-HorizontalAlign="Center"
                                        SortExpression="DateEnd" UniqueName="DateEnd" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Eval("DateEnd", "{0:d}") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="Amount" FilterControlAltText="Filter Amount column" HeaderText="$/Hour" HeaderStyle-HorizontalAlign="Center"
                                        SortExpression="Amount" UniqueName="Amount" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right"
                                        HeaderTooltip="Hourly Wage Rate">
                                        <ItemTemplate>
                                            <%# Eval("Amount", "{0:C2}") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Benefits_vacations" FilterControlAltText="Filter Benefits_vacations column" HeaderText="Vacations(hours)" HeaderStyle-HorizontalAlign="Center"
                                        SortExpression="Benefits_vacations" UniqueName="Benefits_vacations" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Eval("Benefits_vacations", "{0:N0}") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Benefits_personals" FilterControlAltText="Filter Benefits_personals column" HeaderText="Personals(hours)" HeaderStyle-HorizontalAlign="Center"
                                        SortExpression="Benefits_personals" UniqueName="Benefits_personals" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Eval("Benefits_personals", "{0:N0}") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Increase" FilterControlAltText="Filter Increase column" HeaderText="Increase" HeaderStyle-HorizontalAlign="Center"
                                        SortExpression="Increase" UniqueName="Increase" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Eval("Increase", "{0:N2}") %>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                </telerik:RadWizardStep>
            </WizardSteps>
        </telerik:RadWizard>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        UpdateCommand="EMPLOYEE_UPDATE"
        SelectCommand="EMPLOYEE_SELECT" SelectCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="Id" PropertyName="Text" Type="Int32" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="LastName" Type="String" />
            <asp:Parameter Name="Address" Type="String" />
            <asp:Parameter Name="City" Type="String" />
            <asp:Parameter Name="Estate" Type="String" />
            <asp:Parameter Name="ZipCode" Type="String" />
            <asp:Parameter Name="Phone" Type="String" />
            <asp:Parameter Name="Cellular" Type="String" />
            <asp:Parameter Name="WorkPhone" Type="String" />
            <asp:Parameter Name="Ext" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="starting_Date" Type="DateTime" />
            <asp:Parameter Name="HourRate" Type="Double" />
            <asp:Parameter Name="SS" Type="String" />
            <asp:Parameter Name="DOB" Type="DateTime" />
            <asp:Parameter Name="Gender" Type="String" />
            <asp:Parameter Name="Inactive" Type="Int32" />
            <asp:Parameter Name="Address2" Type="String" />
            <asp:Parameter Name="Notes" Type="String" />
            <asp:Parameter Name="Employee_Code" Type="String" />
            <asp:Parameter Name="DepartmentId" Type="Int32" />
            <asp:Parameter Name="ParentID" Type="Int32" />
            <asp:Parameter Name="PositionId" Type="Int32" />
            <asp:Parameter Name="Benefits_vacations" Type="Int32" />
            <asp:Parameter Name="Benefits_personals" Type="Int32" />
            <asp:Parameter Name="WeeklyTimesheetNotification" Type="Int32" />
            <asp:Parameter Name="ContactPhone" Type="String" />
            <asp:Parameter Name="ContactEmail" Type="String" />
            <asp:Parameter Name="ShowAddress" />
            <asp:Parameter Name="Suffix" Type="String" />
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
        SelectCommand="Select Id, Name from Employees_Position where companyId=@companyId Order By Name">
        <SelectParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceBoss" runat="server"
        ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, FullName As Name From Employees Where companyId=@companyId Order By FullName">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceHourlyWage" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="EmployeeForm_HourlyWageHistory_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceChart" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Employee_HourlyWageHistoryDetailsExt_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="Year" DefaultValue="0" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployeeBalance" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Employee_Balance" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="EmployeeId" PropertyName="Text" Type="Int32" />
        </SelectParameters>

    </asp:SqlDataSource>


    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>

    <asp:Label ID="lblInactive" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblBackSource" runat="server" Visible="False" Text="0"></asp:Label>
</asp:Content>

