<%@ Page Title="New Job" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="newjob.aspx.vb" Inherits="pasconcept20.newjob" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pasconcept-bar">
        <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
                       Cancel
        </asp:LinkButton>

        <span class="pasconcept-pagetitle">  New Job</span>

    </div>
    <div>
        <asp:ValidationSummary ID="vsClient" runat="server" ValidationGroup="JobUpdate" ForeColor="Red"
            HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were this errors:"></asp:ValidationSummary>
    </div>
    <div class="pasconcept-bar">
        <table class="table-sm" style="width: 100%">
            <tr>
                <td style="width: 200px; text-align: right">Project Year:
                </td>
                <td style="width: 180px; text-align: right">
                    <telerik:RadDropDownList ID="cboYear" runat="server" DataSourceID="SqlDataSourceYear" DataTextField="nYear"
                        DataValueField="Year" Width="100%" AutoPostBack="true" CausesValidation="false" UseSubmitBehavior="false">
                    </telerik:RadDropDownList>
                </td>
                <td style="width: 180px; text-align: right">Project Code:</td>
                <td style="width: 40px; text-align: right">
                    <asp:Label ID="lblYear" runat="server" Font-Bold="true" Font-Size="Medium">
                    </asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtCode" runat="server" Width="100px" MaxLength="4" Font-Bold="true">
                    </telerik:RadTextBox>
                </td>
            </tr>
        </table>
        <table class="table-sm" style="width: 100%">
            <tr>
                <td style="width: 200px; text-align: right">Opening Date:
                </td>
                <td>
                    <telerik:RadDatePicker ID="RadDatePicker1" runat="server" Width="180px">
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Job Name:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtJob" runat="server" Width="100%" MaxLength="80">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Template:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboProposalType" runat="server" DataSourceID="SqlDataSourceProposalType" DataTextField="Name"
                        DataValueField="Id" Width="100%" AppendDataBoundItems="True" MarkFirstMatch="True" Filter="Contains" Height="300px">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select Template...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Type:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboType" runat="server" DataSourceID="SqlDataSourceJobTypes" DataTextField="Name"
                        DataValueField="Id" Width="100%" AppendDataBoundItems="True" MarkFirstMatch="True" Filter="Contains" Height="300px">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select Job Type...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Client:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboCliente" runat="server" DataSourceID="SqlDataSourceClientes"
                        DataTextField="Name" DataValueField="Id" Width="100%" AppendDataBoundItems="True" Height="300px"
                        MarkFirstMatch="True" Filter="Contains">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select Client...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Owner Name:</td>
                <td>
                    <telerik:RadTextBox ID="txtOwnerName" runat="server" Width="100%" MaxLength="80">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Department:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboDepartment" runat="server"
                        AppendDataBoundItems="True"
                        DataSourceID="SqlDataSourceDepartments" DataTextField="Name" DataValueField="Id"
                        Width="100%" MarkFirstMatch="True"
                        Filter="Contains" Height="300px">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select Department...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Assigned Employee:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboEmployee" runat="server"
                        DataSourceID="SqlDataSourceEmployee" DataTextField="Name" DataValueField="Id"
                        Width="100%" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="True">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select Employee...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">A/E of Record:</td>
                <td>
                    <telerik:RadComboBox ID="cboEngRecord" runat="server"
                        DataSourceID="SqlDataSourceEmployee" DataTextField="Name" DataValueField="Id"
                        Width="100%" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="True">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select  A/E of Record...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Location:</td>
                <td>
                    <telerik:RadTextBox ID="txtProjectLocation" runat="server" Width="100%" MaxLength="80" EmptyMessage="Project Address">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right"></td>
                <td></td>
            </tr>
        </table>
        <%--Engeniering companies--%>
        <table class="table-sm" style="width: 100%">
            <tr>
                <td style="width: 200px; text-align: right">Budget:</td>
                <td style="width: 180px;">
                    <telerik:RadNumericTextBox ID="txtBudgest" runat="server" Width="180px" Value="0">
                    </telerik:RadNumericTextBox>
                </td>
                <td style="width: 180px; text-align: right">Construction Cost:</td>
                <td>
                    <telerik:RadNumericTextBox ID="txtCost" runat="server" Width="180px">
                    </telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Sector:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboSector" runat="server" AppendDataBoundItems="True"
                        DataSourceID="SqlDataSourceProjectSector" DataTextField="Name" DataValueField="Id"
                        Width="100%" MarkFirstMatch="True"
                        Filter="Contains" Height="300px">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select Sector...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td style="text-align: right">Use &amp; Occupancy::
                </td>
                <td>
                    <telerik:RadComboBox ID="cboUse" runat="server" AppendDataBoundItems="True"
                        DataSourceID="SqlDataSourceProjectUse" DataTextField="Name" DataValueField="Id"
                        Width="180px" MarkFirstMatch="True"
                        Filter="Contains" Height="300px">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select Use...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Signed Date::
                </td>
                <td>
                    <telerik:RadDatePicker ID="RadDatePickerSigned" runat="server" Width="180px" ToolTip="Signed Date">
                    </telerik:RadDatePicker>
                </td>
                <td style="text-align: right">Deadline:
                </td>
                <td>
                    <telerik:RadDatePicker ID="RadDatePickerDeadline" runat="server" Width="180px" ToolTip="Job Deadline">
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Quantity:
                </td>
                <td>
                    <telerik:RadNumericTextBox ID="txtUnit" runat="server" Width="100%">
                    </telerik:RadNumericTextBox>
                </td>
                <td style="text-align: right">Units
                </td>
                <td>
                    <telerik:RadComboBox ID="cboMeasure" runat="server" DataSourceID="SqlDataSourceMeasure" DataTextField="Name" DataValueField="Id" Width="180px" AppendDataBoundItems="True">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Not defined...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
        </table>
        <hr />
        <div style="text-align: center">
            <asp:LinkButton ID="btnCreateJob" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" ValidationGroup="JobUpdate">
                       <i class="fas fa-plus"></i>&nbsp;Create Job
            </asp:LinkButton>
        </div>
        <br />
        <br />
    </div>
    <%--RequiredFieldValidator--%>
    <div>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtCode" ValidationGroup="JobUpdate"
            Text="*" ErrorMessage="Define Job Number" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtJob" ValidationGroup="JobUpdate"
            Text="*" ErrorMessage="Define Job Name" SetFocusOnError="true" Display="None"></asp:RequiredFieldValidator>
        <asp:CompareValidator runat="server" ID="Comparevalidator1" ValueToCompare="(Select Job Type...)"
            Operator="NotEqual" ControlToValidate="cboType" ErrorMessage="Define Job Type" Text="*" SetFocusOnError="true" ValidationGroup="JobUpdate" Display="None"> </asp:CompareValidator>
        <asp:CompareValidator runat="server" ID="Comparevalidator2" ValueToCompare="(Select Client...)"
            Operator="NotEqual" ControlToValidate="cboCliente" Text="*" ErrorMessage="Define Client" SetFocusOnError="true" ValidationGroup="JobUpdate" Display="None"> </asp:CompareValidator>
        <asp:CompareValidator runat="server" ID="Comparevalidator5" ValueToCompare="(Select Department...)"
            Operator="NotEqual" ControlToValidate="cboDepartment" Text="*" ErrorMessage="Define Department" SetFocusOnError="true" ValidationGroup="JobUpdate" Display="None">
        </asp:CompareValidator>
        <asp:CompareValidator runat="server" ID="Comparevalidator3" ValueToCompare="(Select Sector...)"
            Operator="NotEqual" ControlToValidate="cboSector" Text="*" ErrorMessage="Define Sector" SetFocusOnError="true" ValidationGroup="JobUpdate" Display="None">
        </asp:CompareValidator>
        <asp:CompareValidator runat="server" ID="Comparevalidator4" ValueToCompare="(Select Use...)"
            Operator="NotEqual" ControlToValidate="cboUse" Text="*" ErrorMessage="Define Use" SetFocusOnError="true" ValidationGroup="JobUpdate" Display="None">
        </asp:CompareValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtBudgest" ValidationGroup="JobUpdate"
            Text="*" ErrorMessage="Budget cannot be Empty" SetFocusOnError="true" Display="None"></asp:RequiredFieldValidator>
    </div>

    <%--SqlDataSource--%>
    <div>
        <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="SELECT Id, FullName as Name FROM Employees WHERE (companyId=@companyId) ORDER BY Name">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceClientes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="SELECT [Id], [Name]+' [' + isnull(Company,'...') + ']' As Name FROM Clients WHERE companyId=@companyId ORDER BY Name">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>


        <asp:SqlDataSource ID="SqlDataSourceJobTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="SELECT Id, Name FROM Jobs_types WHERE companyId=@companyId ORDER BY Name">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>


        <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="SELECT [Id], [Name] FROM [Employees] WHERE companyId=@companyId ORDER BY [Name]">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceJobStatus" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="SELECT [Id], [Name] FROM [Jobs_status] ORDER BY [OrderBy]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceProjectSector" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="SELECT Id, Name FROM Jobs_sectors ORDER BY Name"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceProjectUse" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="SELECT Id, Name FROM Jobs_uses ORDER BY Name"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="SELECT [Year], nYear FROM Years ORDER BY [Year] DESC"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceMeasure" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="SELECT Id, Name FROM Jobs_measures ORDER BY Id"></asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceProposalType" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="SELECT Id, Name FROM Proposal_types WHERE (companyId = @companyId) ORDER BY Name">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblCompanyId" Name="companyId"
                    PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblEmployeeName" runat="server" Visible="False"></asp:Label>

        <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblId" runat="server" Text="-1" Visible="False"></asp:Label>
        <asp:Label ID="lblJobCode" runat="server" Visible="False"></asp:Label>
    </div>

</asp:Content>


