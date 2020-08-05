<%@ Page Title="Jobs YOY" Language="vb" AutoEventWireup="false" MasterPageFile="~/e2103445_8a47_49ff_808e_6008c0fe13a1/smarth/mastersmarth.Master" CodeBehind="dashboard_jobsyoy.aspx.vb" Inherits="pasconcept20.dashboard_jobsyoy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        h1 {
            font-size: 18px;
        }

        h2 {
            font-size: 24px;
        }

        .PanelGreen {
            font-size: 16px;
            color: black;
            font-weight: bold;
            background-color: rgb(145, 199, 148);
        }

        .PanelGray {
            font-size: 16px;
            color: black;
            font-weight: bold;
            background-color: gray;
        }

        .PanelRed {
            font-size: 16px;
            color: black;
            font-weight: bold;
            background-color: rgb(214, 76, 76);
        }

        .PanelBlue {
            font-size: 16px;
            color: black;
            font-weight: bold;
            background-color: rgb(92, 194, 241);
        }

        .PanelWhite {
            font-size: 16px;
            color: black;
            font-weight: bold;
        }

        .ComboLabel {
            font-size: 14px;
            color: darkblue;
            font-weight: bold;
        }
    </style>


    <div id="main-section-header" class="row">
        <table class="table-condensed" style="width: 100%">
            <tr>
                <td style="text-align: right">
                    <telerik:RadComboBox ID="cboDepartment" runat="server" DataSourceID="SqlDataSourceDepartments" AutoPostBack="true"
                        Label="Department:" LabelCssClass="ComboLabel"
                        DataTextField="Name" DataValueField="Id" Width="95%" AppendDataBoundItems="true" Font-Size="12px">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="(All Departments...)" Value="0" Selected="true" />
                        </Items>
                    </telerik:RadComboBox>

                </td>
            </tr>
        </table>

        <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1" Width="100%">
            <ItemTemplate>
                <div style="text-align: center; width: 100%">

                    <%--MTD--%>
                    <table class="table-condensed" style="width: 98%">

                        <tr>
                            <td></td>
                            <td style="width: 40%">
                                <p class="text-success input-lg PanelGray">MTD Y- 1</p>
                                <h1 style="color: dimgray"><%# Eval("Budget_MTDY_1", "{0:C0}")%></h1>
                                <h2 style="color: dimgray"><%# Eval("Number_MTDY_1", "{0:N0}")%></h2>
                            </td>
                            <td style="width: 18%; vertical-align: bottom">
                                <h2 style="color: darkred"><%# Eval("Budget_MTD_Percent", "{0:N0}")%>%</h2>
                                <h1 style="color: dimgray"><%# Eval("Number_MTD_Percent", "{0:N0}")%>%</h1>
                            </td>
                            <td style="vertical-align: bottom;">
                                <h2 style='<%# iif(Eval("Budget_MTD_Percent")>=0,"color:green","color:red") %>'><span class='<%#IIf(Eval("Budget_MTD_Percent") < 0, "fas fa-arrow-down", "fas fa-arrow-up") %>'></h2>
                                <h1 style='<%# iif(Eval("Number_MTD_Percent")>=0,"color:green","color:red") %>'><span class='<%#IIf(Eval("Number_MTD_Percent") < 0, "fas fa-arrow-down", "fas fa-arrow-up") %>'></h1>
                            </td>
                            <td style="width: 40%">
                                <p class="text-success input-lg PanelGreen">MTD</p>
                                <h1 style="color: darkblue"><%# Eval("Budget_MTD", "{0:C0}")%></h1>
                                <h2 style="color: darkblue"><%# Eval("Number_MTD", "{0:N0}")%></h2>
                            </td>
                        </tr>

                    </table>

                    <hr style="margin: 0" />
                    <br />
                    <%--QTD--%>
                    <table class="table-condensed" style="width: 98%">

                        <tr>
                            <td></td>
                            <td style="width: 40%">
                                <p class="text-success input-lg PanelGray">QTD Y- 1</p>
                                <h1 style="color: dimgray"><%# Eval("Budget_QTDY_1", "{0:C0}")%></h1>
                                <h2 style="color: dimgray"><%# Eval("Number_QTDY_1", "{0:N0}")%></h2>
                            </td>
                            <td style="width: 18%; vertical-align: bottom">
                                <h2 style="color: darkred"><%# Eval("Budget_QTD_Percent", "{0:N0}")%>%</h2>
                                <h1 style="color: dimgray"><%# Eval("Number_QTD_Percent", "{0:N0}")%>%</h1>
                            </td>
                            <td style="vertical-align: bottom;">
                                <h2 style='<%# iif(Eval("Budget_QTD_Percent")>=0,"color:green","color:red") %>'><span class='<%#IIf(Eval("Budget_QTD_Percent") < 0, "fas fa-arrow-down", "fas fa-arrow-up") %>'></h2>
                                <h1 style='<%# iif(Eval("Number_QTD_Percent")>=0,"color:green","color:red") %>'><span class='<%#IIf(Eval("Number_QTD_Percent") < 0, "fas fa-arrow-down", "fas fa-arrow-up") %>'></h1>
                            </td>
                            <td style="width: 40%">
                                <p class="text-success input-lg PanelGreen">QTD</p>
                                <h1 style="color: darkblue"><%# Eval("Budget_QTD", "{0:C0}")%></h1>
                                <h2 style="color: darkblue"><%# Eval("Number_QTD", "{0:N0}")%></h2>
                            </td>
                        </tr>


                    </table>

                    <hr style="margin: 0" />
                    <br />
                    <%--YTD--%>
                    <table class="table-condensed" style="width: 98%">

                        <tr>
                            <td></td>
                            <td style="width: 40%">
                                <p class="text-success input-lg PanelGray">YTD Y- 1</p>
                                <h1 style="color: dimgray"><%# Eval("Budget_YTDY_1", "{0:C0}")%></h1>
                                <h2 style="color: dimgray"><%# Eval("Number_YTDY_1", "{0:N0}")%></h2>
                            </td>
                            <td style="width: 18%; vertical-align: bottom">

                                <h2 style="color: darkred"><%# Eval("Budget_YTD_Percent", "{0:N0}")%>%</h2>
                                <h1 style="color: dimgray"><%# Eval("Number_YTD_Percent", "{0:N0}")%>%</h1>
                            </td>
                            <td style="vertical-align: bottom;">
                                <h2 style='<%# iif(Eval("Budget_YTD_Percent")>=0,"color:green","color:red") %>'><span class='<%#IIf(Eval("Budget_YTD_Percent") < 0, "fas fa-arrow-down", "fas fa-arrow-up") %>'></h2>
                                <h1 style='<%# iif(Eval("Number_YTD_Percent")>=0,"color:green","color:red") %>'><span class='<%#IIf(Eval("Number_YTD_Percent") < 0, "fas fa-arrow-down", "fas fa-arrow-up") %>'></h1>

                            </td>
                            <td style="width: 40%">
                                <p class="text-success input-lg PanelGreen">YTD</p>
                                <h1 style="color: darkblue"><%# Eval("Budget_YTD", "{0:C0}")%></h1>
                                <h2 style="color: darkblue"><%# Eval("Number_YTD", "{0:N0}")%></h2>
                            </td>
                        </tr>


                    </table>

                </div>
            </ItemTemplate>
        </asp:FormView>



    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="Dashboard2_JobsYOY" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboDepartment" Name="DepartmentId" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Id], [Name] FROM [Company_Department] WHERE companyId=@companyId and isnull(Productive,0)=1 ORDER BY [Name]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblCompanyId" runat="server" Text="0" Visible="False"></asp:Label>

</asp:Content>
