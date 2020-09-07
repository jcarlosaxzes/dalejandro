Imports System.Data.Entity
Imports System.Web.Optimization
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.WebFormsDependencyInjection.Unity
Imports PASconcept.DataAccess.Repositories.Abstract
Imports PASconcept.DataAccess.Repositories.Implementation
Imports PASconcept.Domain.Utils
Imports Unity

Public Class Global_asax
    Inherits HttpApplication

    Sub Application_Start(sender As Object, e As EventArgs)
        ' Fires when the application is started
        RouteConfig.RegisterRoutes(RouteTable.Routes)
        BundleConfig.RegisterBundles(BundleTable.Bundles)
        ' See: https://stackoverflow.com/a/34966050/2146113
        Database.SetInitializer (Of ApplicationDbContext)(Nothing)

        Dim container = Me.AddUnity()

        Dim cnnStr = ConfigurationManager.ConnectionStrings("cnnProjectsAccounting")
        If cnnStr Is Nothing Or String.IsNullOrEmpty(cnnStr.ConnectionString)
            Throw new Exception("Fatal error: missing connecting string in web.config file")
        End If

        ' Registering all DI
        container.RegisterInstance(
            Microsoft.Extensions.Options.Options.Create(New AppSettings With {
                                                           .ConnectionString =
                                                           cnnStr.ConnectionString
                                                           })
            )

        container.RegisterType(Of IPASconceptDbContext, PASconceptDbContext)
        container.RegisterType (Of IBaseDapperRepository, BaseDapperRepository)
        container.RegisterType(Of ICompaniesRepository, CompaniesRepository)
        container.RegisterType(Of IQBOperationLogRepository, QBOperationLogRepository)
        container.RegisterType(Of IInvoiceRepository, InvoiceRepository)
    End Sub
    'Private Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)

    '    Dim exc As Exception = Server.GetLastError()
    '    If TypeOf exc Is HttpUnhandledException Then
    '        If exc.InnerException IsNot Nothing Then
    '            InsertSysError(exc)
    '            Server.Transfer("~/ErrorPage.aspx", True)
    '        End If
    '    End If
    'End Sub

    Private Sub InsertSysError(objError As Exception)
        If Not objError Is Nothing Then
            Dim userEmail As String = ""
            Dim MessageErr As String = ""
            Dim SourceErr As String = ""
            Dim StackTraceErr As String = ""
            Try
                userEmail = Context.User.Identity.GetUserName()
            Catch ex As Exception
            End Try
            Try
                MessageErr = objError.Message
            Catch ex As Exception
            End Try
            Try
                SourceErr = objError.Source
            Catch ex As Exception
            End Try
            Try
                StackTraceErr = objError.StackTrace
            Catch ex As Exception
            End Try

            LocalAPI.sys_error_INSERT(Session("companyId"), userEmail, MessageErr, SourceErr, StackTraceErr)
        End If
    End Sub

    Protected Sub Application_EndRequest()
        If Context.Response.StatusCode = 404 Then
            Response.Clear()
            Dim req = Context.Request.Url
            InsertSysError(New Exception("Page Not Found " & req.ToString()))
            Server.Transfer("ErrorPage.aspx", True)
        End If
    End Sub
End Class