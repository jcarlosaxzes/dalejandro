<%@ Page Title="Time Entries" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="time.aspx.vb" Inherits="pasconcept20.time" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"  EnableEmbeddedSkins="false" />

    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <script type="text/javascript">
            function PrintReport(sender, args) {
                var RadWindow = $find("<%=RadWindow1.ClientID%>");
                RadWindow.show();
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
        <Windows>
            <telerik:RadWindow ID="RadWindow1"
                VisibleOnPageLoad="false" Behaviors="Close, Move" Modal="true" Top="20" Left="100" Height="680px" Width="850px" runat="server" VisibleStatusbar="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">Time Entries</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>
            <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                           <i class="fas fa-user-clock"></i>&nbsp;Time
            </asp:LinkButton>
        </span>
    </div>
    <div class="collapse" id="collapseFilter">

        <asp:Panel ID="pnlFind" runat="server" class="pasconcept-bar" DefaultButton="btnRefresh">
            <table class="table-sm" style="width: 100%">
                <tr>
                    <td style="width: 180px">
                        <telerik:RadComboBox ID="cboPeriod" runat="server" Width="100%" MarkFirstMatch="True" DropDownAutoWidth="Enabled">
                            <Items>
                                <telerik:RadComboBoxItem Text="Last 30 days" Value="30" Selected="true" />
                                <telerik:RadComboBoxItem Text="Last 60 days" Value="60" />
                                <telerik:RadComboBoxItem Text="Last 90 days" Value="90" />
                                <telerik:RadComboBoxItem Text="Last 120 days" Value="120" />
                                <telerik:RadComboBoxItem Text="Last 180 days" Value="180" />
                                <telerik:RadComboBoxItem Text="Last 365 days" Value="365" />
                                <telerik:RadComboBoxItem Text="This year" Value="14" />
                                <telerik:RadComboBoxItem Text="This month" Value="16" />
                                <telerik:RadComboBoxItem Text="Last year" Value="15" />
                                <telerik:RadComboBoxItem Text="Last month" Value="17" />
                                <telerik:RadComboBoxItem Text="(All years...)" Value="13" />
                                <telerik:RadComboBoxItem Text="Custom Range..." Value="99" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 130px">
                        <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" DateFormat="MM/dd/yyyy" Culture="en-US" ToolTip="Date From for filter">
                        </telerik:RadDatePicker>
                    </td>
                    <td style="width: 130px">
                        <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" DateFormat="MM/dd/yyyy" Culture="en-US" ToolTip="Date To for Filter">
                        </telerik:RadDatePicker>
                    </td>
                    <td style="width: 450px">
                        <telerik:RadComboBox ID="cboJob" runat="server" DataSourceID="SqlDataSourceJobs"
                            DataTextField="Job" DataValueField="Id" Width="100%" MarkFirstMatch="True" Filter="Contains" Height="260px"
                            AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem Text="(All Jobs...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td colspan="2">
                        <telerik:RadComboBox ID="cboClient" runat="server" DataSourceID="SqlDataSourceClients"
                            DataTextField="Name" DataValueField="Id" Width="100%" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem Text="(All Clients...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <telerik:RadComboBox ID="cboDepartments" runat="server" AppendDataBoundItems="true" DataSourceID="SqlDataSourceDepartments" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" MarkFirstMatch="True" Width="100%">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Selected="true" Text="(All Departments...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>

                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboEmployee" runat="server" DataSourceID="SqlDataSourceEmployee" AppendDataBoundItems="true"
                            DataTextField="Name" DataValueField="Id" Width="100%" MarkFirstMatch="True" Filter="Contains" Height="300px">
                            <Items>
                                <telerik:RadComboBoxItem Text="(All Employee...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>

                    </td>
                    <td></td>
                    <td style="width: 150px; text-align: right">
                        <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>
                    </td>
                </tr>


            </table>
        </asp:Panel>

    </div>
    <telerik:RadWizard ID="RadWizard1" runat="server" DisplayCancelButton="false" RenderMode="Lightweight" Skin="Silk" DisplayNavigationButtons="false" DisplayProgressBar="false">
        <WizardSteps>
            
            <%--Productive Time--%>
            <telerik:RadWizardStep runat="server" ID="RadWizardStep1" Title="Productive Time" StepType="Step">
                <asp:Panel ID="PanelAssignedEmployees" runat="server" class="noprint">
                    <asp:Label ID="lblPanelAssignedEmployees" runat="server" Text="Job's Assigned Employees"></asp:Label>
                    <telerik:RadGrid ID="RadGridAssignedEmployees" runat="server" DataSourceID="SqlDataSourceAssignedEmployees" GridLines="None" AllowAutomaticInserts="true"
                        AllowAutomaticUpdates="True" CellSpacing="0" ShowFooter="true">
                        <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceAssignedEmployees">
                            <BatchEditingSettings EditType="Cell" />
                            <CommandItemSettings AddNewRecordText="New Employee" ShowRefreshButton="true" />
                            <Columns>
                                <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" HeaderText="ID" ReadOnly="True" SortExpression="Id" UniqueName="Id" Display="False">
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="employeeId" DataType="System.Int32" HeaderText="employeeId" SortExpression="employeeId" UniqueName="employeeId" Aggregate="Count" FooterAggregateFormatString="{0:N0}" >
                                    <ItemTemplate>
                                        <asp:Label ID="lbleEmployee" runat="server" Text='<%# Eval("Employee") %>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="cboeEmployee" runat="server" DataSourceID="SqlDataSourceEmployee" DataTextField="Name" DataValueField="Id"
                                            Width="350px" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="True">
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text="(Select Employee...)" Value="0" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="positionId" DataType="System.Int32" HeaderText="Position" SortExpression="positionId" UniqueName="positionId" HeaderStyle-Width="120px" >
                                    <ItemTemplate>
                                        <asp:Label ID="lbleposition" runat="server" Text='<%# Eval("Position") %>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="cboeposition" runat="server" DataSourceID="SqlDataSourcePosition" DataTextField="Name" DataValueField="Id"
                                            Width="100px" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="True">
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text="(Select Position...)" Value="0" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="Scope" HeaderText="Scope of Work" SortExpression="Scope" UniqueName="Scope" HeaderStyle-Width="120px" >
                                    <ItemTemplate>
                                        <asp:Label ID="lblScope" runat="server" Text='<%# Eval("Scope") %>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="txtScope" runat="server" Text='<%# Bind("Scope")%>' Width="100px" MaxLength="128">
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn Aggregate="Sum" DataField="Hours" FilterControlAltText="Filter Hours column" FooterAggregateFormatString="{0:N1}"
                                    FooterStyle-HorizontalAlign="Right" FooterStyle-Width="60px"  HeaderStyle-Width="70px" HeaderText="Estimared Hours" ItemStyle-HorizontalAlign="Right" SortExpression="Hours" UniqueName="Hours">
                                    <EditItemTemplate>
                                        <telerik:RadNumericTextBox ID="txteHours" runat="server" DbValue='<%# Bind("Hours")%>' Width="45px">
                                        </telerik:RadNumericTextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="HoursLabel_paym" runat="server" Text='<%# Eval("Hours", "{0:N1}") %>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="HoursWorked" HeaderText="Hours Worked" ReadOnly="True" SortExpression="HoursWorked" UniqueName="HoursWorked" DataFormatString="{0:N2}" FooterAggregateFormatString="{0:N2}"
                                    Aggregate="Sum" FooterStyle-HorizontalAlign="Right" FooterStyle-Width="80px"  HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="EstimatedTotal" HeaderText="Estimated Total" ReadOnly="True" SortExpression="EstimatedTotal" UniqueName="EstimatedTotal"
                                    DataFormatString="{0:C2}" FooterAggregateFormatString="{0:C2}"
                                    Aggregate="Sum" FooterStyle-HorizontalAlign="Right" FooterStyle-Width="70px"  HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Right">
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="PercentET" HeaderText="E.Total Used(%)" ReadOnly="True" SortExpression="PercentET" UniqueName="PercentET"
                                    FooterAggregateFormatString="{0:N1}"
                                    Aggregate="Sum" FooterStyle-HorizontalAlign="Right" FooterStyle-Width="70px"  HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPercentET" runat="server" Text='<%# Eval("PercentET", "{0:N1}") %>' ForeColor='<%# GetPercentETForeColor(Eval("PercentET"))%>' Font-Bold='<%# GetPercentETFontBold(Eval("PercentET"))%>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="BudgetUsed" HeaderText="Budget Used" ReadOnly="True" SortExpression="BudgetUsed" UniqueName="BudgetUsed"
                                    DataFormatString="{0:C2}" FooterAggregateFormatString="{0:C2}"
                                    Aggregate="Sum" FooterStyle-HorizontalAlign="Right" FooterStyle-Width="70px"  HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Right">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="PercentBU" HeaderText="Budget Used(%)" ReadOnly="True" SortExpression="PercentBU" UniqueName="PercentBU"
                                    DataFormatString="{0:N1}" FooterAggregateFormatString="{0:N1}"
                                    Aggregate="Sum" FooterStyle-HorizontalAlign="Right" FooterStyle-Width="70px"  HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Right">
                                </telerik:GridBoundColumn>
                            </Columns>
                            <EditFormSettings>
                                <EditColumn FilterControlAltText="Filter EditCommandColumn1 column" ButtonType="PushButton"
                                    UniqueName="EditCommandColumn1">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                    </telerik:RadGrid>
                </asp:Panel>
                <div style="padding-top: 10px">
                    <telerik:RadGrid ID="RadGrid1" runat="server" AllowAutomaticUpdates="True" AllowSorting="True" DataSourceID="SqlDataSource1"
                        GridLines="None" Width="100%" AutoGenerateColumns="False"
                        PageSize="50" AllowPaging="true"
                        Height="850px" RenderMode="Lightweight"
                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                        <ClientSettings Selecting-AllowRowSelect="true">
                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                        </ClientSettings>
                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1" ShowFooter="True" EditMode="PopUp">
                            <PagerStyle Mode="Slider" AlwaysVisible="false" />
                            <Columns>
                                <telerik:GridTemplateColumn AllowFiltering="False" DataField="nEmployee" HeaderText="Employee" ReadOnly="True"
                                    SortExpression="nEmployee" UniqueName="nEmployee" HeaderStyle-Width="150px" >
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" Text='<%# Eval("nEmployee")%>' ToolTip="Click to edit" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn AllowFiltering="False" DataField="JobNumber" HeaderText="Job" ReadOnly="True"
                                    SortExpression="JobNumber" UniqueName="JobNumber" HeaderStyle-Width="80px" >
                                </telerik:GridBoundColumn>
                                <telerik:GridDateTimeColumn DataField="Fecha" DataFormatString="{0:MM/dd/yy}" DataType="System.DateTime"
                                    HeaderText="D.Work" SortExpression="Fecha" UniqueName="Fecha" HeaderStyle-Width="80px"
                                    ItemStyle-HorizontalAlign="Right"  HeaderTooltip="Date of Work">
                                </telerik:GridDateTimeColumn>
                                <telerik:GridDateTimeColumn DataField="DateEntry" DataFormatString="{0:MM/dd/yy}"
                                    HeaderText="D.Entry" SortExpression="DateEntry" UniqueName="DateEntry"
                                    HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right"  HeaderTooltip="Date of Entry">
                                </telerik:GridDateTimeColumn>
                                <telerik:GridNumericColumn AllowFiltering="False" DataField="Time"
                                    HeaderText="Time" SortExpression="Time" UniqueName="Time" Aggregate="Sum"
                                    DataFormatString="{0:N1}" FooterAggregateFormatString="{0:N1}" HeaderStyle-Width="70px"
                                    ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right"  HeaderTooltip="Time (hrs)">
                                </telerik:GridNumericColumn>
                                <telerik:GridNumericColumn AllowFiltering="False" DataField="HourRate" ReadOnly="true"
                                    HeaderText="Hourly" SortExpression="HourRate" UniqueName="HourRate"
                                    DataFormatString="{0:N1}" HeaderStyle-Width="70px"
                                    ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right"  HeaderTooltip="Hourly Rate">
                                </telerik:GridNumericColumn>
                                <telerik:GridNumericColumn AllowFiltering="False" DataField="Cost" ReadOnly="true"
                                    HeaderText="Cost" SortExpression="Cost" UniqueName="Cost" Aggregate="Sum"
                                    DataFormatString="{0:N1}" FooterAggregateFormatString="{0:N1}" HeaderStyle-Width="70px"
                                    ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right"  HeaderTooltip="Cost ($)">
                                </telerik:GridNumericColumn>
                                <telerik:GridTemplateColumn DataField="categoryId" FilterControlAltText="Filter CategoryId column" HeaderStyle-Width="200px"
                                    HeaderText="Category" SortExpression="categoryId" UniqueName="categoryId" >
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="cboCategory" runat="server" DataSourceID="SqlDataSourceCategory" SelectedValue='<%# Bind("categoryId")%>'
                                            DataTextField="Name" DataValueField="Id" Width="600px" AppendDataBoundItems="true">
                                            <Items>
                                                <telerik:RadComboBoxItem Text="(Select Time Sheet Category...)" Value="0" />
                                            </Items>
                                        </telerik:RadComboBox>

                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="CategoryLabel" runat="server" Text='<%# Eval("Category")%>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn AllowFiltering="False" DataField="InvoiceNumber" HeaderText="Invoice" ReadOnly="True" HeaderTooltip="Create/Delete Invoice per record"
                                    SortExpression="InvoiceNumber" UniqueName="InvoiceNumber" HeaderStyle-Width="180px" >
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="btnNewInvoice" runat="server" CommandArgument='<%# Eval("Id")%>' ToolTip="Click to Insert Invoice (hr)"
                                                CommandName="NewHrInvoice" UseSubmitBehavior="false" Visible='<%#IIf(Eval("invoiceId") = 0, True, False) %>'>
                                                    <i class="far fa-plus"></i>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnDeleteInvoice" runat="server" CommandArgument='<%# Eval("invoiceId")%>' ToolTip="Click to delete Invoice (hr)"
                                                CommandName="DeleteHrInvoice" UseSubmitBehavior="false" Visible='<%#IIf(Eval("invoiceId") > 0, True, False) %>'>
                                                <i class="far fa-trash-alt"></i>
                                            </asp:LinkButton>
                                            <a href='<%# LocalAPI.GetSharedLink_URL(4, Eval("invoiceId"))%>' target="_blank" title="view invoice"><%# Eval("InvoiceNumber")%></a>
                                        </div>
                                        <div style="text-align: center">
                                            <%# Eval("TimeInvoice")%> <%#IIf(Eval("invoiceId") > 0, "  x  ", "") %> <%# Eval("RateInvoice")%>
                                        </div>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridNumericColumn AllowFiltering="False" DataField="Amount" ReadOnly="true"
                                    HeaderText="Amount" SortExpression="Amount" UniqueName="Amount" Aggregate="Sum"
                                    DataFormatString="{0:N2}" FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="70px"
                                    ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right" >
                                </telerik:GridNumericColumn>
                                <telerik:GridNumericColumn AllowFiltering="False" DataField="AmountDue" ReadOnly="true"
                                    HeaderText="A.Due" SortExpression="AmountDue" UniqueName="AmountDue" Aggregate="Sum"
                                    DataFormatString="{0:N2}" FooterAggregateFormatString="{0:N2}" HeaderStyle-Width="70px"
                                    ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right"  HeaderTooltip="Amount Due">
                                </telerik:GridNumericColumn>


                                <telerik:GridTemplateColumn DataField="Description" FilterControlAltText="Filter Description column"
                                    HeaderText="Description" SortExpression="Description" UniqueName="Description" >
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description")%>' Width="600px" MaxLength="512" Rows="3" TextMode="MultiLine">
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="DescriptionLabel" runat="server" Font-Size="X-Small" Text='<%# Eval("DescriptionCompuestaShort")%>' ToolTip='<%# Eval("DescriptionCompuesta")%>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <EditFormSettings>
                                <PopUpSettings Modal="true" Width="700px" />
                                <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                        <PagerStyle AlwaysVisible="false" />
                    </telerik:RadGrid>
                </div>
            </telerik:RadWizardStep>

            <%--Non-Productive Time--%>
            <telerik:RadWizardStep runat="server" ID="RadWizardStep2" Title="Non-Productive Time" StepType="Step">
                <telerik:RadGrid ID="RadGrid2" runat="server" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                    AutoGenerateColumns="False" DataSourceID="SqlDataSource2" PageSize="50" AllowPaging="true"
                    Height="850px" RenderMode="Lightweight"
                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" FooterStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                    <ClientSettings Selecting-AllowRowSelect="true">
                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                    </ClientSettings>
                    <PagerStyle Mode="Slider" AlwaysVisible="false" />
                    <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource2">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                HeaderText="" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                            </telerik:GridEditCommandColumn>
                            <telerik:GridBoundColumn AllowFiltering="False" DataField="nEmployee" HeaderText="Employee" ReadOnly="True"
                                SortExpression="nEmployee" UniqueName="nEmployee" HeaderStyle-Width="250px" >
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column" HeaderText="Category"
                                SortExpression="Name" UniqueName="Name" >
                                <EditItemTemplate>
                                    <div style="margin: 5px">
                                        <telerik:RadComboBox ID="cboType" runat="server" DataSourceID="SqlDataSourceType" DataTextField="Name" Width="100%"
                                            DataValueField="Id" AppendDataBoundItems="True" Height="300px" SelectedValue='<%# Bind("Type") %>'>
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text="(Select Category...)" Value="0"></telerik:RadComboBoxItem>
                                            </Items>
                                        </telerik:RadComboBox>
                                    </div>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <%# Eval("Name") %>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridBoundColumn DataField="DateFrom" DataType="System.DateTime" HeaderText="From"
                                SortExpression="DateFrom" UniqueName="DateFrom" DataFormatString="{0:d}" HeaderStyle-Width="100px"
                                ItemStyle-HorizontalAlign="Right" >
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DateTo" DataType="System.DateTime" HeaderText="To" SortExpression="DateTo" UniqueName="DateTo" DataFormatString="{0:d}" HeaderStyle-Width="100px"
                                ItemStyle-HorizontalAlign="Right">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Hours" HeaderText="Time" SortExpression="Hours" UniqueName="Hours"  ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Notes" HeaderText="Notes" SortExpression="Notes"
                                UniqueName="Notes"  ItemStyle-HorizontalAlign="Left">
                            </telerik:GridBoundColumn>
                            <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText="" HeaderStyle-Width="50px"
                                 ItemStyle-HorizontalAlign="Center">
                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" />
                            </telerik:GridButtonColumn>
                        </Columns>
                        <EditFormSettings>
                            <EditColumn ButtonType="PushButton" UniqueName="EditCommandColumn1">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                </telerik:RadGrid>

            </telerik:RadWizardStep>
        </WizardSteps>
    </telerik:RadWizard>


    <telerik:RadToolTip ID="RadToolTipConfirmInsert" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <table class="table table-bordered" style="width: 500px">
            <tr>
                <td colspan="2">
                    <h2 style="margin: 0; text-align: center; color: white; width: 500px">
                        <span class="navbar navbar-expand-md bg-dark text-white">
                            <asp:Label ID="lblActionMesage" runat="server"></asp:Label>
                        </span>
                    </h2>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; text-align: right">Time Worked:
                </td>
                <td>
                    <telerik:RadNumericTextBox ID="txtTimeSel" runat="server" MaxLength="3"
                        MinValue="0.1" ShowSpinButtons="True" ButtonsPosition="Right" ToolTip="Time in hours"
                        Value="1" Width="50px" MaxValue="999">
                        <NumberFormat DecimalDigits="1" />
                        <IncrementSettings Step="0.5" />
                    </telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; text-align: right">Rate:
                </td>
                <td>
                    <telerik:RadNumericTextBox ID="txtRate" runat="server"
                        Width="150px">
                        <NumberFormat DecimalDigits="2" />
                    </telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>
                <td>Notes:</td>
                <td>
                    <telerik:RadTextBox ID="txtTimeDescription" runat="server" TextMode="MultiLine" Width="100%" MaxLength="512" ValidationGroup="time_insert">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: center" colspan="2">
                    <asp:LinkButton ID="btnOk" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" Width="100px">
                                    <i class="fas fa-check"></i> Ok
                    </asp:LinkButton>

                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-secondary btn" CausesValidation="false" UseSubmitBehavior="false" Width="100px">
                                    Cancel
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>


    <telerik:RadToolTip ID="RadToolTipConfirmDelete" runat="server" Position="Center" RelativeTo="BrowserWindow" Modal="true" ManualClose="true" ShowEvent="FromCode">
        <table class="table table-bordered" style="width: 500px">
            <tr>
                <td colspan="2">
                    <h2 style="margin: 0; text-align: center; color: white; width: 500px">
                        <span class="navbar navbar-expand-md bg-dark text-white">
                            <asp:Label ID="lblActionMesage2" runat="server"></asp:Label>
                        </span>
                    </h2>
                </td>
            </tr>
            <tr>
                <td style="text-align: center" colspan="2">
                    <asp:LinkButton ID="btnOk2" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" Width="100px">
                                    <i class="fas fa-check"></i> Ok
                    </asp:LinkButton>

                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnCancel2" runat="server" CssClass="btn btn-secondary btn" CausesValidation="false" UseSubmitBehavior="false" Width="100px">
                                    Cancel
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </telerik:RadToolTip>


    <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, FullName as Name FROM Employees WHERE companyId=@companyId ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceJobs" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Code + '-' + Job AS Job FROM Jobs  WHERE companyId=@companyId ORDER BY Job DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    &nbsp;&nbsp;
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="TIMES4_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="TIME_UPDATE" UpdateCommandType="StoredProcedure"
        DeleteCommand="INVOICE_DELETE" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboEmployee" DefaultValue=" " Name="Empleado" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="DateFrom" PropertyName="SelectedDate" Type="DateTime" DefaultValue="" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="DateTo" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboJob" Name="Job" PropertyName="SelectedValue" DefaultValue="-1" />
            <asp:ControlParameter ControlID="cboClient" Name="Client" PropertyName="SelectedValue" DefaultValue="-1" />
            <asp:ControlParameter ControlID="cboDepartments" Name="Department" PropertyName="SelectedValue" DefaultValue="-1" />
            <asp:Parameter DefaultValue="-1" Name="CategoryId" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
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
            <asp:ControlParameter ControlID="lblInvoiceSelected" DefaultValue="" Name="Id" PropertyName="Text" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClients" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Client] As Name FROM [Clients]  WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="select year(open_date) as nYear from Jobs where companyId=@companyId group by year(open_date) order by year(open_date) desc">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceMes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [id], [Month] FROM [Months] ORDER BY [id]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceCategory" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Employees_time_categories] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM Employees_NonRegularHours WHERE (Id = @Id)"
        SelectCommand="Employees_NonRegularHours_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="Employees_NonRegularHours_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboEmployee" DefaultValue=" " Name="EmployeeId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="DateFrom" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="DateTo" PropertyName="SelectedDate" Type="DateTime" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="DateFrom" />
            <asp:Parameter Name="DateTo" />
            <asp:Parameter Name="Hours" />
            <asp:Parameter Name="Type" />
            <asp:Parameter Name="Notes" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceType" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="MiscellaneousType_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceAssignedEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Jobs_Employees_assigned_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="Jobs_Employees_assigned_INSERT" InsertCommandType="StoredProcedure"
        UpdateCommand="UPDATE [Jobs_Employees_assigned] SET  [employeeId] = @employeeId, [Scope] = @Scope, [positionId] = @positionId, [Hours] = @Hours WHERE [Id] = @Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboJob" Name="jobId" PropertyName="SelectedValue" DefaultValue="-1" />
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
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblInvoiceSelected" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblTimeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
</asp:Content>
