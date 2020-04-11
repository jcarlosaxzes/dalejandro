<%@ Page Title="Monthly Chart Department" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="chartdepartments.aspx.vb" Inherits="pasconcept20.chartdepartments" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="row Formulario">
        <div class="col-md-4" style="text-align: center">
            <telerik:RadComboBox ID="cboYear" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceYear" Label="Year:"
                DataTextField="nYear" DataValueField="Year" Width="150px">
            </telerik:RadComboBox>
        </div>
        <div class="col-md-4" style="text-align: center">
            <telerik:RadComboBox ID="cboDepartments" runat="server" DataSourceID="SqlDataSourceDepartments"
                DataTextField="Name" DataValueField="Id" Width="300px" AppendDataBoundItems="true" AutoPostBack="True" Label="Department:">
                <Items>
                    <telerik:RadComboBoxItem runat="server" Text="(All Departments...)" Value="-1" Selected="true" />
                </Items>
            </telerik:RadComboBox>
        </div>
        <div class="col-md-4" style="text-align: center">
            <telerik:RadComboBox ID="cboCurrentSource" runat="server" Width="300px" AppendDataBoundItems="true" AutoPostBack="True" Label="Current:">
                <Items>
                    <telerik:RadComboBoxItem runat="server" Text="From Job's Budgets" Value="0" Selected="true" />
                    <telerik:RadComboBoxItem runat="server" Text="From Payments Received" Value="1" />
                </Items>
            </telerik:RadComboBox>
        </div>
    </div>

    <div class="row">
        <div class="col-md-8">
            <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" DataSourceID="SqlDataSource1" Height="600px" Width="100%">
                <ChartTitle Text="Monthly (Current vs Target) Balance by Departments">
                    <Appearance Align="Center" BackgroundColor="White" Position="Top"></Appearance>
                </ChartTitle>
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
                        <telerik:LineSeries DataFieldY="PaymentsReceived" Name="Collected">
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
                        <TitleAppearance Text="$"></TitleAppearance>
                        <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                        <MinorGridLines Visible="false"></MinorGridLines>
                    </YAxis>
                    <XAxis DataLabelsField="Month3">
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
        </div>
        <div class="col-md-4">
            <h4>Data</h4>
            <br />
            <br />
            <telerik:RadGrid ID="RadGrid1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"
                GridLines="None">
                <MasterTableView DataKeyNames="Month3" DataSourceID="SqlDataSource1" ShowFooter="True">
                    <Columns>
                        <telerik:GridBoundColumn DataField="Month3" HeaderText="Month" SortExpression="Month3"
                            UniqueName="Month3">
                            <HeaderStyle HorizontalAlign="Center" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn Aggregate="Sum" DataField="DptoBudget" DataFormatString="{0:N0}"
                            FooterAggregateFormatString="{0:N0}" HeaderText="Target"
                            ReadOnly="True" SortExpression="DptoBudget" UniqueName="DptoBudget"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn Aggregate="Sum" DataField="Executed" DataFormatString="{0:N0}"
                            FooterAggregateFormatString="{0:N0}" HeaderText="Current"
                            ReadOnly="True" SortExpression="Executed" UniqueName="Executed"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn Aggregate="Sum" DataField="Balance" DataFormatString="{0:N0}"
                            FooterAggregateFormatString="{0:N0}" HeaderText="Balance"
                            ReadOnly="True" SortExpression="Balance" UniqueName="Balance"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Accumulated" DataFormatString="{0:N0}"
                            HeaderText="Accumulated" ReadOnly="True" SortExpression="Accumulated" UniqueName="Accumulated"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
                        </telerik:GridBoundColumn>
                    </Columns>
                </MasterTableView>
                <FilterMenu EnableTheming="True">
                    <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                </FilterMenu>
            </telerik:RadGrid>
        </div>
    </div>


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
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblEmployeeEmail" runat="server" Visible="False"></asp:Label>

</asp:Content>


