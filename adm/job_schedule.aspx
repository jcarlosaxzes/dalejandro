<%@ Page Title="Job Schedule" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterJOB.Master" CodeBehind="job_schedule.aspx.vb" Inherits="pasconcept20.job_schedule" %>

<%@ MasterType VirtualPath="~/ADM/MasterJOB.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadScheduler1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
      <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function RedirectPage(url) {
                window.location = url;
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"  EnableEmbeddedSkins="false" >
    </telerik:RadAjaxLoadingPanel>

    <div class="container">

        <div class="pasconcept-bar noprint">
            <span class="pasconcept-pagetitle">Calendar</span>

            <span style="float: right; vertical-align: middle;">
                <asp:LinkButton ID="btnAddEvent" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" ToolTip="Add new Event">
                     Add Event
                </asp:LinkButton>
            </span>

        </div>


        <telerik:RadScheduler ID="RadScheduler1" runat="server" Culture="en-US" RenderMode="Auto" OverflowBehavior="Auto" Width="100%"
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
            StartInsertingInAdvancedForm="False"
            StartEditingInAdvancedForm ="False"
            CustomAttributeNames="Location"
            OnFormCreating="RadScheduler1_FormCreating">
            <ResourceTypes>
                <telerik:ResourceType KeyField="ID" Name="Activity Type" TextField="Name" ForeignKeyField="ActivityId" DataSourceID="SqlDataSourceType"></telerik:ResourceType>
                <telerik:ResourceType KeyField="ID" Name="Assign to User" TextField="Name" ForeignKeyField="EmployeeId" DataSourceID="SqlDataSourceEmployees"></telerik:ResourceType>
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
            <AdvancedForm DateFormat="MM/dd/yyyy" Modal="true" Width="800px" EnableCustomAttributeEditing="true" EnableResourceEditing="true" />
            <DayView UserSelectable="True" />
            <WeekView UserSelectable="True" />
            <MonthView UserSelectable="True" AdaptiveRowHeight="true" />
            <TimelineView UserSelectable="True" />
            <MultiDayView UserSelectable="True" />
            <AgendaView UserSelectable="True" TimeColumnWidth="150px" DateColumnWidth="150px" ResourceMarkerType="Bar" />
            <Reminders Enabled="true"></Reminders>

        </telerik:RadScheduler>
    </div>
    <br />
    <asp:SqlDataSource ID="SqlDataSourceAppointments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="Appointment_DELETE" DeleteCommandType="StoredProcedure"
        InsertCommand="Appointment_INSERT" InsertCommandType="StoredProcedure"
        SelectCommand="Appointments_SELECT" SelectCommandType="StoredProcedure"
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
            <asp:ControlParameter ControlID="lblJobId" Name="JobId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="EmployeeId" PropertyName="Text"
                Type="String" />
            <asp:Parameter DefaultValue="" Name="ActivityId" Type="Int16" />
            <asp:Parameter DefaultValue="-1" Name="ClientId" Type="Int32" />
            <asp:Parameter Name="Location" Type="String" />
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="RangeStart" Type="DateTime" DefaultValue="1900/1/1"></asp:Parameter>
            <asp:Parameter Name="RangeEnd" Type="DateTime" DefaultValue="2900/1/1"></asp:Parameter>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:Parameter DefaultValue="-1" Name="employeeId" Type="Int32" />
            <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" Type="Int32" />
            <asp:Parameter DefaultValue="-1" Name="ClientId" Type="Int32" />
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
            <asp:Parameter DefaultValue="-1" Name="ClientId" Type="Int32" />
            <asp:ControlParameter ControlID="lblJobId" Name="JobId" PropertyName="Text" Type="Int32" />
            <asp:Parameter DefaultValue="" Name="EmployeeId" Type="Int32" />
            <asp:Parameter Name="Location" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceType" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Appointments_types] ORDER BY [Id]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], FullName As [Name] FROM [Employees] WHERE companyId=@companyId and isnull(Inactive,0)=0 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblJobId" runat="server" Visible="false" Text="0"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>

