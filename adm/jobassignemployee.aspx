<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="jobassignemployee.aspx.vb" Inherits="pasconcept20.jobassignemployee" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Assign Employee</title>
    <%--Bootstrap reference begin--%>
    <link href="~/Content/bootstrap.css" rel="stylesheet" />
    <%--Bootstrap reference end--%>
    <link href="~/Content/pasconcept.min.css" rel="stylesheet" />

</head>
<body>
    <%--Bootstrap reference begin--%>
    <script src="../Scripts/jquery-1.9.1.js"></script>
    <script src="../Scripts/bootstrap.js"></script>
    <%--Bootstrap reference end--%>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" EnableCdn="true" runat="server">
        </telerik:RadScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="cboMulticolumnEmployee">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="cboMulticolumnEmployee" LoadingPanelID="RadAjaxLoadingPanel1" />
                        <telerik:AjaxUpdatedControl ControlID="cboPosition" />
                        <telerik:AjaxUpdatedControl ControlID="txtEmployeeHours" />
                        <telerik:AjaxUpdatedControl ControlID="txtHourlyRate" />
                        <telerik:AjaxUpdatedControl ControlID="gaugeUsedBudget" />
                        <telerik:AjaxUpdatedControl ControlID="sliderUsedBudget" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="cboDepartment">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="cboMulticolumnEmployee" LoadingPanelID="RadAjaxLoadingPanel1" />
                        <telerik:AjaxUpdatedControl ControlID="cboPosition" />
                        <telerik:AjaxUpdatedControl ControlID="txtEmployeeHours" />
                        <telerik:AjaxUpdatedControl ControlID="txtHourlyRate" />
                        <telerik:AjaxUpdatedControl ControlID="gaugeUsedBudget" />
                        <telerik:AjaxUpdatedControl ControlID="sliderUsedBudget" />
                    </UpdatedControls>
                </telerik:AjaxSetting>


                <telerik:AjaxSetting AjaxControlID="btnDefineEmployee">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="lblMsg" />
                        <telerik:AjaxUpdatedControl ControlID="cboMulticolumnEmployee" />
                        <telerik:AjaxUpdatedControl ControlID="cboPosition" />
                        <telerik:AjaxUpdatedControl ControlID="chkIsProjectManager" />
                        <telerik:AjaxUpdatedControl ControlID="gaugeUsedBudget" />
                        <telerik:AjaxUpdatedControl ControlID="sliderUsedBudget" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="sliderUsedBudget">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="gaugeUsedBudget" LoadingPanelID="RadAjaxLoadingPanel1" />
                        <telerik:AjaxUpdatedControl ControlID="txtEmployeeHours" />
                        <telerik:AjaxUpdatedControl ControlID="txtHourlyRate" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="txtHourlyRate">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="gaugeUsedBudget" LoadingPanelID="RadAjaxLoadingPanel1" />
                        <telerik:AjaxUpdatedControl ControlID="txtEmployeeHours" />
                        <telerik:AjaxUpdatedControl ControlID="sliderUsedBudget" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnPrivate">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="btnPrivate" LoadingPanelID="RadAjaxLoadingPanel1" />
                        <telerik:AjaxUpdatedControl ControlID="txtHourlyRate" />
                        <telerik:AjaxUpdatedControl ControlID="gaugeUsedBudget" />
                        <telerik:AjaxUpdatedControl ControlID="sliderUsedBudget" />
                    </UpdatedControls>
                </telerik:AjaxSetting>

            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"  EnableEmbeddedSkins="false" />

        <%-- <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
            <script type="text/javascript">
                function SetGaugeValue(sender, args) {
                    var Gauge = $find("<%=gaugeUsedBudget.ClientID%>");
                    Gauge.set_value(sender.get_value());
            }
            </script>
        </telerik:RadCodeBlock>--%>
        <div style="padding-left:25px; padding-right:25px">
            <br />

            <div class="pasconcept-bar">
                <span class="pasconcept-pagetitle">
                    <asp:Label ID="lblJobName" runat="server"></asp:Label></span>
                <span style="float: right; vertical-align: middle;">
                    <asp:LinkButton ID="btnPrivate" runat="server" ToolTip="Private/Public mode" Text="Private"
                        CssClass="btn btn-danger btn" UseSubmitBehavior="false">
                    </asp:LinkButton>
                </span>
            </div>



            <table class="table-sm" style="width: 100%">
                <tr>
                    <td style="width: 60%; vertical-align: top">
                        <table class="table-sm" style="width: 100%">
                            <tr>
                                <td style="width: 180px; text-align: right">Department:</td>
                                <td>
                                    <telerik:RadComboBox ID="cboDepartment" runat="server" AppendDataBoundItems="True" Width="100%" AutoPostBack="true" DataSourceID="SqlDataSourceDepartments"
                                        DataTextField="Name" DataValueField="Id">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(All Departments...)" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Employee:
                                </td>
                                <td>
                                    <telerik:RadMultiColumnComboBox ID="cboMulticolumnEmployee" runat="server" DataSourceID="SqlDataSourceEmpl_activos" DataTextField="Name" DataValueField="Id" AutoPostBack="true"
                                        Width="100%" DropDownWidth="700" MarkFirstMatch="True" Filter="Contains" AutoFilter="True"
                                        FilterFields="Name" Placeholder="(Select Employee...)">
                                        <ColumnsCollection>
                                            <telerik:MultiColumnComboBoxColumn Field="Name" Title="Code" />
                                            <telerik:MultiColumnComboBoxColumn Field="Experience" Title="Experience" Width="100px" />
                                            <telerik:MultiColumnComboBoxColumn Field="WorkLoad" Title="WorkLoad" Width="100px" />
                                            <telerik:MultiColumnComboBoxColumn Field="EfficiencyAsPM" Title="Eff.As PM" Width="100px" />
                                            <telerik:MultiColumnComboBoxColumn Field="EfficiencyAsTM" Title="Eff.As TM" Width="100px" />
                                        </ColumnsCollection>
                                    </telerik:RadMultiColumnComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Position in Job:</td>
                                <td>
                                    <telerik:RadComboBox ID="cboPosition" runat="server" AppendDataBoundItems="True" Width="100%" DataSourceID="SqlDataSourcePositions"
                                        DataTextField="Name" DataValueField="Id" AutoPostBack="true">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="(Select Position...)" Value="0" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Assign Time:
                                </td>
                                <td style="text-align: left">
                                    <table>
                                        <tr>
                                            <td style="width: 75px">
                                                <telerik:RadNumericTextBox ID="txtEmployeeHours" runat="server" MinValue="0" Value="0" Width="95px">
                                                    <NumberFormat DecimalDigits="0" />
                                                </telerik:RadNumericTextBox>

                                            </td>
                                            <td style="width: 75px">(hours)
                                            </td>
                                            <td style="text-align: right">
                                                <telerik:RadNumericTextBox ID="txtHourlyRate" runat="server" MaxLength="3" AutoPostBack="true"
                                                    MinValue="25" ShowSpinButtons="True" ButtonsPosition="Right" ToolTip="Hourly rate" Visible="false"
                                                    Value="25" Width="100px" MaxValue="999">
                                                    <NumberFormat DecimalDigits="0" />
                                                    <IncrementSettings Step="5" />
                                                </telerik:RadNumericTextBox>
                                            </td>
                                        </tr>
                                    </table>


                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Is Project Manager?:
                                </td>
                                <td>
                                    <telerik:RadCheckBox ID="chkIsProjectManager" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">Client Deadline:
                                </td>
                                <td style="color: red">
                                    <telerik:RadDatePicker ID="RadDatePickerDeadline" runat="server" Width="100%" ToolTip="Job Deadline" Enabled="false">
                                    </telerik:RadDatePicker>
                                </td>

                            </tr>
                        </table>

                    </td>

                    <td style="width: 7%"></td>
                    <td>
                        <h5 style="margin: 3px; text-align: center">Time Budget Risk </h5>
                        <telerik:RadRadialGauge runat="server" ID="gaugeUsedBudget" Width="100%" Height="130px"
                            ToolTip="This gauge sets the risk to assign employee time. We reccomend low risk in complex/expense jobs">
                            <Pointer Value="2.2">
                                <Cap Size="0.1" />
                            </Pointer>
                            <Scale Min="60" Max="90" MajorUnit="5">
                                <%--<Labels Format="{0}" />--%>
                                <Ranges>
                                    <telerik:GaugeRange Color="#8dcb2a" From="60" To="67" />
                                    <telerik:GaugeRange Color="#ffc700" From="67" To="75" />
                                    <telerik:GaugeRange Color="#ff7a00" From="75" To="82" />
                                    <telerik:GaugeRange Color="#c20000" From="82" To="90" />

                                </Ranges>
                            </Scale>
                        </telerik:RadRadialGauge>


                        <telerik:RadSlider RenderMode="Lightweight" runat="server" ID="sliderUsedBudget" Orientation="Horizontal" ShowDecreaseHandle="false"
                            LargeChange="10" SmallChange="5"
                            ShowIncreaseHandle="false" MinimumValue="60" AutoPostBack="true" ToolTip="This slide sets the risk to assign employee time. We reccomend low risk in complex/expense jobs"
                            MaximumValue="90" Width="95%">
                        </telerik:RadSlider>
                    </td>

                </tr>
            </table>

            <hr />

            <table class="table-sm" style="width: 100%">
                <tr>
                    <td style="text-align: right; padding-right: 10px;">
                        <asp:LinkButton ID="btnDefineEmployee" runat="server" ToolTip="Assign New Employee & Time" ValidationGroup="AssignEmployee"
                            CssClass="btn btn-success btn-lg" UseSubmitBehavior="false">
                                    <i class="fas fa-plus"></i> Assign Employee
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
            <div>
                <asp:ValidationSummary ID="vsClient" runat="server" ValidationGroup="AssignEmployee" ForeColor="Red"
                    HeaderText="<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>
                                        There were this errors:"></asp:ValidationSummary>
            </div>


            <div style="text-align: center;">
                <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>

            </div>
            <div>
                <asp:CompareValidator runat="server" ID="Comparevalidator2" ValueToCompare="(Select Position...)"
                    Operator="NotEqual" ControlToValidate="cboPosition" Text="*" ErrorMessage="Define Position" SetFocusOnError="true" ValidationGroup="AssignEmployee" Display="None"> </asp:CompareValidator>

            </div>

        </div>
        <asp:SqlDataSource ID="SqlDataSourceEmpl_activos" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="JobAssignEmployee_SELECT" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblJobId" Name="JobId" PropertyName="Text" />
                <asp:ControlParameter ControlID="cboDepartment" Name="deparmentId" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="SELECT Id, FullName as Name FROM Employees WHERE companyId=@companyId and isnull(Inactive,0)=0 ORDER BY Name">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourcePositions" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="SELECT [Id], [Name] FROM [Employees_Position] WHERE companyId=@companyId ORDER BY [Name]">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:Label ID="lblJobId" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblDptoId" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>


    </form>

</body>
</html>
