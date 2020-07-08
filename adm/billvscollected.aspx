<%@ Page Title="Bill vs Collected" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="billvscollected.aspx.vb" Inherits="pasconcept20.billvscollected" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="pasconcept-bar noprint">
        <span class="pasconcept-pagetitle">Bill vs Collected</span>

        <span style="float: right; vertical-align: middle;">
            <button class="btn btn-warning" type="button" data-toggle="collapse" data-target="#collapseFilter" aria-expanded="false" aria-controls="collapseFilter" title="Show/Hide Filter panel">
                <i class="fas fa-filter"></i>&nbsp;Filter
            </button>
        </span>
    </div>

    <div class="collapse" id="collapseFilter">

        <asp:Panel ID="pnlFind" runat="server" DefaultButton="btnRefresh">
            <table class="table-sm pasconcept-bar" style="width: 100%">
                <tr>
                    <td style="width: 200px">
                        <telerik:RadComboBox ID="cboYear" runat="server" DataSourceID="SqlDataSourceYear"
                            DataTextField="Year" DataValueField="Year" Width="100%">
                        </telerik:RadComboBox>
                    </td>
                    <td style="width: 350px">

                        <telerik:RadComboBox ID="cboDepartments" runat="server" AppendDataBoundItems="true"
                            DataSourceID="SqlDataSourceDepartments" DataTextField="Name" DataValueField="Id" Filter="Contains"
                            Height="250px" MarkFirstMatch="True" Width="100%" DropDownAutoWidth="Enabled" EmptyMessage="(Select Department...)">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Selected="true" Text="(All Departments...)" Value="-1" />
                            </Items>
                        </telerik:RadComboBox>

                    </td>
                    <td>
                        <telerik:RadComboBox ID="cboEmployees" runat="server" DataSourceID="SqlDataSourceEmployees" MarkFirstMatch="True"
                            Width="350px" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="(All Employees...)" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>

                    </td>
                    <td style="width: 150px; text-align: right">
                        <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-info btn" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Filter/Search
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:Panel>

    </div>

    <table class="table-sm pasconcept-bar" style="width: 100%">
        <tr>
            <td style="width: 30%;">
                <br />
                <telerik:RadGrid ID="RadGrid1" runat="server" CellSpacing="0" Culture="en-US" DataSourceID="SqlDataSourceMonth" GridLines="None"
                    ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" FooterStyle-Font-Size="X-Small" HeaderStyle-Font-Size="Small">
                    <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSourceMonth" ShowFooter="true">
                        <Columns>
                            <telerik:GridBoundColumn DataField="colMonth" FilterControlAltText="Filter colMonth column" HeaderText="Month" ReadOnly="True" SortExpression="colMonth" UniqueName="colMonth"
                                HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                FooterText="<b>TOTAL:</b> ">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Bill" DataType="System.Decimal" FilterControlAltText="Filter Bill column" HeaderText="Bill" ReadOnly="True" SortExpression="Bill" UniqueName="Bill"
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right"
                                Aggregate="Sum" DataFormatString="{0:N0}" FooterAggregateFormatString="{0:C0}" FooterStyle-HorizontalAlign="Right">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Collected" DataType="System.Double" FilterControlAltText="Filter Collected column" HeaderText="Collected" ReadOnly="True" SortExpression="Collected" UniqueName="Collected"
                                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                                Aggregate="Sum" DataFormatString="{0:N0}" FooterAggregateFormatString="{0:C0}" FooterStyle-HorizontalAlign="Right">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="AmountDue" DataType="System.Double" FilterControlAltText="Filter AmountDue column" HeaderText="A. Due" ReadOnly="True" SortExpression="AmountDue" UniqueName="AmountDue"
                                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                                DataFormatString="{0:N0}">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
            <td style="vertical-align:top">
                <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" DataSourceID="SqlDataSourceMonth" Height="550px" Width="100%" Skin="Material">
                    <PlotArea>
                        <Series>
                            <telerik:ColumnSeries DataFieldY="Bill" Name="Billing">
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
                        </Series>
                        <Series>
                            <telerik:LineSeries DataFieldY="AmountDue" Name="AmountDue">
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
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="RadGrid2" runat="server" CellSpacing="0" Culture="en-US" DataSourceID="SqlDataSourceByYear" GridLines="None"
                    ItemStyle-Font-Size="X-Small" AlternatingItemStyle-Font-Size="X-Small" FooterStyle-Font-Size="X-Small" HeaderStyle-Font-Size="Small">
                    <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSourceByYear" ShowFooter="true">
                        <Columns>
                            <telerik:GridBoundColumn DataField="Year" FilterControlAltText="Filter Year column" HeaderText="Year" ReadOnly="True" SortExpression="Year" UniqueName="Year"
                                HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                FooterText="<b>TOTAL:</b> ">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Bill" DataType="System.Decimal" FilterControlAltText="Filter Bill column" HeaderText="Bill" ReadOnly="True" SortExpression="Bill" UniqueName="Bill"
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right"
                                Aggregate="Sum" DataFormatString="{0:N0}" FooterAggregateFormatString="{0:C0}" FooterStyle-HorizontalAlign="Right">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Collected" DataType="System.Double" FilterControlAltText="Filter Collected column" HeaderText="Collected" ReadOnly="True" SortExpression="Collected" UniqueName="Collected"
                                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                                Aggregate="Sum" DataFormatString="{0:N0}" FooterAggregateFormatString="{0:C0}" FooterStyle-HorizontalAlign="Right">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
            <td style="vertical-align:top">
                <telerik:RadHtmlChart ID="RadHtmlChart2" runat="server" DataSourceID="SqlDataSourceByYear" Height="400px" Width="100%" Skin="Material">
                    <PlotArea>
                        <Series>
                            <telerik:ColumnSeries DataFieldY="Bill" Name="Billing">
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
                        </Series>
                        <XAxis DataLabelsField="Year">
                            <TitleAppearance Text="Year"></TitleAppearance>
                            <MinorGridLines Visible="false"></MinorGridLines>
                        </XAxis>
                        <YAxis MajorTickSize="4" MajorTickType="Outside" MinorTickSize="1">
                            <LabelsAppearance DataFormatString="{0:C0}"></LabelsAppearance>
                            <MinorGridLines Visible="false"></MinorGridLines>
                        </YAxis>
                    </PlotArea>
                    <Legend>
                        <Appearance Visible="false"></Appearance>
                    </Legend>
                    <ChartTitle Text="Bill vs Collected by Year">
                        <Appearance Visible="true"></Appearance>
                    </ChartTitle>
                </telerik:RadHtmlChart>
            </td>
        </tr>
    </table>


    <asp:SqlDataSource ID="SqlDataSourceMonth" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="BILL_VS_COLLECTED3" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboEmployees" Name="employeeId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboDepartments" Name="departmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboYear" Name="Year" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceByYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="BILL_VS_COLLECTED_byYear" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="cboEmployees" Name="employeeId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="cboDepartments" Name="departmentId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], FullName As Name FROM [Employees] WHERE companyId=@companyId ORDER BY [Name]">
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
    <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="select Year(InvoiceDate) as [Year] from Invoices INNER JOIN Jobs ON Invoices.JobId = Jobs.Id where Jobs.companyId=@companyId group by Year(InvoiceDate) order by Year(InvoiceDate) desc">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
        </SelectParameters>

    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>

</asp:Content>

