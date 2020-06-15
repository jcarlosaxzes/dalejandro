<%@ Page Title="Client" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="client.aspx.vb" Inherits="pasconcept20.client" %>

<%@ Import Namespace="pasconcept20" %>
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
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <div class="Formulario">
        <table class="table-sm" style="width: 100%">
            <tr>
                <td style="width: 80px">
                    <asp:LinkButton ID="btnTotals" runat="server" CssClass="btn btn-danger" UseSubmitBehavior="false">
                       $ Dashboard
                    </asp:LinkButton>
                </td>
                <td style="width: 120px">
                    <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
                       Back to List
                    </asp:LinkButton>
                </td>
                <td></td>
            </tr>
        </table>
        <div id="collapseTotals">
            <div class="card card-body">
                <asp:FormView ID="FormViewClientBalance" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceClientBalance" Width="100%">
                    <ItemTemplate>
                        <table class="table-sm" style="width: 100%">
                            <tr>
                                <td colspan="9">
                                    <hr style="margin: 0" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="9" style="text-align: center">
                                    <h2 style="margin: 0"><%# Eval("ClientName")%>, <%# Eval("ClientCompany") %></h2>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 18%; text-align: center; background-color: #039be5">
                                    <span class="DashboardFont2">Pending Proposals</span><br />
                                    <asp:Label ID="lblTotalBudget" CssClass="DashboardFont1" runat="server" Text='<%# Eval("NumberPendingProposal", "{0:N0}") %>'></asp:Label>
                                </td>
                                <td></td>
                                <td style="width: 18%; text-align: center; background-color: #546e7a">
                                    <span class="DashboardFont2">Acepted Proposal</span><br />
                                    <asp:Label ID="lblTotalBilled" runat="server" CssClass="DashboardFont1" Text='<%# Eval("ProposalAmount", "{0:C0}") %>'></asp:Label>
                                </td>
                                <td></td>
                                <td style="width: 18%; text-align: center; background-color: #43a047">
                                    <span class="DashboardFont2">Jobs Budget</span><br />
                                    <asp:Label ID="lblTotalCollected" runat="server" CssClass="DashboardFont1" Text='<%# Eval("ContractAmount", "{0:C0}") %>'></asp:Label>
                                </td>
                                <td></td>
                                <td style="width: 18%; text-align: center; background-color: #43a047">
                                    <span class="DashboardFont2">Amount Paid</span><br />
                                    <asp:Label ID="lblTotalPending" runat="server" CssClass="DashboardFont1" Text='<%# Eval("AmountPaid", "{0:C0}") %>'></asp:Label>
                                </td>
                                <td></td>
                                <td style="width: 18%; text-align: center; background-color: #e53935">
                                    <span class="DashboardFont2">Remaining Balance</span><br />
                                    <asp:Label ID="LabelblTotalBalance" runat="server" CssClass="DashboardFont1" Text='<%# Eval("Balance", "{0:C0}") %>'></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:FormView>

            </div>
        </div>
    </div>
    <div class="pas-container">
        <telerik:RadWizard ID="RadWizard1" runat="server" DisplayCancelButton="false" RenderMode="Lightweight" Skin="Silk" DisplayNavigationButtons="false" DisplayProgressBar="false">
            <WizardSteps>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep1" Title="Client Details" StepType="Step">
                    <div style="padding-left: 10px">
                        <div>
                            <asp:ValidationSummary ID="vsClient" runat="server" ValidationGroup="UpdateClient" ForeColor="Red"
                                HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were this errors:"></asp:ValidationSummary>
                        </div>

                    </div>
                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSource1" Width="100%" DefaultMode="Edit">
                        <EditItemTemplate>
                            <table class="table-sm" style="width: 100%">
                                <tr>
                                    <td style="width: 120px">
                                        <asp:Image ID="ImageClientPhoto" ImageUrl='<%# GetClientPhotoURL(Eval("Id"))%>'
                                            runat="server" Width="45" Height="50" AlternateText='<%# Eval("Name", "{0} photo")%>'></asp:Image>
                                    </td>
                                    <td style="width: 10px">
                                        <telerik:RadButton ID="btnPhoto" runat="server" CommandName="Photo" Text="Client Photo" Visible="false">
                                            <Icon PrimaryIconCssClass=" rbUpload"></Icon>
                                        </telerik:RadButton>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:LinkButton ID="btnUpdateClient1" runat="server" CommandName="Update" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false">
                                            Update Client
                                        </asp:LinkButton>
                                        <td></td>
                                        <td></td>
                                </tr>
                            </table>

                            <table class="table-sm" style="width: 100%">
                                <tr>
                                    <td style="width: 220px; text-align: right">Name:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txtClientName" runat="server" Text='<%# Bind("Name") %>' MaxLength="80"
                                            Width="90%" EmptyMessage="Required">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Email:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' MaxLength="128" Width="90%" EmptyMessage="Required">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Position:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="RadTextBox3" runat="server" Text='<%# Bind("Position") %>'
                                            MaxLength="80" Width="90%">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Organization:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="RadTextBox4" runat="server" Text='<%# Bind("Company") %>'
                                            MaxLength="80" Width="90%">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Type:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cboType" runat="server" DataSourceID="SqlDataSourceTypes"
                                            DataTextField="Name" DataValueField="Id" Width="90%" SelectedValue='<%# Bind("Type") %>'
                                            AppendDataBoundItems="true" AutoPostBack="True">
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
                                            SelectedValue='<%# DataBinder.Eval(Container.DataItem, "Subtype")%>' Width="90%">
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text="(Subtypes Not Defined...)" Value="0" />
                                            </Items>
                                        </telerik:RadComboBox>
                                        <asp:SqlDataSource ID="SqlDataSourceSubtypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
                                            SelectCommand="SELECT [Id], [Name] FROM [Clients_Subtypes] Where typeId=@typeId ORDER BY Name">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="cboType" Name="typeId" PropertyName="SelectedValue" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>

                                <tr>
                                    <td style="text-align: right"><a href="https://www.census.gov/eos/www/naics/" target="_blank">NAICS</a> US Code:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cboNAICS" runat="server" DataSourceID="SqlDataSourceNAICS"
                                            DataTextField="CodeAndTitle" DataValueField="Code" Width="90%" SelectedValue='<%# Bind("NAICS_code") %>'
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
                                        <telerik:RadTextBox ID="txtAddress" runat="server" Text='<%# Bind("Address") %>'
                                            MaxLength="80" Width="90%" CssClass="input-address">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Address Line 2:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txtAddress2" runat="server" Text='<%# Bind("Address2") %>'
                                            MaxLength="80" Width="90%">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">City/State/Zip:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txtCity" runat="server" Text='<%# Bind("City") %>' MaxLength="50"
                                            Width="160px" ToolTip="City" EmptyMessage="City" CssClass="input-city">
                                        </telerik:RadTextBox>
                                        &nbsp;
                                                                <telerik:RadTextBox ID="txtState" runat="server" Text='<%# Bind("State") %>'
                                                                    MaxLength="50" Width="160px" ToolTip="State" EmptyMessage="State" CssClass="input-state">
                                                                </telerik:RadTextBox>
                                        &nbsp;
                                                                <telerik:RadTextBox ID="txtZipCode" runat="server" Text='<%# Bind("ZipCode") %>' ToolTip="Zip Code" EmptyMessage="Zip Code"
                                                                    MaxLength="50" Width="160px" CssClass="input-zip">
                                                                </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Phone/Cell/Fax:
                                    </td>
                                    <td>
                                        <telerik:RadMaskedTextBox ID="RadMaskedTextBox1" runat="server" Text='<%# Bind("Phone") %>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" ToolTip="Phone" />
                                        &nbsp;
                                                                <telerik:RadMaskedTextBox ID="RadMaskedTextBox2" runat="server" Text='<%# Bind("Cellular") %>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" ToolTip="Cell" />
                                        &nbsp;
                                                                <telerik:RadMaskedTextBox ID="RadMaskedTextBox3" runat="server" Text='<%# Bind("Fax") %>' Mask="(###) ###-####" SelectionOnFocus="CaretToBeginning" ToolTip="Facsimile" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Web Page:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="RadTextBox1" runat="server" Text='<%# Bind("Web") %>' MaxLength="50"
                                            Width="90%">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Availability/Starting Date:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cboAvailability" runat="server" DataSourceID="SqlDataSourceAvailability"
                                            DataTextField="Name" DataValueField="Id" Width="250px" SelectedValue='<%# Bind("AvailabilityId") %>'>
                                        </telerik:RadComboBox>
                                        &nbsp;
                                                                <telerik:RadDatePicker ID="RadDatePickerStartingDate" runat="server" DbSelectedDate='<%# Bind("StartingDate")%>' ToolTip="Starting Date"
                                                                    MaxDate="01/01/2099 0:00:00" MinDate="01/01/1900 0:00:00">
                                                                </telerik:RadDatePicker>
                                    </td>
                                </tr>

                                <tr>
                                    <td style="text-align: right">Notes:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="RadTextBox14" runat="server" Text='<%# Bind("Notes") %>'
                                            TextMode="MultiLine" Width="90%" MaxLength="1024" Rows="2">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Client Code:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txtCode" runat="server" Text='<%# Bind("Initials") %>' EmptyMessage="Up to 7 characters"
                                            MaxLength="7">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">TAGs:
                                    </td>
                                    <td>

                                        <asp:Label ID="lblActualTAGS" runat="server" Text='<%# Eval("TAGS") %>'></asp:Label>
                                        <br />
                                        <telerik:RadAutoCompleteBox RenderMode="Lightweight" ID="cboTags" runat="server" EnableClientFiltering="true" Width="90%"
                                            DropDownHeight="150" DataSourceID="SqlDataSourceTags" DataTextField="Tag" EmptyMessage="Add New Tags"
                                            DataValueField="Tag">
                                        </telerik:RadAutoCompleteBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Source:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cboSource" runat="server" DataSourceID="SqlDataSourceClientSources" AllowCustomText="true"
                                            MarkFirstMatch="True" Filter="Contains" DataTextField="Name" Width="300px"
                                            Text='<%# Bind("Source") %>' EmptyMessage="Type or select client source...">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td style="text-align: right">Customer Representative:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cboSalesRep1" runat="server" AppendDataBoundItems="True"
                                            DataSourceID="SqlDataSourceEmployees" DataTextField="Name" DataValueField="Id"
                                            MarkFirstMatch="True" Filter="Contains"
                                            SelectedValue='<%# Bind("SalesRep1")%>'
                                            Width="300px">
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text="(Customer Rep 1 Not Defined...)" Value="0" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                            </table>

                            <h4>Billing Contact</h4>
                            <table class="table-sm" style="width: 100%">
                                <tr>
                                    <td style="width: 220px; text-align: right">Name:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="RadTextBox12" runat="server" Text='<%# Bind("Billing_contact") %>'
                                            MaxLength="80" Width="90%">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Email:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="RadTextBox2" runat="server" Text='<%# Bind("Billing_Email")%>'
                                            MaxLength="80" Width="90%">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Telephone:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="RadTextBox13" runat="server" Text='<%# Bind("Billing_Telephone") %>'
                                            MaxLength="25">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Bill Type:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cboBillType" runat="server" SelectedValue='<%# Bind("BillType") %>' Width="90%">
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text="Defined Per Job" Value="0" />
                                                <telerik:RadComboBoxItem runat="server" Text="Lump Sum" Value="1" />
                                                <telerik:RadComboBoxItem runat="server" Text="Hourly" Value="2" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                            </table>

                            <h4>Notification</h4>
                            <table class="table-sm" style="width: 100%">
                                <tr>
                                    <td style="width: 220px; text-align: right">For Invoice Emitted:
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="Notification_invoiceemittedCheckBox1" runat="server" Checked='<%# Bind("Notification_invoiceemitted")%>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Job Inactive or Invoice Collected:
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="Notification_invoicecollectedCheckBox1" runat="server" Checked='<%# Bind("Notification_invoicecollected")%>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Proposal PDF Attached:
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("ProposalPDFattached")%>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">For Proposal Accepted:
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="Notification_acceptedproposalCheckBox1" runat="server" Checked='<%# Bind("Notification_acceptedproposal")%>' Enabled="false" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">For Proposal Declined:
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="Notification_declinedproposalCheckBox1" runat="server" Checked='<%# Bind("Notification_declinedproposal")%>' Enabled="false" />
                                    </td>
                                </tr>

                                <tr>
                                    <td style="text-align: right">Deny SMS Notifications:
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Deny_SMSnotification")%>' />
                                    </td>
                                </tr>


                            </table>

                            <div style="text-align: center">
                                <asp:LinkButton ID="btnUpdateClient2" runat="server" CommandName="Update" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" CausesValidation="true" ValidationGroup="UpdateClient">
                                     Update Client
                                </asp:LinkButton>
                                <br />
                                <br />
                            </div>
                            <div>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtClientName" ValidationGroup="UpdateClient"
                                    ErrorMessage="(*) Name is Required" Display="None"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtEmail" ValidationGroup="UpdateClient"
                                    runat="server" ErrorMessage="(*) Enter a valid email address"
                                    ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                    Display="None"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmail" ValidationGroup="UpdateClient"
                                    ErrorMessage="(*) Email is Required" Display="None"></asp:RequiredFieldValidator>
                            </div>
                        </EditItemTemplate>

                    </asp:FormView>
                </telerik:RadWizardStep>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep2" Title="History" StepType="Step">
                    <h4>Proposals History</h4>
                    <telerik:RadGrid ID="RadGridProposals" runat="server" DataSourceID="SqlDataSourceProp" AutoGenerateColumns="False" AllowSorting="True"
                        PageSize="5" AllowPaging="true" ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" HeaderStyle-Font-Size="Small">
                        <ClientSettings>
                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                        </ClientSettings>
                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceProp" ShowFooter="True" ClientDataKeyNames="Id">
                            <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                            <Columns>
                                <telerik:GridTemplateColumn DataField="Id" HeaderText="Number"
                                    SortExpression="Id" UniqueName="Id" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="lnkPropEdit" runat="server" NavigateUrl='<%# Eval("Id", "~/adm/proposal.aspx?proposalId={0}&Origen=2")%>'
                                            Text='<%# Eval("ProposalNumber")%>' ToolTip="Clic to View/Edit Proposal in new tab" Target="_blank"></asp:HyperLink>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="ProjectName" FilterControlAltText="Filter ProjectName column" HeaderText="Project Name"
                                    SortExpression="ProjectName" UniqueName="ProjectName" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hlkJobLabel" runat="server" Text='<%# Eval("ProjectName")%>' NavigateUrl='<%# LocalAPI.urlProjectLocationGmap(Eval("ProjectLocation"))%>' CssClass="lnkGrid"
                                            ToolTip='<%# String.Concat("Click to view [", Eval("ProjectLocation"), "] in Google Maps")%>' Target="_blank"></asp:HyperLink>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="nType" HeaderText="Proposal Template" SortExpression="nType"
                                    UniqueName="nType" HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn AllowFiltering="False" DataField="Total" DataFormatString="{0:N}"
                                    Groupable="False" HeaderText="Amount" ReadOnly="True" SortExpression="Total"
                                    UniqueName="Total" ItemStyle-Width="60px" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                                    FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:N}" FooterStyle-Width="100px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Date" DataFormatString="{0:MM/dd/yy}" DataType="System.DateTime"
                                    HeaderText="Date" SortExpression="Date" UniqueName="Date" ItemStyle-Width="80px"
                                    ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" AllowFiltering="False" HeaderStyle-Width="80px">
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="JobCode" HeaderText="Job No." SortExpression="JobCode"
                                    UniqueName="JobCode" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("JobId", "~/ADM/Job_job.aspx?JobId={0}&Origen=2")%>'
                                            Text='<%# Eval("JobCode") %>' ToolTip="Click to edit job in new tab" Target="_blank"></asp:HyperLink>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                    <h4>Jobs History</h4>
                    <telerik:RadGrid ID="RadGridJobs" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSourceJobs" Width="100%"
                        PageSize="5" AllowPaging="true"
                        ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" HeaderStyle-Font-Size="Small">

                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceJobs" ShowFooter="True">
                            <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                            <Columns>
                                <telerik:GridTemplateColumn DataField="Code" Groupable="False" HeaderText="Number"
                                    SortExpression="Code" UniqueName="Code" ItemStyle-Width="60px" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="60px"
                                    FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}" ReadOnly="true">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hlkJobedit" runat="server" Text='<%# Eval("Code")%>' NavigateUrl='<%# Eval("Id", "~/ADM/Job_job.aspx?JobId={0}")%>' CssClass="lnkGrid"
                                            ToolTip="Click to edit job in new tab" Target="_blank"></asp:HyperLink>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="Job" FilterControlAltText="Filter Job column" HeaderText="Name" SortExpression="Job" UniqueName="Job" HeaderStyle-HorizontalAlign="Center" ReadOnly="true">
                                    <ItemTemplate>
                                        <asp:Label ID="lblJobCompleto" runat="server" CssClass="PequenaNegrita" Visible='<%# LocalAPI.IsJobComplete(Eval("Id"))%>' Text="*" ToolTip="This Job is complete"></asp:Label>
                                        <asp:HyperLink ID="hlkJobLabel" runat="server" Text='<%# Eval("Job")%>' NavigateUrl='<%# LocalAPI.urlProjectLocationGmap(Eval("ProjectLocation"))%>' CssClass="lnkGrid"
                                            ToolTip='<%# String.Concat("Click to view [", Eval("ProjectLocation"), "] in Google Maps")%>' Target="_blank"></asp:HyperLink>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="Status" HeaderText="Status" SortExpression="nStatus"
                                    UniqueName="Status" HeaderStyle-HorizontalAlign="Center" AllowFiltering="true" HeaderStyle-Width="150px">
                                    <ItemTemplate>
                                        <asp:Label ID="hlkStatusEdit" runat="server" Text='<%# Eval("nStatus")%>' ToolTip="Click to edit job status"></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="Budget" DataFormatString="{0:N2}"
                                    Groupable="False" HeaderText="Budget" SortExpression="Budget" ReadOnly="true"
                                    UniqueName="Budget" ItemStyle-Width="60px" ItemStyle-HorizontalAlign="Right"
                                    FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:N2}"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" FooterStyle-Width="100px">
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="Collected"
                                    Groupable="False" HeaderText="Collected" ReadOnly="True" SortExpression="Collected"
                                    UniqueName="Collected" ItemStyle-HorizontalAlign="Right"
                                    FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:N2}"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" FooterStyle-Width="100px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCol" runat="server" Width="30px" Text='<%# Eval("Collected", "{0:N2}")%>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="Balance" DataFormatString="{0:N2}"
                                    Groupable="False" HeaderText="Pending" ReadOnly="True"
                                    SortExpression="Balance" UniqueName="Balance" ItemStyle-HorizontalAlign="Right"
                                    FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:N2}"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" FooterStyle-Width="100px">
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>

                </telerik:RadWizardStep>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep3" Title="Uploaded Files" StepType="Step">
                    <telerik:RadGrid ID="RadGridAzureuploads" runat="server" DataSourceID="SqlDataSourceAzureuploads" GroupPanelPosition="Top" ShowFooter="true"
                        AllowAutomaticUpdates="True" AllowPaging="True" PageSize="10" AllowSorting="True" AllowAutomaticDeletes="True">
                        <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceAzureuploads"
                            ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" HeaderStyle-Font-Size="Small">
                            <Columns>
                                <telerik:GridTemplateColumn DataField="Source" FilterControlAltText="Filter Source column" HeaderText="Source" SortExpression="Source"
                                    UniqueName="Source" HeaderStyle-Width="100px" ReadOnly="true">
                                    <ItemTemplate>
                                        <%# Eval("Source")%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="Document" FilterControlAltText="Filter Document column" HeaderText="Document" SortExpression="Document"
                                    UniqueName="Document" HeaderStyle-Width="80px" ReadOnly="true">
                                    <ItemTemplate>
                                        <%# Eval("Document")%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column" HeaderText="File Name" SortExpression="Name" UniqueName="Name">
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="255" Width="100%"></telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="NameTextBox" CssClass="Error" ErrorMessage=" (*)">
                                        </asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <a href='<%# Eval("url")%>' target="_blank" download='<%# Eval("Name") %>'><%# String.Concat(Eval("Name"), " (", Eval("ContentType"), ")")%></a>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="Date" FilterControlAltText="Filter Date column" HeaderText="Date" SortExpression="Date" UniqueName="Date"
                                    HeaderStyle-Width="80px" ReadOnly="true">
                                    <ItemTemplate>
                                        <%# Eval("Date", "{0:d}")%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="nType" FilterControlAltText="Filter nType column" HeaderText="Type" SortExpression="nType" UniqueName="nType"
                                    HeaderStyle-Width="80px" ReadOnly="true">
                                    <ItemTemplate>
                                        <%# Eval("nType")%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="Public" FilterControlAltText="Filter Public column" HeaderText="Public" SortExpression="Public" UniqueName="Public"
                                    HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                    <EditItemTemplate>
                                        <telerik:RadCheckBox ID="chkPublicEdit" runat="server" ToolTip="Public or private" Checked='<%# Bind("Public") %>'></telerik:RadCheckBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <telerik:RadCheckBox ID="chkPublicEdit" runat="server" ToolTip="Public or private" Checked='<%# Eval("Public") %>'></telerik:RadCheckBox>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn UniqueName="KBytes" DataFormatString="{0:N0}" ReadOnly="true" Aggregate="Sum"
                                    SortExpression="KBytes" HeaderText="KBytes" DataField="KBytes"
                                    HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                                </telerik:GridBoundColumn>
                                <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                    CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText=""
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="30px" ItemStyle-HorizontalAlign="Center">
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings>
                                <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                    </telerik:RadGrid>
                </telerik:RadWizardStep>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep4" Title="Schedule" StepType="Step">
                    <h4>Schedule</h4>
                    <telerik:RadScheduler ID="RadScheduler1" runat="server" Culture="en-US" ToolTip="Press 'Double-Click' to insert/edit client's appointment"
                        Height="950px"
                        SelectedView="MonthView"
                        ShowFooter="false"
                        DataDescriptionField="Description"
                        DataEndField="End"
                        DataKeyField="Id"
                        DataRecurrenceField="RecurrenceRule"
                        DataRecurrenceParentKeyField="RecurrenceParentID"
                        DataReminderField="Reminder"
                        DataSourceID="SqlDataSourceAppointments"
                        DataStartField="Start"
                        DataSubjectField="Subject"
                        DayEndTime="23:59:59"
                        EditFormDateFormat="MM/dd/yyyy"
                        WorkDayEndTime="23:59:59"
                        FirstDayOfWeek="Monday" LastDayOfWeek="Sunday"
                        StartInsertingInAdvancedForm="True"
                        RowHeight="15px" Width="100%">
                        <AdvancedForm DateFormat="MM/dd/yyyy" Modal="true" />
                        <DayView UserSelectable="True" />
                        <WeekView UserSelectable="True" />
                        <MonthView UserSelectable="True" />
                        <TimelineView UserSelectable="True" />
                        <MultiDayView UserSelectable="True" />
                        <AgendaView UserSelectable="True" TimeColumnWidth="100px" DateColumnWidth="150px" ResourceMarkerType="Bar" />
                        <Reminders Enabled="true"></Reminders>
                        <ResourceTypes>
                            <telerik:ResourceType KeyField="ID" Name="Activity Type" TextField="Name" ForeignKeyField="ActivityId" DataSourceID="SqlDataSourceActivityType"></telerik:ResourceType>
                            <telerik:ResourceType KeyField="ID" Name="Assign to User" TextField="Name" ForeignKeyField="EmployeeId" DataSourceID="SqlDataSourceEmployees"></telerik:ResourceType>
                        </ResourceTypes>
                        <ResourceStyles>
                            <telerik:ResourceStyleMapping Type="Activity Type" Text="Appointment" ApplyCssClass="rsCategoryBlue"></telerik:ResourceStyleMapping>
                            <telerik:ResourceStyleMapping Type="Activity Type" Text="Meeting" ApplyCssClass="rsCategoryOrange"></telerik:ResourceStyleMapping>
                            <telerik:ResourceStyleMapping Type="Activity Type" Text="Site Visit" ApplyCssClass="rsCategoryGreen"></telerik:ResourceStyleMapping>
                            <telerik:ResourceStyleMapping Type="Activity Type" Text="Vacation" ApplyCssClass="rsCategoryRed"></telerik:ResourceStyleMapping>
                        </ResourceStyles>
                    </telerik:RadScheduler>

                </telerik:RadWizardStep>
                <telerik:RadWizardStep runat="server" ID="RadWizardStep5" Title="Appointments & Activity" StepType="Step">
                    <h4>Appointments & Activity</h4>
                    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSourceAppointments" AllowPaging="true" PageSize="10"
                        AutoGenerateColumns="False" AllowAutomaticDeletes="True" AllowSorting="True" Width="100%"
                        ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" HeaderStyle-Font-Size="Small">
                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceAppointments">
                            <PagerStyle Mode="Slider" />
                            <Columns>
                                <telerik:GridBoundColumn DataField="Start" DataType="System.DateTime" FilterControlAltText="Filter Start column" HeaderText="Start" SortExpression="Start" UniqueName="Start"
                                    HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" DataFormatString="{0:d}">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="End" DataType="System.DateTime" FilterControlAltText="Filter End column" HeaderText="End" SortExpression="End" UniqueName="End"
                                    HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" DataFormatString="{0:d}">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Subject" FilterControlAltText="Filter Subject column" HeaderText="Subject" ReadOnly="True" SortExpression="Subject" UniqueName="Subject"
                                    HeaderStyle-Width="200px" HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Description" FilterControlAltText="Filter Description column" HeaderText="Description" SortExpression="Description" UniqueName="Description"
                                    HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridBoundColumn>
                                <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                    CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText="Delete"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" ItemStyle-HorizontalAlign="Center">
                                </telerik:GridButtonColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>

                </telerik:RadWizardStep>
            </WizardSteps>
        </telerik:RadWizard>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        UpdateCommand="CLIENT_v20_UPDATE" UpdateCommandType="StoredProcedure"
        SelectCommand="CLIENT_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblClientId" Name="clientId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Company" Type="String" />
            <asp:Parameter Name="Address" Type="String" />
            <asp:Parameter Name="City" Type="String" />
            <asp:Parameter Name="State" Type="String" />
            <asp:Parameter Name="ZipCode" Type="String" />
            <asp:Parameter Name="Phone" Type="String" />
            <asp:Parameter Name="Cellular" Type="String" />
            <asp:Parameter Name="Fax" Type="String" />
            <asp:Parameter Name="StartingDate" Type="DateTime" />
            <asp:Parameter Name="Web" Type="String" />
            <asp:Parameter Name="Initials" Type="String" />
            <asp:Parameter Name="Notes" Type="String" />
            <asp:Parameter Name="Email" />
            <asp:Parameter Name="Position" />
            <asp:Parameter Name="Address2" />
            <asp:Parameter Name="Billing_contact" />
            <asp:Parameter Name="Billing_Email" />
            <asp:Parameter Name="Billing_Telephone" />
            <asp:Parameter Name="Notification_invoiceemitted" />
            <asp:Parameter Name="Notification_invoicecollected" />
            <asp:Parameter Name="Notification_acceptedproposal" />
            <asp:Parameter Name="Notification_declinedproposal" />
            <asp:Parameter Name="Deny_SMSnotification" />
            <asp:Parameter Name="ProposalPDFattached" />
            <asp:Parameter Name="Type" />
            <asp:Parameter Name="Subtype" />
            <asp:Parameter Name="AvailabilityId" />
            <asp:Parameter Name="TAGS" Type="String" />
            <asp:Parameter Name="Source" Type="String" />
            <asp:Parameter Name="BillType" />
            <asp:Parameter Name="SalesRep1" />
            <asp:Parameter Name="SalesRep2" DefaultValue="0" />
            <asp:Parameter Name="NAICS_code" />

            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblClientId" Name="Id" PropertyName="Text" Type="Int32" />

        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Clients_types] Where companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceAppointments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="Appointment_DELETE" DeleteCommandType="StoredProcedure"
        InsertCommand="Appointment_INSERT" InsertCommandType="StoredProcedure"
        SelectCommand="Appointments_And_Activity_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="Appointment_UPDATE" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Subject" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Start" Type="DateTime" />
            <asp:Parameter Name="End" Type="DateTime" />
            <asp:Parameter Name="RecurrenceRule" Type="String" />
            <asp:Parameter Name="RecurrenceParentID" Type="Int32" />
            <asp:Parameter Name="Reminder" Type="String" />
            <asp:Parameter Name="Annotations" />
            <asp:Parameter DefaultValue="-1" Name="JobId" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="EmployeeId" PropertyName="Text" Type="String" />
            <asp:Parameter DefaultValue="" Name="ActivityId" Type="Int16" />
            <asp:ControlParameter ControlID="lblClientId" Name="ClientId" PropertyName="Text" Type="Int32" DefaultValue="" />
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="RangeStart" Type="DateTime" DefaultValue="1900/1/1"></asp:Parameter>
            <asp:Parameter Name="RangeEnd" Type="DateTime" DefaultValue="2900/1/1"></asp:Parameter>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:Parameter DefaultValue="-1" Name="employeeId" Type="Int32" />
            <asp:Parameter DefaultValue="-1" Name="jobId" Type="Int32" />
            <asp:ControlParameter ControlID="lblClientId" Name="ClientId" PropertyName="Text" Type="Int32" DefaultValue="" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:Parameter Name="Subject" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Start" Type="DateTime" />
            <asp:Parameter Name="End" Type="DateTime" />
            <asp:Parameter Name="RecurrenceRule" Type="String" />
            <asp:Parameter Name="RecurrenceParentID" Type="Int32" />
            <asp:Parameter Name="Reminder" Type="String" />
            <asp:Parameter Name="Annotations" Type="String" />
            <asp:Parameter Name="ActivityId" Type="Int16" />
            <asp:Parameter DefaultValue="" Name="EmployeeId" Type="Int32" />
            <asp:Parameter DefaultValue="-1" Name="JobId" Type="Int32" />
            <asp:ControlParameter ControlID="lblClientId" Name="ClientId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceActivityType" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Appointments_types] ORDER BY [Id]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceAvailability" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Clients_availability] ORDER BY [Id]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], FullName As Name FROM [Employees] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProp" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="PROPOSAL_SELECT_ADM" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="Year" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="Mes" Type="Int32" />
            <asp:ControlParameter ControlID="lblClientId" Name="Client" PropertyName="Text" Type="Int32" />
            <asp:Parameter DefaultValue="-1" Name="StatusId" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:Parameter DefaultValue="-1" Name="DepartmentId" Type="Int32" />
            <asp:Parameter Name="Find" Type="String" ConvertEmptyStringToNull="False" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceJobs" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOBS_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="Year" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="Mes" Type="Int32" />
            <asp:ControlParameter ControlID="lblClientId" Name="Client" PropertyName="Text" Type="Int32" />
            <asp:Parameter DefaultValue="-1" Name="Employee" Type="Int32" />
            <asp:Parameter DefaultValue="1000" Name="Status" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="BalancePositivo" Type="Int32" />
            <asp:Parameter Name="Find" Type="String" ConvertEmptyStringToNull="False" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTags" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENT_TAGS_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceAzureuploads" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Client_azureuploads_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="delete from Azure_Uploads WHERE Id=@Id"
        UpdateCommand="UPDATE Azure_Uploads SET preprojectId=@preprojectId, Name=@Name, [Type]=@Type, [Public]=@Public WHERE Id=@Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblClientId" Name="clientId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Id" />
            <asp:Parameter Name="preprojectId" />
            <asp:Parameter Name="Name" />
            <asp:Parameter Name="Type" />
            <asp:Parameter Name="Public" DbType="Boolean" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDocTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Jobs_azureuploads_types] ORDER BY [Id]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClientBalance" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Client_Balance" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblClientId" Name="ClientId" PropertyName="Text" Type="Int32" />
        </SelectParameters>

    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClientSources" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Clients_sources] ORDER BY [Id]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceNAICS" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="NAICS_US_Codes_FromCombobox_SELECT" SelectCommandType="StoredProcedure"></asp:SqlDataSource>


    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblClientId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedType" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployee" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblBackSource" runat="server" Visible="False" Text="0"></asp:Label>

</asp:Content>

