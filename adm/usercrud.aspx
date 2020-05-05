<%@ Page Language="VB" AutoEventWireup="false" CodeBehind="usercrud.aspx.vb" Inherits="pasconcept20.Usercrud" Async="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .MyImageButton {
            cursor: pointer;
            cursor: hand;
        }

        .EditFormHeader td {
            font-size: 14px;
            padding: 4px !important;
            color: #0066cc;
        }
    </style>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button Text="Employes Photos" runat="server" OnClick="Unnamed_Click" />

        <asp:Button ID="btnClients" Text="Clients Photos" runat="server" OnClick="btnClients_Click" />
        <br/>
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
            </Scripts>            
        </telerik:RadScriptManager>
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">
            <telerik:RadGrid ID="RadGrid1" GridLines="None" runat="server" AllowSorting="True"
                AllowAutomaticInserts="False" PageSize="20" AllowAutomaticUpdates="False" AllowMultiRowEdit="False"
                AllowPaging="True" DataSourceID="DataSource1" 
                AllowFilteringByColumn="True" 
                OnDataBound="RadGrid1_DataBound" OnItemCommand="RadGrid1_ItemCommand" OnItemDataBound="RadGrid1_ItemDataBound" OnPreRender="RadGrid1_PreRender" >
                <PagerStyle Mode="NextPrevAndNumeric" />
                <MasterTableView Width="100%" CommandItemDisplay="None" DataKeyNames="Email"
                    DataSourceID="DataSource1" HorizontalAlign="NotSet" EditMode="EditForms">
                    <Columns>
                        <telerik:GridButtonColumn ButtonType="PushButton" HeaderText="Migrate Password" 
                            UniqueName="cmdMigrate" CommandName="cmdMigrate" Text="Migrate">
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
            </telerik:RadGrid>
            <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
        </telerik:RadAjaxPanel>
        <asp:SqlDataSource SelectCommand="SELECT [Id] ,[Name] ,[LastName] ,[FullName] ,[Email] ,[companyId],  isnull([IsMigrate], 0) as IsMigrate FROM [dbo].[Employees] where Inactive = 0" ConnectionString="Server=axzesu1server.database.windows.net;Database=pasconcept_db;User ID=axzesu1@axzesu1server;Password=P@ssw0rd;Trusted_Connection=False;Encrypt=True;Connection Timeout=30;" ProviderName="System.Data.SqlClient" ID="DataSource1" runat="server"></asp:SqlDataSource>
    </form>
</body>
</html>
