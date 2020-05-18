<%@ Page Title="Clients Map" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="clientsmap.aspx.vb" Inherits="pasconcept20.clientsmap" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script>
        var $ = $telerik.$;

        function exportContent() {
            $find('<%=RadClientExportManager1.ClientID%>').exportPDF($(".RadMap"));
        }
        function OpenProject(Id) {
            //alert(Id);
            var oWnd = $find("<%=RadWindow1.ClientID%>");
            var url = '../OPE/project.aspx?guId=a454d8ed-d27d-2609-1962-426a02615e1a&Id=' + Id;
            oWnd.setUrl(url);
            oWnd.show();
        }
    </script>
    <style type="text/css">
        .RadMap .k-marker.k-i-marker-active:before {
            color: green;
            font-size:25px;
        }

        .RadMap .k-marker.k-i-marker-inactive:before {
            color: red;
            font-size:25px;
        }

        .RadMap .k-marker.k-i-marker-potencial:before {
            color: blue;
            font-size:25px;
        }
    </style>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook">
        <Windows>
            <telerik:RadWindow ID="RadWindow1"
                VisibleOnPageLoad="false" Behaviors="Close, Move,Maximize,Resize" Modal="true" Width="600" Height="480" runat="server" Title="Project" VisibleStatusbar="False" BorderStyle="None">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>


    <div class="Formulario">
        <table class="table-condensed" style="width: 100%">
            <tr>
                <td style="width: 90px">
                    <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                        <span class="glyphicon glyphicon-filter"></span>&nbsp;Filter
                    </button>
                </td>
                <td style="width: 100px">
                     <asp:LinkButton ID="btnSattelite" runat="server" CssClass="btn btn-primary btn" UseSubmitBehavior="false" Text="Map View">
                    </asp:LinkButton>
                </td>
                <td style="width: 120px">
                    <telerik:RadButton runat="server" OnClientClicked="exportContent" Text="Export PDF" AutoPostBack="false" UseSubmitBehavior="false"></telerik:RadButton>
                </td>
                <td style="text-align: right">
                    <b>Status:</b>
                    &nbsp;&nbsp;&nbsp;
                                    <asp:Image ID="Image4" runat="server" ImageUrl="~/Images/MarkerImages/redmarker.png" />&nbsp;Inactive
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/MarkerImages/greenmarker.png" />&nbsp;Active
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Image ID="Image2" runat="server" ImageUrl="~/Images/MarkerImages/bluemarker.png" />&nbsp;Potential
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Image ID="Image3" runat="server" ImageUrl="~/Images/MarkerImages/blackmarker.png" />&nbsp;Prospective
                </td>

            </tr>
        </table>
    </div>

    <div class="collapse" id="collapseFilter">
        <div class="card card-body">
            <asp:Panel ID="pnlFind" runat="server" class="Formulario" DefaultButton="btnRefresh">
                <table class="table-condensed" style="width: 100%">
                    <tr>
                        <td style="width: 280px">
                            <telerik:RadComboBox ID="cboStatus" runat="server" Width="100%" AppendDataBoundItems="True" DataTextField="Name" DataValueField="Id" DataSourceID="SqlDataSourceClientStatus">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(All Status...)" Value="-1" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                        <td style="width: 280px">
                            <telerik:RadComboBox ID="cboTypes" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceClientTypes" 
                                DataTextField="Name" DataValueField="Id" MarkFirstMatch="True" Width="100%" CausesValidation="False">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(All Clients Types...)" Value="-1" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                        <td style="width: 280px">
                            <telerik:RadComboBox ID="cboDepartments" runat="server" DataSourceID="SqlDataSourceDepartments" DataTextField="Name"
                                DataValueField="Id" Width="100%" AppendDataBoundItems="true">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="(All Departments...)" Value="-1" Selected="true" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtZipCodes" runat="server" Width="100%" x-webkit-speech="x-webkit-speech" EmptyMessage="ZIP Codes comma separated" ToolTip="ZIP Codes comma separated">
                            </telerik:RadTextBox>
                        </td>
                        <td style="text-align: right;width:100px">
                            <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false">
                                    <span class="glyphicon glyphicon-search"></span> Search
                            </asp:LinkButton>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
    </div>
    <div>
        <telerik:RadClientExportManager runat="server" ID="RadClientExportManager1">
                            <PdfSettings FileName="ProjectMap.pdf" />
                        </telerik:RadClientExportManager>
    </div>
    <div>
        <telerik:RadMap runat="server" ID="RadMap1" Zoom="12" DataSourceID="SqlDataSource1"
            Height="700px" Width="100%" BorderStyle="Solid" BorderColor="Gray" BorderWidth="1">
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



    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Clients_Map_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter Name="typeId" ControlID="cboTypes" PropertyName="SelectedValue" />
            <asp:ControlParameter Name="statusId" ControlID="cboStatus" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboDepartments" Name="departmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtZipCodes" ConvertEmptyStringToNull="False" Name="ZIPCodesCommaSeparated" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClientTypes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Clients_types] WHERE ([companyId] = @companyId) ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClientStatus" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] + '. '+[Description] As Name FROM [Clients_status] ORDER BY Id"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>


</asp:Content>

