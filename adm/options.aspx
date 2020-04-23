<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="options.aspx.vb" Inherits="pasconcept20.options" Async="true"  %>

<%@ MasterType VirtualPath="~/adm/ADM_Main_Responsive.master" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style>
        .photo100 {
            box-shadow: inset 0 0 30px rgba(0,0,0,.3);
            margin: 0 10px 0 0;
            width: 100px;
            /*height: 50px;*/
            border-radius: 50%;
            background-size: 100%;
            background-repeat: no-repeat;
            display: inline-block;
        }
    </style>

    <telerik:RadWizard ID="RadWizard1" runat="server" Height="720px" DisplayCancelButton="false"
        RenderMode="Lightweight" Skin="Material" DisplayNavigationButtons="false">
        <WizardSteps>
            <telerik:RadWizardStep runat="server" ID="RadWizardStep1" Title="Employee Profile" StepType="Step">
                <fieldset style="width: 800px; height: 280px;">
                    <legend>
                        <h3>Employee Photo</h3>
                    </legend>

                    <table class="table-condensed" style="width: 100%">
                        <tr>
                            <td>You can define your personal avatar. 
                                    Please select a .jpg file to upload
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Image ID="Image1" runat="server" Width="100px" CssClass="photo100" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                               <telerik:RadAsyncUpload ID="RadAsyncUpload1" runat="server"
                                    AllowedFileExtensions=".jpeg,.jpg,.png"
                                    MaxFileInputsCount="1"
                                    Width="100%" InputSize="45" ControlObjectsVisibility="None" MaxFileSize="524288">
                                </telerik:RadAsyncUpload>
                            </td>
                            <td>
                                <telerik:RadButton runat="server" ID="btnSubmit" Text="Upload Image" UseSubmitBehavior="false">
                                    <Icon PrimaryIconCssClass="rbUpload"></Icon>
                                </telerik:RadButton>
                                <br />
                                <asp:Label ID="Label1" Text="*Size limit: 500Kb. Recommended resolution 60x70" runat="server" Style="font-size: 10px;"></asp:Label>
                            </td>
                        </tr>
                    </table>

                </fieldset>
                <fieldset style="width: 800px; height: 380px;">
                    <legend>
                        <h3>Change Password</h3>
                    </legend>
                    <table class="table-condensed" style="width: 100%">
                        <tr>
                            <td>You can change the password to access your PASconcept account. Please bear in mind that the new password must comply with the following specifications:
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: left; padding-left: 50px" class="Normal">
                                <ul>
                                    <li>Minimum 6 (six) characters in length required</li>
                                    <li>Minimum 1 (one) nonalphanumeric character required</li>
                                </ul>
                            </td>
                        </tr>

                        <tr>
                            <td align="left">
                                <table class="table-condensed" style="width: 100%">
                                    <tr>
                                        <td align="right" width="150px" class="Normal">Old Password:
                                        </td>
                                        <td colspan="2">
                                            <telerik:RadTextBox ID="txtOldPass" runat="server" TextMode="Password" Width="180px">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" class="Normal">New Password:
                                        </td>
                                        <td colspan="2">
                                            <telerik:RadTextBox ID="txtPass" runat="server" TextMode="Password" Width="180px">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" class="Normal">Confirm Password:
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="txtConPass" runat="server" TextMode="Password" Width="180px">
                                            </telerik:RadTextBox>
                                        </td>
                                        <td>
                                            <telerik:RadButton ID="btnOk" runat="server" OnClick="btnOk_Click" Text="Update Password" >
                                                <Icon PrimaryIconCssClass="rbSave"></Icon>
                                            </telerik:RadButton>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                            <asp:Label ID="lblMsg" runat="server" CssClass="Error"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </telerik:RadWizardStep>
            <telerik:RadWizardStep runat="server" ID="RadWizardStep2" Title="Page Settingse" StepType="Step">
                <fieldset style="width: 800px; height: 520px;">
                    <legend>
                        <h3>
                        Page Settings</h4></legend>
                    <div>
                        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSource1" DefaultMode="Edit" Width="100%">
                            <EditItemTemplate>


                                <table class="table-condensed" style="width: 100%">
                                    <tr>
                                        <td colspan="2" style="padding-left: 50px" class="NormalNegrita">You can define your favorite home page to begin PASconcept:
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right; width: 150px" class="Normal">My Favorite Page:
                                        </td>
                                        <td style="text-align: left">
                                            <telerik:RadComboBox ID="RadComboBox1" runat="server" Width="250px" SelectedValue='<%# Bind("MyHomePage")%>'>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text="Home Page" Value="Default.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Schedule" Value="~/ADM/Schedule.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Job List" Value="Jobs.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Proposal List" Value="Proposals.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Invoices" Value="Invoices.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Statements" Value="Jobs.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Client List" Value="Clients.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Client Management" Value="ClientManagement.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Requests for Proposals" Value="RequestForProposals.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Timesheet" Value="TimeSheet.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Dashboard" Value="Dashboard.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Project Schedule" Value="ProjectSchedule.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Project Map" Value="ProjectMap.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Top ten" Value="TopTen.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Messages" Value="Messages.aspx" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="padding-left: 100px; padding-top: 10px" class="NormalNegrita">Pre-defined filters for Job List page
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right; width: 150px" class="Normal">Period:
                                        </td>
                                        <td>
                                            <telerik:RadDropDownList ID="cboMesJob" runat="server" Width="100%" SelectedValue='<%# Bind("FilterJob_Month")%>'>
                                                <Items>
                                                    <telerik:DropDownListItem Text="(Last 30 days)" Value="30" Selected="true" />
                                                    <telerik:DropDownListItem Text="(Last 60 days)" Value="60" />
                                                    <telerik:DropDownListItem Text="(Last 90 days)" Value="90" />
                                                    <telerik:DropDownListItem Text="Last 120 days" Value="120" />
                                                    <telerik:DropDownListItem Text="Last 180 days" Value="180" />
                                                    <telerik:DropDownListItem Text="Last 365 days" Value="365" />
                                                    <telerik:DropDownListItem Text="(This year...)" Value="14" />
                                                    <telerik:DropDownListItem Text="(All years...)" Value="13" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right; width: 150px" class="Normal">Employee Filter:
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="cboEmployeeJob" runat="server" DataSourceID="SqlDataSourceEmpl_activos" SelectedValue='<%# Bind("FilterJob_Employee")%>'
                                                Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text="(All Employees...)" Value="-1" Selected="true" />

                                                </Items>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right; width: 150px" class="Normal">Department Filter:
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="cboDepartments" runat="server" DataSourceID="SqlDataSourceDepartments" DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("FilterJob_Department")%>'
                                                Width="100%" AppendDataBoundItems="true">
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text="(All Departments...)" Value="-1" Selected="true" />
                                                </Items>
                                            </telerik:RadComboBox>

                                        </td>
                                    </tr>


                                    <tr>
                                        <td colspan="2" style="padding-left: 100px; padding-top: 10px" class="NormalNegrita">Pre-defined filters for Proposal List page
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right; width: 150px" class="Normal">Period:
                                        </td>
                                        <td>
                                            <telerik:RadDropDownList ID="cboMesProposal" runat="server" Width="100%" SelectedValue='<%# Bind("FilterProposal_Month")%>'>
                                                <Items>
                                                    <telerik:DropDownListItem Text="(Last 30 days)" Value="30" Selected="true" />
                                                    <telerik:DropDownListItem Text="(Last 60 days)" Value="60" />
                                                    <telerik:DropDownListItem Text="(Last 90 days)" Value="90" />
                                                    <telerik:DropDownListItem Text="(Last 120 days)" Value="120" />
                                                    <telerik:DropDownListItem Text="(Last 180 days)" Value="180" />
                                                    <telerik:DropDownListItem Text="(Last 120 days)" Value="120" />
                                                    <telerik:DropDownListItem Text="(Last 180 days)" Value="180" />
                                                    <telerik:DropDownListItem Text="(Last 365 days)" Value="365" />
                                                    <telerik:DropDownListItem Text="(This year)" Value="14" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right; width: 150px" class="Normal">Department Filter:
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="cboDptoProposal" runat="server" DataSourceID="SqlDataSourceDepartments" DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("FilterProposal_Department")%>'
                                                Width="100%" AppendDataBoundItems="true">
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text="(All Departments...)" Value="-1" Selected="true" />
                                                </Items>
                                            </telerik:RadComboBox>

                                        </td>
                                    </tr>
                                </table>
                                <div style="text-align: right">
                                    <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" ToolTip="Update" CommandName="Update">
                                        Update
                                    </asp:LinkButton>
                                </div>


                            </EditItemTemplate>

                        </asp:FormView>

                    </div>

                </fieldset>
            </telerik:RadWizardStep>
            <telerik:RadWizardStep runat="server" ID="RadWizardStep3" Title="Mobile App" StepType="Step">
                <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSourceMobile" HeaderStyle-HorizontalAlign="Center">
                    <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSourceMobile">
                        <Columns>
                            <telerik:GridBoundColumn UniqueName="Platform" HeaderText="Platform" DataField="Platform" HeaderStyle-Width="200px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="VersionNumber" HeaderText="Version" DataField="VersionNumber" HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Center" >
                            </telerik:GridBoundColumn>

                            <telerik:GridTemplateColumn DataField="Url" HeaderText="Distribution Page Link" UniqueName="Download">
                                <ItemTemplate>
                                    <a href='<%# iif(Eval("Platform") = "iPhone", "https://www.pasconcept.com/Distribution/iphone.aspx", "https://www.pasconcept.com/Distribution/android.aspx") %>' target="_blank"><%#String.Concat("PASconcept Mobile App Distribution page for ", Eval("Platform"))%></a>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </telerik:RadWizardStep>
        </WizardSteps>
    </telerik:RadWizard>




    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="EmployyeOthersSettings_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="UPDATE Employees SET MyHomePage = @MyHomePage, FilterJob_Year = @FilterJob_Year, FilterJob_Month = @FilterJob_Month, FilterJob_Employee = @FilterJob_Employee, FilterJob_Department = @FilterJob_Department, FilterProposal_Year = @FilterProposal_Year, FilterProposal_Month = @FilterProposal_Month, FilterProposal_Department = @FilterProposal_Department WHERE (Id = @Id)">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="MyHomePage" />
            <asp:Parameter Name="FilterJob_Year" />
            <asp:Parameter Name="FilterJob_Month" />
            <asp:Parameter Name="FilterJob_Employee" />
            <asp:Parameter Name="FilterJob_Department" />
            <asp:Parameter Name="FilterProposal_Year" />
            <asp:Parameter Name="FilterProposal_Month" />
            <asp:Parameter Name="FilterProposal_Department" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="Id" PropertyName="Text" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceYears" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Year], nYear FROM Years ORDER BY Year DESC"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmpl_activos" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, FullName as Name, Employee_Code FROM Employees WHERE companyId=@companyId and isnull(Inactive,0)=0 ORDER BY Name">
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

    <asp:SqlDataSource ID="SqlDataSourceMobile" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Platform]=case when [Platform]=1 then 'iPhone' else 'Android' end ,[VersionNumber],[Url]  FROM [dbo].[MobileAppVersions] WHERE [Latest]=1"></asp:SqlDataSource>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Text="0" Visible="False"></asp:Label>

</asp:Content>

