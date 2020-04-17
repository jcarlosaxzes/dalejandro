<%@ Page Title="New Job" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="newjob.aspx.vb" Inherits="pasconcept20.newjob" %>

<%@ MasterType VirtualPath="~/ADM/BasicMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:Panel ID="InsertForm" runat="server">
        <table class="table-condensed" style="width: 95%; margin-top: 20px">
            <tr>
                <td style="text-align: right">Select Job Year:
                </td>
                <td>
                    <table style="width: 100%">
                        <tr>
                            <td style="width: 150px">
                                <telerik:RadDropDownList ID="cboYear" runat="server" DataSourceID="SqlDataSourceYear" DataTextField="nYear"
                                    DataValueField="Year" Width="100px" AutoPostBack="true" CausesValidation="false" UseSubmitBehavior="false">
                                </telerik:RadDropDownList>
                            </td>
                            <td style="text-align: right">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtCode" ValidationGroup="JobUpdate"
                                    Text="*" ErrorMessage="Define Job Number" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                Job Number:&nbsp;</td>
                            <td style="width: 150px">
                                <asp:Label ID="lblYear" runat="server" Font-Bold="true" Font-Size="Medium">
                                </asp:Label>
                                <telerik:RadTextBox ID="txtCode" runat="server" Width="80px" MaxLength="4" Font-Bold="true">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                    </table>

                </td>
            </tr>

            <tr>
                <td style="text-align: right">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtJob" ValidationGroup="JobUpdate"
                        Text="*" ErrorMessage="Define Job Name" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    Job Name:
                </td>
                <td>
                    <telerik:RadTextBox ID="txtJob" runat="server" Width="100%" MaxLength="80">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Template:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboProposalType" runat="server" DataSourceID="SqlDataSourceProposalType" DataTextField="Name"
                        DataValueField="Id" Width="100%" AppendDataBoundItems="True" MarkFirstMatch="True" Filter="Contains" Height="300px">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select Template...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">
                    <asp:CompareValidator runat="server" ID="Comparevalidator1" ValueToCompare="(Select Job Type...)"
                        Operator="NotEqual" ControlToValidate="cboType" ErrorMessage="Define Job Type" Text="*" SetFocusOnError="true" ValidationGroup="JobUpdate"> </asp:CompareValidator>
                    Type:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboType" runat="server" DataSourceID="SqlDataSource8" DataTextField="Name"
                        DataValueField="Id" Width="100%" AppendDataBoundItems="True" MarkFirstMatch="True" Filter="Contains" Height="300px">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select Job Type...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">
                    <asp:CompareValidator runat="server" ID="Comparevalidator2" ValueToCompare="(Select Client...)"
                        Operator="NotEqual" ControlToValidate="cboCliente" Text="*" ErrorMessage="Define Client" SetFocusOnError="true" ValidationGroup="JobUpdate"> </asp:CompareValidator>
                    Client:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboCliente" runat="server" DataSourceID="SqlDataSourceClientes"
                        DataTextField="Name" DataValueField="Id" Width="100%" AppendDataBoundItems="True" Height="300px"
                        MarkFirstMatch="True" Filter="Contains">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select Client...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Owner Name:</td>
                <td>
                    <telerik:RadTextBox ID="txtOwnerName" runat="server" Width="100%" MaxLength="80">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Assigned Employee:
                </td>
                <td>
                    <telerik:RadComboBox ID="cboEmployee" runat="server"
                        DataSourceID="SqlDataSourceEmployee" DataTextField="Name" DataValueField="Id"
                        Width="100%" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="True">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select Employee...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">A/E of Record:</td>
                <td>
                    <telerik:RadComboBox ID="cboEngRecord" runat="server"
                        DataSourceID="SqlDataSourceEmployee" DataTextField="Name" DataValueField="Id"
                        Width="100%" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="True">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select  A/E of Record...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Location:</td>
                <td>
                    <telerik:RadTextBox ID="txtProjectLocation" runat="server" Width="100%" MaxLength="80">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Unit:</td>
                <td>
                    <table style="width: 100%">
                        <tr>
                            <td style="width: 150px">
                                <telerik:RadNumericTextBox ID="txtUnit" runat="server" Width="100%">
                                </telerik:RadNumericTextBox>
                            </td>
                            <td style="text-align: right">Measure:&nbsp;</td>
                            <td style="width: 150px">
                                <telerik:RadComboBox ID="cboMeasure" runat="server" DataSourceID="SqlDataSourceMeasure" DataTextField="Name" DataValueField="Id" Width="100%" AppendDataBoundItems="True">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(Not defined...)" Value="0" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Construction Cost:</td>
                <td style="text-align: left">
                    <table style="width: 100%">
                        <tr>
                            <td style="width: 150px">
                                <telerik:RadNumericTextBox ID="txtCost" runat="server" Width="100%">
                                </telerik:RadNumericTextBox>
                            </td>
                            <td style="text-align: right">Budget:&nbsp;</td>
                            <td style="width: 150px">
                                <telerik:RadNumericTextBox ID="txtBudgest" runat="server" Width="100%">
                                </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Opening Date:
                </td>
                <td>
                    <table style="width: 100%">
                        <tr>
                            <td style="width: 150px">
                                <telerik:RadDatePicker ID="RadDatePicker1" runat="server" Width="100%">
                                </telerik:RadDatePicker>
                            </td>
                            <td style="text-align: right">Signed Date:&nbsp;</td>
                            <td style="width: 150px">
                                <telerik:RadDatePicker ID="RadDatePickerSigned" runat="server" Width="100%" ToolTip="Signed Date">
                                </telerik:RadDatePicker>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>

                <td style="text-align: right">
                    <asp:Label ID="lblJobStatus" runat="server" Text="Job Status:"></asp:Label>
                </td>
                <td>
                    <table style="width: 100%">
                        <tr>
                            <td style="width: 150px">
                                <telerik:RadComboBox ID="cboStatus" runat="server" DataSourceID="SqlDataSourceJobStatus" DataTextField="Name" DataValueField="Id" Width="100%">
                                </telerik:RadComboBox>
                            </td>
                            <td style="text-align: right">Deadline:&nbsp;</td>
                            <td style="width: 150px">
                                <telerik:RadDatePicker ID="RadDatePickerDeadline" runat="server" Width="100%" ToolTip="Job Deadline">
                                </telerik:RadDatePicker>
                            </td>
                        </tr>
                    </table>
                </td>

            </tr>
            <tr>
                <td></td>
                <td style="text-align: right; padding-right: 50px; padding-top: 15px">
                    <asp:LinkButton ID="btnCreateJob" runat="server" CssClass="btn btn-primary btn-lg" UseSubmitBehavior="false" ValidationGroup="JobUpdate">
                       <span class="glyphicon glyphicon-plus"></span>&nbsp;Job
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="FinalPanel" runat="server" Visible="false">
        <div class="thumbnail">
            <h2 style="margin-top: 100px; margin-bottom: 30px; text-align: center">
                <asp:Label ID="lblCreatedJobTitle" runat="server">
                </asp:Label>
            </h2>
            <div style="text-align: center; font-size: large" class="alert alert-success" role="alert">has been successfully created!!!</div>

        </div>
    </asp:Panel>



    <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, FullName as Name FROM Employees WHERE (companyId=@companyId) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>



    <asp:SqlDataSource ID="SqlDataSourceAssignedEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="Jobs_Employees_assigned_DELETE" DeleteCommandType="StoredProcedure"
        SelectCommand="Jobs_Employees_assigned_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="Jobs_Employees_assigned_INSERT" InsertCommandType="StoredProcedure"
        UpdateCommand="UPDATE [Jobs_Employees_assigned] SET  [employeeId] = @employeeId, [Scope] = @Scope, [positionId] = @positionId, [Hours] = @Hours WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblId" Name="jobId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblId" Name="jobId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="employeeId" Type="Int32" />
            <asp:Parameter Name="positionId" Type="Int32" />
            <asp:Parameter Name="Scope" Type="String" />
            <asp:Parameter Name="Hours" Type="Double" />
            <asp:Parameter Name="HourRate" Type="Double" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="employeeId" Type="Int32" />
            <asp:Parameter Name="positionId" Type="Int32" />
            <asp:Parameter Name="Scope" Type="String" />
            <asp:Parameter Name="Hours" Type="Double" />
            <asp:Parameter Name="HourRate" Type="Double" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClientes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name]+' [' + isnull(Company,'...') + ']' As Name FROM Clients WHERE companyId=@companyId ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Jobs_types WHERE companyId=@companyId ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePaymentMethod" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Payment_methods ORDER BY Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePayments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [Invoices_payments] WHERE [Id] = @Id"
        SelectCommand="SELECT Invoices_payments.Id, dbo.InvoiceNumber(Invoices_payments.InvoiceId) AS InvoiceNumber, Invoices_payments.InvoiceId, Invoices_payments.Method, Invoices_payments.CollectedDate, Invoices_payments.CollectedNotes, Invoices_payments.Amount, Invoices.Id AS InvoiceNumber, Payment_methods.Name AS PaymentMethodName FROM Invoices_payments INNER JOIN Invoices ON Invoices_payments.InvoiceId = Invoices.Id LEFT OUTER JOIN Payment_methods ON Invoices_payments.Method = Payment_methods.Id WHERE (Invoices.JobId = @Job) ORDER BY Invoices_payments.CollectedDate, Invoices_payments.Id, Invoices_payments.InvoiceId"
        InsertCommand="INVOICE_PAYMENTS2_INSERT" InsertCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblInvoiceId" Name="InvoiceId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="RadDatePickerPayment" Name="CollectedDate" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboPaymentMethod_paym" Name="Method" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtAmountPayment" Name="Amount" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtPaymentNotes" Name="CollectedNotes" PropertyName="Text" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblId" DefaultValue="0" Name="Job" PropertyName="Text"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>



    <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Employees] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceType" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Appointments_types] ORDER BY [Id]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceJobStatus" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Jobs_status] ORDER BY [OrderBy]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProjectSector" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Jobs_sectors ORDER BY Name"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProjectUse" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Jobs_uses ORDER BY Name"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Year], nYear FROM Years ORDER BY [Year] DESC"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSubconsultant" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM [SubConsultans] WHERE (companyId = @companyId) ORDER BY Name">
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
    <asp:SqlDataSource ID="SqlDataSourceJobDates" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="select Id, Open_date, SignedDate, StartDay, EndDay, Done_Date, AcceptedDate=(select top 1 AceptedDate from Proposal where JobId=Jobs.Id)  from jobs  WHERE Id = @Job">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblId" DefaultValue="0" Name="Job" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceMeasure" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Jobs_measures ORDER BY Id"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceProposalType" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Proposal_types WHERE (companyId = @companyId) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId"
                PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceCategory" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Employees_time_categories] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSourcePosition" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Select Id, Name from Employees_Position where companyId=@companyId Order By Name">
        <SelectParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>





    <asp:SqlDataSource ID="SqlDataSourceCity" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM PlanReview_Cities ORDER BY Name"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM PlanReview_Departments ORDER BY Name"></asp:SqlDataSource>

    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeName" runat="server" Visible="False"></asp:Label>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblReturn" runat="server" Text="lblReturn" Visible="False"></asp:Label>
    <asp:Label ID="lblId" runat="server" Text="-1" Visible="False"></asp:Label>
    <asp:Label ID="lblInvoiceId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblPaymentId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblRFPId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblJobCode" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblLocation" runat="server" Visible="False"></asp:Label>
    <telerik:RadTextBox ID="txtProjectArea" runat="server" Visible="false"></telerik:RadTextBox>


</asp:Content>


