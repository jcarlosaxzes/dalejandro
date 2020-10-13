<%@ Page Title="Permit Tracker" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="revisions.aspx.vb" Inherits="pasconcept20.revisions" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Permit Tracker</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>
        </span>

    </div>
    <div class="collapse" id="collapseFilter">
        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnRefresh">
            <table class="table-sm pasconcept-bar" style="width: 100%">
                <tr>
                    <td style="width: 150px; text-align: right">Period:
                    </td>
                    <td style="width: 200px;">
                        <telerik:RadComboBox ID="cboPeriod" runat="server" Width="100%" AppendDataBoundItems="True" MarkFirstMatch="True">
                            <Items>
                                <telerik:RadComboBoxItem Text="Last 30 days" Value="30" />
                                <telerik:RadComboBoxItem Text="Last 60 days" Value="60" />
                                <telerik:RadComboBoxItem Text="Last 90 days" Value="90" />
                                <telerik:RadComboBoxItem Text="Last 120 days" Value="120" />
                                <telerik:RadComboBoxItem Text="Last 180 days" Value="180" />
                                <telerik:RadComboBoxItem Text="Last 365 days" Value="365" />
                                <telerik:RadComboBoxItem Text="(This year...)" Value="14" />
                                <telerik:RadComboBoxItem Text="(Last year...)" Value="15" />
                                <telerik:RadComboBoxItem Text="(All years...)" Value="13" Selected="true" />
                                <telerik:RadComboBoxItem Text="Custom Range..." Value="99" />
                            </Items>
                        </telerik:RadComboBox>

                    </td>
                    <td style="width: 280px;">
                        <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" DateFormat="MM/dd/yyyy" Width="130px" Culture="en-US">
                        </telerik:RadDatePicker>
                        <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" DateFormat="MM/dd/yyyy" Width="130px" Culture="en-US">
                        </telerik:RadDatePicker>

                    </td>
                    <td style="width: 150px; text-align: right">Status:
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboStatus" runat="server" DataSourceID="SqlDataSourcePlanReview_status" DataTextField="Name" DataValueField="Id" Width="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Status...)" Value="1000" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td style="text-align: right">Client:
                    </td>
                    <td colspan="2">
                        <telerik:RadComboBox ID="cboClients" runat="server" DataSourceID="SqlDataSourceClient"
                            Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains"
                            Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Clients...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="text-align: right">Search:
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" Text=""
                            EmptyMessage="Additional search for Reference, Job Code & Name, City, Departemnt... "
                            LabelWidth="" Width="100%">
                        </telerik:RadTextBox>
                    </td>
                    <td style="width: 150px; text-align: right">
                        <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>

                    </td>
                </tr>
            </table>
        </asp:Panel>

    </div>

    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1"
        AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowAutomaticInserts="true" ShowFooter="True" Width="100%" HeaderStyle-HorizontalAlign="Center"
        ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" FooterStyle-Font-Size="Small" FooterStyle-Font-Bold="true">
        <MasterTableView AutoGenerateColumns="False" CommandItemDisplay="None" DataKeyNames="Id" DataSourceID="SqlDataSource1"
            HeaderStyle-Font-Size="Small">
            <Columns>
                <telerik:GridTemplateColumn DataField="Code" HeaderStyle-Width="120px" HeaderText="Reference" SortExpression="Code" UniqueName="Code">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEditReviews" runat="server" UseSubmitBehavior="false" ToolTip="Edit Revision" CommandName="Edit">
                                            <%# Eval("Code") %>
                        </asp:LinkButton>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadTextBox ID="txtEditCode2" runat="server" Text='<%# Bind("Code") %>' Width="150px" MaxLength="32">
                        </telerik:RadTextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Required" ForeColor="Red" ControlToValidate="txtEditCode2"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="JobName" ReadOnly="true" HeaderText="Job" SortExpression="JobName" UniqueName="JobName">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn DataField="url" HeaderStyle-Width="150px" HeaderText="URL" SortExpression="url" UniqueName="url">
                    <ItemTemplate>
                        <a href="<%# Eval("url") %>" style='<%# IIf(len(Eval("url")) = 0,"display:none","display:normal")%>' target="_blank">Revision URL</a>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadTextBox ID="txturl2" runat="server" Text='<%# Bind("url") %>' Width="800px" MaxLength="128">
                        </telerik:RadTextBox>
                    </EditItemTemplate>

                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="City" HeaderStyle-Width="180px" HeaderText="City/County" SortExpression="City" UniqueName="City">
                    <ItemTemplate>
                        <%# Eval("City") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadTextBox ID="txtCity" runat="server" Text='<%# Bind("City") %>' Width="800px" MaxLength="80">
                        </telerik:RadTextBox>
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="Department" HeaderStyle-Width="180px" HeaderText="Department" SortExpression="Department" UniqueName="Department">
                    <ItemTemplate>
                        <%# Eval("Department") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadTextBox ID="txtDepartment" runat="server" Text='<%# Bind("Department") %>' Width="800px" MaxLength="80">
                        </telerik:RadTextBox>
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="DateSubmit" HeaderStyle-Width="100px" HeaderText="Submitted" SortExpression="DateSubmit" UniqueName="DateSubmit">
                    <ItemTemplate>
                        <%# Eval("DateSubmit", "{0:d}") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadDatePicker ID="RadDatePickerReviewSubmit" runat="server"
                            DbSelectedDate='<%# Bind("DateSubmit") %>'>
                        </telerik:RadDatePicker>
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="statusId" HeaderStyle-Width="180px" HeaderText="Status" SortExpression="Status" UniqueName="statusId" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <div style="font-size: 12px; width: 100%" class='<%# LocalAPI.GetRevisionsStatusLabelCSS(Eval("StatusId")) %>'>
                            <%# Eval("Status") %>
                        </div>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="cboPlanReview_status2" runat="server" DataSourceID="SqlDataSourcePlanReview_status"
                            DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("statusId") %>' Width="400px">
                        </telerik:RadComboBox>
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="DateOut" HeaderStyle-Width="100px" HeaderText="Closed" SortExpression="DateOut" UniqueName="DateOut">
                    <ItemTemplate>
                        <%# Eval("DateOut", "{0:d}") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadDatePicker ID="RadDatePickerReviewDateOut" runat="server" DbSelectedDate='<%# Bind("DateOut") %>'>
                        </telerik:RadDatePicker>
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn DataField="contactId" FilterControlAltText="Filter Reviewer column"
                    HeaderText="Reviewed by" SortExpression="Reviewer" UniqueName="contactId">
                    <ItemTemplate>
                        <%# Eval("Reviewer") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="cboReviewer2" runat="server" DataSourceID="SqlDataSourceReviewer" DataTextField="Name" DataValueField="Id"
                            Filter="Contains" MarkFirstMatch="True" Width="400px"
                            SelectedValue='<%# Bind("contactId") %>' AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(Select Reviewer...)" Value="0" />
                            </Items>
                        </telerik:RadComboBox>
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn DataField="Notes" FilterControlAltText="Filter Notes column" Display="false"
                    HeaderText="Notes" SortExpression="Notes" UniqueName="Notes">
                    <ItemTemplate>
                        <%# Eval("Notes") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadTextBox ID="txtCityNotes2" runat="server" Text='<%# Bind("Notes") %>' Width="800px" Height="64px" Rows="3" TextMode="MultiLine">
                        </telerik:RadTextBox>
                    </EditItemTemplate>

                </telerik:GridTemplateColumn>
                <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?"
                    ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                    UniqueName="DeleteColumn" HeaderText=""
                    ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                </telerik:GridButtonColumn>
            </Columns>
            <EditFormSettings>
                <EditColumn ButtonType="PushButton" UniqueName="EditCommandColumn1">
                </EditColumn>
            </EditFormSettings>
        </MasterTableView>
    </telerik:RadGrid>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM Jobs_PlanReview_and_Permits WHERE Id=@Id"
        SelectCommand="PlanReview_and_Permits_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="Jobs_PlanReview_and_Permits_UPDATE" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="DateFrom" PropertyName="SelectedDate" Type="DateTime" DefaultValue="" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="DateTo" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboClients" Name="Client" PropertyName="SelectedValue" Type="Int32" DefaultValue="-1" />
            <asp:ControlParameter ControlID="cboStatus" Name="StatusId" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Filter" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="Code" Type="String" />
            <asp:Parameter Name="url" Type="String" />
            <asp:Parameter Name="City" Type="String" />
            <asp:Parameter Name="Department" Type="String" />
            <asp:Parameter Name="DateSubmit" Type="DateTime" />
            <asp:Parameter Name="DateOut" Type="DateTime" />
            <asp:Parameter Name="statusId" Type="Int16" />
            <asp:Parameter Name="Notes" Type="String" />
            <asp:Parameter Name="contactId" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePlanReview_status" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [PlanReview_status]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Client] As Name FROM [Clients]  WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceReviewer" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Contacts] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Text="0" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>



</asp:Content>
