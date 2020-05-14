Imports System.Data.Entity
Imports System.Web.Optimization

Public Class Global_asax
    Inherits HttpApplication

    Sub Application_Start(sender As Object, e As EventArgs)
        ' Fires when the application is started
        RouteConfig.RegisterRoutes(RouteTable.Routes)
        BundleConfig.RegisterBundles(BundleTable.Bundles)
        ' See: https://stackoverflow.com/a/34966050/2146113
        Database.SetInitializer(Of ApplicationDbContext)(Nothing)
    End Sub
    Private Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        Dim exc As Exception = Server.GetLastError()
        Server.Transfer("ErrorPage.aspx", True)
        LocalAPI.sys_log_Nuevo("", LocalAPI.sys_log_AccionENUM.UnhandleError, 0, exc.Message & " -- " & exc.StackTrace)
    End Sub
End Class