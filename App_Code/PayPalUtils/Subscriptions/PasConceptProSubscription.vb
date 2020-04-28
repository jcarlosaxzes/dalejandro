Imports Microsoft.VisualBasic
Imports PayPal.Api

Public Class PasConceptProSubscription
    Inherits PasConceptSubscription
    Public Shadows PlanName As String = "PasConcept Pro Subscription Plan"
    Public Shadows PlanDescription As String = "Monthly plan"
    Public Shadows PlanType As String = "INFINITE"
    ' More information: https://developer.paypal.com/docs/api/payments.billing-plans/#definition-payment_definition
    ' 49.99
    ' > NOTE: For `IFNINITE` type plans, `cycles` should be 0 for a `REGULAR` `PaymentDefinition` object.
    Public Shadows PaymentDefinitions As New List(Of PaymentDefinition)() From {
        New PaymentDefinition() With {
            .name = "Regular Payments",
            .type = "REGULAR",
            .frequency = "MONTH",
            .frequency_interval = "1",
            .amount = Common.GetCurrency("89.99"),
            .cycles = "0"
        }
    }
    ''' <summary>
    ''' Creates the PayPal Plan for Pro Subscription
    ''' </summary>
    ''' <param name="httpContext"></param>
    ''' <param name="apiContext"></param>
    ''' <returns></returns>
    Public Overrides Function CreatePlanObject(httpContext As HttpContext, apiContext As APIContext) As Plan
        ' Define the plan and attach the payment definitions and merchant preferences.
        ' More Information: https://developer.paypal.com/webapps/developer/docs/api/#create-a-plan
        ' Define the merchant preferences.
        ' More Information: https://developer.paypal.com/webapps/developer/docs/api/#merchantpreferences-object
        'setup_fee = Common.GetCurrency("1500"), // Initial Payment
        Dim plan = New Plan() With {
            .name = PlanName,
            .description = PlanDescription,
            .type = PlanType,
            .merchant_preferences = New MerchantPreferences() With {
                .return_url = httpContext.Request.Url.ToString(),
                .cancel_url = httpContext.Request.Url.ToString() + "?cancel",
                .auto_bill_amount = "YES",
                .initial_fail_amount_action = "CONTINUE",
                .max_fail_attempts = "0"
            },
            .payment_definitions = PaymentDefinitions
        }
        Me.Plan = plan.Create(apiContext)
        Return Plan
    End Function

    ''' <summary>
    ''' Updates pro plan
    ''' </summary>
    ''' <param name="httpContext"></param>
    ''' <param name="apiContext"></param>
    ''' <param name="newPlan"></param>
    ''' <returns></returns>
    Public Function UpdatePlanObject(httpContext As HttpContext, apiContext As APIContext, newPlan As Plan) As Plan
        Dim currentPlan = Plan
        Dim patchRequest = New PatchRequest() From {
            New Patch() With {
                .op = "replace",
                .path = "/",
                .value = newPlan
            }
        }
        currentPlan.Update(apiContext, patchRequest)
        Return currentPlan
    End Function

    ''' <summary>
    ''' Activates a pro plan
    ''' </summary>
    ''' <param name="httpContext"></param>
    ''' <param name="apiContext"></param>
    ''' <returns></returns>
    Public Function ActivatePlanObject(httpContext As HttpContext, apiContext As APIContext) As Plan
        Return UpdatePlanObject(httpContext, apiContext, New Plan() With {
            .state = "ACTIVE"
        })
    End Function

    Public Overrides Function CreateBillingAgreement(httpContext As HttpContext, apiContext As APIContext, planId As String, Optional paymentMethod As String = "paypal") As Agreement

        Dim payer = New Payer() With {
            .payment_method = paymentMethod
        }
        Dim agreement = New Agreement() With {
            .name = "PasConcept Pro Subsription Agreement",
            .description = "Agreement PasConcept Pro Subscription Plan",
            .start_date = DateTime.UtcNow.AddDays(30).ToString("s") + "Z",
            .payer = payer,
            .plan = New Plan() With {
                .id = planId
            }
        }
        Return agreement.Create(apiContext)
    End Function

    Public Overloads Function CreateBillingAgreement(httpContext As HttpContext, apiContext As APIContext, planId As String, payer As Payer) As Agreement
        Dim agreement = New Agreement() With {
            .name = "PasConcept Pro Subsription Agreement",
            .description = "Agreement PasConcept Pro Subscription Plan",
            .start_date = DateTime.UtcNow.AddDays(30).ToString("s") + "Z",
            .payer = payer,
            .plan = New Plan() With {
                .id = planId
            }
        }
        Return agreement.Create(apiContext)
    End Function

    Public Overrides Function AddPlanToDB(planId As String, planName As String, planDesc As String) As Integer
        Return LocalAPI.AddPayPalPlan(planId, planName, planDesc, 0)
    End Function

    Public Overrides Function InitSubscription(httpContext As HttpContext, apiContext As APIContext) As String
        ' Deletes all plans
        DeleteAllPlans(apiContext)
        ' Create the plan
        Dim plan = CreatePlanObject(httpContext, apiContext)
        ' Activate it
        Dim activatedPlan = ActivatePlanObject(httpContext, apiContext)
        ' Add plan to DB
        AddPlanToDB(activatedPlan.id, activatedPlan.name, activatedPlan.description)
        Return activatedPlan.id
    End Function

    Private Sub DeleteAllPlans(apiContext As APIContext)
        Dim page = 1
        While True
            Dim plans = Plan.List(apiContext, page.ToString())
            If plans Is Nothing Then
                Exit While
            End If
            For Each p As Plan In plans.plans
                p.Delete(apiContext)
            Next
            page += 1
        End While
    End Sub
End Class
