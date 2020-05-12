Imports Microsoft.AspNet.Identity
Imports PayPal.Api


Public Class pro
    Inherits System.Web.UI.Page

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

                ' Inserto Company_Payments si no existe. 
                ' Company_Payments_INSERT do:
                ' 1.- New Axzes Invoice 
                ' 2.- New Company Invoice
                ' 3.- Company Binded to Axzes. 
                SqlDataSourcePayment.Insert()

                ' Enabled=False para planes antiguos
                cboPlans.DataBind()
                'If Val("" & cboPlans.SelectedValue) < 100 Then cboPlans.Enabled = False
                cboPlans.Enabled = False

                ' Refreco FormView
                SqlDataSourcePayment.DataBind()

                ' PayPal....................................................................................
                Dim axzesCompanyId As Integer = 260973
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
                            Dim payerId As String = Request.Params("PayerID")
                            If String.IsNullOrEmpty(payerId) Then
                                Dim g = Guid.NewGuid().ToString()
                                Dim createdPayment = CreatePayment(apiContext, lblCompanyPaymentsPendingId.Text, g)
                                lblPayPalPaymentId.Text = createdPayment.id
                                Dim payLink = createdPayment.GetApprovalUrl()
                                btnPay.Attributes.Add("href", payLink)
                                Session.Add(g, createdPayment.id)
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

            SqlDataSourcePayment.Update()
            ' Company_Payments_UPDATE do:
            ' 1.- Confirm Company Payment
            ' 2.- New Axzes Payment
            ' 3.- Update Company billingExpirationDate
            '..............................................................................

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

            Dim AxzesInvoiceId As Integer = LocalAPI.GetCompanyPaymentsProperty(lblCompanyPaymentsPendingId.Text, "AxzesInvoiceId")
            If IsNothing(AxzesInvoiceId) Or Len(AxzesInvoiceId) = 0 Or AxzesInvoiceId = 0 Then
                LocalAPI.BindCompanyToAxzesInvoice(AxzesJobId, lblCompanyPaymentsPendingId.Text, 0)
                AxzesInvoiceId = LocalAPI.GetCompanyPaymentsProperty(lblCompanyPaymentsPendingId.Text, "AxzesInvoiceId")
                'Else
                '    LocalAPI.BindCompanyToAxzesInvoice(AxzesJobId, lblCompanyPaymentsPendingId.Text, AxzesInvoiceId)
            End If

            Dim AxzesInvoiceNumber As String = LocalAPI.InvoiceNumber(AxzesInvoiceId)
            Dim sMsg As New System.Text.StringBuilder

            sMsg.Append("This message is to notify a invoice payment of PASconcept subscription using PayHere from PayPal")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("Company Name: " & LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Name"))
            sMsg.Append("<br />")

            sMsg.Append("Axzes Invoice Number: " & AxzesInvoiceNumber)
            sMsg.Append("<br />")

            sMsg.Append("Payment Number: " & LocalAPI.GetCompanyPaymentsProperty(lblCompanyPaymentsPendingId.Text, "PaymentNumber"))
            sMsg.Append("<br />")
            sMsg.Append("Amount: " & LocalAPI.GetCompanyPaymentsProperty(lblCompanyPaymentsPendingId.Text, "Amount"))
            sMsg.Append("<br />")
            sMsg.Append("Notes: " & LocalAPI.GetCompanyPaymentsProperty(lblCompanyPaymentsPendingId.Text, "Notes"))
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("<br />")
            sMsg.Append("PASconcept Notifications")
            sMsg.Append("<br />")
            Dim sBody As String = sMsg.ToString
            Dim sSubject As String = "PASconcept subscription, Payment Number: " & LocalAPI.GetCompanyPaymentsProperty(lblCompanyPaymentsPendingId.Text, "PaymentNumber")

            Dim AccountantEmail As String = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "AccountantEmail")
            If Len(AccountantEmail) > 0 Then
                LocalAPI.SendMail(AccountantEmail, "", "jcarlos@axzes.com,matt@axzes.com", sSubject, sBody, lblCompanyId.Text)
            Else
                LocalAPI.SendMail("jcarlos@axzes.com", "", "matt@axzes.com", sSubject, sBody, lblCompanyId.Text)
            End If

            Response.Redirect("~/ADM/subscribe/subscribesuccess.aspx")

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try

    End Function
End Class
