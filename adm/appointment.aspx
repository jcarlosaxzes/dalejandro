<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="appointment.aspx.vb" Inherits="pasconcept20.appointment" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadScheduler1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipSend"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

      <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
    </telerik:RadAjaxLoadingPanel>

    <div class="pasconcept-bar">
        <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
            Back
        </asp:LinkButton>
        <span style="float: right; vertical-align: middle;">
                <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Save Appointment">
                        Save Event
                </asp:LinkButton>
            </span>

    </div>
    <div class="pasconcept-bar">
        <h4>Appointment</h4>
        <div>
            <asp:Label runat="server" ID="lblError" ForeColor="Red" Text=""></asp:Label>
        </div>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceAppointments" Width="100%" DefaultMode="Edit" OnDataBound="FormView1_DataBound">
            <EditItemTemplate>
            <table class="table-sm" style="width: 90%">
                <tr>
                    <td style="width: 200px; text-align: right">Subject:
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtSubject" runat="server" Text='<%# Bind("Subject") %>' Width="60%" MaxLength="80">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 200px; text-align: right">Start Date: 
                    </td>
                    <td>
                        <telerik:RadDateTimePicker ID="dtpStart" runat="server" DbSelectedDate='<%# Bind("Start") %>' Width="250px">
                        </telerik:RadDateTimePicker>
                    </td>
                </tr>
                <tr>
                    <td style="width: 200px; text-align: right">End Date: 
                    </td>
                    <td>
                        <telerik:RadDateTimePicker ID="dtpEnd" runat="server" DbSelectedDate='<%# Bind("End") %>'  Width="250px">
                        </telerik:RadDateTimePicker>
                    </td>
                </tr>
                <tr>
                    <td style="width: 200px; text-align: right">All Day: 
                    </td>
                    <td>
                        <telerik:RadCheckBox runat="server" ID="chAllDay"  TextAlign="Left" Text=""  Checked='<%# Bind("AllDay") %>'  />
                    </td>
                </tr>
                <tr>
                    <td style="width: 200px; text-align: right">Activity Type:
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboActivity" runat="server" DataSourceID="SqlDataSourceType" ZIndex="50001"
                            DataTextField="Name" DataValueField="Id" Width="60%" MarkFirstMatch="True" Filter="Contains" Height="300px"
                            AppendDataBoundItems="true" SelectedValue='<%# Bind("ActivityId") %>' >
                            <Items>
                                <telerik:RadComboBoxItem Text="(Select Activity Type...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 200px; text-align: right">Assign to User:
                    </td>
                    <td style="height: 45px; vertical-align: top">
                        <telerik:RadComboBox ID="cboEmployees" runat="server" DataSourceID="SqlDataSourceEmployees" ZIndex="50001"
                            DataTextField="Name" DataValueField="Id" Width="60%" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="true"  SelectedValue='<%# Bind("EmployeeId") %>'>
                            <Items>
                                <telerik:RadComboBoxItem Text="(Select User...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 200px; text-align: right">Client:
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboClient" runat="server" DataSourceID="SqlDataSourceClients" ZIndex="50001"
                            DataTextField="Name" DataValueField="Id" Width="60%" MarkFirstMatch="True" Filter="Contains" Height="300px" 
                            AppendDataBoundItems="true"  SelectedValue='<%# Bind("ClientId") %>'>
                            <Items>
                                <telerik:RadComboBoxItem Text="(Select Clients...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 200px; text-align: right">Job:
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboJob" runat="server" DataSourceID="SqlDataSourceJob" DropDownAutoWidth="Enabled"
                            DataTextField="JobName" DataValueField="Id" Width="60%" MarkFirstMatch="True" Filter="Contains"  AppendDataBoundItems="true"  
                            Height="300px"  SelectedValue='<%# Bind("JobId") %>' >
                            <Items>
                                <telerik:RadComboBoxItem Text="(Select Jobs...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 200px; text-align: right">Description:
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtDescription" runat="server"
                            TextMode="MultiLine" Rows="6" MaxLength="1024" Width="60%" Text='<%# Bind("Description") %>'>
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 200px; text-align: right">Location:
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtLocation" runat="server" Width="60%" MaxLength="80"  Text='<%# Bind("Location") %>'>
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 200px; text-align: right">Recurrence:
                    </td>
                    <td>
                        Repeat every 
                        <telerik:RadNumericTextBox ID="txtRecurrenceFrecuency" runat="server" Width="100px" MaxLength="80"  
                            NumberFormat-DecimalDigits="0" MinValue="0" MaxValue="100"  Text='<%# Bind("RecurrenceFrequency") %>' >
                            
                        </telerik:RadNumericTextBox>
                        <telerik:RadComboBox ID="cboRecurrenceInterval" runat="server" 
                             Width="100px"  AppendDataBoundItems="true"  Height="300px"   SelectedValue='<%# Bind("RecurrenceInterval") %>' >
                            <Items>
                                <telerik:RadComboBoxItem Value="0" Text="Days"/>
                                <telerik:RadComboBoxItem Value="1" Text="Weeks"/>
                                <telerik:RadComboBoxItem Value="2" Text="Months"/>
                                <telerik:RadComboBoxItem Value="3" Text="Quarters"/>
                                <telerik:RadComboBoxItem Value="4" Text="Years"/>
                            </Items>
                        </telerik:RadComboBox>
                        &nbsp;&nbsp;Until:
                        <telerik:RadDatePicker ID="dtpUntil" runat="server" DbSelectedDate='<%# Bind("RecurrenceUntil") %>' MinDate='<%# DateTime.Now %>'  MaxDate='<%# DateTime.Parse("2029-12-31") %>'>
                        </telerik:RadDatePicker>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 200px; text-align: right">Notify Employees:
                    </td>
                    <td>
                        <telerik:RadCheckBox runat="server" ID="chNotify"  TextAlign="Left" Text="" Checked='<%# Bind("NotifyEmployee") %>' />
                    </td>
                </tr>

            </table>                
            <asp:Label ID="lblNotifyTo" runat="server" Visible="False"></asp:Label>
            </EditItemTemplate>
        </asp:FormView>
    </div>

    
    <telerik:RadToolTip ID="RadToolTipSend" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; color: white; width: 650px">
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


    <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [FullName] as Name FROM [Employees] WHERE companyId=@companyId and isnull(Inactive,0)=0 ORDER BY [Name]">
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
    <asp:SqlDataSource ID="SqlDataSourceJob" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOBS_Active_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceAppointments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="Appointment_DELETE" DeleteCommandType="StoredProcedure"
        InsertCommand="Appointment_INSERT" InsertCommandType="StoredProcedure"
        UpdateCommand="Appointment_v20_UPDATE" UpdateCommandType="StoredProcedure"
        SelectCommand="Appointment_v20_SELECT" SelectCommandType="StoredProcedure" OnUpdated="SqlDataSourceAppointments_Updated" OnSelecting="SqlDataSourceAppointments_Selecting" OnSelected="SqlDataSourceAppointments_Selected">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Subject" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Start" Type="DateTime" />            
            <asp:ControlParameter ControlID="dtpSendDate" Name="SendDate" PropertyName="SelectedDate" Type="DateTime" />
            <asp:Parameter Name="End" Type="DateTime" />
            <asp:Parameter Name="RecurrenceRule" Type="String" DefaultValue=""/>
            <asp:Parameter Name="RecurrenceParentID" Type="Int32" DefaultValue="" />
            <asp:Parameter Name="Reminder" Type="String" DefaultValue=""/>
            <asp:Parameter Name="Annotations" DefaultValue=""/>
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
            <asp:ControlParameter ControlID="lblAppointmentid" Name="Id" PropertyName="Text"></asp:ControlParameter>
            <asp:ControlParameter ControlID="uStart" Name="start" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="uEnd" Name="end" PropertyName="SelectedDate" Type="DateTime" />
            <%--<asp:ControlParameter ControlID="lblStartDate" Name="start" PropertyName="Text" Type="String"></asp:ControlParameter>
            <asp:ControlParameter ControlID="lblEndDate" Name="end" PropertyName="Text" Type="DateTime"></asp:ControlParameter>--%>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ReturnId" Type="Int32" Direction="Output" />
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
            <asp:Parameter Name="RecurrenceFrequency" Type="Int32" />            
            <asp:Parameter Name="RecurrenceInterval" Type="Int32" />
            <asp:Parameter Name="RecurrenceUntil" Type="DateTime" />            
            <asp:Parameter Name="NotifyEmployee" Type="Boolean" />
            <asp:Parameter Name="AllDay" Type="Boolean" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceProposalTask" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="ProposalTaskAppoitment_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblSelectedJob" Name="JobId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployee" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblStartDate" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEndDate" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblAppointmentid" runat="server" Visible="False"></asp:Label>
    <telerik:RadDateTimePicker  ID="uStart" runat="server" Visible="false">  </telerik:RadDateTimePicker>
    <telerik:RadDateTimePicker  ID="uEnd" runat="server" Visible="false">  </telerik:RadDateTimePicker>    
    <asp:Label ID="lblEntityType" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEntityId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedJob" runat="server" Visible="False"></asp:Label>
</asp:Content>
