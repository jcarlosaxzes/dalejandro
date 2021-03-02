<%@ Page Title="Positions" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="position.aspx.vb" Inherits="pasconcept20.position" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnNew">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"  EnableEmbeddedSkins="false" />

        <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Employee Positions</span>

        <span style="float: right; vertical-align: middle;">

            <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                    Add Position
            </asp:LinkButton>

        </span>
    </div>

    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None"
                        AutoGenerateColumns="False" AllowAutomaticInserts="True" AllowAutomaticDeletes="True"
                        HeaderStyle-HorizontalAlign="Center"
                        AllowAutomaticUpdates="True" AllowPaging="True" PageSize="25" AllowSorting="True">
                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1">
                            <PagerStyle Mode="Slider" AlwaysVisible="false" />
                            <Columns>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                    HeaderText="" HeaderStyle-Width="50px">
                                </telerik:GridEditCommandColumn>
                                <telerik:GridTemplateColumn DataField="Name"
                                    FilterControlAltText="Filter Name column" HeaderText="Name" SortExpression="Name" UniqueName="Name"  ItemStyle-HorizontalAlign="Left">
                                    <EditItemTemplate>
                                        <div style="margin: 5px">
                                            <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="80" Width="600px"></telerik:RadTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="NameTextBox" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>
                                        </div>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("Name") %>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                               <telerik:GridBoundColumn DataField="PositionCount" HeaderText="Active Employees *" SortExpression="PositionCount" UniqueName="PositionCount" HeaderStyle-Width="220px" ItemStyle-HorizontalAlign="Center" ReadOnly="true" HeaderTooltip="Number of active employees assigned to that position">
                                </telerik:GridBoundColumn>
                               <telerik:GridBoundColumn DataField="AverageHourlySalary" HeaderText="Average Hourly Salary *" SortExpression="AverageHourlySalary" UniqueName="AverageHourlySalary" HeaderStyle-Width="220px" ItemStyle-HorizontalAlign="Center" ReadOnly="true" HeaderTooltip="Average salary of Active employees in that position">
                                </telerik:GridBoundColumn>
                               <telerik:GridBoundColumn DataField="RecommendedRate" HeaderText="Recommended Rate *" SortExpression="RecommendedRate" UniqueName="RecommendedRate" HeaderStyle-Width="220px" ItemStyle-HorizontalAlign="Center" ReadOnly="true" HeaderTooltip="[Average Hourly Salary] * [Multiplier]">
                                </telerik:GridBoundColumn>


                                <telerik:GridTemplateColumn DataField="HourRate" HeaderText="Hourly Rate" SortExpression="HourRate" UniqueName="HourRate" HeaderStyle-Width="220px"
                                    ItemStyle-HorizontalAlign="Center" >
                                    <ItemTemplate>
                                        <%# Eval("HourRate", "{0:N2}")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <div style="margin: 5px">
                                            <telerik:RadTextBox ID="HourRateTextBox" runat="server" Text='<%# Bind("HourRate") %>' MaxLength="80"></telerik:RadTextBox>
                                        </div>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                    CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText=""
                                     HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings>
                                <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                    </telerik:RadGrid>
    </div>
    * These three fields, Active Employees, Average Hourly Salary and Recommended Rate are all calculated by PASconcept and are not editable fields.<br />
Active Employees indicates the current number of active employees with this position.<br />
Average Hourly Salary is the total hourly salary of these Active Employees with this position divided by the by the number of Active Employees with this position.<br />
Recommended Rate is the value of that Average Hourly Salary multiplied by your company's Multiplier.
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="Employees_Position_DELETE" DeleteCommandType="StoredProcedure"
        InsertCommand="INSERT INTO Employees_Position(companyId, Name, HourRate) VALUES (@companyId, @Name, @HourRate)"
        SelectCommand="Employees_Position_v21_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="UPDATE Employees_Position SET Name = @Name, HourRate=@HourRate WHERE (Id = @Id)">
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" />
            <asp:Parameter Name="HourRate" />
            <asp:Parameter Name="Id" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Name="Name" />
            <asp:Parameter Name="HourRate" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
