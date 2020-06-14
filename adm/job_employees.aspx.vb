﻿Imports Telerik.Web.UI
Public Class job_employees
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If (Not Page.IsPostBack) Then
                lblCompanyId.Text = Session("companyId")
                lblJobId.Text = Request.QueryString("JobId")
                Master.ActiveTab(2)
            End If

            RadWindowManager1.EnableViewState = False

        Catch ex As Exception
            Master.ErrorMessage(ex.Message & " code: " & lblCompanyId.Text)
        End Try
    End Sub
    Protected Sub btnSetEmployee_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSetEmployee.Click
        CreateRadWindows("SetEmployee", "~/ADM/JobAssignEmployee.aspx?JobId=" & lblJobId.Text, 750, 450, False, "OnClientClose")
    End Sub

    Private Sub CreateRadWindows(WindowsID As String, sUrl As String, Width As Integer, Height As Integer, Maximize As Boolean, OnClientCloseFn As String)
        RadWindowManager1.Windows.Clear()
        Dim window1 As RadWindow = New RadWindow()
        window1.NavigateUrl = sUrl
        window1.VisibleOnPageLoad = True
        window1.VisibleStatusbar = False
        window1.ID = WindowsID
        If Maximize Then window1.InitialBehaviors = WindowBehaviors.Maximize
        window1.Behaviors = WindowBehaviors.Close Or WindowBehaviors.Resize Or WindowBehaviors.Move Or WindowBehaviors.Maximize
        If Width = -1 Then
            window1.AutoSize = True
        Else
            window1.AutoSize = False
            window1.Width = Width
            window1.Height = Height
        End If
        window1.Modal = True
        window1.OnClientClose = OnClientCloseFn
        RadWindowManager1.Windows.Add(window1)
    End Sub
    Public Function GetPercentETForeColor(ByVal dPercent As Object) As System.Drawing.Color
        If Val("" & dPercent) < 25 Then
            Return System.Drawing.Color.LightGreen
        ElseIf dPercent < 50 Then
            Return System.Drawing.Color.Green
        ElseIf dPercent < 75 Then
            Return System.Drawing.Color.Orange
        ElseIf dPercent < 100 Then
            Return System.Drawing.Color.OrangeRed
        Else
            Return System.Drawing.Color.DarkRed
        End If
    End Function
    Public Function GetPercentETFontBold(ByVal dPercent As Object) As Boolean
        If Val("" & dPercent) < 75 Then
            Return False
        Else
            Return True
        End If
    End Function
    Protected Sub RadGridAssignedEmployees_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGridAssignedEmployees.ItemCommand
        Dim sUrl As String = ""
        Select Case e.CommandName
            Case "NotifyEmployee"
                Dim Id As Integer = e.CommandArgument
                Dim JobCodeName As String = LocalAPI.GetJobCodeName(lblJobId.Text)
                Dim employeeId As Integer = LocalAPI.GetJobsEmployeesassignedProperty(Id, "employeeId")
                Dim nHours As Double = LocalAPI.GetJobsEmployeesassignedProperty(Id, "Hours") - LocalAPI.GetJobHourWorked(lblJobId.Text)

                NotifyEmployee(employeeId, JobCodeName, nHours)

        End Select
    End Sub
    Protected Sub NotifyEmployee(employeeId As Integer, JobCodeName As String, dHourds As Double)
        Dim sFullBody As New System.Text.StringBuilder
        sFullBody.Append("You had been assigned Job " & JobCodeName)
        sFullBody.Append("<br />")
        sFullBody.Append("Hours (remaining): " & dHourds)
        sFullBody.Append("<br />")

        LocalAPI.EmailToEmployee(employeeId, "Job: '" & JobCodeName & "' asigned", sFullBody, lblCompanyId.Text)
    End Sub

End Class
