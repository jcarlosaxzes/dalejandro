<%@ Page Title="Management Request" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="managementrequest.aspx.vb" Inherits="pasconcept20.managementrequest" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Time off request</span>
    </div>

    <div id="decorationZone">
        <telerik:RadDataForm runat="server" ID="RadDataForm1" DataKeyNames="Id" DataSourceID="SqlDataSource1">
            <ItemTemplate>
                <table class="table-sm" style="width: 100%">
                    <tr>
                        <td class="pasconcept-bar" style="width: 500px; vertical-align: top">
                            <table class="table-sm" style="width: 100%">
                                <tr>
                                    <td style="width: 25%; text-align: center"><b>Benfits</b></td>
                                    <td style="width: 25%; text-align: center"><b>Assined</b></td>
                                    <td style="width: 25%; text-align: center"><b>Used</b></td>
                                    <td style="width: 25%; text-align: center"><b>Balance</b></td>
                                </tr>
                                <tr>
                                    <td style="text-align: center">Vacations</td>
                                    <td style="text-align: center"><%# Eval("Benefits_vacations") %></td>
                                    <td style="text-align: center"><%# Eval("used_vacations") %></td>
                                    <td style="text-align: center"><%# Eval("Benefits_vacations") - Eval("used_vacations") %></td>
                                </tr>
                                <tr>
                                    <td style="text-align: center">Personal/Sick</td>
                                    <td style="text-align: center"><%# Eval("Benefits_personals") %></td>
                                    <td style="text-align: center"><%# Eval("used_personals") %></td>
                                    <td style="text-align: center"><%# Eval("Benefits_personals") - Eval("used_personals") %></td>
                                </tr>
                            </table>

                            <br />
                            <b>The following time off request has been submitted</b>
                            <table class="table-sm" style="width: 100%">
                                <tr>
                                    <td style="text-align: right; width: 180px">Employee:
                                    </td>
                                    <td>
                                        <%# Eval("EmployeeFullName") %>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Reason for Request:
                                    </td>
                                    <td>
                                        <%# Eval("TypeName") %>
                                    </td>
                                    <tr>
                                        <td style="text-align: right">Date of Request:
                                        </td>
                                        <td>
                                            <%# Eval("DateRequest", "{0:d}")%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right">Status:
                                        </td>
                                        <td>
                                            <%# Eval("StatusName") %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right">Days Requested:
                                        </td>
                                        <td>
                                            <%# Eval("nDays") %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right">Dates of absence, From:
                                        </td>
                                        <td>
                                            <%# Eval("DateFrom", "{0:d}") %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right">Dates of Absence, To:
                                        </td>
                                        <td>
                                            <%# Eval("DateTo", "{0:d}") %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right">Hours of Absence per Day:
                                        </td>
                                        <td>

                                            <%# Eval("Hours") %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right">Employee Notes:
                                        </td>
                                        <td>
                                            <%# Eval("Notes") %>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <b>Response Explanation:</b>
                                            <telerik:RadTextBox ID="txtExplanation" runat="server" Text='<%# Bind("NotesResponse")%>' ReadOnly='<%# Eval("Status") <> 0%>' Width="100%"></telerik:RadTextBox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <asp:LinkButton ID="btnSign" runat="server" Visible='<%# Eval("Status") = 0%>' CssClass="btn btn-primary btn-lg" UseSubmitBehavior="false" OnClick="btnAccept_Click" CausesValidation="true">
                                            Accept
                                            </asp:LinkButton>
                                            &nbsp;&nbsp;&nbsp;
                                            <asp:LinkButton ID="btnDecline" runat="server" Visible='<%# Eval("Status") = 0%>' CssClass="btn btn-danger btn-lg" UseSubmitBehavior="false" OnClick="btnDecline_Click" CausesValidation="true">
                                                            Decline
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtExplanation" Text="(*) Response Explanation can not be empty" SetFocusOnError="true" ForeColor="Red">
                                            </asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                            </table>
                        </td>
                        <td class="pasconcept-bar" style="vertical-align: top">
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
                                FirstDayOfWeek="Monday"
                                LastDayOfWeek="Friday"
                                OnAppointmentDataBound="RadScheduler1_AppointmentDataBound">
                                <DayView UserSelectable="True" />
                                <WeekView UserSelectable="True" />
                                <TimelineView UserSelectable="False" />
                                <MonthView UserSelectable="True" AdaptiveRowHeight="true" />
                            </telerik:RadScheduler>
                        </td>
                    </tr>
                </table>




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
        SelectCommand="Employees_NonRegularHours_Request_Calendar_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblRequestId" Name="RequestId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblRequestId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
