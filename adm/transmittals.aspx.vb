Imports Telerik.Web.UI
Public Class transmittals
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Transmittals"
            If (Not Page.IsPostBack) Then

                ' Si no tiene permiso, la dirijo a message
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_TransmittalList") Then Response.RedirectPermanent("~/ADM/Default.aspx")

                Master.PageTitle = "Jobs/Transmittals"
                Master.Help = "http://blog.pasconcept.com/2015/04/jobstransmittal-letter.html"

                lblEmployeeId.Text = Master.UserId
                lblEmployeeName.Text = LocalAPI.GetEmployeeName(lblEmployeeId.Text)
                lblEmployeeEmail.Text = Master.UserEmail

                LocalAPI.RefreshYearsList()
                lblCompanyId.Text = Session("companyId")

                cboYear.DataBind()
                cboYear.SelectedValue = Today.Year
                cboMes.DataBind()
                cboMes.SelectedValue = Date.Today.Month
                IniciaPeriodo(cboMes.SelectedValue)

                If Len(Session("Employee")) Then
                    cboEmployee.SelectedValue = Session("Employee")
                End If

                cboStatus.DataBind()
                cboStatus.SelectedValue = 1

            End If

            If RadWindowManager1.Windows.Count > 0 Then
                RadWindowManager1.Windows.Clear()
                RadGrid1.DataBind()
            End If

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        IniciaPeriodo(cboMes.SelectedValue)
        RadGrid1.DataBind()
    End Sub

    Private Sub IniciaPeriodo(nPeriodo As Integer)

        Select Case nPeriodo
            Case 1 To 12 ' Meses
                If cboYear.SelectedValue = 0 Then
                    cboYear.SelectedValue = Date.Today.Year
                End If
                RadDatePickerFrom.DbSelectedDate = nPeriodo & "/01/" & cboYear.SelectedValue
                RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Month, 1, RadDatePickerFrom.DbSelectedDate)
                RadDatePickerTo.DbSelectedDate = DateAdd(DateInterval.Day, -1, RadDatePickerTo.DbSelectedDate)

            Case 0  ' All months...
                Dim nYearFrom As Integer = IIf(cboYear.SelectedValue > 0, cboYear.SelectedValue, 2000)
                Dim nYearTo As Integer = IIf(cboYear.SelectedValue > 0, cboYear.SelectedValue, Today.Year)

                RadDatePickerFrom.DbSelectedDate = "01/01/" & nYearFrom
                RadDatePickerTo.DbSelectedDate = "12/31/" & nYearTo

            Case Is > 29   ' Last 60, 90 days....
                ' Rectifico filtro de Year a This Year
                cboYear.SelectedValue = Date.Today.Year

                RadDatePickerTo.DbSelectedDate = Date.Today
                RadDatePickerFrom.DbSelectedDate = DateAdd(DateInterval.Day, 0 - nPeriodo, RadDatePickerTo.DbSelectedDate)

        End Select
    End Sub

    Protected Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
        RadGrid1.MasterTableView.InsertItem()
    End Sub

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName
            Case "EditTransmittal"
                sUrl = "~/ADMCLI/Transmittal.aspx?transmittalId=" & e.CommandArgument
                CreateRadWindows(e.CommandName, sUrl, 970, 810, False)

            Case "Email"
                If LocalAPI.EmailReadyToPickUp(e.CommandArgument, lblCompanyId.Text, lblEmployeeEmail.Text, lblEmployeeName.Text) Then
                    LocalAPI.SetTransmittalJobToDoneStatus(e.CommandArgument)
                    Master.InfoMessage("The Transmittal have been sent by email")
                End If

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
