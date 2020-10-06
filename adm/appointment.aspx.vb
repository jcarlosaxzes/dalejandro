Imports Telerik.Web.UI

Public Class appointment
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            lblCompanyId.Text = Session("companyId")
            lblStartDate.Text = Session("appointment_start")
            lblEndDate.Text = Session("appointment_end")
            Dim s = DateTime.Now
            If Len(lblStartDate.Text) > 0 Then
                s = DateTime.Parse(lblStartDate.Text)
            End If
            Dim en = DateTime.Now.AddHours(1)
            If Len(lblEndDate.Text) > 0 Then
                en = DateTime.Parse(lblEndDate.Text)
            End If

            dtpStart.SelectedDate = s
            dtpEnd.SelectedDate = en
            lblEmployee.Text = LocalAPI.GetEmployeeId(Master.UserEmail, lblCompanyId.Text)
            lblAppointmentid.Text = Val(Request.QueryString("Id"))
            btnSave.Text = IIf(Val(Request.QueryString("Id")) > 0, "Update Appointment", "Create Appointment")
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click

        If CType(FormView1.FindControl("txtSubject"), RadTextBox).Text.Length = 0 Then
            lblError.Text = "Please enter Subject"
            Return
        End If

        If CType(FormView1.FindControl("dtpStart"), RadDatePicker).SelectedDate >= CType(FormView1.FindControl("dtpEnd"), RadDatePicker).SelectedDate Then
            If CType(FormView1.FindControl("tpStart"), RadTimePicker).SelectedDate >= CType(FormView1.FindControl("tpEnd"), RadTimePicker).SelectedDate Then
                lblError.Text = "End Date must be grate than Start Date"
                Return
            End If
        End If

            FormView1.UpdateItem(False)


    End Sub

    Protected Sub btnBack_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBack.Click
        Response.Redirect("~/adm/schedule.aspx")
    End Sub

    Protected Sub SqlDataSourceAppointments_Updated(sender As Object, e As SqlDataSourceStatusEventArgs)
        Dim newId = e.Command.Parameters("@ReturnId").Value.ToString()
        lblAppointmentid.Text = newId

        If CType(FormView1.FindControl("chNotify"), RadCheckBox).Checked Then
            Response.Redirect($"~/adm/notificationsnew.aspx?id={newId}&EntityType=Appointment&backpage=schedule")
        Else
            Response.Redirect("~/adm/schedule.aspx")
        End If
    End Sub

    Protected Sub SqlDataSourceAppointments_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs)
        Dim newId = e.Command.Parameters
    End Sub

    Protected Sub SqlDataSourceAppointments_Selected(sender As Object, e As SqlDataSourceStatusEventArgs)
        ' Dim newId = e.AffectedRows.
    End Sub
End Class

