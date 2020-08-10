Imports System.IO
Imports Newtonsoft.Json
Imports pasconcept20.LocalAPI
Imports pasconcept20.PasConcept.PayPalUtils.Webhooks.JSON.Payments
Imports PayPal.Api

Public Class api_paypal_webhooks_payment
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Dim apiContext = Configuration.GetAPIContext()
            Dim planWebhook = New PasConceptPaymentWebhook()
            ' Creates for first time the webhook if doesn't exists in DB
            planWebhook.GetOrCreateWebhook(HttpContext.Current, apiContext, PayPalWebhookType.Payment)
        End If
        If HttpContext.Current.Request.HttpMethod = "POST" Then
            Dim apiContext = Configuration.GetAPIContext()
            Dim requestHeaders = HttpContext.Current.Request.Headers
            Dim rb = String.Empty
            Using r = New StreamReader(HttpContext.Current.Request.InputStream)
                rb = r.ReadToEnd()
            End Using
            SendGrid.Email.SendMail("curbelorobin@gmail.com", "jcarlos@axzes.com,robin@axzes.com,matt@axzes.com", "", "PasConcept Payment Attempt", rb, 260973, 0, 0)
            Try
                Dim webhookId = LocalAPI.GetPayPalWebhookId(PayPalWebhookType.Payment)
                Dim isValid = Not [String].IsNullOrEmpty(webhookId) AndAlso WebhookEvent.ValidateReceivedEvent(apiContext, requestHeaders, rb, webhookId)
                If isValid Then
                    ' TODO: Do something with webhook in here (don't exaclty what yet, for the moment I'll send to myself an email)
                    SendGrid.Email.SendMail("curbelorobin@gmail.com", "jcarlos@axzes.com,robin@axzes.com,matt@axzes.com", "", "PasConcept PayPal Payment notification", rb, 260973, 0, 0)
                    Dim resp As RootObject = JsonConvert.DeserializeObject(Of RootObject)(rb)
                    Dim res As Resource = resp.resource
                    LocalAPI.LogPayPalPayment(res.id, res.billing_agreement_id, resp.event_type, resp.summary, resp.create_time)
                    ' Create Payment in DB
                    If resp.event_type = "PAYMENT.SALE.COMPLETED" Then
                        LocalAPI.AddPayPalPayment(res.id, res.billing_agreement_id, res.amount.total, res.amount.currency, resp.create_time)
                    End If
                Else
                    SendGrid.Email.SendMail("curbelorobin@gmail.com", "robin@axzes.com", "jcarlos@axzes.com", "PasConcept PayPal Payment Not Valid", webhookId, 260973, 0, 0)
                End If
            Catch ex As Exception
                SendGrid.Email.SendMail("curbelorobin@gmail.com", "jcarlos@axzes.com,robin@axzes.com,matt@axzes.com", "", "PasConcept PayPal Payment exception", ex.Message, 260973, 0, 0)
            End Try
        End If
    End Sub
End Class
