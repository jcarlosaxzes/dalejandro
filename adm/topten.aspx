<%@ Page Title="Top Ten" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="topten.aspx.vb" Inherits="pasconcept20.topten" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

        <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Top Ten Charts</span>

        <span style="float: right; vertical-align: middle;">
            Year:
             <telerik:RadComboBox ID="cboYears" runat="server" DataSourceID="SqlDataSourceYear"
                            DataTextField="nYear" DataValueField="Year" AutoPostBack="True"
                            Width="150px">
                        </telerik:RadComboBox>

        </span>
    </div>




    <div class="pas-container">
        <div class="row">
            <div class="col-md-12" style="text-align: center">

                <telerik:RadHtmlChart ID="RadHtmlChartHours" runat="server" DataSourceID="SqlDataSourceClientTopTenHours" Width="90%">
                    <ChartTitle Text="Top Clients by Time Worked">
                        <Appearance Align="Center" Position="Top">
                            <TextStyle Bold="true" FontSize="20px" Color="#317eac" />
                        </Appearance>
                    </ChartTitle>
                    <Legend>
                        <Appearance Position="Right" Visible="true">
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <Series>
                            <telerik:DonutSeries DataFieldY="Hours" StartAngle="90">
                                <LabelsAppearance Position="OutsideEnd" DataFormatString="{0:N0} %" Visible="true">
                                    <ClientTemplate>
                                     #=dataItem.Company#&nbsp;(#=dataItem.Hours# %)
                                    </ClientTemplate>
                                </LabelsAppearance>
                                <TooltipsAppearance>
                                    <ClientTemplate>
                                     #=dataItem.Company#<br/>#=dataItem.Total# Hours
                                    </ClientTemplate>
                                </TooltipsAppearance>
                            </telerik:DonutSeries>
                        </Series>
                    </PlotArea>
                </telerik:RadHtmlChart>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <telerik:RadHtmlChart ID="RadHtmlChartPayments" runat="server" DataSourceID="SqlDataSourceClientTopTenPayments" Width="90%">
                    <ChartTitle Text="Top Clients by Payments">
                        <Appearance Align="Center" Position="Top">
                            <TextStyle Bold="true" FontSize="20px" Color="#317eac" />
                        </Appearance>
                    </ChartTitle>
                    <Legend>
                        <Appearance Position="Right" Visible="true">
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <Series>
                            <telerik:DonutSeries DataFieldY="Amount" StartAngle="90">
                                <LabelsAppearance Position="OutsideEnd" DataFormatString="{0:N0} %" Visible="true">
                                    <ClientTemplate>
                                     #=dataItem.Company#&nbsp;(#=dataItem.Amount# %)
                                    </ClientTemplate>
                                </LabelsAppearance>
                                <TooltipsAppearance>
                                    <ClientTemplate>
                                     #=dataItem.Company#<br/>$ #=dataItem.Total# 
                                    </ClientTemplate>
                                </TooltipsAppearance>
                            </telerik:DonutSeries>
                        </Series>
                    </PlotArea>
                </telerik:RadHtmlChart>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSourceClientTopTenHours" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENTS_TopTenHours" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboYears" Name="year" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClientTopTenPayments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENTS_TopTenPayments" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboYears" Name="year" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT * FROM [Years] ORDER BY [Year] DESC "></asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
