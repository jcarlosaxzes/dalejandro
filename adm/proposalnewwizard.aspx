<%@ Page Title="Proposal" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="proposalnewwizard.aspx.vb" Inherits="pasconcept20.proposalnewwizard" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>
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

        .card-body {
            padding: 0.25rem;
        }

        .card-header {
            padding: 0 .50rem;
        }

        img {
            max-height: 96px;
            max-width: 200px;
            height: auto;
            width: auto;
        }
    </style>

    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">
            <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
                       Back to List
            </asp:LinkButton>
            Proposal
            <asp:Label ID="lblProposalNumber" runat="server"></asp:Label>
        </span>
        <span style="float: right; vertical-align: middle;">
            <asp:Panel runat="server" ID="panelProposalCreated">
                <asp:LinkButton ID="btnSaveAs" runat="server" CssClass="btn btn-secondary" UseSubmitBehavior="false" ToolTip="Save Proposal As New Propsal">
                                 Save As
                </asp:LinkButton>
                &nbsp;
                <asp:LinkButton ID="btnSaveAsTemplate" runat="server" CssClass="btn btn-secondary" UseSubmitBehavior="false" ToolTip="Save Proposal As Proposal Template">
                                 Save Template
                </asp:LinkButton>
                &nbsp;
                <a href='<%# LocalAPI.GetSharedLink_URL(111, lblProposalId.Text, False)%>' target="_blank" class="btn btn-primary">
                    <i class="far fa-share-square"></i>&nbsp;&nbsp;View Proposal
                </a>
            </asp:Panel>
        </span>
    </div>


    <div class="pasconcept-bar">
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
                                                <td style="text-align: right">Accepted Proposals:</td>
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
                                            <tr>
                                                <td style="text-align: right;">Balance 90D+:</td>
                                                <td style="color: red">
                                                    <b><%# Eval("Balance90Dplus", "{0:C2}") %></b>
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
                                    <telerik:RadComboBox ID="cboProjectType" runat="server"
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
                    <fieldset>
                        <legend>Service Fee(s)</legend>

                        <%--Panel Phases--%>
                        <asp:Panel runat="server" ID="PanelPhases">
                            <div class="pasconcept-bar noprint">
                                <span class="pasconcept-pagetitle">Proposal Phases</span>

                                <span style="float: right; vertical-align: middle;">

                                    <asp:LinkButton ID="btnNewPhase" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Add New Phase for Proposal">
                                            Add Phase
                                    </asp:LinkButton>

                                </span>
                            </div>
                            <telerik:RadGrid ID="RadGridPhases" runat="server" DataSourceID="SqlDataSourcePhases" GridLines="None" AllowAutomaticDeletes="true"
                                AutoGenerateColumns="False" CellSpacing="0" ShowFooter="true" HeaderStyle-HorizontalAlign="Center"
                                HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                                <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourcePhases">
                                    <PagerStyle Mode="Slider" AlwaysVisible="false" />
                                    <BatchEditingSettings EditType="Cell" />
                                    <CommandItemSettings ShowAddNewRecordButton="false" />
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="nOrder" HeaderStyle-Width="100px" HeaderText="Order" SortExpression="nOrder" UniqueName="nOrder" ItemStyle-HorizontalAlign="Center">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="Code" HeaderStyle-Width="100px" HeaderText="Code" SortExpression="Code" UniqueName="Code" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkPhaseEdit" runat="server" CommandName="EditPhase" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to Edit Phase">
                                                    <span class= "badge badge-pill badge-info"><%#Eval("Code")%></span>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="Task" HeaderText="Task" SortExpression="Task" UniqueName="Task" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <span title="Number of task for this Phase" class='<%#IIf(Eval("Task") = 0, "badge badge-pill badge-dark", "badge badge-pill badge-success") %>'>
                                                    <%#Eval("Task")%>
                                                </span>
                                                &nbsp;
                                                <asp:LinkButton ID="btnNewTaskInPhase" Font-Size="X-Small" runat="server" CssClass="btn btn-primary btn-sm" CommandName="AddTaskInPhase" CommandArgument='<%# Eval("Id") %>' UseSubmitBehavior="false"
                                                    ToolTip="Add New Task for this Pahse">
                                                    Add Task
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="Name" HeaderText="Name" SortExpression="Name" UniqueName="Name">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkPhaseEdit2" runat="server" CommandName="EditPhase" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to Edit Phase">
                                                    <%#Eval("Name")%>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="Period" HeaderStyle-Width="180px" HeaderText="Period" SortExpression="Period" UniqueName="Period" ItemStyle-HorizontalAlign="Left" Display="false">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="DateFrom" HeaderText="DateFrom" SortExpression="DateFrom" UniqueName="DateFrom" DataFormatString="{0:d}" HeaderStyle-Width="100px">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="DateTo" HeaderText="DateTo" SortExpression="DateTo" UniqueName="DateTo" DataFormatString="{0:d}" HeaderStyle-Width="100px">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Progress" HeaderText="Progress" SortExpression="Progress" DataFormatString="{0:N0}" UniqueName="Progress" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Total" HeaderText="Total" ReadOnly="True" SortExpression="Total" DataFormatString="{0:N2}" UniqueName="Total" Aggregate="Sum"
                                            FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this phase and its related tasks?"
                                            ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                            UniqueName="DeleteColumn" HeaderText="" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-Width="50px" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                                        </telerik:GridButtonColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </asp:Panel>

                        <%--Proposal Tasks--%>
                        <div class="pasconcept-bar noprint">
                            <span class="pasconcept-pagetitle">Proposal Tasks</span>

                            <span style="float: right; vertical-align: middle;">

                                <asp:LinkButton ID="btnNewFeeOk" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="false">
                                        Add Task
                                </asp:LinkButton>

                            </span>
                        </div>
                        <telerik:RadGrid ID="RadGridFees" runat="server" AllowAutomaticDeletes="True"
                            AutoGenerateColumns="False" DataSourceID="SqlDataSourceServiceFees" CellSpacing="0" Width="100%"
                            HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small">
                            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceServiceFees" ShowFooter="true">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="Id" HeaderText="ID" ReadOnly="True" SortExpression="Id" UniqueName="Id" Display="False">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn DataField="phaseId" HeaderText="Phase" SortExpression="PhaseCode" UniqueName="phaseId" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <%--<asp:Label ID="lblphaseId" runat="server" Text='<%# Eval("PhaseCode") %>' ToolTip='<%# Eval("PhaseName") %>'></asp:Label>--%>
                                            <span title="Phase of This Task" class="badge badge-pill badge-info">
                                                <%#Eval("PhaseCode")%>
                                            </span>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="taskcode" HeaderText="Task" ReadOnly="True" SortExpression="taskcode"
                                        UniqueName="taskcode" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEditDetail" runat="server" CommandName="EditTask" CommandArgument='<%# Eval("Id") %>' CausesValidation="false"
                                                ToolTip="Click to Edit detail">
                                                                <%# Eval("taskcode")%>
                                            </asp:LinkButton>
                                            &nbsp;
                                                        <asp:LinkButton ID="btnOrderDown" runat="server" CommandName="OrderDown" CommandArgument='<%# Eval("Id") %>' CausesValidation="false"
                                                            ToolTip="Click to Order Down">
                                                                <i class="fas fa-arrow-down"></i>
                                                        </asp:LinkButton>
                                            &nbsp;
                                                        <asp:LinkButton ID="btnOrderUp" runat="server" CommandName="OrderUp" CommandArgument='<%# Eval("Id") %>' CausesValidation="false"
                                                            ToolTip="Click to Order Up">
                                                                <i class="fas fa-arrow-up"></i>
                                                        </asp:LinkButton>
                                            &nbsp;
                                                        <asp:LinkButton ID="btnDuplicate" runat="server" CommandName="DetailDuplicate" CommandArgument='<%# Eval("Id") %>' UseSubmitBehavior="false" CausesValidation="false"
                                                            ToolTip="Click to duplicate record">
                                                                <i class="far fa-clone"></i>
                                                        </asp:LinkButton>

                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Description" FilterControlAltText="Filter Description column"
                                        HeaderText="Name" SortExpression="Description" UniqueName="Description" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEditDetail2" runat="server" CommandName="EditTask" CommandArgument='<%# Eval("Id") %>' CausesValidation="false" ToolTip="Click to Edit detail">
                                                                <%# Eval("Description") %>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Amount" DataType="System.Double" HeaderText="Quantity"
                                        SortExpression="Amount" UniqueName="Amount" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right"
                                        HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAmount" runat="server" Text='<%# Eval("Amount", "{0:N4}") %>'></asp:Label>
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
                                    <telerik:GridBoundColumn DataField="BillType" HeaderText="Bill Type" SortExpression="BillType" UniqueName="BillType" HeaderStyle-Width="180px">
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

                        <hr />
                        <%--Project History--%>
                        <div class="pasconcept-bar noprint">
                            <span class="pasconcept-pagetitle">Project History
                            </span>
                            <span style="float: right; vertical-align: middle;">
                                <asp:LinkButton ID="btnRefreshRatios" runat="server" CssClass="btn btn-info btn" UseSubmitBehavior="false" CausesValidation="false">
                                        <i class="fas fa-redo"></i>&nbsp;&nbsp;Refresh
                                </asp:LinkButton>

                            </span>
                        </div>
                        <table class="table-sm" style="width: 100%">
                            <tr>
                                <td style="width: 200px">
                                    <telerik:RadComboBox ID="cboClientRatios" runat="server" AppendDataBoundItems="True"
                                        Width="100%" CausesValidation="false" RenderMode="Lightweight" Skin="Material">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Current client...)" Value="0" />
                                            <telerik:RadComboBoxItem runat="server" Text="(All clients...)" Value="1" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                                <td style="width: 200px">
                                    <telerik:RadComboBox ID="cboDatesRates" runat="server" AppendDataBoundItems="True"
                                        Width="100%" CausesValidation="false" RenderMode="Lightweight" Skin="Material">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(From 01-01-2000)" Value="0" />
                                            <telerik:RadComboBoxItem runat="server" Text="(Last 3 Years)" Value="1" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                                <td style="width: 200px;">
                                    <telerik:RadNumericTextBox ID="txtRatio" runat="server" Text='<%# Bind("Name") %>' Width="100%" Label="Ration:" RenderMode="Lightweight" Skin="Material">
                                    </telerik:RadNumericTextBox>
                                </td>
                                <td style="width: 250px;">
                                    <telerik:RadTextBox ID="txtEstimatedTotal" runat="server" Font-Bold="true" Text='<%# Bind("Name") %>' Width="100%" Label="Estimate Total:" ReadOnly="true" Skin="Material"></telerik:RadTextBox>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="lblMeasureAndUnits"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <div>
                            <script>
                                function OnClientClose(sender, args) {
                                    var masterTable = $find("<%= RadGridRatios.ClientID %>").get_masterTableView();
                                    masterTable.rebind();
                                }
                            </script>
                            <telerik:RadGrid ID="RadGridRatios" runat="server" DataSourceID="SqlDataSourceRatios" Width="100%"
                                HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" HeaderStyle-HorizontalAlign="Center"
                                AutoGenerateColumns="False" AllowPaging="True" PageSize="25" AllowSorting="True">
                                <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceRatios">
                                    <PagerStyle Mode="Slider" AlwaysVisible="false" />
                                    <Columns>

                                        <telerik:GridTemplateColumn HeaderText="-"
                                            UniqueName="RemoveRow" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnRemoveRow" runat="server" CommandName="RemoveRow" CommandArgument='<%# Eval("Id") %>' CausesValidation="false"
                                                    ToolTip="Click to RemoveRow">
                                                                <i class="fas fa-minus"></i>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridBoundColumn DataField="Open_date" DataFormatString="{0:d}" DataType="System.DateTime"
                                            HeaderText="Date" SortExpression="Open_date" UniqueName="Open_date"
                                            ItemStyle-HorizontalAlign="Right" AllowFiltering="False" HeaderStyle-Width="100px">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="Job" HeaderText="Project - Client" SortExpression="Job" UniqueName="Job"
                                            ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <%# Eval("Source")%>:  
                                            <asp:LinkButton ID="btnEditJob" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Click to Edit Job"
                                                CommandName="EditJob" UseSubmitBehavior="false" Enabled='<%# Eval("Source") = "Job" %>'>
                                                <%# Eval("Job")%>
                                            </asp:LinkButton>
                                                -- <%# Eval("Client")%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="Budget" HeaderText="Budget" SortExpression="Budget" UniqueName="Budget" DataFormatString="{0:N2}"
                                            ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="100px">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Unit" HeaderText="Unit" SortExpression="Unit" UniqueName="Unit" DataFormatString="{0:N2}"
                                            ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="100px">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Hours" HeaderText="Hours" SortExpression="Hours" UniqueName="Hours" DataFormatString="{0:N1}"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Cost" HeaderText="Cost" SortExpression="Cost" UniqueName="Cost" DataFormatString="{0:N2}"
                                            ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="100px" HeaderTooltip="[Cost]= SUM(Time)*EmployeeHR*Multiplier">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="AdjustedToDate" HeaderText="Adjusted" SortExpression="AdjustedToDate" UniqueName="AdjustedToDate" DataFormatString="{0:N2}"
                                            ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="100px" ItemStyle-ForeColor="Red" HeaderTooltip="[Adjusted To Date]= SUM(Time)*PositionHR">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridTemplateColumn DataField="CosteByUnit" HeaderText="Cost/Unit" SortExpression="CosteByUnit" UniqueName="CosteByUnit"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" HeaderTooltip="CosteByUnit=[Budget]/[Unit]">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnCosteByUnit" runat="server" CommandName="CosteByUnit" CommandArgument='<%# Eval("CosteByUnit") %>' CausesValidation="false"
                                                    ToolTip="Click to Calculate Estaimated Total" CssClass="btn btn-warning btn-sm" Width="100%" Visible='<%# Eval("CosteByUnit") > 0 %>'>
                                                    <%# Eval("CosteByUnit", "{0:N2}") %>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>


                                        <telerik:GridTemplateColumn DataField="AdjustedByUnit" HeaderText="Ajusted/Unit" SortExpression="AdjustedByUnit" UniqueName="AdjustedByUnit"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" HeaderTooltip="AdjustedByUnit=[Budget]/[Unit]">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnAdjustedByUnit" runat="server" CommandName="AdjustedByUnit" CommandArgument='<%# Eval("AdjustedByUnit") %>' CausesValidation="false"
                                                    ToolTip="Click to Calculate Estaimated Total" CssClass="btn btn-danger btn-sm" Width="100%" Visible='<%# Eval("AdjustedByUnit") > 0 %>'>
                                                    <%# Eval("AdjustedByUnit", "{0:N2}") %>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn DataField="HourByUnit" HeaderText="Hours/Unit" SortExpression="HourByUnit" UniqueName="HourByUnit"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" HeaderTooltip="HourByUnit=[Budget]/[Unit]">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnHourByUnit" runat="server" CommandName="HourByUnit" CommandArgument='<%# Eval("HourByUnit") %>' CausesValidation="false"
                                                    ToolTip="Click to Calculate Estaimated Total" CssClass="btn btn-dark btn-sm" Width="100%" Visible='<%# Eval("HourByUnit") > 0 %>'>
                                                    <%# Eval("HourByUnit", "{0:N2}") %>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>


                                        <telerik:GridTemplateColumn DataField="BudgetByUnit" HeaderText="Budget/Unit" SortExpression="BudgetByUnit" UniqueName="BudgetByUnit"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" HeaderTooltip="BudgetByUnit=[Budget]/[Unit]">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnBudgetByUnit" runat="server" CommandName="BudgetByUnit" CommandArgument='<%# Eval("BudgetByUnit") %>' CausesValidation="false"
                                                    ToolTip="Click to Calculate Estaimated Total" CssClass="btn btn-success btn-sm" Width="100%" Visible='<%# Eval("BudgetByUnit") > 0 %>'>
                                                    <%# Eval("BudgetByUnit", "{0:N2}") %>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                    </fieldset>
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
                                            <i class="fas fa-check"></i>&nbsp;&nbsp;Update
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
                                    Height="400px" ToolsFile="~/BasicTools.xml" AllowScripts="True" EditModes="Design,Preview" RenderMode="Auto"
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
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="Payments" ForeColor="Red"
                                HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were errors on this step:"></asp:ValidationSummary>
                        </div>
                        <table class="table-sm" style="width: 100%">
                            <tr>
                                <td style="width: 220px; text-align: right">Retainer:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cboRetainer" runat="server" AutoPostBack="true" Width="250px" ToolTip="Send First Invoice when Proposal is Accepted">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Select Retainer option...)" Value="-1" />
                                            <telerik:RadComboBoxItem runat="server" Text="YES" Value="1" />
                                            <telerik:RadComboBoxItem runat="server" Text="NO" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Lump Sum (Hide Totals):
                                </td>
                                <td>
                                    <telerik:RadCheckBox ID="chkLumpSum" runat="server"
                                        ToolTip="Hide details Totals for Task in Client View" AutoPostBack="true">
                                    </telerik:RadCheckBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Payment Schedule:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cboPaymentSchedules" runat="server" DataSourceID="SqlDataSourcePaymentSchedules"
                                        DataTextField="Name" DataValueField="Id" Width="400px" AppendDataBoundItems="true"
                                        ToolTip="Select Payment Schedules to define first time or modify the current">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Select Payment Schedules...)" Value="0" />
                                            <telerik:RadComboBoxItem runat="server" Text="Payment Schedule defined in Service Fee(s)!" Value="-1" ForeColor="Red" Font-Italic="true" Enabled="false" />
                                        </Items>
                                    </telerik:RadComboBox>
                                    <asp:LinkButton ID="btnUpdatePS" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false" CausesValidation="true" ValidationGroup="Payments">
                                        Update
                                    </asp:LinkButton>
                                </td>


                            </tr>
                        </table>

                        <div style="padding-top: 15px">
                            <telerik:RadGrid ID="RadGridPS" runat="server" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                                AutoGenerateColumns="False" DataSourceID="SqlDataSourcePS" HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small"
                                CellSpacing="0" Width="100%">
                                <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourcePS" ShowFooter="true" EditMode="EditForms">
                                    <Columns>
                                        <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                            HeaderText="" HeaderStyle-Width="50px">
                                        </telerik:GridEditCommandColumn>
                                        <telerik:GridBoundColumn DataField="Id" HeaderText="ID" SortExpression="Id" UniqueName="Id" Display="False" ReadOnly="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="taskcode" ItemStyle-HorizontalAlign="Center" ReadOnly="true" HeaderStyle-Width="150px"
                                            HeaderText="Task" SortExpression="taskcode" UniqueName="taskcode">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="Description" HeaderText="Description" SortExpression="Description" UniqueName="Description">
                                            <ItemTemplate>
                                                <%# Eval("Description") %>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox Width="960px" ID="txtPSDescrip" runat="server" MaxLength="512" RenderMode="Lightweight" TextMode="MultiLine" Rows="2" Text='<%# Bind("Description") %>'>
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="Percentage" ItemStyle-HorizontalAlign="Center" ReadOnly="true" HeaderStyle-Width="100px"
                                            HeaderText="(%)" SortExpression="Percentage" UniqueName="Percentage">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="InvoiceNumber" ItemStyle-HorizontalAlign="Center" ReadOnly="true" HeaderStyle-Width="150px"
                                            HeaderText="" SortExpression="InvoiceNumber" UniqueName="InvoiceNumber">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Amount" HeaderText="Total" ReadOnly="True" SortExpression="Amount" DataFormatString="{0:N2}" UniqueName="Amount" Aggregate="Sum" HeaderStyle-Width="150px"
                                            FooterAggregateFormatString="{0:N2}" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right">
                                        </telerik:GridBoundColumn>
                                    </Columns>
                                    <EditFormSettings EditColumn-ItemStyle-Width="900px">
                                        <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                                        </EditColumn>
                                    </EditFormSettings>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                        <table class="table-sm" style="width: 100%">
                            <tr style="text-align: right">
                                <td>Totals:
                                </td>
                                <td>
                                    <table style="width: 400px">
                                        <tr>
                                            <td style="text-align: center; width: 50%">Proposal Total
                                            </td>
                                            <td style="text-align: center;">Payment Schedule Total
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center">
                                                <asp:Label ID="lblProposalTotal" runat="server"></asp:Label>
                                            </td>
                                            <td style="text-align: center">
                                                <asp:Label ID="lblScheduleTotal" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="text-align: center">
                                                <asp:Label ID="lblTotalAlert" runat="server" ForeColor="Red"></asp:Label>
                                            </td>
                                        </tr>

                                    </table>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    <div>
                        <asp:CompareValidator runat="server" ID="Comparevalidator4" ValueToCompare="(Select Retainer option...)" Display="None"
                            Operator="NotEqual" ControlToValidate="cboRetainer" ErrorMessage="<span><b>Retainer</b> is required</span>" ValidationGroup="Payments">
                        </asp:CompareValidator>
                        <asp:CompareValidator runat="server" ID="Comparevalidator3" ValueToCompare="(Select Payment Schedules...)" Display="None"
                            Operator="NotEqual" ControlToValidate="cboPaymentSchedules" ErrorMessage="<span>Select and Update <b>Payment Schedules</b></span>" ValidationGroup="Payments">
                        </asp:CompareValidator>
                    </div>

                </telerik:RadWizardStep>

                <%-- Attachments --%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStepAttachments" Title="Attachments" Enabled="false" StepType="Step">
                    <div class="pas-container" style="width: 100%">
                        <asp:Panel ID="PanelUpload" runat="server">
                            <table class="table-sm pasconcept-bar noprint" style="width: 100%">
                                <tr>
                                    <td style="width: 550px; text-align: right">
                                        <asp:LinkButton ID="btnListFiles" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" ToolTip="Table view" OnClick="btnListFiles_Click">
                                                               <i class="fas fa-align-justify"></i>&nbsp;&nbsp;View Files
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <telerik:RadWizard ID="RadWizardFiles" runat="server" DisplayCancelButton="false" DisplayProgressBar="false"
                            DisplayNavigationButtons="false" RenderMode="Lightweight" Skin="Silk" DisplayNavigationBar="false">
                            <WizardSteps>
                                <%--Upload Files--%>
                                <telerik:RadWizardStep runat="server" ID="RadWizardStepUpload" Title="Upload Files" StepType="Step">
                                    <asp:Panel ID="UploadPanel" runat="server">
                                        <div style="width: 100%; height: 500px; position: relative">
                                            <table class="table-sm" style="width: 100%; position: absolute; margin-top: 0px; background-color: lightgray;">
                                                <tr>
                                                    <td style="width: 40%;">
                                                        <telerik:RadComboBox ID="cboDocType" runat="server" DataSourceID="SqlDataSourceDocTypes" Label="File type:" DataTextField="Name" DataValueField="Id" Width="100%">
                                                        </telerik:RadComboBox>
                                                    </td>
                                                    <td style="width: 30%;">
                                                        <telerik:RadCheckBox ID="chkPublic" runat="server" Text="Public" ToolTip="Public or private" AutoPostBack="false"></telerik:RadCheckBox>
                                                    </td>
                                                    <td style="width: 30%;" rowspan="2">
                                                        <asp:LinkButton ID="btnSaveUpload" runat="server" CssClass="btn btn-success btn float-right" UseSubmitBehavior="false" ToolTip="Upload and Save selected files">
                                                    <i class="fas fa-cloud-upload-alt"></i>&nbsp;&nbsp;Upload
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                            <div class="uploadfiles-canvas">
                                                <%--<telerik:RadCloudUpload ID="RadCloudUpload1" runat="server" RenderMode="Lightweight" MultipleFileSelection="Automatic" OnFileUploaded="RadCloudUpload1_FileUploaded"          CssClass="fileUploadRad" DropZones=".uploadfiles-canvas,#UploadPanel" ProviderType="Azure" MaxFileSize="1048576">
                                                    <FileListPanelSettings PanelContainerSelector=".uploadfiles-canvas" />
                                                </telerik:RadCloudUpload>
                                                <p style="text-align: center; vertical-align: middle; padding-top: 100px; font-size: 36px">Upload your files</p>--%>
                                                <p style="text-align: center; vertical-align: middle; padding-top: 150px;">
                                                    <i style="font-size: 96px" class="fas fa-cloud-upload-alt"></i>
                                                    <br />
                                                    <span style="font-size: 36px">Drag & Drop Files here, or
                                                    </span>
                                                    <br />
                                                    <br />
                                                    <br />
                                                    <span style="font-size: 36px">
                                                        <telerik:RadCloudUpload ID="RadCloudUpload1" runat="server" RenderMode="Lightweight" MultipleFileSelection="Automatic" ProviderType="Azure" MaxFileSize="1048576"
                                                            OnFileUploaded="RadCloudUpload1_FileUploaded"
                                                            CssClass="fileUploadRad"
                                                            DropZones=".uploadfiles-canvas,#UploadPanel">
                                                            <Localization SelectButtonText="Select Files" />
                                                        </telerik:RadCloudUpload>
                                                    </span>
                                                </p>

                                            </div>

                                        </div>
                                    </asp:Panel>
                                </telerik:RadWizardStep>

                                <%--Files--%>
                                <telerik:RadWizardStep runat="server" ID="RadWizardStepFiles" Title="Files" StepType="Step">
                                    <div>
                                        <asp:Panel ID="pnlFind" runat="server">
                                            <table class="table-sm pasconcept-bar noprint" style="width: 100%">
                                                <tr>
                                                    <td style="width: 550px; text-align: right">
                                                        <asp:LinkButton ID="btnTablePage" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" ToolTip="Table view" OnClick="btnTablePage_Click">
                                                               <i class="fas fa-align-justify"></i> Table
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnGridPage" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" ToolTip="Table view" OnClick="btnTablePage_Click" Visible="false">
                                                               <i class="fas fa-th"></i> Grid
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnUploadFiles" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" OnClick="btnUploadFiles_Click">
                                                               <i class="fas fa-cloud-upload-alt"></i>&nbsp;&nbsp; Uploads
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnBulkDelete" runat="server"
                                                            CssClass="btn btn-danger" UseSubmitBehavior="false">
                                                               <i class="fas fa-trash"></i>&nbsp;Bulk Delete
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnBulkEdit" runat="server"
                                                            CssClass="btn btn-primary" UseSubmitBehavior="false">
                                                               <i class="fas fa-pencil-alt"></i>&nbsp; Bulk Update
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>

                                        <telerik:RadListView ID="RadListViewFiles" runat="server" DataSourceID="SqlDataSourceAzureFiles" DataKeyNames="Id" ItemPlaceholderID="Container1" BorderStyle="Solid" AllowMultiItemSelection="true">
                                            <LayoutTemplate>
                                                <fieldset style="width: 100%; text-align: center">
                                                    <asp:PlaceHolder ID="Container1" runat="server"></asp:PlaceHolder>
                                                </fieldset>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <div class="card" style="float: left; width: 230px; margin: 2px">
                                                    <div class="card-header">
                                                        <asp:LinkButton ID="LinkButton1" CssClass="selectedButtons" runat="server" CommandName="Select">
                                                                <i class="far fa-square" aria-hidden="true" style="float: left;margin-top: 10px;color: black;"></i>
                                                        </asp:LinkButton>

                                                        <b style="display: inline-block; height: 22px; overflow: hidden; margin-top: 5px; width: 80%;" title="<%# Eval("Name")%> "><%# LocalAPI.TruncateString(Eval("Name"), 20)%> </b>

                                                        <asp:LinkButton ID="LinkButton2" CssClass="selectedButtons" runat="server" CommandName="Update">
                                                            <i class="far fa-edit" aria-hidden="true" style="float: right;margin-top: 10px;color: black;"></i>
                                                        </asp:LinkButton>
                                                    </div>
                                                    <div class="card-body" style="padding: 0px; margin-top: -6px;">
                                                        <asp:LinkButton ID="btnNewTime2" runat="server" UseSubmitBehavior="false" CommandName="AddNewTime" CommandArgument='<%# Eval("Id")%>' ForeColor="Black" Font-Underline="false">
                                                            <table style="width: 100%; flex-wrap: nowrap; text-overflow: ellipsis; overflow: hidden;">
                                                                <tr>
                                                                    <td style="height: 108px; padding: 0px;">
                                                                        <%# LocalAPI.CreateIcon(Eval("ContentType"), Eval("url"), Eval("Name"), 96)%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: 12px; padding-top: 5px; padding-bottom: 0px;">
                                                                        <%# FormatSource(Eval("Source"))%>:&nbsp <%# Eval("Document")%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: 12px; padding: 0;">
                                                                        <%# Eval("Date", "{0:d}")%>,&nbsp;&nbsp;
                                                                             <%#  LocalAPI.FormatByteSize(Eval("ContentBytes"))%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: 12px; padding: 0;">Type:   <%# Eval("nType")%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: 12px; padding: 0;">
                                                                        <%#IIf(Eval("Public"), "Public", "Private") %>

                                                                        <asp:Label ID="lblPubicHide" runat="server" Visible="False" Text='<%# Eval("Public") %>'></asp:Label>
                                                                        <asp:Label ID="lblTypeHide" runat="server" Visible="False" Text='<%# Eval("Type") %>'></asp:Label>
                                                                        <asp:Label ID="lblNameHide" runat="server" Visible="False" Text='<%# Eval("Name") %>'></asp:Label>
                                                                    </td>
                                                                </tr>

                                                            </table>
                                                        </asp:LinkButton>

                                                    </div>
                                                </div>

                                            </ItemTemplate>
                                            <SelectedItemTemplate>
                                                <div class="card" style="float: left; width: 230px; margin: 2px">
                                                    <div class="card-header">
                                                        <asp:LinkButton ID="LinkButton1" CssClass="selectedButtons" runat="server" CommandName="Deselect">
                                                            <i class="fa fa-check-square" aria-hidden="true" style="float: left;margin-top: 10px;color: black;"></i>
                                                        </asp:LinkButton>

                                                        <b style="display: inline-block; height: 22px; overflow: hidden; margin-top: 5px; width: 80%;" title="<%# Eval("Name")%> "><%# LocalAPI.TruncateString(Eval("Name"), 20)%> </b>

                                                        <asp:LinkButton ID="LinkButton2" CssClass="selectedButtons" runat="server" CommandName="Update">
                                                            <i class="far fa-edit" aria-hidden="true" style="float: right;margin-top: 10px;color: black;"></i>
                                                        </asp:LinkButton>
                                                    </div>
                                                    <div class="card-body" style="padding: 0px; margin-top: -6px;">
                                                        <asp:LinkButton ID="btnNewTime2" runat="server" UseSubmitBehavior="false" CommandName="AddNewTime" CommandArgument='<%# Eval("Id")%>' ForeColor="Black" Font-Underline="false">
                                                            <table style="width: 100%; flex-wrap: nowrap; text-overflow: ellipsis; overflow: hidden;">
                                                                <tr>
                                                                    <td style="height: 108px; padding: 0px">
                                                                        <%# LocalAPI.CreateIcon(Eval("ContentType"), Eval("url"), Eval("Name"), 96)%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: 12px; padding-top: 5px; padding-bottom: 0px;">
                                                                        <asp:Label ID="lblFileName" runat="server" Visible="False" Text='<%# Bind("Name") %>'></asp:Label>
                                                                        <%# FormatSource(Eval("Source"))%>:&nbsp <%# Eval("Document")%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: 12px; padding: 0;">
                                                                        <%# Eval("Date", "{0:d}")%>,&nbsp;&nbsp;
                                                                         <%#  LocalAPI.FormatByteSize(Eval("ContentBytes"))%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: 12px; padding: 0;">Type:   <%# Eval("nType")%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size: 12px; padding: 0;">
                                                                        <%#IIf(Eval("Public"), "Public", "Private") %>

                                                                        <asp:Label ID="lblPubicHide" runat="server" Visible="False" Text='<%# Eval("Type") %>'></asp:Label>
                                                                        <asp:Label ID="lblTypeHide" runat="server" Visible="False" Text='<%# Eval("Name") %>'></asp:Label>
                                                                        <asp:Label ID="lblNameHide" runat="server" Visible="False" Text='<%# Eval("Name") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:LinkButton>

                                                    </div>
                                                </div>
                                            </SelectedItemTemplate>
                                        </telerik:RadListView>

                                        <telerik:RadGrid ID="RadGridFiles" runat="server" DataSourceID="SqlDataSourceAzureFiles" GridLines="None" Visible="false"
                                            AllowPaging="True" PageSize="25" AutoGenerateColumns="False" HeaderStyle-HorizontalAlign="Center" OnItemCommand="RadGridFiles_ItemCommand" AllowMultiRowSelection="true">
                                            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceAzureFiles"
                                                HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                                                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                                                <Columns>
                                                    <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                                                    </telerik:GridClientSelectColumn>
                                                    <telerik:GridBoundColumn DataField="Id" HeaderText="Id" ReadOnly="True" UniqueName="Id" Display="false" HeaderStyle-Width="40px">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridTemplateColumn DataField="Name" HeaderText="FileName" UniqueName="Name" SortExpression="Name" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-Width="300px" HeaderStyle-HorizontalAlign="Left">
                                                        <ItemTemplate>
                                                            <%# LocalAPI.CreateIcon(Eval("ContentType"), Eval("url"), Eval("Name"), 16)%>
                                                            &nbsp;&nbsp;
                                                            <%# Eval("Name")%>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="Type" HeaderText="Type" UniqueName="Type" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <%# Eval("nType")%>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="Public" HeaderText="Public" UniqueName="Public" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <%#IIf(Eval("Public"), "Public", "Private") %>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="Source" HeaderText="Source" UniqueName="Source" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <%# FormatSource(Eval("Source"))%>:&nbsp <%# Eval("Document")%>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="Size" HeaderText="Size" UniqueName="Size" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <%#  LocalAPI.FormatByteSize(Eval("ContentBytes"))%>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="Date" HeaderText="Date" UniqueName="Date" SortExpression="Date" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center" Aggregate="Count">
                                                        <ItemTemplate>
                                                            <%# Eval("Date", "{0:d}")%>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>


                                                    <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="Actions" HeaderStyle-HorizontalAlign="Center"
                                                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                                                        <ItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Update" CommandArgument='<%# Eval("Id") %>' ToolTip="Edit">
                                                                            <span class="fas fa-edit"></span>
                                                                        </asp:LinkButton>
                                                                    </td>
                                                                    <td>&nbsp;&nbsp;
                                                                    </td>
                                                                    <td>
                                                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("Id") %>' ToolTip="Edit">
                                                                            <span class="fas fa-trash"></span>
                                                                        </asp:LinkButton>
                                                                        <asp:Label ID="lblPubicHide" runat="server" Visible="False" Text='<%# Eval("Public") %>'></asp:Label>
                                                                        <asp:Label ID="lblTypeHide" runat="server" Visible="False" Text='<%# Eval("Type") %>'></asp:Label>
                                                                        <asp:Label ID="lblNameHide" runat="server" Visible="False" Text='<%# Eval("Name") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>

                                            </MasterTableView>

                                            <ClientSettings>
                                                <Selecting AllowRowSelect="true" />
                                            </ClientSettings>
                                        </telerik:RadGrid>

                                    </div>
                                </telerik:RadWizardStep>
                            </WizardSteps>
                        </telerik:RadWizard>
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

    <telerik:RadWindowManager ID="RadWindowManagerJob" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>



    <telerik:RadToolTip ID="RadToolTipBulkEdit" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

        <table class="table table-bordered" style="width: 500px">
            <tr>
                <td colspan="2">
                    <h3 style="margin: 0; text-align: center; color: white; width: 600px">
                        <span class="navbar navbar-expand-md bg-dark text-white">Update Files</span>
                    </h3>
                </td>
            </tr>
            <tr>
                <td style="width: 20%;">
                    <telerik:RadComboBox ID="cboDocTypeBulk" runat="server" DataSourceID="SqlDataSourceDocTypes" ZIndex="10000" Label="File type:" DataTextField="Name" DataValueField="Id" Width="100%">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="width: 20%;">
                    <telerik:RadCheckBox ID="chkPublicBulk" runat="server" Text="Public" ToolTip="Public or private" AutoPostBack="false"></telerik:RadCheckBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <asp:LinkButton ID="btnUpdateStatus" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" Width="120px" ValidationGroup="Reconcile">
                                    <i class="fas fa-check"></i> Update
                    </asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCance" runat="server" CssClass="btn btn-secondary btn" CausesValidation="false" UseSubmitBehavior="false" Width="120px">
                                     Cancel
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipBulkDelete" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h3 style="margin: 0; text-align: center; color: white; width: 600px">
            <span class="navbar navbar-expand-md bg-dark text-white">Delete Files
            </span>
        </h3>
        <table class="table-sm" style="width: 600px">
            <tr>
                <td>Are you sure you want to delete selected Files?
                </td>
            </tr>
            <tr>
                <td>
                    <asp:LinkButton ID="btnConfirmDelete" runat="server" CssClass="btn btn-danger" Width="150px" UseSubmitBehavior="false">
                             Delete 
                    </asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCancelDelete" runat="server" CssClass="btn btn-secondary" Width="150px" UseSubmitBehavior="false">
                             Cancel
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

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
        SelectCommand="ClientProsalJob_azureuploads_v20_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="clientId" DefaultValue="0" />
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
        UpdateCommand="Proposal_PaymentScheduleDescription_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="ProposalId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProposalPSUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        UpdateCommand="Proposal_PS_v20_UPDATE" UpdateCommandType="StoredProcedure">
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

    <asp:SqlDataSource ID="SqlDataSourceRatios" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOBS_Ratios_V20_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblProposalId" Name="proposalId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="DateFrom" />
            <asp:Parameter Name="DateTo" />
            <asp:ControlParameter ControlID="cboProjectType" Name="jobType" PropertyName="SelectedValue" />
            <asp:Parameter Name="clientId" />
            <asp:ControlParameter ControlID="lblExcludeJobsList" Name="ExcludeJobsList" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
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

    <asp:Label ID="lblClientId" runat="server" Visible="False" Text="0"></asp:Label>
    <asp:Label ID="lblProposalId" runat="server" Visible="False" Text="0"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False" Text="0"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblDetailSelectedId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblPreProjectId" runat="server" Visible="False" Text="0"></asp:Label>
    <asp:Label ID="lblExcludeJobsList" runat="server" Visible="False" Text="0"></asp:Label>
    <asp:Label ID="lblSelectedId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedName" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblProposalStatus" runat="server" Visible="False" Text="0"></asp:Label>
</asp:Content>

