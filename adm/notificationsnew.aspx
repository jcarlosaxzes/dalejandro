<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="notificationsnew.aspx.vb" Inherits="pasconcept20.notificationsnew" %>
<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pasconcept-bar">
        <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-dark" UseSubmitBehavior="false" CausesValidation="False">
            Back
        </asp:LinkButton>
        <span style="float: right; vertical-align: middle;">
                <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Save Appointment">
                        Create Notifications
                </asp:LinkButton>
            </span>

    </div>

    <div class="pasconcept-bar">
        <h4>Notifications</h4>
        <span>All notifications are sent between 6am-9am, Monday-Friday</span>
            <table class="table-sm" style="width: 90%">
                <tr>
                    <td style="width: 200px; text-align: right">Subject:
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtSubject" runat="server" Text='' Width="60%" MaxLength="80">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 200px; text-align: right">Description:
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtDescription" runat="server"
                            TextMode="MultiLine" Rows="6" MaxLength="1024" Width="60%" Text=''>
                        </telerik:RadTextBox>
                    </td>
                </tr>

                <tr>
                    <td style="width: 200px; text-align: right">Send Date: 
                    </td>
                    <td>
                        <telerik:RadDatePicker ID="dtpSendDate" runat="server" MinDate='<%# DateTime.Now.AddDays(1) %>'  MaxDate='<%# DateTime.Parse("2029-12-31") %>'>
                        </telerik:RadDatePicker>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 200px; text-align: right">Notify Users:
                    </td>
                    <td style="height: 45px; vertical-align: top">
                        <telerik:RadComboBox ID="cboNotify" runat="server" DataSourceID="SqlDataSourceEmployees" ZIndex="50001"
                            DataTextField="Name" DataValueField="Id" Width="60%" MarkFirstMatch="True" Filter="Contains" Height="300px" 
                            CheckBoxes="true" AppendDataBoundItems="true">
                        </telerik:RadComboBox>
                    </td>
                </tr>

            </table>                
            <asp:Label ID="lblNotifyTo" runat="server" Visible="False"></asp:Label>            
    </div>

    <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [FullName] as Name FROM [Employees] WHERE companyId=@companyId and isnull(Inactive,0)=0 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

 


    <asp:SqlDataSource ID="SqlDataSourceNotifications" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="Appointment_DELETE" DeleteCommandType="StoredProcedure"
        UpdateCommand="Notifications_UPDATE" UpdateCommandType="StoredProcedure"
        SelectCommand="Notifiations_SELECT" SelectCommandType="StoredProcedure" 
        InsertCommand="Notifications_INSERT" InsertCommandType="StoredProcedure"
        OnInserted="SqlDataSourceNotifications_Inserted" OnUpdated="SqlDataSourceNotifications_Updated">
        <InsertParameters>
            <asp:ControlParameter ControlID="txtSubject" Name="Subject" PropertyName="Text"></asp:ControlParameter>
            <asp:ControlParameter ControlID="txtDescription" Name="Body" PropertyName="Text"></asp:ControlParameter>
            <asp:ControlParameter ControlID="dtpSendDate" Name="SendDate" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="lblEntityType" Name="EntityType" PropertyName="Text"></asp:ControlParameter>
            <asp:ControlParameter ControlID="lblEntityId" Name="EntityId" PropertyName="Text"></asp:ControlParameter>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblEmployeesId" Name="EmployeesId" PropertyName="Text"></asp:ControlParameter>
            <asp:ControlParameter ControlID="lblTargetEmails" Name="TargetEmails" PropertyName="Text"></asp:ControlParameter>
        </InsertParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </DeleteParameters>
        
        <SelectParameters>
            <asp:ControlParameter ControlID="lblNotificationsId" Name="Id" PropertyName="Text"></asp:ControlParameter>
            <asp:ControlParameter ControlID="lblEntityType" Name="EntityType" PropertyName="Text"></asp:ControlParameter>
            <asp:ControlParameter ControlID="lblEntityId" Name="EntityId" PropertyName="Text"></asp:ControlParameter>
            <asp:ControlParameter ControlID="dtpSendDate" Name="SendDate" PropertyName="SelectedDate" Type="DateTime" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="lblNotificationsId" Name="Id" PropertyName="Text"></asp:ControlParameter>
            <asp:ControlParameter ControlID="txtSubject" Name="Subject" PropertyName="Text"></asp:ControlParameter>
            <asp:ControlParameter ControlID="txtDescription" Name="Body" PropertyName="Text"></asp:ControlParameter>
            <asp:ControlParameter ControlID="dtpSendDate" Name="SendDate" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="lblEmployeesId" Name="EmployeesId" PropertyName="Text"></asp:ControlParameter>
            <asp:ControlParameter ControlID="lblTargetEmails" Name="TargetEmails" PropertyName="Text"></asp:ControlParameter>
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblNotificationsId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEntityType" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEntityId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeesId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblTargetEmails" runat="server" Visible="False"></asp:Label>
</asp:Content>
