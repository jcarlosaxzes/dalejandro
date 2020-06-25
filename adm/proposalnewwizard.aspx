<%@ Page Title="Proposal" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="proposalnewwizard.aspx.vb" Inherits="pasconcept20.proposalnewwizard" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <script type="text/javascript">
            function onClientUploadFailed(sender, eventArgs) {
                alert(eventArgs.get_message())
            }

        </script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLuxW5zYQh_ClJfDEBpTLlT_tf8JVcxf0&libraries=places&callback=initAutocomplete"
            async defer></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.0/jquery.mask.min.js"></script>
        <script>
            // Autocompletes all address inputs using google maps js api
            function initAutocomplete() {
                // Address Fields
                var addressInput1 = document.getElementsByClassName("input-address-1")[0];
                var addressInput2 = document.getElementsByClassName("input-address-2")[0];
                var cityInput = document.getElementsByClassName("input-city")[0];
                var stateInput = document.getElementsByClassName("input-state")[0];
                var zipInput = document.getElementsByClassName("input-zip")[0];
                // autocomplete var
                var autocomplete1 = new google.maps.places.Autocomplete(addressInput1);
                var autocomplete2 = new google.maps.places.Autocomplete(addressInput2);

                autocomplete1.addListener('place_changed', function () {
                    var place = autocomplete1.getPlace();
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
                    addressInput1.value = loader.street_number + loader.route + loader.subpremise;
                });

                autocomplete2.addListener('place_changed', function () {
                    var place = autocomplete2.getPlace();
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


                });
            }
        </script>
    </telerik:RadCodeBlock>
    <style>
        #wrap {
            /*width: 600px;*/
            /*height: 390px;*/
            padding: 0;
            overflow: hidden;
        }


        #frame {
            zoom: 0.75;
            -moz-transform: scale(0.75);
            -moz-transform-origin: 0 0;
        }

        .borderless table {
            border-top-style: none;
            border-left-style: none;
            border-right-style: none;
            border-bottom-style: none;
        }

        .rlbItem {
            float: left !important;
            width: 300px;
        }

        .rlbGroup, .RadListBox {
            width: auto !important;
        }

        .mycheckbox input[type="checkbox"] {
            margin-right: 5px !important;
        }

        .leftcheckbox input[type="checkbox"] {
            margin-left: 20px !important;
        }

        label {
            font-weight: normal;
        }

        .RadListBox label > input {
            margin-right: 5px !important;
        }
    </style>
    <div class="Formulario">
        <table class="table-sm" style="width: 100%">
            <tr>
                <td style="width: 120px">
                    <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
                       Back to List
                    </asp:LinkButton>
                </td>
                <td style="text-align: center">
                    <h3 style="margin: 0">Proposal</h3>
                </td>

            </tr>
        </table>
    </div>
    <div class="pas-container">
        <telerik:RadWizard ID="RadWizard1" runat="server" Height="800px" DisplayCancelButton="false"
            RenderMode="Lightweight" Skin="Material">
            <WizardSteps>

                <%-- Contact Information --%>
                <telerik:RadWizardStep runat="server" ID="Client" Title="Client" ValidationGroup="Client" StepType="Start">

                    <div>
                        <asp:ValidationSummary ID="vsClient" runat="server" ValidationGroup="Client"
                            HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were errors on this step:"></asp:ValidationSummary>
                    </div>


                    <fieldset>
                        <legend>Client Info 
                            <telerik:RadComboBox ID="cboClients" runat="server" DataSourceID="SqlDataSourceClient" Width="450px"
                                DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Height="250px"
                                AppendDataBoundItems="true" AutoPostBack="true" Font-Size="Medium">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="[+ New client...]" Value="0" />
                                </Items>
                            </telerik:RadComboBox>
                        </legend>
                    </fieldset>

                    <table class="table-sm" style="width: 100%">
                        <tr>
                            <td style="width: 50px; text-align: right">
                                <asp:RequiredFieldValidator ID="rfvFirstName"
                                    ControlToValidate="txtClientName" Display="Dynamic" runat="server" Text="*" ErrorMessage="<span><b>Name</b> is required</span>" SetFocusOnError="true" ValidationGroup="Client">
                                </asp:RequiredFieldValidator>
                            </td>
                            <td>
                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="txtClientName" Text="Name:"></asp:Label>
                                <telerik:RadTextBox Width="100%" ID="txtClientName" runat="server" MaxLength="80"
                                    RenderMode="Lightweight" Skin="Material">
                                </telerik:RadTextBox>
                            </td>
                            <td style="width: 50px; text-align: right"></td>
                            <td>
                                <asp:Label ID="Label2" runat="server" AssociatedControlID="txtClientCompany" Text="Company:"></asp:Label>
                                <telerik:RadTextBox Width="100%" ID="txtClientCompany" runat="server" MaxLength="80"
                                    RenderMode="Lightweight" Skin="Material">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">
                                <asp:RegularExpressionValidator
                                    ID="RegularExpressionValidator1"
                                    runat="server"
                                    ControlToValidate="txtClientEmail"
                                    Text="!"
                                    ErrorMessage="Invalid Email"
                                    ForeColor="Red"
                                    ValidationExpression="^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,})$"
                                    ValidationGroup="Client">
                                </asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                                    ControlToValidate="txtClientEmail" Display="Dynamic" runat="server" Text="*" ErrorMessage="<span><b>Email</b> is required</span>" SetFocusOnError="true" ValidationGroup="Client">
                                </asp:RequiredFieldValidator>
                            </td>
                            <td>
                                <asp:Label ID="Label3" runat="server" AssociatedControlID="txtClientEmail" Text="Email:"></asp:Label>
                                <telerik:RadTextBox Width="100%" ID="txtClientEmail" runat="server" MaxLength="128"
                                    RenderMode="Lightweight" Skin="Material">
                                </telerik:RadTextBox>
                            </td>
                            <td style="text-align: right">
                                <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator2" ControlToValidate="txtClientPhone" Text="!" ErrorMessage="Invalid phone number" ValidationExpression="^\+?\d{1,3}?[- .]?\(?(?:\d{2,3})\)?[- .]?\d\d\d[- .]?\d\d\d\d$" Display="Dynamic" />
                            </td>
                            <td>
                                <asp:Label ID="Label4" runat="server" AssociatedControlID="txtClientPhone" Text="Phone:"></asp:Label>
                                <telerik:RadMaskedTextBox ID="txtClientPhone" runat="server"
                                    Mask="### ###-####" Width="100%"
                                    MaxLength="14" SelectionOnFocus="SelectAll" ResetCaretOnFocus="True" ButtonsPosition="Right"
                                    RenderMode="Lightweight" Skin="Material">
                                </telerik:RadMaskedTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right"></td>
                            <td>
                                <asp:Label ID="Label5" runat="server" AssociatedControlID="txtClientAddress" Text="Address:"></asp:Label>
                                <telerik:RadTextBox Width="100%" ID="txtClientAddress" runat="server" MaxLength="128"
                                    RenderMode="Lightweight" Skin="Material" CssClass="input-address-1">
                                </telerik:RadTextBox>
                            </td>
                            <td style="text-align: right"></td>
                            <td>
                                <asp:Label ID="Label6" runat="server" AssociatedControlID="txtClientCity" Text="City:"></asp:Label>
                                <telerik:RadTextBox Width="100%" ID="txtClientCity" runat="server" MaxLength="50"
                                    RenderMode="Lightweight" Skin="Material" CssClass="input-city">
                                </telerik:RadTextBox></td>
                        </tr>
                        <tr>
                            <td style="text-align: right"></td>
                            <td>
                                <asp:Label ID="Label7" runat="server" AssociatedControlID="txtClientState" Text="State:"></asp:Label>
                                <telerik:RadTextBox Width="100%" ID="txtClientState" runat="server" MaxLength="2"
                                    RenderMode="Lightweight" Skin="Material" CssClass="input-state">
                                </telerik:RadTextBox></td>
                            <td style="text-align: right"></td>
                            <td>
                                <asp:Label ID="Label8" runat="server" AssociatedControlID="txtClientZipCode" Text="Zip Code:"></asp:Label>
                                <telerik:RadTextBox Width="100%" ID="txtClientZipCode" runat="server" MaxLength="50"
                                    RenderMode="Lightweight" Skin="Material" CssClass="input-zip">
                                </telerik:RadTextBox></td>
                        </tr>

                        <tr>
                            <td style="text-align: right">
                                <asp:CompareValidator runat="server" ID="Comparevalidator5" ValueToCompare="(Types Not Defined...)"
                                    Operator="NotEqual" ControlToValidate="cboClientType" Text="*" ErrorMessage="<span><b>Client Type</b> is required</span>" ValidationGroup="Client">
                                </asp:CompareValidator>
                            </td>
                            <td>
                                <asp:Label ID="Label24" runat="server" AssociatedControlID="cboType" Text="Type:"></asp:Label>
                                <telerik:RadComboBox ID="cboClientType" runat="server" DataSourceID="SqlDataSourceClientTypes" DataTextField="Name"
                                    DataValueField="Id" Width="100%" Height="250px" AppendDataBoundItems="True"
                                    RenderMode="Lightweight" Skin="Material">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(Types Not Defined...)" Value="0" />
                                    </Items>
                                </telerik:RadComboBox>

                            </td>
                            <td style="text-align: right"></td>
                            <td></td>
                        </tr>


                    </table>

                    <asp:FormView ID="FormViewClientBalance" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceClientBalance" Width="100%">
                        <ItemTemplate>

                            <table class="table-sm" style="width: 100%">
                                <tr>
                                    <td style="width: 50%; text-align: center; vertical-align: top">
                                        <h3 style="margin: 0; text-align: center"><span class="navbar navbar-expand-md bg-dark text-white">Projects</span></h3>
                                        <table class="table-sm" style="width: 100%">
                                            <tr>
                                                <td style="text-align: right"># Pending Proposals:</td>
                                                <td style="width: 120px; text-align: right">
                                                    <b><%# Eval("NumberPendingProposal", "{0:N0}") %></b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right">Acepted Proposals:</td>
                                                <td style="text-align: right">
                                                    <b><%# Eval("ProposalAmount", "{0:C2}") %></b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right;">Jobs Total Amount:</td>
                                                <td style="text-align: right">
                                                    <b><%# Eval("ContractAmount", "{0:C2}") %></b>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="text-align: right; vertical-align: top">
                                        <h3 style="margin: 0; text-align: center"><span class="navbar navbar-expand-md bg-dark text-white">Balance</span></h3>
                                        <table class="table-sm" style="width: 100%">
                                            <tr>
                                                <td style="text-align: right;">Amount Paid:</td>
                                                <td>
                                                    <b><%# Eval("AmountPaid", "{0:C2}") %></b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right;">Remaining Balance:</td>
                                                <td>
                                                    <b><%# Eval("Balance", "{0:C2}") %></b>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>


                        </ItemTemplate>
                    </asp:FormView>

                </telerik:RadWizardStep>
                <%-- Project Info --%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStepProposal" Title="Proposal" Enabled="false" StepType="Step" CausesValidation="true" ValidationGroup="Proposal">

                    <div>
                        <asp:ValidationSummary ID="vsPoposal" runat="server" ValidationGroup="Proposal"
                            HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were errors on this step:"></asp:ValidationSummary>

                    </div>

                    <fieldset>
                        <legend>Proposal Info</legend>
                        <table style="width: 100%" class="table-sm">
                            <tr>
                                <td style="width: 16px; text-align: right">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtProposalName"
                                        ValidationGroup="Proposal" Text="*"
                                        ErrorMessage="<span><b>Proposal Name</b> is required</span>"></asp:RequiredFieldValidator>

                                </td>
                                <td>
                                    <asp:Label ID="Label9" runat="server" AssociatedControlID="txtProposalName" Text="Name:"></asp:Label>
                                    <telerik:RadTextBox ID="txtProposalName" runat="server" Width="100%" MaxLength="80"
                                        RenderMode="Lightweight" Skin="Material">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width: 16px; text-align: right"></td>
                                <td>
                                    <asp:Label ID="Label16" runat="server" Text="Area/Units - Measure:" Font-Bold="true"></asp:Label>
                                    <br />
                                    <telerik:RadNumericTextBox ID="txtUnit" runat="server" MaxLength="128" Width="45%"
                                        RenderMode="Lightweight" Skin="Material">
                                    </telerik:RadNumericTextBox>
                                    <telerik:RadComboBox ID="cboMeasure" runat="server" DataSourceID="SqlDataSourceMeasure" DataTextField="Name" DataValueField="Id"
                                        Width="40%"
                                        RenderMode="Lightweight" Skin="Material">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Not defined...)" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <asp:Label ID="Label15" runat="server" AssociatedControlID="txtProjectAddressLine" Text="Project Location:"></asp:Label>
                                    <telerik:RadTextBox Width="100%" ID="txtProjectAddressLine" runat="server" MaxLength="128"
                                        RenderMode="Lightweight" Skin="Material" CssClass="input-address-2">
                                    </telerik:RadTextBox>
                                </td>
                                <td>
                                    <asp:CompareValidator runat="server" ID="Comparevalidator8"
                                        Operator="NotEqual" Text="*" ValidationGroup="Proposal"
                                        ControlToValidate="cboSector"
                                        ValueToCompare="(Not defined...)"
                                        ErrorMessage="<span><b>Sector</b> is required</span>">
                                    </asp:CompareValidator>
                                </td>
                                <td>
                                    <asp:Label ID="Label12" runat="server" Text="Sector:"></asp:Label>
                                    <telerik:RadComboBox ID="cboSector" runat="server" DataSourceID="SqlDataSourceProjectSector" DataTextField="Name" DataValueField="Id"
                                        Width="100%" RenderMode="Lightweight" Skin="Material" AppendDataBoundItems="true">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Not defined...)" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>



                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">
                                    <asp:CompareValidator runat="server" ID="Comparevalidator1" ValueToCompare="(Not defined...)"
                                        Operator="NotEqual" ControlToValidate="cboType" Text="*" ErrorMessage="<span><b>Proposal Template</b> is required</span>" ValidationGroup="Proposal">
                                    </asp:CompareValidator>
                                </td>
                                <td>
                                    <asp:Label ID="Label10" runat="server" AssociatedControlID="cboType" Text="Proposal Template:"></asp:Label>
                                    <telerik:RadComboBox ID="cboType" runat="server" DataSourceID="SqlDataSourceType" DataTextField="Name" MarkFirstMatch="True" Filter="Contains"
                                        DataValueField="Id" Width="100%" Height="250px" AppendDataBoundItems="True" AutoPostBack="true"
                                        RenderMode="Lightweight" Skin="Material">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Not defined...)" Value="-1" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                                <td style="text-align: right">
                                    <asp:CompareValidator runat="server" ID="Comparevalidator9" ValueToCompare="(Not defined...)"
                                        Operator="NotEqual" ControlToValidate="cboUse" Text="*" ErrorMessage="<span><b>Use &amp; Occupancy</b> is required</span>" ValidationGroup="Proposal">
                                    </asp:CompareValidator>
                                </td>
                                <td>
                                    <asp:Label ID="Label19" runat="server" AssociatedControlID="cboUse" Text="Use &amp; Occupancy:"></asp:Label>
                                    <telerik:RadComboBox ID="cboUse" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceProjectUse" DataTextField="Name" DataValueField="Id"
                                        Width="100%" MarkFirstMatch="True" Filter="Contains" Height="350px" AutoPostBack="True" CausesValidation="false"
                                        RenderMode="Lightweight" Skin="Material">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Not defined...)" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>

                            </tr>
                            <tr>
                                <td style="text-align: right">
                                    <asp:CompareValidator runat="server" ID="Comparevalidator7" SetFocusOnError="true" Text="*" Operator="NotEqual"
                                        ControlToValidate="cboProjectType"
                                        ErrorMessage="<span><b>Job Type</b> is required</span>"
                                        ValueToCompare="(Not defined...)"
                                        ValidationGroup="Proposal">
                                    </asp:CompareValidator>
                                </td>
                                <td>

                                    <asp:Label ID="Label11" runat="server" AssociatedControlID="cboProjectType" Text="Job Type:"></asp:Label>
                                    <telerik:RadComboBox ID="cboProjectType" runat="server" AutoPostBack="true"
                                        DataSourceID="SqlDataSourceProjectType" DataTextField="Name" DataValueField="Id" Width="100%" MarkFirstMatch="True"
                                        Filter="Contains" Height="250px"
                                        RenderMode="Lightweight" Skin="Material">
                                    </telerik:RadComboBox>
                                </td>
                                <td style="text-align: right"></td>
                                <td>
                                    <asp:Label ID="Label20" runat="server" AssociatedControlID="cboUse2" Text="Classification:"></asp:Label>
                                    <telerik:RadComboBox ID="cboUse2" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceProjectUandOClassification" DataTextField="Id" DataValueField="Id"
                                        Width="100%" MarkFirstMatch="True" Filter="Contains" Height="350px" CausesValidation="false"
                                        RenderMode="Lightweight" Skin="Material">
                                        <ItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 80px">
                                                        <%# DataBinder.Eval(Container.DataItem, "Id")%>
                                                    </td>
                                                    <td>
                                                        <%# DataBinder.Eval(Container.DataItem, "Description")%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Not defined...)" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">
                                    <asp:CompareValidator runat="server" ID="Comparevalidator2"
                                        Operator="NotEqual" Text="*" ValidationGroup="Proposal"
                                        ControlToValidate="cboDepartment"
                                        ValueToCompare="(Not defined...)"
                                        ErrorMessage="<span><b>Department</b> is required</span>">
                                    </asp:CompareValidator>
                                </td>
                                <td>
                                    <asp:Label ID="Label13" runat="server" AssociatedControlID="cboDepartment" Text="Department:"></asp:Label>
                                    <telerik:RadComboBox ID="cboDepartment" runat="server" AppendDataBoundItems="True" AutoPostBack="true"
                                        DataSourceID="SqlDataSourceDepartments" DataTextField="Name" DataValueField="Id" Width="100%" Height="250px"
                                        RenderMode="Lightweight" Skin="Material">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Not defined...)" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                                <td style="text-align: right"></td>
                                <td>
                                    <asp:Label ID="Label14" runat="server" AssociatedControlID="cboEmployee" Text="Prepared By:"></asp:Label>
                                    <telerik:RadComboBox ID="cboEmployee" runat="server" AutoPostBack="true"
                                        DataSourceID="SqlDataSourceEmployees" DataTextField="Name" DataValueField="Id" MarkFirstMatch="true" Filter="Contains"
                                        Width="100%" CausesValidation="false" Height="350px"
                                        RenderMode="Lightweight" Skin="Material">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right"></td>
                                <td>
                                    <asp:Label ID="Label23" runat="server" AssociatedControlID="TextBoxOwner" Text="Owner Name:"></asp:Label>
                                    <telerik:RadTextBox ID="TextBoxOwner" runat="server" Width="100%" RenderMode="Lightweight" Skin="Material" MaxLength="80">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="text-align: right">
                                    <asp:CompareValidator runat="server" ID="Comparevalidator6" ValueToCompare="(Not defined...)"
                                        Operator="NotEqual" ControlToValidate="cboProjectManagerId" Text="*" ErrorMessage="<span><b>Proposal By</b> is required</span>" ValidationGroup="Proposal">
                                    </asp:CompareValidator>
                                </td>
                                <td>
                                    <asp:Label ID="Label25" runat="server" AssociatedControlID="cboProjectManagerId" Text="Proposal By:"></asp:Label>
                                    <telerik:RadComboBox ID="cboProjectManagerId" runat="server"
                                        DataSourceID="SqlDataSourceEmployees2" DataTextField="Name" DataValueField="Id" MarkFirstMatch="true" Filter="Contains"
                                        Width="100%" CausesValidation="false" Height="350px" AppendDataBoundItems="True" AutoPostBack="true"
                                        RenderMode="Lightweight" Skin="Material">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Not defined...)" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>

                        </table>

                    </fieldset>
                </telerik:RadWizardStep>

                <%-- Service Fee(s) --%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStepFees" Title="Fees & Scope" Enabled="false" StepType="Step">
                    
                        <h3>Service Fee(s)</h3>
                        <table class="table-sm" style="width: 100%">
                            <tr>
                                <td>
                                    <asp:LinkButton ID="btnNewFeeOk" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false" CausesValidation="false">
                                        <i class="fas fa-plus"></i>&nbsp;&nbsp;Fee
                                    </asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td >
                                    <telerik:RadGrid ID="RadGridFees" runat="server" AllowAutomaticDeletes="True" 
                                        AutoGenerateColumns="False" DataSourceID="SqlDataSourceServiceFees" CellSpacing="0" Width="100%">
                                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceServiceFees" ShowFooter="true">
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="Id" HeaderText="ID" ReadOnly="True" SortExpression="Id" UniqueName="Id" Display="False">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridTemplateColumn DataField="taskcode" HeaderText="Task" ReadOnly="True" SortExpression="taskcode"
                                                    UniqueName="taskcode" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="160px" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="btnEditDetail" runat="server" CommandName="EditTask" CommandArgument='<%# Eval("Id") %>' CausesValidation="false"
                                                            ToolTip="Click to Edit detail">
                                                                <%# Eval("taskcode")%>
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnOrderDown" runat="server" CommandName="OrderDown" CommandArgument='<%# Eval("Id") %>' CausesValidation="false"
                                                            ToolTip="Click to Order Down">
                                                                <i class="fas fa-arrow-down"></i>
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnOrderUp" runat="server" CommandName="OrderUp" CommandArgument='<%# Eval("Id") %>' CausesValidation="false"
                                                            ToolTip="Click to Order Up">
                                                                <i class="fas fa-arrow-up"></i>
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnDuplicate" runat="server" CommandName="DetailDuplicate" CommandArgument='<%# Eval("Id") %>' UseSubmitBehavior="false" CausesValidation="false"
                                                            ToolTip="Click to duplicate record">
                                                                <i class="far fa-clone"></i>
                                                        </asp:LinkButton>

                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="Description" FilterControlAltText="Filter Description column"
                                                    HeaderText="Name" SortExpression="Description" UniqueName="Description" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <%# Eval("Description") %>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="Amount" DataType="System.Double" HeaderText="Quantity"
                                                    SortExpression="Amount" UniqueName="Amount" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right"
                                                    HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAmount" runat="server" Text='<%# Eval("Amount", "{0:N2}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="Hours" DataType="System.Double" HeaderText="Hours"
                                                    SortExpression="Hours" UniqueName="Hours" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right"
                                                    HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblHours" runat="server" Text='<%# Eval("Hours", "{0:N2}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="Rates" DataType="System.Double" HeaderText="Rates"
                                                    SortExpression="Rates" UniqueName="Rates" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right"
                                                    HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRates" runat="server" Text='<%# Eval("Rates", "{0:N2}")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn DataField="BillType" HeaderText="Bill Type" SortExpression="BillType" UniqueName="BillType"  HeaderStyle-Width="180px" >
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="Estimator" HeaderText="Estimated" ReadOnly="True"
                                                    SortExpression="Estimator" DataFormatString="{0:N2}" UniqueName="Estimated" Aggregate="Sum"
                                                    FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right"
                                                    HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="TotalRow" HeaderText="Total" ReadOnly="True"
                                                    SortExpression="TotalRow" DataFormatString="{0:N2}" UniqueName="TotalRow" Aggregate="Sum"
                                                    FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right"
                                                    HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn DataField="Paymentschedule" FilterControlAltText="Filter Paymentschedule column" ItemStyle-HorizontalAlign="Center"
                                                    HeaderText="Payment Shedule" SortExpression="Paymentschedule" UniqueName="Paymentschedule" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <%# Eval("Paymentschedule") %>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridButtonColumn ConfirmDialogType="Classic" ConfirmText="Delete this row?"
                                                    ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                                    UniqueName="DeleteColumn" HeaderText="" HeaderStyle-HorizontalAlign="Center"
                                                    HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                                                </telerik:GridButtonColumn>
                                            </Columns>
                                            
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>

                    

                </telerik:RadWizardStep>

                <%-- Term & Conditions --%>
                <telerik:RadWizardStep runat="server" ID="TC" Title="T&C" Enabled="false" StepType="Step">
                    <fieldset>
                        <legend>Term & Conditions</legend>
                        <div id="divBtnTC" runat="server" class="divBtnTC">
                            <asp:LinkButton ID="btnEditTC" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                            <i class="far fa-edit"></i>&nbsp;&nbsp;Edit
                            </asp:LinkButton>
                        </div>
                        <div id="divFormTC" runat="server" class="divFormTC" visible="false">
                            <table class="table-sm" style="width: 100%">
                                <tr>
                                    <td style="width: 50%">
                                        <telerik:RadComboBox ID="cboTandCtemplates" runat="server" DataSourceID="SqlDataSourceTandCtemplates"
                                            DataTextField="Name" DataValueField="Id" Width="400px" Height="200px" AppendDataBoundItems="true" AutoPostBack="true"
                                            ToolTip="To modify the current, select T&C template">
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text="(Select other T&C Template...)" Value="-1" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>
                                    <td style="text-align: right">
                                        <asp:LinkButton ID="btnTCUpdate" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                            <i class="fas fa-check"></i>&nbsp;&nbsp;Save
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnCloseTC" runat="server" CssClass="btn btn-secondary btn" UseSubmitBehavior="false">
                                            Close
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </table>


                        </div>


                        <asp:FormView ID="FormViewTC" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourcePropTC" Width="100%" EnableViewState="false">
                            <ItemTemplate>
                                <asp:Label ID="lblTyC" runat="server" Text='<%# Eval("Agreements")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadEditor ID="radEditor_TandC" runat="server" Content='<%# Bind("Agreements") %>'
                                    Height="400px" ToolsFile="~/BasicTools.xml" AllowScripts="True" EditModes="Design" RenderMode="Auto"
                                    Width="100%">
                                </telerik:RadEditor>
                            </EditItemTemplate>
                        </asp:FormView>
                    </fieldset>

                </telerik:RadWizardStep>

                <%-- PS --%>
                <telerik:RadWizardStep runat="server" ID="Payment" Title="Payments" Enabled="false" StepType="Step" ValidationGroup="Payments">
                    <fieldset>
                        <legend>Payments Schedule</legend>
                        <div>
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="Payments"
                                HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were errors on this step:"></asp:ValidationSummary>
                        </div>
                        <table class="table-sm" style="width: 100%">
                            <tr>
                                <td style="width: 150px; text-align:right">
                                    Retainer:
                                </td>
                                <td style="width: 250px">
                                    <telerik:RadComboBox ID="cboRetainer" runat="server" AutoPostBack="true" Width="100%" ToolTip="Send First Invoice when Proposal is Accepted">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Select Retainer option...)" Value="-1" />
                                            <telerik:RadComboBoxItem runat="server" Text="YES" Value="1" />
                                            <telerik:RadComboBoxItem runat="server" Text="NO" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                                <td style="width: 150px; text-align:right">
                                    Lump Sum:
                                </td>
                                <td>
                                    <telerik:RadCheckBox ID="chkLumpSum" runat="server" Text="Detail Totals" 
                                            ToolTip="Hide details Totals for Task in Client View" AutoPostBack="true">
                                        </telerik:RadCheckBox>
                                </td>
                            </tr>
                        </table>


                        <table class="table-sm" style="width: 100%">
                            <tr>
                                <td style="width: 350px">
                                    <telerik:RadComboBox ID="cboPaymentSchedules" runat="server" DataSourceID="SqlDataSourcePaymentSchedules"
                                        DataTextField="Name" DataValueField="Id" Width="100%" AppendDataBoundItems="true"
                                        ToolTip="Select Payment Schedules to define first time or modify the current">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Select Payment Schedules...)" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>

                                </td>
                                <td style="width: 150px">
                                    <asp:LinkButton ID="btnUpdatePS" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false" CausesValidation="true" ValidationGroup="Payments">
                                        Update
                                    </asp:LinkButton>

                                </td>
                            </tr>
                            <tr>
                                <td>If selected, upon the clients acceptance of the proposal, the first invoice of the payment schedule will be sent to the client
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <telerik:RadGrid ID="RadGridPS" runat="server" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                                        AutoGenerateColumns="False" DataSourceID="SqlDataSourcePS" HeaderStyle-HorizontalAlign="Center"
                                        CellSpacing="0" Width="100%">
                                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourcePS" ShowFooter="true">
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="Id" HeaderText="ID" SortExpression="Id" UniqueName="Id" Display="False">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="Order" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                    HeaderText="Order" SortExpression="Order" UniqueName="Order">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="Percentage" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                    HeaderText="(%)" SortExpression="Percentage" UniqueName="Percentage">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="Description"
                                                    HeaderText="Description" SortExpression="Description" UniqueName="Description">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="Amount" HeaderText="Total" ReadOnly="True"
                                                    SortExpression="Amount" DataFormatString="{0:N2}" UniqueName="Amount" Aggregate="Sum"
                                                    FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right"
                                                    HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    <div>
                        <asp:CompareValidator runat="server" ID="Comparevalidator4" ValueToCompare="(Select Retainer option...)" Display="None"
                            Operator="NotEqual" ControlToValidate="cboRetainer" ErrorMessage="<span><b>Retainer</b> is required</span>" ValidationGroup="Payments">
                        </asp:CompareValidator>
                        <asp:CompareValidator runat="server" ID="Comparevalidator3" ValueToCompare="(Select Payment Schedules...)" Display="None"
                            Operator="NotEqual" ControlToValidate="cboPaymentSchedules" ErrorMessage="<span><b>Retainer</b> is required</span>" ValidationGroup="Payments">
                        </asp:CompareValidator>
                    </div>

                </telerik:RadWizardStep>

                <%-- Attachments --%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStepAttachments" Title="Attachments" Enabled="false" StepType="Step">
                    <table class="table-sm" style="width: 100%">
                        <tr>
                            <td colspan="3">
                                <asp:Panel runat="server" class="DropZoneClient">
                                    <h4>Select or Drag and Drop files (up to 100Mb)</h4>
                                    <telerik:RadCloudUpload ID="RadCloudUpload1" runat="server" MultipleFileSelection="Automatic" OnClientUploadFailed="onClientUploadFailed"
                                        OnFileUploaded="RadCloudUpload1_FileUploaded" ProviderType="Azure"
                                        MaxFileSize="100145728"
                                        DropZones=".DropZoneClient">
                                    </telerik:RadCloudUpload>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 350px;">
                                <telerik:RadComboBox ID="cboDocType" runat="server" DataSourceID="SqlDataSourceDocTypes" DataTextField="Name" DataValueField="Id" Width="95%" ToolTip="Select file type to Upload" Label="Type:">
                                </telerik:RadComboBox>
                            </td>
                            <td style="width: 200px;">
                                <telerik:RadCheckBox ID="chkPublic" runat="server" Text="Public" ToolTip="Public or private" AutoPostBack="False">
                                </telerik:RadCheckBox>
                            </td>
                            <td style="text-align: right;">
                                <asp:LinkButton ID="btnSaveUpload" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false" ToolTip="Upload and Save selected files">
                                    <i class="fas fa-cloud-upload-alt"></i>&nbsp;&nbsp;Upload
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                    <div>
                        <telerik:RadGrid ID="RadGridAzureuploads" runat="server" DataSourceID="SqlDataSourceAzureFiles" GroupPanelPosition="Top" ShowFooter="true"
                            AllowAutomaticUpdates="True" AllowPaging="True" PageSize="25" AllowSorting="True" AllowAutomaticDeletes="True">
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id,Source" DataSourceID="SqlDataSourceAzureFiles"
                                ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small">
                                <Columns>
                                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                        HeaderText="" HeaderStyle-Width="40px">
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridTemplateColumn DataField="Source" FilterControlAltText="Filter Source column" HeaderText="Source" SortExpression="Source"
                                        UniqueName="Source" HeaderStyle-Width="100px" ItemStyle-Font-Size="X-Small">
                                        <ItemTemplate>
                                            <%# Eval("Source")%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column" HeaderText="Name" SortExpression="Name" UniqueName="Name"
                                        ItemStyle-Font-Size="Medium" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                                        <EditItemTemplate>
                                            <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="255" Width="100%"></telerik:RadTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="NameTextBox" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <a href='<%# Eval("url")%>' target="_blank" download='<%# Eval("Name") %>'><%# String.Concat(Eval("Name"), " (", Eval("ContentType"), ")")%></a>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Date" FilterControlAltText="Filter Date column" HeaderText="Date" SortExpression="Date" UniqueName="Date"
                                        HeaderStyle-Width="100px" ReadOnly="true">
                                        <ItemTemplate>
                                            <%# Eval("Date", "{0:d}")%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="nType" FilterControlAltText="Filter nType column" HeaderText="Type" SortExpression="nType" UniqueName="nType"
                                        HeaderStyle-Width="100px">
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="cboDocTypeEdit" runat="server" DataSourceID="SqlDataSourceDocTypes" DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("Type") %>' Width="100%">
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <%# Eval("nType")%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Public" FilterControlAltText="Filter Public column" HeaderText="Public" SortExpression="Public" UniqueName="Public"
                                        HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                        <EditItemTemplate>
                                            <telerik:RadCheckBox ID="chkPublicEdit" runat="server" ToolTip="Public or private" Checked='<%# Bind("Public") %>' AutoPostBack="false">
                                            </telerik:RadCheckBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <telerik:RadCheckBox ID="chkPublicEdit" runat="server" ToolTip="Public or private" Checked='<%# Eval("Public") %>' Enabled="false">
                                            </telerik:RadCheckBox>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn UniqueName="ContentBytes" Aggregate="Sum" DataFormatString="{0:N0}" ReadOnly="true"
                                        SortExpression="ContentBytes" HeaderText="Bytes" DataField="ContentBytes"
                                        HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                        CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText=""
                                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                </telerik:RadWizardStep>

                <%-- Confirmation --%>
                <telerik:RadWizardStep runat="server" Title="Preview" ID="Preview" Enabled="false" StepType="Finish">
                    <div style="text-align: right; margin: 10px">
                        <asp:LinkButton ID="btnSend" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false" ToolTip="Send Proposal to Client">
                                    <i class="far fa-envelope"></i>&nbsp;&nbsp;Send
                        </asp:LinkButton>
                    </div>
                    <div>
                        <iframe id="iframeViewProposal" runat="server" style="border: none; width: 100%; height: 550px"></iframe>
                    </div>

                </telerik:RadWizardStep>

            </WizardSteps>
        </telerik:RadWizard>
    </div>
    <div>
        <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
    </div>

    <asp:SqlDataSource ID="SqlDataSourceProposal_Step1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="PROPOSAL_Adapter" SelectCommandType="StoredProcedure"
        UpdateCommand="PROPOSAL3_Wizard_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="ProposalId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="cboClients" Name="ClientId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboType" Name="Type" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboProjectType" Name="ProjectType" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="txtProposalName" Name="ProjectName" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtProjectAddressLine" Name="ProjectLocation" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="cboSector" Name="ProjectSector" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboUse" Name="ProjectUse" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="cboUse2" Name="ProjectUse2" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="cboDepartment" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboEmployee" Name="EmployeeAprovedId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtUnit" Name="Unit" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="cboMeasure" Name="Measure" PropertyName="SelectedValue" Type="Int16" />
            <asp:ControlParameter ControlID="TextBoxOwner" Name="Owner" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="cboProjectManagerId" Name="ProjectManagerId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblProposalId" Name="Id" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProposalClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        UpdateCommand="Client_UPDATE_or_INSERT" UpdateCommandType="StoredProcedure"
        SelectCommand="CLIENT_for_NewProposal_SELECT" SelectCommandType="StoredProcedure">
        <UpdateParameters>

            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="txtClientName" Name="Name" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtClientEmail" Name="Email" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtClientPhone" Name="Phone" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtClientCompany" Name="Company" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtClientAddress" Name="Address" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtClientCity" Name="City" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtClientState" Name="State" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtClientZipCode" Name="ZipCode" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboClientType" Name="Type" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboClients" Name="Id" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="Id_OUT" Type="Int32" Direction="InputOutput" />

        </UpdateParameters>
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="cboClients" Name="clientId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENT_for_NewWizardProposal_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceType" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Proposal_types WHERE (companyId = @companyId) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [FullName] As Name FROM [Employees] WHERE companyId=@companyId and isnull(Inactive,0)=0 ORDER BY [FullName]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployees2" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [FullName] As Name FROM [Employees] WHERE companyId=@companyId and isnull(Inactive,0)=0 ORDER BY [FullName]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProjectSector" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Jobs_sectors ORDER BY Name"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProjectUse" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Jobs_uses ORDER BY Name"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProjectUandOClassification" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, [Description] FROM prj_UseLevel2 Where useId=@useId ORDER BY Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboUse" Name="useId" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceMeasure" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Jobs_measures ORDER BY Id"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceAzureFiles" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="ClientProsalJob_azureuploads_v20_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="ClientProsalJob_azureuploads_v20_DELETE" DeleteCommandType="StoredProcedure"
        UpdateCommand="ClientProsalJob_azureuploads_v20_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblClientId" Name="clientId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblProposalId" Name="ProposalId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="JobId" DefaultValue="0" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Source" />
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Id" />
            <asp:Parameter Name="Name" />
            <asp:Parameter Name="Type" />
            <asp:Parameter Name="Public" DbType="Boolean" />
            <asp:Parameter Name="Source" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceServiceFees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="PROPOSAL_details_DELETE" DeleteCommandType="StoredProcedure"
        SelectCommand="PROPOSAL_details_SELECT" SelectCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="String" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="ProposalId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <%--<asp:SqlDataSource ID="SqlDataSourceScopeOfWork" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="PROPOSAL_details_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="PROPOSAL_details_ScopeOfWork_UPDATE" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="DescriptionPlus" Type="String" />
            <asp:Parameter Name="Id" Type="String" />
        </UpdateParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="ProposalId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>--%>

    <asp:SqlDataSource ID="SqlDataSourceDocTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Jobs_azureuploads_types] ORDER BY [Id]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePositions" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Select Id, Name from Employees_Position where companyId=@companyId Order By Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProjectType" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT '' AS [Id], '(Not defined...)' AS Name  UNION ALL SELECT [Id], [Name] FROM [Jobs_types] WHERE (companyId = @companyId) ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePhases" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="PROPOSAL_phases_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="PROPOSAL_phases_DELETE" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="proposalId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePropTC" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Agreements FROM Proposal WHERE (Id = @Id)"
        UpdateCommand="Proposal_TC_Ext_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="Id" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Agreements" Type="String" />
            <asp:ControlParameter ControlID="lblProposalId" Name="Id" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTandCtemplates" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM [Proposal_TandCtemplates] WHERE ([companyId] = @companyId) ORDER BY [Name]"
        UpdateCommand="Proposal_TC_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="cboTandCtemplates" Name="tcId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblProposalId" Name="Id" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSourcePS" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Proposal_PaymentSchedule_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="Proposal_PS_v20_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="ProposalId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="cboPaymentSchedules" Name="paymentscheduleId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="lblProposalId" Name="Id" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePaymentSchedules" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Invoices_types WHERE (companyId = @companyId) ORDER BY Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClientTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Clients_types] Where companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceProposaldDetailDuplicate" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="PROPOSAL_details_DUPLICATE" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="lblDetailSelectedId" Name="ProposaldetailsId" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClientBalance" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Client_Balance" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblClientId" Name="ClientId" PropertyName="Text" Type="Int32" />
        </SelectParameters>

    </asp:SqlDataSource>

    <asp:Label ID="lblClientId" runat="server" Visible="False" Text="0"></asp:Label>
    <asp:Label ID="lblProposalId" runat="server" Visible="False" Text="0"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False" Text="0"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblDetailSelectedId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblPreProjectId" runat="server" Visible="False" Text="0"></asp:Label>
</asp:Content>

