<%@ Page Title="Employee Vacation & Holidays" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="vacationandholidays.aspx.vb" Inherits="pasconcept20.vacationandholidays" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnFind">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadGridRequest" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGridRequest">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridRequest" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cboStatus">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridRequest" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" EnableEmbeddedSkins="false" />

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Employee Vacation & Holidays</span>

        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <b>Legend: </b>
        &nbsp;<span style="background-color: lightpink; color: white">&nbsp;Vacations&nbsp;</span>
        &nbsp;<span style="background-color: limegreen; color: white">&nbsp;Holidays&nbsp;</span>
        &nbsp;<span style="background-color: darkblue; color: white">&nbsp;Closure&nbsp;</span>
        &nbsp;<span style="background-color: darkred; color: white">&nbsp;Payday&nbsp;</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseRequest" aria-expanded="false" aria-controls="collapseRequest" title="Show/Hide Request panel">
                <i class="fas fa-list"></i>&nbsp;Requests
            </button>
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>



            <telerik:RadComboBox ID="cboEmployee" runat="server" DataSourceID="SqlDataSourceEmpl_activos" MarkFirstMatch="True" ToolTip="Select active Employye"
                Width="300px" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" AutoPostBack="true">
            </telerik:RadComboBox>

            <asp:LinkButton ID="btnNewVacation" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Add Vacation Request for selected employee">
                    Add Vacation
            </asp:LinkButton>
            <asp:LinkButton ID="btnUpdateHolidays" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Insert/Update/Delete Holidays and Company Closure">
                    Holidays/Closures
            </asp:LinkButton>
        </span>

    </div>
    <div class="collapse" id="collapseFilter">
        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
            <table style="width: 100%" class="pasconcept-bar noprint">
                <tr>
                    <td style="width: 100px; text-align: right">Department:</td>
                    <td style="width: 400px">
                        <telerik:RadComboBox ID="cboDepartments" runat="server" AppendDataBoundItems="true"
                            DataSourceID="SqlDataSourceDepartments" DataTextField="Name" DataValueField="Id" Filter="Contains"
                            Height="250px" MarkFirstMatch="True" Width="100%" EmptyMessage="(Select Department...)">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Selected="true" Text="(All Departments...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>

                    </td>
                    <td style="text-align: right">
                        <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="false">
                                                <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:Panel>

    </div>
    <div style="margin-top: 5px">
        <telerik:RadScheduler ID="RadScheduler1" runat="server" RenderMode="Lightweight" OverflowBehavior="Auto"
            DataDescriptionField="Description" AllowDelete="false" Font-Size="Smaller"
            DataEndField="End"
            DataKeyField="Id"
            DataSourceID="SqlDataSourceEmployeeVacation"
            DataStartField="Start"
            DataSubjectField="Subject"
            DayEndTime="21:00:00"
            EditFormDateFormat="MM/dd/yyyy"
            Height="700px"
            FirstDayOfWeek="Monday"
            LastDayOfWeek="Friday"
            StartInsertingInAdvancedForm="False"
            StartEditingInAdvancedForm="False"
            SelectedView="MonthView"
            ShowFooter="false" EnableDescriptionField="true">
            <DayView UserSelectable="false" />
            <WeekView UserSelectable="True" />
            <MonthView UserSelectable="false" MinimumRowHeight="4" />
            <TimelineView UserSelectable="false" />
            <MultiDayView UserSelectable="false" />
            <AgendaView UserSelectable="false" />
            <Reminders Enabled="false"></Reminders>

        </telerik:RadScheduler>
    </div>

    <div class="collapse" id="collapseRequest">

        <div class="pasconcept-bar noprint">
            <span style="vertical-align: middle;font-size:20px;font-weight:bold">Request</span>

            <span style="float: right; vertical-align: middle;">Status:
                <telerik:RadComboBox ID="cboStatus" runat="server" AppendDataBoundItems="true" Width="250px" AutoPostBack="true">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Selected="true" Text="Pending" Value="0" />
                        <telerik:RadComboBoxItem runat="server" Text="Accepted" Value="1" />
                        <telerik:RadComboBoxItem runat="server" Text="Declined" Value="2" />
                    </Items>
                </telerik:RadComboBox>
            </span>
        </div>
        <telerik:RadGrid ID="RadGridRequest" runat="server" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
            AutoGenerateColumns="False" DataSourceID="SqlDataSourceRequest" PageSize="15" AllowPaging="true"
            Height="850px" RenderMode="Lightweight"
            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
            <ClientSettings Selecting-AllowRowSelect="true">
                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
            </ClientSettings>
            <PagerStyle Mode="Slider" AlwaysVisible="false" />
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceRequest">
                <Columns>
                    <telerik:GridBoundColumn DataField="Id" UniqueName="ID" HeaderText="Request ID" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DateRequest" HeaderText="Date Request" SortExpression="DateRequest" UniqueName="DateRequest" DataFormatString="{0:d}" HeaderStyle-Width="130px" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="EmployeeFullName" HeaderText="Employee" SortExpression="EmployeeFullName" UniqueName="EmployeeFullName">
                        <ItemTemplate>
                            <a href='<%#String.Concat(LocalAPI.GetHostAppSite(), Eval("url")) %>' target="_blank">
                                <i class="far fa-share-square" style="padding-right: 10px"></i>
                            </a>
                            <%# Eval("EmployeeFullName") %>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="DateFrom" HeaderText="From" SortExpression="DateFrom" UniqueName="DateFrom" DataFormatString="{0:d}" HeaderStyle-Width="130px" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DateTo" HeaderText="To" SortExpression="DateTo" UniqueName="DateTo" DataFormatString="{0:d}" HeaderStyle-Width="130px" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Hours" HeaderText="Hours" SortExpression="Hours" UniqueName="Hours" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="StatusName" HeaderText="Status" SortExpression="StatusName" UniqueName="StatusName" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="NotesResponse" HeaderText="Notes Response" SortExpression="NotesResponse" UniqueName="NotesResponse">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>

    </div>

    <telerik:RadToolTip ID="RadToolTipHolidays" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h3 style="margin: 0; text-align: center; color: white; width: 800px">
            <span class="navbar navbar-expand-md bg-dark text-white">Insert/Update/Delete Holidays and Company Closure
            </span>
        </h3>
        <br />
        <table class="table-sm" style="width: 800px">
            <tr>
                <td style="z-index: 50001">
                    <asp:Panel runat="server"></asp:Panel>
                    <telerik:RadGrid ID="RadGridHoliday" GridLines="None" runat="server" AllowAutomaticDeletes="True"
                        HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-HorizontalAlign="Center"
                        AllowAutomaticInserts="True" AllowAutomaticUpdates="True" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="SqlDataSourceHoliday"
                        Height="350px" PageSize="100">
                        <ClientSettings>
                            <Scrolling AllowScroll="True" SaveScrollPosition="true"></Scrolling>
                        </ClientSettings>
                        <MasterTableView CommandItemDisplay="Top" DataKeyNames="Id"
                            DataSourceID="SqlDataSourceHoliday" HorizontalAlign="NotSet" AutoGenerateColumns="False">
                            <PagerStyle Mode="Slider" AlwaysVisible="false" />
                            <CommandItemSettings AddNewRecordText="Holiday/Closure" />
                            <Columns>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                    HeaderText="" HeaderStyle-Width="50px">
                                </telerik:GridEditCommandColumn>
                                <telerik:GridTemplateColumn DataField="Holiday" HeaderStyle-Width="100px" HeaderText="Date" SortExpression="Holiday" UniqueName="Holiday" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <%# Eval("Holiday", "{0:d}") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadDatePicker ID="RadDatePickerHoliday" runat="server" DbSelectedDate='<%# Bind("Holiday") %>' ToolTip="Holiday" ZIndex="50001">
                                        </telerik:RadDatePicker>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridCheckBoxColumn DataField="Closure" HeaderText="Closure" SortExpression="Closure" UniqueName="Closure" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridBoundColumn DataField="Description" HeaderText="Description" SortExpression="Description" UniqueName="Description">
                                </telerik:GridBoundColumn>
                                <telerik:GridButtonColumn ConfirmText="Delete this record?" ConfirmDialogType="RadWindow"
                                    ConfirmTitle="Delete" HeaderText="" HeaderStyle-Width="50px"
                                    CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings>
                                <EditColumn FilterControlAltText="Filter EditCommandColumn1 column" ButtonType="PushButton"
                                    UniqueName="EditCommandColumn1">
                                </EditColumn>
                            </EditFormSettings>

                        </MasterTableView>
                    </telerik:RadGrid>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">
                    <br />
                    <asp:LinkButton runat="server" ID="btnCloseHoliday" CssClass="btn btn-success btn-lg">
                            Close Holiday
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>

    <asp:SqlDataSource ID="SqlDataSourceEmployeeVacation" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="EmployeeVacationAndHolidays_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboDepartments" Name="departmentId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmpl_activos" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, FullName as Name FROM Employees WHERE companyId=@companyId and isnull(Inactive,0)=0 ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceHoliday" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Holiday, Closure=isnull(Closure,0), Description FROM Company_hollidays WHERE ([companyId] = @companyId) ORDER BY Holiday DESC"
        InsertCommand="INSERT INTO Company_hollidays(Holiday, Closure, Description, companyId) VALUES(@Holiday, @Closure, @Description, @companyId)"
        DeleteCommand="DELETE FROM Company_hollidays WHERE Id=@Id"
        UpdateCommand="UPDATE Company_hollidays SET Holiday=@Holiday, Closure=@Closure, Description=@Description WHERE Id=@Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Holiday" />
            <asp:Parameter Name="Closure" />
            <asp:Parameter Name="Description" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="Holiday" />
            <asp:Parameter Name="Closure" />
            <asp:Parameter Name="Description" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>



    <asp:SqlDataSource ID="SqlDataSourceRequest" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="NonJobTime_Request_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboDepartments" Name="departmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboStatus" Name="statusId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblLogedEmployeeId" runat="server" Visible="False"></asp:Label>

</asp:Content>
