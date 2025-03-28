class LFSR {
  int register; // стартовое значение сдвигового регистра
  List<int> taps; // позиции отводов для обратной связи

  LFSR({required this.register, required this.taps});

  int nextBit() {
    // формируем бит обратной связи
    int nextBit = 0;
    for (int pos in taps) {
      nextBit ^= (register >> pos) & 1; // применяем XOR к выбранным битам
    }
    // выполняем сдвиг и добавление нового бита
    register = (nextBit << 7) | (register >> 1);
    return register & 1; // возвращаем младший бит регистра
  }

  int generateByte() {
    int output = 0;
    for (int i = 0; i < 8; i++) {
      output = (output << 1) | nextBit();
    }
    return output;
  }
}

void main() {
  int seed = 0xB5; // начальное состояние регистра (0b10110101)
  // инициализация с отводами 0, 5, 7
  var lfsr = LFSR(register: seed, taps: [0, 5, 7]);

  // счетчики для анализа последовательности
  int evenNumbers = 0;
  int oddNumbers = 0;
  int zerosBits = 0;
  int onesBits = 0;
  int sequenceLength = 0;

  // основной цикл генерации и анализа
  while (true) {
    int currentValue = 0;
    int bitOutput = 0;

    // формирование 8-битного числа
    // путем последовательного сдвига
    for (int i = 0; i < 8; i++) {
      bitOutput = lfsr.nextBit();
      currentValue = (currentValue << 1) | bitOutput;
    }

    sequenceLength++;

    // подсчет статистики по четности
    if (currentValue % 2 == 0) {
      evenNumbers++;
    } else {
      oddNumbers++;
    }

    // анализ битового состава
    String binaryString = currentValue.toRadixString(2).padLeft(8, '0');
    zerosBits += binaryString.split('0').length - 1;
    onesBits += binaryString.split('1').length - 1;

    // проверка завершения периода
    if (lfsr.register == seed) {
      break;
    }
  }

  // вычисление полной длины в битах
  int totalBits = sequenceLength * 8;

  print('\nСтатистика генератора:');
  print('Длина периода в битах: $totalBits');
  print('Четных чисел: $evenNumbers');
  print('Нечетных чисел: $oddNumbers');
  print('Количество нулей: $zerosBits');
  print('Количество единиц: $onesBits');
}
