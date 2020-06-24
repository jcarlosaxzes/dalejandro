<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterJOB.Master" CodeBehind="job_job.aspx.vb" Inherits="pasconcept20.Job_job" %>

<%@ MasterType VirtualPath="~/ADM/MasterJOB.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLuxW5zYQh_ClJfDEBpTLlT_tf8JVcxf0&libraries=places&callback=initAutocomplete"
            async defer></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.0/jquery.mask.min.js"></script>
        <script>
            // Autocompletes all address inputs using google maps js api
            function initAutocomplete() {
                // Address Fields
                var addressInput2 = document.getElementsByClassName("input-address-2")[0];
                // autocomplete var
                var autocomplete2 = new google.maps.places.Autocomplete(addressInput2);
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
    <div>
        <asp:ValidationSummary ID="ValidationSummaryJobUpdate" runat="server"
            Font-Size="X-Small" HeaderText="Following error occurs:" ShowMessageBox="false" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="JobUpdate" />
        <div class="row">
            <div class="col-12" style="padding-top:15px">

                <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceJob" DefaultMode="Edit" Width="98%">
                    <EditItemTemplate>
                        <table class="table-sm" style="width: 100%">
                            <tr>
                                <td style="width: 150px; text-align: right">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtCode" ValidationGroup="JobUpdate"
                                        Text="*" ErrorMessage="Define Job Number" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtJob" ValidationGroup="JobUpdate"
                                        Text="*" ErrorMessage="Define Job Name" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    Number/Name:
                                </td>
                                <td>
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="width: 100px">
                                                <telerik:RadTextBox ID="txtCode" Text='<%# Bind("Code") %>' runat="server" Width="95px" MaxLength="7">
                                                </telerik:RadTextBox></td>
                                            <td>
                                                <telerik:RadTextBox ID="txtJob" runat="server" Text='<%# Bind("Job") %>' Width="100%" MaxLength="80">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="width: 150px; text-align: right">Budget:
                                </td>
                                <td style="width: 200px;">
                                    <telerik:RadNumericTextBox ID="txtBudgest" runat="server" DbValue='<%# Bind("Budget") %>' Width="100%">
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>
                            <tr>
                                 <td style="text-align: right">Location:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txtProjectLocation" runat="server" Text='<%# Bind("ProjectLocation") %>' Width="100%" MaxLength="80"
                                        CssClass="input-address-2">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="text-align: right">
                                    Allow Open Budget:
                                </td>
                                <td>
                                    <telerik:RadCheckBox ID="chkAllowOpenBudget" runat="server" Checked='<%# Bind("AllowOpenBudget") %>' 
                                        ToolTip="Automatically update the Budget when Invoices are inserted or updated. Budget=SUM(Invoices.Amount)" />
                                </td>
                            </tr>
                            <tr>
                               <td style="text-align: right">
                                    <asp:CompareValidator runat="server" ID="Comparevalidator2" ValueToCompare="(Select Client...)"
                                        Operator="NotEqual" ControlToValidate="cboCliente" Text="*" ErrorMessage="Define Client" SetFocusOnError="true" ValidationGroup="JobUpdate"> </asp:CompareValidator>
                                    Client:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cboCliente" runat="server" SelectedValue='<%# Bind("Client") %>' DataSourceID="SqlDataSourceClientes"
                                        DataTextField="Name" DataValueField="Id" Width="100%" AppendDataBoundItems="True"
                                        MarkFirstMatch="True" Filter="Contains" OnClientKeyPressing="(function(sender, e){ if (!sender.get_dropDownVisible() && sender.get_text().length >1) sender.showDropDown(); })">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Select Client...)" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                                <td style="text-align: right">Job Status:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cboStatus" runat="server" SelectedValue='<%# Bind("Status") %>'
                                        DataSourceID="SqlDataSourceJobStatus" DataTextField="Name" DataValueField="Id" Width="100%">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Owner Name:</td>
                                <td>
                                    <telerik:RadTextBox ID="txtOwnerName" runat="server" Text='<%# Bind("Owner") %>' Width="100%" MaxLength="80">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="text-align: right">Opening Date:
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="RadDatePicker1" runat="server" DbSelectedDate='<%# Bind("Open_date") %>' Width="100%">
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Project Manager:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cboEmployee" runat="server" SelectedValue='<%# Bind("Employee") %>'
                                        DataSourceID="SqlDataSourceEmployee" DataTextField="Name" DataValueField="Id"
                                        Width="100%" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="True">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Select Employee...)" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                                <td style="text-align: right">Start Date:
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="RadDatePickerSignedDate" runat="server" DbSelectedDate='<%# Bind("StartDay") %>' Width="100%" ToolTip="Signed Date">
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">
                                    <asp:CompareValidator runat="server" ID="Comparevalidator5" ValueToCompare="(Select Department...)"
                                        Operator="NotEqual" ControlToValidate="cboDepartment" Text="*" ErrorMessage="Define Department" SetFocusOnError="true" ValidationGroup="JobUpdate">
                                    </asp:CompareValidator>Department:

                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cboDepartment" runat="server" SelectedValue='<%# Bind("DepartmentId") %>'
                                        AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSourceDepartments" DataTextField="Name" DataValueField="Id"
                                        Width="100%" MarkFirstMatch="True"
                                        Filter="Contains" Height="300px">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Select Department...)" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                                <td style="text-align: right">Signed Date:
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="RadDatePickerSigned" runat="server" DbSelectedDate='<%# Bind("SignedDate") %>' Width="100%" ToolTip="Signed Date">
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">A/E of Record:</td>
                                <td>
                                    <telerik:RadComboBox ID="cboEngRecord" runat="server" SelectedValue='<%# Bind("RecordBy") %>'
                                        DataSourceID="SqlDataSourceEmployee" DataTextField="Name" DataValueField="Id"
                                        Width="100%" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="True">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Select  A/E of Record...)" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                                <td style="text-align: right">Deadline:
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="RadDatePickerDeadline" runat="server" DbSelectedDate='<%# Bind("EndDay") %>' Width="100%" ToolTip="Job Deadline">
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">
                                    <asp:CompareValidator runat="server" ID="Comparevalidator1" ValueToCompare="(Select Job Type...)"
                                        Operator="NotEqual" ControlToValidate="cboType" ErrorMessage="Define Job Type" Text="*" SetFocusOnError="true" ValidationGroup="JobUpdate"> </asp:CompareValidator>
                                    Type:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cboType" runat="server" SelectedValue='<%# Bind("Type") %>' DataSourceID="SqlDataSourceType" DataTextField="Name"
                                        DataValueField="Id" Width="100%" AppendDataBoundItems="True" MarkFirstMatch="True" Filter="Contains" Height="300px">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Select Job Type...)" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                                <td style="text-align: right">Estimated Days:
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox ID="RadNumericTextBox1" runat="server" DbValue='<%# Bind("Workdays") %>' Width="200px">
                                        <NumberFormat DecimalDigits="0" />
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Description:</td>
                                <td>
                                    <telerik:RadTextBox ID="RadTextBox1" runat="server" Text='<%# Bind("Description") %>' Width="100%" MaxLength="1024" TextMode="MultiLine" Rows="4">
                                    </telerik:RadTextBox>
                                </td>
                                <td colspan="2">
                                    <table class="table-sm">
                                        <tr>
                                            <td style="text-align: right; width: 150px">Construction Cost:</td>
                                            <td>
                                                <telerik:RadNumericTextBox ID="txtCost" runat="server" DbValue='<%# Bind("Cost") %>' Width="100%">
                                                </telerik:RadNumericTextBox></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right">Unit:</td>
                                            <td>
                                                <telerik:RadNumericTextBox ID="txtUnit" runat="server" DbValue='<%# Bind("Unit") %>' Width="100%">
                                                </telerik:RadNumericTextBox></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">
                                    Bill Type:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cboBillType" runat="server" SelectedValue='<%# Bind("BillType") %>' Width="100%">
                                                    <Items>
                                                        <telerik:RadComboBoxItem runat="server" Text="Defined Per Task" Value="0" />
                                                        <telerik:RadComboBoxItem runat="server" Text="Lump Sum" Value="1" />
                                                        <telerik:RadComboBoxItem runat="server" Text="Hourly" Value="2" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                </td>
                                <td style="text-align: right">
                                    Measure:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cboMeasure" runat="server" SelectedValue='<%# Bind("Measure") %>'
                                                    DataSourceID="SqlDataSourceMeasure" DataTextField="Name" DataValueField="Id" Width="100%" AppendDataBoundItems="True">
                                                    <Items>
                                                        <telerik:RadComboBoxItem runat="server" Text="(Not defined...)" Value="0" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">
                                    <asp:CompareValidator runat="server" ID="Comparevalidator3" ValueToCompare="(Select Sector...)"
                                        Operator="NotEqual" ControlToValidate="cboSector" Text="*" ErrorMessage="Define Sector" SetFocusOnError="true" ValidationGroup="JobUpdate">
                                    </asp:CompareValidator>Sector:</td>
                                <td>
                                    <telerik:RadComboBox ID="cboSector" runat="server" AppendDataBoundItems="True" SelectedValue='<%# Bind("ProjectSector") %>'
                                        DataSourceID="SqlDataSourceProjectSector" DataTextField="Name" DataValueField="Id"
                                        Width="100%" MarkFirstMatch="True"
                                        Filter="Contains" Height="300px">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Select Sector...)" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>

                                <td style="text-align: right">Lifespan:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txtLifespan" runat="server" Text='<%# Bind("Lifespan") %>' MaxLength="50" Width="100%"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">
                                    <asp:CompareValidator runat="server" ID="Comparevalidator4" ValueToCompare="(Select Use...)"
                                        Operator="NotEqual" ControlToValidate="cboUse" Text="*" ErrorMessage="Define Use" SetFocusOnError="true" ValidationGroup="JobUpdate">
                                    </asp:CompareValidator>Use &amp; Occupancy:</td>
                                <td>
                                    <telerik:RadComboBox ID="cboUse" runat="server" AppendDataBoundItems="True" SelectedValue='<%# Bind("ProjectUse") %>'
                                        DataSourceID="SqlDataSourceProjectUse" DataTextField="Name" DataValueField="Id"
                                        Width="100%" MarkFirstMatch="True"
                                        Filter="Contains" Height="300px">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Select Use...)" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>

                                <td style="text-align: right">Change Orders:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txtChangeOrders" runat="server" Text='<%# Bind("Change_orders") %>' MaxLength="128" Width="100%"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right"></td>
                                <td></td>
                                <td style="text-align: right"></td>
                                <telerik:RadComboBox ID="cboProposalType" Visible="false" runat="server" SelectedValue='<%# Bind("ProposalType") %>' DataSourceID="SqlDataSourceProposalType" DataTextField="Name"
                                    DataValueField="Id" Width="100%" AppendDataBoundItems="True" MarkFirstMatch="True" Filter="Contains" Height="300px">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(Select Template...)" Value="0" />
                                    </Items>
                                </telerik:RadComboBox>
                                <td></td>
                            </tr>

                        </table>
                    </EditItemTemplate>
                </asp:FormView>
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <table style="width:98%">
                    <tr>
                        <td style="width: 150px; text-align: right;vertical-align:top">
                            Tags: 
                        </td>
                        <td style="text-align:left">
                            <asp:Label ID="lblTags" runat="server"></asp:Label>
                        </td>
                        <td style="width:150px;text-align:right;vertical-align:top">
                             <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" ToolTip="Update Active Job" ValidationGroup="JobUpdate">
                                 Update
                            </asp:LinkButton>
                        </td>
                    </tr>
                </table>
               <br /><br /><br />
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="SqlDataSourceJob" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOB_JOB_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="JOB_JOB_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="Id" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Code" Type="String" />
            <asp:Parameter Name="Job" Type="String" />
            <asp:Parameter Name="Open_date" Type="DateTime" />
            <asp:Parameter Name="Client" Type="Int32" />
            <asp:Parameter Name="Budget" Type="Double" />
            <asp:Parameter Name="Type" Type="String" />
            <asp:Parameter Name="Employee" Type="Int32" />
            <asp:Parameter Name="ProjectLocation" Type="String" />
            <asp:Parameter Name="Status" Type="Int32" />
            <asp:Parameter Name="Owner" Type="String" />
            <asp:Parameter Name="Cost" Type="Double" />
            <asp:Parameter Name="RecordBy" Type="Int32" />
            <asp:Parameter Name="SignedDate" Type="DateTime" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Change_orders" Type="String" />
            <asp:Parameter Name="Lifespan" Type="String" />
            <asp:Parameter Name="ProjectSector" Type="Int32" />
            <asp:Parameter Name="ProjectUse" Type="String" />
            <asp:Parameter Name="DepartmentId" Type="Int32" />
            <asp:Parameter Name="Unit" Type="Int32" />
            <asp:Parameter Name="Measure" Type="Int32" />
            <asp:Parameter Name="ProposalType" Type="Int32" />
            <asp:Parameter Name="StartDay" Type="DateTime" />
            <asp:Parameter Name="EndDay" Type="DateTime" />
            <asp:Parameter Name="Workdays" Type="Int32" />
            <asp:Parameter Name="AllowOpenBudget" />
            <asp:Parameter Name="BillType" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblJobId" Name="Id" PropertyName="Text" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClientes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name]+' [' + isnull(Company,'...') + ']' As Name FROM Clients WHERE companyId=@companyId ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, FullName as Name FROM Employees WHERE (companyId=@companyId) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceMeasure" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Jobs_measures ORDER BY Id"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceJobStatus" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Jobs_status] ORDER BY [OrderBy]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProjectSector" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Jobs_sectors ORDER BY Name"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProjectUse" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Jobs_uses ORDER BY Name"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceProposalType" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Proposal_types WHERE (companyId = @companyId) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceType" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Jobs_types WHERE companyId=@companyId ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblJobId" runat="server" Visible="false" Text="0"></asp:Label>

    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
</asp:Content>

