<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="employee_hourlywagehistory.aspx.vb" Inherits="pasconcept20.employee_hourlywagehistory" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Hourly Wage</title>
    <link href="~/Content/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" EnableCdn="true" runat="server">
        </telerik:RadScriptManager>

        <div class="container">
            <table class="table-condensed" style="width: 100%">
                <tr>
                    <td style="text-align: center">
                        <h3>
                            <asp:Label ID="lblEmployeeName" runat="server"></asp:Label><br />
                            (<asp:Label ID="lblYear" runat="server"></asp:Label>)</h3>
                    </td>
                    <td>
                        <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" DataSourceID="SqlDataSourceChart" Height="170px" Width="100%"
                            Transitions="true" >
                            <PlotArea>
                                <Series>
                                    <telerik:LineSeries DataFieldY="Amount" Name="$/Hour" AxisName="LeftAxis">

                                        <TooltipsAppearance DataFormatString="{0:N2}"></TooltipsAppearance>

                                        <Appearance>
                                            <FillStyle BackgroundColor="Red" />
                                        </Appearance>

                                        <LineAppearance LineStyle="Smooth" Width="2" />
                                        <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                        <LabelsAppearance Color="Red" Position="Above">
                                            <TextStyle FontSize="10" />
                                        </LabelsAppearance>

                                    </telerik:LineSeries>
                                </Series>
                                <YAxis Name="LeftAxis" MajorTickSize="6" MajorTickType="Outside" Step="10" MinorTickSize="1" Color="Red" Width="3">
                                    <TitleAppearance Text="$/Hour"></TitleAppearance>
                                    <LabelsAppearance DataFormatString="{0:N2}" >
                                        <TextStyle FontSize="8" />
                                    </LabelsAppearance>
                                    <MinorGridLines Visible="false"></MinorGridLines>
                                    
                                </YAxis>
                                <XAxis DataLabelsField="YearGroup">
                                    <TitleAppearance Text="Date" Visible="false"></TitleAppearance>
                                    <MinorGridLines Visible="false"></MinorGridLines>
                                    <MajorGridLines Visible="false" />
                                    <LabelsAppearance>
                                        <TextStyle FontSize="10" />
                                    </LabelsAppearance>
                                </XAxis>
                            </PlotArea>
                            <Legend>
                                <Appearance Visible="false" Position="Top"></Appearance>
                            </Legend>
                        </telerik:RadHtmlChart>
                    </td>
                </tr>
            </table>

            <telerik:RadTabStrip runat="server" ID="RadTabStrip1" MultiPageID="RadMultiPage1" SelectedIndex="0" CausesValidation="True"
                RenderMode="Lightweight" Skin="Metro">
                <Tabs>
                    <telerik:RadTab Text="Current"></telerik:RadTab>
                    <telerik:RadTab Text="Review"></telerik:RadTab>
                    <telerik:RadTab Text="History this Year"></telerik:RadTab>
                </Tabs>
            </telerik:RadTabStrip>

            <telerik:RadMultiPage runat="server" ID="RadMultiPage1" SelectedIndex="0" Width="100%" CausesValidation="True">
                <telerik:RadPageView runat="server" ID="RadPageView1">
                    <br />
                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSource1" Width="100%">
                        <ItemTemplate>
                            <table class="table-condensed" style="width: 100%">
                                <tr>
                                    <td style="width: 180px">Date From:
                                    </td>
                                    <td>
                                        <telerik:RadDatePicker ID="RadDatePicker1" runat="server" DateFormat="MM/dd/yyyy" Enabled="false" DbSelectedDate='<%# Eval("Date") %>' Width="120px"  Skin="Material">
                                        </telerik:RadDatePicker>
                                    </td>
                                    <td class="small">Date From (in selected year) to apply this settings.
                                    </td>
                                </tr>
                                <tr>
                                    <td>Date To:
                                    </td>
                                    <td>
                                        <telerik:RadDatePicker ID="RadDatePicker2" runat="server" DateFormat="MM/dd/yyyy" Enabled="false" DbSelectedDate='<%# Eval("DateEnd") %>' Width="120px"  Skin="Material">
                                        </telerik:RadDatePicker>
                                    </td>
                                    <td class="small">Date From (in selected year) to apply this settings.
                                    </td>
                                </tr>

                                <tr>
                                    <td>Hourly Rate ($/hour):
                                    </td>
                                    <td style="width: 180px;">
                                        <telerik:RadNumericTextBox ID="txtHourlyRate1" runat="server" Enabled="false" DbValue='<%# Eval("Amount") %>' Width="100px"  Skin="Material">
                                            <NumberFormat DecimalDigits="2" />
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td class="small">Amount of money that is paid for every hour worked.
                                    </td>
                                </tr>
                                <tr>
                                    <td>Producer Rate (0 to 1):
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="RadNumericTextBox1" runat="server" Enabled="false" MaxValue="1" DbValue='<%# Eval("Producer") %>' Width="100px"  Skin="Material">
                                            <NumberFormat DecimalDigits="2" />
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td class="small">Ratio as Producer, where 1 is fully producer and 0 is non-producer.
                                    </td>
                                </tr>
                                <tr>
                                    <td>Hour Per Week:
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="RadNumericTextBox2" runat="server" Enabled="false" DbValue='<%# Eval("HourPerWeek") %>' Width="100px"  Skin="Material">
                                            <NumberFormat DecimalDigits="0" />
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td class="small">The number of hours a employee may spend per work week.
                                    </td>
                                </tr>
                                <tr>
                                    <td>Vacations(Hours):
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="txtBenefits_vacations1" runat="server" Enabled="false" DbValue='<%# Eval("Benefits_vacations") %>' Width="100px"  Skin="Material">
                                            <NumberFormat DecimalDigits="0" />
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td class="small">The number of hours of benefit given to employees during a year in which they do not have to work.
                                    </td>
                                </tr>
                                <tr>
                                    <td>Personal/Sicks (Hours):
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="txtBenefits_personals1" runat="server" Enabled="false" DbValue='<%# Eval("Benefits_personals") %>' Width="100px"  Skin="Material">
                                            <NumberFormat DecimalDigits="0" />
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td class="small">The number of hours of benefit given to employees during a year in which they do not have to work.
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:FormView>
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView2">
                    <br />
                    <table class="table-condensed" style="width: 100%">
                        <tr>
                            <td style="width: 180px">Date From:
                            </td>
                            <td>
                                <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" DateFormat="MM/dd/yyyy" Culture="en-US">
                                </telerik:RadDatePicker>
                            </td>
                            <td class="small">Date From (in selected year) to apply this settings.
                            </td>
                        </tr>
                        <tr>
                            <td>Hourly Rate ($/hour):
                            </td>
                            <td style="width: 180px;">
                                <telerik:RadNumericTextBox ID="txtHourlyRate" runat="server" MinValue="0" MaxValue="80" Width="160"
                                    ShowSpinButtons="True"
                                    ButtonsPosition="Right">
                                    <NumberFormat DecimalDigits="2" />
                                    <IncrementSettings Step="0.5" />
                                </telerik:RadNumericTextBox>
                            </td>
                            <td class="small">Amount of money that is paid for every hour worked.
                            </td>
                        </tr>
                        <tr>
                            <td>Producer Rate (0 to 1):
                            </td>
                            <td>
                                <telerik:RadNumericTextBox ID="RadNumericProducer" runat="server" MinValue="0" Width="160" MaxValue="1">
                                    <NumberFormat DecimalDigits="2" />
                                </telerik:RadNumericTextBox>
                            </td>
                            <td class="small">Ratio as Producer, where 1 is fully producer and 0 is non-producer.
                            </td>
                        </tr>
                        <tr>
                            <td>Hour Per Week:
                            </td>
                            <td>
                                <telerik:RadNumericTextBox ID="RadNumericHour" runat="server" MinValue="0" Width="160">
                                    <NumberFormat DecimalDigits="0" />
                                </telerik:RadNumericTextBox>
                            </td>
                            <td class="small">The number of hours a employee may spend per work week.
                            </td>
                        </tr>
                        <tr>
                            <td>Vacations(Hours):
                            </td>
                            <td>
                                <telerik:RadNumericTextBox ID="txtBenefits_vacations" runat="server" MinValue="0" MaxValue="160" Width="160">
                                    <NumberFormat DecimalDigits="0" />
                                </telerik:RadNumericTextBox>
                            </td>
                            <td class="small">The number of hours of benefit given to employees during a year in which they do not have to work.
                            </td>
                        </tr>
                        <tr>
                            <td>Personal/Sicks (Hours):
                            </td>
                            <td>
                                <telerik:RadNumericTextBox ID="txtBenefits_personals" runat="server" MinValue="0" MaxValue="32" Width="160">
                                    <NumberFormat DecimalDigits="0" />
                                </telerik:RadNumericTextBox>
                            </td>
                            <td class="small">The number of hours of benefit given to employees during a year in which they do not have to work.
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table class="table-condensed" style="width: 100%">
                        <tr>
                            <td style="text-align: center">
                                <asp:LinkButton ID="btnInsert" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" Text="Insert" ToolTip="Insert New Record" ValidationGroup="Insert">
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView3">
                    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSourceHourlyWageDetail" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
                        AutoGenerateColumns="False" AllowSorting="True" ShowFooter="true"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" FooterStyle-Font-Size="X-Small" HeaderStyle-Font-Size="X-Small">
                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceHourlyWageDetail" CommandItemDisplay="Top">
                            <CommandItemSettings ShowAddNewRecordButton="false" />
                            <Columns>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                    HeaderText="" HeaderStyle-Width="40px">
                                </telerik:GridEditCommandColumn>
                                <telerik:GridDateTimeColumn DataField="Date" FilterControlAltText="Filter Date column" HeaderText="Date From" HeaderStyle-HorizontalAlign="Center"
                                    SortExpression="Date" UniqueName="Date" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="center" PickerType="DatePicker" DataFormatString="{0:d}">
                                </telerik:GridDateTimeColumn>
                                <telerik:GridDateTimeColumn DataField="DateEnd" FilterControlAltText="Filter DateEnd column" HeaderText="Date To" HeaderStyle-HorizontalAlign="Center"
                                    SortExpression="DateEnd" UniqueName="DateEnd" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="center" PickerType="DatePicker" DataFormatString="{0:d}">
                                </telerik:GridDateTimeColumn>
                                <telerik:GridNumericColumn DataField="Amount" FilterControlAltText="Filter Amount column" HeaderText="$/Hour" HeaderStyle-HorizontalAlign="Center"
                                    SortExpression="Amount" UniqueName="Amount" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" HeaderTooltip="Hourly Wage Rate"
                                    DecimalDigits="2" MinValue="0">
                                </telerik:GridNumericColumn>
                                <telerik:GridNumericColumn DataField="HourPerWeek" FilterControlAltText="Filter HourPerWeek column" HeaderText="Hours per Week" HeaderStyle-HorizontalAlign="Center"
                                    SortExpression="HourPerWeek" UniqueName="HourPerWeek" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right"
                                    DecimalDigits="2" MinValue="0" MaxValue="40">
                                </telerik:GridNumericColumn>
                                <telerik:GridNumericColumn DataField="Benefits_vacations" FilterControlAltText="Filter Benefits_vacations column" HeaderText="Vacations(hours)" HeaderStyle-HorizontalAlign="Center"
                                    SortExpression="Benefits_vacations" UniqueName="Benefits_vacations" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right"
                                    DecimalDigits="0" MinValue="0" MaxValue="80">
                                </telerik:GridNumericColumn>
                                <telerik:GridNumericColumn DataField="Benefits_personals" FilterControlAltText="Filter Benefits_personals column" HeaderText="Personals(hours)" HeaderStyle-HorizontalAlign="Center"
                                    SortExpression="Benefits_personals" UniqueName="Benefits_personals" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right"
                                    DecimalDigits="0" MinValue="0" MaxValue="32">
                                </telerik:GridNumericColumn>
                                <telerik:GridNumericColumn DataField="Producer" FilterControlAltText="Filter Producer column" HeaderText="P.Rate" HeaderStyle-HorizontalAlign="Center"
                                    SortExpression="Producer" UniqueName="Producer" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right" HeaderTooltip="Producer Rate 0 to 1"
                                    DecimalDigits="2" MinValue="0" MaxValue="1">
                                </telerik:GridNumericColumn>

                                <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ButtonType="ImageButton"
                                    HeaderText="" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn"
                                    HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                                </telerik:GridButtonColumn>
                            </Columns>

                        </MasterTableView>
                    </telerik:RadGrid>
                </telerik:RadPageView>
            </telerik:RadMultiPage>

            <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
                <p class="text-danger"><%: SuccessMessageText %></p>
            </asp:PlaceHolder>

            <asp:ValidationSummary ID="ValidationSummary1" runat="server"
                Font-Size="X-Small" HeaderText="Following error occurs:" ShowMessageBox="false" DisplayMode="BulletList" ShowSummary="true"
                ValidationGroup="Employee" />

        </div>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="Employee_HourlyWageHistory_SELECT" SelectCommandType="StoredProcedure"
            InsertCommand="Employee_HourlyWageHistoryExt_INSERT" InsertCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblHourlyWageHistoryId" Name="Id" PropertyName="Text" />
            </SelectParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" />
                <asp:ControlParameter ControlID="RadDatePickerFrom" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                <asp:ControlParameter ControlID="txtHourlyRate" Name="Amount" PropertyName="Value" />
                <asp:ControlParameter ControlID="RadNumericHour" Name="HourPerWeek" PropertyName="Value" />
                <asp:ControlParameter ControlID="RadNumericProducer" Name="Producer" PropertyName="Value" />
                <asp:ControlParameter ControlID="txtBenefits_vacations" Name="Benefits_vacations" PropertyName="Value" />
                <asp:ControlParameter ControlID="txtBenefits_personals" Name="Benefits_personals" PropertyName="Value" />
                <asp:ControlParameter ControlID="lblHourlyWageHistoryId" Name="HourlyWageHistoryLastId" PropertyName="Text" />
            </InsertParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceHourlyWageDetail" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            DeleteCommand="DELETE FROM [Employee_HourlyWageHistory] WHERE Id = @Id"
            SelectCommand="Employee_HourlyWageHistoryDetailsExt_SELECT" SelectCommandType="StoredProcedure"
            UpdateCommand="Employee_HourlyWageHistory_UPDATE" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="Id" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="lblYear" Name="Year" PropertyName="Text" />
                <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Date" />
                <asp:Parameter Name="DateEnd" />
                <asp:Parameter Name="Amount" />
                <asp:Parameter Name="HourPerWeek" />
                <asp:Parameter Name="Producer" />
                <asp:Parameter Name="Benefits_vacations" />
                <asp:Parameter Name="Benefits_personals" />
                <asp:Parameter Name="Id" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceChart" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="Employee_HourlyWageHistoryDetailsExt_SELECT" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="Year" DefaultValue="0" />
                <asp:ControlParameter ControlID="lblEmployeeId" Name="employeeId" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:Label ID="lblHourlyWageHistoryId" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblMonthUpdated" runat="server" Visible="False"></asp:Label>
    </form>

</body>
</html>
