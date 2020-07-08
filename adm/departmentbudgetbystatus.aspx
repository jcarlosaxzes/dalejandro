<%@ Page Title="Department Budget by Status" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="departmentbudgetbystatus.aspx.vb" Inherits="pasconcept20.departmentbudgetbystatus" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Departments Budget Status</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>

        </span>
    </div>

    <div class="collapse" id="collapseFilter">

        <asp:Panel ID="PanelFilter" runat="server" DefaultButton="btnFind">
            <table class="table-sm pasconcept-bar" style="width: 100%">
                <tr>
                    <td style="width: 350px">From:
                                <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" DateFormat="MM/dd/yyyy" Width="120px" Culture="en-US" ToolTip="Date From of the filter">
                                </telerik:RadDatePicker>
                        &nbsp;&nbsp;&nbsp;To:
                                <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" DateFormat="MM/dd/yyyy" Width="120px" Culture="en-US">
                                </telerik:RadDatePicker>
                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboClients" runat="server" AppendDataBoundItems="true" DataSourceID="SqlDataSourceClient" ToolTip="Clients"
                            DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" MarkFirstMatch="True" Width="450px">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Selected="true" Text="(All Clients...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>

                    </td>
                    <td style="width: 150px; text-align: right">
                        <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:Panel>

    </div>




    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"
             HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small">
            <MasterTableView DataKeyNames="Departament" DataSourceID="SqlDataSource1" ShowFooter="True">
                <Columns>
                    <telerik:GridBoundColumn DataField="Departament" HeaderText="Departament" SortExpression="Departament"
                        UniqueName="Departament" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="300px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn Aggregate="Sum" DataField="AllStatus" DataFormatString="{0:N0}"
                        FooterAggregateFormatString="{0:N0}" HeaderText="AllStatus"
                        SortExpression="AllStatus" UniqueName="AllStatus"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn Aggregate="Sum" DataField="NotInProgress" DataFormatString="{0:N0}"
                        FooterAggregateFormatString="{0:N0}" HeaderText="Not In Progress"
                        SortExpression="NotInProgress" UniqueName="NotInProgress"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn Aggregate="Sum" DataField="InProgress" DataFormatString="{0:N0}"
                        FooterAggregateFormatString="{0:N0}" HeaderText="In Progress"
                        SortExpression="InProgress" UniqueName="InProgress"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn Aggregate="Sum" DataField="OnHold" DataFormatString="{0:N0}"
                        FooterAggregateFormatString="{0:N0}" HeaderText="On Hold"
                        SortExpression="OnHold" UniqueName="OnHold"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn Aggregate="Sum" DataField="Submitted" DataFormatString="{0:N0}"
                        FooterAggregateFormatString="{0:N0}" HeaderText="Submitted"
                        SortExpression="Submitted" UniqueName="Submitted"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn Aggregate="Sum" DataField="UnderRevision" DataFormatString="{0:N0}"
                        FooterAggregateFormatString="{0:N0}" HeaderText="Under Revision"
                        SortExpression="UnderRevision" UniqueName="UnderRevision"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn Aggregate="Sum" DataField="Approved" DataFormatString="{0:N0}"
                        FooterAggregateFormatString="{0:N0}" HeaderText="Approved"
                        SortExpression="Approved" UniqueName="Approved"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn Aggregate="Sum" DataField="Done" DataFormatString="{0:N0}"
                        FooterAggregateFormatString="{0:N0}" HeaderText="Done"
                        SortExpression="Done" UniqueName="Done"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn Aggregate="Sum" DataField="Inactive" DataFormatString="{0:N0}"
                        FooterAggregateFormatString="{0:N0}" HeaderText="Inactive"
                        SortExpression="Inactive" UniqueName="Inactive"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                    </telerik:GridBoundColumn>

                </Columns>
            </MasterTableView>
            <FilterMenu EnableTheming="True">
                <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
            </FilterMenu>
        </telerik:RadGrid>
    </div>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Department_BudgetByStatus" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="DateFrom" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="DateTo" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="cboClients" Name="ClientId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Client] As Name FROM [Clients]  WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourcePaymentMethod" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Id, Name FROM Payment_methods ORDER BY Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblPaymentId" runat="server" Visible="False"></asp:Label>

    <asp:Label ID="lblOriginalFileName" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblKeyName" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblContentBytes" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblContentType" runat="server" Visible="False"></asp:Label>

</asp:Content>

