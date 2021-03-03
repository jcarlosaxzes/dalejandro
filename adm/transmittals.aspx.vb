Imports Telerik.Web.UI
Public Class transmittals
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Transmittals"
            If (Not Page.IsPostBack) Then

                ' Si no tiene permiso, la dirijo a message
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_TransmittalList") Then Response.RedirectPermanent("~/adm/schedule.aspx")

                Master.PageTitle = "Jobs/Transmittals"
                Master.Help = "http://blog.pasconcept.com/2015/04/jobstransmittal-letter.html"

                lblEmployeeId.Text = Master.UserId
                lblEmployeeName.Text = LocalAPI.GetEmployeeName(lblEmployeeId.Text)
                lblEmployeeEmail.Text = Master.UserEmail

                lblCompanyId.Text = Session("companyId")

                cboPeriod.DataBind()
                IniciaPeriodo(cboPeriod.SelectedValue)

                If Len(Session("Employee")) Then
                    cboEmployee.SelectedValue = Session("Employee")
                End If

                cboStatus.DataBind()

            End If

            If RadWindowManager1.Windows.Count > 0 Then
                RadWindowManager1.Windows.Clear()
                RadGrid1.DataBind()
            End If

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        IniciaPeriodo(cboPeriod.SelectedValue)
        RadGrid1.DataBind()
    End Sub

    Private Sub IniciaPeriodo(nPeriodo As Integer)
        cboPeriod.SelectedValue = nPeriodo
        Select Case nPeriodo
            Case 13  ' (All Years)
                RadDatePickerFrom.DbSelectedDate = "01/01/2000"
                RadDatePickerTo.DbSelectedDate = "12/31/" & Today.Year

            Case 15  ' (Last Years)
                RadDatePickerFrom.DbSelectedDate = "01/01/" & Today.Year - 1
                RadDatePickerTo.DbSelectedDate = "12/31/" & Today.Year - 1

            Case 16  ' (This Month)
                RadDatePickerFrom.DbSelectedDate = Today.Month & "/01/" & Today.Year
                RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Day, -1, DateAdd(DateInterval.Month, 1, RadDatePickerFrom.DbSelectedDate))
            Case 17  ' (Past Month)
                RadDatePickerFrom.DbSelectedDate = Today.Month & "/01/" & Today.Year
                RadDatePickerFrom.DbSelectedDate = DateAdd(DateInterval.Month, -1, RadDatePickerFrom.DbSelectedDate)
                RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Day, -1, DateAdd(DateInterval.Month, 1, RadDatePickerFrom.DbSelectedDate))

            Case 30, 60, 90, 120, 180, 365 '   days....
                RadDatePickerTo.DbSelectedDate = Date.Today
                RadDatePickerFrom.DbSelectedDate = DateAdd(DateInterval.Day, 0 - nPeriodo, RadDatePickerTo.DbSelectedDate)

            Case 99   'Custom
                RadDatePickerFrom.Focus()
                ' Allow RadDatePicker user Values...

            Case 14  '14 and any other old setting (This Years)
                RadDatePickerFrom.DbSelectedDate = "01/01/" & Today.Year
                RadDatePickerTo.DbSelectedDate = "12/31/" & Today.Year

            Case 99   'Custom
                RadDatePickerFrom.Focus()
                ' Allow RadDatePicker user Values...
        End Select
    End Sub

    Protected Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
        RadGrid1.MasterTableView.InsertItem()
    End Sub

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName
            Case "EditTransmittal"
                Response.Redirect("~/adm/transmittal.aspx?transmittalId=" & e.CommandArgument & "&BackPage=transmittals")

            Case "EmailPickUp"
                If LocalAPI.EmailReadyToPickUp(e.CommandArgument, lblCompanyId.Text, lblEmployeeEmail.Text, lblEmployeeName.Text) Then
                    LocalAPI.SetTransmittalJobToDoneStatus(e.CommandArgument)
                    Master.InfoMessage("The Transmittal have been sent by email")
                End If

            Case "EditClient"
                sUrl = $"~/ADM/Client.aspx?clientId={e.CommandArgument}&Dialog=1"
                CreateRadWindows("ClientW", sUrl, 970, 750, False)

            Case "EmailDeliveryTransmittalDigital"
                sUrl = "~/adm/sendtransmittal.aspx?TransmittalId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 960, 680, False)

            Case "Delete"
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
