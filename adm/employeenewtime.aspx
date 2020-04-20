<%@ Page Title="Employee New Time" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/BasicMasterPage.Master" CodeBehind="employeenewtime.aspx.vb" Inherits="pasconcept20.employeenewtime" %>
<%@ MasterType VirtualPath="~/ADM/BasicMasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table>
        <tr>
            <td style="width: 220px"></td>
            <td>
                <div class="TBL_FORM">
                    <table class="table-condensed TBL_FORM" style="width: 100%">
                        <tr>
                            <td style="width: 130px; text-align: center;">
                                <asp:Image ID="Image7" runat="server" ImageUrl="~/App_Themes/Estandar/reloj.png" />
                            </td>
                            <td style="text-align: left;">Enter time (in hours) and date that work was performed.
                                <br />
                                Click "<b>Add New Time</b>" to complete.
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>

    <div>
        <h3><asp:Label ID="lblJobName" runat="server"></asp:Label></h3>
    </div>
    <div>
        <table class="table-condensed" style="width: 100%">
            <tr>
                <td style="width: 220px; ">
                </td>
                <td style="width: 80px; text-align: center; vertical-align: bottom">
                    <b>(Hours)</b>
                </td>
                <td style="width: 80px; text-align: center; vertical-align: bottom">
                    <b>This Week</b>
                </td>
                <td style="width: 80px; text-align: center; vertical-align: bottom">
                    <b>Last Weeks</b>
                </td>
                <td></td>
            </tr>
            <tr>
                <td style="text-align: center">Time Worked (in hours 0.25-24):
                </td>
                <td style="text-align: left; width: 400px">
                    <telerik:RadNumericTextBox ID="txtTimeSel" runat="server"
                        MinValue="0.25" ShowSpinButtons="True" ButtonsPosition="Right" ToolTip="Time in hours"
                        Value="1" Width="155px" MaxValue="24">
                        <NumberFormat DecimalDigits="2" />
                        <IncrementSettings Step="1" />
                    </telerik:RadNumericTextBox>
                </td>
                <td style="text-align: right">
                    <span class="label label-default">Submitted:</span>
                </td>
                <td style="text-align: center">
                    <asp:Label ID="lblTotalWeekHours" runat="server"></asp:Label>
                </td>
                <td style="text-align: center">
                    <asp:Label ID="lblTotalBiWeekHours" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Date of Work:
                </td>
                <td style="text-align: left; width: 400px">
                    <telerik:RadDatePicker ID="RadDatePicker1" runat="server" DateFormat="MM/dd/yyyy" Culture="en-US">
                    </telerik:RadDatePicker>
                </td>
                <td style="text-align: right">
                    <span class="label label-warning">Remaining:</span>

                </td>
                <td style="text-align: center">
                    <asp:Label ID="lblRemaining" runat="server"></asp:Label>


                </td>
                <td style="text-align: center">
                    <asp:Label ID="lblRemaining2Week" runat="server"></asp:Label>
                </td>
                
            </tr>
        </table>
        <div id="divProposalTask" runat="server">
            <table class="table-condensed" style="width: 100%">
                <tr>
                    <td style="text-align: right; width: 220px">Proposal Task:
                    </td>
                    <td style="text-align: left">
                        <telerik:RadComboBox ID="cboTask" runat="server" DataSourceID="SqlDataSourceProposalTask" Width="400px" Sort="Descending"
                            DataTextField="Description" DataValueField="Id" CausesValidation="false">
                        </telerik:RadComboBox>
                    </td>
                </tr>
            </table>
        </div>
        <div id="divTickets" runat="server">
            <table class="table-condensed" style="width: 100%">
                <tr>
                    <td style="text-align: right; width: 220px">Ticket:
                    </td>
                    <td style="text-align: left">
                        <telerik:RadComboBox ID="cboActiveTickets" runat="server" DataSourceID="SqlDataSourceActiveTickets" Width="400px" AutoPostBack="true"
                            DataTextField="Title" DataValueField="Id" CausesValidation="false" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem Text="(Select Ticket...)" Value="0" />
                            </Items>

                        </telerik:RadComboBox>
                    </td>
                </tr>
            </table>
        </div>
        <table class="table-condensed" style="width: 100%">
            <tr>
                <td style="text-align: right; width: 220px">Category:
                </td>
                <td style="text-align: left">
                    <telerik:RadComboBox ID="cboCategory" runat="server" DataSourceID="SqlDataSourceCategory" ValidationGroup="time_insert"
                        DataTextField="Name" DataValueField="Id" Width="400px" AppendDataBoundItems="true" CausesValidation="false">
                        <Items>
                            <telerik:RadComboBoxItem Text="(Select Time Sheet Category...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Notes:
                </td>
                <td style="text-align: left">
                    <telerik:RadTextBox ID="txtDescription" runat="server" Width="100%" MaxLength="512" Rows="3" TextMode="MultiLine" ValidationGroup="time_insert">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Set Job Status (optional):</td>
                <td style="text-align: left">

                    <asp:RadioButton runat="server" ID="opcDone" GroupName="status" Text="&nbsp;Done" ToolTip="Set Job to Done status"></asp:RadioButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:RadioButton runat="server" ID="opcHold" GroupName="status" Text="&nbsp;On Hold" ToolTip="Set Job to On Hold status"></asp:RadioButton>
                </td>
            </tr>

            <tr>
                <td colspan="2">

                    <asp:LinkButton ID="btnInsertTime" runat="server" CssClass="btn btn-info btn-lg" UseSubmitBehavior="false" ValidationGroup="time_insert" Width="200px">
                        <span class="glyphicon glyphicon-plus"></span> Time
                    </asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;
                <asp:LinkButton ID="btnInsertTimeAndInvoice" runat="server" CssClass="btn btn-success btn-lg" UseSubmitBehavior="false" ValidationGroup="time_insert" Width="200px">
                        <span class="glyphicon glyphicon-usd"></span> Billable Time
                </asp:LinkButton>
                </td>
            </tr>
        </table>
    </div>
    <div style="text-align: left">
        <h3>Last Time Records of this Job</h3>
        <telerik:RadGrid ID="RadGridTimes" runat="server" AllowAutomaticUpdates="True" AllowAutomaticDeletes="true" AllowSorting="True" DataSourceID="SqlDataSourceTimes"
            Width="100%" AutoGenerateColumns="False" AllowPaging="True" PageSize="100" Height="500px" 
            HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
            <ClientSettings>
                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
            </ClientSettings>
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceTimes" ShowFooter="True">
                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                <Columns>
                    <telerik:GridTemplateColumn AllowFiltering="False" DataField="Id" HeaderText="Time ID" ReadOnly="True"
                        SortExpression="Id" UniqueName="Id" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkDetailId" runat="server" CommandName="Edit" CommandArgument='<%# Eval("Id") %>' UseSubmitBehavior="false"
                                Text='<%# Eval("Id")%>' ToolTip="Click to Edit detail"></asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridDateTimeColumn DataField="Fecha" DataType="System.DateTime" DataFormatString="{0:d}"
                        HeaderText="Date of Work" SortExpression="Fecha" UniqueName="Fecha" HeaderStyle-Width="120px"
                        ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridDateTimeColumn>
                    <telerik:GridDateTimeColumn DataField="DateEntry" DataFormatString="{0:d}" Display="false"
                        HeaderText="Date of Entry" SortExpression="DateEntry" UniqueName="DateEntry"
                        HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridDateTimeColumn>
                    <telerik:GridNumericColumn AllowFiltering="False" DataField="Time"
                        HeaderText="Time (hrs)" SortExpression="Time" UniqueName="Time" Aggregate="Sum"
                        DataFormatString="{0:N1}" FooterAggregateFormatString="{0:N1}" HeaderStyle-Width="100px"
                        ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridNumericColumn>
                    <telerik:GridTemplateColumn DataField="categoryId" FilterControlAltText="Filter CategoryId column" Display="false"
                        HeaderText="Category" SortExpression="categoryId" UniqueName="categoryId" HeaderStyle-HorizontalAlign="Center">
                        <EditItemTemplate>
                            <telerik:RadComboBox ID="cboCategory" runat="server" DataSourceID="SqlDataSourceCategory" SelectedValue='<%# Bind("categoryId")%>'
                                DataTextField="Name" DataValueField="Id" Width="300px" AppendDataBoundItems="true">
                                <Items>
                                    <telerik:RadComboBoxItem Text="(Select Time Sheet Category...)" Value="0" />
                                </Items>
                            </telerik:RadComboBox>

                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="CategoryLabel" runat="server" Text='<%# Eval("Category")%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="Description" FilterControlAltText="Filter Description column"
                        HeaderText="Description" SortExpression="Description" UniqueName="Description" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description")%>' Width="600px" MaxLength="512" Rows="3" TextMode="MultiLine">
                            </telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <%# Eval("DescriptionCompuesta")%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                        CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText=""
                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="60px" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings>
                    <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                    </EditColumn>
                </EditFormSettings>
            </MasterTableView>
            <PagerStyle AlwaysVisible="false" />
        </telerik:RadGrid>
    </div>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDescription" ErrorMessage="(*) Notes can not be empty"
        ValidationGroup="time_insert">
    </asp:RequiredFieldValidator>
    <asp:CompareValidator runat="server" ID="Comparevalidator1" ValueToCompare="(Select Time Sheet Category...)"
        Operator="NotEqual" ControlToValidate="cboCategory" ErrorMessage="(*) You must select Category!" ValidationGroup="time_insert">
    </asp:CompareValidator>


    <asp:SqlDataSource ID="SqlDataSourceProposalTask" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="ProposalTaskNewTime_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblSelectedJob" Name="JobId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceCategory" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Employees_time_categories] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceTimes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="TIMES15days_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="TIME_UPDATE" UpdateCommandType="StoredProcedure"
        DeleteCommand="DELETE FROM Employees_time WHERE (Id = @Id)">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblEmployeeId" DefaultValue=" " Name="EmployeeId" PropertyName="Text" />
            <asp:ControlParameter ControlID="lblSelectedJob" DefaultValue=" " Name="JobId" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Fecha" Type="DateTime" />
            <asp:Parameter Name="DateEntry" Type="DateTime" />
            <asp:Parameter Name="Time" />
            <asp:Parameter Name="categoryId" />
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="Id" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceActiveTickets" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Job_ActiveTickets_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblSelectedJob" Name="JobId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedJob" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectedTicket" runat="server" Visible="False" Text="0"></asp:Label>

</asp:Content>
