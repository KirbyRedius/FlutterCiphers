class LinearCongruentialGenerator {
  static String solve({
    required int a,
    required int c,
    required int m,
    required int x0,
  }) {
    int periodLengthInBits = 0;
    int evenCount = 0;
    int oddCount = 0;
    int zeroCount = 0;
    int oneCount = 0;

    int currentX = x0;
    bool periodFound = false;
    int firstX = x0;

    while (!periodFound) {
      // Генерация следующего числа
      currentX = (a * currentX + c) % m;

      // Подсчёт чётных/нечётных
      if (currentX % 2 == 0) {
        evenCount++;
      } else {
        oddCount++;
      }

      // Подсчёт нулей/единиц в битовом представлении
      String binary = currentX.toRadixString(2).padLeft(m.bitLength, '0');
      for (int i = 0; i < binary.length; i++) {
        if (binary[i] == '0') {
          zeroCount++;
        } else {
          oneCount++;
        }
      }

      // Увеличиваем длину периода в битах на количество битов в текущем числе
      periodLengthInBits += binary.length;

      // Проверка на завершение периода
      if (currentX == firstX) {
        periodFound = true;
      }
    }

    // Формирование результата
    String result = """
    Параметры генератора: a = $a, c = $c, m = $m, x0 = $x0
    Длина периода: $periodLengthInBits бит
    Количество четных чисел: $evenCount
    Количество нечетных чисел: $oddCount
    Количество нулей в битовом представлении: $zeroCount
    Количество единиц в битовом представлении: $oneCount
    """;

    return result;
  }
}
