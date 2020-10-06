Imports Telerik.Web.UI

Public Class notificationsnew
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            lblCompanyId.Text = Session("companyId")
            lblEntityId.Text = Val(Request.QueryString("Id"))
            lblEntityType.Text = Request.QueryString("EntityType")
            lblNotificationsId.Text = ""

            If (lblEntityType.Text = "Appointment") Then
                Dim Appointments = LocalAPI.GetRecordFromQuery($"SELECT TOP 1 [Id]
                                      ,[Subject]
                                      ,[Description]
                                      ,[Start]
                                      ,[End]                                      
                                      ,[companyId]
                                      ,[Location]
                                      ,[AllDay]
                                  FROM [dbo].[Appointments] where companyId = {lblCompanyId.Text} and id = " + lblEntityId.Text)

                Dim Notifications = LocalAPI.GetRecordFromQuery($"SELECT TOP 1 [Id]
				                          ,[Subject]
				                          ,[Body]
				                          ,[SendDate]
				                          ,[EntityType]
				                          ,[EntityId]
                                          ,[EmployeesId]
                                          ,[TargetEmails]
			                          FROM [dbo].[Notifications] where EntityType = 'Appointment' and EntityId = " + lblEntityId.Text)

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
        Response.Redirect("~/adm/schedule.aspx")
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

        Response.Redirect($"~/adm/schedule.aspx")

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
End Class