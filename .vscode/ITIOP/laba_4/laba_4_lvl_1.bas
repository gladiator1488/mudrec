Sub CreateFunctionTable()

  Dim x1 As Double, x2 As Double, y1 As Double, y2 As Double
  Dim numXSteps As Long, numYSteps As Long
  Dim xStep As Double, yStep As Double
  Dim i As Long, j As Long
  Dim tbl As Worksheet
  Dim lastRow As Long, lastCol As Long
  Dim chartTitle As String

  x1 = InputBox("Input x1 value:")
  x2 = InputBox("Input x2 value:")
  y1 = InputBox("Input y1 value:")
  y2 = InputBox("Input y2 value:")
  numXSteps = InputBox("Enter the number of steps for x:")
  numYSteps = InputBox("Enter the number of steps for y:")
  chartTitle = InputBox("Enter the title for the chart:")


  ' Проверка корректности ввода
  If x1 >= x2 Or y1 >= y2 Or numXSteps <= 0 Or numYSteps <= 0 Then
    MsgBox "Некорректные входные данные. Проверьте значения x1, x2, y1, y2, numXSteps и numYSteps.", vbCritical
    Exit Sub
  End If

  ' Calculate steps based on number of steps
  xStep = (x2 - x1) / numXSteps
  yStep = (y2 - y1) / numYSteps


  ' Определение листа для таблицы (или создание нового)
  Set tbl = ThisWorkbook.Sheets("Лист1") ' Имя существующего листа.
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
  For j = 0 To numYSteps
    tbl.Cells(1, j + 2).Value = Format(y1 + j * yStep, "0.00")
  Next j

  ' Заполняем таблицу значениями функции
  For i = 0 To numXSteps
    tbl.Cells(i + 2, 1).Value = Format(x1 + i * xStep, "0.00")
    For j = 0 To numYSteps
      tbl.Cells(i + 2, j + 2).Value = MyFunction(x1 + i * xStep, y1 + j * yStep)
    Next j
  Next i

  ' Создание диаграммы в виде поверхности
  Dim cht As Chart
  Set cht = tbl.Parent.Charts.Add
  With cht
    .ChartType = xlSurface
    .SetSourceData Source:=tbl.Range("A1").CurrentRegion
    .HasTitle = True
    .chartTitle.Text = chartTitle
  End With

End Sub

' Определение функции. Измените эту функцию на свою.
Function MyFunction(x As Double, y As Double) As Double
  MyFunction = x ^ 2 + y ^ 2
End Function
