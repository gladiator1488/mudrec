Sub NewMacros()
Dim tableName As String
    Dim numRows As Integer
    Dim numCols As Integer
    Dim tableNumber As Integer
    Dim doc As Document
    Dim rng As Range
    Dim tbl As Table

    ' Получить активный документ
    Set doc = ActiveDocument

    ' Запросить у пользователя название таблицы, количество строк и столбцов
    tableName = InputBox("Введите название таблицы:", "Название таблицы")
    numRows = InputBox("Введите количество строк:", "Количество строк")
    numCols = InputBox("Введите количество столбцов:", "Количество столбцов")

    ' Определить номер таблицы
    tableNumber = doc.Tables.Count + 1

    ' Вставить заголовок таблицы
    Set rng = Selection.Range
    rng.InsertBefore "Таблица " & tableNumber & ". " & tableName & vbCr
    rng.Collapse Direction:=wdCollapseEnd

    ' Вставить таблицу
    Set tbl = doc.Tables.Add(Range:=rng, numRows:=numRows, NumColumns:=numCols)

    ' Автоматическая настройка ширины столбцов
    tbl.AutoFitBehavior wdAutoFitWindow

    ' Нумерация первого столбца
    Dim i As Integer
    For i = 1 To numRows
        tbl.Cell(i, 1).Range.Text = i
    Next i

    ' Изменение цвета рамок на черный:
    With tbl.Borders(wdBorderTop)
        .LineStyle = wdLineStyleSingle
        .Color = wdColorBlack
        .Visible = True
    End With

    With tbl.Borders(wdBorderBottom)
        .LineStyle = wdLineStyleSingle
        .Color = wdColorBlack
        .Visible = True
    End With

    With tbl.Borders(wdBorderLeft)
        .LineStyle = wdLineStyleSingle
        .Color = wdColorBlack
        .Visible = True
    End With

    With tbl.Borders(wdBorderRight)
        .LineStyle = wdLineStyleSingle
        .Color = wdColorBlack
        .Visible = True
    End With

    With tbl.Borders(wdBorderInsideH)
        .LineStyle = wdLineStyleSingle
        .Color = wdColorBlack
        .Visible = True
    End With

    With tbl.Borders(wdBorderInsideV)
        .LineStyle = wdLineStyleSingle
        .Color = wdColorBlack
        .Visible = True
    End With

    ' Переместить курсор за таблицу
    tbl.Range.Collapse Direction:=wdCollapseEnd
    tbl.Range.Select


End Sub
