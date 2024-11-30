Sub CreateFunctionTable()

  Dim x1 As Double, x2 As Double, y1 As Double, y2 As Double
  Dim xStep As Double, yStep As Double
  Dim i As Long, j As Long
  Dim tbl As Worksheet
  Dim lastRow As Long, lastCol As Long


    x1 = InputBox("Input x1 value:")
    x2 = InputBox("Input x2 value:")
    y1 = InputBox("Input y1 value:")
    y2 = InputBox("Input y2 value:")
    xStep = InputBox("Input step for x value:")
    yStep = InputBox("Input step for y value:")

  ' Проверка корректности ввода
  If x1 >= x2 Or y1 >= y2 Or xStep <= 0 Or yStep <= 0 Then
    MsgBox "Некорректные входные данные. Проверьте значения x1, x2, y1, y2, xStep и yStep.", vbCritical
    Exit Sub
  End If

  ' Определение листа для таблицы (или создание нового)
  Set tbl = ThisWorkbook.Sheets("Лист") ' Имя существующего листа.
  If tbl Is Nothing Then
    Set tbl = ThisWorkbook.Sheets.Add(After:=ThisWorkbook.Sheets(ThisWorkbook.Sheets.Count))
    tbl.Name = "Таблица значений" ' Присваиваем имя
  End If

  ' Очистка существующей таблицы
  lastRow = tbl.Cells(Rows.Count, 1).End(xlUp).Row
  lastCol = tbl.Cells(1, Columns.Count).End(xlToLeft).Column
  tbl.Cells(1, 1).Resize(lastRow, lastCol).ClearContents


  ' Заголовки
  tbl.Cells(1, 1).Value = "x\y"
  For j = 1 To (y2 - y1) / yStep + 1
      tbl.Cells(1, j + 1).Value = Format(y1 + (j - 1) * yStep, "0.00")
  Next j

  ' Заполняем таблицу значениями функции
  For i = 1 To (x2 - x1) / xStep + 1
    tbl.Cells(i + 1, 1).Value = Format(x1 + (i - 1) * xStep, "0.00")
    For j = 1 To (y2 - y1) / yStep + 1
      tbl.Cells(i + 1, j + 1).Value = MyFunction(x1 + (i - 1) * xStep, y1 + (j - 1) * yStep)
    Next j
  Next i


End Sub


' Определение функции. Измените эту функцию на свою.
Function MyFunction(x As Double, y As Double) As Double
    MyFunction = x ^ 2 + y ^ 2
End Function
