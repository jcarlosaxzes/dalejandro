<%@ Page Title="Employee New Time" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="employeenewtime.aspx.vb" Inherits="pasconcept20.employeenewtime" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">

            <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
                       Back to List
            </asp:LinkButton>
            Productive Time (<asp:Label ID="lblEmployeeName" runat="server"></asp:Label>)
        </span>
    </div>
    <table class="table-sm" style="width: 100%">
        <tr>
            <td class="pasconcept-bar" style="width: 700px; vertical-align: top">
                <div>
                    <asp:FormView ID="FormViewViewSummary" runat="server" DataSourceID="SqlDataSourceViewSummary" Width="100%" CssClass="pasconcept-subbar">
                        <ItemTemplate>
                            <table style="width: 100%">
                                <tr>
                                    <td colspan="3" style="text-align:center" class="pasconcept-pagetitle">
                                        <%# Eval("JobName") %>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 49%; text-align: center; background-color: #039be5">
                                        <span class="DashboardFont2">This Job</span><br />
                                        <asp:Label ID="lblTotalBudget" CssClass="DashboardFont1" runat="server" Text='<%# String.Concat(Eval("TotalJobHours", "{0:N0}"), " of ", Eval("HoursAssigned", "{0:N0}"), " hr")  %>'></asp:Label><br />
                                        <span class="DashboardFont3">Hours Entered of Assigned Time</span>
                                    </td>
                                    <td></td>
                                    <td style="width: 49%; text-align: center; background-color: #546e7a">
                                        <span class="DashboardFont2">Selected Week</span><br />
                                        <asp:Label ID="lblTotalPending" runat="server" CssClass="DashboardFont1" Text='<%# String.Concat(Eval("TotalWeekHours", "{0:N0}"), " of ", Eval("TotalWeekHours") + Eval("TotalWeekHoursRemaining"), " hr") %>'></asp:Label><br />
                                        <span class="DashboardFont3">Total Hours Entered</span>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:FormView>
                </div>
                <br />
                <div>
                    <table class="table-sm" style="width: 100%">
                        <tr>
                            <td style="width: 130px; text-align: right">Date:
                            </td>
                            <td>
                                <telerik:RadDatePicker ID="RadDatePicker1" runat="server" DateFormat="MM/dd/yyyy" Culture="en-US" Width="200px">
                                </telerik:RadDatePicker>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Hours:
                            </td>
                            <td style="text-align: left;">


                                <telerik:RadNumericTextBox ID="txtTimeSel" runat="server"
                                    MinValue="0.25" ShowSpinButtons="True" ButtonsPosition="Right" ToolTip="Time in hours"
                                    Value="1" Width="200px" MaxValue="24">
                                    <NumberFormat DecimalDigits="2" />
                                    <IncrementSettings Step="1" />
                                </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                    </table>
                    <div id="divProposalTask" runat="server">
                        <table class="table-sm" style="width: 100%">
                            <tr>
                                <td style="text-align: right; width: 130px">Task:
                                </td>
                                <td style="text-align: left">
                                    <telerik:RadComboBox ID="cboTask" runat="server" DataSourceID="SqlDataSourceProposalTask" Width="100%" 
                                        DataTextField="Description" DataValueField="Id" CausesValidation="false" MarkFirstMatch="True" Filter="Contains" AppendDataBoundItems="true">
                                        <Items>
                                            <telerik:RadComboBoxItem Text="(Select Task...)" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="divTickets" runat="server">
                        <table class="table-sm" style="width: 100%">
                            <tr>
                                <td style="text-align: right; width: 130px">Ticket:
                                </td>
                                <td style="text-align: left">
                                    <telerik:RadComboBox ID="cboActiveTickets" runat="server" DataSourceID="SqlDataSourceActiveTickets" Width="100%" AutoPostBack="true" Height="300px"
                                        DataTextField="Title" DataValueField="Id" CausesValidation="false" AppendDataBoundItems="true" MarkFirstMatch="True" Filter="Contains">
                                        <Items>
                                            <telerik:RadComboBoxItem Text="(Select Ticket...)" Value="0" />
                                        </Items>

                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <table class="table-sm" style="width: 100%">
                        <tr>
                            <td style="text-align: right; width: 130px">Category:
                            </td>
                            <td style="text-align: left">
                                <telerik:RadComboBox ID="cboCategory" runat="server" DataSourceID="SqlDataSourceCategory" ValidationGroup="time_insert" Height="300px"
                                    DataTextField="Name" DataValueField="Id" Width="100%" AppendDataBoundItems="true" CausesValidation="false" MarkFirstMatch="True" Filter="Contains">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="(Select Category...)" Value="0" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right; vertical-align: top">Notes:
                            </td>
                            <td style="text-align: left">
                                <telerik:RadTextBox ID="txtDescription" runat="server" Width="100%" MaxLength="512" Rows="3" TextMode="MultiLine" ValidationGroup="time_insert">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Job Status:</td>
                            <td style="text-align: left">
                                <telerik:RadComboBox ID="cboJobStatus" runat="server" Width="200px" AppendDataBoundItems="true" CausesValidation="false" MarkFirstMatch="True" Filter="Contains" ValidationGroup="time_insert">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="(Select Status...)" Value="-2" />
                                        <telerik:RadComboBoxItem Text="Done" Value="7" />
                                        <telerik:RadComboBoxItem Text="On Hold" Value="3" />
                                        <telerik:RadComboBoxItem Text="No Status Change" Value="-1" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2" style="text-align: right">
                                <br /><br />
                                <asp:LinkButton ID="btnInsertTime" runat="server" CssClass="btn btn-info btn-lg" UseSubmitBehavior="false" ValidationGroup="time_insert" Width="200px">
                                    Add Time
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnInsertTimeAndInvoice" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" ValidationGroup="time_insert" Width="200px">
                                    Add Billable Time
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                    <div>
                        <asp:ValidationSummary ID="vsClient" runat="server" ValidationGroup="time_insert" ForeColor="Red"
                            HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were this errors:"></asp:ValidationSummary>
                    </div>

                </div>
            </td>
            <td class="pasconcept-bar" style="vertical-align: top">
                <telerik:RadScheduler ID="RadScheduler1" runat="server" RenderMode="Lightweight" OverflowBehavior="Auto"
                    DataDescriptionField="Description" AllowDelete="false" Font-Size="Smaller"
                    DataEndField="End"
                    DataKeyField="Id"
                    DataSourceID="SqlDataSourceEmployeeDailyTimeWorked"
                    DataStartField="Start"
                    DataSubjectField="Subject"
                    DayEndTime="21:00:00"
                    EditFormDateFormat="MM/dd/yyyy"
                    Height="600px"
                    FirstDayOfWeek="Monday"
                    LastDayOfWeek="Sunday"
                    StartInsertingInAdvancedForm="False"
                    StartEditingInAdvancedForm="False"
                    SelectedView="MonthView"
                    ShowFooter="false" EnableDescriptionField="true">
                    <DayView UserSelectable="false"  />
                    <WeekView UserSelectable="True" />
                    <MonthView UserSelectable="True" MinimumRowHeight="4" />
                    <TimelineView UserSelectable="false" />
                    <MultiDayView UserSelectable="false" />
                    <AgendaView UserSelectable="false" />
                    <Reminders Enabled="false"></Reminders>

                </telerik:RadScheduler>
            </td>
        </tr>
    </table>
    <div style="margin-left: 10px; margin-right: 10px">
        <h3>Job Time Entry Log</h3>
        <telerik:RadGrid ID="RadGridTimes" runat="server" AllowAutomaticUpdates="True" AllowAutomaticDeletes="true" AllowSorting="True" DataSourceID="SqlDataSourceTimes"
            Width="100%" AutoGenerateColumns="False" AllowPaging="True" PageSize="100" Height="500px"
            HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
            <ClientSettings>
                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
            </ClientSettings>
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceTimes" ShowFooter="True">
                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                <Columns>
                    <telerik:GridTemplateColumn AllowFiltering="False" DataField="Id" HeaderText="Time ID" ReadOnly="True"
                        SortExpression="Id" UniqueName="Id" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkDetailId" runat="server" CommandName="Edit" CommandArgument='<%# Eval("Id") %>' UseSubmitBehavior="false"
                                Text='<%# Eval("Id")%>' ToolTip="Click to Edit detail"></asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridDateTimeColumn DataField="Fecha" DataType="System.DateTime" DataFormatString="{0:d}"
                        HeaderText="Date of Work" SortExpression="Fecha" UniqueName="Fecha" HeaderStyle-Width="120px"
                        ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridDateTimeColumn>
                    <telerik:GridDateTimeColumn DataField="DateEntry" DataFormatString="{0:d}" Display="false"
                        HeaderText="Date" SortExpression="DateEntry" UniqueName="DateEntry"
                        HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridDateTimeColumn>
                    <telerik:GridNumericColumn AllowFiltering="False" DataField="Time"
                        HeaderText="Hours" SortExpression="Time" UniqueName="Time" Aggregate="Sum"
                        DataFormatString="{0:N1}" FooterAggregateFormatString="{0:N1}" HeaderStyle-Width="100px"
                        ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridNumericColumn>
                    <telerik:GridTemplateColumn DataField="categoryId" FilterControlAltText="Filter CategoryId column" Display="false"
                        HeaderText="Category" SortExpression="categoryId" UniqueName="categoryId" HeaderStyle-HorizontalAlign="Center">
                        <EditItemTemplate>
                            <telerik:RadComboBox ID="cboCategory" runat="server" DataSourceID="SqlDataSourceCategory" SelectedValue='<%# Bind("categoryId")%>'
                                DataTextField="Name" DataValueField="Id" Width="300px" AppendDataBoundItems="true">
                                <Items>
                                    <telerik:RadComboBoxItem Text="(Select Category...)" Value="0" />
                                </Items>
                            </telerik:RadComboBox>

                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="CategoryLabel" runat="server" Text='<%# Eval("Category")%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Description" FilterControlAltText="Filter Description column"
                        HeaderText="Description" SortExpression="Description" UniqueName="Description" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description")%>' Width="600px" MaxLength="512" Rows="3" TextMode="MultiLine">
                            </telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <%# Eval("DescriptionCompuesta")%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                        CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText=""
                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings>
                    <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                    </EditColumn>
                </EditFormSettings>
            </MasterTableView>
            <PagerStyle AlwaysVisible="false" />
        </telerik:RadGrid>
    </div>



    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDescription" ErrorMessage="Notes can not be empty!"
        ValidationGroup="time_insert" Display="None">
    </asp:RequiredFieldValidator>
    <asp:CompareValidator runat="server" ID="Comparevalidator1" ValueToCompare="(Select Category...)"
        Operator="NotEqual" ControlToValidate="cboCategory" ErrorMessage="You must select Category!" ValidationGroup="time_insert" Display="None">
    </asp:CompareValidator>
    <asp:CompareValidator runat="server" ID="Comparevalidator2" ValueToCompare="(Select Status...)"
        Operator="NotEqual" ControlToValidate="cboJobStatus" ErrorMessage="You must select Job Status!" ValidationGroup="time_insert" Display="None">
    </asp:CompareValidator>


    <asp:SqlDataSource ID="SqlDataSourceProposalTask" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="ProposalTaskNewTime_v20_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblSelectedJob" Name="JobId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceCategory" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Employees_time_categories] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceTimes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="TIMES15days_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="TIME_UPDATE" UpdateCommandType="StoredProcedure"
        DeleteCommand="DELETE FROM Employees_time WHERE (Id = @Id)">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblEmployeeId" DefaultValue=" " Name="EmployeeId" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblSelectedJob" DefaultValue=" " Name="JobId" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Fecha" Type="DateTime" />
            <asp:Parameter Name="DateEntry" Type="DateTime" />
            <asp:Parameter Name="Time" />
            <asp:Parameter Name="categoryId" />
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="Id" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceActiveTickets" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Job_ActiveTickets_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblSelectedJob" Name="JobId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceViewSummary" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="EmployeeTime_v20_Balance" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="EmployeeId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblSelectedJob" Name="JobId" PropertyName="Text" />
            <asp:ControlParameter ControlID="RadDatePicker1" Name="DateOfWeek" PropertyName="SelectedDate" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceEmployeeDailyTimeWorked" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="EmployeeDailyTimeWorked_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="RadDatePicker1" Name="DateEntry" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="EmployeeId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSourceTimeType" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id]=0, [Name]='Productive Time' union all SELECT [Id]=1, [Name]='Non Productive Time' union all SELECT [Id]=2, [Name]='Holiday'"></asp:SqlDataSource>

    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblLogedEmployeeId" runat="server" Visible="False"></asp:Label>

    <asp:Label ID="lblClientId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedJob" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedTicket" runat="server" Visible="False" Text="0"></asp:Label>

</asp:Content>
