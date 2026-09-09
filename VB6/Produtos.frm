Private Sub UserForm_Initialize()
    With ListView1
        .View = 3
        .Gridlines = True
        .FullRowSelect = True
        
        .ColumnHeaders.Clear
        .ColumnHeaders.Add , , "Nome do Produto", 500
        .ColumnHeaders.Add , , "Preço (R$)", 150
    End With
End Sub

Private Sub cmdCarregarAPI_Click()
    Dim http As Object
    Dim url As String
    Dim jsonResponse As String
    
    Set http = CreateObject("MSXML2.ServerXMLHTTP.6.0")
    url = "https://fakestoreapi.com/products"
    
    On Error GoTo ErrorHandler
    
    http.Open "GET", url, False
    http.setRequestHeader "Content-Type", "application/json"
    http.send
    
    If http.Status = 200 Then
        jsonResponse = http.responseText
        
        Call PreencherListViewComJSON(jsonResponse)
        MsgBox "Dados carregados com sucesso!", vbInformation, "Sucesso"
    Else
        MsgBox "Erro na API. Código: " & http.Status, vbCritical, "Erro"
    End If
    
    Set http = Nothing
    Exit Sub

ErrorHandler:
    MsgBox "Erro de conexão: " & Err.Description, vbCritical, "Erro de Sistema"
    Set http = Nothing
End Sub

Private Sub PreencherListViewComJSON(ByVal jsonString As String)
    Dim regEx As Object
    Dim matches As Object
    Dim m As Object
    Dim item As Object
    Dim nome As String
    Dim preco As String
    
    Set regEx = CreateObject("VBScript.RegExp")
    regEx.Global = True
    regEx.IgnoreCase = True
    
    regEx.Pattern = """title"":""([^""]+)"".*?""price"":([0-9\.]+)"
    
    Set matches = regEx.Execute(jsonString)
    
    ListView1.ListItems.Clear
    
    For Each m In matches
        nome = m.SubMatches(0)
        preco = m.SubMatches(1)
        
        Set item = ListView1.ListItems.Add(, , nome)
        
        preco = Replace(preco, ".", ",")
        item.SubItems(1) = FormatCurrency(preco)
    Next m
    
    Set regEx = Nothing
End Sub

