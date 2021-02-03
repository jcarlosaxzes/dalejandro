﻿<%@ Page Title="Employees" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="employees.aspx.vb" Inherits="pasconcept20.employees" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/adm/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .table-sm td, .table-sm th {
            padding-top: .05rem;
            padding-bottom: .05rem;
        }
    </style>
    <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
        <script type="text/javascript">
            function CheckBoxRequired_ClientValidate(sender, e) {
                e.IsValid = jQuery(".AcceptedAgreement input:checkbox").is(':checked');
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipDelete" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnNew">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnConfirmDelete">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnFind">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" EnableEmbeddedSkins="false" />

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Silk">
    </telerik:RadWindowManager>

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Employees</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
           
            </button>
            <asp:LinkButton ID="btnTechnicalSupport" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" ToolTip="Activate Employee for Technical Support" CausesValidation="false"
                Text="Activate Technical Support">
            </asp:LinkButton>
            <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" CausesValidation="false">
                        Add Employee
            </asp:LinkButton>
        </span>

    </div>

    <div class="collapse" id="collapseFilter">
        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
            <table width="100%" class="pasconcept-bar noprint">
                <tr>
                    <td align="right" width="100px">Status:</td>
                    <td style="width: 250px">
                        <telerik:RadComboBox ID="cboStatus" runat="server" Width="100%" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(Active Employees...)" Value="0" Selected="true" />
                                <telerik:RadComboBoxItem runat="server" Text="(Inactive Employees...)" Value="1" />
                                <telerik:RadComboBoxItem runat="server" Text="(All Employees...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" Width="100%">
                        </telerik:RadTextBox>
                    </td>
                    <td style="width: 150px; text-align: right">
                        <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="false">
                                                <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:Panel>

    </div>
    <telerik:RadWizard ID="RadWizard1" runat="server" DisplayCancelButton="false" RenderMode="Lightweight" Skin="Silk" DisplayNavigationButtons="false" DisplayProgressBar="false">
        <WizardSteps>
            <telerik:RadWizardStep runat="server" ID="RadWizardStep1" Title="Employees" StepType="Step">
                <div>
                    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
                        <script type="text/javascript">
                            function OnClientClose(sender, args) {
                                var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                                masterTable.rebind();
                            }
                        </script>
                    </telerik:RadCodeBlock>
                    <div class="pasconcept-bar noprint">
                        <span class="h4">Employee List</span>
                    </div>
                    <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" CellSpacing="0" RenderMode="Auto"
                        DataSourceID="SqlDataSource1" GridLines="None" AllowAutomaticDeletes="True"
                        AllowSorting="True" AutoGenerateColumns="False" Culture="en-US" PageSize="10"
                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small">
                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1" ShowFooter="True" EditMode="PopUp">
                            <PagerStyle Mode="Slider" AlwaysVisible="false" />
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Photo" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px">
                                    <ItemTemplate>

                                        <asp:LinkButton ID="btnEditEmpl2" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to Edit Employee Photo" CausesValidation="false"
                                            CommandName="EditPhoto" UseSubmitBehavior="false">
                                            <asp:Image ID="ImageEmployeePhoto" ImageUrl='<%#LocalAPI.GetEmployeePhotoURL(employeeId:=Eval("Id"))%>' CssClass="photo50"
                                                runat="server" AlternateText=""></asp:Image>
                                        </asp:LinkButton>

                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn Aggregate="Count" DataField="Name" FilterControlAltText="Filter Name column"
                                    FooterAggregateFormatString="{0:N0}" HeaderText="Name - Position - Email" SortExpression="Name" ReadOnly="true"
                                    UniqueName="Name" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <strong>
                                                <asp:LinkButton ID="btnEditEmpl" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to View/Edit Employee"
                                                    CommandName="EditEmployee" Text='<%# Eval("FullName") & Eval("Suffix") %>' UseSubmitBehavior="false" CausesValidation="false">
                                                </asp:LinkButton>

                                            </strong>
                                            &nbsp;&nbsp;&nbsp;<%# Eval("Position") %>
                                        </div>
                                        <div style="vertical-align: top">
                                            <%--<asp:Image ID="imgQBconncetd" ImageUrl="~/Images/qb_connected_grid.png" ToolTip="Connected to QuickBook"
                                                        runat="server" Visible='<%# LocalAPI.IsQBEmployeeConnected(Eval("Id"))%>'></asp:Image>--%>
                                            <a href='<%# string.Concat("mailto:", Eval("Email")) %>' title="Mail to"><%#Eval("Email") %></a>
                                        </div>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn Aggregate="Count" DataField="Name" FilterControlAltText="Filter Name column"
                                    FooterAggregateFormatString="{0:N0}" HeaderText="Name" SortExpression="Name" Display="false"
                                    UniqueName="Name" HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="DepartmentId" HeaderText="Department" SortExpression="DepartmentId" UniqueName="DepartmentId"
                                    ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="250px">
                                    <ItemTemplate>
                                        <%# Eval("Department")%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="PrjNumber" HeaderText="Jobs" SortExpression="PrjNumber" UniqueName="PrjNumber"
                                    ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="90px">
                                    <ItemTemplate>
                                        <%# Eval("PrjNumber", "{0:N0}")%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="ParentID" HeaderText="Boss" SortExpression="ParentID" UniqueName="ParentID"
                                    ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center" Display="false">
                                    <ItemTemplate>
                                        <%# Eval("ParentID")%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="EmployeeTimeLast30days" HeaderText="Hours" SortExpression="EmployeeTimeLast30days" UniqueName="EmployeeTimeLast30days"
                                    ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="90px" HeaderTooltip="Hours in Timesheet Last 30 days">
                                    <ItemTemplate>
                                        <%# Eval("EmployeeTimeLast30days", "{0:N0}")%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="Benefits_vacations" HeaderTooltip="Vacs | Used | Bal / Pers | Used | Bal"
                                    HeaderText="Benefits" SortExpression="Benefits_vacations" HeaderStyle-Width="160px" UniqueName="Benefits_vacations" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <table class="table table-borderless" style="width: 100%; margin-top: 10px">
                                            <tr>
                                                <td style="width: 33%; text-align: center">
                                                    <span title="Vacations"><%# Eval("Benefits_vacations")%></span>
                                                </td>
                                                <td style="width: 33%; text-align: center">
                                                    <span title="Vacations Used"><%# Eval("used_vacations")%></span>
                                                </td>
                                                <td style="text-align: center">
                                                    <span title="Vacations Pending"><%# Eval("vacations_balance")%></span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 33%; text-align: center">
                                                    <span title="Personal Days"><%# Eval("Benefits_personals")%></span>
                                                </td>
                                                <td style="width: 33%; text-align: center">
                                                    <span title="Personal Used"><%# Eval("used_personals")%></span>
                                                </td>
                                                <td style="text-align: center">
                                                    <span title="Personal Pending"><%# Eval("personals_balance")%></span>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Status" UniqueName="Inactive" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                                    <ItemTemplate>
                                        <%#IIf(Eval("Inactive"), "Inactive", "Active") %>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="Actions" HeaderStyle-HorizontalAlign="Center"
                                    ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px">
                                    <ItemTemplate>
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 33%; text-align: center">
                                                    <asp:LinkButton runat="server" ID="btnInactive" CommandName="UpdateStatus" CommandArgument='<%# Eval("Id") %>' ToolTip='<%# iif(Eval("Inactive"), "Inactive Status. Click to change", "Active Status. Click to change") %>' CausesValidation="false"
                                                        ForeColor='<%# GetStatusColor(Eval("Inactive")) %>'>
                                                            <span class='<%# ActiveInactiveIcon(Eval("Inactive")) %>'></span>
                                                    </asp:LinkButton>
                                                </td>
                                                <td style="width: 33%; text-align: center">
                                                    <asp:LinkButton runat="server" ID="btnCredentials" CommandName="SendCredentials" CommandArgument='<%# Eval("Id") %>'
                                                        ToolTip="Send Email with login credentials" CausesValidation="false">
                                                                <i class="far fa-envelope"></i>
                                                    </asp:LinkButton>
                                                </td>
                                                <td style="text-align: center">
                                                    <asp:LinkButton runat="server" ID="btnPermits" CommandName="Permits" CommandArgument='<%# Eval("Id") %>'
                                                        ToolTip="Employee Permits" CausesValidation="false">
                                                                <i class="fas fa-cog"></i>
                                                    </asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>

                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this employee  and asociate user?"
                                    ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                    UniqueName="DeleteColumn" HeaderText="" HeaderStyle-HorizontalAlign="Center"
                                    HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings>
                                <PopUpSettings Modal="true" Width="650px" Height="1000px" />
                                <FormMainTableStyle GridLines="None" CellSpacing="0" CellPadding="3" Width="100%" />
                                <FormTableStyle CellSpacing="3" CellPadding="3" BackColor="White" Width="100%" />
                                <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                    </telerik:RadGrid>

                </div>
            </telerik:RadWizardStep>
            <telerik:RadWizardStep runat="server" ID="RadWizardStep2" Title="Vacation & Holidays" StepType="Step">
                <div class="pasconcept-bar noprint">
                    <span class="h4">Employee Vacation & Holidays</span>
                </div>
                <div>
                    <telerik:RadScheduler ID="RadScheduler1" runat="server" RenderMode="Lightweight" OverflowBehavior="Auto"
                        DataDescriptionField="Description" AllowDelete="false" Font-Size="Smaller"
                        DataEndField="End"
                        DataKeyField="Id"
                        DataSourceID="SqlDataSourceEmployeeVacation"
                        DataStartField="Start"
                        DataSubjectField="Subject"
                        DayEndTime="21:00:00"
                        EditFormDateFormat="MM/dd/yyyy"
                        Height="700px"
                        FirstDayOfWeek="Monday"
                        LastDayOfWeek="Friday"
                        StartInsertingInAdvancedForm="False"
                        StartEditingInAdvancedForm="False"
                        SelectedView="MonthView"
                        ShowFooter="false" EnableDescriptionField="true">
                        <DayView UserSelectable="false" />
                        <WeekView UserSelectable="True" />
                        <MonthView UserSelectable="false" MinimumRowHeight="4"  />
                        <TimelineView UserSelectable="false" />
                        <MultiDayView UserSelectable="false" />
                        <AgendaView UserSelectable="false" />
                        <Reminders Enabled="false"></Reminders>

                    </telerik:RadScheduler>
                </div>
            </telerik:RadWizardStep>
            <telerik:RadWizardStep runat="server" ID="RadWizardStep3" Title="Hiring Timeline" StepType="Step">
                <div class="pasconcept-bar noprint">
                    <span class="h4">Employee Hiring Timeline</span>
                </div>
                <div>
                    <telerik:RadTimeline runat="server" ID="RadTimelineHiring"
                        DataSourceID="SqlDataSourceEmployeesHiringTimeLine"
                        DataTitleField="FullName"
                        DataSubtitleField="Position"
                        Orientation="Vertical"
                        AlternatingMode="true"
                        DataKeyNames="City,Country,Status,Department"
                        DataDateField="HireDate">
                        <EventTemplate>
                <div class="k-card-header">
                    <h4 class="k-card-title">#=data.FullName#</h4>
                    #=data.Position# of <b>#=data.Department#</b>
                </div>
                <div class="k-card-body">
                    <div class="k-card-description">
                        <p>
                            #=data.City#, #=data.Country#
                        </p>
                        # var images = data.images; 
                        if(images && images.length > 0) { #
                            <img src="#=images[0].src#" class="box-photo shadow-sm p-2 mb-2 bg-white rounded">
                        # } #
                    </div>
                    <div>
                        <h6>#=data.Status#</h6>
                    </div>
                </div>
                        </EventTemplate>
                        <WebServiceClientDataSource>
                            <SortExpressions>
                                <telerik:ClientDataSourceSortExpression FieldName="HireDate" SortOrder="Desc" />
                            </SortExpressions>
                            <Schema>
                                <Model>
                                    <telerik:ClientDataSourceModelField DataType="Date" FieldName="HireDate" />
                                </Model>
                            </Schema>
                        </WebServiceClientDataSource>
                    </telerik:RadTimeline>
                </div>
            </telerik:RadWizardStep>
        </WizardSteps>
    </telerik:RadWizard>


    <telerik:RadToolTip ID="RadToolTipDelete" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h3 style="margin: 0; text-align: center; color: white; width: 500px">
            <span class="navbar navbar-expand-md bg-dark text-white">Delete employee
            </span>
        </h3>
        <table class="table-sm" style="width: 450px">
            <tr>
                <td class="Titulo4">&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label32" runat="server" Text="Action to remove the employee involved:"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;- Delete the Username and Password
                </td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;- Delete the employee profile
                </td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;- Delete the employee time historial
                </td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;- Update Multiplier and Department Monthly Target
                </td>
            </tr>
            <tr>
                <td class="NormalNegrita">&nbsp;&nbsp;&nbsp;Are you sure you perform this action?
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblSelected" runat="server" Visible="False"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="center">

                    <asp:LinkButton runat="server" ID="btnConfirmDelete" CssClass="btn btn-danger btn-lg" CausesValidation="false">
                             Confirm Delete Employee
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipTechnicalSupport" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h3 style="margin: 0; text-align: center; color: white; width: 600px">
            <span class="navbar navbar-expand-md bg-dark text-white">Activate Technical Support
            </span>
        </h3>
        <br />
        <table class="table-sm" style="width: 600px">
            <tr>
                <td>PASconcept Technical Support can provide assistance with company set-up, training, and technical issues. 
                    <br />
                    <br />
                    By activating, you are granting PASconcept Technical Support access to your company's instance of PASconcept.
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <br />
                    <asp:CheckBox ID="chkAuthorizeTS" runat="server" CssClass="AcceptedAgreement" Text="&nbsp;&nbsp;I authorize the activation of PASconcept Technical Support User."></asp:CheckBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: center">
                    <br />
                    <br />
                    <asp:LinkButton runat="server" ID="btnConfirmActivateTechnicalSupport" CssClass="btn btn-success btn-lg" ValidationGroup="ConfirmActivateTechnicalSupport">
                             Activate Technical Support
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
        <asp:CustomValidator runat="server" ID="CheckBoxRequired" EnableClientScript="true" ForeColor="Red" ValidationGroup="ConfirmActivateTechnicalSupport"
            OnServerValidate="CheckBoxRequired_ServerValidate"
            ClientValidationFunction="CheckBoxRequired_ClientValidate">You must select authorize the activation box.</asp:CustomValidator>
    </telerik:RadToolTip>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="EMPLOYEES_SELECT" SelectCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboStatus" Name="InactiveId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Filter" PropertyName="Text" Type="String" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployeeVacation" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="EmployeeVacationAndHolidays_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployeesHiringTimeLine" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="EmployeesHiringTimeLine_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployee" runat="server" Visible="False"></asp:Label>

</asp:Content>
