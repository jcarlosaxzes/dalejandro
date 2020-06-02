Imports PayPal.Api

Public Class invoice
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit
        'If LocalAPI.IsTabletOrSmarthphone(Request.UserAgent) Then
        '    Response.RedirectPermanent("~/e2103445_8a47_49ff_808e_6008c0fe13a1/Invoice_phone.aspx?GuiId=" & Request.QueryString("GuiId"))
        'End If
    End Sub
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Not Request.QueryString("GuiId") Is Nothing Then
                Dim guiId As String = Request.QueryString("GuiId")
                'guiId  ="75ffa08b-e28f-488f-a863-e5d6d41c94ee"
                lblInvoice.Text = LocalAPI.GetSharedLink_Id(4, guiId)
                Dim companyId = LocalAPI.GetCompanyIdFromInvoice(lblInvoice.Text)
                lblCompanyId.Text = companyId
                Master.Company = companyId
                lblInvoiceGuid.Text = guiId

                Title = LocalAPI.GetInvoiceProperty(lblInvoice.Text, "InvoiceNumber")

                ' Para navegar en CLIENT PORTAL.....................................
                Dim JobId As Integer = LocalAPI.GetInvoiceProperty(lblInvoice.Text, "JobId")
                Session("CLIENTPORTAL_clientId") = LocalAPI.GetJobProperty(JobId, "Client")

                ' PayPal....................................................................................
                If LocalAPI.IsPayPalModule(companyId) Then
                    ' Get All invoice Data
                    Dim invoiceInfo = LocalAPI.GetInvoiceInfo(lblInvoice.Text)


                    Dim amountDue As Double = invoiceInfo("AmountDue")
                    Dim PayHereMax As Double = LocalAPI.GetCompanyProperty(companyId, "PayHereMax")

                    ' PayHereMax condition....................................................................................
                    If (PayHereMax = 0) Or (PayHereMax > 0 And amountDue < PayHereMax) Then

                        ' Get PayPalClientId
                        Dim clientId = LocalAPI.GetCompanyProperty(companyId, "PayPalClientId")
                        ' Get PayPalClientSecret
                        Dim clientSecret = LocalAPI.GetCompanyProperty(companyId, "PayPalClientSecret")

                        ' PayPal Tokens condition....................................................................................
                        If amountDue > 0 AndAlso Not String.IsNullOrEmpty(clientId) AndAlso Not String.IsNullOrEmpty(clientSecret) Then
                            pnlSideTools.Visible = True
                            ' ### Api Context
                            ' Pass in a `APIContext` object to authenticate 
                            ' the call and to send a unique request id 
                            ' (that ensures idempotency). The SDK generates
                            ' a request id if you do not pass one explicitly. 
                            Dim apiContext = Configuration.GetAPIContext("", clientId, clientSecret)
                            Dim payerId As String = Request.Params("PayerID")
                            If String.IsNullOrEmpty(payerId) Then
                                Dim g = Guid.NewGuid().ToString()
                                Dim createdPayment = CreatePayment(apiContext, invoiceInfo, g)
                                Dim payLink = createdPayment.GetApprovalUrl()
                                btnPay.Attributes.Add("href", payLink)
                                Session.Add(g, createdPayment.id)
                            Else
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
                                MessagePayHere(amountDue)

                                SqlDataSourceInvoice.Insert()

                            End If
                        End If

                    End If
                End If

                ' pnlPayments Visible
                pnlPayments.Visible = (LocalAPI.GetPaymentsForInvoice(lblInvoice.Text) > 0)

            End If
        End If
    End Sub

    ''' <summary>
    ''' Common Function to create a PayPal Payment
    ''' </summary>
    ''' <param name="apiContext">Current API Context based on Company's credentials</param>
    ''' <param name="invoiceInfo">Dictionary of all Invoice information</param>
    ''' <param name="g">A random generated string for generate return_urls</param>
    ''' <param name="payer">A nullable payer object, in case of null will be a PayPal payer</param>
    ''' <returns></returns>
    Private Function CreatePayment(apiContext As APIContext, invoiceInfo As Dictionary(Of String, Object), g As String, Optional payer As Payer = Nothing) As Payment
        Dim amountDueD As Double
        Double.TryParse(invoiceInfo("AmountDue"), amountDueD)
        Dim amountDue = FormatNumber(amountDueD, 2)
        Dim projectName = invoiceInfo("ProjectName")
        Dim invoiceNumber = invoiceInfo("InvoiceNumber")
        Dim invoiceNotes = invoiceNumber & ": " & invoiceInfo("Notes")

        ' ###Items
        ' Items within a transaction.
        Dim itemList = New ItemList() With {
                    .items = New List(Of Item)() From {
                        New Item() With {
                            .name = projectName,
                            .currency = "USD",
                            .price = amountDue,
                            .quantity = "1",
                            .sku = lblInvoiceGuid.Text
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

        Dim redirectUrl = baseURI + "&payment_guid=" + g
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
            .invoice_number = lblInvoiceGuid.Text,
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

    Protected Sub btnAgreeCreditCard_Click(sender As Object, e As EventArgs)
        Try
            pnlError.Visible = False
            ' Get All invoice Data
            Dim invoiceInfo = LocalAPI.GetInvoiceInfo(lblInvoice.Text)
            ' Get PayPalClientId
            Dim clientId = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "PayPalClientId")
            ' Get PayPalClientSecret
            Dim clientSecret = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "PayPalClientSecret")
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
            Dim createdPayment = CreatePayment(apiContext, invoiceInfo, g, payer)
            If createdPayment.state = "approved" Then

                ScriptManager.RegisterClientScriptBlock(Me, Me.[GetType](), "none", "<script>$('#modal-card').modal('hide');</script>", False)
                MessagePayHere(invoiceInfo("AmountDue"))
                SqlDataSourceInvoice.Insert()
            End If
        Catch ex As Exception
            pnlError.Visible = True
            ltrlError.Text = ex.Message
            ScriptManager.RegisterClientScriptBlock(Me, Me.[GetType](), "none", "<script>$('#modal-card').modal('hide');</script>", False)
        End Try
    End Sub

    Private Sub SqlDataSourceInvoice_Inserting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSourceInvoice.Inserting
        Try
            Dim invoiceInfo = LocalAPI.GetInvoiceInfo(lblInvoice.Text)
            e.Command.Parameters(2).Value = LocalAPI.GetDateTime()      'CollectedDate
            e.Command.Parameters(3).Value = 12                          '12: Method PayPal
            e.Command.Parameters(4).Value = invoiceInfo("AmountDue")    'Amount
            e.Command.Parameters(5).Value = invoiceInfo("Notes")        'CollectedNotes
        Catch ex As Exception
        End Try
    End Sub

    Private Sub SqlDataSourceInvoice_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceInvoice.Inserted
        pnlSideTools.Visible = False
        pnlSuccess.Visible = True

        ThanksPage()
    End Sub

    Private Sub ThanksPage()
        Dim url As String
        ' Corporative Thanks Page
        url = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "ThankPage_PaidInvoice_url")
        If Len(url) > 0 Then
            Response.Redirect(url)
        End If

    End Sub

    Private Function MessagePayHere(amountDue As Double) As Boolean
        Try

            Dim AccountantEmail As String = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "AccountantEmail")
            If Len(AccountantEmail) > 0 Then
                Dim invoiceInfo = LocalAPI.GetInvoiceInfo(lblInvoice.Text)
                Dim sMsg As New System.Text.StringBuilder

                sMsg.Append("This message is to notify a invoice payment using PayHere from PayPal")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("Job: " & invoiceInfo("ProjectName"))
                sMsg.Append("<br />")
                sMsg.Append("Invoice: " & invoiceInfo("InvoiceNumber"))
                sMsg.Append("<br />")
                sMsg.Append("Amount: " & FormatCurrency(amountDue))
                sMsg.Append("<br />")
                sMsg.Append("Notes: " & invoiceInfo("Notes"))
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("<br />")
                sMsg.Append("PASconcept Notifications")
                sMsg.Append("<br />")
                Dim sBody As String = sMsg.ToString
                Dim sSubject As String = "PayHere to " & LocalAPI.GetCompanyName(lblCompanyId.Text) & " from PayPal, Invoice: " & invoiceInfo("InvoiceNumber")

                SendGrid.Email.SendMail(AccountantEmail, "", "", sSubject, sBody, lblCompanyId.Text)
                SqlDataSourceInvoice.DataBind()

            End If

        Catch ex As Exception
            Master.ErrorMessage("Error. " & ex.Message)
        End Try

    End Function

End Class
