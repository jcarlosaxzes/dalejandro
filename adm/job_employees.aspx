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
        <div class="row">
            <div class="form-group">
                <asp:LinkButton ID="btnSetEmployee" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Assin Employees">
                                    <span class="glyphicon glyphicon-plus"></span>&nbsp;Employees
                </asp:LinkButton>
            </div>
        </div>
        <div class="row">
            <div class="form-group">
                <telerik:RadGrid ID="RadGridAssignedEmployees" runat="server" DataSourceID="SqlDataSourceAssignedEmployees" GridLines="None"
                    AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" CellSpacing="0" ShowFooter="true">
                    <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceAssignedEmployees">
                        <Columns>
                            <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" HeaderText="ID" ReadOnly="True" SortExpression="Id" UniqueName="Id" Display="False">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="employeeId" DataType="System.Int32" HeaderText="Employee" SortExpression="employeeId" UniqueName="employeeId" Aggregate="Count"
                                FooterAggregateFormatString="{0:N0}" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" ReadOnly="true">
                                <ItemTemplate>
                                        <asp:LinkButton ID="btnEditEmployee" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Click to Edit Record"
                                            CommandName="Edit" UseSubmitBehavior="false">
                                            <%#Eval("Employee")%> 
                                        </asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridDropDownColumn UniqueName="positionId" ListTextField="Name" ListValueField="Id" DataSourceID="SqlDataSourcePosition" HeaderText="Position"
                                DataField="positionId" DropDownControlType="RadComboBox" AllowSorting="true">
                            </telerik:GridDropDownColumn>
                            <telerik:GridBoundColumn DataField="Scope" HeaderText="Scope of Work" SortExpression="Scope" UniqueName="Scope"
                                HeaderStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>
                            <telerik:GridNumericColumn Aggregate="Sum" DataField="Hours" HeaderText="Est. Hours" UniqueName="Freight" HeaderTooltip="Estimared Hours"
                                HeaderStyle-Width="80px" FooterStyle-Font-Bold="true" DataFormatString="{0:N1}" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center">
                            </telerik:GridNumericColumn>
                            <telerik:GridBoundColumn DataField="HoursWorked" HeaderText="H. Worked" ReadOnly="True" SortExpression="HoursWorked" UniqueName="HoursWorked"
                                DataFormatString="{0:N1}" FooterAggregateFormatString="{0:N1}" FooterStyle-Font-Bold="true" HeaderTooltip="Hours Worked"
                                Aggregate="Sum" FooterStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center">
                            </telerik:GridBoundColumn>

<%--                            <telerik:GridTemplateColumn DataField="HourRate" FilterControlAltText="Filter HourRate column" FooterAggregateFormatString="{0:N2}" ReadOnly="true"
                                HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" HeaderText="Hour Rate" ItemStyle-HorizontalAlign="Right" SortExpression="HourRate" UniqueName="HourRate">
                                <ItemTemplate>
                                    <asp:Label ID="HourRateLabel_paym" runat="server" Text='<%# Eval("HourRate", "{0:N2}") %>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="EstimatedTotal" HeaderText="Estimated Total" ReadOnly="True" SortExpression="EstimatedTotal" UniqueName="EstimatedTotal"
                                DataFormatString="{0:C2}" FooterAggregateFormatString="{0:C2}"
                                Aggregate="Sum" FooterStyle-HorizontalAlign="Right" FooterStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right">
                            </telerik:GridBoundColumn>--%>
                            <telerik:GridTemplateColumn DataField="PercentET" HeaderText="E.Total Used(%)" ReadOnly="True" SortExpression="PercentET" UniqueName="PercentET"
                                FooterAggregateFormatString="{0:N1}"
                                Aggregate="Avg" FooterStyle-HorizontalAlign="Right" FooterStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <asp:Label ID="lblPercentET" runat="server" Text='<%# Eval("PercentET", "{0:N1}") %>' ForeColor='<%# GetPercentETForeColor(Eval("PercentET"))%>' Font-Bold='<%# GetPercentETFontBold(Eval("PercentET"))%>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="BudgetUsed" HeaderText="Budget Used" ReadOnly="True" SortExpression="BudgetUsed" UniqueName="BudgetUsed"
                                DataFormatString="{0:C2}" FooterAggregateFormatString="{0:C2}"
                                Aggregate="Sum" FooterStyle-HorizontalAlign="Right" FooterStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FTE" HeaderText="FTE(%)" ReadOnly="True" SortExpression="FTE" UniqueName="FTE"
                                DataFormatString="{0:N1}" FooterAggregateFormatString="{0:N1}"
                                Aggregate="Sum" FooterStyle-HorizontalAlign="Right" FooterStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PercentBU" HeaderText="Budget Used(%)" ReadOnly="True" SortExpression="PercentBU" UniqueName="PercentBU"
                                DataFormatString="{0:N1}" FooterAggregateFormatString="{0:N1}"
                                Aggregate="Sum" FooterStyle-HorizontalAlign="Right" FooterStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right">
                            </telerik:GridBoundColumn>
                            <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="To delete row, H.Worked must be '0'. Delete this row?"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                UniqueName="DeleteColumn" HeaderText="Delete" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                            </telerik:GridButtonColumn>
                        </Columns>
                        <EditFormSettings>
                            <EditColumn FilterControlAltText="Filter EditCommandColumn1 column" ButtonType="PushButton"
                                UniqueName="EditCommandColumn1">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>

        </div>
    </div>
    <br />
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <asp:SqlDataSource ID="SqlDataSourceAssignedEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="Jobs_Employees_assigned_DELETE" DeleteCommandType="StoredProcedure"
        SelectCommand="Jobs_Employees_assigned_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="Jobs_Employees_assigned_INSERT" InsertCommandType="StoredProcedure"
        UpdateCommand="UPDATE [Jobs_Employees_assigned] SET  [Scope] = @Scope, [positionId] = @positionId, [Hours] = @Hours WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" Type="Int32" />
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
    <asp:SqlDataSource ID="SqlDataSourcePosition" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Select Id, Name from Employees_Position where companyId=@companyId Order By Name">
        <SelectParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:Label ID="lblJobId" runat="server" Visible="false" Text="0"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
