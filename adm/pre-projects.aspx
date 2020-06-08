<%@ Page Title="Pre-Projects" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="pre-projects.aspx.vb" Inherits="pasconcept20.pre_projects" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnNew">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />

    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <script type="text/javascript">

            function OnClientClose(sender, args) {
                var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                masterTable.rebind();
            }

        </script>

    </telerik:RadCodeBlock>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>

    <telerik:RadPageLayout ID="RadPageLayout1" runat="server" GridType="Fluid">
        <Rows>
            <telerik:LayoutRow>
                <Content>
                    <div style="text-align: left" class="PanelFilter noprint">
                        <asp:Panel ID="pnlFind" runat="server">
                            <table class=" table-condensed Formulario" style="width: 100%">
                                <tr>
                                    <td style="width: 150px">
                                        <telerik:RadComboBox ID="cboStatus" runat="server" Width="100%" AppendDataBoundItems="true">
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text="Pending" Value="0" Selected="true" />
                                                <telerik:RadComboBoxItem runat="server" Text="Processed" Value="1" />
                                                <telerik:RadComboBoxItem runat="server" Text="(All Status...)" Value="-1" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>
                                    <td style="width: 350px">
                                        <telerik:RadComboBox ID="cboClients" runat="server" DataSourceID="SqlDataSourceClient"
                                            Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Height="300px"
                                            AppendDataBoundItems="true">
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text="(All Clients...)" Value="-1" Selected="true" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>
                                    <td style="width: 300px">
                                        <telerik:RadComboBox ID="cboDepartments" runat="server" DataSourceID="SqlDataSourceDepartments" DataTextField="Name"
                                            DataValueField="Id" Width="100%" AppendDataBoundItems="true">
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text="(All Departments...)" Value="-1" Selected="true" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech"
                                            EmptyMessage="Name, Description, Location..." Width="100%">
                                        </telerik:RadTextBox>
                                    </td>
                                    <td style="width: 100px">
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

                    <table class="table-condensed noprint" style="width: 100%">
                        <tr>
                            <td style="width: 100px">
                                <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                                        <span class="glyphicon glyphicon-plus"></span>&nbsp;Pre-Project
                                </asp:LinkButton>
                            </td>
                            <td style="width: 130px">
                                <script type="text/javascript">
                                    function PrintPage(sender, args) {
                                        window.print();
                                    }
                                </script>
                                <telerik:RadButton ID="printbutton" OnClientClicked="PrintPage" Text="Print Page" runat="server" AutoPostBack="false" UseSubmitBehavior="false">
                                    <Icon PrimaryIconCssClass=" rbPrint"></Icon>
                                </telerik:RadButton>
                            </td>
                            <td style="text-align: center">
                                <h3 style="margin: 0">Pre-Proposals
                                </h3>
                            </td>
                        </tr>
                    </table>
                </Content>
            </telerik:LayoutRow>

            <telerik:LayoutRow>
                <Content>
                    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None" HeaderStyle-Font-Size="Small"
                        AutoGenerateColumns="False" AllowAutomaticDeletes="True"
                        AllowPaging="True" PageSize="25" AllowSorting="True" CellSpacing="0">
                        <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1">
                            <PagerStyle Mode="Slider" AlwaysVisible="false" />
                            <Columns>
                                <telerik:GridTemplateColumn DataField="Id" HeaderText="Number"
                                    SortExpression="Id" UniqueName="Id" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" FooterStyle-HorizontalAlign="Center" Aggregate="Count" FooterAggregateFormatString="{0:N0}">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="btnEditProj" runat="server" CommandArgument='<%# Eval("Id") %>' ToolTip="Click to View/Edit Pre-Project"
                                                CommandName="EditPre_Project">
                                                <%# Eval("Pre_ProjectNumber")%>
                                                <span title="Number of files uploaded" class="badge" style='<%# IIf(Eval("PreProjectUploadFiles")=0,"display:none","display:normal")%>'>
                                                <%#Eval("PreProjectUploadFiles")%>
                                            </span>
                                            </asp:LinkButton>
                                        </div>
                                        <div>
                                            <asp:LinkButton runat="server" ID="btnAzureStorage" CommandName="AzureUpload" CommandArgument='<%# Eval("Id") %>' ToolTip="Upload Files">
                                                <span aria-hidden="true" class="glyphicon glyphicon-cloud-upload"></span>
                                            </asp:LinkButton>
                                            &nbsp;&nbsp;
                                            <asp:LinkButton ID="btnNewProposal" runat="server" CommandName="NewProposal" CommandArgument='<%# Eval("Id") %>' Visible='<%# Eval("statusId") = 0 %>'>
                                                    <span title="Create new Proposal" class="glyphicon glyphicon-export"></span>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnEditProp" runat="server" CommandArgument='<%# Eval("proposalId") %>' ToolTip="Click to View/Edit Proposal" Font-Size="X-Small"
                                                CommandName="EditProposal" Text='<%# Eval("ProposalNumber")%>' Visible='<%# Eval("statusId") = 1 And Eval("proposalId") > 0 %>'>
                                            </asp:LinkButton>

                                        </div>

                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridBoundColumn DataField="DateIn" DataFormatString="{0:MM/dd/yy}" DataType="System.DateTime"
                                    HeaderText="Date" SortExpression="DateIn" UniqueName="DateIn"
                                    ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" AllowFiltering="False" HeaderStyle-Width="80px">
                                </telerik:GridBoundColumn>

                                <telerik:GridTemplateColumn DataField="Name" ItemStyle-HorizontalAlign="Left"
                                    FilterControlAltText="Filter Name column" HeaderText="Name<br/>Type" SortExpression="Name" UniqueName="Name" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <%# Eval("Name") %>
                                        </div>
                                        <div>
                                            <%# Eval("nProjectType") %>
                                        </div>

                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn DataField="clientId" ItemStyle-HorizontalAlign="Left"
                                    FilterControlAltText="Filter ClientName column" HeaderText="Client <br/>Proposal By - Prepared By" SortExpression="ClientName" UniqueName="ClientName" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <%# Eval("ClientName") %>
                                        </div>
                                        <div>
                                            <%# String.Concat(Eval("ProposalByName"), " - ", Eval("PreparedByName")) %>
                                        </div>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>


                                <telerik:GridTemplateColumn DataField="Status" HeaderText="Status" SortExpression="Status"
                                    UniqueName="Status" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="true" HeaderStyle-Width="80px">
                                    <ItemTemplate>
                                        <span class="label  <%# LocalAPI.GetPre_ProjectsStatusLabelCSS(Eval("statusId")) %>"><%# Eval("Status") %></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmText="Delete this row?" ConfirmTitle="Delete" ButtonType="ImageButton"
                                    CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderText=""
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" ItemStyle-HorizontalAlign="Center">
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
        SelectCommand="Pre_Projects_SELECT" SelectCommandType="StoredProcedure"
        DeleteCommand="DELETE FROM Clients_pre_projects WHERE (Id = @Id)">
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboClients" Name="clientId" PropertyName="SelectedValue" Type="Int32" DefaultValue="-1" />
            <asp:ControlParameter ControlID="cboDepartments" Name="departmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboStatus" Name="statusId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Find" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Client] As Name FROM [Clients]  WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>


