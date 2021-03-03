<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterJOB.Master" CodeBehind="job_reviews.aspx.vb" Inherits="pasconcept20.job_reviews" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/MasterJOB.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="container">

        <div class="pasconcept-bar">
            <span class="pasconcept-pagetitle">Revisions/Permits</span>
            <span style="float: right; vertical-align: middle;">
                <asp:LinkButton ID="btnNewReview" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" ToolTip="Assin Employees">
                        Add Revision
                </asp:LinkButton>
            </span>
        </div>

        <table class="table-sm" style="width: 100%">
            <tr>
                <td>
                    <asp:Panel runat="server" ID="PanelNo16Type">
                        <telerik:RadGrid ID="RadGridReviewsPermits" runat="server" DataSourceID="SqlDataSourceReviewsPermits"
                            AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowAutomaticInserts="true" ShowFooter="True" Width="100%" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" FooterStyle-Font-Size="Small" FooterStyle-Font-Bold="true">
                            <MasterTableView AutoGenerateColumns="False" CommandItemDisplay="None" DataKeyNames="Id" DataSourceID="SqlDataSourceReviewsPermits"
                                HeaderStyle-Font-Size="Small">
                                <Columns>
                                    <telerik:GridTemplateColumn DataField="Code" FilterControlAltText="Filter Code column"
                                        HeaderStyle-Width="120px" HeaderText="Reference" SortExpression="Code" UniqueName="Code">
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
                                    <telerik:GridTemplateColumn DataField="DateSubmit" HeaderStyle-Width="100px" FilterControlAltText="Filter DateSubmit column" HeaderText="Submitted" SortExpression="DateSubmit" UniqueName="DateSubmit">
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
                                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn ButtonType="PushButton" FilterControlAltText="Filter EditCommandColumn1 column" UniqueName="EditCommandColumn1">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                        </telerik:RadGrid>

                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel runat="server" ID="Panel16Type">

                        <asp:LinkButton ID="btnAddAppName" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="false">
                                                                     Add Application
                        </asp:LinkButton>

                        <div style="padding-top: 10px; padding-bottom: 10px">
                            <telerik:RadGrid ID="RadGridAppName" runat="server" DataSourceID="SqlDataSourceAppName" AllowAutomaticInserts="true"
                                AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" ShowFooter="True" Width="100%" ZIndex="50000">
                                <MasterTableView AutoGenerateColumns="False" CommandItemDisplay="None" DataKeyNames="Id" DataSourceID="SqlDataSourceAppName">
                                    <Columns>
                                        <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column"
                                            HeaderStyle-HorizontalAlign="Center" HeaderText=" Application Name" SortExpression="Name" UniqueName="Name">
                                            <ItemTemplate>

                                                <asp:LinkButton ID="btnEditApp" runat="server" UseSubmitBehavior="false" ToolTip="Edit App Name" CommandName="Edit">
                                            <%# Eval("Name") %>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox ID="txtName" runat="server" Text='<%# Bind("Name") %>' Width="100%" MaxLength="32">
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?"
                                            ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                            UniqueName="DeleteColumn" HeaderText="Delete" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                                        </telerik:GridButtonColumn>
                                    </Columns>
                                    <EditFormSettings>
                                        <EditColumn ButtonType="PushButton" FilterControlAltText="Filter EditCommandColumn1 column" UniqueName="EditCommandColumn1">
                                        </EditColumn>
                                    </EditFormSettings>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>

                        <asp:LinkButton ID="btnAddModule" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="false">
                                                                     Add Module
                        </asp:LinkButton>

                        <div style="padding-top: 10px">
                            <telerik:RadGrid ID="RadGridLocationModule" runat="server" DataSourceID="SqlDataSourceLocationModule" AllowAutomaticInserts="true"
                                AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" ShowFooter="True" Width="100%" ZIndex="50000">
                                <MasterTableView AutoGenerateColumns="False" CommandItemDisplay="None" DataKeyNames="Id" DataSourceID="SqlDataSourceLocationModule"
                                    HeaderStyle-Font-Size="Small">
                                    <Columns>
                                        <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column"
                                            HeaderStyle-HorizontalAlign="Center" HeaderText=" Location/Module " SortExpression="Name" UniqueName="Name">
                                            <ItemTemplate>

                                                <asp:LinkButton ID="btnEditLocationModule" runat="server" UseSubmitBehavior="false" ToolTip="Edit Location Module" CommandName="Edit">
                                            <%# Eval("Name") %>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox ID="txtName" runat="server" Text='<%# Bind("Name") %>' Width="100%" MaxLength="32">
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?"
                                            ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                            UniqueName="DeleteColumn" HeaderText="Delete" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                                        </telerik:GridButtonColumn>
                                    </Columns>
                                    <EditFormSettings>
                                        <EditColumn ButtonType="PushButton" FilterControlAltText="Filter EditCommandColumn1 column" UniqueName="EditCommandColumn1">
                                        </EditColumn>
                                    </EditFormSettings>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                    </asp:Panel>
                </td>
            </tr>

        </table>


    </div>

    <asp:SqlDataSource ID="SqlDataSourceReviewsPermits" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM Jobs_PlanReview_and_Permits WHERE Id=@Id"
        SelectCommand="Jobs_PlanReview_and_Permits_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="Jobs_PlanReview_and_Permits_INSERT" InsertCommandType="StoredProcedure"
        UpdateCommand="Jobs_PlanReview_and_Permits_UPDATE" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="Code" Type="String" />
            <asp:Parameter Name="url" Type="String" />
            <asp:Parameter Name="City" Type="String" />
            <asp:Parameter Name="Department" Type="String" />
            <asp:Parameter Name="DateSubmit" Type="DateTime" />
            <asp:Parameter Name="DateOut" Type="DateTime" />
            <asp:Parameter Name="statusId" Type="Int16" />
            <asp:Parameter Name="Notes" Type="String" />
            <asp:Parameter Name="contactId" Type="Int32" />
        </InsertParameters>
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


    <asp:SqlDataSource ID="SqlDataSourceReviewer" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Contacts] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <%--IT Company--%>

    <asp:SqlDataSource ID="SqlDataSourceAppName" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM Jobs_ticket_AppName WHERE Id=@Id"
        SelectCommand="select Id, Name from Jobs_ticket_AppName where jobId=@jobId"
        InsertCommand="INSERT INTO [Jobs_ticket_AppName] ([jobId], [Name]) VALUES (@jobId, @Name)"
        UpdateCommand="update Jobs_ticket_AppName set Name=@Name where Id=@Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="Name" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceLocationModule" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM Jobs_ticket_LocationModule WHERE Id=@Id"
        SelectCommand="select Id, Name from Jobs_ticket_LocationModule where jobId=@jobId"
        InsertCommand="INSERT INTO [Jobs_ticket_LocationModule] ([jobId], [Name]) VALUES (@jobId, @Name)"
        UpdateCommand="update Jobs_ticket_LocationModule set Name=@Name where Id=@Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Name="Name" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblJobId" runat="server" Visible="false" Text="0"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
