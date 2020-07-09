<%@ Page Title="Projects Tag Search" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="tagcloud.aspx.vb" Inherits="pasconcept20.tagcloud" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Projects Tag Search</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>
            <asp:LinkButton ID="btnExport" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" Visible="false">
                                    Export CSV
                    </asp:LinkButton>
        </span>
    </div>

    <div class="collapse" id="collapseFilter">

        <table class="table-sm pasconcept-bar" style="width:100%">
            <tr>
                <td style="width: 450px">
                    <telerik:RadComboBox ID="cboDepartments" runat="server" DataSourceID="SqlDataSourceDepartments" DataTextField="Name" AutoPostBack="true"
                        DataValueField="Id" Width="100%" AppendDataBoundItems="true" Label="Department:">
                    </telerik:RadComboBox>
                </td>
                <td>
                    <telerik:RadComboBox ID="cboMultiselectTagCONTAINS" runat="server" DataSourceID="SqlDataSourceTag" DataTextField="Tag" DataValueField="Id" Label="Tag Contains"
                        Width="100%" CheckBoxes="true" Height="300px" EnableCheckAllItemsCheckBox="false" MarkFirstMatch="True" Filter="Contains" EmptyMessage="(All Tags...)">
                        <Localization AllItemsCheckedString="All Items Checked" CheckAllString="Check All..." ItemsCheckedString="items checked"></Localization>
                    </telerik:RadComboBox>
                </td>
                <td style="width: 120px; text-align: right">
                    <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <telerik:RadGrid ID="RadGridJobs" runat="server" AllowAutomaticDeletes="True" AutoGenerateColumns="False" DataSourceID="SqlDataSourceJobs">
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceJobs"
                ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" HeaderStyle-Font-Size="Small" HeaderStyle-HorizontalAlign="Center">
                <Columns>
                    <telerik:GridBoundColumn DataField="Code" HeaderText="Number" SortExpression="Code" UniqueName="Code" HeaderStyle-Width="100px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Job" HeaderText="Job" SortExpression="Job" UniqueName="Job">
                    </telerik:GridBoundColumn>
                    <telerik:GridDateTimeColumn DataField="Date" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Date" SortExpression="Date" UniqueName="Date" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                    </telerik:GridDateTimeColumn>
                    <telerik:GridBoundColumn DataField="Client" HeaderText="Client" SortExpression="Client" UniqueName="Client">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Budget" HeaderText="Budget" SortExpression="Budget" UniqueName="Budget" DataFormatString="{0:C0}">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Tag" HeaderText="Tags" SortExpression="Tag" UniqueName="Tag">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>


    <asp:SqlDataSource ID="SqlDataSourceJobs" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JobsTagFinder_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Name="TagCONTAINS"/>
        </SelectParameters>
    </asp:SqlDataSource>


<%--    <asp:SqlDataSource ID="SqlDataSourceTagAndWeight" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Analytics_tags_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboDepartments" Name="DepartmentId" PropertyName="SelectedValue" />
            <asp:Parameter Name="Find" DefaultValue="" ConvertEmptyStringToNull="False" />
        </SelectParameters>
    </asp:SqlDataSource>--%>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTag" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Project_tags_JOB_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboDepartments" Name="departmenId" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="CategoryId" DefaultValue="-1" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>

</asp:Content>

