<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="AATest.aspx.vb" Inherits="pasconcept20.AATest" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">Ebillity Import Manager
        </span>

    </div>
    <div class="pas-container" style="width: 100%">
        <telerik:RadWizard ID="RadWizard" runat="server" DisplayCancelButton="false" DisplayProgressBar="false" DisplayNavigationButtons="false" RenderMode="Lightweight" Skin="Silk">
            <WizardSteps>
                <%--Time Entries--%>
                <telerik:RadWizardStep runat="server" ID="RadWizardStepTimeEntries" Title="Time Entries" StepType="Step">

                    <asp:Panel ID="SyncPanelTimeEntries" runat="server">
                        <div class="pasconcept-bar">
                            <span class="pasconcept-pagetitle">Unlinked Ebillity Activities
                            </span>
                            <span style="float: right; vertical-align: middle;">

                                <asp:Button ID="btnGetTimeEntries" runat="server" Text="Get Timer Entries from Ebillity " CssClass="btn btn-success" />

                            </span>
                        </div>
                        <telerik:RadGrid ID="RadGridTimeEntries" runat="server" Width="100%" DataSourceID="SqlDataSourceTimeEntriesPending"
                            PageSize="50" AllowPaging="true" Height="580px" RenderMode="Lightweight" BorderStyle="None"
                            AllowMultiRowSelection="True" AllowAutomaticDeletes="true"
                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" AlternatingItemStyle-Font-Size="Small"
                            FooterStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                            <ClientSettings Selecting-AllowRowSelect="true">
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="TimeEntryId" DataSourceID="SqlDataSourceTimeEntriesPending">

                                <Columns>

                                    <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" UniqueName="TimeEntriesSelectColumn">
                                    </telerik:GridClientSelectColumn>

                                    <telerik:GridBoundColumn DataField="TimeEntryId" HeaderText="TimeEntryId" HeaderStyle-Width="10px" UniqueName="TimeEntryId" Display="false"></telerik:GridBoundColumn>
                                    
                                    <telerik:GridBoundColumn DataField="fecha"
                                        FilterControlAltText="Filter fecha column" HeaderText="Date"
                                        SortExpression="Date" UniqueName="Date" HeaderStyle-Font-Bold="true">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn HeaderText="Time " UniqueName="TIme" HeaderStyle-Font-Bold="true" >
                                         <ItemTemplate>
                                             <asp:Label runat="server" Text='<%# Eval("TotalHour") & ":" & Eval("TotalMinute") %>'></asp:Label>
                                         </ItemTemplate>                                    
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="Employee"
                                        FilterControlAltText="Employee column" HeaderText="Employee"
                                        SortExpression="Employee" UniqueName="Employee" HeaderStyle-Font-Bold="true">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="Client"
                                        FilterControlAltText="Client column" HeaderText="Client"
                                        SortExpression="Client" UniqueName="Client" HeaderStyle-Font-Bold="true" >
                                    </telerik:GridBoundColumn>

                                    
                                    <telerik:GridBoundColumn DataField="Job"
                                        FilterControlAltText="Project column" HeaderText="Project"
                                        SortExpression="Job" UniqueName="Job" HeaderStyle-Font-Bold="true" >
                                    </telerik:GridBoundColumn>

                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <br />

                    </asp:Panel>

                </telerik:RadWizardStep>

            </WizardSteps>
        </telerik:RadWizard>
    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
    </telerik:RadWindowManager>


    <%--Time Categorie--%>
    <asp:SqlDataSource ID="SqlDataSourceTimeEntriesPending" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JobTimeEntries_Sync_Ebillity_Select" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    







    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceProject" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Client] As Name FROM [Clients]  WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblSelectTimeEntries" runat="server" Visible="False"></asp:Label>
</asp:Content>

