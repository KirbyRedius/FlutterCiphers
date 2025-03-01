import 'dart:math';

class TextEntropyCalculator {
  /// Очищает текст: удаляет пробелы, знаки препинания и приводит к нижнему регистру.
  static String cleanText(String text) {
    // Регулярное выражение для удаления всех символов, кроме букв русского алфавита.
    RegExp regex = RegExp(r'[^а-яА-Я]');
    // Удаляем все символы, не соответствующие регулярному выражению, и приводим текст к нижнему регистру.
    return text.replaceAll(regex, '').toLowerCase();
  }

  /// Вычисляет энтропию Hk для заданного k.
  static double calculateEntropy(String text, int k) {
    // Создаем карту (Map) для подсчета частот k-грамм.
    // Ключ — k-грамма, значение — количество её вхождений в тексте.
    Map<String, int> frequencyMap = {};

    // Подсчитываем частоты k-грамм.
    // Проходим по тексту, начиная с первого символа и до (длина текста - k).
    for (int i = 0; i <= text.length - k; i++) {
      // Выделяем k-грамму (подстроку длины k).
      String kGram = text.substring(i, i + k);
      // Увеличиваем счетчик для данной k-граммы в карте.
      // Если k-грамма уже есть в карте, увеличиваем её значение на 1, иначе устанавливаем значение 1.
      frequencyMap[kGram] = (frequencyMap[kGram] ?? 0) + 1;
    }

    // Вычисляем энтропию Hk.
    double entropy = 0.0;
    // Общее количество k-грамм в тексте.
    int totalKgrams = text.length - k + 1;

    // Проходим по всем k-граммам в карте.
    frequencyMap.forEach((kGram, count) {
      // Вычисляем вероятность p(x) для текущей k-граммы.
      double probability = count / totalKgrams;
      // Добавляем вклад текущей k-граммы в энтропию по формуле: -p(x) * log2(p(x)).
      entropy -= probability * log(probability) / ln2;
    });

    // Возвращаем вычисленное значение энтропии.
    return entropy;
  }

  /// Вычисляет Hk/k для k от 1 до maxK и возвращает список результатов.
  static List<double> calculateHkOverK(String text, int maxK) {
    // Создаем список для хранения результатов Hk/k.
    List<double> results = [];

    // Проходим по всем значениям k от 1 до maxK.
    for (int k = 1; k <= maxK; k++) {
      // Вычисляем энтропию Hk для текущего k.
      double hk = calculateEntropy(text, k);
      // Вычисляем Hk/k.
      double hkOverK = hk / k;
      // Добавляем результат в список.
      results.add(hkOverK);
    }

    // Возвращаем список результатов.
    return results;
  }
}
