<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="billingplans.aspx.vb" Inherits="pasconcept20.billingplans" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ MasterType VirtualPath="~/master/MasterPage.Master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
        <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Billing Plans</span>

        <span style="float: right; vertical-align: middle;">
            <asp:LinkButton ID="btnNewPlan" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false">
                    Add Plan
            </asp:LinkButton>
        </span>


    </div>
    <div style="padding-bottom:10px">
        Status: 
        <telerik:RadComboBox ID="cboStatus" runat="server" Width="250px" AppendDataBoundItems="true" AutoPostBack="true">
                    <Items>
                        <telerik:RadComboBoxItem runat="server" Text="Active Plans" Value="0" Selected="true" />
                        <telerik:RadComboBoxItem runat="server" Text="Inactive Plans" Value="1" />
                        <telerik:RadComboBoxItem runat="server" Text="(All Plans...)" Value="-1" />
                    </Items>
                </telerik:RadComboBox>
        
    </div>
<div>
    <telerik:RadGrid ID="RadGrid1" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True"
                    AllowAutomaticUpdates="True" AllowSorting="True" AutoGenerateColumns="False"
                    DataSourceID="SqlDataSource1" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AlternatingItemStyle-HorizontalAlign="Center"
                    HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" >
                    <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                            </telerik:GridEditCommandColumn>
                            <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column"
                                HeaderText="ID" ReadOnly="True" SortExpression="Id" UniqueName="Id" HeaderStyle-Width="50px">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column"
                                HeaderText="Plan name" SortExpression="Name" UniqueName="Name" ItemStyle-HorizontalAlign="Left" >
                                <EditItemTemplate>
                                    <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' Width="100%">
                                    </telerik:RadTextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <%# Eval("Name") %>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="billing_baseprice" DataType="System.Double" FilterControlAltText="Filter billing_baseprice column"
                                HeaderText="Rental Base" SortExpression="billing_baseprice" UniqueName="billing_baseprice" HeaderStyle-Width="150px">
                                <EditItemTemplate>
                                    <telerik:RadNumericTextBox ID="RadNumericTextBox1" runat="server" DbValue='<%# Bind("billing_baseprice")%>'
                                        Width="150px">
                                    </telerik:RadNumericTextBox>
                                    <small class="badge badge-info"> Base Price per Period</small>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <%# Eval("billing_baseprice")%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="billing_baseusers"
                                FilterControlAltText="Filter billing_baseusers column" HeaderText="Base Users (#)"
                                SortExpression="billing_baseusers" UniqueName="billing_baseusers" HeaderStyle-Width="150px">
                                <EditItemTemplate>
                                    <telerik:RadNumericTextBox ID="billing_baseusersTextBox" runat="server" DbValue='<%# Bind("billing_baseusers")%>'
                                        Width="150px" Style="text-align: right">
                                    </telerik:RadNumericTextBox>
                                    <small class="badge badge-info"> Maximum number of employees users ($/Period)</small>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <%# Eval("billing_baseusers")%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="billing_otheruser" DataType="System.Double"
                                FilterControlAltText="Filter billing_otheruser column" HeaderText="Other Users"
                                SortExpression="billing_otheruser" UniqueName="billing_otheruser" HeaderStyle-Width="150px">
                                <EditItemTemplate>
                                    <telerik:RadNumericTextBox ID="billing_otheruserTextBox" runat="server" DbValue='<%# Bind("billing_otheruser") %>'
                                        Width="150px" Style="text-align: right">
                                    </telerik:RadNumericTextBox>
                                    <small class="badge badge-info"> Maximum number of others users ($/Period)</small>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <%# Eval("billing_otheruser") %>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>


                            <telerik:GridTemplateColumn DataField="billing_period_Id"
                                FilterControlAltText="Filter billing_period_Id column" HeaderText="Billing Period"
                                SortExpression="billing_period_Id" UniqueName="billing_period_Id" HeaderStyle-Width="150px">
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="cboPeriod" runat="server" DataSourceID="SqlDataSourcePeriod" 
                                        DataTextField="Name" DataValueField="Id" Width="100%" SelectedValue='<%# Bind("billing_period_Id")%>'>
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <%# Eval("BillingPeriod")%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="Custom"
                                FilterControlAltText="Filter Custom column" HeaderText="Custom"
                                SortExpression="Custom" UniqueName="Custom" HeaderStyle-Width="70px">
                                <EditItemTemplate>
                                    <telerik:RadCheckBox ID="CustomCHBox" runat="server" Checked='<%# Bind("Custom") %>'
                                        Width="150px" Style="text-align: right">
                                    </telerik:RadCheckBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <%# Eval("Custom")%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="Inactive"
                                FilterControlAltText="Filter Inactive column" HeaderText="Inactive"
                                SortExpression="Inactive" UniqueName="Inactive" HeaderStyle-Width="70px">
                                <EditItemTemplate>
                                    <telerik:RadCheckBox ID="InactiveCHBox" runat="server" Checked='<%# Bind("Inactive") %>'
                                        Width="150px" Style="text-align: right">
                                    </telerik:RadCheckBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <%# Eval("Inactive")%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>



                            <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this plan?"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                UniqueName="DeleteColumn" HeaderStyle-Width="50px">
                            </telerik:GridButtonColumn>
                        </Columns>
                        <EditFormSettings>
                            <EditColumn UniqueName="EditCommandColumn1" ButtonType="PushButton">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                    <FilterMenu EnableImageSprites="False">
                    </FilterMenu>
                </telerik:RadGrid>
</div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="Billing_plans_DELETE" DeleteCommandType="StoredProcedure"
        InsertCommand="Billing_plans_INSERT" InsertCommandType="StoredProcedure"
        SelectCommand="Billing_plans_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="Billing_plans_UPDATE" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="billing_baseprice" Type="Double" />
            <asp:Parameter Name="billing_baseusers" />
            <asp:Parameter Name="billing_otheruser" Type="Double" />
            <asp:Parameter Name="billing_period_Id" />
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="Custom" Type="Boolean" />
            <asp:Parameter Name="Inactive" Type="Boolean" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="billing_baseprice" Type="Double" />
            <asp:Parameter Name="billing_baseusers" />
            <asp:Parameter Name="billing_otheruser" Type="Double" />
            <asp:Parameter Name="billing_period_Id" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="cboStatus" Name="StatusId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="SqlDataSourcePeriod" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Billing_periods]">
    </asp:SqlDataSource>

</asp:Content>
