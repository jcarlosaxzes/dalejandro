<%@ Page Title="Balance by Departments" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="balancedepartments.aspx.vb" Inherits="pasconcept20.balancedepartments" %>

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
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Departments Balance</span>

        <span style="padding-left: 150px; vertical-align: middle;">
            <b>Bud</b>: Department Budget by Month&nbsp;&nbsp;&nbsp;&nbsp; <b>Exec</b>: Executed by Month&nbsp;&nbsp;&nbsp;&nbsp; <b>Bal</b>: Balance by Month&nbsp;&nbsp;&nbsp;&nbsp;  <b>Acc</b>: Accumulated Balance
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <telerik:RadComboBox ID="cboYear" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceYears" DataTextField="nYear" DataValueField="Year" Width="150px">
             </telerik:RadComboBox>

            <asp:LinkButton ID="btnExport" runat="server" ToolTip="Export records to Excel" Width="100px"
                CssClass="btn btn-secondary btn" UseSubmitBehavior="false">
                                    <i class="fas fa-download"></i> Export
            </asp:LinkButton>


        </span>
    </div>

    <div class="row">
        <div class="col-12">
            <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" Width="100%" Height="750px"
                ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" Font-Size="X-Small" RenderMode="Lightweight"
                AutoGenerateColumns="False" AllowPaging="True" PageSize="100" AllowSorting="True" ShowFooter="true" HeaderStyle-Width="60px">
                <ClientSettings>
                    <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
                </ClientSettings>

                <MasterTableView DataKeyNames="Department" DataSourceID="SqlDataSource1">
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
                        <telerik:GridBoundColumn DataField="Department" FilterControlAltText="Filter Department column" HeaderText="Department" SortExpression="Department" UniqueName="Department"
                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Left">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Jan" DataType="System.Double" FilterControlAltText="Filter Jan column" HeaderText="Bud" SortExpression="Jan" UniqueName="Jan"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Jan">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="JanE" DataType="System.Double" FilterControlAltText="Filter JanE column" HeaderText="Exec" SortExpression="JanE" UniqueName="JanE"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Jan">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="JanB" DataType="System.Double" FilterControlAltText="Filter JanB column" HeaderText="Bal" SortExpression="JanB" UniqueName="JanB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Jan">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="JanAB" DataType="System.Double" FilterControlAltText="Filter JanAB column" HeaderText="Acc" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="JanAB" UniqueName="JanAB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Jan">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Feb" DataType="System.Double" FilterControlAltText="Filter Feb column" HeaderText="Bud" SortExpression="Feb" UniqueName="Feb"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Feb">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="FebE" DataType="System.Double" FilterControlAltText="Filter FebE column" HeaderText="Exec" SortExpression="FebE" UniqueName="FebE"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Feb">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="FebB" DataType="System.Double" FilterControlAltText="Filter FebB column" HeaderText="Bal" SortExpression="FebB" UniqueName="FebB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Feb">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="FebAB" DataType="System.Double" FilterControlAltText="Filter FebAB column" HeaderText="Acc" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="FebAB" UniqueName="FebAB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Feb">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Mar" DataType="System.Double" FilterControlAltText="Filter Mar column" HeaderText="Bud" SortExpression="Mar" UniqueName="Mar"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Mar">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="MarE" DataType="System.Double" FilterControlAltText="Filter MarE column" HeaderText="Exec" SortExpression="MarE" UniqueName="MarE"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Mar">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="MarB" DataType="System.Double" FilterControlAltText="Filter MarB column" HeaderText="Bal" SortExpression="MarB" UniqueName="MarB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Mar">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="MarAB" DataType="System.Double" FilterControlAltText="Filter MarAB column" HeaderText="Acc" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="MarAB" UniqueName="MarAB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Mar">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Apr" DataType="System.Double" FilterControlAltText="Filter Apr column" HeaderText="Bud" SortExpression="Apr" UniqueName="Apr"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Apr">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="AprE" DataType="System.Double" FilterControlAltText="Filter AprE column" HeaderText="Exec" SortExpression="AprE" UniqueName="AprE"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Apr">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="AprB" DataType="System.Double" FilterControlAltText="Filter AprB column" HeaderText="Bal" SortExpression="AprB" UniqueName="AprB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Apr">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="AprAB" DataType="System.Double" FilterControlAltText="Filter AprAB column" HeaderText="Acc" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="AprAB" UniqueName="AprAB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Apr">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="May" DataType="System.Double" FilterControlAltText="Filter May column" HeaderText="Bud" SortExpression="May" UniqueName="May"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="May">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="MayE" DataType="System.Double" FilterControlAltText="Filter MayE column" HeaderText="Exec" SortExpression="MayE" UniqueName="MayE"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="May">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="MayB" DataType="System.Double" FilterControlAltText="Filter MayB column" HeaderText="Bal" SortExpression="MayB" UniqueName="MayB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="May">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="MayAB" DataType="System.Double" FilterControlAltText="Filter MayAB column" HeaderText="Acc" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="MayAB" UniqueName="MayAB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="May">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Jun" DataType="System.Double" FilterControlAltText="Filter Jun column" HeaderText="Bud" SortExpression="Jun" UniqueName="Jun"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Jun">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="JunE" DataType="System.Double" FilterControlAltText="Filter JunE column" HeaderText="Exec" SortExpression="JunE" UniqueName="JunE"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Jun">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="JunB" DataType="System.Double" FilterControlAltText="Filter JunB column" HeaderText="Bal" FooterStyle-Font-Bold="true" SortExpression="JunB" UniqueName="JunB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Jun">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="JunAB" DataType="System.Double" FilterControlAltText="Filter JunAB column" HeaderText="Acc" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="JunAB" UniqueName="JunAB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Jun">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Jul" DataType="System.Double" FilterControlAltText="Filter Jul column" HeaderText="Bud" SortExpression="Jul" UniqueName="Jul"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Jul">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="JulE" DataType="System.Double" FilterControlAltText="Filter JulE column" HeaderText="Exec" SortExpression="JulE" UniqueName="JulE"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Jul">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="JulB" DataType="System.Double" FilterControlAltText="Filter JulB column" HeaderText="Bal" FooterStyle-Font-Bold="true" SortExpression="JulB" UniqueName="JulB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Jul">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="JulAB" DataType="System.Double" FilterControlAltText="Filter JulAB column" HeaderText="Acc" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="JulAB" UniqueName="JulAB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Jul">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Aug" DataType="System.Double" FilterControlAltText="Filter Aug column" HeaderText="Bud" SortExpression="Aug" UniqueName="Aug"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Aug">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="AugE" DataType="System.Double" FilterControlAltText="Filter AugE column" HeaderText="Exec" SortExpression="AugE" UniqueName="AugE"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Aug">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="AugB" DataType="System.Double" FilterControlAltText="Filter AugB column" HeaderText="Bal" FooterStyle-Font-Bold="true" SortExpression="AugB" UniqueName="AugB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Aug">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="AugAB" DataType="System.Double" FilterControlAltText="Filter AugAB column" HeaderText="Acc" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="AugAB" UniqueName="AugAB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Aug">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Sep" DataType="System.Double" FilterControlAltText="Filter Sep column" HeaderText="Bud" SortExpression="Sep" UniqueName="Sep"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Sep">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SepE" DataType="System.Double" FilterControlAltText="Filter SepE column" HeaderText="Exec" SortExpression="SepE" UniqueName="SepE"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Sep">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SepB" DataType="System.Double" FilterControlAltText="Filter SepB column" HeaderText="Bal" FooterStyle-Font-Bold="true" SortExpression="SepB" UniqueName="SepB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Sep">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SepAB" DataType="System.Double" FilterControlAltText="Filter SepAB column" HeaderText="Acc" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="SepAB" UniqueName="SepAB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Sep">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Oct" DataType="System.Double" FilterControlAltText="Filter Oct column" HeaderText="Bud" SortExpression="Oct" UniqueName="Oct"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Oct">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="OctE" DataType="System.Double" FilterControlAltText="Filter OctE column" HeaderText="Exec" SortExpression="OctE" UniqueName="OctE"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Oct">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="OctB" DataType="System.Double" FilterControlAltText="Filter OctB column" HeaderText="Bal" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="OctB" UniqueName="OctB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Oct">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="OctAB" DataType="System.Double" FilterControlAltText="Filter OctAB column" HeaderText="Bal" FooterStyle-Font-Bold="true" SortExpression="OctAB" UniqueName="OctAB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Oct">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Nov" DataType="System.Double" FilterControlAltText="Filter Nov column" HeaderText="Bud" SortExpression="Nov" UniqueName="Nov"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Nov">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NovE" DataType="System.Double" FilterControlAltText="Filter NovE column" HeaderText="Exec" SortExpression="NovE" UniqueName="NovE"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Nov">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NovB" DataType="System.Double" FilterControlAltText="Filter NovB column" HeaderText="Bal" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="NovB" UniqueName="NovB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Nov">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NovAB" DataType="System.Double" FilterControlAltText="Filter NovAB column" HeaderText="Bal" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="NovAB" UniqueName="NovAB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Nov">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Dec" DataType="System.Double" FilterControlAltText="Filter Dec column" HeaderText="Bud" SortExpression="Dec" UniqueName="Dec"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Dec">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="DecE" DataType="System.Double" FilterControlAltText="Filter DecE column" HeaderText="Exec" SortExpression="DecE" UniqueName="DecE"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Dec">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="DecB" DataType="System.Double" FilterControlAltText="Filter DecB column" HeaderText="Bal" FooterStyle-Font-Bold="true" SortExpression="DecB" UniqueName="DecB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Dec">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="DecAB" DataType="System.Double" FilterControlAltText="Filter DecAB column" HeaderText="Acc" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true" SortExpression="DecAB" UniqueName="DecAB"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Dec">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Total" DataType="System.Double" FilterControlAltText="Filter Total column" HeaderText="T-Bud" ReadOnly="True" SortExpression="Total" UniqueName="Total"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Tot">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="TotE" DataType="System.Double" FilterControlAltText="Filter TotE column" HeaderText="T-Exec" ReadOnly="True" SortExpression="TotE" UniqueName="TotE"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Tot">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="TotB" DataType="System.Double" FilterControlAltText="Filter TotB column" HeaderText="T-Bal" ReadOnly="True" SortExpression="TotB" UniqueName="TotB" ItemStyle-BackColor="#f0f0f0" ItemStyle-Font-Bold="true" FooterStyle-Font-Bold="true"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N0}" Aggregate="Sum" FooterAggregateFormatString="{0:N0}" FooterStyle-HorizontalAlign="Right"
                            ColumnGroupName="Tot">
                        </telerik:GridBoundColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="BudgetDepartments_BALANCE" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceYears" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT Year, nYear FROM Years ORDER BY Year DESC"></asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
