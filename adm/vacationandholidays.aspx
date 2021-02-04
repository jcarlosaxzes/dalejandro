<%@ Page Title="Employee Vacation & Holidays" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="vacationandholidays.aspx.vb" Inherits="pasconcept20.vacationandholidays" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnFind">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" EnableEmbeddedSkins="false" />

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Employee Vacation & Holidays</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>


            <telerik:RadComboBox ID="cboEmployee" runat="server" DataSourceID="SqlDataSourceEmpl_activos" MarkFirstMatch="True" ToolTip="Select active Employye"
                Width="300px" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" AutoPostBack="true">
            </telerik:RadComboBox>

            <asp:LinkButton ID="btnNewVacation" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Add Vacation Request for selected employee">
                    Add Vacation
            </asp:LinkButton>
            <asp:LinkButton ID="btnUpdateHolidays" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Insert/Update/Delete Holidays">
                    Update Holidays
            </asp:LinkButton>
        </span>

    </div>
    <div class="collapse" id="collapseFilter">
        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
            <table width="100%" class="pasconcept-bar noprint">
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
    <div style="text-align: left">
        <b>Legend: </b>
        <ul>
            <li><span style="background-color: lightpink; color: white">Vacations</span></li>
            <li><span style="background-color: limegreen; color: white">Holidays</span></li>
        </ul>


    </div>


    <telerik:RadToolTip ID="RadToolTipHolidays" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <h3 style="margin: 0; text-align: center; color: white; width: 800px">
            <span class="navbar navbar-expand-md bg-dark text-white">Insert/Update/Delete Holidays
            </span>
        </h3>
        <br />
        <table class="table-sm" style="width: 800px">
            <tr>
                <td>Holidays 
                </td>
            </tr>
            <tr>
                <td style="z-index: 50001">
                    <asp:Panel runat="server"></asp:Panel>
                    <telerik:RadGrid ID="RadGridHoliday" GridLines="None" runat="server" AllowAutomaticDeletes="True"
                        HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small"
                        AllowAutomaticInserts="True" AllowAutomaticUpdates="True" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="SqlDataSourceHoliday"
                        Height="350px" PageSize="100">
                        <ClientSettings>
                            <Scrolling AllowScroll="True" SaveScrollPosition="true"></Scrolling>
                        </ClientSettings>
                        <MasterTableView CommandItemDisplay="Top" DataKeyNames="Id"
                            DataSourceID="SqlDataSourceHoliday" HorizontalAlign="NotSet" AutoGenerateColumns="False">
                            <PagerStyle Mode="Slider" AlwaysVisible="false" />
                            <CommandItemSettings AddNewRecordText="Holiday" />
                            <Columns>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                    HeaderText="" HeaderStyle-Width="50px">
                                </telerik:GridEditCommandColumn>
                                <telerik:GridTemplateColumn DataField="Holiday" HeaderStyle-Width="180px" HeaderText="Holiday" SortExpression="Holiday" UniqueName="Holiday">
                                    <ItemTemplate>
                                        <%# Eval("Holiday", "{0:d}") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadDatePicker ID="RadDatePickerHoliday" runat="server" DbSelectedDate='<%# Bind("Holiday") %>' ToolTip="Holiday" ZIndex="50001">
                                        </telerik:RadDatePicker>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="Description" HeaderText="Description"
                                    SortExpression="Description" UniqueName="Description">
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
        SelectCommand="SELECT Id, Holiday, Description FROM Company_hollidays WHERE ([companyId] = @companyId) ORDER BY Holiday DESC"
        InsertCommand="INSERT INTO Company_hollidays(Holiday, Description, companyId) VALUES(@Holiday, @Description, @companyId)"
        DeleteCommand="DELETE FROM Company_hollidays WHERE Id=@Id"
        UpdateCommand="UPDATE Company_hollidays SET Holiday=@Holiday, Description=@Description WHERE Id=@Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Holiday" />
            <asp:Parameter Name="Description" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="Holiday" />
            <asp:Parameter Name="Description" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblLogedEmployeeId" runat="server" Visible="False"></asp:Label>

</asp:Content>
