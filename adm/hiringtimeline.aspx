<%@ Page Title="Hiring Timeline" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="hiringtimeline.aspx.vb" Inherits="pasconcept20.hiringtimeline" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<%@ Import Namespace="pasconcept20" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnFind">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadTimelineHiring" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" EnableEmbeddedSkins="false" />

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Hiring Timeline</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>
        </span>

    </div>
    <div class="collapse" id="collapseFilter">
        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnFind">
            <table style="width:100%" class="pasconcept-bar noprint">
                <tr>
                    <td style="width: 100px; text-align: right">Status:</td>
                    <td style="width: 250px">
                        <telerik:RadComboBox ID="cboStatus" runat="server" Width="100%" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(Active Employees...)" Value="0" Selected="true" />
                                <telerik:RadComboBoxItem runat="server" Text="(Inactive Employees...)" Value="1" />
                                <telerik:RadComboBoxItem runat="server" Text="(All Employees...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 100px; text-align: right">Department:</td>
                    <td style="width: 350px">
                        <telerik:RadComboBox ID="cboDepartments" runat="server" AppendDataBoundItems="true"
                            DataSourceID="SqlDataSourceDepartments" DataTextField="Name" DataValueField="Id" Filter="Contains"
                            Height="250px" MarkFirstMatch="True" Width="100%" EmptyMessage="(Select Department...)">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Selected="true" Text="(All Departments...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>

                    </td>
                    <td style="width: 150px; text-align: right">
                        <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false" CausesValidation="false">
                                                <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:Panel>

    </div>

    <div style="margin-top: 15px">
        <telerik:RadTimeline runat="server" ID="RadTimelineHiring" BorderColor="WhiteSmoke" BorderStyle="Solid" BorderWidth="1" 
            DataSourceID="SqlDataSourceEmployeesHiringTimeLine"
            DataTitleField="FullName"
            DataSubtitleField="Position"
            Orientation="Vertical"
            AlternatingMode="true"
            DataKeyNames="City,State,Status,Department"
            DataDateField="HireDate"
            Navigatable="true">
            <EventTemplate>
                <div class="k-card-header">
                    <h4 class="k-card-title">#=data.FullName#</h4>
                    #=data.Position# of <b>#=data.Department#</b>
                </div>
                <div class="k-card-body">
                    <div class="k-card-description">
                        <p>
                            #=data.City#, #=data.State#
                        </p>
                        # var images = data.images; 
                        if(images && images.length > 0) { #
                            <img src="#=images[0].src#" class="box-photo shadow-sm p-2 mb-2 bg-white rounded">
                        # } #
                    </div>
                    <div>
                        <h6>#=data.Status#</h6>
                    </div>
                </div>
            </EventTemplate>
            <WebServiceClientDataSource>
                <SortExpressions>
                    <telerik:ClientDataSourceSortExpression FieldName="HireDate" SortOrder="Desc" />
                </SortExpressions>
                <Schema>
                    <Model>
                        <telerik:ClientDataSourceModelField DataType="Date" FieldName="HireDate" />
                    </Model>
                </Schema>
            </WebServiceClientDataSource>
        </telerik:RadTimeline>
    </div>


    <asp:SqlDataSource ID="SqlDataSourceEmployeesHiringTimeLine" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="EmployeesHiringTimeLine_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboStatus" Name="InactiveId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboDepartments" Name="departmentId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>


</asp:Content>
