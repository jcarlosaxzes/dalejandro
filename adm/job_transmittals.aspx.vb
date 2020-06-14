Imports Telerik.Web.UI
Public Class job_transmittals
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblJobId.Text = Request.QueryString("JobId")


                lblEmployeeEmail.Text = Master.UserEmail
                Master.ActiveTab(11)
            End If

            RadWindowManager1.EnableViewState = False

        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblJobId.Text)
        End Try
    End Sub
    Protected Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
        SqlDataSourceTransmittals.Insert()
        RadGrid1.DataBind()
    End Sub
    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName

            Case "EditTransmittal"
                sUrl = "~/ADM/Transmittal.aspx?transmittalId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 970, 720, False)

            Case "EmailReadyToPickUp"
                Dim Id = e.CommandArgument
                Dim employeeId As Integer = LocalAPI.GetEmployeeId(lblEmployeeEmail.Text, lblCompanyId.Text)

                If LocalAPI.EmailReadyToPickUp(Id, lblCompanyId.Text, lblEmployeeEmail.Text, LocalAPI.GetEmployeeName(employeeId)) Then
                    LocalAPI.SetTransmittalJobToDoneStatus(Id)
                    Master.InfoMessage("The Transmittal have been sent by email")
                End If

        End Select
    End Sub
    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer, Maximize As Boolean)
        RadWindowManager1.Windows.Clear()
        Dim window1 As RadWindow = New RadWindow()
        window1.NavigateUrl = sUrl
        window1.VisibleOnPageLoad = True
        window1.VisibleStatusbar = False
        window1.ID = WindowsID
        If Maximize Then window1.InitialBehaviors = WindowBehaviors.Maximize
        window1.Behaviors = WindowBehaviors.Close Or WindowBehaviors.Resize Or WindowBehaviors.Move Or WindowBehaviors.Maximize
        window1.Width = Width
        window1.Height = Height
        window1.Modal = True
        window1.OnClientClose = "OnClientClose"
        RadWindowManager1.Windows.Add(window1)
    End Sub

End Class
