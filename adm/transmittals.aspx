<%@ Page Title="Transmittals" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="transmittals.aspx.vb" Inherits="pasconcept20.transmittals" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadDatePickerFrom"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadDatePickerTo"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cboMes">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadDatePickerFrom"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadDatePickerTo"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnNew">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>
    <table class="table-sm" style="width: 100%;">
        <tr>
            <td class="PanelFilter">
                <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnRefresh">
                    <table width="100%" class="table-sm pasconcept-bar" >
                        <tr>
                            <td width="100px" align="right" >Date:
                            </td>
                            <td width="110px" align="left" >
                                <telerik:RadComboBox ID="cboYear" runat="server" DataSourceID="SqlDataSourceYear" DataTextField="nYear"
                                    DataValueField="Year" Width="100%" AppendDataBoundItems="True">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(All Years...)" Value="0" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td width="140px" align="left" >
                                <telerik:RadComboBox ID="cboMes" runat="server" DataSourceID="SqlDataSourceMes"
                                    DataTextField="Month" DataValueField="id" Width="100%">
                                </telerik:RadComboBox>
                            </td>
                            <td width="100px" align="right" >Employee:
                            </td>
                            <td width="350px">
                                <telerik:RadComboBox ID="cboEmployee" runat="server" DataSourceID="SqlDataSourceEmpl"
                                    Width="100%" DataTextField="Name" DataValueField="Id"
                                    MarkFirstMatch="True" Filter="Contains"
                                    Height="300px" AppendDataBoundItems="true">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(All Employees...)" Value="-1" Selected="true" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td align="right" >Status:
                            </td>
                            <td align="left"  colspan="2">
                                <telerik:RadComboBox ID="cboStatus" runat="server" DataSourceID="SqlDataSourceTrasmittalStatus" DataTextField="Name" DataValueField="Id" Width="100%" AppendDataBoundItems="true">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(All Status...)" Value="1000" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td width="100px" align="right" >Client:
                            </td>
                            <td style="text-align: left" >
                                <telerik:RadComboBox ID="cboClients" runat="server" DataSourceID="SqlDataSourceClient"
                                    Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains"
                                    Height="300px" AppendDataBoundItems="true">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="(All Clients...)" Value="-1" Selected="true" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td align="right"  valign="top">Find:</td>
                            <td align="left"  colspan="4">
                                <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" Text=""
                                    EmptyMessage="Additional search for Transmittal Number, Job Code & Name, Received By, Notes, Client Name, Company... "
                                    LabelWidth="" Width="100%">
                                </telerik:RadTextBox>
                            </td>
                            <td>
                                <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Search
                                </asp:LinkButton>

                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>
    <table class="table-sm pasconcept-bar">
        <tr>
            <td>
                <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                            <i class="fas fa-plus"></i>&nbsp;Transmittal
                </asp:LinkButton>
            </td>
            <td>
                <script type="text/javascript">
                    function PrintPage(sender, args) {
                        window.print();
                    }
                </script>
                <telerik:RadButton ID="printbutton" OnClientClicked="PrintPage" Text="Print" runat="server" AutoPostBack="false" UseSubmitBehavior="false">
                    <Icon PrimaryIconCssClass=" rbPrint"></Icon>
                </telerik:RadButton>
            </td>
            <td>
                <span class="pasconcept-pagetitle" style="padding-left: 50px">Transmittals</span>
            </td>
        </tr>
    </table>

    <div>
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
            <script type="text/javascript">
                function OnClientClose(sender, args) {
                    var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                    masterTable.rebind();
                }
            </script>
        </telerik:RadCodeBlock>
        <telerik:RadGrid ID="RadGrid1" runat="server" AllowSorting="True" GroupingEnabled="false" AutoGenerateColumns="False" DataSourceID="SqlDataSourceTransmittals" Width="100%"
            AllowAutomaticInserts="True" AllowAutomaticDeletes="true" AllowPaging="True" PageSize="250" Height="1000px" HeaderStyle-Font-Size="X-Small"
            ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
            <ClientSettings>
                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
            </ClientSettings>
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceTransmittals" ShowFooter="True" EditMode="PopUp">
                <PagerStyle Mode="Slider" AlwaysVisible="false"></PagerStyle>
                <Columns>
                    <telerik:GridTemplateColumn DataField="TransmittalID" Groupable="False" HeaderText="Transmittal ID"
                        SortExpression="TransmittalID" UniqueName="TransmittalID" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px"
                        FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}" ReadOnly="true">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEditTransmittal" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to View/Edit Transmittal"
                                CommandName="EditTransmittal" Text='<%# Eval("TransmittalID")%>'>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="JobName" HeaderText="Job Name" SortExpression="JobName" UniqueName="JobName" HeaderStyle-HorizontalAlign="Center" ReadOnly="true">
                        <ItemTemplate>
                            <asp:Label ID="JobNameLabel" runat="server" Text='<%# Eval("JobName")%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="ClientCode" HeaderText="Client Code" SortExpression="ClientCode" UniqueName="ClientCode"
                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" ReadOnly="true">
                        <ItemTemplate>
                            <asp:Label ID="ClientCodeLabel" runat="server" Text='<%# Eval("ClientCode")%>' ></asp:Label>
                            <telerik:RadToolTip ID="RadToolTipContact" runat="server" TargetControlID="ClientCodeLabel" RelativeTo="Element"
                                Position="BottomCenter" RenderInPageRoot="true" Modal="True" Title='<%# LocalAPI.GetClientProperty(Eval("ClientId"), "Name")%>' ShowEvent="OnClick"
                                HideDelay="300" HideEvent="LeaveTargetAndToolTip" IgnoreAltAttribute="true">
                                <table>
                                    <tr>
                                        <td colspan="2">
                                            <b><%# LocalAPI.GetClientProperty(Eval("ClientId"), "Company")%></b>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 60px">Phone:
                                        </td>
                                        <td>
                                            <telerik:RadMaskedTextBox ID="PhoneTextBox" runat="server" ReadOnly="true"
                                                Text='<%# LocalAPI.GetClientProperty(Eval("ClientId"), "Phone")%>' Mask="(###) ###-####" BorderStyle="None" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Cellular:
                                        </td>
                                        <td>
                                            <telerik:RadMaskedTextBox ID="RadMaskedTextBox1" runat="server" ReadOnly="true"
                                                Text='<%# LocalAPI.GetClientProperty(Eval("ClientId"), "Cellular")%>' Mask="(###) ###-####" BorderStyle="None" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Email:
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="EmailText" runat="server" ReadOnly="true"
                                                Text='<%# LocalAPI.GetClientProperty(Eval("ClientId"), "Email")%>'>
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                </table>
                            </telerik:RadToolTip>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="TransmittalDate" DataFormatString="{0:MM/dd}" DataType="System.DateTime" ReadOnly="true"
                        HeaderText="Date Opened" SortExpression="TransmittalDate" UniqueName="TransmittalDate" HeaderStyle-Width="70px"
                        ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ReadyDate" DataFormatString="{0:MM/dd}" DataType="System.DateTime" ReadOnly="true"
                        HeaderText="Ready Date" SortExpression="ReadyDate" UniqueName="ReadyDate" HeaderStyle-Width="70px"
                        ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PickUpDate" DataFormatString="{0:MM/dd}" DataType="System.DateTime" ReadOnly="true"
                        HeaderText="Pick-Up Date" SortExpression="PickUpDate" UniqueName="PickUpDate" HeaderStyle-Width="80px"
                        ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="nStatus" HeaderText="Status" SortExpression="nStatus" ReadOnly="true"
                        UniqueName="nStatus" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="true" HeaderStyle-Width="140px">
                        <ItemTemplate>
                            <asp:Label ID="nStatusLabel" runat="server" Text='<%# Eval("nStatus")%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="Budget" DataFormatString="{0:N0}"
                        DataType="System.Decimal" Groupable="False" HeaderText="Budget" SortExpression="Budget" ReadOnly="true"
                        UniqueName="Budget" ItemStyle-HorizontalAlign="Right"
                        FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:N0}"
                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="AmountPending" DataFormatString="{0:N0}"
                        Groupable="False" HeaderText="Amount Pending" ReadOnly="True"
                        SortExpression="AmountPending" UniqueName="AmountPending" ItemStyle-HorizontalAlign="Right"
                        FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:N0}"
                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="RecordBy" HeaderText="A/E Record" ReadOnly="true"
                        SortExpression="RecordBy" UniqueName="RecordBy" HeaderStyle-Width="60px"
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="RecordByLabel" runat="server" Text='<%# Eval("RecordBy_Code")%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="column" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <table style="width: 100%">
                                <tr>
                                    <td style="width: 50%; text-align: center">
                                        <a href='<%# LocalAPI.GetSharedLink_URL(6, Eval("Id"))%>' target="_blank" title="View Transmittal Private Client Page">
                                            <i class="far fa-share-square"></i></a>
                                        </a>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:LinkButton ID="btnSendEmail" runat="server" CommandName="Email" CommandArgument='<%# Eval("Id")%>' ToolTip="Send Email to Client with Ready For Pick Up Notification"
                                            UseSubmitBehavior="false" Enabled='<%# LocalAPI.IsTransmittalReadyToSigned(Eval("Id"))%>'>
                                                                <i class="far fa-envelope"></i>
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center" Width="30px"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                        CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText="Delete"
                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings CaptionFormatString="Add New Transmittal" PopUpSettings-Width="700px" EditFormType="Template">
                    <EditColumn ButtonType="PushButton">
                    </EditColumn>
                    <FormTemplate>
                        <table class="table-sm" style="width: 650px">
                            <tr>
                                <td style="padding-top: 30px">Job status should be: <b>Done</b>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">
                                    <telerik:RadComboBox ID="cboJobs" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceJob"
                                        DataTextField="Code" DataValueField="Id" SelectedValue='<%# Bind("JobId")%>'
                                        Width="100%" MarkFirstMatch="True" Filter="Contains" Height="400px" Label="Select Related Job:">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Selected="True" Text="(Select Active Job...)" Value="-1" />
                                        </Items>
                                    </telerik:RadComboBox>

                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right; padding-top: 20px; padding-bottom: 10px; width: 100%">
                                    <asp:LinkButton ID="btnInsert" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CommandName="PerformInsert">
                                                <i class="fas fa-plus"></i>&nbsp;Insert
                                    </asp:LinkButton>
                                    &nbsp;&nbsp;&nbsp;
                                            <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-secondary" UseSubmitBehavior="false" CausesValidation="False" CommandName="Cancel">
                                                <i class="fas fa-plus"></i>&nbsp;Cancel
                                            </asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </FormTemplate>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="SqlDataSourceTransmittals" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Transmittals2_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="Transmittal_INSERT" InsertCommandType="StoredProcedure"
        DeleteCommand="DELETE FROM Transmittals WHERE Id=@Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="JobId" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="TransmittalId_OUT" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="DateFrom" PropertyName="SelectedDate" Type="DateTime" DefaultValue="" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="DateTo" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboEmployee" Name="Employee" PropertyName="SelectedValue" Type="Int32" DefaultValue="-1" />
            <asp:ControlParameter ControlID="cboClients" Name="Client" PropertyName="SelectedValue" Type="Int32" DefaultValue="-1" />
            <asp:ControlParameter ControlID="cboStatus" Name="Status" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Filter" PropertyName="Text" Type="String" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceMes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [id], [Month] FROM [Months] ORDER BY [id]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Year], nYear FROM Years ORDER BY [Year] DESC"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTrasmittalStatus" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Transmittals_status] ORDER BY [Id]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceJob" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, '('+cast((select count(*) from Transmittals where JobId=Jobs.id) as nvarchar(4)) + ') '+ Code+'  '+Job AS Code FROM Jobs WHERE (companyId = @companyId) AND ISNULL(Status,0)=7 ORDER by Jobs.Id DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Client] As Name FROM [Clients]  WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmpl" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, FullName as Name FROM Employees WHERE companyId=@companyId ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Text="0" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeName" runat="server" Visible="False"></asp:Label>
    <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" DateFormat="MM/dd/yyyy" Width="120px" Culture="en-US" Visible="false">
    </telerik:RadDatePicker>
    <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" DateFormat="MM/dd/yyyy" Width="120px" Culture="en-US" Visible="false">
    </telerik:RadDatePicker>

</asp:Content>

