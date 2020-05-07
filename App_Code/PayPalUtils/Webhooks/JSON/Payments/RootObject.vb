Imports Microsoft.VisualBasic

Namespace PasConcept.PayPalUtils.Webhooks.JSON.Payments
    Public Class Details
    End Class

    Public Class Amount
        Public Property total() As String
            Get
                Return m_total
            End Get
            Set
                m_total = Value
            End Set
        End Property
        Private m_total As String
        Public Property currency() As String
            Get
                Return m_currency
            End Get
            Set
                m_currency = Value
            End Set
        End Property
        Private m_currency As String
        Public Property details() As Details
            Get
                Return m_details
            End Get
            Set
                m_details = Value
            End Set
        End Property
        Private m_details As Details
    End Class

    Public Class TransactionFee
        Public Property value() As String
            Get
                Return m_value
            End Get
            Set
                m_value = Value
            End Set
        End Property
        Private m_value As String
        Public Property currency() As String
            Get
                Return m_currency
            End Get
            Set
                m_currency = Value
            End Set
        End Property
        Private m_currency As String
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

    Public Class Resource
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
        Public Property amount() As Amount
            Get
                Return m_amount
            End Get
            Set
                m_amount = Value
            End Set
        End Property
        Private m_amount As Amount
        Public Property payment_mode() As String
            Get
                Return m_payment_mode
            End Get
            Set
                m_payment_mode = Value
            End Set
        End Property
        Private m_payment_mode As String
        Public Property protection_eligibility() As String
            Get
                Return m_protection_eligibility
            End Get
            Set
                m_protection_eligibility = Value
            End Set
        End Property
        Private m_protection_eligibility As String
        Public Property protection_eligibility_type() As String
            Get
                Return m_protection_eligibility_type
            End Get
            Set
                m_protection_eligibility_type = Value
            End Set
        End Property
        Private m_protection_eligibility_type As String
        Public Property transaction_fee() As TransactionFee
            Get
                Return m_transaction_fee
            End Get
            Set
                m_transaction_fee = Value
            End Set
        End Property
        Private m_transaction_fee As TransactionFee
        Public Property billing_agreement_id() As String
            Get
                Return m_billing_agreement_id
            End Get
            Set
                m_billing_agreement_id = Value
            End Set
        End Property
        Private m_billing_agreement_id As String
        Public Property create_time() As String
            Get
                Return m_create_time
            End Get
            Set
                m_create_time = Value
            End Set
        End Property
        Private m_create_time As String
        Public Property update_time() As String
            Get
                Return m_update_time
            End Get
            Set
                m_update_time = Value
            End Set
        End Property
        Private m_update_time As String
        Public Property links() As List(Of Link)
            Get
                Return m_links
            End Get
            Set
                m_links = Value
            End Set
        End Property
        Private m_links As List(Of Link)
        Public Property soft_descriptor() As String
            Get
                Return m_soft_descriptor
            End Get
            Set
                m_soft_descriptor = Value
            End Set
        End Property
        Private m_soft_descriptor As String
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




