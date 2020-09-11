<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="android.aspx.vb" Inherits="pasconcept20.android" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Android</title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        </telerik:RadScriptManager>
        <div class="container" style="text-align:center">
            <h1>Install PASconcept app on Android devices.</h1>
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
            
        </div>

        <asp:SqlDataSource ID="SqlDataSourceMobile" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>"
            SelectCommand="SELECT [Platform]=case when [Platform]=1 then 'iPhone' else 'Android' end ,[VersionNumber],[Url]  FROM [dbo].[MobileAppVersions] WHERE [Latest]=1 and Platform=2"></asp:SqlDataSource>
    </form>
</body>
</html>
