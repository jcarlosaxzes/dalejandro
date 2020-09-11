<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterJOB.Master" CodeBehind="job_employees.aspx.vb" Inherits="pasconcept20.job_employees" %>

<%@ MasterType VirtualPath="~/ADM/MasterJOB.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function OnClientClose(sender, args) {
                var masterTable = $find("<%= RadGridAssignedEmployees.ClientID%>").get_masterTableView();
                masterTable.rebind();
            }
        </script>
    </telerik:RadCodeBlock>
    <div class="container">

        <div class="pasconcept-bar">
            <span class="pasconcept-pagetitle">Assigned Employees</span>
            <span style="float: right; vertical-align: middle;">
                <asp:LinkButton ID="btnSetEmployee" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Assin Employees">
                        Add Employee
                </asp:LinkButton>
                <asp:LinkButton ID="btnPrivate" runat="server" ToolTip="Private/Public mode" Text="Public Mode"
                    CssClass="btn btn-danger btn" UseSubmitBehavior="false">
                </asp:LinkButton>
            </span>
        </div>
        <div style="padding-top: 10px">
            <telerik:RadGrid ID="RadGridAssignedEmployees" runat="server" DataSourceID="SqlDataSourceAssignedEmployees"
                AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" ShowFooter="true" HeaderStyle-HorizontalAlign="Center"
                ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" FooterStyle-Font-Size="Small" FooterStyle-Font-Bold="true">
                <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceAssignedEmployees" EditMode="EditForms">
                    <Columns>
                        <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" HeaderText="ID" ReadOnly="True" SortExpression="Id" UniqueName="Id" Display="False">
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn HeaderStyle-Width="25px" HeaderText="" ItemStyle-HorizontalAlign="Center" UniqueName="AddTime">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton14" runat="server" UseSubmitBehavior="false" CommandName="AddTime" CommandArgument='<%# Eval("employeeId")%>' ToolTip="Add Time">
                                    <i class="fas fa-user-clock"></i>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn DataField="employeeId" DataType="System.Int32" HeaderText="Employee" SortExpression="employeeId" UniqueName="employeeId" Aggregate="Count"
                            FooterAggregateFormatString="{0:N0}" ReadOnly="true">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEditEmployee" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Click to Edit Record"
                                    CommandName="Edit" UseSubmitBehavior="false">
                                            <%#Eval("Employee")%> 
                                </asp:LinkButton>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn UniqueName="Position" HeaderText="Position" DataField="Position">
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn DataField="HourRate" HeaderStyle-Width="120px" HeaderText="Hourly Rate" ItemStyle-HorizontalAlign="Center" SortExpression="HourRate" UniqueName="HourRate">
                            <ItemTemplate>
                                <%# Eval("HourRate", "{0:N2}") %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn DataField="Scope" HeaderText="Scope of Work" SortExpression="Scope" UniqueName="Scope">
                        </telerik:GridBoundColumn>
                        <telerik:GridNumericColumn Aggregate="Sum" DataField="Hours" HeaderText="Hours" UniqueName="Freight" HeaderTooltip="Assigned Hours"
                            HeaderStyle-Width="110px" FooterStyle-Font-Bold="true" DataFormatString="{0:N1}" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center">
                        </telerik:GridNumericColumn>
                        <telerik:GridBoundColumn DataField="HoursWorked" HeaderText="H. Worked" ReadOnly="True" SortExpression="HoursWorked" UniqueName="HoursWorked"
                            DataFormatString="{0:N1}" FooterAggregateFormatString="{0:N1}" FooterStyle-Font-Bold="true" HeaderTooltip="Hours Worked"
                            Aggregate="Sum" FooterStyle-HorizontalAlign="Center" HeaderStyle-Width="110px" ItemStyle-HorizontalAlign="Center">
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn DataField="PercentET" HeaderText="H. Used(%)" ReadOnly="True" SortExpression="PercentET" UniqueName="PercentET"
                            FooterAggregateFormatString="{0:N1}"
                            Aggregate="Avg" FooterStyle-HorizontalAlign="Center" HeaderStyle-Width="110px" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label ID="lblPercentET" runat="server" Text='<%# Eval("PercentET", "{0:N1}") %>' ForeColor='<%# GetPercentETForeColor(Eval("PercentET"))%>' Font-Bold='<%# GetPercentETFontBold(Eval("PercentET"))%>'>
                                </asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn DataField="BudgetUsed" HeaderText="Budget Used" ReadOnly="True" SortExpression="BudgetUsed" UniqueName="BudgetUsed"
                            DataFormatString="{0:C2}" FooterAggregateFormatString="{0:C2}"
                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right" FooterStyle-Width="120px" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="FTE" HeaderText="FTE(%)" ReadOnly="True" SortExpression="FTE" UniqueName="FTE" Display="false"
                            DataFormatString="{0:N1}" FooterAggregateFormatString="{0:N1}"
                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right" FooterStyle-Width="120px" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Right">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="PercentBU" HeaderText="Budget Used(%)" ReadOnly="True" SortExpression="PercentBU" UniqueName="PercentBU"
                            DataFormatString="{0:N1}" FooterAggregateFormatString="{0:N1}"
                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right" FooterStyle-Width="130px" HeaderStyle-Width="130px" ItemStyle-HorizontalAlign="Right">
                        </telerik:GridBoundColumn>
                        <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="To delete row, H.Worked must be '0'. Delete this row?"
                            ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                            UniqueName="DeleteColumn" HeaderText=""
                            ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                        </telerik:GridButtonColumn>
                    </Columns>
                    <EditFormSettings CaptionFormatString="Edit Assigned Employee" EditFormType="Template" FormStyle-Width="600px">
                        <FormTemplate>
                            <br />
                            <table style="width: 100%; font-size: small">
                                <tr>
                                    <td style="width: 100px; text-align: right">Position:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cboPosition" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourcePosition"
                                            DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("positionId")%>'
                                            Width="100%" MarkFirstMatch="True" Filter="Contains" Height="400px">
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Selected="True" Text="(Select Position...)" Value="0" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Hours:
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="RadNumericTextBox1" runat="server" Width="200px" DbValue='<%# Bind("Hours")%>'>
                                        </telerik:RadNumericTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Hourly Rate:
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="txtRate" runat="server" Width="200px" DbValue='<%# Bind("HourRate")%>'>
                                        </telerik:RadNumericTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Scope:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txtScope" runat="server" Width="100%" Text='<%# Bind("Scope") %>' MaxLength="128">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: center" colspan="2">
                                        <br />
                                        <asp:LinkButton ID="btnInsert" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CommandName="Update">
                                                Update
                                        </asp:LinkButton>
                                        &nbsp;&nbsp;&nbsp;
                                           
                                        <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-secondary" UseSubmitBehavior="false" CausesValidation="False" CommandName="Cancel">
                                                Cancel
                                            </asp:LinkButton>

                                    </td>
                                </tr>
                            </table>
                            <br />
                        </FormTemplate>
                    </EditFormSettings>
                </MasterTableView>
            </telerik:RadGrid>
        </div>

    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <asp:SqlDataSource ID="SqlDataSourceAssignedEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="Jobs_Employees_assigned_DELETE" DeleteCommandType="StoredProcedure"
        SelectCommand="Jobs_Employees_assigned_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="Jobs_Employees_v20_assigned_UPDATE" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="positionId" Type="Int32" />
            <asp:Parameter Name="Scope" Type="String" />
            <asp:Parameter Name="Hours" Type="Double" />
            <asp:Parameter Name="HourRate" Type="Double" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePosition" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Select Id, Name=Name + ' $ ' + cast(HourRate as nvarchar(20)) from Employees_Position where companyId=@companyId Order By Name">
        <SelectParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblJobId" runat="server" Visible="false" Text="0"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
