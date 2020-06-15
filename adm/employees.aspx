<%@ Page Title="Employees" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="employees.aspx.vb" Inherits="pasconcept20.employees" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/adm/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipDelete" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnNew">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnConfirmDelete">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />

    <style>
        .photo {
            box-shadow: inset 0 0 30px rgba(0,0,0,.3);
            margin: 0 10px 0 0;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background-size: 100%;
            background-repeat: no-repeat;
            display: inline-block;
        }
    </style>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Silk">
    </telerik:RadWindowManager>

    <telerik:RadWizard ID="RadWizard1" runat="server" DisplayCancelButton="false" RenderMode="Lightweight" Skin="Silk" DisplayNavigationButtons="false" DisplayProgressBar="false">
        <WizardSteps>
            <telerik:RadWizardStep runat="server" ID="RadWizardStep1" Title="Employees" StepType="Step">
                <table class="table-sm" style="width: 100%">
                    <tr>
                        <td class="PanelFilter">
                            <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
                                <table width="100%" class="Formulario">
                                    <tr>
                                        <td align="right" width="100px">Status:</td>
                                        <td style="width: 200px">
                                            <telerik:RadComboBox ID="cboStatus" runat="server" Width="100%" AppendDataBoundItems="true">
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text="(Active Employees...)" Value="0" Selected="true" />
                                                    <telerik:RadComboBoxItem runat="server" Text="(Inactive Employees...)" Value="1" />
                                                    <telerik:RadComboBoxItem runat="server" Text="(All Employees...)" Value="-1" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </td>
                                        <td style="width: 400px">
                                            <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" Width="100%">
                                            </telerik:RadTextBox>
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                                <i class="fas fa-search"></i> Search
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td class="ToolButtom noprint">
                            <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                            <i class="fas fa-plus"></i>&nbsp;Employee
                            </asp:LinkButton>

                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <script type="text/javascript">
                                function PrintPage(sender, args) {
                                    window.print();
                                }
                            </script>
                            <telerik:RadButton ID="printbutton" OnClientClicked="PrintPage" Text="Print Page" runat="server" AutoPostBack="false" UseSubmitBehavior="false">
                                <Icon PrimaryIconCssClass=" rbPrint"></Icon>
                            </telerik:RadButton>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <telerik:RadLinkButton ID="btnImport" runat="server" Text="Import Data" NavigateUrl="~/ADM/ImportData.aspx?source=Employees" ToolTip="Import records from CSV files" UseSubmitBehavior="false">
                            </telerik:RadLinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
                                <script type="text/javascript">
                                    function OnClientClose(sender, args) {
                                        var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                                        masterTable.rebind();
                                    }
                                </script>
                            </telerik:RadCodeBlock>
                            <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" CellSpacing="0" RenderMode="Auto" Skin="Bootstrap"
                                DataSourceID="SqlDataSource1" GridLines="None" AllowAutomaticDeletes="True"
                                AllowSorting="True" AutoGenerateColumns="False" Culture="en-US" PageSize="10" HeaderStyle-Font-Size="Small">
                                <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1" ShowFooter="True" EditMode="PopUp">
                                    <PagerStyle Mode="Slider" AlwaysVisible="false" />
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Photo" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px">
                                            <ItemTemplate>

                                                <asp:LinkButton ID="btnEditEmpl2" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to Edit Employee Photo"
                                                    CommandName="EditPhoto" UseSubmitBehavior="false">
                                                    <asp:Image ID="ImageEmployeePhoto" ImageUrl='<%#LocalAPI.GetEmployeePhotoURL(employeeId:=Eval("Id"))%>' CssClass="photo"
                                                        runat="server" AlternateText=""></asp:Image>
                                                </asp:LinkButton>

                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn Aggregate="Count" DataField="Name" FilterControlAltText="Filter Name column"
                                            FooterAggregateFormatString="{0:N0}" HeaderText="Name|Position <br/> Email" SortExpression="Name" ReadOnly="true"
                                            UniqueName="Name" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <div>
                                                    <strong>
                                                        <asp:LinkButton ID="btnEditEmpl" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to View/Edit Employee"
                                                            CommandName="EditEmployee" Text='<%# Eval("FullName") & Eval("Suffix") %>' UseSubmitBehavior="false">
                                                        </asp:LinkButton>

                                                    </strong>
                                                    &nbsp;&nbsp;&nbsp;<%# Eval("Position") %>
                                                </div>
                                                <div style="vertical-align: top">
                                                    <%--<asp:Image ID="imgQBconncetd" ImageUrl="~/Images/qb_connected_grid.png" ToolTip="Connected to QuickBook"
                                                        runat="server" Visible='<%# LocalAPI.IsQBEmployeeConnected(Eval("Id"))%>'></asp:Image>--%>
                                                    <a href='<%# string.Concat("mailto:", Eval("Email")) %>' title="Mail to"><%#Eval("Email") %></a>
                                                </div>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn Aggregate="Count" DataField="Name" FilterControlAltText="Filter Name column"
                                            FooterAggregateFormatString="{0:N0}" HeaderText="Name" SortExpression="Name" Display="false"
                                            UniqueName="Name" HeaderStyle-HorizontalAlign="Center">
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="DepartmentId" HeaderText="Department" SortExpression="DepartmentId" UniqueName="DepartmentId"
                                            ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="250px">
                                            <ItemTemplate>
                                                <%# Eval("Department")%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="PrjNumber" HeaderText="# Prjs." SortExpression="PrjNumber" UniqueName="PrjNumber"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="90px">
                                            <ItemTemplate>
                                                <%# Eval("PrjNumber", "{0:N0}")%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="ParentID" HeaderText="Boss" SortExpression="ParentID" UniqueName="ParentID"
                                            ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center" Display="false">
                                            <ItemTemplate>
                                                <%# Eval("ParentID")%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="EmployeeTimeLast30days" HeaderText="Hours_30d" SortExpression="EmployeeTimeLast30days" UniqueName="EmployeeTimeLast30days"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="90px" HeaderTooltip="Hours in Timesheet Last 30 days">
                                            <ItemTemplate>
                                                <%# Eval("EmployeeTimeLast30days", "{0:N0}")%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="Benefits_vacations" FilterControlAltText="Filter Benefits_vacations column"
                                            HeaderText="Vacs | Used | Bal </br>Pers | Used | Bal" SortExpression="Benefits_vacations" HeaderStyle-Width="160px" UniqueName="Benefits_vacations" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td style="width: 33%; text-align: center">
                                                            <small><%# Eval("Benefits_vacations")%></small>
                                                        </td>
                                                        <td style="width: 33%; text-align: center">
                                                            <small><%# Eval("used_vacations")%></small>
                                                        </td>
                                                        <td style="text-align: center">
                                                            <small><%# Eval("vacations_balance")%></small>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 33%; text-align: center">
                                                            <small><%# Eval("Benefits_personals")%></small>
                                                        </td>
                                                        <td style="width: 33%; text-align: center">
                                                            <small><%# Eval("used_personals")%></small>
                                                        </td>
                                                        <td style="text-align: center">
                                                            <small><%# Eval("personals_balance")%></small>
                                                        </td>

                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Status" UniqueName="Inactive" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="30px">
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" ID="btnInactive" CommandName="UpdateStatus" CommandArgument='<%# Eval("Id") %>' ToolTip='<%# iif(Eval("Inactive"), "Inactive Status. Click to change", "Active Status. Click to change") %>'
                                                    ForeColor='<%# GetStatusColor(Eval("Inactive")) %>'>
                                                        <span class='<%# ActiveInactiveIcon(Eval("Inactive")) %>'></span>
                                                </asp:LinkButton>


                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="Actions" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="90px">
                                            <ItemTemplate>
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td style="width: 50%; text-align: center">
                                                            <asp:LinkButton runat="server" ID="btnCredentials" CommandName="SendCredentials" CommandArgument='<%# Eval("Id") %>'
                                                                ToolTip="Send Email with login credentials">
                                                                <i class="far fa-envelope"></i>
                                                            </asp:LinkButton>
                                                        </td>
                                                        <td style="text-align: center">
                                                            <asp:LinkButton runat="server" ID="btnPermits" CommandName="Permits" CommandArgument='<%# Eval("Id") %>'
                                                                ToolTip="Employee Permits">
                                                                <i class="fas fa-cog"></i>
                                                            </asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>

                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this employee  and asociate user?"
                                            ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                            UniqueName="DeleteColumn" HeaderText="" HeaderStyle-HorizontalAlign="Center"
                                            HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                                        </telerik:GridButtonColumn>
                                    </Columns>
                                    <EditFormSettings>
                                        <PopUpSettings Modal="true" Width="650px" Height="1000px" />
                                        <FormMainTableStyle GridLines="None" CellSpacing="0" CellPadding="3" Width="100%" />
                                        <FormTableStyle CellSpacing="3" CellPadding="3" BackColor="White" Width="100%" />
                                        <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                                        </EditColumn>
                                    </EditFormSettings>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </td>
                    </tr>
                </table>
            </telerik:RadWizardStep>
            <telerik:RadWizardStep runat="server" ID="RadWizardStep2" Title="Vacation Schedule" StepType="Step">
                <table width="100%">
                    <tr>
                        <td class="PanelFilter">&nbsp;&nbsp;&nbsp;Year:&nbsp;
                            <telerik:RadComboBox ID="cboYear" runat="server" DataSourceID="SqlDataSourceYear" DataTextField="nYear" AutoPostBack="true"
                                DataValueField="Year" Width="100px">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="PanelFilter">
                            <telerik:RadScheduler ID="RadSchedulerVacation" runat="server" Culture="en-US" Skin="Web20" AllowDelete="false" AllowEdit="false" AllowInsert="false"
                                DataEndField="End"
                                DataKeyField="Id"
                                DataSourceID="SqlDataSourceEmployeeVacation"
                                DataStartField="Start"
                                DataSubjectField="Employee"
                                DayEndTime="23:59:00"
                                Height="750px"
                                FirstDayOfWeek="Monday" SelectedView="TimelineView">
                                <DayView UserSelectable="False" />
                                <WeekView UserSelectable="False" />
                                <MonthView UserSelectable="False" />
                                <TimelineView UserSelectable="False" NumberOfSlots="53" ColumnHeaderDateFormat="MMM dd" HeaderDateFormat="d" SlotDuration="7.00:00:00" />
                                <MultiDayView UserSelectable="False" />
                                <AgendaView UserSelectable="False" />
                            </telerik:RadScheduler>
                        </td>
                    </tr>
                </table>
            </telerik:RadWizardStep>
            <telerik:RadWizardStep runat="server" ID="RadWizardStep3" Title="Employee Live" StepType="Step">
                <table width="100%">
                    <tr>
                        <td class="PanelFilter">&nbsp;&nbsp;&nbsp;Year:&nbsp;
                            <telerik:RadComboBox ID="cboYear2" runat="server" DataSourceID="SqlDataSourceYear" DataTextField="nYear" AutoPostBack="true"
                                DataValueField="Year" Width="100px">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="PanelFilter">
                            <telerik:RadScheduler ID="RadSchedulerLive" runat="server" Culture="en-US" Skin="Web20" AllowDelete="false" AllowEdit="false" AllowInsert="false"
                                DataEndField="End"
                                DataKeyField="Id"
                                DataSourceID="SqlDataSourceEmployeeLive"
                                DataStartField="Start"
                                DataSubjectField="Employee"
                                DayEndTime="23:59:00"
                                Height="750px"
                                FirstDayOfWeek="Monday" SelectedView="TimelineView">
                                <DayView UserSelectable="False" />
                                <WeekView UserSelectable="False" />
                                <MonthView UserSelectable="False" />
                                <TimelineView UserSelectable="False" NumberOfSlots="53" ColumnHeaderDateFormat="MMM dd" HeaderDateFormat="d" SlotDuration="7.00:00:00" />
                                <MultiDayView UserSelectable="False" />
                                <AgendaView UserSelectable="False" />
                            </telerik:RadScheduler>
                        </td>
                    </tr>
                </table>
            </telerik:RadWizardStep>
        </WizardSteps>
    </telerik:RadWizard>


    <telerik:RadToolTip ID="RadToolTipDelete" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h2 style="margin: 0; text-align: center; color:white; width: 500px">
            <span class="navbar bg-dark">Delete employee
            </span>
        </h2>
        <table class="table-sm" style="width: 450px">
            <tr>
                <td class="Titulo4">&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label32" runat="server" Text="Action to remove the employee involved:"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;- Delete the Username and Password
                </td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;- Delete the employee profile
                </td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;- Delete the employee time historial
                </td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;- Update Multiplier and Department Monthly Target
                </td>
            </tr>
            <tr>
                <td class="NormalNegrita">&nbsp;&nbsp;&nbsp;Are you sure you perform this action?
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblSelected" runat="server" Visible="False"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="center">

                    <asp:LinkButton runat="server" ID="btnConfirmDelete" CssClass="btn btn-danger btn-lg">
                             Confirm Delete Employee
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="EMPLOYEES_SELECT" SelectCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboStatus" Name="InactiveId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Filter" PropertyName="Text" Type="String" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployeeVacation" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="EMPLOYEES_ResultByActivity" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="Year" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter DefaultValue="3" Name="ActivityId" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployeeLive" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="EMPLOYEES_ResultByLive" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Year], nYear FROM Years ORDER BY [Year] DESC"></asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployee" runat="server" Visible="False"></asp:Label>

</asp:Content>
