<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="job.aspx.vb" Inherits="pasconcept20.job" %>

<%@ Import Namespace="pasconcept20" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Job</title>
    <link href="~/Content/bootstrap.css" rel="stylesheet" />
    <style type="text/css">
        .borderCssClass div {
            border: 1px solid red;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" EnableCdn="true" runat="server">
        </telerik:RadScriptManager>


        <div class="container">
            <div class="row">
                <asp:FormView ID="FormViewCompany" runat="server" DataKeyNames="companyId" DataSourceID="SqlDataSourceCompany" RenderOuterTable="false">
                    <ItemTemplate>
                        <table style="width: 100%; background-color: white;">
                            <tr>
                                <td style="text-align: left; width: 200px">
                                    <a href='<%# Eval("web") %>' target="_blank">
                                        <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" AlternateText="Logo" CssClass="img-responsive" Style="width: 160px; height: 150px; margin: auto;"
                                            DataValue='<%# IIf(Eval("Logo") Is DBNull.Value, Nothing, Eval("Logo"))%>'></telerik:RadBinaryImage>
                                    </a>
                                </td>
                                <td style="text-align: right; vertical-align: top">
                                    <h3 style="margin: 5px"><%# Eval("Name") %></h3>
                                    <span class="glyphicon glyphicon-map-marker"></span>&nbsp;<%# Eval("Address") %><br>
                                    <%# Eval("City") %>, <%# Eval("State") %> <%# Eval("ZipCode") %><br>
                                    <span class="glyphicon glyphicon-earphone"></span>&nbsp;<%# LocalAPI.PhoneHTML(Request.UserAgent, Eval("Phone"))%><br>
                                    <span class="glyphicon glyphicon-envelope"></span>&nbsp;<%# Eval("Email") %><br>
                                    <span class="glyphicon glyphicon-globe"></span>&nbsp;<a href='<%# Eval("web") %>' target="_blank"><%# Eval("web") %></a>
                                </td>
                            </tr>


                        </table>
                    </ItemTemplate>
                </asp:FormView>
            </div>


            <div class="row">
                <hr />
            </div>

            <div class="row">
                <telerik:RadDataForm runat="server" ID="RadDataForm1" DataKeyNames="Id" DataSourceID="SqlDataSource1" Skin="Bootstrap">
                    <ItemTemplate>

                        <table style="width: 100%">
                            <tr>
                                <td style="width: 60%; vertical-align: top">
                                    <h3 style="margin: 0 0 5px 0"><%# String.Concat(Eval("Code"), " ", Eval("JobName")) %></h3>
                                    <p>
                                        <table>
                                            <tr>
                                                <td style="width: 120px;font-weight:bold">Open:&nbsp;
                                                </td>
                                                <td>
                                                    <%# Eval("Open_date", "{0:d}")%>
                                                </td>

                                            </tr>
                                            <tr>
                                                <td style="font-weight:bold">Project Location:&nbsp;
                                                </td>
                                                <td>
                                                    <a href='<%# LocalAPI.urlProjectLocationGmap(Eval("ProjectLocation"))%>' target="_blank"><%# Eval("ProjectLocation")%></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-weight:bold">Project Type:&nbsp;
                                                </td>
                                                <td>
                                                    <%# Eval("ProposalType")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-weight:bold">Project Area:&nbsp;
                                                </td>
                                                <td>
                                                    <%# Eval("UnitMeasure") %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-weight:bold">Project Status:&nbsp;
                                                </td>
                                                <td>
                                                    <%# Eval("nStatus") %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-weight:bold">Project Manager:&nbsp;</td>
                                                <td>
                                                    <%# Eval("EmployeeName")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-weight:bold">Sector:&nbsp;
                                                </td>
                                                <td>
                                                    <%# Eval("Sector")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-weight:bold">Use:&nbsp;
                                                </td>
                                                <td>
                                                    <%# Eval("Use")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align:top;font-weight:bold">Tags:&nbsp;
                                                </td>
                                                <td>
                                                    <%# Eval("Tags")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </p>
                                </td>
                                <td style="vertical-align: top; text-align: right">
                                    <h3 style="margin: 0 0 5px 0"><%# Eval("ClientName")%></h3>
                                    <p>
                                        <%# Eval("ClientCompany") %><br />
                                        <%# Eval("ClientFullAddress")%><br />
                                        <%# LocalAPI.PhoneHTML(Request.UserAgent, Eval("ClientPhone"))%><br />
                                        <a href='<%#String.Concat("mailto:", Eval("ClientEmail"),"?subject=",Eval("JobName")) %>' title="Mail to"><%#Eval("ClientEmail") %></a>
                                    </p>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <div id="itemPlaceholder" runat="server">
                        </div>
                    </LayoutTemplate>
                </telerik:RadDataForm>
            </div>
            <div class="row">
                <hr />
            </div>


            <div class="row">
                <h3 style="margin: 0 0 5px 0">DESIGN CRITERIA</h3>
                <telerik:RadGrid ID="RadGridScopeOfWork" runat="server" DataSourceID="SqlDataSourceSCOPEOFWORK" Skin="" GridLines="None"
                    ShowGroupPanel="false">
                    <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSourceSCOPEOFWORK" ShowHeader="false">
                        <Columns>
                            <telerik:GridTemplateColumn DataField="Taskcode" HeaderText="Taskcode" UniqueName="Taskcode">
                                <ItemTemplate>
                                    <table style="width: 100%">
                                        <tr>
                                            <td><%# Eval("PhaseCode")%>&nbsp;&nbsp;<%# Eval("Description")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: justify; padding-left: 10px"><%# Eval("DescriptionPlus")%>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>

            <div class="row">
                <hr />
                <h3 style="margin: 0 0 5px 0">IMAGES</h3>
            </div>

            <div class="row">
                <div class="col-md-4">
                    <asp:Image ID="imgGoogleStreetview" runat="server" ImageUrl='<%# LocalAPI.GetJobStreeViewImage(lblJobId.Text, "800x600") %>' />
                </div>
                <div class="col-md-8">
                    <telerik:RadListView ID="RadListView1" runat="server" DataSourceID="SqlDataSourceFotos" DataKeyNames="Id" ItemPlaceholderID="Container1"
                        BorderStyle="Solid">
                        <LayoutTemplate>
                            <fieldset style="width: 100%">
                                <asp:PlaceHolder ID="Container1" runat="server"></asp:PlaceHolder>
                            </fieldset>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <fieldset style="float: left; width: 270px;">
                                <table class="table-condensed">
                                    <tr>
                                        <td style="text-align: center; width: 265px">

                                            <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" AlternateText="Job Photo"
                                                Width="100%" Height="290px" ResizeMode="Fit" ImageUrl='<%# Eval("Photo")%>'></telerik:RadBinaryImage>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td style="text-align: center">
                                            <%#Eval("OriginalFileName")%>
                                        </td>


                                    </tr>
                                </table>
                            </fieldset>
                        </ItemTemplate>
                    </telerik:RadListView>
                </div>

            </div>
</div>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
                SelectCommand="JOB_ADMCLI_SELECT" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                    <asp:ControlParameter ControlID="lblJobId" Name="JobId" PropertyName="Text" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceSCOPEOFWORK" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
                SelectCommand="JOB_SCOPEOFWORK_SELECT" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                    <asp:ControlParameter ControlID="lblJobId" Name="JobId" PropertyName="Text" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceCompany" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
                SelectCommand="select companyId, Name, Address, City, State, ZipCode, ISNULL(Phone,'') AS Phone, Email, web, shortLogo as Logo, web from Company where companyId=@companyId">
                <SelectParameters>
                    <asp:ControlParameter ControlID="lblCompanyId" Name="companyId" PropertyName="Text" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceFotos" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
                SelectCommand="JOB_Photos_SELECT" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="lblJobId" DefaultValue="0" Name="JobId" PropertyName="Text" Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
            </asp:SqlDataSource>

            <asp:Label ID="lblJobId" runat="server" Visible="False"></asp:Label>
            <asp:Label ID="lblCompanyId" runat="server" Visible="False"></asp:Label>
    </form>
</body>
</html>
