<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/ope/OPE_Master_Pages.Master" CodeBehind="ope_project.aspx.vb" Inherits="pasconcept20.ope_project" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ope/OPE_Master_Pages.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <script type="text/javascript">
            function Back(sender, args) {
                history.back();
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadFormDecorator ID="FormDecorator1" runat="server" DecoratedControls="all" DecorationZoneID="decorationZone" Skin="Bootstrap"></telerik:RadFormDecorator>
    <div id="decorationZone">
        <telerik:RadPageLayout ID="RadPageLayout1" runat="server" GridType="Fluid">
            <Rows>
                <telerik:LayoutRow>
                    <Columns>
                        <telerik:LayoutColumn Span="12">
                            <div>
                                <telerik:RadDataForm runat="server" ID="RadDataForm1" DataKeyNames="Id" DataSourceID="SqlDataSource1" Skin="Bootstrap">
                                    <ItemTemplate>
                                       <%-- <div>
                                            <telerik:RadButton ID="btnBak" runat="server" Text="Back" Width="120px" Skin="Bootstrap" Font-Size="20px" Height="28" OnClientClicked="Back" AutoPostBack="false" UseSubmitBehavior="false">
                                                <Icon PrimaryIconCssClass=" rbPrevious" PrimaryIconLeft="10" PrimaryIconTop="12"></Icon>
                                            </telerik:RadButton>
                                        </div>--%>
                                        <h2 style="margin: 8px"><%# Eval("JobName") %></h2>
                                        <asp:Panel ID="divPhoto" runat="server" Visible='<%# LocalAPI.IsJobPhoto(Eval("Id"))%>'>
                                            <div style="padding-left: 25px">
                                                <telerik:RadBinaryImage ID="RadBinaryImageJob" runat="server" BorderStyle="Double" BorderWidth="2" BorderColor="DarkGray"
                                                    Width="480px" ResizeMode="Fit" DataValue='<%# IIf(Eval("Photo") Is DBNull.Value, Nothing, Eval("Photo"))%>'></telerik:RadBinaryImage>
                                            </div>
                                        </asp:Panel>
                                        <div>
                                            <h3 style="margin: 5px">
                                                <asp:HyperLink ID="hlkJobLabel" runat="server" Text='<%# Eval("ProjectLocation")%>' NavigateUrl='<%# LocalAPI.urlProjectLocationGmap(Eval("ProjectLocation"))%>'
                                                    ToolTip='<%# String.Concat("Click to view [", Eval("ProjectLocation"), "] in Google Maps")%>' Target="_blank"></asp:HyperLink></h3>
                                        </div>
                                        <h4 style="border: none">Date Open:&nbsp;<%# Eval("Open_date", "{0:d}")%>&nbsp;&nbsp;&nbsp;Status:&nbsp;<%# Eval("nStatus") %></h4>
                                        <h4 style="border: none">Project Manager:&nbsp;<%# Eval("EmployeeName")%></h4>
                                        <h4><%# Eval("ProposalType") %>
                                            <%# Eval("JobType") %></h4>
                                        <h5 style="border: none"><%# Eval("UnitMeasure") %></h5>
                                        <h5 style="border: none"><%# IIf(Len(Eval("Owner")) > 0, String.Concat("Owner: ", Eval("Owner")), "") %></h5>
                                        <h5 style="border: none"><%# Eval("Sector") %>, <%# Eval("Entity")%></h5>
                                        <h5 style="border: none"><%# Eval("Use") %></h5>
                                        <h5 style="border: none"><%# Eval("Use2Description") %></h5>
                                        <h5 style="border: none"></h5>
                                        <%# Eval("ConstructionType") %></h5>
                                        <h5 style="border: none"><%# Eval("ConstructionSubType") %></h5>
                                        <h5 style="border: none"><%# IIf(Len(Eval("Description")) > 0, String.Concat("<b>Description:</b><br />", Eval("Description")), "") %></h5>
                                    </ItemTemplate>
                                </telerik:RadDataForm>
                            </div>
                        </telerik:LayoutColumn>
                    </Columns>
                </telerik:LayoutRow>
                <telerik:LayoutRow>
                    <Content>
                        <div style="padding-top:25px">
                        <telerik:RadSocialShare RenderMode="Lightweight" ID="RadSocialShare1" runat="server" Skin="Telerik"
                            UrlToShare='<%# String.Concat(LocalAPI.GetHostAppSite() & "/ope/ope_project.aspx?guId=", Eval("guid"),"&Id=",Eval("id"))%>'
                            TitleToShare='<%# Eval("JobName")%>'>
                            <MainButtons>
                                <telerik:RadSocialButton SocialNetType="ShareOnFacebook"></telerik:RadSocialButton>
                                <telerik:RadSocialButton SocialNetType="ShareOnTwitter"></telerik:RadSocialButton>
                                <telerik:RadSocialButton SocialNetType="ShareOnGooglePlus"></telerik:RadSocialButton>
                                <telerik:RadSocialButton SocialNetType="LinkedIn"></telerik:RadSocialButton>
                            </MainButtons>
                        </telerik:RadSocialShare>
                        </div>
                    </Content>
                </telerik:LayoutRow>

            </Rows>
        </telerik:RadPageLayout>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="OPE_JOB_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="lblGUID" Name="guid" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lblGUID" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblJobId" runat="server" Visible="False"></asp:Label>

</asp:Content>

