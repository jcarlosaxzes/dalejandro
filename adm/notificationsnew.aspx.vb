Imports Telerik.Web.UI

Public Class notificationsnew
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            lblCompanyId.Text = Session("companyId")
            lblEntityId.Text = Val(Request.QueryString("EntityId"))
            lblEntityType.Text = Request.QueryString("EntityType")
            lblAppointmentId.Text = Val(Request.QueryString("AppointmentId"))
            lblNotificationsId.Text = ""

            If (lblEntityType.Text = "Notifications") Then
                lblNotificationsId.Text = lblEntityId.Text

                Dim Notifications = LocalAPI.GetRecordFromQuery($"SELECT TOP 1 [Id]
                              ,[Subject]
                              ,[Body]
                              ,[SendDate]
                              ,[EntityType]
                              ,[EntityId]
                                          ,[EmployeesId]
                                          ,[TargetEmails]
                             FROM [dbo].[Notifications] where Id =  " & lblNotificationsId.Text)

                UpdateControls(Notifications("Subject"),
                                    Notifications("Body"),
                                    Notifications("SendDate"),
                                    Notifications("EmployeesId"))
                btnSave.Text = "Update Notification"

            Else

                If Val(lblAppointmentId.Text) > 0 Then
                    Dim Appointments = LocalAPI.GetRecordFromQuery($"SELECT TOP 1 [Id]
                                      ,[Subject]
                                      ,[Description]
                                      ,[Start]
                                      ,[End]                                      
                                      ,[companyId]
                                      ,[Location]
                                      ,[AllDay]
                                  FROM [dbo].[Appointments] where id = " & lblAppointmentId.Text)

                    Dim Notifications = LocalAPI.GetRecordFromQuery($"SELECT TOP 1 [Id]
				                          ,[Subject]
				                          ,[Body]
				                          ,[SendDate]
				                          ,[EntityType]
				                          ,[EntityId]
                                          ,[EmployeesId]
                                          ,[TargetEmails]
			                          FROM [dbo].[Notifications] where AppointmentId = {lblAppointmentId.Text} ")

                    If IsNothing(Notifications) Or Notifications.Count = 0 Then

                        UpdateControls(Appointments("Subject"),
                                Appointments("Description") & " Location: " & Appointments("Location"),
                                Appointments("Start"),
                                "")
                        btnSave.Text = "Create Notification"
                    Else
                        lblNotificationsId.Text = Notifications("Id")
                        UpdateControls(Notifications("Subject"),
                                Notifications("Body"),
                                Notifications("SendDate"),
                                Notifications("EmployeesId"))
                        btnSave.Text = "Update Notification"
                    End If

                End If
            End If
            'If (lblEntityType.Text = "Appointment") Then

            '    lblEntityId.Text = AppointmentId

            '    Dim Appointments = LocalAPI.GetRecordFromQuery($"SELECT TOP 1 [Id]
            '                          ,[Subject]
            '                          ,[Description]
            '                          ,[Start]
            '                          ,[End]                                      
            '                          ,[companyId]
            '                          ,[Location]
            '                          ,[AllDay]
            '                      FROM [dbo].[Appointments] where companyId = {lblCompanyId.Text} and id = " & AppointmentId)

            '    Dim Notifications = LocalAPI.GetRecordFromQuery($"SELECT TOP 1 [Id]
            '                  ,[Subject]
            '                  ,[Body]
            '                  ,[SendDate]
            '                  ,[EntityType]
            '                  ,[EntityId]
            '                              ,[EmployeesId]
            '                              ,[TargetEmails]
            '                 FROM [dbo].[Notifications] where EntityType = 'Appointment' and EntityId = " & AppointmentId)

            '    If IsNothing(Notifications) Or Notifications.Count = 0 Then

            '        UpdateControls(Appointments("Subject"),
            '                        Appointments("Description") & " Location: " & Appointments("Location"),
            '                        Appointments("Start"),
            '                        "")
            '        btnSave.Text = "Create Notification"
            '    Else
            '        lblNotificationsId.Text = Notifications("Id")
            '        UpdateControls(Notifications("Subject"),
            '                        Notifications("Body"),
            '                        Notifications("SendDate"),
            '                        Notifications("EmployeesId"))
            '        btnSave.Text = "Update Notification"
            '    End If



            'End If




        End If
    End Sub

    Protected Sub UpdateControls(Subject As String, Description As String, SendDate As DateTime, Employees As String)
        txtSubject.Text = Subject
        txtDescription.Text = Description
        If Not (IsNothing(SendDate)) Then
            dtpSendDate.SelectedDate = SendDate
        End If

        lblEmployeesId.Text = Employees

    End Sub

    Protected Sub btnBack_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBack.Click
        BackPage()
    End Sub


    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        'Store Select Employess
        Dim ids As String = ""
        Dim collection As IList(Of RadComboBoxItem) = cboNotify.CheckedItems
        If (collection.Count <> 0) Then
            For Each item As RadComboBoxItem In collection
                If Len(ids) = 0 Then
                    ids = item.Value
                Else
                    ids = ids & "," & item.Value
                End If
            Next
        End If
        lblEmployeesId.Text = ids

        If Val(lblNotificationsId.Text) > 0 Then
            SqlDataSourceNotifications.Update()
        Else
            SqlDataSourceNotifications.Insert()
        End If


        BackPage()

    End Sub

    Protected Sub SqlDataSourceNotifications_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        Dim eeee = e.Command.Parameters
    End Sub


    Protected Sub cboType_ItemDataBound(sender As Object, e As RadComboBoxItemEventArgs) Handles cboNotify.ItemDataBound
        Dim employeesArray = lblEmployeesId.Text.Split(",")
        If employeesArray.Contains(e.Item.Value) Then
            e.Item.Checked = True
        Else
            e.Item.Checked = False
        End If

    End Sub

    Protected Sub SqlDataSourceNotifications_Updated(sender As Object, e As SqlDataSourceStatusEventArgs)
        Dim sss = e.Command.Parameters
    End Sub


    Protected Sub BackPage()
        If (lblEntityType.Text = "Appointment") Then
            Response.Redirect("~/adm/schedule.aspx")
            Return
        End If

        If Request.QueryString("backpage") = "Notifications" Then
            Response.Redirect("~/adm/Notifications.aspx")
            Return
        End If

        If Request.QueryString("backpage") = "Job" Then
            Dim jobGuid = LocalAPI.GetJobProperty(lblEntityId.Text, "guid")
            Response.Redirect($"~/adm/job_schedule?guid={jobGuid}")
            Return
        End If

        If Request.QueryString("backpage") = "Client" Then
            Response.Redirect($"~/adm/Client?clientId={lblEntityId.Text}&FullPage=1&tab=schedule")
            Return
        End If

        If Request.QueryString("backpage") = "Clients" Then
            Response.Redirect($"~/adm/Clients?restoreFilter=true")
            Return
        End If

        If Request.QueryString("backpage") = "Jobs" Then
            Response.Redirect($"~/adm/Jobs?restoreFilter=true")
            Return
        End If

        Response.Redirect($"~/adm/schedule.aspx")
    End Sub

End Class