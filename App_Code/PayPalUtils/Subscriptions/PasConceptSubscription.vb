Imports Microsoft.VisualBasic
Imports PayPal.Api
Public MustInherit Class PasConceptSubscription
    Public PlanName As String = "Subscription"
    Public PlanDescription As String = "Subscription Description"
    Public PlanType As String = "INFINITE"
    Public Property Plan() As Plan
        Get
            Return m_Plan
        End Get
        Set
            m_Plan = Value
        End Set
    End Property
    Private m_Plan As Plan
    Public PaymentDefinitions As List(Of PaymentDefinition)
    ''' <summary>
    ''' This Method should be called once, for creating and storing the billing plan
    ''' </summary>
    ''' <param name="httpContext"></param>
    ''' <param name="apiContext"></param>
    ''' <returns></returns>
    Public MustOverride Function InitSubscription(httpContext As HttpContext, apiContext As APIContext) As String
    Public MustOverride Function CreatePlanObject(httpContext As HttpContext, apiContext As APIContext) As Plan
    Public MustOverride Function CreateBillingAgreement(httpContext As HttpContext, apiContext As APIContext, planId As String, Optional paymentMethod As String = "paypal") As Agreement
    Public MustOverride Function AddPlanToDB(planId As String, planName As String, planDesc As String) As Integer
    Public Function GetOrCreatePlan(httpContext As HttpContext, apiContext As APIContext, billingPlanId As Integer) As String
        Dim planId = LocalAPI.GetPayPalPlanId(billingPlanId)
        If String.IsNullOrEmpty(planId) Then
            Return InitSubscription(httpContext, apiContext)
        End If
        Return planId
    End Function
End Class
