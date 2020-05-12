Imports Telerik.Web.UI
Public Class newjob
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")

                lblEmployeeEmail.Text = Master.UserEmail
                lblEmployeeId.Text = LocalAPI.GetEmployeeId(lblEmployeeEmail.Text, lblCompanyId.Text)
                lblEmployeeName.Text = LocalAPI.GetEmployeeName(lblEmployeeId.Text)

                SqlDataSourceYear.DataBind()
                cboYear.DataBind()
                If Not Request.QueryString("Year") Is Nothing Then
                    lblYear.Text = Right(Request.QueryString("Year"), 2) & "-"
                    cboYear.SelectedValue = Request.QueryString("Year")
                Else
                    lblYear.Text = Right(Year(Date.Today), 2) & "-"
                End If

                SqlDataSourceEmployee.DataBind()
                SqlDataSourceJobStatus.DataBind()
                InitPage(lblId.Text)
                txtCode.Enabled = True

                If LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Type") = 16 Then
                    ' Initialize for IT companies
                    cboSector.DataBind()
                    cboSector.SelectedValue = 2
                    cboUse.DataBind()
                    cboUse.SelectedValue = "B"
                End If

                txtCode.Focus()

            End If
            Title = ConfigurationManager.AppSettings("Titulo") & IIf(lblId.Text > 0, ". Job Details", ". New Job")


        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub

    Private Sub InitPage(ByVal lJob As Integer)
        Try

            ' New Job excluir inactivos

            ' Analisis de Cantidad en esta Caracteristica¡¡¡
            Dim CantidadPermitida As Double, CantidadActual As Double
            If LocalAPI.sys_CaracteristicaCantidad(lblCompanyId.Text, 102, Session("Version"), CantidadPermitida, CantidadActual) Then
                Response.RedirectPermanent("~/ADM/VersionFeatures.aspx?Feature=Amount Of Jobs per year(" & CantidadPermitida & ")")
            End If

            ' Si no tiene permiso, la dirijo a message
            'lblNew.Text = "Enter details Of the New Job below. Be mindful Of mandatory fields."
            If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_NewJob") Then Response.RedirectPermanent("~/ADM/Default.aspx")

            Me.RadDatePicker1.SelectedDate = Date.Today

            If Len(txtCode.Text) = 0 Then
                'txtCode.Text = LocalAPI.GetNewJobCode(Left(Me.lblYear.Text, 2), lblCompanyId.Text)
                txtCode.Text = Mid(LocalAPI.GetNextJobCode(Right(cboYear.SelectedValue, 2), lblCompanyId.Text), 4)
            End If

        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub


    Protected Sub btnCreateJob_Click(sender As Object, e As EventArgs) Handles btnCreateJob.Click
        CreateJob()
    End Sub

    Private Sub CreateJob()
        Try
            If Not LocalAPI.IsJobName(-1, txtJob.Text, lblCompanyId.Text) Then
                Dim EngRecord As Integer = IIf(Val("" & cboEngRecord.SelectedValue) > 0, cboEngRecord.SelectedValue, 0)
                Dim dCost As Double = IIf(Val("" & txtCost.Value) > 0, txtCost.Value, 0)
                'Me.lblYear.Text = Right(Year(Me.RadDatePicker1.SelectedDate.Value), 2) & "-"
                Dim nProposalType As Integer = IIf(Val("" & cboProposalType.SelectedValue) > 0, cboProposalType.SelectedValue, 0)
                lblId.Text = LocalAPI.NuevoJob(lblYear.Text & txtCode.Text, txtJob.Text, RadDatePicker1.SelectedDate.Value, cboCliente.SelectedValue,
                                       txtBudgest.Text, nProposalType, cboType.SelectedValue, cboEmployee.SelectedValue, txtProjectLocation.Text, "", cboSector.SelectedValue, cboUse.SelectedValue, "", cboDepartment.SelectedValue, txtOwnerName.Text, EngRecord, dCost, lblCompanyId.Text)

                ' Return con llamado a job_page!!!
                Response.Redirect("~/adm/jobs.aspx?JobIdInput=" & lblId.Text)

            Else
                txtJob.Focus()
                Master.ErrorMessage("'" & txtJob.Text & "' is the name of other job. Change this property.")
            End If
        Catch ex As Exception
            Master.ErrorMessage(ex.Message)
        End Try
    End Sub

    Protected Sub cboYear_SelectedIndexChanged(sender As Object, e As DropDownListEventArgs) Handles cboYear.SelectedIndexChanged
        lblYear.Text = Right(cboYear.SelectedValue, 2) & "-"
        txtCode.Text = Mid(LocalAPI.GetNextJobCode(Right(cboYear.SelectedValue, 2), lblCompanyId.Text), 4)
    End Sub

    Private Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
        Response.Redirect("~/adm/jobs.aspx")
    End Sub
End Class


