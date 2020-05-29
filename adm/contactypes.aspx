<%@ Page Title="Contact Types" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="contactypes.aspx.vb" Inherits="pasconcept20.contactypes" %>

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
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnNewSubtype">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
    <table width="100%" cellpading="3">
        <tr>
            <td style="width: 400px;" class="ToolButtom">
                <telerik:RadButton ID="btnNew" runat="server" Text="Add New Type">
                    <Icon PrimaryIconCssClass="rbAdd" PrimaryIconLeft="4" PrimaryIconTop="4"></Icon>
                </telerik:RadButton>
            </td>
            <td style="padding-left: 10px; padding-top: 25px; padding-bottom: 15px">
                <telerik:RadButton ID="btnNewSubtype" runat="server" Text="Add New Subtype">
                    <Icon PrimaryIconCssClass="rbAdd" PrimaryIconLeft="4" PrimaryIconTop="4"></Icon>
                </telerik:RadButton>
            </td>
        </tr>
        <tr>
            <td style="vertical-align: top; width: 400px">
                <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None"
                    AutoGenerateColumns="False" AllowAutomaticInserts="True" AllowAutomaticDeletes="True"
                    AllowAutomaticUpdates="True" AllowPaging="True" AllowSorting="True" PageSize="25">
                    <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1">
                        <PagerStyle Mode="Slider" AlwaysVisible="false" />
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                HeaderText="Edit" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="30px">
                            </telerik:GridEditCommandColumn>
                            <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column" HeaderText="Name"
                                SortExpression="Name" UniqueName="Name" HeaderStyle-HorizontalAlign="Center">
                                <EditItemTemplate>
                                    <div style="margin: 5px">
                                        <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="80" Width="600px"></telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="NameTextBox" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>
                                    </div>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="NameLabel0" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText="Delete"
                                HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" ItemStyle-HorizontalAlign="Center">
                            </telerik:GridButtonColumn>
                        </Columns>
                        <EditFormSettings>
                            <PopUpSettings Modal="true" Width="650px" />
                            <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
            <td style="vertical-align: top;">

                <telerik:RadGrid ID="RadGrid2" runat="server" DataSourceID="SqlDataSource2" GridLines="None"
                    AutoGenerateColumns="False" AllowAutomaticInserts="True" AllowAutomaticDeletes="True"
                    AllowAutomaticUpdates="True" AllowPaging="True" AllowSorting="True" PageSize="25">
                    <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource2">
                        <PagerStyle Mode="Slider" AlwaysVisible="false" />
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                HeaderText="Edit" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="30px">
                            </telerik:GridEditCommandColumn>
                            <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column" HeaderText="Name"
                                SortExpression="Name" UniqueName="Name" HeaderStyle-HorizontalAlign="Center">
                                <EditItemTemplate>
                                    <div style="margin: 5px">
                                        <telerik:RadTextBox ID="subtypeNameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="80" Width="600px"></telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="subtypeNameTextBox" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>
                                    </div>
                                </EditItemTemplate>

                                <ItemTemplate>
                                    <asp:Label ID="subtypeNameLabel" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="typeId" FilterControlAltText="Filter typeId column" HeaderText="Type" SortExpression="typeId" UniqueName="typeId"
                                HeaderStyle-Width="250px" HeaderStyle-HorizontalAlign="Center">
                                <EditItemTemplate>
                                    <div style="margin: 5px">
                                        <telerik:RadComboBox ID="cbotypeId" runat="server" DataSourceID="SqlDataSource1"
                                            DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("typeId")%>' AppendDataBoundItems="true"
                                            Width="300px" MarkFirstMatch="True" Filter="Contains"
                                            Height="300px">
                                            <Items>
                                                <telerik:RadComboBoxItem Text="(Type Not Defined...)" Value="0" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </div>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="TypeNameLabel" runat="server" Text='<%# Eval("nType")%>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText="Delete"
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px">
                            </telerik:GridButtonColumn>
                        </Columns>
                        <EditFormSettings>
                            <PopUpSettings Modal="true" Width="650px" />
                            <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM Contact_types WHERE (Id = @Id)"
        InsertCommand="INSERT INTO Contact_types(companyId, Name) VALUES (@companyId, @Name)"
        SelectCommand="SELECT Id, Name FROM Contact_types WHERE (companyId = @companyId) ORDER BY Name"
        UpdateCommand="UPDATE Contact_types SET Name = @Name WHERE (Id = @Id)">
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" />
            <asp:Parameter Name="Id" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Name="Name" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="Contact_subtypes_DELETE" DeleteCommandType="StoredProcedure"
        InsertCommand="INSERT INTO Contact_subtypes(Name, typeId) VALUES (@Name, @typeId)"
        SelectCommand="SELECT Contact_subtypes.Id, Contact_subtypes.Name, Contact_subtypes.typeId, Contact_types.Name AS nType FROM Contact_subtypes INNER JOIN Contact_types ON Contact_subtypes.typeId = Contact_types.Id WHERE typeId in(SELECT Id FROM Contact_types WHERE companyId = @companyId) ORDER BY nType, Name"
        UpdateCommand="UPDATE Contact_subtypes SET Name = @Name, typeId=@typeId WHERE (Id = @Id)">
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" />
            <asp:Parameter Name="typeId" />
            <asp:Parameter Name="Id" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" />
            <asp:Parameter Name="typeId" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>

