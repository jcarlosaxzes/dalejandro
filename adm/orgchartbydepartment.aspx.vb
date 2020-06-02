Public Class orgchartbydepartment
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not IsPostBack() Then
                ' Si no tiene permiso, la dirijo a message
                '!!! pending permiso especifico
                If Not LocalAPI.GetEmployeePermission(Master.UserId, "Deny_OrganizationChart") Then Response.RedirectPermanent("~/ADM/Default.aspx")

                Me.Title = ConfigurationManager.AppSettings("Titulo") & ". Organization Chart"
                Master.PageTitle = "Departments/Organization Chart"
                Master.Help = "http://blog.pasconcept.com/2015/04/departmentsmonthly-chart.html"
                lblCompanyId.Text = Session("companyId")
                lblCompanyName.Text = LocalAPI.GetCompanyProperty(lblCompanyId.Text, "Name")
                'If LocalAPI.IsOrgChar(lblCompanyId.Text) Then

                SqlDataSource1.DataBind()
                'Else
                '    Response.RedirectPermanent("~/ADM/Default.aspx")
                'End If

            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub RadOrgChart1_NodeDataBound(sender As Object, e As Telerik.Web.UI.OrgChartNodeDataBoundEventArguments) Handles RadOrgChart1.NodeDataBound
        Try

            btnOrientation.DataBind()
            If btnOrientation.Text = "Vertical" Or btnOrientation.Text = "" Then
                RadOrgChart1.Orientation = Orientation.Vertical
            Else
                RadOrgChart1.Orientation = Orientation.Horizontal
            End If

            btnPrivate.DataBind()
            ' Formateando nvarchar a Numeros
            If e.Node.RenderedFields(1).Text = 0 Or btnPrivate.Text = "Private" Or btnPrivate.Text = "" Then
                e.Node.RenderedFields(1).Text = ""
            Else
                e.Node.RenderedFields(1).Text = "Budget " & FormatNumber(e.Node.RenderedFields(1).Text, 0)
                e.Node.RenderedFields(1).Label = ""
            End If
            If e.Node.RenderedFields(2).Text = 0 Or btnPrivate.Text = "Private" Or btnPrivate.Text = "" Then
                e.Node.RenderedFields(2).Text = ""
                e.Node.RenderedFields(2).Label = ""
            Else
                e.Node.RenderedFields(2).Text = "Execut. " & FormatNumber(e.Node.RenderedFields(2).Text, 0)
            End If
            If e.Node.RenderedFields(3).Text = 0 Or btnPrivate.Text = "Private" Or btnPrivate.Text = "" Then
                e.Node.RenderedFields(3).Text = ""
                e.Node.RenderedFields(3).Label = ""
            Else
                e.Node.RenderedFields(3).Text = "Balance " & FormatNumber(e.Node.RenderedFields(3).Text, 0)
            End If

            ' Detactando si existe imagen
            'Dim i As Integer
            'For i = 0 To e.Node.GroupItems.Count - 1
            '    ' Existe el archivo en disco?
            '    If Not System.IO.File.Exists(Server.MapPath(e.Node.GroupItems(i).ImageUrl.ToString)) Then
            '        e.Node.GroupItems(i).ImageUrl = "~/Images/Employees/nophoto.jpg"
            '    End If
            'Next
        Catch ex As Exception

        End Try


    End Sub

End Class
