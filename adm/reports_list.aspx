<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="reports_list.aspx.vb" Inherits="pasconcept20.reports_list" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <telerik:RadTreeList RenderMode="Lightweight" runat="server" ID="TreeListReports" DataSourceID="SqlDataSourceReportsList"
        AutoGenerateColumns="false" AllowPaging="false" DataKeyNames="Name"
        ParentDataKeyNames="RPTGroup">
        <ClientSettings AllowPostBackOnItemClick="true">
        </ClientSettings>
        <Columns>
            <telerik:TreeListTemplateColumn DataField="Name" HeaderText="Name" UniqueName="Name" HeaderStyle-Width="300px">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" UseSubmitBehavior="false" Text='<%# Eval("Name") %>' CommandName='<%# IIf(Eval("Id") = 0, "Expand_Colapse", "Report") %>' CommandArgument='<%# IIf(Eval("Id") = 0, Eval("Name"), Eval("Id"))%>' CssClass="dropdown-item">
                    
                    </asp:LinkButton>
                </ItemTemplate>
            </telerik:TreeListTemplateColumn>
            <telerik:TreeListBoundColumn DataField="Description" HeaderText="Description" UniqueName="Description">
            </telerik:TreeListBoundColumn>
        </Columns>
    </telerik:RadTreeList>

    <asp:SqlDataSource ID="SqlDataSourceReportsList" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="select distinct 0 as [Id],[RPTGroup] as [Name], '' as [RPTGroup],'' as [SQLSource],'' as [Description] FROM [dbo].[Reports] union SELECT  [Id],[Name],[RPTGroup],[SQLSource],[Description] FROM [Reports] WHERE isnull(CustomCompanyId,0)=0 or isnull(CustomCompanyId,0)=@companyId">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
