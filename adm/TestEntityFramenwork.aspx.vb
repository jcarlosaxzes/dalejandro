Imports PASconcept.DataAccess.Repositories.Abstract
Imports PASconcept.DataAccess.Repositories.Implementation
Imports PASconcept.Domain.Model
Public Class TestEntityFramenwork
    Inherits System.Web.UI.Page

    Private ReadOnly qbOperationLogRepository As IQBOperationLogRepository

    Private ReadOnly invoiceRepository As IInvoiceRepository

    Public Sub New(ByVal qbOperationLogRepository As IQBOperationLogRepository, ByVal invoiceRepo As IInvoiceRepository)
        Me.qbOperationLogRepository = qbOperationLogRepository
        Me.invoiceRepository = invoiceRepo
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnTest1_Click(sender As Object, e As EventArgs)
        'Add Objet to Database Without Repository adn Dependency Injection
        Dim context = New PASconceptDbContext()

        Dim operation As QBOperationLog = New QBOperationLog() With {
            .LogDate = DateTime.Now,
            .OperationData = "Tet 1 From Entity Framework " & DateTime.Now.Second.ToString(),
            .OperationType = "Type operation",
            .ResutlStatus = "Status OK"
         }

        context.QBOperationLogs.Add(operation)
        context.SaveChanges()

    End Sub

    Protected Sub btnTest2_Click(sender As Object, e As EventArgs)

        'Dim Operations = qbOperationLogRepository.ReadAllByCompanyId(0)

        Dim Operations = qbOperationLogRepository.SingleOrDefault(1)

        Operations.OperationData = "Tet 1 From Entity Framework " & DateTime.Now.Second.ToString() + " Update"

        qbOperationLogRepository.Update(Operations)
        qbOperationLogRepository.SaveChanges()

        Dim invss = invoiceRepository.SingleOrDefault(50104)
        'Dim Operations = qbOperationLogRepository.

        '.SingleOrDefault(Function(qbo) qbo.Id <> 1000)
        Console.WriteLine("okok")
    End Sub
End Class