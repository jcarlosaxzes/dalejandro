<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="40yearsreqquote.aspx.vb" Inherits="pasconcept20._40yearsreqquote" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Request for 40 Years Project</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" />
    <style type="text/css">
        .form-group {
            margin: 10px !important;
            font-style: italic;
        }

        form-group-address {
            margin: 1px !important;
        }

        .btn {
            display: inline-block;
            padding: 6px 12px;
            margin-bottom: 0;
            font-size: 14px;
            font-weight: normal;
            line-height: 1.42857143;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            -ms-touch-action: manipulation;
            touch-action: manipulation;
            cursor: pointer;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
            background-image: none;
            border: 1px solid transparent;
            border-radius: 4px;
            font-family: inherit;
            font-weight: 700;
            line-height: 1.1;
        }

        .btn-primary {
            background-color: #18a689;
            border-color: #18a689;
            color: #FFFFFF;
        }

            .btn-primary:hover,
            .btn-primary:focus,
            .btn-primary:active,
            .btn-primary.active,
            .open .dropdown-toggle.btn-primary {
                background-color: #18a689;
                border-color: #18a689;
                color: #FFFFFF;
            }

        .pull-right {
            float: right !important;
        }

        .clearfix {
            display: table;
            content: " ";
            clear: both;
        }


        .validator {
            color: Red !important;
        }

        validator-message-right {
            margin: 30px !important;
            width: 30% !important;
        }


        html body .riSingle .riTextBox {
            margin: 3px !important;
        }

        .icon-input {
            padding-left: 30px !important;
            margin: 3px !important;
        }

        h3 {
            orphans: 3;
            widows: 3;
            font-family: inherit;
            font-weight: 700;
            line-height: 1.1;
            color: inherit;
            margin-bottom: 15px;
            margin-top: 15px;
            margin-left: 17px;
            font-size: 24px;
            letter-spacing: -1.5px;
        }

        .inner-addon {
            position: relative;
        }

            /* style icon */
            .inner-addon .glyphicon {
                position: absolute;
                padding: 10px;
                pointer-events: none;
                align-content: center;
            }

        /* align icon */
        .left-addon .glyphicon {
            left: 0px;
        }

        .right-addon .glyphicon {
            right: 0px;
        }

        /* add padding  */
        .left-addon input {
            padding-left: 30px;
        }

        .right-addon input {
            padding-right: 30px;
        }

        .icon-style {
            width: 1%;
            color: #18a689;
        }
    </style>
