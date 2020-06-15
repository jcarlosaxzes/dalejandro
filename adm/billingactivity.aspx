<%@ Page Title="Billing Activity" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="billingactivity.aspx.vb" Inherits="pasconcept20.billingactivity" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="Formulario" >
        <table class="table-sm">
            <tr>
                <td style="width: 280px">
                    <telerik:RadDropDownList ID="cboPeriod" runat="server" AutoPostBack="true" Width="120px">
                        <Items>
                            <telerik:DropDownListItem Text="(Today)" Value="0" />
                            <telerik:DropDownListItem Text="January" Value="1" />
                            <telerik:DropDownListItem Text="February" Value="2" />
                            <telerik:DropDownListItem Text="March" Value="3" />
                            <telerik:DropDownListItem Text="April" Value="4" />
                            <telerik:DropDownListItem Text="May" Value="5" />
                            <telerik:DropDownListItem Text="June" Value="6" />
                            <telerik:DropDownListItem Text="July" Value="7" />
                            <telerik:DropDownListItem Text="August" Value="8" />
                            <telerik:DropDownListItem Text="September" Value="9" />
                            <telerik:DropDownListItem Text="October" Value="10" />
                            <telerik:DropDownListItem Text="November" Value="11" />
                            <telerik:DropDownListItem Text="December" Value="12" />
                            <telerik:DropDownListItem Text="(This Year)" Value="13" />
                            <telerik:DropDownListItem Text="(All Years)" Value="14" />
                        </Items>
                    </telerik:RadDropDownList>
                    <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server" DateFormat="MM/dd/yyyy" Width="130px" Culture="en-US" ToolTip="Date From">
                    </telerik:RadDatePicker>
                </td>
                <td style="width: 130px;">
                    <telerik:RadDatePicker ID="RadDatePickerTo" runat="server" DateFormat="MM/dd/yyyy" Width="130px" Culture="en-US"  ToolTip="Date To">
                    </telerik:RadDatePicker>
                </td>
                <td>
                    <telerik:RadComboBox ID="cboEmployee" runat="server" DataSourceID="SqlDataSourceEmpl" MarkFirstMatch="True"
                        Width="350px" DataTextField="Name" DataValueField="Id" Filter="Contains" Height="300px" AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(All Employees...)" Value="-1" Selected="true" />
                        </Items>
                    </telerik:RadComboBox>

                </td>
                <td>
                    <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-info" UseSubmitBehavior="false">
                                    <i class="fas fa-search"></i> Search
                    </asp:LinkButton>

                </td>
            </tr>
        </table>
        <table class="table-sm">
            <tr>
                <td style="text-align: center; width:150px">Hour
                    <br />
                    <asp:RadioButton runat="server" ID="hour" GroupName="datepart" AutoPostBack="true" />
                </td>
                <td style="text-align: center; width:150px">Day
                    <br />
                    <asp:RadioButton runat="server" ID="day" GroupName="datepart" Checked="true" AutoPostBack="true" />
                </td>
                <td style="text-align: center; width:150px">Week
                    <br />
                    <asp:RadioButton runat="server" ID="week" GroupName="datepart" AutoPostBack="true" />
                </td>
                <td style="text-align: center; width:150px">Weekday
                    <br />
                    <asp:RadioButton runat="server" ID="weekday" GroupName="datepart" AutoPostBack="true" />
                </td>
                <td style="text-align: center; width:150px">Month
                    <br />
                    <asp:RadioButton runat="server" ID="month" GroupName="datepart" AutoPostBack="true" />
                </td>
                <td style="text-align: center; width:150px">Quarter
                    <br />
                    <asp:RadioButton runat="server" ID="quarter" GroupName="datepart" AutoPostBack="true" />
                </td>
                <td style="text-align: center; width:150px">Year
                    <br />
                    <asp:RadioButton runat="server" ID="year" GroupName="datepart" AutoPostBack="true" />
                </td>
            </tr>
        </table>
    </div>

     <div style="text-align: center">
                    <h3>Billing Activity Chart
                    </h3>
         
                </div>
    <div class="pas-container">
        <telerik:RadHtmlChart runat="server" Width="100%" Height="600px" ID="RadChartRemainderStadistic" Transitions="true"
            DataSourceID="SqlDataSourceRemainderStadistic">
            <PlotArea>
                <Series>
                    <telerik:LineSeries DataFieldY="InvoiceRemaindersCount" Name="Invoice Remainders">
                        <Appearance>
                            <FillStyle BackgroundColor="Red" />
                        </Appearance>
                        <LineAppearance LineStyle="Smooth" Width="2" />
                        <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                        <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                        <LabelsAppearance Color="Red" Position="Above"></LabelsAppearance>
                    </telerik:LineSeries>
                    <telerik:LineSeries DataFieldY="InvoiceEmittedCount" Name="Invoice Emitted">
                        <Appearance>
                            <FillStyle BackgroundColor="DarkRed" />
                        </Appearance>
                        <LineAppearance LineStyle="Smooth" Width="1" />
                        <MarkersAppearance MarkersType="Square" BackgroundColor="White"></MarkersAppearance>
                        <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                        <LabelsAppearance Color="DarkRed" DataFormatString="{0:N0}" Position="Above">
                        </LabelsAppearance>
                    </telerik:LineSeries>

                    <telerik:LineSeries DataFieldY="StatementRemaindersCount" Name="Statement Remainders">
                        <Appearance>
                            <FillStyle BackgroundColor="Blue" />
                        </Appearance>
                        <LineAppearance LineStyle="Smooth" Width="2" />
                        <MarkersAppearance MarkersType="Circle" BackgroundColor="White"></MarkersAppearance>
                        <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                        <LabelsAppearance Color="Blue" Position="Above"></LabelsAppearance>
                    </telerik:LineSeries>
                    <telerik:LineSeries DataFieldY="StatementEmittedCount" Name="Statement Emitted">
                        <Appearance>
                            <FillStyle BackgroundColor="DarkBlue" />
                        </Appearance>
                        <LineAppearance LineStyle="Smooth" Width="1" />
                        <MarkersAppearance MarkersType="Square" BackgroundColor="White"></MarkersAppearance>
                        <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                        <LabelsAppearance Color="DarkBlue" DataFormatString="{0:N0}" Position="Above">
                        </LabelsAppearance>
                    </telerik:LineSeries>



                </Series>

                <XAxis DataLabelsField="DateTimeName">
                    <LabelsAppearance RotationAngle="300">
                    </LabelsAppearance>
                    <TitleAppearance Text="">
                    </TitleAppearance>
                    <MinorGridLines Visible="false"></MinorGridLines>
                    <AxisCrossingPoints>
                        <telerik:AxisCrossingPoint Value="0" />
                        <telerik:AxisCrossingPoint Value="9999" />
                    </AxisCrossingPoints>
                </XAxis>
                <YAxis Name="LeftAxis" MajorTickSize="4" MajorTickType="Outside" MinorTickSize="1" Color="DarkBlue" Width="3">
                    <TitleAppearance Text="# Records"></TitleAppearance>
                    <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                    <MinorGridLines Visible="false"></MinorGridLines>
                </YAxis>

            </PlotArea>
            <Legend>
                <Appearance Visible="true" Position="Top">
                </Appearance>
            </Legend>
        </telerik:RadHtmlChart>
    </div>
    <asp:SqlDataSource ID="SqlDataSourceRemainderStadistic" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="RemainderStadistic2_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="RadDatePickerFrom" Name="DateFrom" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="RadDatePickerTo" Name="DateTo" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="lblDatePart" Name="datepart" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="cboEmployee" Name="employeeId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmpl" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="select employeeId as Id, FullName as Name from Invoices_remainders inner join [Employees] ON Invoices_remainders.employeeId=[Employees].Id where Invoices_remainders.companyId=@companyId group by employeeId, FullName order by FullName">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="lblDatePart" runat="server" Visible="False" Text="day"></asp:Label>
    <asp:Label ID="lblEmployeeId" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
</asp:Content>

