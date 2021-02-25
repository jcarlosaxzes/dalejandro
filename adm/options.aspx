﻿<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="options.aspx.vb" Inherits="pasconcept20.options" Async="true" %>

<%@ Import Namespace="pasconcept20" %>
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
        RenderMode="Lightweight" Skin="Silk" DisplayNavigationButtons="false" DisplayProgressBar="false">
        <WizardSteps>
            <telerik:RadWizardStep runat="server" ID="RadWizardStep1" Title="Employee Profile" StepType="Step">
                <fieldset style="width: 800px; height: 280px;">
                    <legend>
                        <h3>Employee Photo</h3>
                    </legend>

                    <table class="table-sm" style="width: 100%">
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
                                <telerik:RadAsyncUpload ID="RadAsyncUpload1" runat="server" RenderMode="Auto" AllowedFileExtensions=".jpeg,.jpg,.png"
                                    MaxFileInputsCount="1" Width="100%" InputSize="45" ControlObjectsVisibility="None" MaxFileSize="524288">
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
                    <table class="table-sm" style="width: 100%">
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
                                <table class="table-sm" style="width: 100%">
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
                                            <telerik:RadButton ID="btnOk" runat="server" OnClick="btnOk_Click" Text="Update Password">
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
            <telerik:RadWizardStep runat="server" ID="RadWizardStep2" Title="Page Settings" StepType="Step">
                <fieldset style="width: 800px; height: 520px;">
                    <legend>
                        <h3>Page Settings</h3>
                    </legend>
                    <div>
                        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSource1" DefaultMode="Edit" Width="100%">
                            <EditItemTemplate>
                                <table class="table-sm" style="width: 100%">
                                    <tr>
                                        <td colspan="2" style="padding-left: 50px">
                                            <h4>Favorite Home Page</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right; width: 150px" class="Normal">My Home Page:
                                        </td>
                                        <td style="text-align: left">
                                            <telerik:RadComboBox ID="RadComboBox1" runat="server" Width="350px" SelectedValue='<%# Bind("MyHomePage")%>'>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text="Projects->Job" Value="jobs.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Projects->Proposals" Value="proposals.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Projects->Requests for Proposals" Value="requestforproposals.aspx" />

                                                    <telerik:RadComboBoxItem runat="server" Text="Projects->Calendar" Value="schedule.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Projects->Timesheet" Value="timesheet.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Projects->Time Activity" Value="activejobsdashboad.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Finances->Invoices" Value="invoices.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Finances->Statements" Value="statement.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Finances->Payments" Value="payments.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Contacts->Clients" Value="clients.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Contacts->Client Management" Value="clientmanagement.aspx" />

                                                    <telerik:RadComboBoxItem runat="server" Text="Dashboards->Company Overview" Value="default.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Dashboards->Company Insights" Value="dashboard.aspx" />
                                                    <telerik:RadComboBoxItem runat="server" Text="Dashboards->Top ten" Value="topten.aspx" />

                                                    <telerik:RadComboBoxItem runat="server" Text="Reports->Permit Tracker" Value="revisions.aspx" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="padding-left: 50px">
                                            <h4>Jobs Favorite Options</h4>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="text-align: right; width: 150px" class="Normal">Period Filter:
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
                                        <td colspan="2" style="padding-left: 50px">
                                            <h4>Proposal Favorite Options</h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right; width: 150px" class="Normal">Period Filter:
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
                                    <tr>
                                        <td colspan="2" style="padding-left: 50px">
                                            <h4>Activity Calendar Favorite Options</h4>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="text-align: right; width: 150px" class="Normal">Activity Calendar Filter:
                                        </td>
                                        <td>
                                            <telerik:RadDropDownList ID="RadDropDownList1" runat="server" Width="100%" SelectedValue='<%# Bind("FilterCalendarViewAll")%>'>
                                                <Items>
                                                    <telerik:DropDownListItem Text="View My Activities" Value="0"/>
                                                    <telerik:DropDownListItem Text="View Activities forf All Employees" Value="1" />
                                                </Items>
                                            </telerik:RadDropDownList>
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

            <telerik:RadWizardStep runat="server" ID="RadWizardStep3" Title="Documents (W2, Paychecks, Contracts, Agreements)" StepType="Step">
                <h3>Employee Documents</h3>
                <telerik:RadGrid ID="RadGridFiles" runat="server" DataSourceID="SqlDataSourceAzureFiles" GridLines="None"
                    AllowPaging="True" PageSize="25" AutoGenerateColumns="False" HeaderStyle-HorizontalAlign="Center">
                    <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceAzureFiles">
                        <PagerStyle Mode="Slider" AlwaysVisible="false" />
                        <Columns>
                            <telerik:GridBoundColumn DataField="Id" HeaderText="Id" ReadOnly="True" UniqueName="Id" Display="false" HeaderStyle-Width="40px">
                            </telerik:GridBoundColumn>

                            <telerik:GridTemplateColumn HeaderText="" UniqueName="IconType" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <%# LocalAPI.CreateIcon(Eval("ContentType"), Eval("url"), Eval("guid").ToString(), Eval("Name"), 32)%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="Name" HeaderText="File Name" UniqueName="Name" SortExpression="Name" ItemStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                            <%# Eval("Name")%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="Type" HeaderText="Type" UniqueName="Type" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-Width="300px" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <%# Eval("nType")%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="Date" HeaderText="Date" UniqueName="Date" SortExpression="Date" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-Width="180px" HeaderStyle-HorizontalAlign="Center" Aggregate="Count">
                                <ItemTemplate>
                                    <%# Eval("Date", "{0:d}")%>
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
        UpdateCommand="UPDATE Employees SET MyHomePage = @MyHomePage, FilterJob_Year = @FilterJob_Year, FilterJob_Month = @FilterJob_Month, FilterJob_Employee = @FilterJob_Employee, FilterJob_Department = @FilterJob_Department, FilterProposal_Year = @FilterProposal_Year, FilterProposal_Month = @FilterProposal_Month, FilterProposal_Department = @FilterProposal_Department, FilterCalendarViewAll=@FilterCalendarViewAll WHERE (Id = @Id)">
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
            <asp:Parameter Name="FilterCalendarViewAll" />
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

    <asp:SqlDataSource ID="SqlDataSourceAzureFiles" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Employee_azureuploads_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="azureuploads_DELETE" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblEmployeeId" Name="EmployeeId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Text="0" Visible="False"></asp:Label>

</asp:Content>

