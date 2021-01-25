<%@ Page Title="PASconcept Mobile App" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="mobileapp.aspx.vb" Inherits="pasconcept20.mobileapp" %>

<%@ Import Namespace="pasconcept20" %>
<%@ MasterType VirtualPath="~/ADM/ADM_Main_Responsive.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pasconcept-bar">
        <span class="pasconcept-pagetitle">PASconcept Mobile App
        </span>
    </div>

    <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSourceMobile" HeaderStyle-HorizontalAlign="Center">
        <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSourceMobile">
            <Columns>
                <telerik:GridBoundColumn UniqueName="Platform" HeaderText="Platform" DataField="Platform" HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true" ItemStyle-Font-Size="Large">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="VersionNumber" HeaderText="Version" DataField="VersionNumber" HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Center">
                </telerik:GridBoundColumn>

                <telerik:GridTemplateColumn HeaderText="Distribution Page Link" UniqueName="Download">
                    <ItemTemplate>
                        <a href='<%#IIf(Eval("Platform") = "iPhone", LocalAPI.GetHostAppSite() & "/distribution/iphone.aspx", LocalAPI.GetHostAppSite() & "/distribution/android.aspx") %>' target="_blank"><%#String.Concat("PASconcept Mobile App Distribution page for ", Eval("Platform"))%></a>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="QR" UniqueName="QR" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <telerik:RadBarcode runat="server" ID="RadBarcode1" Type="QRCode" Width="380px" Height="300px" OutputType="EmbeddedPNG" ToolTip="Distribution Page Link from QR" Text='<%#IIf(Eval("Platform") = "iPhone", LocalAPI.GetHostAppSite() & "/distribution/iphone.aspx", LocalAPI.GetHostAppSite() & "/distribution/android.aspx") %>'>
                            <QRCodeSettings Version="9" DotSize="5" Mode="Byte" />
                        </telerik:RadBarcode>
                        <br /><%# Eval("Platform") %>
                        <br />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>

    <asp:SqlDataSource ID="SqlDataSourceMobile" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
        SelectCommand="SELECT [Platform]=case when [Platform]=1 then 'iPhone' else 'Android' end ,[VersionNumber],[Url]  FROM [dbo].[MobileAppVersions] WHERE [Latest]=1"></asp:SqlDataSource>

</asp:Content>
