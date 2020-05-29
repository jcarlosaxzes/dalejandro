﻿<%@ Page Title="A/E Discipline" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="discipline.aspx.vb" Inherits="pasconcept20.discipline" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

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
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />

    <telerik:RadPageLayout ID="RadPageLayout1" runat="server" GridType="Fluid">
        <Rows>
            <telerik:LayoutRow>
                <Content>
                    <div style="text-align: left" class="ToolButtom noprint">

                        <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                            <span class="glyphicon glyphicon-plus"></span>&nbsp;Discipline
                        </asp:LinkButton>


                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <script type="text/javascript">
                    function PrintPage(sender, args) {
                        window.print();
                    }
                </script>
                        <telerik:RadButton ID="printbutton" OnClientClicked="PrintPage" Text="Print Page" runat="server" AutoPostBack="false" UseSubmitBehavior="false">
                            <Icon PrimaryIconCssClass="rbPrint"></Icon>
                        </telerik:RadButton>
                    </div>
                </Content>
            </telerik:LayoutRow>

            <telerik:LayoutRow>
                <Content>
                    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None"
                        AutoGenerateColumns="False" AllowAutomaticInserts="True" AllowAutomaticDeletes="True"
                        AllowAutomaticUpdates="True" AllowPaging="True" PageSize="25" AllowSorting="True" CellSpacing="0">
                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1">
                            <PagerStyle Mode="Slider" AlwaysVisible="false" />
                            <Columns>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                    HeaderText="" HeaderStyle-Width="50px">
                                </telerik:GridEditCommandColumn>
                                <telerik:GridTemplateColumn DataField="Name" ItemStyle-HorizontalAlign="Left"
                                    FilterControlAltText="Filter Name column" HeaderText="Name" SortExpression="Name" UniqueName="Name" HeaderStyle-HorizontalAlign="Center">
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
                                    CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText=""
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings>
                                <PopUpSettings Modal="true" Width="700px" />
                                <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                        </HeaderContextMenu>
                    </telerik:RadGrid>
                </Content>
            </telerik:LayoutRow>
        </Rows>
    </telerik:RadPageLayout>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="SubConsultans_disciplines_DELETE" DeleteCommandType="StoredProcedure"
        InsertCommand="INSERT INTO SubConsultans_disciplines(companyId, Name) VALUES (@companyId, @Name)"
        SelectCommand="SELECT Id, Name FROM SubConsultans_disciplines WHERE (companyId = @companyId) ORDER BY Name"
        UpdateCommand="UPDATE SubConsultans_disciplines SET Name = @Name WHERE (Id = @Id)">
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
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
