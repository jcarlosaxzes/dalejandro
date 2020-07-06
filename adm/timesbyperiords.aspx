<%@ Page Title="Times By Periods" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="timesbyperiords.aspx.vb" Inherits="pasconcept20.timesbyperiords" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadToolTipMiscellaneous">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipMiscellaneous"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipMiscellaneous"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadToolTipSalary"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadToolTipSalary">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridSalary" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnBack">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadDatePickerFrom" />
                    <telerik:AjaxUpdatedControl ControlID="RadDatePickerTo" />
                    <telerik:AjaxUpdatedControl ControlID="lblMesName" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnNext">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadDatePickerFrom" />
                    <telerik:AjaxUpdatedControl ControlID="RadDatePickerTo" />
                    <telerik:AjaxUpdatedControl ControlID="lblMesName" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>--%>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />

    <div class="pasconcept-bar noprint">

        <span class="pasconcept-pagetitle">Time By Periods</span>

        <span style="float: right; vertical-align: middle;">
            <table class="table-sm">
                <tr>
                    <td>
                        <telerik:RadDropDownList ID="cboPeriod" runat="server" AutoPostBack="true" Width="150px">
                            <Items>
                                <telerik:DropDownListItem Text="By Periods" Value="0" />
                                <telerik:DropDownListItem Text="By Moths" Value="1" />
                                <telerik:DropDownListItem Text="By Years" Value="2" />
                            </Items>
                        </telerik:RadDropDownList>
                    </td>
                    <td>From:
                    </td>
                    <td>
                        <telerik:RadDateInput ID="RadDatePickerFrom" runat="server" DateFormat="MM/dd/yyyy" ReadOnly="True" Width="120px">
                        </telerik:RadDateInput>
                    </td>
                    <td>To:
                    </td>
                    <td>
                        <telerik:RadDateInput ID="RadDatePickerTo" runat="server" DateFormat="MM/dd/yyyy" ReadOnly="True" Width="120px">
                        </telerik:RadDateInput>
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboDepartments" runat="server" AppendDataBoundItems="true"
                            DataSourceID="SqlDataSourceDepartments" DataTextField="Name" DataValueField="Id" Filter="Contains" AutoPostBack="true"
                            Height="250px" MarkFirstMatch="True" Width="350px" DropDownAutoWidth="Enabled" EmptyMessage="(Select Department...)">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Selected="true" Text="(All Departments...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td>
                        <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false" Width="120px">
                                    <i class="fas fa-backward"></i>&nbsp;Previous
                        </asp:LinkButton>
                    </td>
                    <td>
                        <asp:LinkButton ID="btnNext" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false" Width="120px">
                                    <i class="fas fa-forward"></i>&nbsp;Next
                        </asp:LinkButton>
                    </td>

                </tr>
            </table>
        </span>

    </div>


    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" HeaderStyle-Font-Size="Small"
            GridLines="None" AutoGenerateColumns="False" AllowAutomaticUpdates="True" AllowSorting="True" CellSpacing="0" ShowFooter="true">
            <ExportSettings>
                <Pdf PageBottomMargin="" PageFooterMargin="" PageHeaderMargin="" PageHeight="11in"
                    PageLeftMargin="" PageRightMargin="" PageTopMargin="" PageWidth="8.5in">
                </Pdf>
            </ExportSettings>
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1">
                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                <ColumnGroups>
                    <telerik:GridColumnGroup Name="Production" HeaderText="Production"
                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="true" />
                    <telerik:GridColumnGroup Name="Administrative" HeaderText="Administrative"
                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="true" />
                    <telerik:GridColumnGroup Name="Benefits" HeaderText="Benefits"
                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="true" />
                </ColumnGroups>
                <Columns>
                    <telerik:GridBoundColumn DataField="Id" HeaderText="Id" SortExpression="Id" UniqueName="Id" DataType="System.Int32" ReadOnly="True" Display="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Name2" HeaderText="Employee" SortExpression="Name2" UniqueName="Name2" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Total" DataType="System.Double" HeaderText="Total" SortExpression="Total" UniqueName="Total" ReadOnly="True"
                        ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" FooterStyle-Width="100px" FooterStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" Aggregate="Sum" DataFormatString="{0:N1}" FooterAggregateFormatString="{0:N1}">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="Salary" DataType="System.Double" HeaderText="Salary" SortExpression="Salary" UniqueName="Salary" ReadOnly="True"
                        ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Right" FooterStyle-Width="100px" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" Aggregate="Sum" FooterAggregateFormatString="{0:N1}" Display="false">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkSalary" runat="server" CommandName="Salary" Text='<%# Eval("Salary", "{0:N2}")%>' CommandArgument='<%# Eval("Id") %>' ToolTip="Click to edit Salary"
                                CssClass='<%# IIf(Eval("Salary") = 0, "ApagarCSS", "SalaryCSS")%>'>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="Jobs" DataType="System.Double" FilterControlAltText="Filter Jobs column" HeaderText="Jobs" ReadOnly="True" SortExpression="Jobs" UniqueName="Jobs"
                        ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" FooterStyle-Width="100px" FooterStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" Aggregate="Sum" DataFormatString="{0:N1}" FooterAggregateFormatString="{0:N1}"
                        ColumnGroupName="Production">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="Over_Time" DataType="System.Double" FilterControlAltText="Filter Over_Time column" HeaderText="Over Time" ReadOnly="True" SortExpression="Over_Time" UniqueName="Over_Time"
                        ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" FooterStyle-Width="100px" FooterStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" Aggregate="Sum" FooterAggregateFormatString="{0:N1}"
                        ColumnGroupName="Production">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CommandName="1" Text='<%# Eval("Over_Time", "{0:N1}")%>' CommandArgument='<%# Eval("Id") %>' ToolTip="Click to add Over_Time time"
                                CssClass='<%# IIf(Eval("Over_Time") = 0, "ApagarCSS", "ResaltarCSS")%>'>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Administration" DataType="System.Double" FilterControlAltText="Filter Administration column" HeaderText="Administration" ReadOnly="True" SortExpression="Administration" UniqueName="Administration"
                        ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" FooterStyle-Width="100px" FooterStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" Aggregate="Sum" FooterAggregateFormatString="{0:N1}"
                        ColumnGroupName="Administrative">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton3" runat="server" CommandName="3" Text='<%# Eval("Administration", "{0:N1}")%>' CommandArgument='<%# Eval("Id") %>' ToolTip="Click to add Administration time"
                                CssClass='<%# IIf(Eval("Administration") = 0, "ApagarCSS", "ResaltarCSS")%>'>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Accounting" DataType="System.Double" FilterControlAltText="Filter Accounting column" HeaderText="Accounting" ReadOnly="True" SortExpression="Accounting" UniqueName="Accounting"
                        ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" FooterStyle-Width="100px" FooterStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" Aggregate="Sum" FooterAggregateFormatString="{0:N1}"
                        ColumnGroupName="Administrative">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton8" runat="server" CommandName="8" Text='<%# Eval("Accounting", "{0:N1}")%>' CommandArgument='<%# Eval("Id") %>' ToolTip="Click to add Accounting time"
                                CssClass='<%# IIf(Eval("Accounting") = 0, "ApagarCSS", "ResaltarCSS")%>'>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Marketing" DataType="System.Double" FilterControlAltText="Filter Marketing column" HeaderText="Marketing" ReadOnly="True" SortExpression="Marketing" UniqueName="Marketing"
                        ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" FooterStyle-Width="100px" FooterStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" Aggregate="Sum" FooterAggregateFormatString="{0:N1}"
                        ColumnGroupName="Administrative">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton4" runat="server" CommandName="4" Text='<%# Eval("Marketing", "{0:N1}")%>' CommandArgument='<%# Eval("Id") %>' ToolTip="Click to add Marketing time"
                                CssClass='<%# IIf(Eval("Marketing") = 0, "ApagarCSS", "ResaltarCSS")%>'>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Sick" DataType="System.Double" FilterControlAltText="Filter Sick column" HeaderText="Sick" ReadOnly="True" SortExpression="Sick" UniqueName="Sick"
                        ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" FooterStyle-Width="100px" FooterStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" Aggregate="Sum" FooterAggregateFormatString="{0:N1}"
                        ColumnGroupName="Benefits">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton5" runat="server" CommandName="5" Text='<%# Eval("Sick", "{0:N1}")%>' CommandArgument='<%# Eval("Id") %>' ToolTip="Click to add Sick time"
                                CssClass='<%# IIf(Eval("Sick") = 0, "ApagarCSS", "ResaltarCSS")%>'>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Vacation" DataType="System.Double" FilterControlAltText="Filter Vacation column" HeaderText="Vacation" ReadOnly="True" SortExpression="Vacation" UniqueName="Vacation"
                        ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" FooterStyle-Width="100px" FooterStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" Aggregate="Sum" FooterAggregateFormatString="{0:N1}"
                        ColumnGroupName="Benefits">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton7" runat="server" CommandName="7" Text='<%# Eval("Vacation", "{0:N1}")%>' CommandArgument='<%# Eval("Id") %>' ToolTip="Click to add Vacation time"
                                CssClass='<%# IIf(Eval("Vacation") = 0, "ApagarCSS", "ResaltarCSS")%>'>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Holiday" DataType="System.Double" FilterControlAltText="Filter Holiday column" HeaderText="Holiday" ReadOnly="True" SortExpression="Holiday" UniqueName="Holiday"
                        ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" FooterStyle-Width="100px" FooterStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" Aggregate="Sum" FooterAggregateFormatString="{0:N1}"
                        ColumnGroupName="Benefits">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton2" runat="server" CommandName="2" Text='<%# Eval("Holiday", "{0:N1}")%>' CommandArgument='<%# Eval("Id") %>' ToolTip="Click to add Holiday time"
                                CssClass='<%# IIf(Eval("Holiday") = 0, "ApagarCSS", "ResaltarCSS")%>'>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Personal" DataType="System.Double" FilterControlAltText="Filter Personal column" HeaderText="Personal" ReadOnly="True" SortExpression="Personal" UniqueName="Personal"
                        ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" FooterStyle-Width="100px" FooterStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" Aggregate="Sum" FooterAggregateFormatString="{0:N1}"
                        ColumnGroupName="Benefits">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton6" runat="server" CommandName="6" Text='<%# Eval("Personal", "{0:N1}")%>' CommandArgument='<%# Eval("Id") %>' ToolTip="Click to add Personal time"
                                CssClass='<%# IIf(Eval("Personal") = 0, "ApagarCSS", "ResaltarCSS")%>'>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>


    <telerik:RadToolTip ID="RadToolTipSalary" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode" Skin="Default" OnClientHide="salaryDlgHide">
        <h2 style="margin: 0; text-align: center; color: white; width: 550px">
            <span class="navbar navbar-expand-md bg-dark text-white">Salary
            </span>
        </h2>
        <div style="width: 550px">
            <telerik:RadAjaxPanel ID="RadAjaxPanelSalary" runat="server">
                <asp:CheckBox ID="chkAplyAllPayroll" runat="server" Text="Apply 'Insert parameters' to All Payroll days in the Salary Date year" />
                <telerik:RadGrid ID="RadGridSalary" GridLines="None" runat="server" AllowAutomaticDeletes="True" Style="z-index: 8001"
                    AllowAutomaticInserts="True" AllowAutomaticUpdates="True"
                    AutoGenerateColumns="False" DataSourceID="SqlDataSourceSalary">
                    <MasterTableView CommandItemDisplay="Top" DataKeyNames="Id"
                        DataSourceID="SqlDataSourceSalary" HorizontalAlign="NotSet" AutoGenerateColumns="False">

                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                HeaderText="Edit" HeaderStyle-Width="40px">
                            </telerik:GridEditCommandColumn>
                            <telerik:GridTemplateColumn DataField="SalaryDate" HeaderStyle-Width="150px" HeaderText="Date"
                                SortExpression="SalaryDate" UniqueName="SalaryDate" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <%# Eval("SalaryDate", "{0:d}") %>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadDatePicker ID="RadDatePickerDate" runat="server" ZIndex="80001" DbSelectedDate='<%# Bind("SalaryDate") %>'>
                                    </telerik:RadDatePicker>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridNumericColumn DataField="NetAmount" HeaderStyle-Width="150px" HeaderText="Net Amount" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right"
                                SortExpression="NetAmount" UniqueName="NetAmount" DataFormatString="{0:C2}">
                            </telerik:GridNumericColumn>
                            <telerik:GridNumericColumn DataField="GrossAmount" HeaderStyle-Width="150px" HeaderText="Gross Amount" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right"
                                SortExpression="GrossAmount" UniqueName="GrossAmount" DataFormatString="{0:C2}">
                            </telerik:GridNumericColumn>
                            <telerik:GridNumericColumn DataField="Hours" HeaderStyle-Width="100px" HeaderText="Hours"
                                SortExpression="Hours" UniqueName="Hours" DataFormatString="{0:N0}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
                            </telerik:GridNumericColumn>
                            <telerik:GridButtonColumn ConfirmText="Delete this record?" ConfirmDialogType="Classic"
                                ConfirmTitle="Delete" HeaderText="Delete" HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center"
                                CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">
                            </telerik:GridButtonColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </telerik:RadAjaxPanel>
        </div>
    </telerik:RadToolTip>

    <telerik:RadToolTip ID="RadToolTipMiscellaneous" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode" Skin="Default">
        <h2 style="margin: 0; text-align: center; color: white; width: 600px">
            <span class="navbar navbar-expand-md bg-dark text-white">New Miscellaneous Time
            </span>
        </h2>
        <table style="width: 600px" cellpadding="2px">
            <tr>
                <td style="width: 150px; text-align: right" class="Normal">Category:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboType" runat="server" DataSourceID="SqlDataSourceMiscellaneousType" DataTextField="Name" ZIndex="50001"
                        DataValueField="Id" Width="100%" MarkFirstMatch="True" Filter="Contains" Height="300px">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right" class="Normal">Time/day:
                </td>
                <td>
                    <telerik:RadNumericTextBox ID="txtMiscellaneousHours" runat="server" MaxLength="5" MaxValue="8"
                        MinValue="0.5" ShowSpinButtons="True" ButtonsPosition="Right" ToolTip="Time in hours for each day" Value="1">
                        <NumberFormat DecimalDigits="1" />
                        <IncrementSettings Step="1" />
                    </telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right" class="Normal">From:</td>
                <td>
                    <telerik:RadDatePicker ID="RadDatePicker1" runat="server" Culture="English (United States)" ZIndex="50001">
                        <DateInput DateFormat="MM/dd/yyyy" DisplayDateFormat="MM/dd/yyyy">
                        </DateInput>
                        <Calendar>
                        </Calendar>
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td style="text-align: right" class="Normal">To:</td>
                <td>
                    <telerik:RadDatePicker ID="RadDatePicker2" runat="server" Culture="English (United States)" ZIndex="50001">
                        <DateInput DateFormat="MM/dd/yyyy" DisplayDateFormat="MM/dd/yyyy">
                        </DateInput>
                        <Calendar>
                        </Calendar>
                    </telerik:RadDatePicker>

                </td>
            </tr>
            <tr>
                <td style="text-align: right" class="Normal">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtNotes" Text="*" ErrorMessage="(*) Notes can not be empty"
                        SetFocusOnError="true" ValidationGroup="AddRecord">
                    </asp:RequiredFieldValidator>
                    Notes:</td>
                <td>
                    <telerik:RadTextBox ID="txtNotes" runat="server" TextMode="MultiLine" Width="100%"
                        MaxLength="128">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center; padding-top: 15px">
                    <telerik:RadButton ID="btnOkNewMiscellaneousTime" runat="server" Text="Add New Time" ValidationGroup="AddRecord" UseSubmitBehavior="false">
                        <Icon PrimaryIconCssClass="rbAdd" PrimaryIconLeft="4" PrimaryIconTop="4"></Icon>
                    </telerik:RadButton>

                    &nbsp;&nbsp;&nbsp;
                    <telerik:RadButton ID="btnCancelMiscellaneousTime" runat="server" Text="Cancel" CausesValidation="False">
                        <Icon PrimaryIconCssClass=" rbCancel" PrimaryIconTop="5"></Icon>
                    </telerik:RadButton>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="padding-left: 125px">
                    <asp:ValidationSummary ID="ValidationSummaryJobUpdate" Font-Size="X-Small" runat="server" HeaderText="Following error occurs:" ShowMessageBox="false" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="AddRecord" />
                </td>
            </tr>

        </table>
        <div style="padding-left: 125px; padding-top: 30px; padding-bottom: 10px">
            <table style="width: 500px; border: 1px solid #aeaeaf;">
                <tr>
                    <td style="width: 25%"><b>Benefits</b></td>
                    <td style="width: 25%; text-align: center"><b>Assigned</b></td>
                    <td style="width: 25%; text-align: center"><b>Used</b></td>
                    <td style="width: 25%; text-align: center"><b>Balance</b></td>
                </tr>
                <tr>
                    <td>Vacations</td>
                    <td style="text-align: center">
                        <asp:Label ID="lblVac1" runat="server" Text="0"></asp:Label></td>
                    <td style="text-align: center">
                        <asp:Label ID="lblVac2" runat="server" Text="0"></asp:Label></td>
                    <td style="text-align: center">
                        <asp:Label ID="lblVac3" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td>Personal/Sick</td>
                    <td style="text-align: center">
                        <asp:Label ID="lblPer1" runat="server" Text="0"></asp:Label></td>
                    <td style="text-align: center">
                        <asp:Label ID="lblPer2" runat="server" Text="0"></asp:Label></td>
                    <td style="text-align: center">
                        <asp:Label ID="lblPer3" runat="server" Text="0"></asp:Label></td>

                </tr>
            </table>
        </div>
    </telerik:RadToolTip>
    <script type="text/javascript">
        function salaryDlgHide(sender, eventArgs) {
            var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
            masterTable.rebind();
        }
    </script>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="TIMESHEET3_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="From" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="To" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboDepartments" Name="departmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceMiscellaneousType" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="MiscellaneousType_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceSalary" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, SalaryDate, NetAmount, Hours,GrossAmount FROM Employee_Payroll WHERE employeeId=@employeeId and SalaryDate between @From and @To ORDER BY SalaryDate DESC"
        InsertCommand="Employee_Payroll_INSERT" InsertCommandType="StoredProcedure"
        DeleteCommand="DELETE FROM Employee_Payroll WHERE Id=@Id"
        UpdateCommand="UPDATE Employee_Payroll SET SalaryDate=@SalaryDate, NetAmount=@NetAmount, GrossAmount=@GrossAmount, Hours=@Hours WHERE Id=@Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="From" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="To" PropertyName="SelectedDate" Type="DateTime" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="SalaryDate" />
            <asp:Parameter Name="NetAmount" />
            <asp:Parameter Name="GrossAmount" />
            <asp:Parameter Name="Hours" />
            <asp:ControlParameter ControlID="chkAplyAllPayroll" Name="ApplyAllPayroll" PropertyName="Checked" Type="Boolean" />
            <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="SalaryDate" />
            <asp:Parameter Name="NetAmount" />
            <asp:Parameter Name="GrossAmount" />
            <asp:Parameter Name="Hours" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblMesName" runat="server" Text="Septembre-Octuber" Visible="False" />
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>

</asp:Content>

