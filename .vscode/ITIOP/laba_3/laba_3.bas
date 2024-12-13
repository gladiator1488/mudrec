Sub InsertTableWithHeader()
    Dim numRows As Integer
    Dim numCols As Integer
    Dim tableName As String
    Dim tbl As Table
    Dim doc As Document
    Dim tableCount As Integer
    
    Set doc = ActiveDocument
    tableCount = doc.Tables.Count + 1  ' Define table number as current + 1

    tableName = InputBox("Enter the table name:")
    numRows = InputBox("Enter the number of rows for the table:")
    numCols = InputBox("Enter the number of columns for the table:")

    ' Insert table title
    doc.Content.InsertParagraphAfter
    doc.Paragraphs(doc.Paragraphs.Count).Range.Text = "Table " & tableCount & ". " & tableName
    
    doc.Content.InsertParagraphAfter

    ' Insert table
    Set tbl = doc.Tables.Add(doc.Paragraphs(doc.Paragraphs.Count).Range, numRows, numCols)
    
    tbl.AutoFitBehavior wdAutoFitWindow


    ' Number the first column
    Dim i As Integer
    For i = 1 To numRows
        tbl.Cell(i, 1).Range.Text = i
    Next i

    ' Set borders to black
    With tbl.Borders
        .InsideColor = RGB(0, 0, 0)
        .OutsideColor = RGB(0, 0, 0)
        .InsideLineStyle = wdLineStyleSingle
        .OutsideLineStyle = wdLineStyleSingle
    End With

End Sub
