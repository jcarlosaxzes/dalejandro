<%@ Page Title="Results by Month" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="resultbymonth.aspx.vb" Inherits="pasconcept20.resultbymonth" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;padding-left:20px" cellpadding="5px">
        <tr>
            <td width="240px" valign="top" align="left">
                &nbsp;
            </td>
            <td>
                <asp:Label ID="lblEmployee" runat="server" CssClass="Titulo4" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td width="240px" valign="top" align="left" class="Normal">
                Data
            </td>
            <td class="Normal" style="text-align: left" >
                Year:&nbsp;
                <telerik:RadComboBox ID="cboYear" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceYear"
                    DataTextField="nYear" DataValueField="Year" Width="100px">
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td valign="top" >
                <telerik:RadGrid ID="RadGrid2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"
                    GridLines="None">
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
            <td valign="top">
                <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" DataSourceID="SqlDataSource1" Height="500px" Width="800px">
                    <ChartTitle Text="Results by Month">
                        <Appearance Align="Center" BackgroundColor="White" Position="Top"></Appearance>
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
                            <telerik:ColumnSeries DataFieldY="sumCoste" Name="Coste" AxisName="LeftAxis">
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
                        <Appearance Visible="True" Position="Top" ></Appearance>
                    </Legend>
                </telerik:RadHtmlChart>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JobsResultByMonth_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT * FROM [Years] where [Year]&gt;2000 ORDER BY [Year]DESC ">
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>
