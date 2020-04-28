Imports Microsoft.VisualBasic
Imports PayPal.Api
Imports pasconcept20.LocalAPI

Public MustInherit Class PasConceptWebhook
    Public WebhookUrl As String = "https://www.paypal.com/paypal_webhook_samples/" & Guid.NewGuid().ToString()
    Public Property EventTypes() As List(Of WebhookEventType)
        Get
            Return m_EventTypes
        End Get
        Set
            m_EventTypes = Value
        End Set
    End Property
    Private m_EventTypes As List(Of WebhookEventType)

    ''' <summary>
    ''' This Method should be called once, for creating and storing the webhook
    ''' </summary>
    ''' <param name="httpContext"></param>
    ''' <param name="apiContext"></param>
    ''' <returns></returns>
    Public MustOverride Function InitWebhook(httpContext As HttpContext, apiContext As APIContext) As String
    Public MustOverride Function CreateWebhookObject(httpContext As HttpContext, apiContext As APIContext) As Webhook
    Public MustOverride Function AddWebhookToDB(webhookId As String) As Integer
    Public Function GetOrCreateWebhook(httpContext As HttpContext, apiContext As APIContext, webhookType As PayPalWebhookType) As String
        Dim webhookId = LocalAPI.GetPayPalWebhookId(webhookType)
        If String.IsNullOrEmpty(webhookId) Then
            Return InitWebhook(httpContext, apiContext)
        End If
        Return webhookId
    End Function
    Public Function GetWebhook(httpContext As HttpContext, apiContext As APIContext, webhookType As PayPalWebhookType) As String
        Return LocalAPI.GetPayPalWebhookId(webhookType)
    End Function
End Class
