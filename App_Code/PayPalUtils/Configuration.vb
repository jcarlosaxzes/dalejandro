Imports Microsoft.VisualBasic
Imports PayPal.Api

Public NotInheritable Class Configuration
    Private Sub New()
    End Sub
    Public Shared ClientId As String
    Public Shared ClientSecret As String

    ' Static constructor for setting the readonly static members.
    Shared Sub New()
        Dim config = GetConfig()
        ClientId = config("clientId")
        ClientSecret = config("clientSecret")
    End Sub

    ' Create the configuration map that contains mode and other optional configuration details.
    Public Shared Function GetConfig(Optional id As String = Nothing, Optional secret As String = Nothing) As Dictionary(Of String, String)
        Dim result = ConfigManager.Instance.GetProperties()
        result("clientId") = If(id, result("clientId"))
        result("clientSecret") = If(secret, result("clientSecret"))
        Return result
    End Function

    ' Create accessToken
    Private Shared Function GetAccessToken(Optional id As String = Nothing, Optional secret As String = Nothing) As String
        ' ###AccessToken
        ' Retrieve the access token from
        ' OAuthTokenCredential by passing in
        ' ClientID and ClientSecret
        ' It is not mandatory to generate Access Token on a per call basis.
        ' Typically the access token can be generated once and
        ' reused within the expiry window
        ClientId = If(id, ClientId)
        ClientSecret = If(secret, ClientSecret)
        Dim accessToken As String = New OAuthTokenCredential(ClientId, ClientSecret, GetConfig(id, secret)).GetAccessToken()
        Return accessToken
    End Function

    ' Returns APIContext object
    Public Shared Function GetAPIContext(Optional accessToken As String = "", Optional id As String = Nothing, Optional secret As String = Nothing) As APIContext
        ' ### Api Context
        ' Pass in a `APIContext` object to authenticate 
        ' the call and to send a unique request id 
        ' (that ensures idempotency). The SDK generates
        ' a request id if you do not pass one explicitly. 
        Dim apiContext = New APIContext(If(String.IsNullOrEmpty(accessToken), GetAccessToken(id, secret), accessToken))
        apiContext.Config = GetConfig(id, secret)

        ' Use this variant if you want to pass in a request id  
        ' that is meaningful in your application, ideally 
        ' a order id.
        ' String requestId = Long.toString(System.nanoTime();
        ' APIContext apiContext = new APIContext(GetAccessToken(), requestId ));

        Return apiContext
    End Function
End Class
