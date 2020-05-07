Imports Microsoft.VisualBasic
Imports PayPal.Api
Imports pasconcept20.LocalAPI

Public Class PasConceptPaymentWebhook
    Inherits PasConceptWebhook

    Public Shadows EventTypes As New List(Of WebhookEventType)() From {
        New WebhookEventType() With {
            .name = "PAYMENT.AUTHORIZATION.CREATED"
        },
        New WebhookEventType() With {
            .name = "PAYMENT.AUTHORIZATION.VOIDED"
        },
        New WebhookEventType() With {
            .name = "PAYMENT.CAPTURE.COMPLETED"
        },
        New WebhookEventType() With {
            .name = "PAYMENT.CAPTURE.DENIED"
        },
        New WebhookEventType() With {
            .name = "PAYMENT.CAPTURE.PENDING"
        },
        New WebhookEventType() With {
            .name = "PAYMENT.CAPTURE.REFUNDED"
        },
        New WebhookEventType() With {
            .name = "PAYMENT.CAPTURE.REVERSED"
        },
        New WebhookEventType() With {
            .name = "PAYMENT.PAYOUTSBATCH.DENIED"
        },
        New WebhookEventType() With {
            .name = "PAYMENT.PAYOUTSBATCH.PROCESSING"
        },
        New WebhookEventType() With {
            .name = "PAYMENT.PAYOUTSBATCH.SUCCESS"
        },
        New WebhookEventType() With {
            .name = "PAYMENT.SALE.COMPLETED"
        },
        New WebhookEventType() With {
            .name = "PAYMENT.SALE.DENIED"
        },
        New WebhookEventType() With {
            .name = "PAYMENT.SALE.PENDING"
        },
        New WebhookEventType() With {
            .name = "PAYMENT.SALE.REFUNDED"
        },
        New WebhookEventType() With {
            .name = "PAYMENT.SALE.REVERSED"
        }
    }
    Public Overrides Function AddWebhookToDB(webhookId As String) As Integer
        Return LocalAPI.AddPayPalWebhook(webhookId, PayPalWebhookType.Payment)
    End Function

    Public Overrides Function CreateWebhookObject(httpContext As HttpContext, apiContext As APIContext) As Webhook
        Dim webhook = New Webhook() With {
            .url = WebhookUrl,
            .event_types = EventTypes
        }
        Return webhook.Create(apiContext)
    End Function

    Public Overrides Function InitWebhook(httpContext As HttpContext, apiContext As APIContext) As String
        ' Sets URL
        WebhookUrl = "https://pasconcept-webapp.azurewebsites.net/api/paypal/webhooks/payment.aspx"
        ' Creates webhook
        Dim webhook = CreateWebhookObject(httpContext, apiContext)
        ' Add webhook to DB
        AddWebhookToDB(webhook.id)
        Return webhook.id
    End Function
End Class
