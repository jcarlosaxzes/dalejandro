<%@ Page Title="Projects Map" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="projectmap.aspx.vb" Inherits="pasconcept20.projectmap" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script>
        var $ = $telerik.$;

        function OpenProject(Id) {
            //alert(Id);
            console.log(<%=RadWindow1.ClientID%>);
            var oWnd = $find("<%=RadWindow1.ClientID%>");
            var url = '../ope/ope_project.aspx?guId=a454d8ed-d27d-2609-1962-426a02615e1a&Id=' + Id;
            oWnd.setUrl(url);
            oWnd.show();
        }
    </script>
    <style type="text/css">
        .RadMap .k-marker.k-i-marker-public:before {
            color: green;
            font-size: 14px;
        }

        .RadMap .k-marker.k-i-marker-private:before {
            color: red;
            font-size: 14px;
        }

        .RadMap .k-marker.k-i-marker-institution:before {
            color: blue;
            font-size: 14px;
        }
    </style>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
        <Windows>
            <telerik:RadWindow CssClass="project-details" ID="RadWindow1"
                VisibleOnPageLoad="false" Behaviors="Close, Move,Maximize,Resize" Modal="true" Width="600" Height="480" runat="server" Title="Project" VisibleStatusbar="False" BorderStyle="None">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Projects Map</span>

        <span style="float: right; vertical-align: middle;">
                                <b>Sector:</b>
            &nbsp;&nbsp;&nbsp;
                                    <asp:Image ID="Image3" runat="server" ImageUrl="~/Images/MarkerImages/redmarker.png" />&nbsp;Private 
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Image ID="Image5" runat="server" ImageUrl="~/Images/MarkerImages/greenmarker.png" />&nbsp;Public
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Image ID="Image6" runat="server" ImageUrl="~/Images/MarkerImages/bluemarker.png" />&nbsp;Institution
            &nbsp;&nbsp;&nbsp;
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>

            <asp:LinkButton ID="btnSattelite" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" Text="Map View">
            </asp:LinkButton>
        </span>
    </div>

    <div class="collapse" id="collapseFilter">
        <asp:Panel ID="pnlFind" runat="server" class="pasconcept-bar" DefaultButton="btnRefresh">
            <table class="table-sm" style="width: 100%">
                <tr>
                    <td style="width: 180px">
                        <telerik:RadComboBox ID="cboPeriod" runat="server" Width="100%" AppendDataBoundItems="True" MarkFirstMatch="True">
                            <Items>
                                <telerik:RadComboBoxItem Text="Last 30 days" Value="30" Selected="true" />
                                <telerik:RadComboBoxItem Text="Last 60 days" Value="60" />
                                <telerik:RadComboBoxItem Text="Last 90 days" Value="90" />
                                <telerik:RadComboBoxItem Text="Last 120 days" Value="120" />
                                <telerik:RadComboBoxItem Text="Last 180 days" Value="180" />
                                <telerik:RadComboBoxItem Text="Last 365 days" Value="365" />
                                <telerik:RadComboBoxItem Text="(This year...)" Value="14" />
                                <telerik:RadComboBoxItem Text="(Last year...)" Value="15" />
                                <telerik:RadComboBoxItem Text="(All years...)" Value="13" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 250px">
                        <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" DateFormat="MM/dd/yyyy" Width="150px" Culture="en-US" ToolTip="Date From for filter">
                        </telerik:RadDatePicker>
                    </td>
                    <td style="width: 250px">
                        <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" DateFormat="MM/dd/yyyy" Width="150px" Culture="en-US" ToolTip="Date To for filter">
                        </telerik:RadDatePicker>
                    </td>
                    <td colspan="2">
                        <telerik:RadComboBox ID="cboDepartments" runat="server" DataSourceID="SqlDataSourceDepartments" DataTextField="Name"
                            DataValueField="Id" Width="100%" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Departments...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 280px">
                        <telerik:RadComboBox ID="cboJobType" runat="server" DataSourceID="SqlDataSourceJobTypes" DataTextField="Name" DataValueField="Id" Width="100%"
                            AppendDataBoundItems="true" Height="300px">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Job Types...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <telerik:RadComboBox ID="cboClients" runat="server" DataSourceID="SqlDataSourceClients"
                            Width="100%" DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Clients...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>

                    </td>
                    <td colspan="2">
                        <telerik:RadComboBox ID="cboEmployee" runat="server" DataSourceID="SqlDataSourceEmpl" MarkFirstMatch="True" ToolTip="Select active Employye (this year)"
                            Width="100%" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Employees...)" Value="0" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtZipCodes" runat="server" Width="100%" x-webkit-speech="x-webkit-speech" EmptyMessage="ZIP Codes comma separated" ToolTip="ZIP Codes comma separated">
                        </telerik:RadTextBox>
                    </td>
                    <td style="width: 150px; text-align: right;">
                        <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>

    <div class="pasconcept-bar">
        <telerik:RadMap runat="server" ID="RadMap1" Zoom="10" DataSourceID="SqlDataSource1" Skin="Default" Height="800px" Width="100%">
            <ControlsSettings Attribution="false">
                <NavigatorSettings Position="BottomLeft" />
            </ControlsSettings>
            <CenterSettings Latitude="25.803670" Longitude="-80.334748" />
            <DataBindings>
                <MarkerBinding DataShapeField="Shape" DataTitleField="Title" DataLocationLatitudeField="Latitude" DataLocationLongitudeField="Longitude" />

            </DataBindings>
            <LayersCollection>
                <telerik:MapLayer></telerik:MapLayer>
            </LayersCollection>
            <MarkersCollection>
                <telerik:MapMarker Shape="myCustomShape">
                    <LocationSettings Latitude="0" Longitude="0" />
                </telerik:MapMarker>
            </MarkersCollection>

        </telerik:RadMap>
    </div>

    <%-- <telerik:LayoutRow>
                <Columns>
                    <telerik:LayoutColumn Span="12">
                        <telerik:RadImageGallery ID="RadImageGallery1" runat="server" DataSourceID="SqlDataSourcePhotos"
                            DataKeyNames="Id"
                            DataDescriptionField="ImgDescription"
                            DataImageField="Photo"
                            DisplayAreaMode="LightBox" Width="100%"
                            LoopItems="true" Height="80px" AllowPaging="true" PageSize="100">

                            <ThumbnailsAreaSettings ThumbnailWidth="120px" ThumbnailHeight="80px" ThumbnailsSpacing="1px" Height="80px" ShowScrollButtons="true" />
                            <ImageAreaSettings Height="600px" />
                        </telerik:RadImageGallery>
                    </telerik:LayoutColumn>
                </Columns>
            </telerik:LayoutRow>--%>
    <div>
    </div>


    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOBS5_Map_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter Name="DateFrom" Type="DateTime" ControlID="RadDatePickerFrom" PropertyName="SelectedDate" />
            <asp:ControlParameter Name="DateTo" Type="DateTime" ControlID="RadDatePickerTo" PropertyName="SelectedDate" />
            <asp:ControlParameter Name="Type" Type="String" ControlID="cboJobType" PropertyName="SelectedValue" />
            <asp:ControlParameter Name="clientId" Type="String" ControlID="cboClients" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboDepartments" Name="departmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboEmployee" Name="employeeId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtZipCodes" ConvertEmptyStringToNull="False" Name="ZIPCodesCommaSeparated" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <%-- <asp:SqlDataSource ID="SqlDataSourcePhotos" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOBS2_Photos_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter Name="DateFrom" Type="DateTime" ControlID="RadDatePickerFrom" PropertyName="SelectedDate" />
            <asp:ControlParameter Name="DateTo" Type="DateTime" ControlID="RadDatePickerTo" PropertyName="SelectedDate" />
            <asp:ControlParameter Name="Type" Type="String" ControlID="cboJobType" PropertyName="SelectedValue" />
            <asp:ControlParameter Name="clientId" Type="String" ControlID="cboClients" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtZipCodes" ConvertEmptyStringToNull="False" Name="ZIPCodesCommaSeparated" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>--%>
    <asp:SqlDataSource ID="SqlDataSourceClients" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Client] As Name FROM [Clients]  WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceYears" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Year], nYear FROM Years ORDER BY Year DESC"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceJobTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Jobs_types] WHERE companyId=@companyId ORDER BY [Id]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceEmpl" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="EMPLOYEES2_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

