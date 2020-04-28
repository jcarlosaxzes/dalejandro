Imports Microsoft.VisualBasic

Namespace PasConcept.PayPalUtils.Webhooks.JSON.Agreements
    Public Class OutstandingBalance
        Public Property currency() As String
            Get
                Return m_currency
            End Get
            Set
                m_currency = Value
            End Set
        End Property
        Private m_currency As String
        Public Property value() As String
            Get
                Return m_value
            End Get
            Set
                m_value = Value
            End Set
        End Property
        Private m_value As String
    End Class

    Public Class LastPaymentAmount
        Public Property currency() As String
            Get
                Return m_currency
            End Get
            Set
                m_currency = Value
            End Set
        End Property
        Private m_currency As String
        Public Property value() As String
            Get
                Return m_value
            End Get
            Set
                m_value = Value
            End Set
        End Property
        Private m_value As String
    End Class

    Public Class AgreementDetails
        Public Property outstanding_balance() As OutstandingBalance
            Get
                Return m_outstanding_balance
            End Get
            Set
                m_outstanding_balance = Value
            End Set
        End Property
        Private m_outstanding_balance As OutstandingBalance
        Public Property cycles_remaining() As String
            Get
                Return m_cycles_remaining
            End Get
            Set
                m_cycles_remaining = Value
            End Set
        End Property
        Private m_cycles_remaining As String
        Public Property cycles_completed() As String
            Get
                Return m_cycles_completed
            End Get
            Set
                m_cycles_completed = Value
            End Set
        End Property
        Private m_cycles_completed As String
        Public Property next_billing_date() As String
            Get
                Return m_next_billing_date
            End Get
            Set
                m_next_billing_date = Value
            End Set
        End Property
        Private m_next_billing_date As String
        Public Property last_payment_date() As String
            Get
                Return m_last_payment_date
            End Get
            Set
                m_last_payment_date = Value
            End Set
        End Property
        Private m_last_payment_date As String
        Public Property last_payment_amount() As LastPaymentAmount
            Get
                Return m_last_payment_amount
            End Get
            Set
                m_last_payment_amount = Value
            End Set
        End Property
        Private m_last_payment_amount As LastPaymentAmount
        Public Property final_payment_date() As String
            Get
                Return m_final_payment_date
            End Get
            Set
                m_final_payment_date = Value
            End Set
        End Property
        Private m_final_payment_date As String
        Public Property failed_payment_count() As String
            Get
                Return m_failed_payment_count
            End Get
            Set
                m_failed_payment_count = Value
            End Set
        End Property
        Private m_failed_payment_count As String
    End Class

    Public Class Link
        Public Property href() As String
            Get
                Return m_href
            End Get
            Set
                m_href = Value
            End Set
        End Property
        Private m_href As String
        Public Property rel() As String
            Get
                Return m_rel
            End Get
            Set
                m_rel = Value
            End Set
        End Property
        Private m_rel As String
        Public Property method() As String
            Get
                Return m_method
            End Get
            Set
                m_method = Value
            End Set
        End Property
        Private m_method As String
    End Class

    Public Class ShippingAddress
        Public Property recipient_name() As String
            Get
                Return m_recipient_name
            End Get
            Set
                m_recipient_name = Value
            End Set
        End Property
        Private m_recipient_name As String
        Public Property line1() As String
            Get
                Return m_line1
            End Get
            Set
                m_line1 = Value
            End Set
        End Property
        Private m_line1 As String
        Public Property city() As String
            Get
                Return m_city
            End Get
            Set
                m_city = Value
            End Set
        End Property
        Private m_city As String
        Public Property state() As String
            Get
                Return m_state
            End Get
            Set
                m_state = Value
            End Set
        End Property
        Private m_state As String
        Public Property postal_code() As String
            Get
                Return m_postal_code
            End Get
            Set
                m_postal_code = Value
            End Set
        End Property
        Private m_postal_code As String
        Public Property country_code() As String
            Get
                Return m_country_code
            End Get
            Set
                m_country_code = Value
            End Set
        End Property
        Private m_country_code As String
    End Class

    Public Class PayerInfo
        Public Property email() As String
            Get
                Return m_email
            End Get
            Set
                m_email = Value
            End Set
        End Property
        Private m_email As String
        Public Property first_name() As String
            Get
                Return m_first_name
            End Get
            Set
                m_first_name = Value
            End Set
        End Property
        Private m_first_name As String
        Public Property last_name() As String
            Get
                Return m_last_name
            End Get
            Set
                m_last_name = Value
            End Set
        End Property
        Private m_last_name As String
        Public Property payer_id() As String
            Get
                Return m_payer_id
            End Get
            Set
                m_payer_id = Value
            End Set
        End Property
        Private m_payer_id As String
    End Class

    Public Class Payer
        Public Property payment_method() As String
            Get
                Return m_payment_method
            End Get
            Set
                m_payment_method = Value
            End Set
        End Property
        Private m_payment_method As String
        Public Property payer_info() As PayerInfo
            Get
                Return m_payer_info
            End Get
            Set
                m_payer_info = Value
            End Set
        End Property
        Private m_payer_info As PayerInfo
        Public Property status() As String
            Get
                Return m_status
            End Get
            Set
                m_status = Value
            End Set
        End Property
        Private m_status As String
    End Class

    Public Class Amount
        Public Property currency() As String
            Get
                Return m_currency
            End Get
            Set
                m_currency = Value
            End Set
        End Property
        Private m_currency As String
        Public Property value() As String
            Get
                Return m_value
            End Get
            Set
                m_value = Value
            End Set
        End Property
        Private m_value As String
    End Class

    Public Class Amount2
        Public Property currency() As String
            Get
                Return m_currency
            End Get
            Set
                m_currency = Value
            End Set
        End Property
        Private m_currency As String
        Public Property value() As String
            Get
                Return m_value
            End Get
            Set
                m_value = Value
            End Set
        End Property
        Private m_value As String
    End Class

    Public Class ChargeModel
        Public Property type() As String
            Get
                Return m_type
            End Get
            Set
                m_type = Value
            End Set
        End Property
        Private m_type As String
        Public Property amount() As Amount2
            Get
                Return m_amount
            End Get
            Set
                m_amount = Value
            End Set
        End Property
        Private m_amount As Amount2
    End Class

    Public Class PaymentDefinition
        Public Property type() As String
            Get
                Return m_type
            End Get
            Set
                m_type = Value
            End Set
        End Property
        Private m_type As String
        Public Property frequency() As String
            Get
                Return m_frequency
            End Get
            Set
                m_frequency = Value
            End Set
        End Property
        Private m_frequency As String
        Public Property frequency_interval() As String
            Get
                Return m_frequency_interval
            End Get
            Set
                m_frequency_interval = Value
            End Set
        End Property
        Private m_frequency_interval As String
        Public Property amount() As Amount
            Get
                Return m_amount
            End Get
            Set
                m_amount = Value
            End Set
        End Property
        Private m_amount As Amount
        Public Property cycles() As String
            Get
                Return m_cycles
            End Get
            Set
                m_cycles = Value
            End Set
        End Property
        Private m_cycles As String
        Public Property charge_models() As List(Of ChargeModel)
            Get
                Return m_charge_models
            End Get
            Set
                m_charge_models = Value
            End Set
        End Property
        Private m_charge_models As List(Of ChargeModel)
    End Class

    Public Class SetupFee
        Public Property currency() As String
            Get
                Return m_currency
            End Get
            Set
                m_currency = Value
            End Set
        End Property
        Private m_currency As String
        Public Property value() As String
            Get
                Return m_value
            End Get
            Set
                m_value = Value
            End Set
        End Property
        Private m_value As String
    End Class

    Public Class MerchantPreferences
        Public Property setup_fee() As SetupFee
            Get
                Return m_setup_fee
            End Get
            Set
                m_setup_fee = Value
            End Set
        End Property
        Private m_setup_fee As SetupFee
        Public Property auto_bill_amount() As String
            Get
                Return m_auto_bill_amount
            End Get
            Set
                m_auto_bill_amount = Value
            End Set
        End Property
        Private m_auto_bill_amount As String
        Public Property max_fail_attempts() As String
            Get
                Return m_max_fail_attempts
            End Get
            Set
                m_max_fail_attempts = Value
            End Set
        End Property
        Private m_max_fail_attempts As String
    End Class

    Public Class Plan
        Public Property currency_code() As String
            Get
                Return m_currency_code
            End Get
            Set
                m_currency_code = Value
            End Set
        End Property
        Private m_currency_code As String
        Public Property payment_definitions() As List(Of PaymentDefinition)
            Get
                Return m_payment_definitions
            End Get
            Set
                m_payment_definitions = Value
            End Set
        End Property
        Private m_payment_definitions As List(Of PaymentDefinition)
        Public Property merchant_preferences() As MerchantPreferences
            Get
                Return m_merchant_preferences
            End Get
            Set
                m_merchant_preferences = Value
            End Set
        End Property
        Private m_merchant_preferences As MerchantPreferences
    End Class

    Public Class Resource
        Public Property agreement_details() As AgreementDetails
            Get
                Return m_agreement_details
            End Get
            Set
                m_agreement_details = Value
            End Set
        End Property
        Private m_agreement_details As AgreementDetails
        Public Property description() As String
            Get
                Return m_description
            End Get
            Set
                m_description = Value
            End Set
        End Property
        Private m_description As String
        Public Property links() As List(Of Link)
            Get
                Return m_links
            End Get
            Set
                m_links = Value
            End Set
        End Property
        Private m_links As List(Of Link)
        Public Property id() As String
            Get
                Return m_id
            End Get
            Set
                m_id = Value
            End Set
        End Property
        Private m_id As String
        Public Property state() As String
            Get
                Return m_state
            End Get
            Set
                m_state = Value
            End Set
        End Property
        Private m_state As String
        Public Property shipping_address() As ShippingAddress
            Get
                Return m_shipping_address
            End Get
            Set
                m_shipping_address = Value
            End Set
        End Property
        Private m_shipping_address As ShippingAddress
        Public Property payer() As Payer
            Get
                Return m_payer
            End Get
            Set
                m_payer = Value
            End Set
        End Property
        Private m_payer As Payer
        Public Property plan() As Plan
            Get
                Return m_plan
            End Get
            Set
                m_plan = Value
            End Set
        End Property
        Private m_plan As Plan
        Public Property start_date() As String
            Get
                Return m_start_date
            End Get
            Set
                m_start_date = Value
            End Set
        End Property
        Private m_start_date As String
    End Class

    Public Class Link2
        Public Property href() As String
            Get
                Return m_href
            End Get
            Set
                m_href = Value
            End Set
        End Property
        Private m_href As String
        Public Property rel() As String
            Get
                Return m_rel
            End Get
            Set
                m_rel = Value
            End Set
        End Property
        Private m_rel As String
        Public Property method() As String
            Get
                Return m_method
            End Get
            Set
                m_method = Value
            End Set
        End Property
        Private m_method As String
    End Class

    Public Class RootObject
        Public Property id() As String
            Get
                Return m_id
            End Get
            Set
                m_id = Value
            End Set
        End Property
        Private m_id As String
        Public Property event_version() As String
            Get
                Return m_event_version
            End Get
            Set
                m_event_version = Value
            End Set
        End Property
        Private m_event_version As String
        Public Property create_time() As String
            Get
                Return m_create_time
            End Get
            Set
                m_create_time = Value
            End Set
        End Property
        Private m_create_time As String
        Public Property resource_type() As String
            Get
                Return m_resource_type
            End Get
            Set
                m_resource_type = Value
            End Set
        End Property
        Private m_resource_type As String
        Public Property event_type() As String
            Get
                Return m_event_type
            End Get
            Set
                m_event_type = Value
            End Set
        End Property
        Private m_event_type As String
        Public Property summary() As String
            Get
                Return m_summary
            End Get
            Set
                m_summary = Value
            End Set
        End Property
        Private m_summary As String
        Public Property resource() As Resource
            Get
                Return m_resource
            End Get
            Set
                m_resource = Value
            End Set
        End Property
        Private m_resource As Resource
        Public Property links() As List(Of Link2)
            Get
                Return m_links
            End Get
            Set
                m_links = Value
            End Set
        End Property
        Private m_links As List(Of Link2)
    End Class

End Namespace