</head>
<body style="width: 320px; color: #676a6c">

    <form id="form1" runat="server">
        <div>
            <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
            </telerik:RadScriptManager>

           <%-- <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
                <AjaxSettings>
                    <telerik:AjaxSetting AjaxControlID="FormViewUser">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="FormViewUser" LoadingPanelID="RadAjaxLoadingPanel1" />
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                </AjaxSettings>
            </telerik:RadAjaxManager>
            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"  EnableEmbeddedSkins="false" />
            <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
            </telerik:RadWindowManager>--%>

            <asp:FormView ID="FormViewUser" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceInsertClient"
                DefaultMode="Insert"
                Style="width: 320px">
                <InsertItemTemplate>

                    <div class="form-horizontal">
                        <h3>Submit Request</h3>

                        <div class="form-group inner-addon left-addon">
                            <i class="glyphicon glyphicon-user icon-style"></i>
                            <telerik:RadTextBox runat="server" Width="95%" ID="txtFirstName" placeholder="First Name" Text='<%# Bind("FirstName") %>' ToolTip="First Name" CssClass="form-control icon-input" />
                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="txtFirstName"
                                CssClass="validator"
                                Display="Static"
                                ValidationGroup="Client"
                                Text="*"
                                SetFocusOnError="true"
                                Width="1%" />
                        </div>

                        <div class="form-group inner-addon left-addon">
                            <i class="glyphicon glyphicon-user icon-style"></i>
                            <telerik:RadTextBox runat="server" Width="95%" ValidationGroup="Client" ID="txtLastName" placeholder="Last Name" Text='<%# Bind("LastName") %>' ToolTip="Last Name" CssClass="form-control icon-input" />
                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="txtLastName"
                                CssClass="validator"
                                Display="Static"
                                ValidationGroup="Client"
                                Text="*"
                                SetFocusOnError="true"
                                Width="1%" />
                        </div>

                        <div class="form-group inner-addon left-addon">
                            <i class="glyphicon glyphicon-envelope icon-style" style="width: 1%"></i>
                            <telerik:RadTextBox runat="server" Width="95%" ValidationGroup="Client" ID="txtEmail" placeholder="Email" Text='<%# Bind("Email") %>' ToolTip="Email" CssClass="form-control icon-input" />
                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="txtEmail"
                                CssClass="validator"
                                Display="Static"
                                ValidationGroup="Client"
                                Text="*"
                                SetFocusOnError="true"
                                Width="1%" />
                            <asp:RegularExpressionValidator
                                ID="RegularExpressionValidatorEmial"
                                runat="server"
                                ControlToValidate="txtEmail"
                                Text="Invalid Email"
                                ValidationExpression="^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,})$"
                                ValidationGroup="Client"
                                Display="Dynamic"
                                SetFocusOnError="true"
                                CssClass="validator" />
                        </div>

                        <div class="form-group inner-addon left-addon">
                            <i class="glyphicon glyphicon-phone icon-style" style="width: 1%"></i>
                            <telerik:RadTextBox ID="txtPhone" Width="95%" ValidationGroup="Client" runat="server" placeholder="Phone" Text='<%# Bind("Phone") %>' ToolTip="Phone" CssClass="form-input-phone form-control icon-input"></telerik:RadTextBox>
                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="txtPhone"
                                CssClass="validator"
                                Display="Static"
                                ValidationGroup="Client"
                                Text="*"
                                SetFocusOnError="true"
                                Width="1%" />
                        </div>

                        <h3>Project Info</h3>

                        <div class="form-group inner-addon left-addon">
                            <i class="glyphicon glyphicon-map-marker icon-style" style="width: 1%"></i>
                            <telerik:RadTextBox runat="server" Width="95%" ID="txtAddress" EmptyMessage="Address" Text='<%# Bind("Address") %>' ToolTip="Address" CssClass="form-control icon-input input-address" />
                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="txtAddress"
                                CssClass="validator"
                                Display="Static"
                                ValidationGroup="Client"
                                Text="*"
                                SetFocusOnError="true"
                                Width="3%" />
                        </div>

                        <div class="form-group">


                            <telerik:RadTextBox runat="server" ID="txtCity" Width="30%" placeholder="City" Text='<%# Bind("City") %>' ToolTip="City" CssClass="form-control input-city" />
                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="txtCity"
                                CssClass="validator form-group-address"
                                Display="Static"
                                ValidationGroup="Client"
                                Text="*"
                                SetFocusOnError="true"
                                Width="2%" />



                            <telerik:RadTextBox runat="server" ID="txtState" Width="28%" placeholder="State" Text='<%# Bind("State") %>' ToolTip="State" CssClass="form-control input-state" />
                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="txtState"
                                CssClass="validator form-group-address"
                                Display="Static"
                                ValidationGroup="Client"
                                Text="*"
                                SetFocusOnError="true"
                                Width="2%" />



                            <telerik:RadTextBox runat="server" ID="txtZip" Width="28%" placeholder="Zip Code" Text='<%# Bind("Zip") %>' ToolTip="Zip" CssClass="form-control  input-zip" MaxLength="5" />
                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="txtZip"
                                CssClass="validator form-group-address"
                                Display="Static"
                                ValidationGroup="Client"
                                Text="*"
                                SetFocusOnError="true"
                                Width="2%" />


                            <div style="width: 100%">
                                <%--<asp:RegularExpressionValidator
                                    ID="RegularExpressionValidator1"
                                    runat="server"
                                    ControlToValidate="txtCity"
                                    Text="Invalid City"
                                    ValidationExpression="^[a-z]+$"
                                    ValidationGroup="Client"
                                    Display="Dynamic"
                                    SetFocusOnError="true"
                                    CssClass="validator pull-left"
                                    Style="margin-left: 5px"
                                    Width="25%" />--%>


                                <div class="pull-right" style="width: 70%">
                                    <%--              <asp:RegularExpressionValidator
                                        ID="RegularExpressionValidator2"
                                        runat="server"
                                        ControlToValidate="txtState"
                                        Text="Invalid State"
                                        ValidationExpression="^[a-z]+$"
                                        ValidationGroup="Client"
                                        Display="Dynamic"
                                        SetFocusOnError="true"
                                        CssClass="validator pull-left"
                                        Width="40%"
                                        Style="margin-left: 15px" />--%>
                                    <asp:RegularExpressionValidator
                                        ID="RegularExpressionValidatorZip"
                                        runat="server"
                                        ControlToValidate="txtZip"
                                        Text="Invalid Zip"
                                        ValidationExpression="^([0-9])*$"
                                        ValidationGroup="Client"
                                        Display="Dynamic"
                                        SetFocusOnError="true"
                                        CssClass="validator pull-right"
                                        Width="45%"
                                        Style="margin-left: 10px" />
                                </div>

                            </div>
                        </div>

                        <div class="form-group row" style="padding-top: 20px">
                            <div class="col-xs-8" style="padding-right: 0">
                                <asp:ValidationSummary ID="valSum" runat="server" DisplayMode="SingleParagraph" HeaderText="All fields with (*) are required." ValidationGroup="Client" />
                            </div>
                            <div class="col-xs-4">
                                <asp:Button runat="server" ID="btnOk" Text="Submit" class="btn btn-primary fa-paper-plane" CommandName="Insert" ValidationGroup="Client" UseSubmitBehavior="false" />
                            </div>
                        </div>
                    </div>
                </InsertItemTemplate>
            </asp:FormView>

            <asp:SqlDataSource ID="SqlDataSourceInsertClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
                InsertCommand="Request40year_Proposal_Insert" InsertCommandType="StoredProcedure" ProviderName="System.Data.SqlClient">
                <InsertParameters>
                    <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />

                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="Phone" Type="String" />
                    <asp:Parameter Name="Email" Type="String" />
                    <asp:Parameter Name="Address" Type="String" />
                    <asp:Parameter Name="City" Type="String" />
                    <asp:Parameter Name="State" Type="String" />
                    <asp:Parameter Name="Zip" Type="String" />

                    <asp:ControlParameter PropertyName="Text" ControlID="lblProposalType40Years" Name="Type" Type="Int32" />
                    <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
                </InsertParameters>
            </asp:SqlDataSource>


            <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
            <asp:Label ID="lblProposalType40Years" runat="server" Visible="False"></asp:Label>

        </div>
    </form>
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

        function afterAjaxInit(e, c) {
            $(".form-input-phone").mask("(000) 000-0000");
            try {
                initAutocomplete();
            }
            catch (err) {
                console.log("Error: " + err.message);
            }
        }
        $(document).ready(function () {
            afterAjaxInit();
        });
    </script>
</body>

</html>
