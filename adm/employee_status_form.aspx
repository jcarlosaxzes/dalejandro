<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="employee_status_form.aspx.vb" Inherits="pasconcept20.employee_status_form" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Status</title>
    <link href="~/Content/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" EnableCdn="true" runat="server">
        </telerik:RadScriptManager>

        <div class="container">
            <h3>
                <asp:Label ID="lblEmployeeName" runat="server"></asp:Label>
            </h3>
            <h4>With the change of status of an employee:
            </h4>
            <table class="table-sm" style="width: 100%">
                <tr>
                    <td colspan="2" style="padding-left: 15px">1.- PASconcept permissions is updated (Active - Permit,  Inactive - Deny )
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="padding-left: 15px">2.- Hourly Wage History is updated
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="padding-left: 15px">3.- The Total Productive Salary (<asp:Label ID="lblCurrentAnualPSalary" Font-Bold="true" runat="server"></asp:Label>) 
                        <asp:Label ID="lblNewAnualPSalary" Font-Bold="true" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="padding-left: 15px">4.- The Company Multiplier (<asp:Label ID="lblCurrentMultiplier" Font-Bold="true" runat="server"></asp:Label>) 
                <asp:Label ID="lblNewMultiplier" Font-Bold="true" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <hr style="margin: 0" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 180px; font-size: large">Current status:
                    </td>
                    <td>
                        <asp:Label ID="lblCurrentStatus" Font-Size="Large" Font-Bold="true" runat="server"></asp:Label>
                        <asp:Label ID="lblInactive_Date" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 180px; font-size: large">Effective Date:
                    </td>
                    <td>
                        <telerik:RadDatePicker ID="RadDatePicker1" runat="server" DateFormat="MM/dd/yyyy" Culture="en-US">
                        </telerik:RadDatePicker>
                    </td>
                </tr>
            </table>
            <asp:Panel runat="server" ID="panelActive">
                <table class="table-sm" style="width: 100%">
                    <tr>
                        <td style="width: 180px;">Hourly Rate ($/hour):
                        </td>
                        <td>
                            <telerik:RadNumericTextBox ID="txtHourlyRate" runat="server" MinValue="0" Width="160">
                                <NumberFormat DecimalDigits="2" />
                            </telerik:RadNumericTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Producer Rate (0 to 1):
                        </td>
                        <td>
                            <telerik:RadNumericTextBox ID="txtProducer" runat="server" MinValue="0" MaxValue="1" Width="160" ToolTip="0: Full Administrative, 1: Full Producer">
                                <NumberFormat DecimalDigits="2" />
                            </telerik:RadNumericTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Vacations(Hours):
                        </td>
                        <td>
                            <telerik:RadNumericTextBox ID="txtBenefits_vacations" runat="server" MinValue="0" Width="160">
                                <NumberFormat DecimalDigits="0" />
                            </telerik:RadNumericTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Personal/Sicks (Hours):
                        </td>
                        <td>
                            <telerik:RadNumericTextBox ID="txtBenefits_personals" runat="server" MinValue="0" Width="160">
                                <NumberFormat DecimalDigits="0" />
                            </telerik:RadNumericTextBox>
                        </td>
                    </tr>
                </table>
            </asp:Panel>

            <table class="table-sm" style="width: 100%">
                <tr>
                    <td style="padding-left: 50px">
                        <telerik:RadCheckBox runat="server" ID="chkConfirm" Text="I read the information and confirm that I will change the status"></telerik:RadCheckBox>
                    </td>
                    <td>
                        <asp:LinkButton ID="btnChangeStatus" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" Text="Set to Active Employee">
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>

            <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
                <p class="text-danger"><%: SuccessMessageText %></p>
            </asp:PlaceHolder>

        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            UpdateCommand="EMPLOYEE_Inactive_UPDATE" UpdateCommandType="StoredProcedure">
            <UpdateParameters>
                <asp:ControlParameter ControlID="lblNewInactive" Name="Inactive" PropertyName="Text" />
                <asp:ControlParameter ControlID="RadDatePicker1" Name="EffectiveDate" PropertyName="SelectedDate" Type="DateTime" />
                <asp:ControlParameter ControlID="txtHourlyRate" Name="HourlyRate" PropertyName="Value" />
                <asp:ControlParameter ControlID="txtProducer" Name="ProducerRate" PropertyName="Value" />
                <asp:ControlParameter ControlID="txtBenefits_vacations" Name="Benefits_vacations" PropertyName="Value" />
                <asp:ControlParameter ControlID="txtBenefits_personals" Name="Benefits_personals" PropertyName="Value" />
                <asp:ControlParameter ControlID="lblEmployeeId" Name="Id" PropertyName="Text" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:Label ID="lblEmployeeId" runat="server" Visible="False" Text="1"></asp:Label>
        <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblCurrentInactive" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblNewInactive" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    </form>

</body>
</html>
