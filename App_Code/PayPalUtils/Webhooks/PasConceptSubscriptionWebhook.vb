Imports Microsoft.VisualBasic
Imports pasconcept20.LocalAPI
Imports PayPal.Api

Public Class PasConceptSubscriptionWebhook
    Inherits PasConceptWebhook

    Public Shadows EventTypes As New List(Of WebhookEventType)() From {
        New WebhookEventType() With {
            .name = "BILLING.SUBSCRIPTION.CANCELLED"
        },
        New WebhookEventType() With {
            .name = "BILLING.SUBSCRIPTION.CREATED"
        },
        New WebhookEventType() With {
            .name = "BILLING.SUBSCRIPTION.RE-ACTIVATED"
        },
        New WebhookEventType() With {
            .name = "BILLING.SUBSCRIPTION.SUSPENDED"
        },
        New WebhookEventType() With {
            .name = "BILLING.SUBSCRIPTION.UPDATED"
        }
    }
    Public Overrides Function AddWebhookToDB(webhookId As String) As Integer
        Return LocalAPI.AddPayPalWebhook(webhookId, PayPalWebhookType.Subscription)
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
        WebhookUrl = "https://pasconcept-webapp.azurewebsites.net/api/paypal/webhooks/subscription.aspx"
        ' Creates webhook
        Dim webhook = CreateWebhookObject(httpContext, apiContext)
        ' Add webhook to DB
        AddWebhookToDB(webhook.id)
        Return webhook.id
    End Function
End Class
