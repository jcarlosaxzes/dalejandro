<%@ Page Title="Margins per Client" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="clients_monthlytimeandcosts.aspx.vb" Inherits="pasconcept20.clients_monthlytimeandcosts" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"  EnableEmbeddedSkins="false" />

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Margins per Clients</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>
            
            <asp:LinkButton ID="btnExport" runat="server" ToolTip="Export records to Excel" Width="100px"
                                CssClass="btn btn-secondary btn" UseSubmitBehavior="false">
                                    <i class="fas fa-download"></i> Export
                            </asp:LinkButton>
        </span>


    </div>



    <div class="collapse" id="collapseFilter">
        <table class="table-sm" style="width: 100%">
            <tr>
                <td style="width: 150px">
                    <telerik:RadComboBox ID="cboYear" runat="server" DataSourceID="SqlDataSourceYears" DataTextField="nYear" DataValueField="Year" Width="100%" AppendDataBoundItems="True">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(All Years...)" Value="-1" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td style="width: 350px">
                    <telerik:RadComboBox ID="cboClients" runat="server" DataSourceID="SqlDataSourceClient" 
                        DataTextField="Name" DataValueField="Id" Width="100%" MarkFirstMatch="True" AppendDataBoundItems="True"
                        Filter="Contains" Height="300px">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(All Clients...)" Value="-1" />
                        </Items>
                    </telerik:RadComboBox>

                </td>
                <td style="width: 300px">
                    <telerik:RadComboBox ID="cboDepartment" runat="server" AppendDataBoundItems="True" 
                        DataSourceID="SqlDataSourceDepartments" DataTextField="Name" DataValueField="Id"
                        Width="100%" MarkFirstMatch="True"
                        Filter="Contains" Height="300px">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(Select Department...)" Value="0" />
                        </Items>
                    </telerik:RadComboBox>

                </td>
                <td >
                    <telerik:RadComboBox ID="cboEmployees" runat="server" DataSourceID="SqlDataSourceEmployees" 
                        DataTextField="Name" DataValueField="Id" Width="300px" MarkFirstMatch="True" AppendDataBoundItems="True"
                        Filter="Contains" Height="300px">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(All Employees...)" Value="-1" />
                        </Items>
                    </telerik:RadComboBox>

                </td>
                <td style="width: 150px;text-align:right">
                    <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>
                </td>

            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="RadGridMonthly" runat="server" DataSourceID="SqlDataSourceMonthly" Width="100%" Height="800px" Visible="false"
            AutoGenerateColumns="False" AllowPaging="True" PageSize="100" AllowSorting="True" ShowFooter="true" HeaderStyle-Font-Size="X-Small">
            <ExportSettings>
                <Excel Format="BIFF" />
            </ExportSettings>
            <ClientSettings>
                <Scrolling AllowScroll="True" UseStaticHeaders="True" FrozenColumnsCount="1"></Scrolling>
            </ClientSettings>

            <MasterTableView DataKeyNames="ClientName" DataSourceID="SqlDataSourceMonthly">
                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                <ColumnGroups>
                    <telerik:GridColumnGroup Name="Jan" HeaderText="January" HeaderStyle-HorizontalAlign="Center" />
                    <telerik:GridColumnGroup Name="Feb" HeaderText="February" HeaderStyle-HorizontalAlign="Center" />
                    <telerik:GridColumnGroup Name="Mar" HeaderText="March" HeaderStyle-HorizontalAlign="Center" />
                    <telerik:GridColumnGroup Name="Apr" HeaderText="April" HeaderStyle-HorizontalAlign="Center" />
                    <telerik:GridColumnGroup Name="May" HeaderText="May" HeaderStyle-HorizontalAlign="Center" />
                    <telerik:GridColumnGroup Name="Jun" HeaderText="June" HeaderStyle-HorizontalAlign="Center" />
                    <telerik:GridColumnGroup Name="Jul" HeaderText="July" HeaderStyle-HorizontalAlign="Center" />
                    <telerik:GridColumnGroup Name="Aug" HeaderText="August" HeaderStyle-HorizontalAlign="Center" />
                    <telerik:GridColumnGroup Name="Sep" HeaderText="September" HeaderStyle-HorizontalAlign="Center" />
                    <telerik:GridColumnGroup Name="Oct" HeaderText="October" HeaderStyle-HorizontalAlign="Center" />
                    <telerik:GridColumnGroup Name="Nov" HeaderText="November" HeaderStyle-HorizontalAlign="Center" />
                    <telerik:GridColumnGroup Name="Dec" HeaderText="December" HeaderStyle-HorizontalAlign="Center" />
                    <telerik:GridColumnGroup Name="Tot" HeaderText="Totals" HeaderStyle-HorizontalAlign="Center" />
                </ColumnGroups>
                <Columns>
                    <telerik:GridBoundColumn DataField="ClientName" FilterControlAltText="Filter ClientName column" HeaderText="Client" SortExpression="ClientName" UniqueName="ClientName"
                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="160px" ItemStyle-Font-Size="X-Small">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TotT" FilterControlAltText="Filter TotT column" HeaderText="T-T" SortExpression="TotT" UniqueName="TotT"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}"
                        FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="50px" ItemStyle-Font-Size="x-Small" ItemStyle-Font-Italic="true"
                        ColumnGroupName="Tot" HeaderTooltip="[Total Time] = SUM([Employee time])">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TotC" FilterControlAltText="Filter TotC column" HeaderText="T-C" SortExpression="TotC" UniqueName="TotC" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="80px" ItemStyle-Font-Size="Small"
                        ColumnGroupName="Tot" HeaderTooltip="[Total Cost] = SUM([Employee Time] * [Employee Hourly Rate])">
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="Paym" FilterControlAltText="Filter Paym column" HeaderText="Paym" SortExpression="Paym" UniqueName="Paym" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="80px" ItemStyle-Font-Size="Small"
                        ColumnGroupName="Tot" HeaderTooltip="[Total Payments] = SUM(Client Payments)">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="Margen" FilterControlAltText="Filter Margen column" HeaderText="Balance" SortExpression="Margen" UniqueName="Margen" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="80px" ItemStyle-Font-Size="Small"
                        ColumnGroupName="Tot" HeaderTooltip="[Client Margen] = [Total Payments] - [Total Cost]">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblMargen" Text='<%# Eval("Margen", "{0:N0}")%>'
                                ForeColor='<%# GetMagenColor(Eval("Margen"))%>' Font-Bold='<%# Eval("Margen") > 0 %>'>
                            </asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="JanT" FilterControlAltText="Filter JanT column" HeaderText="T(h)" HeaderTooltip="Time (hours)" SortExpression="JanT" UniqueName="JanT"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="40px" ItemStyle-Font-Size="X-Small" ItemStyle-Font-Italic="true"
                        ColumnGroupName="Jan">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="JanC" FilterControlAltText="Filter JanC column" HeaderText="C($)" HeaderTooltip="Cost ($)" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="JanC" UniqueName="JanC"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="50px" ItemStyle-Font-Size="X-Small"
                        ColumnGroupName="Jan">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="FebT" FilterControlAltText="Filter FebT column" HeaderText="T(h)" HeaderTooltip="Time (hours)" SortExpression="FebT" UniqueName="FebT"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="40px" ItemStyle-Font-Size="X-Small" ItemStyle-Font-Italic="true"
                        ColumnGroupName="Feb">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="FebC" FilterControlAltText="Filter FebC column" HeaderText="C($)" HeaderTooltip="Cost ($)" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="FebC" UniqueName="FebC"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="50px" ItemStyle-Font-Size="X-Small"
                        ColumnGroupName="Feb">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MarT" FilterControlAltText="Filter MarT column" HeaderText="T(h)" HeaderTooltip="Time (hours)" SortExpression="MarT" UniqueName="MarT"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="40px" ItemStyle-Font-Size="X-Small" ItemStyle-Font-Italic="true"
                        ColumnGroupName="Mar">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MarC" FilterControlAltText="Filter MarC column" HeaderText="C($)" HeaderTooltip="Cost ($)" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="MarC" UniqueName="MarC"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="50px" ItemStyle-Font-Size="X-Small"
                        ColumnGroupName="Mar">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="AprT" FilterControlAltText="Filter AprT column" HeaderText="T(h)" HeaderTooltip="Time (hours)" SortExpression="AprT" UniqueName="AprT"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="40px" ItemStyle-Font-Size="X-Small" ItemStyle-Font-Italic="true"
                        ColumnGroupName="Apr">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="AprC" FilterControlAltText="Filter AprC column" HeaderText="C($)" HeaderTooltip="Cost ($)" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="AprC" UniqueName="AprC"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="50px" ItemStyle-Font-Size="X-Small"
                        ColumnGroupName="Apr">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MayT" FilterControlAltText="Filter MayT column" HeaderText="T(h)" HeaderTooltip="Time (hours)" SortExpression="MayT" UniqueName="MayT"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="40px" ItemStyle-Font-Size="X-Small" ItemStyle-Font-Italic="true"
                        ColumnGroupName="May">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MayC" FilterControlAltText="Filter MayC column" HeaderText="C($)" HeaderTooltip="Cost ($)" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="MayC" UniqueName="MayC"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="50px" ItemStyle-Font-Size="X-Small"
                        ColumnGroupName="May">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="JunT" FilterControlAltText="Filter JunT column" HeaderText="T(h)" HeaderTooltip="Time (hours)" SortExpression="JunT" UniqueName="JunT"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="40px" ItemStyle-Font-Size="X-Small" ItemStyle-Font-Italic="true"
                        ColumnGroupName="Jun">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="JunC" FilterControlAltText="Filter JunC column" HeaderText="C($)" HeaderTooltip="Cost ($)" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="JunC" UniqueName="JunC"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="50px" ItemStyle-Font-Size="X-Small"
                        ColumnGroupName="Jun">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="JulT" FilterControlAltText="Filter JulT column" HeaderText="T(h)" HeaderTooltip="Time (hours)" SortExpression="JulT" UniqueName="JulT"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="40px" ItemStyle-Font-Size="X-Small" ItemStyle-Font-Italic="true"
                        ColumnGroupName="Jul">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="JulC" FilterControlAltText="Filter JulC column" HeaderText="C($)" HeaderTooltip="Cost ($)" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="JulC" UniqueName="JulC"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="50px" ItemStyle-Font-Size="X-Small"
                        ColumnGroupName="Jul">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="AugT" FilterControlAltText="Filter AugT column" HeaderText="T(h)" HeaderTooltip="Time (hours)" SortExpression="AugT" UniqueName="AugT"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="40px" ItemStyle-Font-Size="X-Small" ItemStyle-Font-Italic="true"
                        ColumnGroupName="Aug">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="AugC" FilterControlAltText="Filter AugC column" HeaderText="C($)" HeaderTooltip="Cost ($)" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="AugC" UniqueName="AugC"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="50px" ItemStyle-Font-Size="X-Small"
                        ColumnGroupName="Aug">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SepT" FilterControlAltText="Filter SepT column" HeaderText="T(h)" HeaderTooltip="Time (hours)" SortExpression="SepT" UniqueName="SepT"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="40px" ItemStyle-Font-Size="X-Small" ItemStyle-Font-Italic="true"
                        ColumnGroupName="Sep">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SepC" FilterControlAltText="Filter SepC column" HeaderText="C($)" HeaderTooltip="Cost ($)" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="SepC" UniqueName="SepC"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="50px" ItemStyle-Font-Size="X-Small"
                        ColumnGroupName="Sep">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="OctT" FilterControlAltText="Filter OctT column" HeaderText="T(h)" HeaderTooltip="Time (hours)" SortExpression="OctT" UniqueName="OctT"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="40px" ItemStyle-Font-Size="X-Small" ItemStyle-Font-Italic="true"
                        ColumnGroupName="Oct">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="OctC" FilterControlAltText="Filter OctC column" HeaderText="C($)" HeaderTooltip="Cost ($)" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="OctC" UniqueName="OctC"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="50px" ItemStyle-Font-Size="X-Small"
                        ColumnGroupName="Oct">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="NovT" FilterControlAltText="Filter NovT column" HeaderText="T(h)" HeaderTooltip="Time (hours)" SortExpression="NovT" UniqueName="NovT"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="40px" ItemStyle-Font-Size="X-Small" ItemStyle-Font-Italic="true"
                        ColumnGroupName="Nov">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="NovC" FilterControlAltText="Filter NovC column" HeaderText="C($)" HeaderTooltip="Cost ($)" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="NovC" UniqueName="NovC"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="50px" ItemStyle-Font-Size="X-Small"
                        ColumnGroupName="Nov">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DecT" FilterControlAltText="Filter DecT column" HeaderText="T(h)" HeaderTooltip="Time (hours)" SortExpression="DecT" UniqueName="DecT"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="40px" ItemStyle-Font-Size="X-Small" ItemStyle-Font-Italic="true"
                        ColumnGroupName="Dec">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DecC" FilterControlAltText="Filter DecC column" HeaderText="C($)" HeaderTooltip="Cost ($)" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="DecC" UniqueName="DecC"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="50px" ItemStyle-Font-Size="X-Small"
                        ColumnGroupName="Dec">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <div>
        <telerik:RadGrid ID="RadGridAllYears" runat="server" DataSourceID="SqlDataSourceAllYears" Width="100%" Height="800px"
            AutoGenerateColumns="False" AllowPaging="True" PageSize="100" AllowSorting="True" ShowFooter="true">
            <ClientSettings>
                <Scrolling AllowScroll="True" UseStaticHeaders="True" FrozenColumnsCount="1"></Scrolling>
            </ClientSettings>

            <MasterTableView DataKeyNames="ClientName" DataSourceID="SqlDataSourceAllYears">
                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                <Columns>
                    <telerik:GridBoundColumn DataField="ClientName" FilterControlAltText="Filter ClientName column" HeaderText="Client" SortExpression="ClientName" UniqueName="ClientName"
                        HeaderStyle-HorizontalAlign="Center">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TotTime" FilterControlAltText="Filter TotTime column" HeaderText="Time (hours)" SortExpression="TotTime" UniqueName="TotTime"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}"
                        FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="150px" ItemStyle-Font-Italic="true"
                        HeaderTooltip="[Total Time] = SUM([Employee time])">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TotCost" FilterControlAltText="Filter TotCost column" HeaderText="Cost ($)" SortExpression="TotCost" UniqueName="TotCost"
                        ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}" Aggregate="Sum"
                        FooterAggregateFormatString="{0:N2}" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="150px" ItemStyle-Font-Size="Small"
                        HeaderTooltip="[Total Cost] = SUM([Employee Time] * [Employee Hourly Rate])">
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="Paym" FilterControlAltText="Filter Paym column" HeaderText="Payments ($)" SortExpression="Paym" UniqueName="Paym" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}" Aggregate="Sum" FooterAggregateFormatString="{0:N2}"
                        FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="150px" ItemStyle-Font-Size="Small"
                        HeaderTooltip="[Total Payments] = SUM(Client Payments)">
                    </telerik:GridBoundColumn>

                    <telerik:GridTemplateColumn DataField="Balance" FilterControlAltText="Filter Balance column" HeaderText="Balance" SortExpression="Balance" UniqueName="Balance" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                        FooterStyle-Font-Size="XX-Small" HeaderStyle-Width="150px" ItemStyle-Font-Size="Small"
                        HeaderTooltip="[Client Balance] = [Total Payments] - [Total Cost]">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblBalance" Text='<%# Eval("Balance", "{0:N0}")%>'
                                ForeColor='<%# GetMagenColor(Eval("Balance"))%>' Font-Bold='<%# Eval("Balance") > 0 %>'>
                            </asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="SqlDataSourceMonthly" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENTS_MonthlyTimeAndCosts_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboClients" Name="clientId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboDepartment" Name="departmentId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboEmployees" Name="employeeId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceAllYears" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENTS_TimeCostsaNDMargin_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboClients" Name="clientId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboDepartment" Name="departmentId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboEmployees" Name="employeeId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceYears" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Year, nYear FROM Years ORDER BY Year DESC"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name]+' [' + isnull(Company,'...') + ']' As Name FROM [Clients] WHERE companyId=@companyId  ORDER BY [Name]">
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
    <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [FullName] as Name FROM [Employees] WHERE companyId=@companyId ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>

