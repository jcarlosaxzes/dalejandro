Imports Telerik.Web.UI
Public Class employeenewtime
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Me.Title = ConfigurationManager.AppSettings("Titulo") & ". New Time"
            Master.PageTitle = "Employee New Time"
            If Not IsPostBack Then
                lblCompanyId.Text = Session("companyId")
                lblEmployeeId.Text = Master.UserId
                lblSelectedJob.Text = Request.QueryString("JobId")
                lblJobName.Text = LocalAPI.GetJobName(lblSelectedJob.Text)

                Dim clientId As Integer = LocalAPI.GetJobProperty(lblSelectedJob.Text, "Client")

                cboCategory.DataBind()

                If Not Request.QueryString("JobTicketId") Is Nothing Then
                    lblSelectedTicket.Text = Request.QueryString("JobTicketId")
                End If

                ' Botones Time & TimeAndInvoices Visible????
                Dim type As Integer = LocalAPI.GetClientProperty(clientId, "BillType")
                Select Case type
                    Case 1  ' Solo Time
                        btnInsertTimeAndInvoice.Visible = False
                    Case 2  ' Solo Time+Invoices
                        btnInsertTime.Visible = False
                    Case Else
                        ' Mismo analisis para el Job
                        type = LocalAPI.GetJobProperty(lblSelectedJob.Text, "BillType")
                        Select Case type
                            Case 1  ' Solo Time
                                btnInsertTimeAndInvoice.Visible = False
                            Case 2  ' Solo Time+Invoices
                                btnInsertTime.Visible = False
                        End Select
                End Select

                If Not Request.QueryString("Dialog") Is Nothing Then
                    Master.HideMasterMenu()
                    btnBack.Visible = False
                End If
                If Not Request.QueryString("back") Is Nothing Then
                    lblBackId.Text = Request.QueryString("back")
                End If


                InitDialog()

            End If

        Catch ex As Exception
        End Try
    End Sub

    Private Sub InitDialog()
        Try
            opcDone.Checked = False
            opcHold.Checked = False
            txtDescription.Text = ""

            Dim DefaultValuesObject = LocalAPI.GetJobNewTimeDefaultValues(lblSelectedJob.Text, lblEmployeeId.Text)
            ' Dim SalesRep as String = verificationRecord("SalesRep")

            txtTimeSel.Text = DefaultValuesObject("Hours")

            RadDatePicker1.DbSelectedDate = DefaultValuesObject("DateOfWork")

            If LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Type") = 16 Then
                ' Programmers/Computer/IT
                divProposalTask.Visible = False
                divTickets.Visible = (LocalAPI.GetActiveJobTicketsCount(lblSelectedJob.Text) > 0)

                If divTickets.Visible And lblSelectedTicket.Text > 0 Then
                    cboActiveTickets.DataBind()
                    cboActiveTickets.SelectedValue = lblSelectedTicket.Text
                    txtDescription.Text = cboActiveTickets.Text
                End If

            Else
                divTickets.Visible = False
                divProposalTask.Visible = LocalAPI.IsProposalTaskForJob(lblSelectedJob.Text)
            End If

            cboCategory.SelectedValue = DefaultValuesObject("CategoryId")

            If divProposalTask.Visible Then
                cboTask.DataBind()
                cboTask.SelectedValue = DefaultValuesObject("ProposalTaskId")
            End If

            txtDescription.Focus()

            RadGridTimes.DataBind()
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btnInsertTime_Click(sender As Object, e As EventArgs) Handles btnInsertTime.Click
        Try

            If LocalNewTime() Then
                If btnBack.Visible Then
                    BackPage()
                Else
                    InitDialog()
                    RadGridTimes.DataBind()
                    Master.InfoMessage("New time inserted")
                End If
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Protected Sub btnInsertTimeAndInvoice_Click(sender As Object, e As EventArgs) Handles btnInsertTimeAndInvoice.Click
        Try

            If LocalNewTime() Then
                Dim TimeId As Integer = LocalAPI.GetLastTimeId(lblEmployeeId.Text, lblSelectedJob.Text)
                LocalNewInvoice(TimeId)

                If btnBack.Visible Then
                    BackPage()
                Else
                    InitDialog()
                    Master.InfoMessage("New time & invoice inserted")
                End If
            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub
    Protected Sub LocalNewInvoice(TimeId As Integer)
        Dim dRate As Double = 0
        If Val(cboTask.SelectedValue) > 0 Then
            dRate = LocalAPI.GetProposalTaskRate(cboTask.SelectedValue)
        Else
            ' Parche para Axzes a $35/Hour
            If lblCompanyId.Text = 260973 Then
                dRate = 35
            Else
                dRate = LocalAPI.GetEmployeeHourRate(lblEmployeeId.Text)
            End If

        End If

        LocalAPI.NuevoInvoiceHourlyRate(TimeId, lblSelectedJob.Text, txtTimeSel.Value, dRate)

    End Sub
    Protected Function LocalNewTime() As Boolean
        Try
            Dim taskId As Integer = 0
            Dim JobTicketId As Integer = 0
            If divProposalTask.Visible Then
                If cboTask.SelectedValue > 0 Then
                    taskId = cboTask.SelectedValue
                End If
            End If
            If divTickets.Visible Then
                JobTicketId = cboActiveTickets.SelectedValue
            End If
            If LocalAPI.InsertNewTime(lblEmployeeId.Text, lblSelectedJob.Text, RadDatePicker1.SelectedDate, txtTimeSel.Value, txtDescription.Text,
                                  taskId, cboCategory.SelectedValue, lblCompanyId.Text, JobTicketId) Then

                ' Actualizar el status del Job
                If opcDone.Checked Then
                    LocalAPI.SetJobStatus(lblSelectedJob.Text, 7, lblEmployeeId.Text, lblCompanyId.Text, lblEmployeeId.Text)
                    opcDone.Checked = False

                ElseIf opcHold.Checked Then
                    LocalAPI.SetJobStatus(lblSelectedJob.Text, 3, lblEmployeeId.Text, lblCompanyId.Text, lblEmployeeId.Text)
                    opcHold.Checked = False

                End If

                Return True
            End If
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Private Sub cboActiveTickets_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs) Handles cboActiveTickets.SelectedIndexChanged
        If cboActiveTickets.SelectedValue > 0 Then
            txtDescription.Text = cboActiveTickets.Text
            If cboCategory.SelectedValue = 0 Then
                cboCategory.Focus()
            Else
                txtDescription.Focus()
            End If
        End If
    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        BackPage()
    End Sub
    Private Sub BackPage()
        Select Case lblBackId.Text
            Case 1
                Response.Redirect("~/adm/activejobsdashboad.aspx")
            Case 2
                Response.Redirect("~/adm/default.aspx")
        End Select

    End Sub
    Private Sub btnTotals_Click(sender As Object, e As EventArgs) Handles btnTotals.Click
        FormViewTimeBalance.Visible = Not FormViewTimeBalance.Visible
        lblJobName.Visible = Not FormViewTimeBalance.Visible
    End Sub
End Class

