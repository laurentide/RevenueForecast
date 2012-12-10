'REVENUE FORECAST
'Module
'description: Ce module regroupe plusieurs fonctions et procédures utilent pour tous les formulaires
'Par: Francis Gauthier
'date: 27 juillet 2007
'contact: f.gauthier@cgodin.qc.ca

Imports System.Data.OleDb
Imports System.Data.SqlClient
Module _Module
    Public Function EstManager(ByVal username As String) As Boolean
        Dim strReq As String
        Dim dtTable As New DataTable
        Dim reponse As Boolean

        strReq = "Select E.name from tblmanager AS M INNER JOIN tblemployee AS E ON M.employeeid = E.employeeid where E.UserName like '" & username & "'"
        dtTable = LectureBD(strReq)

        If dtTable.Rows.Count > 0 Then
            reponse = True
        Else
            reponse = False
        End If

        Return reponse
    End Function

    Public Function accesSalaries(ByVal username As String) As Boolean
        Dim reponse As Boolean

        reponse = True
        If username = "LauraS" Or username = "AnnieLA" Or username = "AnnS" Or username = "JeffR" Or username = "DyanneN" Or username = "MattieuB" Or username = "dharvey" Then
            reponse = False
        End If

        Return reponse
    End Function

    Function setGuillemets(ByVal strparametre As String) As String
        Dim strreponse As String
        Dim intx As Integer

        'Cette fonction empeche à SQL de planter si jamais une personne se nomme par exemple "Guillemet, J'enaiun"
        For intx = 0 To strparametre.Length - 1
            If strparametre.Chars(intx) = "'" Then
                strreponse = strreponse & strparametre.Chars(intx)
            End If
            strreponse = strreponse & strparametre.Chars(intx)
        Next

        Return strreponse

    End Function

    Public Function Arrondir(ByVal Valeur As Double) As Double

        'arrondi a 2 chiffres après la virgule
        Return (Math.Round(Valeur * 100)) / 100

    End Function

    Public Sub EcritureBD(ByVal strReq As String)
        Dim cmdConn As New OleDbCommand
        Dim strConn As String = "Provider=SQLOLEDB;Data Source=localhost;Initial Catalog=LCLAdmin;User ID=LCLADMIN;Password=test"
        Dim dbConn As New OleDbConnection(strConn)

        dbConn.Open()
        cmdConn.Connection = dbConn
        cmdConn.CommandText = strReq
        cmdConn.ExecuteNonQuery()
        dbConn.Close()
    End Sub

    Public Function LectureBD(ByVal strReq As String) As DataTable
        Dim dtTable As New DataTable
        Dim cmdTable As SqlCommand
        Dim sqlAdapter As SqlDataAdapter
        Dim strConn As String = "Server=localhost;uid=LCLADMIN;password=test;database=LCLAdmin"
        Dim dbConn As New SqlConnection(strConn)

        cmdTable = New SqlCommand(strReq, dbConn)
        sqlAdapter = New SqlDataAdapter(cmdTable)
        sqlAdapter.Fill(dtTable)

        Return dtTable
    End Function

    Public Function LectureAS400(ByVal strReq As String) As DataTable
        'Cette fonction pourrait etre utile un jour....qui sait
        Dim dtTable As New DataTable
        Dim myAS400Connection As New OleDb.OleDbConnection
        Dim myAS400Command As New OleDb.OleDbCommand

        myAS400Connection.ConnectionString = "Provider=IBMDA400; Data source=AS820; User Id=vbuser; Password=vbuser"

        myAS400Connection.Open()
        myAS400Connection.Close()

        Return dtTable
    End Function

    Public Function EstAdmin(ByVal username As String) As Boolean
        Dim reponse As Boolean = False
        If username = "DeanW" Or username = "ClaireD" Or username = "FrancisG" Or username = "d2dadmin" Or username = "Duc-DuyN" Then
            reponse = True
        End If
        Return reponse
    End Function

    Public Function Isnull(ByVal texte As String) As String
        'Fonction identique à ISNULL("",0) en SQL
        Dim reponse As String = "0"
        If texte <> "" Then
            reponse = texte
        End If
        Return reponse
    End Function

    Public Function GetFY(ByVal month As Integer) As Integer
        'Fonction identique à ISNULL("",0) en SQL
        Dim reponse As Integer
        reponse = Year(Now())

        If month >= 10 Then
            reponse += 1
        End If
        Return reponse
    End Function

End Module
