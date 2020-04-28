Imports Microsoft.VisualBasic
Imports PayPal.Api
Public NotInheritable Class Common
    Private Sub New()
    End Sub
    ''' <summary>
    ''' Helper method for getting a currency amount.
    ''' </summary>
    ''' <param name="value">The value for the currency object.</param>
    ''' <returns></returns>
    Public Shared Function GetCurrency(value As String) As Currency
        Return New Currency() With {
            .value = value,
            .currency = "USD"
        }
    End Function
End Class
