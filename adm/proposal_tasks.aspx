<%@ Page Title="Proposal Tasks" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="proposal_tasks.aspx.vb" Inherits="pasconcept20.proposal_tasks" %>

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
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
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
                    <div style="text-align: left" class="PanelFilter noprint">
                        <asp:Panel ID="pnlFind" runat="server">
                            <table style="width: 100%" class="table-condensed Formulario">
                                <tr>
                                    <td style="width: 100px">Discipline:
                                    </td>
                                    <td style="width: 350px">
                                        <telerik:RadComboBox ID="cboDisciplineFilter" runat="server" DataSourceID="SqlDataSourceDiscipline"
                                            DataTextField="Name" DataValueField="Id" Width="100%" AppendDataBoundItems="true">
                                            <Items>
                                                <telerik:RadComboBoxItem Text="(All disciplines...)" Value="0" />
                                            </Items>
                                        </telerik:RadComboBox>
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
                                <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" ToolTip="Add New Task">
                                    <span class="glyphicon glyphicon-plus"></span> Task
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
                            <td>
                                <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-danger btn" UseSubmitBehavior="false" ToolTip="Delete Selected records">
                                    Delete Selected
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </table>

                </Content>
            </telerik:LayoutRow>

            <telerik:LayoutRow>
                <Content>
                    <div style="text-align: left">
                        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
                            <script type="text/javascript">
                                var popUp;
                                function PopUpShowing(sender, eventArgs) {
                                    popUp = eventArgs.get_popUp();
                                    var gridWidth = sender.get_element().offsetWidth;
                                    var gridHeight = sender.get_element().offsetHeight;
                                    var popUpWidth = popUp.style.width.substr(0, popUp.style.width.indexOf("px"));
                                    var popUpHeight = popUp.style.height.substr(0, popUp.style.height.indexOf("px"));
                                    popUp.style.left = ((gridWidth - popUpWidth) / 2 + sender.get_element().offsetLeft).toString() + "px";
                                    popUp.style.top = 25 + "px";
                                }
                            </script>
                        </telerik:RadCodeBlock>
                        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1"
                            AllowAutomaticInserts="True" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" HeaderStyle-Font-Size="Small"
                            ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small"
                            Width="100%" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" AllowMultiRowSelection="True"
                            CellSpacing="0" PageSize="250" Height="700px">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                <Selecting AllowRowSelect="true" />
                                <ClientEvents OnPopUpShowing="PopUpShowing" />
                            </ClientSettings>

                            <MasterTableView DataSourceID="SqlDataSource1" DataKeyNames="Id">
                                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                                <Columns>

                                    <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center">
                                    </telerik:GridClientSelectColumn>
                                    <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" HeaderText="Id" ReadOnly="True" UniqueName="Id" Display="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="taskcode" HeaderText="Task ID" SortExpression="taskcode"
                                        UniqueName="taskcode" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                        <EditItemTemplate>
                                            <div style="margin: 5px">
                                                <telerik:RadTextBox ID="taskcodeTextBox" runat="server" Text='<%# Bind("taskcode")%>' MaxLength="16" Width="150px">
                                                </telerik:RadTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="taskcodeTextBox" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>
                                            </div>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <div style="margin: 5px">
                                                <asp:LinkButton ID="lnkcodeLabel" runat="server" CommandName="Edit" CausesValidation="false"
                                                    Text='<%# Eval("taskcode")%>' ToolTip="Click to Edit detail"></asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Description" FilterControlAltText="Filter Description column"
                                        HeaderText="Task Name" SortExpression="Description" UniqueName="Description" ItemStyle-HorizontalAlign="Left"
                                        HeaderStyle-HorizontalAlign="Center">
                                        <EditItemTemplate>
                                            <div style="margin: 5px">
                                                <telerik:RadTextBox ID="NameTextBox" runat="server" Text='<%# Bind("Description") %>' MaxLength="80" Width="800px">
                                                </telerik:RadTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="NameTextBox" CssClass="Error" ErrorMessage=" (*)"></asp:RequiredFieldValidator>
                                            </div>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="NameLabel0" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="DescriptionPlus" Display="False" HeaderText="Task Description"
                                        SortExpression="DescriptionPlus" UniqueName="DescriptionPlus">
                                        <ItemTemplate>
                                            <asp:Label ID="DescriptionPlusLabel" runat="server" Text='<%# Eval("DescriptionPlus") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <div style="margin: 5px">
                                                <telerik:RadEditor ID="gridEditor_Saludo" runat="server" Content='<%# Bind("DescriptionPlus")%>' Height="300px"
                                                    AllowScripts="True" Width="800px"
                                                    ToolbarMode="Default" ToolsFile="~/BasicTools.xml" EditModes="All">
                                                </telerik:RadEditor>
                                            </div>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Hours" DataType="System.Double" FilterControlAltText="Filter Hours column"
                                        HeaderText="Quantity (Hours)" SortExpression="Hours" UniqueName="Hours"
                                        HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                        <EditItemTemplate>
                                            <div style="margin: 5px">
                                                <telerik:RadNumericTextBox ID="HoursTextBox" runat="server" Culture="en-US" DbValue='<%# Bind("Hours") %>'
                                                    LabelWidth="" Width="125px">
                                                </telerik:RadNumericTextBox>
                                            </div>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="HoursLabel" runat="server" Text='<%# Eval("Hours") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Rates" DataType="System.Double" FilterControlAltText="Filter Rates column"
                                        HeaderText="UnitPrice (Hours Rates)" SortExpression="Rates" UniqueName="Rates"
                                        HeaderStyle-Width="180px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                        <EditItemTemplate>
                                            <div style="margin: 5px">
                                                <telerik:RadNumericTextBox ID="RatesTextBox" runat="server" Culture="en-US" DbValue='<%# Bind("Rates") %>'
                                                    LabelWidth="" Width="125px">
                                                </telerik:RadNumericTextBox>
                                            </div>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="RatesLabel" runat="server" Text='<%# Eval("Rates") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridCheckBoxColumn DataField="HourRatesService" DataType="System.Boolean"
                                        HeaderText="Hour Rates Service" SortExpression="HourRatesService" UniqueName="HourRatesService"
                                        HeaderStyle-Width="180px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                    </telerik:GridCheckBoxColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn ButtonType="PushButton" UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>

                </Content>
            </telerik:LayoutRow>

        </Rows>
    </telerik:RadPageLayout>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        DeleteCommand="DELETE FROM [Proposal_tasks] WHERE [Id]=@Id "
        InsertCommand="INSERT INTO Proposal_tasks(taskcode, Description, DescriptionPlus, Hours, Rates, HourRatesService, companyId,disciplineId) VALUES (@taskcode, @Description, @DescriptionPlus, @Hours, @Rates, @HourRatesService, @companyId, @disciplineId)"
        SelectCommand="Proposal_tasks_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="UPDATE Proposal_tasks SET taskcode=@taskcode, Description = @Description, DescriptionPlus = @DescriptionPlus, Hours = ISNULL(@Hours,0), Rates = ISNULL(@Rates,0), HourRatesService =@HourRatesService,disciplineId=@disciplineId WHERE Id=@Id ">
        <DeleteParameters>
            <asp:ControlParameter ControlID="lblSelected" Name="Id" PropertyName="Text" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboDisciplineFilter" Name="disciplineId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Filter" PropertyName="Text" Type="String" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="taskcode" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="DescriptionPlus" Type="String" />
            <asp:Parameter Name="Hours" Type="Double" />
            <asp:Parameter Name="Rates" Type="Double" />
            <asp:Parameter Name="HourRatesService" />
            <asp:Parameter Name="disciplineId" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="taskcode" Type="String" />
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="DescriptionPlus" />
            <asp:Parameter Name="Hours" />
            <asp:Parameter Name="Rates" />
            <asp:Parameter Name="HourRatesService" />
            <asp:Parameter Name="disciplineId" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDiscipline" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, companyId, Name FROM SubConsultans_disciplines WHERE (companyId = @companyId) ORDER BY Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelected" runat="server" Visible="False"></asp:Label>
</asp:Content>
