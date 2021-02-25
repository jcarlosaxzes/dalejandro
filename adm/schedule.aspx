<%@ Page Title="Activity Calendar" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="schedule.aspx.vb" Inherits="pasconcept20.schedule" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <%-- <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadScheduler1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipSend"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGridPending"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGridPending">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridPending" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadScheduler1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadGridPending"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="cboEmployee"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="lblTitle"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" EnableEmbeddedSkins="false">
    </telerik:RadAjaxLoadingPanel>--%>


    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function RedirectPage(url) {
                window.location = url;
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Activity Calendar</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>

            <asp:LinkButton ID="btnOutlook" runat="server" CssClass="btn btn-secondary btn" UseSubmitBehavior="false" ToolTip="Export to Outlook">
                        <i class="far fa-calendar-alt"></i>&nbsp; Export to Outlook
            </asp:LinkButton>
            <asp:LinkButton ID="btnPDF" runat="server" CssClass="btn btn-secondary btn" UseSubmitBehavior="false" Visible="false">
                        Export to PDF
            </asp:LinkButton>

            <asp:LinkButton ID="btnAddEvent" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" ToolTip="Add new Activity">
                            Add Activity
            </asp:LinkButton>
        </span>

    </div>

    <div class="collapse" id="collapseFilter">

        <asp:Panel ID="pnlFind" runat="server" class="pasconcept-bar" DefaultButton="btnRefresh">
            <table class="table-sm" style="width: 100%">
                <tr>
                    <td style="width: 300px">
                        <telerik:RadComboBox ID="cboEmployee" runat="server" DropDownAutoWidth="Enabled"
                            DataSourceID="SqlDataSourceEmployees" DataTextField="Name" DataValueField="Id" MarkFirstMatch="true" Filter="Contains"
                            Width="100%" Height="300px" EmptyMessage="(All Employees...)">
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 300px">
                        <telerik:RadComboBox ID="cboClients" runat="server" DataSourceID="SqlDataSourceClient" DropDownAutoWidth="Enabled"
                            DataTextField="Name" DataValueField="Id" Width="100%" MarkFirstMatch="True"
                            Filter="Contains" Height="300px" EmptyMessage="(All Clients...)">
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 300px;">
                        <telerik:RadComboBox ID="cboJob" runat="server" DataSourceID="SqlDataSourceJob" DropDownAutoWidth="Enabled"
                            DataTextField="JobName" DataValueField="Id" Width="100%" MarkFirstMatch="True" Filter="Contains"
                            Height="300px" EmptyMessage="(All Jobs...)">
                        </telerik:RadComboBox>

                    </td>
                    <td style="text-align: right">
                        <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>

        </asp:Panel>

    </div>

    <table class="table-sm" style="width: 100%; padding-top: 5px">
        <tr>
            <td style="width: 35%; vertical-align: top">
                Pending Activities for <asp:Label ID="lblTitle" runat="server" Font-Bold="true" Text="all employees"></asp:Label>
                <div style="margin-top: 10px">
                    <telerik:RadGrid ID="RadGridPending" runat="server" DataSourceID="SqlDataSourcePending" AutoGenerateColumns="False" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" RenderMode="Lightweight" Width="100%" Skin="Material" ShowHeader="false">
                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourcePending">
                            <NoRecordsTemplate>
                                No Pending Activities for Records
                            </NoRecordsTemplate>
                            <Columns>
                                <telerik:GridBoundColumn DataField="Id" Display="False" UniqueName="Id" HeaderStyle-Width="50px">
                                </telerik:GridBoundColumn>

                                <telerik:GridTemplateColumn UniqueName="Subject">
                                    <ItemTemplate>
                                        <div style="font-weight: bold">
                                            <asp:Label ID="lblEmployeeName" runat="server" Text='<%# Eval("DueDate", "{0:d}") %>' ForeColor='<%# GetDueDateColor(Eval("DueDate")) %>'></asp:Label>
                                            - <%# Eval("ActivityType") %> - <%# Eval("Subject") %>
                                        </div>
                                        <div>
                                            <%# Eval("EmployeeName") %>,
                                            <asp:HyperLink ID="InitialsLabel" runat="server" NavigateUrl="javascript:void(0);"><%# Eval("ClientandCompany") %></asp:HyperLink>
                                            <telerik:RadToolTip ID="RadToolTipContact" runat="server" TargetControlID="InitialsLabel" RelativeTo="Element"
                                                RenderMode="Lightweight" EnableViewState="true" ShowCallout="false" RenderInPageRoot="true"
                                                Position="BottomCenter" Modal="True" Title="" ShowEvent="OnClick"
                                                HideDelay="300" HideEvent="ManualClose" IgnoreAltAttribute="true">
                                                <table class="table-sm">
                                                    <tr>
                                                        <td colspan="2">
                                                            <asp:LinkButton ID="btnEditCli" runat="server" CommandArgument='<%# Eval("clientId") %>'
                                                                CommandName="EditClient" Text='<%# Eval("ClientName")%>' UseSubmitBehavior="false" Font-Size="Medium"
                                                                CssClass="badge badge-info ">
                                                            </asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" style="margin-top: 10px">
                                                            <%# Eval("Company") %>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 60px">Phone:
                                                        </td>
                                                        <td>
                                                            <telerik:RadMaskedTextBox ID="PhoneTextBox" runat="server" ReadOnly="true"
                                                                Text='<%# LocalAPI.GetClientProperty(Eval("ClientId"), "Phone")%>' Mask="(###) ###-####" BorderStyle="None" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Cellular:
                                                        </td>
                                                        <td>
                                                            <telerik:RadMaskedTextBox ID="RadMaskedTextBox1" runat="server" ReadOnly="true"
                                                                Text='<%# LocalAPI.GetClientProperty(Eval("ClientId"), "Cellular")%>' Mask="(###) ###-####" BorderStyle="None" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Email:
                                                        </td>
                                                        <td>
                                                            <a href='<%#String.Concat("mailto:", Eval("Email")) %>' title="Mail to"><%#Eval("Email") %></a>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </telerik:RadToolTip>

                                        </div>
                                        <div>
                                            <a href='<%# LocalAPI.GetSharedLink_URL(Eval("SharedLink_URLId"), Eval("AdditionalEntityId")) %>' target="_blank">
                                                <%# Eval("AdditionalEntityName") %>
                                            </a>
                                        </div>
                                        <div>
                                            <%# Eval("Description") %>
                                        </div>
                                        <div>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>


                                <telerik:GridTemplateColumn HeaderText="" UniqueName="EditActivity" HeaderStyle-Width="32px" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton2" runat="server" UseSubmitBehavior="false" CommandName="EditActivity" CommandArgument='<%# Eval("Id")%>' ToolTip="Edit Activity">
                                            <i style="color:dimgray" class="fas fa-pencil-alt"></i>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="" UniqueName="Complete" HeaderStyle-Width="32px" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" UseSubmitBehavior="false" CommandName="Complete" CommandArgument='<%# Eval("Id")%>' ToolTip="Complete this Activity">
                                            <i style="color:dimgray" class="fas fa-check"></i>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>
            </td>

            <td style="vertical-align: top">
                <telerik:RadScheduler ID="RadScheduler1" runat="server" Culture="en-US" RenderMode="Auto" OverflowBehavior="Auto"
                    DataDescriptionField="Description" Skin="Material"
                    DataEndField="End"
                    DataKeyField="Id"
                    Font-Size="Smaller"
                    DataRecurrenceField="RecurrenceRule"
                    DataRecurrenceParentKeyField="RecurrenceParentID"
                    DataReminderField="Reminder"
                    DataSourceID="SqlDataSourceAppointments"
                    DataStartField="Start"
                    DataSubjectField="Subject"
                    DayEndTime="21:00:00"
                    EditFormDateFormat="MM/dd/yyyy"
                    Height="700px"
                    WorkDayEndTime="23:59:59"
                    FirstDayOfWeek="Monday"
                    LastDayOfWeek="Sunday"
                    StartInsertingInAdvancedForm="False"
                    StartEditingInAdvancedForm="False"
                    CustomAttributeNames="Location"
                    OnFormCreating="RadScheduler1_FormCreating">
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
                    <AdvancedForm DateFormat="MM/dd/yyyy" Modal="true" Width="800px" EnableCustomAttributeEditing="true" EnableResourceEditing="true" />
                    <DayView UserSelectable="True" />
                    <WeekView UserSelectable="True" />
                    <MonthView UserSelectable="True" MinimumRowHeight="5" />
                    <TimelineView UserSelectable="True" />
                    <MultiDayView UserSelectable="True" />
                    <AgendaView UserSelectable="True" TimeColumnWidth="150px" DateColumnWidth="150px" ResourceMarkerType="Bar" />
                    <Reminders Enabled="true"></Reminders>

                </telerik:RadScheduler>
            </td>

        </tr>

    </table>

    <div>
        <telerik:RadToolTip ID="RadToolTipComplete" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">

            <table class="table-sm" style="width: 600px">
                <tr>
                    <td colspan="2">
                        <h3 style="margin: 0; text-align: center; color: white; width: 600px">
                            <span class="navbar navbar-expand-md bg-dark text-white">Complete Activity</span>
                        </h3>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lblActivitySubject" runat="server" Visible="False"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 180px; text-align: right">Completed Date:
                    </td>
                    <td>
                        <telerik:RadDateTimePicker ID="RadDateTimePickerCompletedDate" runat="server" Width="250px" ZIndex="50001">
                        </telerik:RadDateTimePicker>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Duration:
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboDuration" runat="server" Width="100%" ZIndex="50001" AppendDataBoundItems="True">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="15 Mins" Value="15" />
                                <telerik:RadComboBoxItem runat="server" Text="30 Mins" Value="30" />
                                <telerik:RadComboBoxItem runat="server" Text="45 Mins" Value="45" />
                                <telerik:RadComboBoxItem runat="server" Text="1 Hr" Value="60" />
                                <telerik:RadComboBoxItem runat="server" Text="2 Hrs" Value="120" />
                                <telerik:RadComboBoxItem runat="server" Text="4 Hrs" Value="240" />
                                <telerik:RadComboBoxItem runat="server" Text="8 Hrs" Value="480" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: right">
                        <br /><br />
                        <asp:LinkButton ID="btnCompleteActivity" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" ValidationGroup="vActivity">
                                    <i class="far fa-calendar"></i>&nbsp;Complete Activity
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
        </telerik:RadToolTip>
    </div>

    <asp:Label runat="server" ID="AppointmentsCount" Font-Size="Small"></asp:Label>

    <asp:SqlDataSource ID="SqlDataSourceAppointments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="Appointment_DELETE" DeleteCommandType="StoredProcedure"
        UpdateCommand="Appointment_DragAndDrop_UPDATE" UpdateCommandType="StoredProcedure"
        SelectCommand="Appointments_SELECT" SelectCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </DeleteParameters>
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
            <asp:Parameter Name="Start" Type="DateTime" />
            <asp:Parameter Name="End" Type="DateTime" />
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


    <asp:SqlDataSource ID="SqlDataSourcePending" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Appointments_Pending_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboEmployee" Name="employeeId" PropertyName="SelectedValue" Type="Int32" DefaultValue="-1" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblSelectedSubject" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblTextAppointment" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedAppointmentId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedJob" runat="server" Visible="False"></asp:Label>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>


</asp:Content>

