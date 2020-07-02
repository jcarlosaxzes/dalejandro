<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/master/MasterPage.Master" CodeBehind="useradmin.aspx.vb" Inherits="pasconcept20.useradmin" Async="true" %>

<%@ Import Namespace="pasconcept20" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <asp:Panel CssClass="PanelFilter noprint" ID="pnlFind" runat="server">
        <table class=" table-condensed pasconcept-bar" style="width: 100%">
            <tr>
                <td style="width: 150px">
                    <telerik:RadComboBox ID="cboMigrateStatusId" runat="server" Width="100%" AppendDataBoundItems="true" Enabled="false">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="Pending" Value="0" />
                            <telerik:RadComboBoxItem runat="server" Text="Migrated" Value="1" />
                            <telerik:RadComboBoxItem runat="server" Text="(All Status...)" Value="-1" Selected="true" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td style="width: 350px">
                    <telerik:RadComboBox ID="cboCompany" runat="server" DataSourceID="SqlDataSourceCompany"
                        Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Height="300px"
                        AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(All Companies...)" Value="-1" Selected="true" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtFind" runat="server" x-webkit-speech="x-webkit-speech"
                        EmptyMessage="Name, Email..." Width="100%">
                    </telerik:RadTextBox>
                </td>
                <td style="width: 100px">
                    <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                            <i class="fas fa-search"></i> Search
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <div style="text-align:right">
        <asp:LinkButton ID="btnMigrateSelected" runat="server" UseSubmitBehavior="false" ToolTip="Migrate user" CssClass="btn btn-primary" >
                                                Migrate Selected
                                        </asp:LinkButton>
    </div>
    <div>
        <telerik:RadGrid ID="RadGridEmployeesAsUsers" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceEmployeesAsUsers" GridLines="None" AllowPaging="True"
            CellSpacing="0" AllowSorting="True" PageSize="25" 
            HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small" HeaderStyle-HorizontalAlign="Center" 
            AllowMultiRowSelection="True" Height="1000px">

            <ClientSettings Selecting-AllowRowSelect="true">
                <Scrolling AllowScroll="True" ></Scrolling>
            </ClientSettings>

            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceEmployeesAsUsers" CommandItemDisplay="None" ShowFooter="True" HeaderStyle-Font-Size="Small">
                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                <Columns>
                    <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridClientSelectColumn>
                    <telerik:GridBoundColumn DataField="Id" HeaderText="ID" SortExpression="ID" UniqueName="ID">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="FullName" HeaderText="User Name" SortExpression="FullName" UniqueName="FullName">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Email" HeaderText="Email" SortExpression="Email" UniqueName="Email">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="Email" HeaderText="Is Migrated" SortExpression="IsMigrate" UniqueName="IsMigrate" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <%# LocalAPI.IsUserIdentityMigrated(Eval("Email"))%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="Company" HeaderText="Company" SortExpression="Company" UniqueName="Company">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn HeaderText="Actions" UniqueName="column" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <table class="table-sm" style="width: 100%">
                                <tr>
                                    <td style="width: 80px; text-align: center">
                                        <asp:LinkButton ID="btnMigrate" runat="server" UseSubmitBehavior="false" ToolTip="Migrate user" CssClass="btn btn-primary btn-sm" Visible='<%# Not LocalAPI.IsUserIdentityMigrated(Eval("Email"))%>'
                                            CommandName="Migrate" CommandArgument='<%# Eval("Email")%>'>
                                                Migrate
                                        </asp:LinkButton>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:LinkButton ID="LinkButton1" runat="server" UseSubmitBehavior="false" ToolTip="Migrate user" CssClass="btn btn-secondary btn-sm"
                                            CommandName="SendCredentials" CommandArgument='<%# Eval("Email")%>'>
                                                Send Credentials
                                        </asp:LinkButton>
                                    </td>
                                    <%--                                    <td>
                                        <asp:LinkButton runat="server" ID="btnAzureStorage" CommandName="AzureUpload" CommandArgument='<%# Eval("Id") %>' ToolTip="Upload Files">
                                                <i class="fas fa-cloud-upload-alt"></i>                                                
                                        </asp:LinkButton>

                                    </td>--%>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>

        </telerik:RadGrid>
    </div>

    <hr />
    <div>
        <%--        <telerik:RadGrid ID="RadGrid1" GridLines="None" runat="server" AllowSorting="True"
            AllowAutomaticInserts="False" PageSize="20" AllowAutomaticUpdates="False" AllowMultiRowEdit="False"
            AllowPaging="True" DataSourceID="DataSource1"
            AllowFilteringByColumn="True"
            OnDataBound="RadGrid1_DataBound" OnItemCommand="RadGrid1_ItemCommand" OnItemDataBound="RadGrid1_ItemDataBound" OnPreRender="RadGrid1_PreRender">
            <PagerStyle Mode="NextPrevAndNumeric" />
            <MasterTableView Width="100%" CommandItemDisplay="None" DataKeyNames="Email"
                DataSourceID="DataSource1" HorizontalAlign="NotSet" EditMode="EditForms">
                <Columns>
                    <telerik:GridButtonColumn ButtonType="PushButton" HeaderText="Migrate Password"
                        UniqueName="cmdMigrate" CommandName="cmdMigrate" Text="Migrate">
                    </telerik:GridButtonColumn>

                    <telerik:GridButtonColumn ButtonType="PushButton" HeaderText="Unlock User"
                        UniqueName="cmdUnlock" CommandName="cmdUnlock" Text="Unlock">
                    </telerik:GridButtonColumn>

                    <telerik:GridButtonColumn ButtonType="PushButton" HeaderText="Confirm Email"
                        UniqueName="cmdConfirm" CommandName="cmdConfirm" Text="Confirm Email">
                    </telerik:GridButtonColumn>

                    <telerik:GridButtonColumn ButtonType="PushButton" HeaderText="Send Credentials"
                        UniqueName="cmdSend" CommandName="cmdSend" Text="Send Credentials">
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings>
                    <FormTableItemStyle Wrap="False"></FormTableItemStyle>
                    <FormCaptionStyle CssClass="EditFormHeader"></FormCaptionStyle>
                    <FormMainTableStyle GridLines="None" CellSpacing="0" CellPadding="3" BackColor="White"
                        Width="100%" />
                    <FormTableStyle CellSpacing="0" CellPadding="2" Height="110px" BackColor="White" />
                    <FormTableAlternatingItemStyle Wrap="False"></FormTableAlternatingItemStyle>
                    <EditColumn ButtonType="ImageButton"
                        UniqueName="EditCommandColumn1" CancelText="Cancel edit">
                    </EditColumn>
                    <FormTableButtonRowStyle HorizontalAlign="Right" CssClass="EditFormButtonRow"></FormTableButtonRowStyle>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>--%>
    </div>




    <%--  <asp:SqlDataSource SelectCommand="SELECT [Id] ,[FullName] ,[Email] ,[companyId],  isnull([IsMigrate], 0) as IsMigrate FROM [dbo].[Employees] where Inactive = 0" ConnectionString="Server=axzesu1server.database.windows.net;Database=pasconcept_db;User ID=axzesu1@axzesu1server;Password=P@ssw0rd;Trusted_Connection=False;Encrypt=True;Connection Timeout=30;" ProviderName="System.Data.SqlClient" ID="DataSource1" runat="server"></asp:SqlDataSource>--%>

    <asp:SqlDataSource ID="SqlDataSourceEmployeesAsUsers" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="EmployeesAsUsers_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboMigrateStatusId" Name="MigrateStatusId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboCompany" Name="companyId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtFind" ConvertEmptyStringToNull="False" Name="Filter" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceCompany" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id]=companyId, Name FROM [Company] ORDER BY [Name]"></asp:SqlDataSource>

</asp:Content>
