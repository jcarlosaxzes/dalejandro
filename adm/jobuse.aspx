<%@ Page Title="Use & Occupancy Classification" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="jobuse.aspx.vb" Inherits="pasconcept20.jobuse" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

         <telerik:RadPageLayout ID="RadPageLayout1" runat="server" GridType="Fluid">
        <Rows>
            <telerik:LayoutRow>
                <Content>
                    <telerik:RadGrid ID="RadGrid1" DataSourceID="SqlDataSource1" runat="server" AutoGenerateColumns="False" GridLines="none">
                    <MasterTableView DataSourceID="SqlDataSource1" ShowHeader="false">
                        <GroupByExpressions>
                            <telerik:GridGroupByExpression>
                                <SelectFields>
                                    <telerik:GridGroupByField FieldAlias="Group" FieldName="Group" HeaderText=""  
                                        HeaderValueSeparator=" "></telerik:GridGroupByField>
                                </SelectFields>
                                <GroupByFields>
                                    <telerik:GridGroupByField FieldName="Group" HeaderText=""></telerik:GridGroupByField>
                                </GroupByFields>
                            </telerik:GridGroupByExpression>
                        </GroupByExpressions>
                        <Columns>
                            <telerik:GridTemplateColumn UniqueName="GroupLevel2_Id" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true" ItemStyle-Font-Size="Medium">
                                <ItemTemplate>
                                    <asp:Label ID="NameLabel0" runat="server" Text='<%# Eval("GroupLevel2_Id")%>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn UniqueName="GroupLevel2_description"  ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="NameLabel2" runat="server" Text='<%# Eval("GroupLevel2_description")%>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
                </Content>
            </telerik:LayoutRow>

        </Rows>
    </telerik:RadPageLayout>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Use_and_Occupance_SELECT" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>




