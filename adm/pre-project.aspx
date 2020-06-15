<%@ Page Title="Pre-Project" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="pre-project.aspx.vb" Inherits="pasconcept20.pre_project" %>

<%@ MasterType VirtualPath="~/ADM/BasicMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnUpdate">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnUpdate" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />


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

    <h2>Pre-Project #:
        <asp:Label ID="lblPre_ProjectNumber" runat="server"></asp:Label>
    </h2>
    <div>
        <asp:ValidationSummary ID="vsPre_Project" runat="server" ValidationGroup="Pre_Project"
            HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were errors on this step:"></asp:ValidationSummary>
    </div>
    <table class="table-sm" style="width: 100%">
        <tr>
            <td style="width: 150px">
                <asp:RequiredFieldValidator ID="rName"
                    ControlToValidate="txtName" Display="None" runat="server" Text="*"
                    ErrorMessage="<span><b>Pre-Project Name</b> is required</span>" SetFocusOnError="true" ValidationGroup="Pre_Project">
                </asp:RequiredFieldValidator>
                Name:
            </td>
            <td>
                <telerik:RadTextBox Width="100%" ID="txtName" runat="server" MaxLength="80" EmptyMessage="Pre-Project Name">
                </telerik:RadTextBox>
            </td>

        </tr>
        <tr>
            <td>
                <asp:CompareValidator runat="server" ID="Comparevalidator2" ValueToCompare="(Select Client...)"
                    Operator="NotEqual" ControlToValidate="cboCliente" Text="*" ErrorMessage="<span><b>Client</b> is required</span>" SetFocusOnError="true"
                    ValidationGroup="Pre_Project"> </asp:CompareValidator>
                Client:
            </td>
            <td>
                <telerik:RadComboBox ID="cboCliente" runat="server" DataSourceID="SqlDataSourceClientes"
                    DataTextField="Name" DataValueField="Id" Width="100%" AppendDataBoundItems="True"
                    MarkFirstMatch="True" Filter="Contains">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="(Select Client...)" Value="0" />
                    </Items>
                </telerik:RadComboBox>
            </td>
        </tr>

        <tr>
            <td>Prepared By:
            </td>
            <td>
                <telerik:RadComboBox ID="cboPreparedBy" runat="server" DataSourceID="SqlDataSourceEmployees" DataTextField="Name"
                    DataValueField="Id" Width="100%" MarkFirstMatch="True" Filter="Contains" Height="300px">
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td>Proposal By:
            </td>
            <td>
                <telerik:RadComboBox ID="cboProposalBy" runat="server" DataSourceID="SqlDataSourceEmployees" DataTextField="Name"
                    DataValueField="Id" Width="100%" MarkFirstMatch="True" Filter="Contains" Height="300px">
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td>Department:
            </td>
            <td>
                <telerik:RadComboBox ID="cboDepartment" runat="server" DataSourceID="SqlDataSourceDepartments" DataTextField="Name"
                    DataValueField="Id" Width="100%" MarkFirstMatch="True" Filter="Contains" Height="300px">
                </telerik:RadComboBox>
            </td>

        </tr>

        <tr>
            <td>
                <asp:CompareValidator runat="server" ID="Comparevalidator1" ValueToCompare="(Project Type...)"
                    Operator="NotEqual" ControlToValidate="cboType" Text="*" ErrorMessage="<span><b>Project Type</b> is required</span>" SetFocusOnError="true"
                    ValidationGroup="Pre_Project"> </asp:CompareValidator>
                Project Type:
            </td>
            <td>
                <telerik:RadComboBox ID="cboType" runat="server" DataSourceID="SqlDataSourceProjectType" DataTextField="Name"
                    DataValueField="Id" Width="100%" AppendDataBoundItems="True" MarkFirstMatch="True" Filter="Contains" Height="300px">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="(Project Type...)" Value="0" />
                    </Items>
                </telerik:RadComboBox>
            </td>

        </tr>
        <tr>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                    ControlToValidate="txtProjectLocation" Display="None" runat="server" Text="*"
                    ErrorMessage="<span><b>Location</b> is required</span>" SetFocusOnError="true" ValidationGroup="Pre_Project">
                </asp:RequiredFieldValidator>
                Location:
            </td>
            <td>
                <telerik:RadTextBox Width="100%" ID="txtProjectLocation" runat="server" MaxLength="80" EmptyMessage="Address, City State Zip"
                    CssClass="input-address-2">
                </telerik:RadTextBox>
            </td>

        </tr>
        <tr>
            <td>Description:
            </td>
            <td>
                <telerik:RadTextBox Width="100%" ID="txtDescription" runat="server" MaxLength="255" Rows="2" TextMode="MultiLine">
                </telerik:RadTextBox>
            </td>

        </tr>
        <tr>
            <td>Status:
            </td>
            <td>
                <telerik:RadComboBox ID="cboStatus" runat="server" Width="50%" AppendDataBoundItems="True">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="Pending" Value="0" />
                        <telerik:RadComboBoxItem runat="server" Text="Processed" Value="1" />
                    </Items>
                </telerik:RadComboBox>
            </td>

        </tr>

        <tr>
            <td></td>

            <td>
                <table style="text-align: center; width: 100%">
                    <tr>

                        <td>
                            <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" Text="Insert">
                            </asp:LinkButton></td>
                        <td>
                            <asp:LinkButton ID="btnUpload" runat="server" CssClass="btn btn-default btn-lg" UseSubmitBehavior="false" Text="Upload File(s)">
                            </asp:LinkButton>
                        </td>
                    </tr>
                </table>



            </td>
        </tr>
    </table>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        UpdateCommand="Pre_Project_UPDATE" UpdateCommandType="StoredProcedure"
        InsertCommand="Pre_Project_INSERT" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="txtName" Name="Name" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="cboCliente" Name="clientId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboPreparedBy" Name="PreparedBy" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboProposalBy" Name="ProposalBy" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboDepartment" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboType" Name="ProjectType" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtProjectLocation" Name="ProjectLocation" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtDescription" Name="Description" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="cboStatus" Name="statusId" PropertyName="SelectedValue" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="txtName" Name="Name" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="cboCliente" Name="clientId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboPreparedBy" Name="PreparedBy" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboProposalBy" Name="ProposalBy" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboDepartment" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboType" Name="ProjectType" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtProjectLocation" Name="ProjectLocation" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtDescription" Name="Description" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="cboStatus" Name="statusId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblPreProjectId" Name="Id" PropertyName="Text" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClientes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name]+' [' + isnull(Company,'...') + ']' As Name FROM Clients WHERE companyId=@companyId ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProjectType" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Jobs_types WHERE companyId=@companyId ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [FullName] As Name FROM [Employees] WHERE companyId=@companyId ORDER BY [FullName]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblPreProjectId" runat="server" Visible="False" Text="0"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>

</asp:Content>

