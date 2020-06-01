<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="ticket.aspx.vb" Inherits="pasconcept20.ticket" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSave">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnSave" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting></telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />

    <div class="Formulario">
        <table class="table-condensed" style="width: 100%">
            <tr>
                <td style="width: 120px">
                    <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="False">
                       Back to List
                    </asp:LinkButton>
                </td>
                <td style="text-align: center">
                    <h2 style="margin: 0">Ticket</h2>
                </td>

            </tr>
        </table>
    </div>


    <div>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="BulletList"
            HeaderText="Following error occurs:" ShowMessageBox="false" ShowSummary="true" CssClass="alert alert-danger alert-dismissable"
            ValidationGroup="Ticket" />

    </div>

    <div class="pas-container">
    <table class="table-condensed" style="width: 100%; text-align: left">
        <tr>
            <td style="width: 20%; text-align: right">Title:
            </td>
            <td colspan="3">
                <telerik:RadTextBox ID="txtTitle" runat="server" MaxLength="512" Width="100%" EmptyMessage="(*)required..." ToolTip="Title">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
        </tr>
        <tr>
            <td style="text-align: right">App. Name:
            </td>
            <td style="width: 30%">
                <telerik:RadDropDownList ID="cboAppNameEdit" runat="server" AppendDataBoundItems="true" Width="100%"
                    DataSourceID="SqlDataSourceTicketAppName" DataTextField="Name" DataValueField="Id">
                    <Items>
                        <telerik:DropDownListItem Text="(Select App Name...)" Selected="true" />
                    </Items>
                </telerik:RadDropDownList>
            </td>
            <td style="width: 20%; text-align: right">Location/Module:
            </td>
            <td>
                <telerik:RadDropDownList ID="cboLocationModuleEdit" runat="server" AppendDataBoundItems="true" Width="100%"
                    DataSourceID="SqlDataSourceTicketLocationModule" DataTextField="Name" DataValueField="Id">
                    <Items>
                        <telerik:DropDownListItem Text="(Select Location/Module...)" Selected="true" />
                    </Items>
                </telerik:RadDropDownList>
            </td>
        </tr>


        <tr>
            <td style="text-align: right">Client Description:
            </td>
            <td colspan="3">
                <telerik:RadTextBox ID="txtClientDescription" runat="server" Rows="2" TextMode="MultiLine" Width="100%" ToolTip="Client Description">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">Company Description:
            </td>
            <td>
                <telerik:RadTextBox ID="txtCompanyDescription" runat="server" Rows="2" TextMode="MultiLine" Width="100%" ToolTip="Company Description">
                </telerik:RadTextBox>
            </td>
            <td style="text-align: right">Client Feedback:
            </td>
            <td>
                <telerik:RadTextBox ID="txtNotes" runat="server" Rows="2" TextMode="MultiLine" Width="100%" ToolTip="Notes">
                </telerik:RadTextBox>
            </td>

        </tr>
        <tr>
            <td style="text-align: right">Type:
            </td>
            <td>
                <telerik:RadDropDownList ID="cboTypeEdit" runat="server" AppendDataBoundItems="true" Width="100%"
                    DataSourceID="SqlDataSourceTicketTypes" DataTextField="Name" DataValueField="Id">
                    <%--<Items>
                        <telerik:DropDownListItem Text="(Select Type...)" Selected="true" />
                    </Items>--%>
                </telerik:RadDropDownList>
            </td>
            <td style="text-align: right">Priority:
            </td>
            <td>
                <telerik:RadDropDownList ID="cboPriority" runat="server" AppendDataBoundItems="true" Width="100%">
                    <Items>
                        <telerik:DropDownListItem Text="Low" />
                        <telerik:DropDownListItem Text="Medium" />
                        <telerik:DropDownListItem Text="High" />
                    </Items>
                </telerik:RadDropDownList>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">Status:
            </td>
            <td>
                <telerik:RadDropDownList ID="cboStatusEdit" runat="server" AppendDataBoundItems="true" Width="100%" ZIndex="50001"
                    DataSourceID="SqlDataSourceTicketsStatus" DataTextField="Name">
                </telerik:RadDropDownList>
            </td>
            <td style="text-align: right">Tags:
            </td>
            <td>
                <telerik:RadTextBox ID="txtTags" runat="server" MaxLength="80" Width="100%" ToolTip="Tags" EmptyMessage="Tags for grouping tickets">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">Client Approved Status:
            </td>
            <td>
                <telerik:RadDropDownList ID="cboApprovedStatus" runat="server" AppendDataBoundItems="true" Width="100%">
                    <Items>
                        <telerik:DropDownListItem runat="server" Text="Pending" Selected="true" />
                        <telerik:DropDownListItem runat="server" Text="Approved" />
                        <telerik:DropDownListItem runat="server" Text="Rejected" />
                    </Items>
                </telerik:RadDropDownList>
            </td>
            <td style="text-align: right">Expected Start:
            </td>
            <td>
                <telerik:RadDatePicker ID="RadDatePickerExpectedStartDate" runat="server" DateFormat="MM/dd/yyyy" Width="150px" Culture="en-US">
                </telerik:RadDatePicker>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">Expected Staging:
            </td>
            <td>
                <telerik:RadDatePicker ID="RadDatePickerStagingDate" runat="server" Width="150px" Culture="en-US">
                </telerik:RadDatePicker>
            </td>
            <td style="text-align: right">Expected Production:
            </td>
            <td>
                <telerik:RadDatePicker ID="RadDatePickerProductionDate" runat="server" Width="150px" Culture="en-US">
                </telerik:RadDatePicker>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">Employee:
            </td>
            <td>
                <telerik:RadDropDownList ID="cboEmployee" runat="server" AppendDataBoundItems="true" Width="100%"
                    DataSourceID="SqlDataSourceEmployee" DataTextField="FullName" DataValueField="employeeId">
                    <Items>
                        <telerik:DropDownListItem Text="(Select Assined Employee...)" Selected="true" Value="0" />
                    </Items>
                </telerik:RadDropDownList>
            </td>
            <td style="text-align: right">Employee to be notified:
            </td>
            <td>
                <telerik:RadComboBox ID="cboNotificationBCCEmail" runat="server" DataSourceID="SqlDataSourceEmployee" DataTextField="Email" DataValueField="employeeId"
                    Width="100%" CheckBoxes="true" Height="250px" EnableCheckAllItemsCheckBox="true" MarkFirstMatch="True" Filter="Contains">
                    <Localization AllItemsCheckedString="All Emails Checked" CheckAllString="Check All..." ItemsCheckedString="emails checked"></Localization>
                </telerik:RadComboBox>

            </td>
        </tr>

        <tr>
            <td style="text-align: right">Business Client Name:
            </td>
            <td>
                <telerik:RadTextBox ID="txtNotificationClientName" runat="server" MaxLength="80" Width="100%" ToolTip="Notification Client Name">
                </telerik:RadTextBox>
            </td>
            <td style="text-align: right">Client Emails to be notified:
            </td>
            <td>
                <telerik:RadTextBox ID="txtNotificationClientEmail" runat="server" MaxLength="128" Width="100%" ToolTip="Notification Client Email">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">Trello URL:
            </td>
            <td>
                <telerik:RadTextBox ID="txttrelloURL" runat="server" MaxLength="128" Width="100%" ToolTip="Link to Trello Card">
                </telerik:RadTextBox>
            </td>
            <td style="text-align: right">Jira URL:
            </td>
            <td>
                <telerik:RadTextBox ID="txtJiraURL" runat="server" MaxLength="128" Width="100%" ToolTip="Link to Jira Card">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
        </tr>

    </table>
    <table class="table-condensed" style="width: 100%;">
        <tr>
            <td style="width: 20%"></td>
            <td style="width: 30%">
                <telerik:RadCheckBox ID="chkNotifyClient" runat="server" ToolTip="Notifiy changes to client when Save?" Text="&nbsp;Notify client on Save?" />
            </td>
            <td style="width: 20%; text-align: right">Estimated Hours:</td>
            <td>
                <telerik:RadTextBox ID="txtEstimatedHours" runat="server" Width="150px" ToolTip="Estimated Hours for Complete Ticket">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <telerik:RadCheckBox ID="chkIsBillable" runat="server" ToolTip="Is Billable?" Text="&nbsp;Is Billable?" />
            </td>
            <td></td>
            <td>

                <telerik:RadCheckBox ID="chkNotifyEmployee" runat="server" ToolTip="Notifiy changes to employee when Save?" Text="&nbsp;Notify employee(s) on Save?" />
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <telerik:RadCheckBox ID="chkIsPrivate" runat="server" ToolTip="Is Private?" Text="&nbsp;Is Private?" />
            </td>
            <td></td>
            <td style="text-align: center;">
                <asp:LinkButton runat="server" ID="btnSave" CssClass="btn btn-success btn-lg" ToolTip="Save Ticket" ValidationGroup="Ticket">
                            <span class="glyphicon glyphicon-save"> Update</span>
                </asp:LinkButton>
            </td>
        </tr>
    </table>
    </div>
    <div>
        <asp:CompareValidator runat="server" ID="Comparevalidator3" ForeColor="Red" Operator="NotEqual" SetFocusOnError="true" ValidationGroup="Ticket"
            ControlToValidate="cboLocationModuleEdit"
            ValueToCompare="(Select Location/Module...)"
            ErrorMessage="<span class='val-msg'><b>Location/Module</b> is required</span>">
        </asp:CompareValidator>
        <asp:CompareValidator runat="server" ID="Comparevalidator2" ForeColor="Red" Operator="NotEqual" SetFocusOnError="true" ValidationGroup="Ticket"
            ControlToValidate="cboAppNameEdit"
            ValueToCompare="(Select App Name...)"
            ErrorMessage="<span class='val-msg'><b>App Name</b> is required</span>">
        </asp:CompareValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" runat="server" ValidationGroup="Ticket" SetFocusOnError="true"
            ControlToValidate="txtTitle"
            ErrorMessage="<span class='val-msg'><b>Location/Title</b> is required</span>">
        </asp:RequiredFieldValidator>
        <asp:CompareValidator runat="server" ID="Comparevalidator1" ForeColor="Red" Operator="NotEqual" SetFocusOnError="true" ValidationGroup="Ticket"
            ControlToValidate="cboTypeEdit"
            ValueToCompare="(Select Type...)"
            ErrorMessage="<span class='val-msg'><b>Type</b> is required</span>">
        </asp:CompareValidator>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        InsertCommand="Jobs_ticket_INSERT" InsertCommandType="StoredProcedure"
        UpdateCommand="Jobs_ticket_UPDATE" UpdateCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="JobId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="RadDatePickerExpectedStartDate" Name="ExpectedStartDate" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboLocationModuleEdit" Name="LocationModule" PropertyName="SelectedText" Type="String" />
            <asp:ControlParameter ControlID="cboAppNameEdit" Name="AppName" PropertyName="SelectedText" Type="String" />
            <asp:ControlParameter ControlID="txtTitle" Name="Title" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtTags" Name="Tags" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtClientDescription" Name="ClientDescription" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtCompanyDescription" Name="CompanyDescription" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtNotes" Name="Notes" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboTypeEdit" Name="Type" PropertyName="SelectedText" Type="String" />
            <asp:ControlParameter ControlID="cboPriority" Name="Priority" PropertyName="SelectedText" Type="String" />
            <asp:ControlParameter ControlID="cboStatusEdit" Name="Status" PropertyName="SelectedText" Type="String" />
            <asp:ControlParameter ControlID="cboApprovedStatus" Name="ApprovedStatus" PropertyName="SelectedText" Type="String" />
            <asp:ControlParameter ControlID="RadDatePickerStagingDate" Name="StagingDate" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="RadDatePickerProductionDate" Name="ProductionDate" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboEmployee" Name="employeeId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtNotificationClientName" Name="NotificationClientName" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtNotificationClientEmail" Name="NotificationClientEmail" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboNotificationBCCEmail" Name="NotificationBCClientEmail" PropertyName="Text" />
            <asp:ControlParameter ControlID="txttrelloURL" Name="trelloURL" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtJiraURL" Name="jiraURL" PropertyName="Text" />

            <asp:ControlParameter ControlID="chkIsBillable" Name="Billable" PropertyName="Checked" />
            <asp:ControlParameter ControlID="chkIsPrivate" Name="IsPrivate" PropertyName="Checked" />

            <asp:ControlParameter ControlID="txtEstimatedHours" Name="EstimatedHours" PropertyName="Text" />

        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="RadDatePickerExpectedStartDate" Name="ExpectedStartDate" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboLocationModuleEdit" Name="LocationModule" PropertyName="SelectedText" Type="String" />
            <asp:ControlParameter ControlID="cboAppNameEdit" Name="AppName" PropertyName="SelectedText" Type="String" />
            <asp:ControlParameter ControlID="txtTitle" Name="Title" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtTags" Name="Tags" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtClientDescription" Name="ClientDescription" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtCompanyDescription" Name="CompanyDescription" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtNotes" Name="Notes" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboTypeEdit" Name="Type" PropertyName="SelectedText" Type="String" />
            <asp:ControlParameter ControlID="cboPriority" Name="Priority" PropertyName="SelectedText" Type="String" />
            <asp:ControlParameter ControlID="cboStatusEdit" Name="Status" PropertyName="SelectedText" Type="String" />
            <asp:ControlParameter ControlID="cboApprovedStatus" Name="ApprovedStatus" PropertyName="SelectedText" Type="String" />
            <asp:ControlParameter ControlID="RadDatePickerStagingDate" Name="StagingDate" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="RadDatePickerProductionDate" Name="ProductionDate" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboEmployee" Name="employeeId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtNotificationClientName" Name="NotificationClientName" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtNotificationClientEmail" Name="NotificationClientEmail" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboNotificationBCCEmail" Name="NotificationBCClientEmail" PropertyName="Text" />
            <asp:ControlParameter ControlID="txttrelloURL" Name="trelloURL" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtJiraURL" Name="jiraURL" PropertyName="Text" />

            <asp:ControlParameter ControlID="chkIsBillable" Name="Billable" PropertyName="Checked" />
            <asp:ControlParameter ControlID="chkIsPrivate" Name="IsPrivate" PropertyName="Checked" />

            <asp:ControlParameter ControlID="txtEstimatedHours" Name="EstimatedHours" PropertyName="Text" />

            <asp:ControlParameter ControlID="lblTicketId" Name="Id" PropertyName="Text" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSourceTicketTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [jobs_ticket_Types] WHERE companyId=@companyId ORDER BY [Id]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceTicketAppName" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Jobs_ticket_AppName] WHERE jobId=@jobId ORDER BY [Id]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTicketLocationModule" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Jobs_ticket_LocationModule] WHERE jobId=@jobId ORDER BY [Id]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="select employeeId, Employees.FullName, jobId, Employees.Email from Jobs_Employees_assigned inner join Employees on Jobs_Employees_assigned.employeeId=Employees.Id WHERE jobId=@jobId">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTicketsStatus" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name], [EmployeeFilterChecked] FROM [Jobs_tickets_Status] ORDER BY [Id]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Text="0" Visible="False"></asp:Label>
    <asp:Label ID="lblJobId" runat="server" Text="0" Visible="False"></asp:Label>
    <asp:Label ID="lblNotificationBCClientEmail" runat="server" Text="" Visible="False"></asp:Label>
    <asp:Label ID="lblTicketId" runat="server" Visible="False"></asp:Label>
</asp:Content>

