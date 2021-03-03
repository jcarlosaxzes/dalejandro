<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="iphone.aspx.vb" Inherits="pasconcept20.iphone" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PASconcept. iPhone</title>
    <link href="~/Content/bootstrap.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        </telerik:RadScriptManager>
        <div class="container" style="text-align:center">
            <h1>Install PASconcept app on iOS devices.</h1>
            <p>To install the PASconcept app on your devices you must click on the Download link. </p>

            <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSourceMobile" Width="100%">
                <ItemTemplate>
                    <div style="text-align: center">
                        <table class="table-condensed" style="width: 100%">
                            <tr>
                                <tr>
                                    <td>
                                    <h2>Version: <%# Eval("VersionNumber")%></h2>
                                    </td>
                                </tr>
                            <tr>
                                <td>
                                   <h1><a href='<%# Eval("url")%>'>Click to Install</a></h1>
                                </td>
                            </tr>

                        </table>
                    </div>
                </ItemTemplate>
            </asp:FormView>
            <br />
            <h2>Installation Instructions</h2>
            <table class="table-condensed" style="width: 100%">
                <tr>
                    <td colspan="2" style="text-align:left">
                        <b>Step 1</b>. Download link and wait until it is downloaded and installed.
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="../Images/mobile/PAS-iphone_install1.png" alt="Example" />
                    </td>
                    <td>
                        <img src="../Images/mobile/PAS-iphone_install2.png" alt="Example" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align:left">
                        <br /><br />
                        <b>Step 2</b>. Before opening this app for the first time you must establish trust for the “Axzes, LLC Developer”.  To do this go to Settings > General > Profiles or Profiles & Device Management. 
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="../Images/mobile/PAS-iphone_install3.png" alt="Example" />
                    </td>
                    <td>
                        <img src="../Images/mobile/PAS-iphone_install4.png" alt="Example" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align:left">
                        <br /><br />
                        <b>Step 3</b>. Under the "Enterprise App" heading, you see the “Axzes, LLC” profile.  Tap on this profile to establish trust for “Axzes, LLC”.
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="../Images/mobile/PAS-iphone_install5.png" alt="Example" />
                    </td>
                    <td>
                        <img src="../Images/mobile/PAS-iphone_install6.png" alt="Example" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        After this verification you can go and open the PASconcept app.
                    </td>
                </tr>
            </table>
        </div>

        <asp:SqlDataSource ID="SqlDataSourceMobile" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="SELECT [Platform]=case when [Platform]=1 then 'iPhone' else 'Android' end ,[VersionNumber],[Url]  FROM [dbo].[MobileAppVersions] WHERE [Latest]=1 and Platform=1"></asp:SqlDataSource>
    </form>
</body>
</html>