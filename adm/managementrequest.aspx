<%@ Page Title="Management Request" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="managementrequest.aspx.vb" Inherits="pasconcept20.managementrequest" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadFormDecorator ID="FormDecorator1" runat="server" DecoratedControls="all" DecorationZoneID="decorationZone" Skin="Bootstrap"></telerik:RadFormDecorator>
    <div id="decorationZone">
        <telerik:RadDataForm runat="server" ID="RadDataForm1" DataKeyNames="Id" DataSourceID="SqlDataSource1" Skin="Bootstrap">
            <ItemTemplate>
                <telerik:RadPageLayout ID="RadPageLayout1" runat="server" GridType="Fluid">
                    <Rows>
                        <telerik:LayoutRow>
                            <Columns>
                                <telerik:LayoutColumn Span="12">
                                    <h1>Time off request</h1>
                                </telerik:LayoutColumn>
                            </Columns>
                        </telerik:LayoutRow>
                        <telerik:LayoutRow>
                            <Columns>
                                <telerik:LayoutColumn Span="6">
                                    <div>

                                        <h4 style="border: none">The following time off request has been submitted</h4>
                                        <h4 style="border: none">for the employee&nbsp;<b><%# Eval("EmployeeFullName") %></b></h4>
                                        <h4 style="border: none">Reason for request:&nbsp;<b><%# Eval("TypeName") %></b></h4>
                                        <h4 style="border: none">Date Request:&nbsp;<%# Eval("DateRequest", "{0:d}")%>&nbsp;&nbsp;&nbsp;Status:&nbsp;<b><%# Eval("StatusName") %></b></h4>
                                        <h4 style="border: none"><%# IIf(Eval("DateFrom") = Eval("DateTo"), "", String.Concat("Number of days requested:&nbsp;<b>", Eval("nDays"), "</b>"))%></h4>
                                        <h5 style="border: none">Dates of absence, From &nbsp;<b><%# Eval("DateFrom", "{0:d}") %></b>&nbsp;to&nbsp; <b><%# Eval("DateTo", "{0:d}") %></b></h5>
                                        <h5 style="border: none">Hours of absence, each day:&nbsp;<%# Eval("Hours") %></h5>
                                        <h5 style="border: none">Employee Explanation:&nbsp;<%# Eval("Notes") %></h5>
                                    </div>
                                </telerik:LayoutColumn>
                                <telerik:LayoutColumn Span="6">
                                    <div>
                                        <table class="table-sm" style="width:100%">
                                            <tr>
                                                <td style="width:25%;text-align:center"><b>Benfits</b></td>
                                                <td style="width:25%;text-align:center"><b>Assined</b></td>
                                                <td style="width:25%;text-align:center"><b>Used</b></td>
                                                <td style="width:25%;text-align:center"><b>Balance</b></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align:center">Vacations</td>
                                                <td style="text-align:center"><%# Eval("Benefits_vacations") %></td>
                                                <td style="text-align:center"><%# Eval("used_vacations") %></td>
                                                <td style="text-align:center"><%# Eval("Benefits_vacations")-Eval("used_vacations") %></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align:center">Personal/Sick</td>
                                                <td style="text-align:center"><%# Eval("Benefits_personals") %></td>
                                                <td style="text-align:center"><%# Eval("used_personals") %></td>
                                                <td style="text-align:center"><%# Eval("Benefits_personals")-Eval("used_personals") %></td>
                                            </tr>
                                        </table>
                                    </div>
                                </telerik:LayoutColumn>
                            </Columns>
                        </telerik:LayoutRow>
                        <telerik:LayoutRow>
                            <Columns>
                                <telerik:LayoutColumn Span="12">
                                    <h3>Response Explanation:&nbsp;</h3>
                                    <telerik:RadTextBox ID="txtExplanation" runat="server" Text='<%# Bind("NotesResponse")%>' Enabled='<%# Eval("Status") = 0%>' Width="100%"></telerik:RadTextBox>
                                </telerik:LayoutColumn>
                            </Columns>
                        </telerik:LayoutRow>
                        <telerik:LayoutRow>
                            <Columns>
                                <telerik:LayoutColumn Span="12">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtExplanation" Text="(*) Response Explanation can not be empty" SetFocusOnError="true">
                                    </asp:RequiredFieldValidator>
                                </telerik:LayoutColumn>
                            </Columns>
                        </telerik:LayoutRow>
                        <telerik:LayoutRow>
                            <Columns>
                                <telerik:LayoutColumn Span="3">
                                    <div style="padding-bottom:10px">
                                        <telerik:RadButton ID="btnSign" runat="server" Text="Accept" Enabled='<%# Eval("Status") = 0%>' OnClick="btnAccept_Click" Width="120px" CausesValidation="true" />
                                    </div>
                                </telerik:LayoutColumn>
                                <telerik:LayoutColumn Span="3">
                                    <div style="padding-bottom:10px">
                                        <telerik:RadButton ID="btnDecline" runat="server" Text="Decline" Enabled='<%# Eval("Status") = 0%>' OnClick="btnDecline_Click" Width="120px" CausesValidation="true" />
                                    </div>
                                </telerik:LayoutColumn>
                            </Columns>
                        </telerik:LayoutRow>
                        <telerik:LayoutRow>
                            <Columns>
                                <telerik:LayoutColumn Span="12">
                                    <telerik:RadScheduler ID="RadScheduler1" runat="server" Culture="en-US" OverflowBehavior="Auto" SelectedView="MonthView" RenderMode="Auto" 
                                        AllowDelete="false" AllowEdit="false" AllowInsert="false" 
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
                                        
                                        WorkDayEndTime="21:00:00"
                                        FirstDayOfWeek="Monday">
                                        <DayView UserSelectable="True" />
                                        <WeekView UserSelectable="True" />
                                        <TimelineView UserSelectable="False" />
                                        <MonthView UserSelectable="True" AdaptiveRowHeight="true" />
                                    </telerik:RadScheduler>
                                </telerik:LayoutColumn>
                            </Columns>
                        </telerik:LayoutRow>
                    </Rows>
                </telerik:RadPageLayout>
            </ItemTemplate>
        </telerik:RadDataForm>

    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Employee_NonJobTime_Request_SELECT" SelectCommandType="StoredProcedure" 
        UpdateCommand="Employee_DeclineRequestNonJobTime" UpdateCommandType="StoredProcedure" 
        InsertCommand="Employee_AcceptRequestNonJobTime" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblRequestId" Name="requestId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="NotesResponse" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblRequestId" Name="RequestId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblRequestId" Name="requestId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="NotesResponse" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceAppointments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Appointments_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="RangeStart" Type="DateTime" DefaultValue="1900/1/1"></asp:Parameter>
            <asp:Parameter Name="RangeEnd" Type="DateTime" DefaultValue="2900/1/1"></asp:Parameter>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:Parameter DefaultValue="-1" Name="employeeId" Type="Int32" />
            <asp:Parameter DefaultValue="-1" Name="ClientId" Type="Int32" />
            <asp:Parameter DefaultValue="-1" Name="jobId" Type="Int32" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblRequestId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False" ></asp:Label>
</asp:Content>

