<%@ Page Title="Non-Productive Time" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="employeenewdowntime.aspx.vb" Inherits="pasconcept20.employeenewdowntime" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src='<%= ResolveUrl("~/Scripts/date_range_picker/jquery.pickmeup.js") %>'></script>
    <link rel="stylesheet" type="text/css" href='<%= ResolveUrl("~/Scripts/date_range_picker/pickmeup.css") %>' />


    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">

            <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
                       Back
            </asp:LinkButton>
            Non-Productive Time (<asp:Label ID="lblEmployeeName" runat="server"></asp:Label>)
        </span>
    </div>
    <table class="table-sm" style="width: 100%">
        <tr>
            <td class="pasconcept-bar" style="width: 700px; vertical-align: top">
                <div>
                    <table style="width: 100%; border: 1px solid #aeaeaf;">
                        <tr>
                            <td style="width: 25%; padding-left: 10px"><b>Benefits</b></td>
                            <td style="width: 25%; text-align: center"><b>Assigned</b></td>
                            <td style="width: 25%; text-align: center"><b>Used</b></td>
                            <td style="width: 25%; text-align: center"><b>Balance</b></td>
                        </tr>
                        <tr>
                            <td style="padding-left: 10px">Vacations</td>
                            <td style="text-align: center">
                                <asp:Label ID="lblVac1" runat="server" Text="0"></asp:Label></td>
                            <td style="text-align: center">
                                <asp:Label ID="lblVac2" runat="server" Text="0"></asp:Label></td>
                            <td style="text-align: center">
                                <asp:Label ID="lblVac3" runat="server" Text="0"></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="padding-left: 10px">Personal/Sick</td>
                            <td style="text-align: center">
                                <asp:Label ID="lblPer1" runat="server" Text="0"></asp:Label></td>
                            <td style="text-align: center">
                                <asp:Label ID="lblPer2" runat="server" Text="0"></asp:Label></td>
                            <td style="text-align: center">
                                <asp:Label ID="lblPer3" runat="server" Text="0"></asp:Label></td>

                        </tr>
                    </table>
                </div>
                <br />
                <div>
                    <table class="table-sm" style="width: 100%">
                        <tr>
                            <td style="width: 100px; text-align: right">Category:
                            </td>
                            <td style="width: 200px; text-align: right">
                                <telerik:RadComboBox ID="cboType" runat="server"  AppendDataBoundItems="True" DataSourceID="SqlDataSourceMiscellaneousType" DataTextField="Name" ZIndex="50001"
                                    DataValueField="Id" Width="100%" MarkFirstMatch="True" Filter="Contains" Height="300px" AutoPostBack="true">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Selected="False" Text="Select Category..." Value="-1" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td style="width: 100px; text-align: right">Time (hrs):
                            </td>
                            <td>
                                <telerik:RadNumericTextBox ID="txtMiscellaneousHours" runat="server"
                                    MinValue="0.25" ShowSpinButtons="True" ButtonsPosition="Right" ToolTip="Time in hours for each day"
                                    Value="1" Width="150px" MaxValue="24">
                                    <NumberFormat DecimalDigits="2" />
                                    <IncrementSettings Step="1" />
                                </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">
                                <asp:Label ID="txtDateFrom" Text="Date:" runat="server"/>  
                            </td>
                            <td>
                                <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server"
                                    DateFormat="MM/dd/yyyy"
                                    Culture="en-US"
                                    ZIndex="50001"
                                    Width="150px">
                                    <ClientEvents OnDateSelected="RadDatePickerChange" />
                                </telerik:RadDatePicker>
                            </td>
                            <td style="text-align: right">
                                <asp:Label ID="txtDateTo" Visible="false" Text="Date To:" runat="server"/>  
                            </td>
                            <td>
                                <telerik:RadDatePicker ID="RadDatePickerTo" runat="server"
                                    DateFormat="MM/dd/yyyy"
                                    Culture="en-US"
                                    ZIndex="50001"
                                    Width="150px" Visible="false">
                                    <ClientEvents OnDateSelected="RadDatePickerChange" />
                                </telerik:RadDatePicker>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" style="text-align:center;">
                                <asp:Panel ID="PanelDateRagePicker" runat="server" Visible="false">                                    
                                    <div id="DateRangeDiv" class="DateRangeDiv"></div>
                                </asp:Panel>
                            </td>
                        </tr>

                        <tr>
                            <td style="text-align: right" >Notes:
                            </td>
                            <td colspan="2">
                                <telerik:RadTextBox ID="txtNotes" runat="server" TextMode="MultiLine" Rows="1" Width="100%"
                                    MaxLength="256">
                                </telerik:RadTextBox>
                            </td>
                            <td colspan="1">
                                <asp:LinkButton ID="btnOkNewMiscellaneousTime" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" ValidationGroup="AddNonRecord"  CausesValidation="true">
                            Add Time
                                </asp:LinkButton>
                            </td>
                        </tr>

                        <tr>
                             <td colspan="4" style="text-align:center;">
                                <asp:Label ID="lblNotes" runat="server" Visible="false" Text="Selected date range will automatically exclude Holidays and Weekends." CssClass="badge badge-pill badge-warning"></asp:Label>
                                 <br />
                                 <asp:Label ID="lblAprovedNote" runat="server" Visible="false" Text="This Request need to be Approved by company managers " CssClass="badge badge-pill badge-warning"></asp:Label>
                           <br />
                                  <asp:Label id="dateValidator" ForeColor="Red" Text="Date From must be earlier or equal than end Date To" Visible="false" runat="server"></asp:Label>
                                 
                             </td> 
                        </tr>
                        

                    </table>
                    <div>
                        <asp:ValidationSummary ID="vsClient" runat="server" ValidationGroup="AddNonRecord" ForeColor="Red"
                            HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were this errors:"></asp:ValidationSummary>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtNotes" ErrorMessage="* Notes is required" ForeColor="Red"
                             ValidationGroup="AddNonRecord" Display="None">
                        </asp:RequiredFieldValidator>

                        <asp:CompareValidator runat="server" ID="Comparevalidator1" ValueToCompare="Select Category..."
                        Operator="NotEqual" ControlToValidate="cboType" ErrorMessage="You must select Category!" ValidationGroup="AddNonRecord" Display="None">
                       

                    </asp:CompareValidator>
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
                    <DayView UserSelectable="false" />
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
        <h4>Non-Productive Time Entry Log (Last Records)</h4>
        <telerik:RadGrid ID="RadGridLog" runat="server" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
            AutoGenerateColumns="False" DataSourceID="SqlDataSourceLog" PageSize="50" AllowPaging="true"
            Height="850px" RenderMode="Lightweight"
            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
            <ClientSettings Selecting-AllowRowSelect="true">
                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
            </ClientSettings>
            <PagerStyle Mode="Slider" AlwaysVisible="false" />
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceLog">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                        HeaderText="" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                    </telerik:GridEditCommandColumn>
                    <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column" HeaderText="Category" HeaderStyle-Width="300px"
                        SortExpression="Name" UniqueName="Name">
                        <EditItemTemplate>
                            <div style="margin: 5px">
                                <telerik:RadComboBox ID="cboType" runat="server" DataSourceID="SqlDataSourceMiscellaneousType" DataTextField="Name" Width="100%"
                                    DataValueField="Id" AppendDataBoundItems="True" Height="300px" SelectedValue='<%# Bind("Type") %>'>
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(Select Category...)" Value="0"></telerik:RadComboBoxItem>
                                    </Items>
                                </telerik:RadComboBox>
                            </div>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <%# Eval("Name") %>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="DateFrom" DataType="System.DateTime" HeaderText="From"
                        SortExpression="DateFrom" UniqueName="DateFrom" DataFormatString="{0:d}" HeaderStyle-Width="130px"
                        ItemStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DateTo" DataType="System.DateTime" HeaderText="To" SortExpression="DateTo" UniqueName="DateTo" DataFormatString="{0:d}" HeaderStyle-Width="130px"
                        ItemStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Hours" HeaderText="Time" SortExpression="Hours" UniqueName="Hours" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Notes" HeaderText="Notes" SortExpression="Notes"
                        UniqueName="Notes" ItemStyle-HorizontalAlign="Left">
                    </telerik:GridBoundColumn>
                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                        CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText="" HeaderStyle-Width="50px"
                        ItemStyle-HorizontalAlign="Center">
                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center" />
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings>
                    <EditColumn ButtonType="PushButton" UniqueName="EditCommandColumn1">
                    </EditColumn>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="SqlDataSourceMiscellaneousType" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="MiscellaneousType_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceLog" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM Employees_NonRegularHours WHERE (Id = @Id)"
        SelectCommand="Employees_NonProductiveTimeLog_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="Employees_NonRegularHours_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblEmployeeId" Name="EmployeeId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="DateFrom" />
            <asp:Parameter Name="DateTo" />
            <asp:Parameter Name="Hours" />
            <asp:Parameter Name="Type" />
            <asp:Parameter Name="Notes" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceEmployeeDailyTimeWorked" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="EmployeeDailyTimeWorked_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="DateEntry" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="EmployeeId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblLogedEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    
     <script>

         $(function () {

             $('.DateRangeDiv').pickmeup({
                 flat: true,
                 mode: 'range',
                 calendars: 2,
                 format: 'Y-m-d',
                 change: function (formatted_date) {
                     //Update Coponents
                     var RadDatePickerFrom = $find("<%= RadDatePickerFrom.ClientID %>");
                     RadDatePickerFrom.set_selectedDate(new Date(formatted_date[0])); 

                     var RadDatePickerTo = $find("<%= RadDatePickerTo.ClientID %>");
                     RadDatePickerTo.set_selectedDate(new Date(formatted_date[1]));

                     return true;

                 }
             });

         });

         function updateRange() {
             var RadDatePickerFrom = $find("<%= RadDatePickerFrom.ClientID %>");
             var RadDatePickerTo = $find("<%= RadDatePickerTo.ClientID %>");
             var dateFrom = RadDatePickerFrom.get_selectedDate();
             var dateTo = RadDatePickerTo.get_selectedDate();
             if (dateFrom) {
                 if (dateTo) {
                     if (dateFrom <= dateTo) {
                         $('.DateRangeDiv').pickmeup('set_date', [dateFrom, dateTo], true);
                         return;
                     }
                     $('.DateRangeDiv').pickmeup('set_date', [dateFrom, dateFrom], true);
                 }
             }   
         }


         function RadDatePickerChange(obj, e) {
             updateRange();
         }
     </script>
</asp:Content>
