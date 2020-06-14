<%@ Page Title="Expenses Chart" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="expenseschart.aspx.vb" Inherits="pasconcept20.expenseschart" %>

<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .RadListView .rlvFloated {
            display: block;
        }

        .RadListView .rlvAutoScroll .rlvI, .RadListView .rlvAutoScroll .rlvA, .RadListView .rlvAutoScroll .rlvISel, .RadListView .rlvAutoScroll .rlvIEmpty, .RadListView .rlvAutoScroll .rlvIEdit {
            overflow: auto;
        }

        .RadListView .rlvFloated .rlvI, .RadListView .rlvFloated .rlvA, .RadListView .rlvFloated .rlvISel, .RadListView .rlvFloated .rlvIEmpty, .RadListView .rlvFloated .rlvIEdit {
            float: left;
            display: inline;
            border: 1px solid;
        }

        .RadListView div.rlvI, .RadListView div.rlvA, .RadListView div.rlvISel, .RadListView div.rlvIEmpty, .RadListView div.rlvIEdit {
            border-bottom: 1px solid;
            padding-top: 5px;
            padding-bottom: 4px;
        }

        .productItemWrapper {
            height: 220px;
            width: 310px;
            margin: 5px;
            padding-left: 15px;
        }
    </style>
    <div class="row" style="padding-top: 5px; padding-bottom: 10px;">
        <div class="col-md-4">

        </div>
        <div class="col-md-2" style="text-align:right">
            <telerik:RadDropDownList ID="cboYear" runat="server" DataSourceID="SqlDataSourceYear" DataTextField="nYear"
                DataValueField="Year" Width="100px" AutoPostBack="true" CausesValidation="false" UseSubmitBehavior="false">
            </telerik:RadDropDownList>

        </div>
        <div class="col-md-2">
            <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-success btn" UseSubmitBehavior="false"
                ToolTip="Refresh data" CausesValidation="false">
                            <i class="fas fa-redo"></i> Refresh
            </asp:LinkButton>
        </div>
    </div>


    <telerik:RadListView runat="server" ID="FloatedTilesListView" RenderMode="Lightweight" AllowPaging="True"
        DataKeyNames="Category" DataSourceID="SqlDataSource1">
        <AlternatingItemTemplate>

            <div class="rlvA productItemWrapper">
                <h4 style="margin:0;text-align:center">
                    <asp:Label ID="lblAlternatingCategory" runat="server" Font-Bold="true" Text='<%# Eval("Category") %>'></asp:Label>
                </h4>

                <h5 style="margin:0;text-align:right;padding-right:5px; font-weight:bold"><%# Eval("Tot","{0:C2}")%></h4>
                <telerik:RadHtmlChart ID="RainfallChart" runat="server" Width="100%" Height="160px" DataSourceID="SqlDataSourceItemAlternating">
                    <Legend>
                        <Appearance Visible="false">
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <CommonTooltipsAppearance Color="White" />
                        <Series>
                            <telerik:ColumnSeries DataFieldY="Amount" Name="Amount">
                                <Appearance FillStyle-BackgroundColor="DodgerBlue"></Appearance>
                                <LabelsAppearance Visible="false"></LabelsAppearance>
                                <TooltipsAppearance DataFormatString="{0:C2}"></TooltipsAppearance>
                            </telerik:ColumnSeries>
                        </Series>
                        <XAxis DataLabelsField="MonthCode">
                            <MajorGridLines Visible="false" />
                            <MinorGridLines Visible="false" />
                        </XAxis>
                        <YAxis>
                            <MajorGridLines Visible="true" />
                             <MajorGridLines Color="#EFEFEF" Width="1"></MajorGridLines>
                            <MinorGridLines Visible="false" />
                        </YAxis>

                    </PlotArea>
                </telerik:RadHtmlChart>
                <asp:SqlDataSource ID="SqlDataSourceItemAlternating" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
                    SelectCommand="YearStadistic_ExpensesItem_Chart" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
                        <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="lblAlternatingCategory" Name="category" PropertyName="Text" />

                    </SelectParameters>
                </asp:SqlDataSource>

            </div>
        </AlternatingItemTemplate>
        <ItemTemplate>
            <div class="rlvI productItemWrapper">
                <h4 style="margin:0;text-align:center">
                <asp:Label ID="lblItemCategory" runat="server" Font-Bold="true" Text='<%# Eval("Category") %>'></asp:Label>
                </h4>
                <h5 style="margin:0;text-align:right;padding-right:5px; font-weight:bold"><%# Eval("Tot","{0:C2}")%></h5>
                <telerik:RadHtmlChart ID="SunshineChart" runat="server" Width="100%" Height="160px" DataSourceID="SqlDataSourceItem">
                    <Legend>
                        <Appearance Visible="false">
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <CommonTooltipsAppearance Color="White" />
                        <Series>
                            <telerik:ColumnSeries DataFieldY="Amount" Name="Amount">
                                <Appearance FillStyle-BackgroundColor="OrangeRed"></Appearance>
                                <LabelsAppearance Visible="false"></LabelsAppearance>
                                <TooltipsAppearance DataFormatString="{0:C2}"></TooltipsAppearance>
                            </telerik:ColumnSeries>
                        </Series>
                        <XAxis DataLabelsField="MonthCode">
                            <MajorGridLines Visible="false" />
                            <MinorGridLines Visible="false" />
                        </XAxis>
                        <YAxis>
                            <MajorGridLines Visible="true" />
                            <MajorGridLines Color="#EFEFEF" Width="1"></MajorGridLines>
                            <MinorGridLines Visible="false" />
                        </YAxis>
                    </PlotArea>
                </telerik:RadHtmlChart>
                
                <asp:SqlDataSource ID="SqlDataSourceItem" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
                    SelectCommand="YearStadistic_ExpensesItem_Chart" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
                        <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="lblItemCategory" Name="category" PropertyName="Text" />

                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </ItemTemplate>
        <EmptyDataTemplate>
            <div class="RadListView RadListView_<%# Container.Skin %>">
                <div class="rlvEmpty">
                    There are no items to be displayed.
                </div>
            </div>
        </EmptyDataTemplate>
        <LayoutTemplate>
            <div class="RadListView RadListViewFloated ">
                <div class="rlvFloated rlvAutoScroll">
                    <div id="itemPlaceholder" runat="server">
                    </div>
                </div>
                <telerik:RadDataPager RenderMode="Lightweight" ID="RadDataPager1" runat="server" PageSize="60">
                    <Fields>
                        <telerik:RadDataPagerButtonField FieldType="Numeric"></telerik:RadDataPagerButtonField>
                    </Fields>
                </telerik:RadDataPager>
            </div>
        </LayoutTemplate>
    </telerik:RadListView>




    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="YearStadistic_Expenses_Chart" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboYear" DefaultValue="" Name="year" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="category" DefaultValue="" Type="String" />

        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Year], nYear FROM Years ORDER BY [Year] DESC"></asp:SqlDataSource>

    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>

