<%@ Page Title="Organization Chart by Department" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="orgchartbydepartment.aspx.vb" Inherits="pasconcept20.orgchartbydepartment" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../App_Themes/Estandar/OrgChartStyle.css" rel="stylesheet" type="text/css" />
    <telerik:RadPageLayout ID="RadPageLayout1" runat="server" GridType="Fluid">
        <Rows>
            <telerik:LayoutRow>
                <Content>
                    <table class="table-sm" style="width: 100%">
                        <tr>
                            <td style="width: 100px; text-align: right; vertical-align: bottom">

                                <asp:Image ID="Image8" runat="server" ImageUrl="~/Images/Toolbar/orgchart-icon.png" Width="48px" />

                            </td>
                            <td style="width: 450px; text-align: left">
                                <asp:Label ID="lblCompanyName" runat="server" Text="COMPANY" CssClass="Titulo2"></asp:Label>
                                <br />
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Label ID="lABEL2" runat="server" Text="Department Structure" CssClass="Titulo3"></asp:Label>
                            </td>
                            <td style="width: 100px; vertical-align: top">
                                <telerik:RadButton ID="btnPrivate" runat="server" ToggleType="CustomToggle" ButtonType="ToggleButton">
                                    <ToggleStates>
                                        <telerik:RadButtonToggleState Text="Private" PrimaryIconCssClass="rbToggleCheckboxFilled" Selected="true" />
                                        <telerik:RadButtonToggleState Text="Public" PrimaryIconCssClass="rbToggleCheckbox" />
                                    </ToggleStates>
                                </telerik:RadButton>
                            </td>
                            <td style="width: 100px; vertical-align: top">
                                <telerik:RadButton ID="btnOrientation" runat="server" ToggleType="CustomToggle" ButtonType="ToggleButton">
                                    <ToggleStates>
                                        <telerik:RadButtonToggleState Text="Vertical" PrimaryIconCssClass="rbToggleCheckboxFilled" Selected="true" />
                                        <telerik:RadButtonToggleState Text="Horizontal" PrimaryIconCssClass="rbToggleCheckbox" />
                                    </ToggleStates>
                                </telerik:RadButton>
                            </td>
                            <td style="vertical-align: top; text-align: left">
                                <telerik:RadButton runat="server" OnClientClicked="exportRadOrgChart" Text="Export PDF" AutoPostBack="false" UseSubmitBehavior="false">
                                </telerik:RadButton>
                            </td>
                        </tr>
                    </table>
                    <telerik:RadClientExportManager runat="server" ID="RadClientExportManager1">
                        <PdfSettings FileName="OrganizationChart.pdf" />
                    </telerik:RadClientExportManager>
                    <telerik:RadScriptBlock runat="Server" ID="RadScriptBlock1">
                        <script>
                            var $ = $telerik.$;

                            function exportRadOrgChart() {
                                $find('<%=RadClientExportManager1.ClientID%>').exportPDF($(".RadOrgChart"));
                        }

                        var fontSize = 12;
                        $(document).ready(function () {


                            $('.foo').bind('DOMMouseScroll mousewheel', function (event) {
                                if (event.originalEvent.wheelDelta > 0 || event.originalEvent.detail < 0) {
                                    fontSize++;
                                    $(".RadOrgChart").css("font-size", fontSize + "px");
                                }
                                else {
                                    fontSize--;
                                    $(".RadOrgChart").css("font-size", fontSize + "px");
                                }

                                event.preventDefault();
                            });
                        });
                        </script>
                    </telerik:RadScriptBlock>

                </Content>
            </telerik:LayoutRow>

            <telerik:LayoutRow>
                <Content>
                    <div class="foo" style="width:100%">
                        <telerik:RadOrgChart ID="RadOrgChart1" runat="server" 
                            GroupColumnCount="2" 
                            EnableCollapsing="true" 
                            EnableGroupCollapsing="true" 
                            RenderMode="Lightweight" Width="100%" Skin="Silk">
                            <GroupEnabledBinding>
                                <NodeBindingSettings
                                    DataFieldID="Id"
                                    DataFieldParentID="ParentID"
                                    DataSourceID="SqlDataSourceDepartments" />
                                <GroupItemBindingSettings
                                    DataFieldNodeID="DepartmentId"
                                    DataFieldID="Id"
                                    DataTextField="FullName"
                                    DataImageUrlField="ImageUrl"
                                    DataSourceID="SqlDataSource1" />
                            </GroupEnabledBinding>
                            <RenderedFields>
                                <NodeFields>
                                    <telerik:OrgChartRenderedField DataField="Department" />
                                    <telerik:OrgChartRenderedField DataField="Budget" />
                                    <telerik:OrgChartRenderedField DataField="Executed" />
                                    <telerik:OrgChartRenderedField DataField="Balance" />
                                </NodeFields>
                                <ItemFields>
                                    <telerik:OrgChartRenderedField DataField="Position" />
                                </ItemFields>
                            </RenderedFields>
                            <Nodes>
                                <telerik:OrgChartNode ColumnCount="3"></telerik:OrgChartNode>
                            </Nodes>
                        </telerik:RadOrgChart>
                    </div>

                </Content>
            </telerik:LayoutRow>
        </Rows>
    </telerik:RadPageLayout>


    <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="OrgChart_Emplyees_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="OrgChart_Departments_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
            <asp:ControlParameter ControlID="lblCompanyId" DefaultValue="" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>

