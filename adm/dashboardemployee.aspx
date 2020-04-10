<%@ Page Title="Dashboard Employee" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="dashboardemployee.aspx.vb" Inherits="pasconcept20.dashboardemployee" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <telerik:RadPageLayout ID="RadPageLayout1" runat="server" GridType="Fluid">
        <Rows>
            <telerik:LayoutRow>
                <Columns>
                    <telerik:LayoutColumn Span="6" Offset="4">
                        <telerik:RadComboBox ID="cboEmployee" runat="server" DataSourceID="SqlDataSourceEmployees" MarkFirstMatch="True" Label="Employee: "
                            Width="400px" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" AutoPostBack="true">
                        </telerik:RadComboBox>
                    </telerik:LayoutColumn>
                </Columns>
            </telerik:LayoutRow>
            <telerik:LayoutRow>
                <Columns>
                    <telerik:LayoutColumn Span="12">
                        <hr style="margin-bottom: 0; margin-top: 7px" />
                    </telerik:LayoutColumn>
                </Columns>
            </telerik:LayoutRow>

            <telerik:LayoutRow>
                <Columns>

                    <telerik:LayoutColumn Span="6" SpanXs="12" SpanSm="12">

                        <h3 style="text-align: center">Time Applied to 'In Progress' Jobs</h3>
                        <telerik:RadHtmlChart ID="RadHtmlChartTimeUsed" runat="server" DataSourceID="SqlDataSourceTimeUsed" Height="400px" Width="90%">
                            <PlotArea>
                                <Series>
                                    <telerik:ColumnSeries DataFieldY="RegularUsedHours" Name="Used Hours" GroupName="Job">
                                        <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                        </LabelsAppearance>
                                        <Appearance>
                                            <FillStyle BackgroundColor="Orange" />
                                        </Appearance>
                                        <TooltipsAppearance>
                                            <ClientTemplate>
                                                #=dataItem.Job#,&nbsp;Used:&nbsp;#=dataItem.RegularUsedHours#&nbsp;Hours
                                            </ClientTemplate>
                                        </TooltipsAppearance>
                                    </telerik:ColumnSeries>
                                    <telerik:ColumnSeries DataFieldY="PendingHours" Name="Pending Hours" GroupName="Job">
                                        <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                        </LabelsAppearance>
                                        <Appearance>
                                            <FillStyle BackgroundColor="YellowGreen" />
                                        </Appearance>
                                        <TooltipsAppearance>
                                            <ClientTemplate>
                                                #=dataItem.Job#,&nbsp;Pending:&nbsp;#=dataItem.PendingHours#&nbsp;Hours
                                            </ClientTemplate>
                                        </TooltipsAppearance>
                                    </telerik:ColumnSeries>
                                    <telerik:ColumnSeries DataFieldY="ExtraUsedHours" Name="Extra Hours" GroupName="Job">
                                        <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                        </LabelsAppearance>
                                        <Appearance>
                                            <FillStyle BackgroundColor="Red" />
                                        </Appearance>
                                        <TooltipsAppearance>
                                            <ClientTemplate>
                                                #=dataItem.Job#,&nbsp;Extra Hours:&nbsp;#=dataItem.ExtraUsedHours#&nbsp;Hours
                                            </ClientTemplate>
                                        </TooltipsAppearance>
                                    </telerik:ColumnSeries>
                                </Series>
                                <YAxis Name="LeftAxis">
                                    <TitleAppearance Text="Hours"></TitleAppearance>
                                    <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                    <MinorGridLines Visible="false"></MinorGridLines>
                                </YAxis>
                                <XAxis DataLabelsField="Code">
                                    <TitleAppearance Text="Job"></TitleAppearance>
                                    <MinorGridLines Visible="false"></MinorGridLines>
                                    <LabelsAppearance RotationAngle="315"></LabelsAppearance>
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

                    </telerik:LayoutColumn>

                    <telerik:LayoutColumn Span="6" SpanXs="12" SpanSm="12">

                        <h3 style="text-align: center">Time Allocation by Jobs 'In Progress'</h3>
                        <telerik:RadHtmlChart ID="RadHtmlChartJobTime" runat="server" DataSourceID="SqlDataSourceJobsByTime" Width="90%">
                            <Legend>
                                <Appearance Visible="false">
                                </Appearance>
                            </Legend>
                            <PlotArea>
                                <Series>
                                    <telerik:DonutSeries DataFieldY="HourPercent" StartAngle="90" NameField="Code">
                                        <LabelsAppearance Position="OutsideEnd" DataFormatString="{0:N0} %" Visible="true">
                                            <ClientTemplate>
                                                [#=dataItem.Code#]&nbsp;#=dataItem.HourPercent# %
                                            </ClientTemplate>
                                        </LabelsAppearance>
                                        <TooltipsAppearance>
                                            <ClientTemplate>
                                                #=dataItem.Job#
                                            </ClientTemplate>
                                        </TooltipsAppearance>
                                    </telerik:DonutSeries>
                                </Series>
                            </PlotArea>
                        </telerik:RadHtmlChart>

                    </telerik:LayoutColumn>

                </Columns>
            </telerik:LayoutRow>

            <telerik:LayoutRow>
                <Columns>
                    <telerik:LayoutColumn Span="12">
                        <hr style="margin: 0" />
                    </telerik:LayoutColumn>
                </Columns>
            </telerik:LayoutRow>

            <telerik:LayoutRow>
                <Columns>
                    <telerik:LayoutColumn Span="6" SpanXs="12" SpanSm="12">

                        <h3 style="text-align: center">Last Work Times</h3>
                        <telerik:RadGrid ID="RadGridTimes" runat="server" AllowSorting="True" DataSourceID="SqlDataSourceTimes"
                            Width="100%" AutoGenerateColumns="False" AllowPaging="True" PageSize="100" Height="400px"
                            HeaderStyle-Font-Size="X-Small" ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small">
                            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSourceTimes">
                                <PagerStyle Mode="Slider" AlwaysVisible="false" />
                                <Columns>
                                    <telerik:GridDateTimeColumn DataField="Fecha" DataType="System.DateTime" DataFormatString="{0:d}"
                                        HeaderText="Date" SortExpression="Fecha" UniqueName="Fecha" HeaderStyle-Width="80px"
                                        ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                                    </telerik:GridDateTimeColumn>
                                    <telerik:GridNumericColumn AllowFiltering="False" DataField="Time"
                                        HeaderText="Time (hrs)" SortExpression="Time" UniqueName="Time" Aggregate="Sum"
                                        DataFormatString="{0:N1}" FooterAggregateFormatString="{0:N1}" HeaderStyle-Width="80px"
                                        ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                                    </telerik:GridNumericColumn>
                                    <telerik:GridTemplateColumn DataField="categoryId" FilterControlAltText="Filter CategoryId column" Display="false"
                                        HeaderText="Category" SortExpression="categoryId" UniqueName="categoryId" HeaderStyle-HorizontalAlign="Center">
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="cboCategory" runat="server" DataSourceID="SqlDataSourceCategory" SelectedValue='<%# Bind("categoryId")%>'
                                                DataTextField="Name" DataValueField="Id" Width="300px" AppendDataBoundItems="true">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="(Select Time Sheet Category...)" Value="0" />
                                                </Items>
                                            </telerik:RadComboBox>

                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="CategoryLabel" runat="server" Text='<%# Eval("Category")%>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Description" FilterControlAltText="Filter Description column"
                                        HeaderText="Description" SortExpression="Description" UniqueName="Description" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                        <EditItemTemplate>
                                            <telerik:RadTextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description")%>' Width="600px" MaxLength="512" Rows="3" TextMode="MultiLine">
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <%# Eval("DescriptionCompuesta")%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>


                    </telerik:LayoutColumn>

                    <telerik:LayoutColumn Span="6" SpanXs="12" SpanSm="12">

                        <h3 style="text-align: center">Time Clocked Daily</h3>
                        <telerik:RadHtmlChart ID="RadHtmlChartTimeSheet" runat="server" DataSourceID="SqlDataSourceTimeSheet" Height="400px" Width="90%">
                            <PlotArea>
                                <Series>
                                    <telerik:ColumnSeries DataFieldY="WorkHours" Name="Work Time" GroupName="Date">
                                        <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                        </LabelsAppearance>
                                        <Appearance>
                                            <FillStyle BackgroundColor="DarkGreen" />
                                        </Appearance>
                                    </telerik:ColumnSeries>
                                    <telerik:ColumnSeries DataFieldY="NonWorkHours" Name="Other Time" GroupName="Date">
                                        <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                        </LabelsAppearance>
                                        <Appearance>
                                            <FillStyle BackgroundColor="OrangeRed" />
                                        </Appearance>
                                    </telerik:ColumnSeries>
                                    <telerik:ColumnSeries DataFieldY="Hollidays" Name="Holliday" GroupName="Date">
                                        <LabelsAppearance Visible="false" DataFormatString="{0:N0}">
                                        </LabelsAppearance>
                                        <Appearance>
                                            <FillStyle BackgroundColor="Blue" />
                                        </Appearance>
                                    </telerik:ColumnSeries>
                                </Series>
                                <YAxis Name="LeftAxis" Step="1">
                                    <TitleAppearance Text="Hours"></TitleAppearance>
                                    <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                    <MinorGridLines Visible="false"></MinorGridLines>
                                </YAxis>
                                <XAxis DataLabelsField="Date" Type="Date">
                                    <TitleAppearance Text="Date"></TitleAppearance>
                                    <MinorGridLines Visible="false"></MinorGridLines>
                                    <LabelsAppearance RotationAngle="315" DataFormatString="d"></LabelsAppearance>
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

                    </telerik:LayoutColumn>

                </Columns>
            </telerik:LayoutRow>


            <telerik:LayoutRow>
                <Columns>

                    <telerik:LayoutColumn Span="6" SpanXs="12" SpanSm="12">
                    </telerik:LayoutColumn>
                    <telerik:LayoutColumn Span="6" SpanXs="12" SpanSm="12">
                    </telerik:LayoutColumn>
                </Columns>
            </telerik:LayoutRow>
        </Rows>
    </telerik:RadPageLayout>



    <asp:SqlDataSource ID="SqlDataSourceJobsByTime" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOBS_ResultByTime" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboEmployee" Name="employeeId" PropertyName="SelectedValue" />
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTimeUsed" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOBS_ResultByTimeUsed" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboEmployee" Name="employeeId" PropertyName="SelectedValue" />
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClientsByStatus" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="CLIENTS_ResultByStatus" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name]=[FullName]+case when isnull(Inactive,0)=1 then ' (I)' else '' end FROM [Employees] WHERE companyId=@companyId ORDER BY isnull(Inactive,0), FullName">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceTimes" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOBS_ResultByLastTimeRecords" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboEmployee" Name="employeeId" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSourceTimeSheet" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="JOBS_ResultByTimeSheet" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboEmployee" Name="employeeId" PropertyName="SelectedValue" />
            <asp:Parameter Name="RETURN_VALUE" Type="Int32" Direction="ReturnValue" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>

