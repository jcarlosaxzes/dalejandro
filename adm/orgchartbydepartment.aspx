﻿<%@ Page Title="Organization Chart by Department" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="orgchartbydepartment.aspx.vb" Inherits="pasconcept20.orgchartbydepartment" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
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
    </div>

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Organization Chart by Department </span>

        <span style="float: right; vertical-align: middle;">
            <telerik:RadButton ID="btnOrientation" runat="server" ToggleType="CustomToggle" ButtonType="ToggleButton">
                <ToggleStates>
                    <telerik:RadButtonToggleState Text="Vertical" PrimaryIconCssClass="rbToggleCheckboxFilled" Selected="true" />
                    <telerik:RadButtonToggleState Text="Horizontal" PrimaryIconCssClass="rbToggleCheckbox" />
                </ToggleStates>
            </telerik:RadButton>
            <telerik:RadButton runat="server" OnClientClicked="exportRadOrgChart" Text="Export PDF" AutoPostBack="false" UseSubmitBehavior="false">
                    </telerik:RadButton>
            <telerik:RadButton ID="btnPrivate" runat="server" ToggleType="CustomToggle" ButtonType="ToggleButton">
                        <ToggleStates>
                            <telerik:RadButtonToggleState Text="Private" PrimaryIconCssClass="rbToggleCheckboxFilled" Selected="true" />
                            <telerik:RadButtonToggleState Text="Public" PrimaryIconCssClass="rbToggleCheckbox" />
                        </ToggleStates>
                    </telerik:RadButton>
        </span>
    </div>


    <%--class="foo..." allow scroll in OrgChar--%>
    <div class="pas-container foo" style="width: 100%">
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
    <asp:Label ID="lblCompanyName" runat="server" Text="COMPANY"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>

