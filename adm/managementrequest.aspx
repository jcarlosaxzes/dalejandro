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
                        <td style="width: 50%;vertical-align:top">
                            <h4 style="border: none">The following time off request has been submitted</h4>
                            <h4 style="border: none">for the employee&nbsp;<b><%# Eval("EmployeeFullName") %></b></h4>
                            <h4 style="border: none">Reason for request:&nbsp;<b><%# Eval("TypeName") %></b></h4>
                            <h4 style="border: none">Date Request:&nbsp;<%# Eval("DateRequest", "{0:d}")%>&nbsp;&nbsp;&nbsp;Status:&nbsp;<b><%# Eval("StatusName") %></b></h4>
                            <h4 style="border: none"><%# IIf(Eval("DateFrom") = Eval("DateTo"), "", String.Concat("Number of days requested:&nbsp;<b>", Eval("nDays"), "</b>"))%></h4>
                            <h5 style="border: none">Dates of absence, From &nbsp;<b><%# Eval("DateFrom", "{0:d}") %></b>&nbsp;to&nbsp; <b><%# Eval("DateTo", "{0:d}") %></b></h5>
                            <h5 style="border: none">Hours of absence, each day:&nbsp;<%# Eval("Hours") %></h5>
                            <h5 style="border: none">Employee Explanation:&nbsp;<%# Eval("Notes") %></h5>
                        </td>
                        <td style="vertical-align:top">
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
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <h3>Response Explanation:&nbsp;</h3>
                                    <telerik:RadTextBox ID="txtExplanation" runat="server" Text='<%# Bind("NotesResponse")%>' Enabled='<%# Eval("Status") = 0%>' Width="100%"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align:center">
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
                    <tr>
                        <td colspan="2">
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
                                        LastDayOfWeek="Sunday">
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
        SelectCommand="AppointmentsForRequest_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblRequestId" Name="AppoitmentId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblRequestId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
