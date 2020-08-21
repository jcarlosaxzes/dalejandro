<%@ Page Title="Quick Books Test" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="QueicBooksTestPages.aspx.vb" Inherits="pasconcept20.QueicBooksTestPages" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

     <br />
        <asp:Button ID="btnConnect" runat="server" Text="Connect to QuickBook" OnClick="btnConnect_Click" />&nbsp;&nbsp;  <asp:Label ID="lblResutl" runat="server" Text=""></asp:Label>
    <br />


    <asp:Panel ID="SyncPanel" runat="server">

     <br />
        <asp:Button ID="btnGetCustomers" runat="server" Text="Reload QuicBooks Customers" OnClick="btnGetCustomers_Click" />&nbsp;&nbsp;  <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
    <br />

    <br />
    <br />
    <h3>QuickBooks Customers</h3>
    <br />
    
    <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" Width="100%" DataSourceID="SqlDataSourceClientPending" >
    <MasterTableView AutoGenerateColumns="False" DataKeyNames="DisplayName" DataSourceID="SqlDataSourceClientPending">
        <ColumnGroups>
            <telerik:GridColumnGroup HeaderText="QuickBooks Customers"  Name="QuickBooksCustomers" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50%"/>
            <telerik:GridColumnGroup HeaderText="PASconcept Suggest Clients" Name="Clients" HeaderStyle-HorizontalAlign="Center"/>
            <telerik:GridColumnGroup HeaderText="Acctions" Name="Acctions" HeaderStyle-HorizontalAlign="Center"/>
        </ColumnGroups>
        <Columns>
            
            <telerik:GridBoundColumn DataField="DisplayName"
                FilterControlAltText="Filter DisplayName column" HeaderText="DisplayName"
                SortExpression="DisplayName" UniqueName="DisplayName" ColumnGroupName="QuickBooksCustomers">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="Email"
                FilterControlAltText="Filter Email column" HeaderText="Email"
                SortExpression="Email" UniqueName="Email" ColumnGroupName="QuickBooksCustomers">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="CompanyName"
                FilterControlAltText="Filter CompanyName column" HeaderText="CompanyName"
                SortExpression="CompanyName" UniqueName="CompanyName" ColumnGroupName="QuickBooksCustomers">
            </telerik:GridBoundColumn>
            

            <telerik:GridTemplateColumn   HeaderText=""  UniqueName="Acctions"  ColumnGroupName="Acctions" HeaderStyle-HorizontalAlign="Center"
                 ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                 <ItemTemplate>
                           <asp:LinkButton ID="btnLink" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false" 
                               ToolTip="Link to PASconcept Client" visible='<%# IIf(TypeOf Eval("Name") Is DBNull, "False", "True") %>' CommandName="Link" CommandArgument='<%# String.Concat(Eval("QBId"), ",", Eval("Id")) %>'>
                                <i class="fas fa-link" aria-hidden="true" ></i>
                           </asp:LinkButton>
                            <asp:LinkButton ID="btnCreate" runat="server"  CssClass="selectedButtons" UseSubmitBehavior="false" 
                                ToolTip="Clone to PASconcept Client" visible='<%# IIf(TypeOf Eval("Name") Is DBNull, "True", "False") %>' CommandName="CreateNew" CommandArgument='<%# Eval("QBId")%>'>
                                <i class="far fa-clone" aria-hidden="true" ></i>
                            </asp:LinkButton>
                 </ItemTemplate>
            </telerik:GridTemplateColumn>

            <telerik:GridBoundColumn DataField="Name"
                FilterControlAltText="Name column" HeaderText="Name"
                SortExpression="Name" UniqueName="Name"  ColumnGroupName="Clients">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="cEmail"
                FilterControlAltText=" Email column" HeaderText="cEmail"
                SortExpression="cEmail" UniqueName="cEmail"  ColumnGroupName="Clients">
            </telerik:GridBoundColumn>
        </Columns>
    </MasterTableView>
</telerik:RadGrid>

    <br />
    <h3>QuickBooks Linked Clients</h3>
    <br />

    <telerik:RadGrid ID="RadGridLinked" runat="server" AllowPaging="True" Width="100%" DataSourceID="SqlDataSourceQBLinked" >
    <MasterTableView AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceQBLinked">

        <Columns>
            <telerik:GridBoundColumn DataField="Name"
                FilterControlAltText="Filter Name column" HeaderText="Name"
                SortExpression="Name" UniqueName="Name">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="Email"
                FilterControlAltText="Filter Email column" HeaderText="Email"
                SortExpression="Email" UniqueName="Email">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="Company"
                FilterControlAltText="Filter Company column" HeaderText="Company"
                SortExpression="Company" UniqueName="Company" >
            </telerik:GridBoundColumn>
            

            <telerik:GridTemplateColumn   HeaderText="Acctions"  UniqueName="Acctions"  HeaderStyle-HorizontalAlign="Center"
                 ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                 <ItemTemplate>
                           <asp:LinkButton ID="btnLink" runat="server" CssClass="selectedButtons" UseSubmitBehavior="false" 
                               ToolTip="Unlink from Quickbooks" CommandName="UnLink" CommandArgument='<%# Eval("Id")%>'>
                                <i class="fas fa-unlink" aria-hidden="true"></i>
                           </asp:LinkButton>
                 </ItemTemplate>
            </telerik:GridTemplateColumn>
        </Columns>
    </MasterTableView>
</telerik:RadGrid>


    

    </asp:Panel>
     <asp:SqlDataSource ID="SqlDataSourceClientPending" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENT_Sync_QBO_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceQBLinked" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENT_linked_QBO_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>

