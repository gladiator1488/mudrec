def decimal_to_base(num, base):
  """
  Переводит десятичное число в другую систему счисления.

  Args:
    num: Десятичное число.
    base: Основание новой системы счисления.

  Returns:
    Строка, представляющая число в новой системе счисления.
  """

  if int(num) == num:
    return int_to_base(int(num), base)
  else:
    integer_part = int(num)
    fractional_part = num - integer_part
    integer_part_result = int_to_base(integer_part, base)
    fractional_part_result = float_to_base(fractional_part, base)
    return integer_part_result + "." + fractional_part_result


def int_to_base(num, base):
  if num == 0:
    return "0"

  digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  result = ""
  while num > 0:
    remainder = num % base
    result = digits[remainder] + result
    num //= base
  return result


def float_to_base(num, base):
  if num == 0:
    return "0"
  digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  result = ""
  for i in range(10):
    num *= base
    whole_part = int(num)
    result += digits[whole_part]
    num -= whole_part
    if num == 0:
      break
  return result

# Пример использования
decimal_number = 12.375
binary_number = decimal_to_base(decimal_number, 2)
print(f"Двоичное: {binary_number}")

decimal_number = 10.5
hexadecimal_number = decimal_to_base(decimal_number, 16)
print(f"Шестнадцатеричное: {hexadecimal_number}")


def float_to_hex4(number):
    number = float(number)