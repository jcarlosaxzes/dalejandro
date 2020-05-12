<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/MasterJOB.Master" CodeBehind="job_reviews.aspx.vb" Inherits="pasconcept20.job_reviews" %>

<%@ MasterType VirtualPath="~/ADM/MasterJOB.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="container">
        <asp:Panel runat="server" ID="PanelNo16Type">
            <div class="row">
                <div class="form-group">
                    <asp:LinkButton ID="btnNewReview" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" CausesValidation="false">
                                                                     <span class="glyphicon glyphicon-plus"></span> Revision
                    </asp:LinkButton>
                </div>
            </div>

            <div class="row">
                <div class="form-group">
                    <telerik:RadGrid ID="RadGridReviewsPermits" runat="server" DataSourceID="SqlDataSourceReviewsPermits"
                        AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" ShowFooter="True" Width="100%" ZIndex="50000">
                        <MasterTableView AutoGenerateColumns="False" CommandItemDisplay="None" DataKeyNames="Id" DataSourceID="SqlDataSourceReviewsPermits"
                              HeaderStyle-Font-Size="Small">
                            <Columns>
                                <telerik:GridTemplateColumn DataField="Code" FilterControlAltText="Filter Code column"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" HeaderText="Number" SortExpression="Code" UniqueName="Code">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEditReviews" runat="server" UseSubmitBehavior="false" ToolTip="Edit Revision" CommandName="Edit">
                                            <%# Eval("Code") %>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="txtEditCode2" runat="server" Text='<%# Bind("Code") %>' Width="150px" MaxLength="32">
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="url" FilterControlAltText="Filter url column" Display="false"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" HeaderText="Process URL" SortExpression="url" UniqueName="url">
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="txturl2" runat="server" Text='<%# Bind("url") %>' Width="600px" MaxLength="128">
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>

                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="cityId" FilterControlAltText="Filter City column"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" HeaderText="City" SortExpression="City" UniqueName="cityId">
                                    <ItemTemplate>
                                        <%# Eval("City") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="cboCity2" runat="server" DataSourceID="SqlDataSourceReviewCity" DataTextField="Name" DataValueField="Id"
                                            Filter="Contains" MarkFirstMatch="True" ZIndex="50001"
                                            SelectedValue='<%# Bind("cityId") %>' AppendDataBoundItems="true">
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text="(Select City...)" Value="0" />
                                            </Items>
                                        </telerik:RadComboBox>

                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="deparmentId" FilterControlAltText="Filter Department column" Display="false"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" HeaderText="Department" SortExpression="Department" UniqueName="deparmentId">
                                    <ItemTemplate>
                                        <%# Eval("Department") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="cboDepartment2" runat="server" DataSourceID="SqlDataSourceReviewDepartment" DataTextField="Name" DataValueField="Id"
                                            Filter="Contains" MarkFirstMatch="True" ZIndex="50001"
                                            SelectedValue='<%# Bind("deparmentId") %>' AppendDataBoundItems="true">
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text="(Select Department...)" Value="0" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="DateSubmit" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" FilterControlAltText="Filter DateSubmit column" HeaderText="App Date" SortExpression="DateSubmit" UniqueName="DateSubmit">
                                    <ItemTemplate>
                                        <%# Eval("DateSubmit", "{0:d}") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadDatePicker ID="RadDatePickerReviewSubmit" runat="server"
                                            SelectedDate='<%# Bind("DateSubmit") %>'
                                            Culture="en-US"
                                            ZIndex="50001">
                                        </telerik:RadDatePicker>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="statusId" FilterControlAltText="Filter Status column"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" HeaderText="Status"
                                    SortExpression="Status" UniqueName="statusId" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <span class="label label-<%# IIf(Eval("statusId") = 0, "warning", IIf(Eval("statusId") = 1, "success", "danger")) %>"><%# Eval("Status") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="cboPlanReview_status2" runat="server" DataSourceID="SqlDataSourcePlanReview_status" DataTextField="Name" DataValueField="Id"
                                            SelectedValue='<%# Bind("statusId") %>' ZIndex="50001">
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="DateOut" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" FilterControlAltText="Filter DateOut column" HeaderText="Disp Date"
                                    SortExpression="DateOut" UniqueName="DateOut">
                                    <ItemTemplate>
                                        <%# Eval("DateOut", "{0:d}") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadDatePicker ID="RadDatePickerReviewDateOut" runat="server"
                                            SelectedDate='<%# Bind("DateOut") %>'
                                            Culture="en-US"
                                            ZIndex="50001">
                                        </telerik:RadDatePicker>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn DataField="contactId" FilterControlAltText="Filter Reviewer column"
                                    HeaderStyle-HorizontalAlign="Center" HeaderText="Reviewed by" SortExpression="Reviewer" UniqueName="contactId">
                                    <ItemTemplate>
                                        <%# Eval("Reviewer") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="cboReviewer2" runat="server" DataSourceID="SqlDataSourceReviewer" DataTextField="Name" DataValueField="Id"
                                            Filter="Contains" MarkFirstMatch="True" Width="350px" ZIndex="50001"
                                            SelectedValue='<%# Bind("contactId") %>' AppendDataBoundItems="true">
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text="(Select Reviewer...)" Value="0" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn DataField="Notes" FilterControlAltText="Filter Notes column" Display="false"
                                    HeaderStyle-HorizontalAlign="Center" HeaderText="Notes" SortExpression="Notes" UniqueName="Notes">
                                    <ItemTemplate>
                                        <%# Eval("Notes") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="txtCityNotes2" runat="server" Text='<%# Bind("Notes") %>' Width="600px" Height="64px" Rows="3" TextMode="MultiLine">
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
            </div>
        </asp:Panel>

        <asp:Panel runat="server" ID="Panel16Type">
            <div class="row">
                <div class="form-group">
                    <asp:LinkButton ID="btnAddAppName" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" CausesValidation="false">
                                                                     <span class="glyphicon glyphicon-plus"></span> Application
                    </asp:LinkButton>
                </div>
            </div>

            <div class="row">
                <div class="form-group">
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
            </div>
            <div class="row">
                <div class="form-group">
                    <asp:LinkButton ID="btnAddModule" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false" CausesValidation="false">
                                                                     <span class="glyphicon glyphicon-plus"></span> Module
                    </asp:LinkButton>
                </div>
            </div>
             <div class="row">
                <div class="form-group">
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
            </div>
        </asp:Panel>

    </div>
    <br />

    <asp:SqlDataSource ID="SqlDataSourceReviewsPermits" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM Jobs_PlanReview_and_Permits WHERE Id=@Id"
        SelectCommand="Jobs_PlanReview_and_Permits_SELECT" SelectCommandType="StoredProcedure"
        InsertCommand="INSERT INTO [Jobs_PlanReview_and_Permits] ([jobId], [DateSubmit], [DateOut], statusId) VALUES (@jobId, DateAdd(hour,-4,GetDate()), DateAdd(hour,-4,GetDate()), 0)"
        UpdateCommand="Jobs_PlanReview_and_Permits_UPDATE" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="Code" Type="String" />
            <asp:Parameter Name="url" Type="String" />
            <asp:Parameter Name="cityId" Type="Int16" />
            <asp:Parameter Name="deparmentId" Type="Int16" />
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

    <asp:SqlDataSource ID="SqlDataSourceReviewCity" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM PlanReview_Cities ORDER BY Name"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceReviewDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM PlanReview_Departments ORDER BY Name"></asp:SqlDataSource>

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
