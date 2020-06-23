<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="schedule.aspx.vb" Inherits="pasconcept20.schedule" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadScheduler1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipSend"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnCRM">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipCRM" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
    </telerik:RadAjaxLoadingPanel>

    <div class="pasconcept-bar">
        <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                        <i class="fas fa-filter"></i>&nbsp;Filter
                    </button>
        <asp:LinkButton ID="btnCRM" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" ToolTip="Insert a record of client activity (phone call, meeting, quote, ...)">
                        <i class="fas fa-plus"></i> Activity
                    </asp:LinkButton>
        <asp:LinkButton ID="btnOutlook" runat="server" CssClass="btn btn-secondary btn" UseSubmitBehavior="false" ToolTip="Export to Outlook">
                        <i class="far fa-calendar-alt"></i> Export to Outlook
                    </asp:LinkButton>
        <asp:LinkButton ID="btnPDF" runat="server" CssClass="btn btn-secondary btn" UseSubmitBehavior="false" ToolTip="Export to Outlook">
                        <i class="fas fa-download"></i> Export to PDF
                    </asp:LinkButton>

        <span class="pasconcept-pagetitle" style="padding-left: 150px;">Calendar</span>
        <span class="pasconcept-pagetitle" style="padding-left: 150px;"><asp:Label runat="server" ID="AppointmentsCount" Font-Size="Small"></asp:Label></span>
    </div>

    <div class="collapse" id="collapseFilter">

            <asp:Panel ID="pnlFind" runat="server" class="pasconcept-bar" DefaultButton="btnRefresh">


                <table class="table-sm" style="width: 100%">
                    <tr>
                        <td>
                            <telerik:RadComboBox ID="cboJob" runat="server" DataSourceID="SqlDataSourceJob" DropDownAutoWidth="Enabled"
                                DataTextField="JobName" DataValueField="Id" Width="250px" MarkFirstMatch="True" Filter="Contains"
                                Height="300px" EmptyMessage="(All Jobs...)">
                            </telerik:RadComboBox>
                            &nbsp;
                                <telerik:RadComboBox ID="cboClients" runat="server" DataSourceID="SqlDataSourceClient" DropDownAutoWidth="Enabled"
                                    DataTextField="Name" DataValueField="Id" Width="250px" MarkFirstMatch="True"
                                    Filter="Contains" Height="300px" EmptyMessage="(All Clients...)">
                                </telerik:RadComboBox>
                            &nbsp;
                                <telerik:RadComboBox ID="cboEmployee" runat="server" DropDownAutoWidth="Enabled"
                                    DataSourceID="SqlDataSourceEmployees" DataTextField="Name" DataValueField="Id" MarkFirstMatch="true" Filter="Contains"
                                    Width="250px" Height="300px" EmptyMessage="(All calendar...)">
                                </telerik:RadComboBox>

                        </td>
                        <td style="text-align: right; width: 120px">
                            <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Search
                            </asp:LinkButton>
                        </td>
                    </tr>
                </table>

            </asp:Panel>
        
    </div>

    <div>
        <telerik:RadScheduler ID="RadScheduler1" runat="server" Culture="en-US" RenderMode="Auto" OverflowBehavior="Auto"
            DataDescriptionField="Description"
            DataEndField="End"
            DataKeyField="Id"
            DataRecurrenceField="RecurrenceRule"
            DataRecurrenceParentKeyField="RecurrenceParentID"
            DataReminderField="Reminder"
            DataSourceID="SqlDataSourceAppointments"
            DataStartField="Start"
            DataSubjectField="Subject"
            DayEndTime="21:00:00"
            EditFormDateFormat="MM/dd/yyyy"
            Height="600px"
            WorkDayEndTime="23:59:59"
            FirstDayOfWeek="Monday"
            LastDayOfWeek="Sunday"
            StartInsertingInAdvancedForm="True"
            CustomAttributeNames="Location">
            <ResourceTypes>
                <telerik:ResourceType KeyField="ID" Name="Activity Type" TextField="Name" ForeignKeyField="ActivityId" DataSourceID="SqlDataSourceType"></telerik:ResourceType>
                <telerik:ResourceType KeyField="ID" Name="Assign to User" TextField="Name" ForeignKeyField="EmployeeId" DataSourceID="SqlDataSourceEmployees"></telerik:ResourceType>
                <telerik:ResourceType KeyField="ID" Name="Client" TextField="Name" ForeignKeyField="ClientId" DataSourceID="SqlDataSourceClient"></telerik:ResourceType>
                <telerik:ResourceType KeyField="ID" Name="Job" TextField="JobName" ForeignKeyField="JobId" DataSourceID="SqlDataSourceJob"></telerik:ResourceType>
            </ResourceTypes>
            <ResourceStyles>
                <telerik:ResourceStyleMapping Type="Activity Type" Text="Appointment" ApplyCssClass="rsCategoryBlue"></telerik:ResourceStyleMapping>
                <telerik:ResourceStyleMapping Type="Activity Type" Text="Meeting" ApplyCssClass="rsCategoryOrange"></telerik:ResourceStyleMapping>
                <telerik:ResourceStyleMapping Type="Activity Type" Text="Site Visit" ApplyCssClass="rsCategoryGreen"></telerik:ResourceStyleMapping>
                <telerik:ResourceStyleMapping Type="Activity Type" Text="Vacation" ApplyCssClass="rsCategoryRed"></telerik:ResourceStyleMapping>
            </ResourceStyles>
            <ExportSettings FileName="SchedulerExport" OpenInNewWindow="True">
                <Pdf Author="PASconcept" />
            </ExportSettings>
            <AdvancedForm DateFormat="MM/dd/yyyy" Modal="true" Width="600px" EnableCustomAttributeEditing="true" EnableResourceEditing="true" />
            <DayView UserSelectable="True" />
            <WeekView UserSelectable="True" />
            <MonthView UserSelectable="True" AdaptiveRowHeight="true" />
            <TimelineView UserSelectable="True" />
            <MultiDayView UserSelectable="True" />
            <AgendaView UserSelectable="True" TimeColumnWidth="150px" DateColumnWidth="150px" ResourceMarkerType="Bar" />
            <Reminders Enabled="true"></Reminders>

        </telerik:RadScheduler>
    </div>


    <telerik:RadToolTip ID="RadToolTipSend" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; color:white; width: 650px">
           <span class="navbar navbar-expand-md bg-dark text-white">Proposal Task & Share Event
            </span>
        </h2>
        <asp:Panel runat="server" ID="panelProposalTask">
            <table class="table-sm" style="width: 650px">

                <tr>
                    <td style="width: 180px">Proposal Task:
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboTask" runat="server" DataSourceID="SqlDataSourceProposalTask" ZIndex="50001" Sort="Descending"
                            DataTextField="Description" DataValueField="Id" Width="100%" CausesValidation="false">
                        </telerik:RadComboBox>
                    </td>
                </tr>
            </table>
        </asp:Panel>

        <table class="table-sm" style="width: 650px">
            <tr>
                <td style="width: 180px">Employees for notify this event:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboMultiEmployees" runat="server" DataSourceID="SqlDataSourceEmployees" DataTextField="Name" DataValueField="Id" ZIndex="50001"
                        Width="100%" CheckBoxes="true" Height="200px" EnableCheckAllItemsCheckBox="false" MarkFirstMatch="True" Filter="Contains">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: right; padding-right: 10px; padding-top: 200px">
                    <asp:LinkButton ID="btnSendCalendar" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                        Accept
                    </asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                     <asp:LinkButton ID="btnCancelSendCalendar" runat="server" CssClass="btn btn-secondary btn" UseSubmitBehavior="false" CausesValidation="false">
                                     Cancel
                     </asp:LinkButton>
                </td>

            </tr>
        </table>
    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipCRM" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; color:white; width: 600px">
           <span class="navbar navbar-expand-md bg-dark text-white">New Client Activity Record
            </span>
        </h2>
        <table class="table-sm" style="width: 600px">
            <tr>
                <td>
                    <telerik:RadComboBox ID="cboActivityType" runat="server" DataSourceID="SqlDataSourceType" ZIndex="50001"
                        DataTextField="Name" DataValueField="Id" Width="100%" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem Text="(Select Activity Type...)" Value="-1" />
                        </Items>
                    </telerik:RadComboBox>
                    <asp:CompareValidator runat="server" ID="Comparevalidator2" ValueToCompare="(Select Activity Type...)" ValidationGroup="NewClientActivity"
                        Operator="NotEqual" ControlToValidate="cboActivityType" ErrorMessage="(*) You must select activity type!">
                    </asp:CompareValidator>

                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadComboBox ID="cboClient" runat="server" DataSourceID="SqlDataSourceClients" ZIndex="50001"
                        DataTextField="Name" DataValueField="Id" Width="100%" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem Text="(Select Clients...)" Value="-1" />
                        </Items>
                    </telerik:RadComboBox>
                    <asp:CompareValidator runat="server" ID="Comparevalidator1" ValueToCompare="(Select Clients...)" ValidationGroup="NewClientActivity"
                        Operator="NotEqual" ControlToValidate="cboClient" ErrorMessage="(*) You must select client!">
                    </asp:CompareValidator>

                </td>
            </tr>
            <tr>
                <td style="height: 45px; vertical-align: top">
                    <telerik:RadComboBox ID="cboEmployees" runat="server" DataSourceID="SqlDataSourceEmployees" DataTextField="Name" DataValueField="Id" ZIndex="50001"
                        Width="100%" CheckBoxes="true" Height="300px" EnableCheckAllItemsCheckBox="true" MarkFirstMatch="True" Filter="Contains" EmptyMessage="(Select CC...)">
                        <Localization AllItemsCheckedString="All Items Checked" CheckAllString="Check All..." ItemsCheckedString="items checked"></Localization>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadTextBox ID="txtSubject" runat="server" EmptyMessage="Subject" Width="100%" MaxLength="255">
                    </telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtSubject" ValidationGroup="NewClientActivity"
                        ErrorMessage="(*) Subject is required"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadTextBox ID="txtDescription" runat="server" EmptyMessage="Description" Width="100%" MaxLength="1024" TextMode="MultiLine" Rows="6">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right; padding-right: 25px; padding-top: 15px">
                    <telerik:RadButton ID="btnCRMOk" runat="server" Text="Insert" Width="125px" ValidationGroup="NewClientActivity">
                        <Icon PrimaryIconCssClass="rbAdd" PrimaryIconLeft="4" PrimaryIconTop="4"></Icon>
                    </telerik:RadButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <telerik:RadButton ID="btnCancel" runat="server" Text="Cancel" Width="125px" CausesValidation="false">
                        <Icon PrimaryIconCssClass="rbCancel" PrimaryIconLeft="4" PrimaryIconTop="4"></Icon>
                    </telerik:RadButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <asp:SqlDataSource ID="SqlDataSourceAppointments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="Appointment_DELETE" DeleteCommandType="StoredProcedure"
        InsertCommand="Appointment_INSERT" InsertCommandType="StoredProcedure"
        UpdateCommand="Appointment_UPDATE" UpdateCommandType="StoredProcedure"
        SelectCommand="Appointments_SELECT" SelectCommandType="StoredProcedure">
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
            <asp:Parameter Name="ActivityId" Type="Int16" />
            <asp:Parameter Name="ClientId" Type="Int32" />
            <asp:Parameter Name="JobId" Type="Int32" />
            <asp:Parameter Name="EmployeeId" Type="String" />
            <asp:Parameter Name="Location" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="RangeStart" Type="DateTime" DefaultValue="1900/1/1"></asp:Parameter>
            <asp:Parameter Name="RangeEnd" Type="DateTime" DefaultValue="2900/1/1"></asp:Parameter>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboEmployee" Name="employeeId" PropertyName="SelectedValue" Type="Int32" DefaultValue="-1" />
            <asp:ControlParameter ControlID="cboClients" Name="ClientId" PropertyName="SelectedValue" Type="Int32" DefaultValue="-1" />
            <asp:ControlParameter ControlID="cboJob" Name="jobId" PropertyName="SelectedValue" Type="Int32" DefaultValue="-1" />
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
            <asp:Parameter Name="ClientId" Type="Int32" />
            <asp:Parameter Name="JobId" Type="Int32" />
            <asp:Parameter Name="EmployeeId" Type="Int32" />
            <asp:Parameter Name="Location" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [FullName] as Name FROM [Employees] WHERE companyId=@companyId and isnull(Inactive,0)=0 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name]+' [' + isnull(Company,'...') + ']' As Name FROM [Clients] WHERE companyId=@companyId  ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceJob" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOBS_Active_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceType" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Appointments_types] ORDER BY [Id]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClients" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name+' [' + isnull(Company,'...') + ']' As Name  FROM Clients WHERE (companyId = @companyId) Order by Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClientActivity" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="Appointment_client_INSERT" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="cboActivityType" Name="ActivityId" PropertyName="SelectedValue" Type="Int16" />
            <asp:ControlParameter ControlID="cboClient" Name="ClientId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtSubject" Name="Subject" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtDescription" Name="Description" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblEmployee" Name="EmployeeId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceProposalTask" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="ProposalTaskAppoitment_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblSelectedJob" Name="JobId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblSelectedSubject" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblTextAppointment" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedAppointmentId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedJob" runat="server" Visible="False"></asp:Label>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployee" runat="server" Visible="False"></asp:Label>
</asp:Content>

