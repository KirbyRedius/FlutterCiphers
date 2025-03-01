class AffineCipherAnalyzer {
  // Определяем класс для анализа аффинного шифра
  static const String alphabet =
      'абвгдежзийклмнопрстуфхцчшщьыъэюя'; // Создаем строку алфавита для шифра

  static const String topChars =
      'оеаинтсрвлкмдпуяыьгзбчйхжшюцщэфёъ'; // Создаем строку самых частых букв в русском языке

  // Расширенный алгоритм Евклида для нахождения НОД и коэффициентов
  static List<int> exGcd(int a, int b) {
    // Метод для нахождения НОД и коэффициентов
    if (a == 0) {
      // Если a равно 0
      return [b, 0, 1]; // Возвращаем НОД и коэффициенты
    }
    var result = exGcd(b % a, a); // Рекурсивно вызываем функцию
    int gcd = result[0]; // Получаем НОД
    int x1 = result[1]; // Получаем первый коэффициент
    int y1 = result[2]; // Получаем второй коэффициент
    int x = y1 - (b ~/ a) * x1; // Вычисляем новый коэффициент
    return [gcd, x, x1]; // Возвращаем НОД и коэффициенты
  }

  static int? modInverse(int a, int m) {
    // Метод для нахождения обратного элемента по модулю
    if (m <= 0) {
      // Проверяем, что модуль больше 0
      throw ArgumentError(
          "Модуль должен быть больше 0."); // Генерируем ошибку, если это не так
    }
    a = a % m; // Приводим a к диапазону [0, m)

    var result = exGcd(a, m); // Находим НОД и коэффициенты
    int gcd = result[0]; // Получаем НОД
    int x = result[1]; // Получаем коэффициент

    if (gcd != 1) {
      // Если НОД не равен 1
      return null; // Возвращаем null, так как обратный элемент не существует
    }
    return x % m; // Возвращаем обратный элемент по модулю
  }

  static String? affineDecrypt(
      String ciphertext, int a, int b, String alphabet) {
    // Метод для расшифровки сообщения
    int m = alphabet.length; // Получаем длину алфавита
    int? aInv = modInverse(a, m); // Находим обратный элемент a по модулю m

    if (aInv == null) {
      // Если обратный элемент не существует
      return null; // Возвращаем null
    }

    String decryptedText =
        ""; // Инициализируем строку для расшифрованного текста
    for (var char in ciphertext.runes) {
      // Проходим по каждому символу шифротекста
      String symbol = String.fromCharCode(char); // Преобразуем символ в строку
      if (alphabet.contains(symbol)) {
        // Проверяем, принадлежит ли символ алфавиту
        int y = alphabet.indexOf(symbol); // Находим индекс символа
        int x =
            (aInv * (y - b)) % m; // Вычисляем индекс расшифрованного символа
        decryptedText +=
            alphabet[x]; // Добавляем расшифрованный символ к результату
      } else {
        decryptedText +=
            symbol; // Если символ не в алфавите, добавляем его без изменений
      }
    }
    return decryptedText; // Возвращаем расшифрованный текст
  }

  static bool matchesCriteria(
      // Метод для проверки соответствия расшифрованного текста критериям
      String decryptedText,
      String ciphertext,
      Map<String, String> criteria) {
    for (var key in criteria.keys) {
      // Проходим по всем ключам в критериях
      if (ciphertext.contains(key)) {
        // Если шифротекст содержит ключ
        bool isValid = false; // Флаг для проверки соответствия
        for (int i = 0; i < decryptedText.length; i++) {
          // Проходим по каждому символу расшифрованного текста
          if (ciphertext[i] == key && // Если символ шифротекста равен ключу
              criteria[key]!.contains(decryptedText[i])) {
            // И соответствующий символ расшифрованного текста удовлетворяет критериям
            isValid = true; // Устанавливаем флаг в true
            break; // Выходим из цикла
          }
        }
        if (!isValid) {
          // Если не найдено соответствие
          return false; // Возвращаем false
        }
      }
    }
    return true; // Если все критерии выполнены, возвращаем true
  }

  static List<MapEntry<String, int>> mostFrequentLetters(String text, int n) {
    // Метод для нахождения самых частых букв
    Map<String, int> frequency = {}; // Создаем карту для частоты букв
    for (var char in text.runes) {
      // Проходим по каждому символу текста
      String symbol = String.fromCharCode(char); // Преобразуем символ в строку
      if (symbol.contains(RegExp(r'[a-zA-Zа-яА-Я]'))) {
        // Проверяем, является ли символ буквой
        frequency[symbol] =
            (frequency[symbol] ?? 0) + 1; // Увеличиваем счетчик частоты
      }
    }
    var sortedLetters = frequency.entries
        .toList() // Преобразуем частоты в список
      ..sort((a, b) =>
          b.value.compareTo(a.value)); // Сортируем по убыванию частоты
    return sortedLetters.take(n).toList(); // Возвращаем n самых частых букв
  }

  static List<String> bruteForceAffineDecrypt(
      String ciphertext, // Метод для переборной расшифровки
      {int depth = 2,
      int width = 3,
      String language = 'ru'}) {
    if (width < depth) {
      // Проверяем, что ширина не меньше глубины
      throw ArgumentError(
          "Ошибка: глубина поиска не может быть меньше ширины."); // Генерируем ошибку
    }
    if (depth < 2) {
      // Проверяем, что глубина не меньше 2
      throw ArgumentError(
          "Ошибка: глубина не может быть меньше 2."); // Генерируем ошибку
    }

    int m = alphabet.length; // Получаем длину алфавита

    var top = mostFrequentLetters(
        ciphertext, depth); // Находим самые частые буквы в шифротексте
    String permutation = topChars.substring(
        0, width); // Получаем подстроку частых букв для критериев

    Map<String, String> criteria =
        {}; // Создаем карту для критериев соответствия
    for (var entry in top) {
      // Проходим по самым частым буквам
      criteria[entry.key] =
          permutation; // Добавляем буквы и соответствующие критерии
    }

    List<String> results = []; // Инициализируем список для результатов

    for (int a = 1; a < m; a++) {
      // Перебираем значения a
      if (modInverse(a, m) != null) {
        // Проверяем, существует ли обратный элемент
        for (int b = 0; b < m; b++) {
          // Перебираем значения b
          String? decryptedText =
              affineDecrypt(ciphertext, a, b, alphabet); // Расшифровываем текст
          if (decryptedText != null && // Если расшифрованный текст не null
              matchesCriteria(decryptedText, ciphertext, criteria)) {
            // И он соответствует критериям
            results.add(
                decryptedText); // Добавляем расшифрованный текст к результатам
          }
        }
      }
    }
    return results; // Возвращаем список расшифрованных текстов
  }
}
