Imports System.IO
Imports Microsoft.VisualBasic.FileIO
Public Class importdata
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim user As MembershipUser = Membership.GetUser()
            lblCompanyId.Text = Session("companyId")
            Me.Title = "Others/Import data"
            ' Si no tiene permiso, la dirijo a message
            If Not LocalAPI.GetEmployeePermission(LocalAPI.GetEmployeeId(user.Email, lblCompanyId.Text), "Deny_Importdata") Then
                Response.RedirectPermanent("~/ADM/Default.aspx")
            End If

            Dim Source As String = "" & Request.QueryString("source")

            Select Case Source
                Case "Clients", "Employees", "Subconsultants", "Contacts", "OutlookContacts", "ExportedContacts"
                    cboDestino.SelectedValue = Source
                Case Else
                    cboDestino.SelectedValue = "Contacts"
            End Select

            TemplateLink()

        End If
    End Sub

    Protected Sub btnImport_Click(sender As Object, e As EventArgs) Handles btnImport.Click
        Dim nRecs As Integer
        If RadUpload1.UploadedFiles.Count > 0 Then
            Select Case cboDestino.SelectedValue
                Case "OutlookContacts"
                    ImportOutlookContacts()
                Case "ExportedContacts"
                    UpdateExportedContacts()
                Case Else
                    nRecs = ImportCSV(cboSeparator.SelectedValue)
            End Select
        Else
            lblMsg.Text = "Select valid csv file."
        End If
    End Sub
    Private Function UpdateExportedContacts() As Integer
        Dim ContactObject As LocalAPI.ContactStruct
        Try

            ' declare CsvDataReader object which will act as a source for data for SqlBulkCopy
            Dim StreamerObject As Stream = RadUpload1.UploadedFiles(0).InputStream
            Dim nRecs As Integer

            Using parser As TextFieldParser = New TextFieldParser(StreamerObject)

                ' 1ra fila es cabecera 
                'Id,Name,LastName,FullName,Position,Company,Class,Type,Subtype,Address,Address2,City,State,ZipCode,Country,Phone,Cellular, BusinessPhone,Fax,Email,BusinessEmail,Web,StartingDate,Notes,ReferredBy,companyId,TAGS
                parser.SetDelimiters(",")
                Dim iField As Integer
                Dim fields As String() = parser.ReadFields()
                Dim currentRow As String()
                Dim bIsValidDataRow As Boolean

                ' Contact Data
                Dim OUT_CONTACTID As Integer

                Dim i As Integer
                ' Contact Data
                Dim MaxRecords As Integer = 0   ' 0 importa todos los records

                If Not fields Is Nothing Then
                    While Not parser.EndOfData
                        currentRow = parser.ReadFields()
                        iField = 0
                        Dim currentField As String
                        For Each currentField In currentRow

                            Select Case iField

                                Case 0  'Id
                                    ContactObject.ID = Val("" & currentField)
                                    bIsValidDataRow = (ContactObject.ID > 0)
                                    If Not bIsValidDataRow Then
                                        Exit For
                                    End If

                                Case 1  'First Name
                                    ContactObject.FirstName = Trim("" & currentField)

                                Case 2  'Last Name
                                    ContactObject.LastName = Trim("" & currentField)
                                    bIsValidDataRow = (Len(ContactObject.FirstName & ContactObject.LastName) > 0)
                                    If Not bIsValidDataRow Then
                                        Exit For
                                    End If

                                Case 4  'Position
                                    ContactObject.Position = "" & currentField

                                Case 5  'Company
                                    ContactObject.Company = "" & currentField

                                Case 7 'Contact Type
                                    ContactObject.ContactType = "" & currentField
                                Case 8 'Contact Subtype
                                    ContactObject.ContactSubtype = "" & currentField

                                    'Business Address...................
                                Case 9  'Business Street
                                    ContactObject.Address = "" & currentField
                                Case 10  'Business Street 2
                                    ContactObject.Address2 = "" & currentField
                                Case 11  'Business City
                                    ContactObject.City = "" & currentField
                                Case 12  'Business State
                                    ContactObject.State = "" & currentField
                                Case 13  'Business Postal Code
                                    ContactObject.ZipCode = "" & currentField
                                Case 14  'Business Country/Region
                                    ContactObject.Country = "" & currentField


                                    'Phones.....
                                Case 15 'Primary Phone
                                    ContactObject.Phone = LocalAPI.GetPhoneNumber("" & currentField)
                                Case 16 'Mobile Phone
                                    ContactObject.Cellular = LocalAPI.GetPhoneNumber("" & currentField)
                                Case 17 'Business Phone
                                    ContactObject.BusinessPhone = LocalAPI.GetPhoneNumber("" & currentField)
                                Case 18 'Business Fax
                                    ContactObject.Fax = LocalAPI.GetPhoneNumber("" & currentField)

                                    'Emails..........
                                Case 19
                                    ContactObject.Email = "" & currentField
                                Case 20
                                    ContactObject.BusinessEmail = "" & currentField
                                Case 21 'Web Page
                                    ContactObject.WebPage = "" & currentField

                                Case 23 'Notes
                                    ContactObject.Notes = "" & currentField
                                Case 24 'Referred By
                                    ContactObject.ReferredBy = "" & currentField

                            End Select
                            iField = iField + 1
                        Next
                        MaxRecords = MaxRecords - 1
                        If bIsValidDataRow Then
                            OUT_CONTACTID = LocalAPI.ExportedContacts_UPDATE(ContactObject, lblCompanyId.Text)
                            If OUT_CONTACTID > 0 Then
                                nRecs = nRecs + 1
                            End If
                            If MaxRecords = 0 Then
                                Exit While
                            End If
                        End If

                    End While
                End If
            End Using

            lblMsg.Text = "'" & nRecs & "' Updated records. "
            Return nRecs

        Catch ex As Exception
            RadUpload1.UploadedFiles.Clear()
            lblMsg.Text = "Error importing Code: " & ContactObject.FirstName & ". " & ex.Message

        End Try

    End Function
    Private Function ImportOutlookContacts() As Integer
        Dim ContactObject As LocalAPI.ContactStruct
        Try

            ' declare CsvDataReader object which will act as a source for data for SqlBulkCopy
            Dim StreamerObject As Stream = RadUpload1.UploadedFiles(0).InputStream
            Dim nRecs As Integer

            Using parser As TextFieldParser = New TextFieldParser(StreamerObject)

                ' 1ra fila es cabecera 
                'First Name,Middle Name,Last Name,Company,Job Title,Business Street,Business Street 2,Business City,Business State,Business Postal Code,Business Country/Region,Home Street,Home Street 2,Home City,Home State,Home Postal Code,Home Country/Region,Business Fax,Business Phone,Business Phone 2,Home Phone,Mobile Phone,Primary Phone,E-mail Address,E-mail Display Name,E-mail 2 Address,E-mail 2 Display Name,Notes,Contact Type,Contact Subtype,Referred By,Web Page
                parser.SetDelimiters(",")
                Dim iField As Integer
                Dim fields As String() = parser.ReadFields()
                Dim currentRow As String()
                Dim bIsValidDataRow As Boolean

                ' Contact Data
                Dim OUT_CONTACTID As Integer

                Dim i As Integer
                ' Contact Data
                Dim MaxRecords As Integer = 0   ' 0 importa todos los records

                If Not fields Is Nothing Then
                    While Not parser.EndOfData
                        currentRow = parser.ReadFields()
                        iField = 0
                        Dim currentField As String
                        For Each currentField In currentRow

                            Select Case iField

                                'Case 0  'Title
                                '    ContactObject.FirstName = Trim("" & currentField)

                                Case 0  'First Name
                                    ContactObject.FirstName = Trim("" & currentField)

                                'Case 2  'Middle Name
                                '    If Len(Trim("" & currentField)) > 0 Then
                                '        ContactObject.FirstName = ContactObject.FirstName & IIf(Len(ContactObject.FirstName) > 0, " ", "") & Trim(currentField)
                                '    End If

                                Case 1  'Last Name
                                    ContactObject.LastName = Trim("" & currentField)
                                    bIsValidDataRow = (Len(ContactObject.FirstName & ContactObject.LastName) > 0)
                                    If Not bIsValidDataRow Then
                                        Exit For
                                    End If

                                Case 2  'Position
                                    ContactObject.Position = "" & currentField

                                'Case 4  'Sufix

                                Case 3  'Company
                                    ContactObject.Company = "" & currentField

                                    'Business Address...................
                                Case 4  'Business Street
                                    ContactObject.Address = "" & currentField
                                Case 5  'Business Street 2
                                    ContactObject.Address2 = "" & currentField
                                Case 6  'Business City
                                    ContactObject.City = "" & currentField
                                Case 7  'Business State
                                    ContactObject.State = "" & currentField
                                Case 8  'Business Postal Code
                                    ContactObject.ZipCode = "" & currentField
                                'Case 12  'Business Country/Region
                                '    ContactObject.Country = "" & currentField

                                '    'Home Address.........................
                                'Case 13  'Home Street
                                '    If Len(ContactObject.Address) = 0 And Len("" & currentField) > 0 Then
                                '        ContactObject.Address = "" & currentField
                                '        ContactObject.FullHomeAddress = "Main"
                                '    Else
                                '        ContactObject.FullHomeAddress = "" & currentField
                                '    End If
                                'Case 14  'Home Street 2
                                '    If ContactObject.FullHomeAddress = "Main" Then
                                '        ContactObject.Address2 = "" & currentField
                                '    Else
                                '        ContactObject.FullHomeAddress = ContactObject.FullHomeAddress & IIf(Len(ContactObject.FullHomeAddress) > 0, " ", "") & currentField
                                '    End If
                                'Case 15  'Home City
                                '    If ContactObject.FullHomeAddress = "Main" Then
                                '        ContactObject.City = "" & currentField
                                '    Else
                                '        ContactObject.FullHomeAddress = ContactObject.FullHomeAddress & IIf(Len(ContactObject.FullHomeAddress) > 0, " ", "") & currentField
                                '    End If
                                'Case 16  'Home State
                                '    If ContactObject.FullHomeAddress = "Main" Then
                                '        ContactObject.State = "" & currentField
                                '    Else
                                '        ContactObject.FullHomeAddress = ContactObject.FullHomeAddress & IIf(Len(ContactObject.FullHomeAddress) > 0, " ", "") & currentField
                                '    End If
                                'Case 17  'Home Postal Code
                                '    If ContactObject.FullHomeAddress = "Main" Then
                                '        ContactObject.ZipCode = "" & currentField
                                '    Else
                                '        ContactObject.FullHomeAddress = ContactObject.FullHomeAddress & IIf(Len(ContactObject.FullHomeAddress) > 0, " ", "") & currentField
                                '    End If
                                'Case 18  'Home Country/Region
                                '    If ContactObject.FullHomeAddress = "Main" Then
                                '        ContactObject.Country = "" & currentField
                                '    Else
                                '        ContactObject.FullHomeAddress = ContactObject.FullHomeAddress & IIf(Len(ContactObject.FullHomeAddress) > 0, " ", "") & currentField
                                '    End If

                                    'Phones.....
                                'Case 19 'Business Fax
                                '    ContactObject.Fax = LocalAPI.GetPhoneNumber("" & currentField)
                                Case 9 'Business Phone
                                    ContactObject.Phone = LocalAPI.GetPhoneNumber("" & currentField)
                                Case 10 'Mobile Phone
                                    ContactObject.Cellular = LocalAPI.GetPhoneNumber("" & currentField)
                                Case 11 'Primary Fax
                                    ContactObject.Fax = LocalAPI.GetPhoneNumber("" & currentField)

                                    'Emails..........
                                Case 12
                                    ContactObject.Email = "" & currentField
                                Case 13 'Web Page
                                    ContactObject.WebPage = "" & currentField
                                'Case 28
                                '    ContactObject.BusinessEmail = "" & currentField

                                Case 14 'Notes
                                    ContactObject.Notes = "" & currentField
                                Case 15 'Contact Type
                                    ContactObject.ContactType = "" & currentField
                                Case 16 'Contact Subtype
                                    ContactObject.ContactSubtype = "" & currentField
                                Case 17 'Referred By
                                    ContactObject.ReferredBy = "" & currentField

                            End Select
                            iField = iField + 1
                        Next
                        MaxRecords = MaxRecords - 1
                        If bIsValidDataRow Then
                            OUT_CONTACTID = LocalAPI.ContactFromOutlook_INSERT(ContactObject, False, lblCompanyId.Text)
                            If OUT_CONTACTID > 0 Then
                                nRecs = nRecs + 1
                            End If
                            If MaxRecords = 0 Then
                                Exit While
                            End If
                        End If

                    End While
                End If
            End Using

            lblMsg.Text = "'" & nRecs & "' Imported/Updated records. "
            Return nRecs

        Catch ex As Exception
            RadUpload1.UploadedFiles.Clear()
            lblMsg.Text = "Error importing Code: " & ContactObject.FirstName & ". " & ex.Message

        End Try

    End Function

    Private Function ImportCSV(sCharSeparator As String) As Integer
        Try

            ' declare CsvDataReader object which will act as a source for data for SqlBulkCopy
            Dim StreamerObject As Stream = RadUpload1.UploadedFiles(0).InputStream
            Dim sr As StreamReader = New StreamReader(StreamerObject)
            Dim sLine As String
            Dim sFIELDLIST As String
            Dim sVALUELIST As String
            Dim arrHeaders
            Dim arrValues
            Dim sVal As String
            Dim nRecs As Integer
            Dim nErrs As Integer
            Dim nFields As Integer
            Dim sSqlInsert As String
            Dim i As Integer
            Dim sTable As String
            Dim NameIndex As Integer
            Dim EmailIndex As Integer

            sTable = cboDestino.SelectedValue

            ' 1ra fila es cabecera
            sLine = sr.ReadLine()
            If Not sLine Is Nothing Then
                arrHeaders = sLine.Split(sCharSeparator)
                ' Recolectar los nombres de Fileds en orden
                For Each sVal In arrHeaders
                    If sVal.Length > 0 Then
                        ' Evitar columnas vacias al final
                        sFIELDLIST = sFIELDLIST & "[" & sVal & "],"
                        If UCase(sVal) = "NAME" Then
                            NameIndex = nFields
                        End If
                        If UCase(sVal) = "EMAIL" Then
                            EmailIndex = nFields
                        End If
                        nFields = nFields + 1
                    End If
                Next
                ' Tratamiento para columnas fijas en la importacion
                sFIELDLIST = sFIELDLIST & "[companyId],"
                ' Sintaxis final sin la ultima coma y con los parentesis
                sFIELDLIST = "(" & Left(sFIELDLIST, Len(sFIELDLIST) - 1) & ")"


                Do
                    sLine = sr.ReadLine()
                    If sLine Is Nothing Then Exit Do
                    arrValues = sLine.Split(sCharSeparator)   'ControlChars.Tab
                    If arrValues(NameIndex).ToString.Length > 0 Then
                        ' Len(Nombre)>0...............
                        sVALUELIST = ""
                        For i = 0 To nFields - 1
                            sVal = ValidarValue(arrValues(i), arrHeaders(i))
                            sVALUELIST = sVALUELIST & "'" & sVal & "',"
                        Next
                        ' Tratamiento para columnas fijas en la importacion
                        sVALUELIST = sVALUELIST & lblCompanyId.Text & ","
                        ' Sintaxis final sin la ultima coma y con los parentesis
                        sVALUELIST = " VALUES(" & Left(sVALUELIST, Len(sVALUELIST) - 1) & ")"

                        If Not ExistRecordByNameOrEmail(arrValues(NameIndex), arrValues(EmailIndex)) Then
                            sSqlInsert = "INSERT INTO [" & sTable & "] " &
                                                    sFIELDLIST &
                                                    sVALUELIST
                            If InsertRecord(sSqlInsert) Then
                                nRecs = nRecs + 1
                            Else
                                nErrs = nErrs + 1
                            End If
                        Else
                            nErrs = nErrs + 1
                        End If
                    Else
                        nErrs = nErrs + 1
                    End If
                Loop
            End If
            sr.Close()

            lblMsg.Text = "'" & nRecs & "' records imported. <br/>" & nErrs & " no imported." & IIf(nErrs > 0, " See Requirements For Import", "")

            Return nRecs

        Catch ex As Exception

            lblMsg.Text = "Error " & ex.Message & vbCrLf

        End Try
    End Function
    Private Function ExistRecordByNameOrEmail(NameValue As String, EmailValue As String) As Boolean
        Dim bRet As Boolean

        NameValue = Replace(NameValue, "'", "`")
        Select Case cboDestino.SelectedValue
            Case "Contacts"
                Return LocalAPI.IsContactByEmail(EmailValue, lblCompanyId.Text)
            Case "Clients"
                bRet = LocalAPI.IsClientByName(NameValue, lblCompanyId.Text)
                If Not bRet And Len(EmailValue) > 0 Then
                    Return LocalAPI.IsClientEmail(EmailValue, lblCompanyId.Text)
                End If
            Case "Employees"
                Return LocalAPI.IsEmployeeEmail(EmailValue, lblCompanyId.Text)
            Case "Subconsultants"
                Return LocalAPI.IsSubConsultanEmail(EmailValue, lblCompanyId.Text)
        End Select

    End Function
    Private Function ValidarValue(sVal As String, sHeaderField As String) As String
        Dim sRes As String = sVal

        ' Maximo 80 caracteres
        sRes = Left(sRes, 80)

        ' Caracteres incompatibles con TSQL en cadenas
        sRes = Replace(sRes, "'", "`")

        Select Case UCase(sHeaderField)
            Case "PHONE", "FAX", "CELLULAR"
                ' Caracteres NO validos en telefonos
                sRes = Replace(sRes, " ", "")
                sRes = Replace(sRes, "-", "")
                sRes = Replace(sRes, "(", "")
                sRes = Replace(sRes, ")", "")
                sRes = Replace(sRes, "+", "")

            Case "EMAIL"
                ' Caracteres NO validos en Email
                sRes = Replace(sRes, " ", "")
                sRes = Replace(sRes, ";", "")
                sRes = LCase(sRes)

            Case "TYPE"
                ' Buscar TypeId 
                Select Case cboDestino.SelectedValue
                    Case "Clients", "Contacts"
                        sRes = LocalAPI.GetClientTypeId(sRes, lblCompanyId.Text)
                End Select

            Case "SUBTYPE"
                ' Buscar SubTypeId
                Select Case cboDestino.SelectedValue
                    Case "Clients", "Contacts"
                        sRes = LocalAPI.GetClientSubtypeId(sRes, lblCompanyId.Text)
                End Select

            Case "CLASS"
                ' Buscar TypeId 
                Select Case sVal
                    Case "Contacts"
                        sRes = LocalAPI.GetContactClassId(sRes)
                End Select

        End Select

        Return sRes
    End Function

    Private Function InsertRecord(sSqlInsert As String) As Boolean
        Try

            SqlDataSource1.InsertCommand = sSqlInsert
            SqlDataSource1.Insert()
            Return True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Private Sub TemplateLink()
        lnkSample.Text = cboDestino.SelectedValue & ".xls"
        lnkSample.NavigateUrl = "~/CSV/" & cboDestino.SelectedValue & ".xls"
    End Sub

    Protected Sub cboDestino_SelectedIndexChanged(ByVal sender As Object, ByVal e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs) Handles cboDestino.SelectedIndexChanged
        TemplateLink()
    End Sub
End Class

