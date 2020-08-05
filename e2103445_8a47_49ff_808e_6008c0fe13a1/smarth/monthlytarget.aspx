<%@ Page Title="Monthly Target" Language="vb" AutoEventWireup="false" MasterPageFile="~/e2103445_8a47_49ff_808e_6008c0fe13a1/smarth/mastersmarth.Master" CodeBehind="monthlytarget.aspx.vb" Inherits="pasconcept20.monthlytarget" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadPageLayout ID="RadPageLayout1" runat="server" GridType="Fluid" CssClass="borderCssClass">
        <Rows>
            <telerik:LayoutRow>
                <Columns>
                    <telerik:LayoutColumn Span="12">
                        <div style="text-align: center">
                            <h3>
                                <asp:Label ID="lblTitle" Text="Monthly Target" runat="server"></asp:Label></h3>
                        </div>
                    </telerik:LayoutColumn>

                    <telerik:LayoutColumn Span="4" SpanXs="12" SpanSm="12">
                        <telerik:RadComboBox ID="cboYear" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceYear" Skin="MetroTouch"
                            DataTextField="nYear" DataValueField="Year" Width="100%">
                        </telerik:RadComboBox>

                    </telerik:LayoutColumn>
                    <telerik:LayoutColumn Span="8" SpanXs="12" SpanSm="12">
                        <telerik:RadComboBox ID="cboDepartments" runat="server" DataSourceID="SqlDataSourceDepartments" Skin="MetroTouch"
                            DataTextField="Name" DataValueField="Id" Width="100%" AppendDataBoundItems="true" AutoPostBack="True">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Departments...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </telerik:LayoutColumn>
                </Columns>
            </telerik:LayoutRow>

            <telerik:LayoutRow>
                <Columns>
                    <telerik:LayoutColumn Span="12">
                        <br />
                        <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" DataSourceID="SqlDataSource1" Height="700px" Width="100%" Skin="MetroTouch">
                            <PlotArea>
                                <Series>
                                    <telerik:AreaSeries DataFieldY="Executed" Name="Executed by Month">
                                        <Appearance FillStyle-BackgroundColor="Blue"></Appearance>
                                        <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                        <TooltipsAppearance DataFormatString="{0:N0}" Color="White"></TooltipsAppearance>
                                    </telerik:AreaSeries>
                                </Series>
                                <Series>
                                    <telerik:AreaSeries DataFieldY="DptoBudget" Name="Target by Month">
                                        <Appearance FillStyle-BackgroundColor="Red"></Appearance>
                                        <LabelsAppearance Visible="false"></LabelsAppearance>
                                        <TooltipsAppearance DataFormatString="{0:N0}" Color="White"></TooltipsAppearance>
                                    </telerik:AreaSeries>
                                </Series>
                                <Series>
                                    <telerik:LineSeries DataFieldY="Accumulated" Name="Accumulated Balance">
                                        <LabelsAppearance Visible="false" DataFormatString="{0:C0}">
                                        </LabelsAppearance>
                                        <Appearance>
                                            <FillStyle BackgroundColor="Green" />
                                        </Appearance>
                                        <LineAppearance LineStyle="Smooth" Width="3" />
                                        <TooltipsAppearance DataFormatString="{0:N0}" Color="White"></TooltipsAppearance>
                                        <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                                    </telerik:LineSeries>
                                </Series>
                                <Series>
                                    <telerik:LineSeries DataFieldY="PaymentsReceived" Name="Payments Received">
                                        <LabelsAppearance Visible="false" DataFormatString="{0:C0}">
                                        </LabelsAppearance>
                                        <Appearance>
                                            <FillStyle BackgroundColor="#00ff00" />
                                        </Appearance>
                                        <LineAppearance LineStyle="Step" Width="3" />
                                        <TooltipsAppearance DataFormatString="{0:N0}" Color="White"></TooltipsAppearance>
                                        <MarkersAppearance MarkersType="Square" BackgroundColor="White"></MarkersAppearance>
                                    </telerik:LineSeries>
                                </Series>
                                <YAxis Name="LeftAxis" MajorTickSize="4" MajorTickType="Outside" Width="3">

                                    <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                    <MinorGridLines Visible="false"></MinorGridLines>
                                    <LabelsAppearance>
                                        <TextStyle FontSize="10px" />
                                    </LabelsAppearance>
                                </YAxis>
                                <XAxis DataLabelsField="Month3">
                                    <TitleAppearance Text="Month"></TitleAppearance>
                                    <MinorGridLines Visible="false"></MinorGridLines>
                                    <AxisCrossingPoints>
                                        <telerik:AxisCrossingPoint Value="0" />
                                        <telerik:AxisCrossingPoint Value="9999" />
                                    </AxisCrossingPoints>
                                    <LabelsAppearance>
                                        <TextStyle FontSize="8px" />
                                    </LabelsAppearance>
                                </XAxis>
                            </PlotArea>
                            <Legend>
                                <Appearance Visible="True" Position="Top"></Appearance>
                            </Legend>
                        </telerik:RadHtmlChart>
                    </telerik:LayoutColumn>
                </Columns>
            </telerik:LayoutRow>
        </Rows>
    </telerik:RadPageLayout>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="BudgetDepartments_Chart" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboYear" Name="Ano" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="cboDepartments" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT * FROM [Years] where [Year]&gt;2000 ORDER BY [Year]DESC "></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>

</asp:Content>
