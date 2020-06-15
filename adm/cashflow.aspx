<%@ Page Title="Cash Flow" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="cashflow.aspx.vb" Inherits="pasconcept20.cashflow" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGridMonthly">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridMonthly" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadHtmlChartMonthly" />
                    <telerik:AjaxUpdatedControl ControlID="RadHtmlChartYearly" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cboYear">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridMonthly" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadHtmlChartMonthly" />
                    <telerik:AjaxUpdatedControl ControlID="RadHtmlChartYearly" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />

    <table class="table-sm Formulario" style="width: 100%">
        <tr>
            <td style="width: 200px">
                <telerik:RadComboBox ID="cboYear" runat="server" DataSourceID="SqlDataSourceYear" Label="  Year:"
                    DataTextField="nYear" DataValueField="Year" Width="200px" AppendDataBoundItems="True" AutoPostBack="true">
                </telerik:RadComboBox>

            </td>
            <td style="text-align: center">
                <h3 style="margin: 0">Cash Flow
                </h3>
            </td>

        </tr>
    </table>

    <div class="row">
        <div class="col-md-5">
            <br />
            <br />
            <telerik:RadGrid ID="RadGrid1" runat="server" CellSpacing="0" Culture="en-US" DataSourceID="SqlDataSourceMonth" GridLines="None">
                <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSourceMonth" ShowFooter="true"
                            ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" FooterStyle-Font-Size="X-Small">
                    <Columns>
                        <telerik:GridBoundColumn DataField="colMonth" FilterControlAltText="Filter colMonth column" HeaderText="Month" SortExpression="colMonth" UniqueName="colMonth"
                            HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                            FooterText="<b>TOTAL:</b> ">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Collected" DataType="System.Double" FilterControlAltText="Filter Collected column" HeaderText="Collected" SortExpression="Collected" UniqueName="Collected"
                            ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                            Aggregate="Sum" DataFormatString="{0:N0}" FooterAggregateFormatString="{0:C0}" FooterStyle-HorizontalAlign="Right">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Expenses" FilterControlAltText="Filter Bill column" HeaderText="Expenses" SortExpression="Expenses" UniqueName="Expenses"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right"
                            Aggregate="Sum" DataFormatString="{0:N0}" FooterAggregateFormatString="{0:C0}" FooterStyle-HorizontalAlign="Right">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Balance" DataType="System.Double" FilterControlAltText="Filter Balance column" HeaderText="Balance" SortExpression="Balance" UniqueName="Balance"
                            ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                            Aggregate="Sum" DataFormatString="{0:N0}" FooterAggregateFormatString="{0:C0}" FooterStyle-HorizontalAlign="Right">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Accumulated" DataType="System.Double" FilterControlAltText="Filter Accumulated column" HeaderText="Accumulated" SortExpression="Accumulated" UniqueName="Accumulated"
                            ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                            DataFormatString="{0:N0}">
                        </telerik:GridBoundColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
        <div class="col-md-7">
            <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" DataSourceID="SqlDataSourceMonth" Height="400px" Width="100%" Skin="Material">
                <PlotArea>
                    <Series>
                        <telerik:ColumnSeries DataFieldY="Expenses" Name="Expenses">
                            <LabelsAppearance Visible="false" DataFormatString="{0:C0}">
                            </LabelsAppearance>
                            <TooltipsAppearance DataFormatString="{0:C0}"></TooltipsAppearance>
                            <Appearance>
                                <FillStyle BackgroundColor="#03a9f4" />
                            </Appearance>
                        </telerik:ColumnSeries>
                        <telerik:ColumnSeries DataFieldY="Collected" Name="Collected">
                            <LabelsAppearance Visible="false" DataFormatString="{0:C0}">
                            </LabelsAppearance>
                            <TooltipsAppearance DataFormatString="{0:C0}"></TooltipsAppearance>
                            <Appearance>
                                <FillStyle BackgroundColor="#8bc34a" />
                            </Appearance>
                        </telerik:ColumnSeries>

                        <telerik:LineSeries DataFieldY="Balance" Name="Monthly Balance">
                            <LabelsAppearance Visible="false" DataFormatString="{0:C0}">
                            </LabelsAppearance>
                            <Appearance>
                                <FillStyle BackgroundColor="#00ff00" />
                            </Appearance>
                            <LineAppearance LineStyle="Step" Width="3" />
                            <TooltipsAppearance DataFormatString="{0:N0}" Color="White"></TooltipsAppearance>
                            <MarkersAppearance MarkersType="Square" BackgroundColor="White"></MarkersAppearance>
                        </telerik:LineSeries>

                        <telerik:LineSeries DataFieldY="Accumulated" Name="Accumulated">
                            <LabelsAppearance Visible="false" DataFormatString="{0:C0}">
                            </LabelsAppearance>
                            <Appearance>
                                <FillStyle BackgroundColor="Red" />
                            </Appearance>
                            <LineAppearance LineStyle="Smooth" Width="2" />
                            <TooltipsAppearance DataFormatString="{0:C0}"></TooltipsAppearance>
                            <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                        </telerik:LineSeries>
                    </Series>
                    <XAxis DataLabelsField="colMonth">
                        <TitleAppearance Text="Month"></TitleAppearance>
                        <MinorGridLines Visible="false"></MinorGridLines>
                    </XAxis>
                    <YAxis MajorTickSize="4" MajorTickType="Outside" MinorTickSize="1">
                        <LabelsAppearance DataFormatString="{0:C0}"></LabelsAppearance>
                        <MinorGridLines Visible="false"></MinorGridLines>
                    </YAxis>
                </PlotArea>
                <Legend>
                    <Appearance Visible="true" Position="Top"></Appearance>
                </Legend>
                <ChartTitle Text="Bill vs Collected by Month">
                    <Appearance Visible="false"></Appearance>
                </ChartTitle>
            </telerik:RadHtmlChart>
        </div>
    </div>

    <asp:SqlDataSource ID="SqlDataSourceMonth" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="COLLECTED_VS_EXPENSES" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT * FROM [Years] ORDER BY [Year] DESC "></asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>

