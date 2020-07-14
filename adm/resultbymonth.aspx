<%@ Page Title="Results by Month" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="resultbymonth.aspx.vb" Inherits="pasconcept20.resultbymonth" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Job Chart by Month</span>

        <span style="float: right; vertical-align: middle;">Year:
                    <telerik:RadComboBox ID="cboYear" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceYear" Width="180px"
                        DataTextField="nYear" DataValueField="Year">
                    </telerik:RadComboBox>

        </span>
    </div>

    <div class="pasconcept-bar">
        <table class="table-sm" style="width: 100%">
            <tr>
                <td style="width: 300px; text-align: center"></td>
                <td style="vertical-align: top; text-align: center" rowspan="2">
                    <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" DataSourceID="SqlDataSource1" Height="750px" Width="100%">
                        <ChartTitle>
                            <Appearance Visible="false"></Appearance>
                        </ChartTitle>
                        <PlotArea>
                            <Series>
                                <telerik:ColumnSeries DataFieldY="SumBudget" Name="Budget" AxisName="LeftAxis">
                                    <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                    </LabelsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="MediumSeaGreen" />
                                    </Appearance>
                                    <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                </telerik:ColumnSeries>
                            </Series>
                            <Series>
                                <telerik:ColumnSeries DataFieldY="SumCollected" Name="Collected" AxisName="LeftAxis">
                                    <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                    </LabelsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="SteelBlue" />
                                    </Appearance>
                                    <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                </telerik:ColumnSeries>
                            </Series>
                            <Series>
                                <telerik:ColumnSeries DataFieldY="sumCoste" Name="Cost" AxisName="LeftAxis">
                                    <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                    </LabelsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="Orange" />
                                    </Appearance>
                                    <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                </telerik:ColumnSeries>
                            </Series>
                            <Series>
                                <telerik:LineSeries DataFieldY="Cantidad" Name="Jobs Count" AxisName="RightAxis">
                                    <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                    </LabelsAppearance>
                                    <Appearance>
                                        <FillStyle BackgroundColor="Red" />
                                    </Appearance>
                                    <LineAppearance LineStyle="Smooth" Width="2" />
                                    <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                    <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                </telerik:LineSeries>
                            </Series>
                            <YAxis Name="LeftAxis" MajorTickSize="4" MajorTickType="Outside" Color="MediumSeaGreen" Width="3">
                                <TitleAppearance Text="$"></TitleAppearance>
                                <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                <MinorGridLines Visible="false"></MinorGridLines>
                            </YAxis>
                            <AdditionalYAxes>
                                <telerik:AxisY Name="RightAxis" Color="Red" Width="3">
                                    <TitleAppearance Text="# Jobs"></TitleAppearance>
                                </telerik:AxisY>
                            </AdditionalYAxes>
                            <XAxis DataLabelsField="Mes">
                                <TitleAppearance Text="Month"></TitleAppearance>
                                <MinorGridLines Visible="false"></MinorGridLines>
                                <AxisCrossingPoints>
                                    <telerik:AxisCrossingPoint Value="0" />
                                    <telerik:AxisCrossingPoint Value="9999" />
                                </AxisCrossingPoints>
                            </XAxis>
                        </PlotArea>
                        <Legend>
                            <Appearance Visible="True" Position="Top"></Appearance>
                        </Legend>
                    </telerik:RadHtmlChart>
                </td>
            </tr>
            <tr>
                <td style="vertical-align: top;padding-top:25px">
                    <telerik:RadGrid ID="RadGrid2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"
                        GridLines="None" ItemStyle-Font-Size="x-Small" AlternatingItemStyle-Font-Size="x-Small" Font-Size="X-Small">
                        <MasterTableView DataKeyNames="Mes" DataSourceID="SqlDataSource1" ShowFooter="True">
                            <RowIndicatorColumn>
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn>
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </ExpandCollapseColumn>
                            <Columns>
                                <telerik:GridBoundColumn DataField="Mes" HeaderText="Month" SortExpression="Mes"
                                    UniqueName="Mes">
                                    <HeaderStyle HorizontalAlign="Center" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn Aggregate="Sum" DataField="SumBudget" DataFormatString="{0:N0}"
                                    FooterAggregateFormatString="{0:N0}" HeaderText="Budget"
                                    ReadOnly="True" SortExpression="SumBudget" UniqueName="SumBudget">
                                    <FooterStyle HorizontalAlign="Right" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn Aggregate="Sum" DataField="SumCollected" DataFormatString="{0:N0}"
                                    FooterAggregateFormatString="{0:N0}" HeaderText="Collected"
                                    ReadOnly="True" SortExpression="SumCollected" UniqueName="SumCollected">
                                    <FooterStyle HorizontalAlign="Right" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn Aggregate="Sum" DataField="sumCoste" DataFormatString="{0:N0}"
                                    FooterAggregateFormatString="{0:N0}" HeaderText="Cost"
                                    ReadOnly="True" SortExpression="sumCoste" UniqueName="sumCoste">
                                    <FooterStyle HorizontalAlign="Right" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                        <FilterMenu EnableTheming="True">
                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                        </FilterMenu>
                    </telerik:RadGrid>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JobsResultByMonth_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT * FROM [Years] where [Year]&gt;2000 ORDER BY [Year]DESC "></asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblEmployee" runat="server" CssClass="Titulo4" Visible="False"></asp:Label>
</asp:Content>
