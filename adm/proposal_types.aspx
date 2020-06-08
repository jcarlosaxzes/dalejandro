﻿<%@ Page Title="Proposal Templates" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="proposal_types.aspx.vb" Inherits="pasconcept20.proposal_types" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <telerik:RadPageLayout ID="RadPageLayout1" runat="server" GridType="Fluid">
        <Rows>
            <telerik:LayoutRow>
                <Content>
                    <div style="text-align: left" class="PanelFilter noprint">
                        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
                            <table style="width: 100%" class="table-condensed Formulario">
                                <tr>
                                    <td align="right" class="Normal" width="80px">Find:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech" Width="100%" EmptyMessage="Find">
                                        </telerik:RadTextBox>
                                    </td>
                                    <td style="width: 120px">
                                        <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                            <span class="glyphicon glyphicon-search"></span> Search
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </div>
                </Content>
            </telerik:LayoutRow>
            <telerik:LayoutRow>
                <Content>
                    <table class="table-condensed noprint">
                        <tr>
                            <td>
                                <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" ToolTip="Add New Template">
                                    <span class="glyphicon glyphicon-plus"></span> Template
                                </asp:LinkButton></td>
                            <td>
                                <script type="text/javascript">
                                    function PrintPage(sender, args) {
                                        window.print();
                                    }
                                </script>
                                <telerik:RadButton ID="printbutton" OnClientClicked="PrintPage" Text="Print Page" runat="server" AutoPostBack="false" UseSubmitBehavior="false">
                                    <Icon PrimaryIconCssClass=" rbPrint" PrimaryIconLeft="4"></Icon>
                                </telerik:RadButton>
                            </td>
                        </tr>
                    </table>
                </Content>
            </telerik:LayoutRow>

            <telerik:LayoutRow>
                <Content>
                    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None"
                        AllowAutomaticDeletes="True" Width="100%" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True"
                        PageSize="250" Height="1000px" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
                        <ClientSettings>
                            <Scrolling AllowScroll="True"></Scrolling>
                        </ClientSettings>
                        <MasterTableView DataSourceID="SqlDataSource1" DataKeyNames="Id">
                            <PagerStyle Mode="Slider" AlwaysVisible="false" />
                            <Columns>
                                <telerik:GridTemplateColumn DataField="Name" FilterControlAltText="Filter Name column" ItemStyle-HorizontalAlign="Left"
                                    HeaderText="Name" SortExpression="Name" UniqueName="Name" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>

                                        <asp:LinkButton ID="btnEditTemplate" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to View/Edit Template"
                                            CommandName="EditTemplate">
                                                <%# Eval("Name")%>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="TaskIdList" FilterControlAltText="Filter TaskIdList column"
                                    HeaderText="Related Task ID" SortExpression="TaskIdList" UniqueName="TaskIdList"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="300px">

                                    <ItemTemplate>
                                        <asp:Label ID="TaskIdListLabel" runat="server" Text='<%# Eval("TaskIdList") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="PaymentsScheduleList" FilterControlAltText="Filter PaymentsScheduleList column"
                                    HeaderText="Payment Schedule(%)" SortExpression="PaymentsScheduleList" UniqueName="PaymentsScheduleList" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="180px">

                                    <ItemTemplate>
                                        <asp:Label ID="PaymentsScheduleListLabel" runat="server" Text='<%# Eval("PaymentsScheduleList") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="TandCtemplate" HeaderText="Terms &amp; Conditions"
                                    SortExpression="TandCtemplate" UniqueName="TandCtemplate">
                                    <ItemTemplate>
                                        <asp:Label ID="TandCtemplateLabel" runat="server" Text='<%# Eval("TandCtemplate") %>'></asp:Label>
                                    </ItemTemplate>

                                </telerik:GridTemplateColumn>
                                <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this type?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                    CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText=""
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings>
                                <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>

                    </telerik:RadGrid>
                </Content>
            </telerik:LayoutRow>

        </Rows>
    </telerik:RadPageLayout>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="Proposal_types_DELETE" DeleteCommandType="StoredProcedure"
        SelectCommand="Proposal_types_SELECT" SelectCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Filter" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTask" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT taskcode, '['+taskcode+'] '+Description as Description FROM Proposal_tasks WHERE (companyId = @companyId) and not Description is null ORDER BY taskcode">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTandCtemplates" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT * FROM [Proposal_TandCtemplates] WHERE ([companyId] = @companyId) ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePaymentSchedules" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Invoices_types WHERE (companyId = @companyId) ORDER BY Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
