class LFSR {
  int _register; // регистр сдвига (начальное заполнение)
  final List<int>
  _taps; // отводы для обратной связи (биты, которые влияют на новый бит)

  // Конструктор
  LFSR(int initialValue, List<int> taps)
    : _register = initialValue,
      _taps = taps;

  // функция для генерации следующего бита в последовательности lfsr
  int next() {
    // переменная для хранения нового бита обратной связи
    int feedback = 0;

    // проходим по всем отводам (битам, которые влияют на обратную связь)
    for (int tap in _taps) {
      // выполняем операцию xor между текущим значением feedback и значением бита на позиции tap
      // (_register >> tap) сдвигает регистр вправо на tap позиций, чтобы получить нужный бит
      // & 1 извлекает младший бит (бит на позиции tap)
      feedback ^= (_register >> tap) & 1;
    }

    // сдвигаем регистр вправо на один бит, чтобы освободить место для нового бита
    // (_register >> 1) выполняет сдвиг вправо
    // (feedback << 7) добавляет новый бит обратной связи в старший разряд (8-битный регистр)
    _register = (_register >> 1) | (feedback << 7);

    // возвращаем младший бит регистра как выходной бит последовательности
    // _register & 1 извлекает младший бит
    return _register & 1;
  }

  // генерация последовательности заданной длины
  List<int> generateSequence(int length) {
    List<int> sequence = [];
    for (int i = 0; i < length; i++) {
      sequence.add(next());
    }
    return sequence;
  }

  // получение текущего состояния регистра
  // (вообще это просто для инкапсуляции в dart)
  int get register => _register;
}

void main() {
  // инициализация LFSR с начальным значением и отводами
  LFSR lfsr = LFSR(0x7F, [0, 5, 7]); // начальное значение 0x7F
  // отводы (taps) 0, 5, 7 так как у меня в варианте "1 + x + x^6 + x^8"

  // Генерация последовательности
  List<int> sequence = [];
  int period = 0;
  int initialRegister = lfsr.register;

  do {
    // добавляем текущее состояние регистра в последовательность
    sequence.add(lfsr.register);

    // генерируем следующий бит и обновляем состояние регистра
    lfsr.next();

    // увеличиваем счетчик периода на 1
    period++;

    // проверяем, вернулся ли регистр в начальное состояние
    // или достигнут максимальный период (256 шагов)
  } while (lfsr.register != initialRegister && period < 256);

  // вывод результатов
  print("Сгенерированная последовательность: $sequence");
  print("Длина периода: $period бит");

  // Подсчет четных и нечетных чисел в одном периоде
  int evenCount = 0;
  int oddCount = 0;
  for (int num in sequence) {
    if (num % 2 == 0) {
      evenCount++;
    } else {
      oddCount++;
    }
  }
  print("Количество четных чисел: $evenCount");
  print("Количество нечетных чисел: $oddCount");

  // Подсчет нулей и единиц в битовом представлении
  int zeroCount = 0;
  int oneCount = 0;
  for (int num in sequence) {
    for (int i = 0; i < 8; i++) {
      if ((num >> i) & 1 == 1) {
        oneCount++;
      } else {
        zeroCount++;
      }
    }
  }
  print("Количество нулей: $zeroCount");
  print("Количество единиц: $oneCount");
}
