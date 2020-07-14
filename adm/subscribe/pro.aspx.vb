Imports Microsoft.AspNet.Identity
Imports PayPal.Api


Public Class pro
    Inherits System.Web.UI.Page

    Private axzesCompanyId As Integer = 260973

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try


            If Not IsPostBack Then
                ' Usuario activo...
                lblEmployeeEmail.Text = Context.User.Identity.GetUserName()

                ' Active company....
                lblCompanyId.Text = If(Session("companyId"), -1)
                cboCompany.DataBind()
                If lblCompanyId.Text = -1 Then
                    lblCompanyId.Text = cboCompany.SelectedValue
                    Session("companyId") = lblCompanyId.Text
                End If

                cboCompany.SelectedValue = lblCompanyId.Text
                lblEmployeeId.Text = LocalAPI.GetEmployeeId(lblEmployeeEmail.Text, lblCompanyId.Text)


                Select Case lblEmployeeEmail.Text
                    Case "jcarlos@axzes.com", "fernando@easterneg.com", "sandra@easterneg.com", "matt@axzes.com"
                        btnAdminPay.Visible = True
                End Select


                lblbillingExpirationDate.Text = LocalAPI.GetCompanybillingExpirationDate(lblCompanyId.Text)

                cboPlans.DataBind()

                ' Inserto Company_Payments si no existe. 
                ' Company_Payments_INSERT do:
                ' 1.- New Axzes Invoice 
                ' 2.- New Company Invoice
                ' 3.- Company Binded to Axzes. 
                Dim payerId As String = Request.Params("PayerID")
                If String.IsNullOrEmpty(payerId) Then
                    SqlDataSourcePayment.Insert()

                    Dim planId = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Billing_plan").ToString()
                    cboPlans.SelectedValue = planId
                    cboPlans.Enabled = True
                End If


                ' Refreco FormView
                SqlDataSourcePayment.DataBind()

                ' PayPal....................................................................................

                If LocalAPI.IsPayPalModule(axzesCompanyId) Then
                    If LocalAPI.GetCompanybillingExpirationDate(lblCompanyId.Text) <= Date.Today Then

                        lblCompanyPaymentsPendingId.Text = LocalAPI.GetCompanyPaymentsPendingId(lblCompanyId.Text)

                        pnlSideTools.Visible = True

                        If LocalAPI.GetCompanyPaymentsProperty(lblCompanyPaymentsPendingId.Text, "Amount") > 0 Then
                            ' If versio <> Free, go ahead...CreatePayment

                            ' Get All payment Data
                            ' Get PayPalClientId
                            Dim clientId = LocalAPI.GetCompanyProperty(axzesCompanyId, "PayPalClientId")
                            ' Get PayPalClientSecret
                            Dim clientSecret = LocalAPI.GetCompanyProperty(axzesCompanyId, "PayPalClientSecret")
                            ' ### Api Context
                            ' Pass in a `APIContext` object to authenticate 
                            ' the call and to send a unique request id 
                            ' (that ensures idempotency). The SDK generates
                            ' a request id if you do not pass one explicitly. 
                            Dim apiContext = Configuration.GetAPIContext("", clientId, clientSecret)

                            If String.IsNullOrEmpty(payerId) Then
                                CreatePaymentPaypalLink()
                                'lblPayPalPaymentId.Text = g
                                'Dim payLink = "https://localhost:44308/ADM/subscribe/pro.aspx?payment_guid=" & g & "&paymentId=PAY-1FS744526K867052KLDRGZHI" & "&token=EC-5YB58532HX951702N" & "&PayerID=RLBGQWGB5R24Q"

                                'Session.Add(g, "123456")
                            Else
                                ' Return sample
                                ' http://localhost:30284/ADM/subscribe/pro.aspx
                                ' ?payment_guid=15d23998-ca94-4358-a7af-36c4ac16f299
                                ' &paymentId=PAY-1FS744526K867052KLDRGZHI
                                ' &token=EC-5YB58532HX951702N
                                ' &PayerID=RLBGQWGB5R24Q
                                Dim guid = Request.Params("payment_guid")

                                ' Using the information from the redirect, setup the payment to execute.
                                Dim paymentId = TryCast(Session(guid), String)
                                Dim paymentExecution = New PaymentExecution() With {
                                    .payer_id = payerId
                                }
                                Dim payment = New Payment() With {
                                    .id = paymentId
                                }

                                ' Execute the payment.
                                Dim executedPayment = payment.Execute(apiContext, paymentExecution)

                                ' TODO: MAKE PASCONCEPT PAYMENT HERE !!!!!!!!!!!!!
                                UpdatePayment_and_MessagePayHere(paymentId, 12)

                            End If

                        End If
                    End If
                End If

                pnlReturn.Visible = Not pnlSideTools.Visible
            End If

        Catch ex As Exception
            lblError.Visible = True
            lblError.Text = ex.Message '& ex.InnerException.Message & ex.HResult
        End Try

    End Sub

    Protected Sub cboCompany_SelectedIndexChanged(ByVal sender As Object, ByVal e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs) Handles cboCompany.SelectedIndexChanged
        Session("companyId") = cboCompany.SelectedValue
        Session("companyId") = cboCompany.SelectedValue

        LocalAPI.SetLastCompanyId(lblEmployeeId.Text, cboCompany.SelectedValue)
        Session("Version") = LocalAPI.sys_VersionId(Session("companyId"))
        Response.RedirectPermanent("~/ADM/Start.aspx")
    End Sub

    Protected Sub cboPlans_SelectedIndexChanged(ByVal sender As Object, ByVal e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs) Handles cboPlans.SelectedIndexChanged
        Dim plan = cboPlans.SelectedValue
        LocalAPI.SetCompanyPaymentsPlan(plan, lblCompanyId.Text)
        CreatePaymentPaypalLink()
        ' Refreco FormView
        RadGridPayments.Rebind()
    End Sub

    Protected Sub CreatePaymentPaypalLink()
        Try
            ' Get PayPalClientId
            Dim clientId = LocalAPI.GetCompanyProperty(axzesCompanyId, "PayPalClientId")
            ' Get PayPalClientSecret
            Dim clientSecret = LocalAPI.GetCompanyProperty(axzesCompanyId, "PayPalClientSecret")
            ' ### Api Context
            ' Pass in a `APIContext` object to authenticate 
            ' the call and to send a unique request id 
            ' (that ensures idempotency). The SDK generates
            ' a request id if you do not pass one explicitly. 
            Dim apiContext = Configuration.GetAPIContext("", clientId, clientSecret)

            Dim g = Guid.NewGuid().ToString()
            Dim createdPayment = CreatePayment(apiContext, lblCompanyPaymentsPendingId.Text, g)
            lblPayPalPaymentId.Text = createdPayment.id
            Dim payLink = createdPayment.GetApprovalUrl()
            'lblPayPalPaymentId.Text = g
            'Dim payLink = "https://localhost:44308/ADM/subscribe/pro.aspx?payment_guid=" & g & "&paymentId=PAY-1FS744526K867052KLDRGZHI" & "&token=EC-5YB58532HX951702N" & "&PayerID=RLBGQWGB5R24Q"
            btnPay.Attributes.Add("href", payLink)
            Session.Add(g, createdPayment.id)
        Catch ex As Exception
            lblError.Visible = True
            lblError.Text = ex.Message '& ex.InnerException.Message & ex.HResult
        End Try
    End Sub

    Protected Sub btnAgreeCreditCard_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAgreeCreditCard.Click
        Try
            ' Get PayPalClientId
            Dim axzesCompanyId As Integer = 260973
            Dim clientId = LocalAPI.GetCompanyProperty(axzesCompanyId, "PayPalClientId")
            ' Get PayPalClientSecret
            Dim clientSecret = LocalAPI.GetCompanyProperty(axzesCompanyId, "PayPalClientSecret")
            Dim apiContext = Configuration.GetAPIContext("", clientId, clientSecret)
            Dim payer = New Payer() With {
            .payment_method = "credit_card",
            .funding_instruments = New List(Of FundingInstrument)() From {
                New FundingInstrument() With {
                    .credit_card = New CreditCard() With {
                        .billing_address = New Address() With {
                            .city = txtCity.Text,
                            .country_code = "US",
                            .line1 = txtAddress.Text,
                            .postal_code = txtZip.Text,
                            .state = txtState.Text
                        },
                        .cvv2 = txtCVV.Text,
                        .expire_month = Integer.Parse(txtExpireMonth.Text),
                        .expire_year = Integer.Parse(txtExpireYear.Text),
                        .first_name = txtFirstName.Text,
                        .last_name = txtLastName.Text,
                        .number = txtCardNumber.Text,
                        .type = hdnCardType.Value
                    }
                }
            },
            .payer_info = New PayerInfo() With {
                .email = txtEmail.Text
            }
        }

            Dim g = Guid.NewGuid().ToString()
            Dim createdPayment = CreatePayment(apiContext, lblCompanyPaymentsPendingId.Text, g, payer)
            If createdPayment.state = "approved" Then

                ScriptManager.RegisterClientScriptBlock(Me, Me.[GetType](), "none", "<script>$('#modal-card').modal('hide');</script>", False)

                UpdatePayment_and_MessagePayHere(createdPayment.id, 12)

            End If
        Catch ex As Exception

            lblError.Text = ex.Message
            ScriptManager.RegisterClientScriptBlock(Me, Me.[GetType](), "none", "<script>$('#modal-card').modal('hide');</script>", False)
        End Try
    End Sub


    Protected Sub btnAdminPay_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdminPay.Click
        UpdatePayment_and_MessagePayHere(Context.User.Identity.GetUserName(), 8)
    End Sub

    Private Sub SqlDataSourcePayment_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourcePayment.Updating
        Dim e1 As String = e.Command.Parameters(3).Value
    End Sub

    Private Function CreatePayment(apiContext As APIContext, CompanyPaymentsPendingId As Integer, g As String, Optional payer As Payer = Nothing) As Payment

        Dim paymentGUID As String = LocalAPI.GetCompanyPaymentsProperty(CompanyPaymentsPendingId, "guid")
        Dim amountDue = FormatNumber(LocalAPI.GetCompanyPaymentsProperty(CompanyPaymentsPendingId, "Amount"), 2)
        Dim projectName = "PASconcept Subscription"
        Dim invoiceNumber = LocalAPI.GetCompanyPaymentsProperty(CompanyPaymentsPendingId, "PaymentNumber")
        Dim invoiceNotes = invoiceNumber & ": " & LocalAPI.GetCompanyPaymentsProperty(CompanyPaymentsPendingId, "Notes")


        ' ###Items
        ' Items within a transaction.
        Dim itemList = New ItemList() With {
                    .items = New List(Of Item)() From {
                        New Item() With {
                            .name = projectName,
                            .currency = "USD",
                            .price = amountDue,
                            .quantity = "1",
                            .sku = paymentGUID
                        }
                    }
                }

        ' ###Payer
        ' A resource representing a Payer that funds a payment
        ' Payment Method
        ' as `paypal`
        If payer Is Nothing Then
            payer = New Payer() With {
                .payment_method = "paypal"
            }
        End If

        ' ###Redirect URLS
        ' These URLs will determine how the user is redirected from PayPal once they have either approved or canceled the payment.
        Dim baseURI = HttpContext.Current.Request.Url.ToString()
        'var baseURI = Request.Url.Scheme + "://" + Request.Url.Authority + "/PaymentWithPayPal.aspx?";

        Dim redirectUrl = baseURI + "?payment_guid=" + g
        Dim redirUrls = New RedirectUrls() With {
            .cancel_url = redirectUrl + "&cancel=true",
            .return_url = redirectUrl
        }

        ' ###Details
        ' Let's you specify details of a payment amount.
        'tax = "15",
        'shipping = "10",
        Dim details = New Details() With {
            .subtotal = amountDue
        }

        ' ###Amount
        ' Let's you specify a payment amount.
        ' Total must be equal to sum of shipping, tax and subtotal.
        Dim amount = New Amount() With {
            .currency = "USD",
            .total = amountDue,
            .details = details
        }

        ' ###Transaction
        ' A transaction defines the contract of a
        ' payment - what is the payment for and who
        ' is fulfilling it. 
        Dim transactionList = New List(Of Transaction)()

        ' The Payment creation API requires a list of
        ' Transaction; add the created `Transaction`
        ' to a List
        transactionList.Add(New Transaction() With {
            .description = invoiceNotes,
            .invoice_number = paymentGUID,
            .amount = amount,
            .item_list = itemList
        })

        ' ###Payment
        ' A Payment Resource; create one using
        ' the above types and intent as `sale` or `authorize`
        Dim payment = New Payment() With {
            .intent = "sale",
            .payer = payer,
            .transactions = transactionList,
            .redirect_urls = redirUrls
        }


        ' Create a payment using a valid APIContext
        Dim createdPayment = payment.Create(apiContext)
        Return createdPayment
    End Function

    Private Function UpdatePayment_and_MessagePayHere(PayPalID As String, PaymentMethodId As Integer) As Boolean
        Try

            ' Completar Pago y Update Company billingExpirationDate........................
            lblPayPalPaymentId.Text = PayPalID
            lblPaymentMethodId.Text = PaymentMethodId


            'Get or Create AxzesClientId
            Dim AxzesClientId As String = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "AxzesClientId")
            If IsNothing(AxzesClientId) Or Len(AxzesClientId) = 0 Or AxzesClientId = 0 Then
                Dim clientId As Integer = LocalAPI.BindCompanyToAxzesClient(lblCompanyId.Text, 0)
                AxzesClientId = clientId.ToString()
            End If

            'Get or Create AxzesJob
            Dim AxzesJobId As String = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "AxzesJobId")
            If IsNothing(AxzesJobId) Or Len(AxzesJobId) = 0 Or AxzesJobId = 0 Then
                LocalAPI.BindCompanyToAxzesJob(lblCompanyId.Text, AxzesClientId, 0)
                AxzesJobId = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "AxzesJobId")
            End If

            SqlDataSourcePayment.Update()
            ' Company_Payments_UPDATE do:
            ' 1.- Confirm Company Payment
            ' 2.- New Axzes Payment
            ' 3.- Update Company billingExpirationDate
            '..............................................................................

            Dim AxzesInvoiceId As Integer = LocalAPI.GetCompanyPaymentsProperty(lblCompanyPaymentsPendingId.Text, "AxzesInvoiceId")

            Dim AxzesInvoiceNumber As String = LocalAPI.InvoiceNumber(AxzesInvoiceId)

            Dim DictValues As Dictionary(Of String, String) = New Dictionary(Of String, String)
            DictValues.Add("[AxzesInvoiceNumber]", AxzesInvoiceNumber)
            DictValues.Add("[PaymentNumber]", LocalAPI.GetCompanyPaymentsProperty(lblCompanyPaymentsPendingId.Text, "PaymentNumber"))
            DictValues.Add("[Amount]", LocalAPI.GetCompanyPaymentsProperty(lblCompanyPaymentsPendingId.Text, "Amount"))
            DictValues.Add("[Notes]", LocalAPI.GetCompanyPaymentsProperty(lblCompanyPaymentsPendingId.Text, "Notes"))
            DictValues.Add("[CompanyName]", LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Name"))
            DictValues.Add("[PASSign]", LocalAPI.GetPASSign())

            Dim sSubject As String = LocalAPI.GetMessageTemplateSubject("Company_Subscription_Payment", lblCompanyId.Text, DictValues)
            Dim sBody As String = LocalAPI.GetMessageTemplateBody("Company_Subscription_Payment", lblCompanyId.Text, DictValues)

            Dim AccountantEmail As String = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "AccountantEmail")
            If Len(AccountantEmail) > 0 Then
                SendGrid.Email.SendMail(AccountantEmail, "", "jcarlos@axzes.com,matt@axzes.com", sSubject, sBody, lblCompanyId.Text)
            Else
                SendGrid.Email.SendMail("jcarlos@axzes.com", "", "matt@axzes.com", sSubject, sBody, lblCompanyId.Text)
            End If

            Response.Redirect("~/ADM/subscribe/subscribesuccess.aspx")

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try

    End Function
End Class
