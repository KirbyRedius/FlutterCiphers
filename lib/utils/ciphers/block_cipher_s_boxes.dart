import 'dart:io';

class SBlockCipher {
  // S-блок S4
  static const List<List<int>> sBlock = [
    [7, 13, 14, 3, 0, 6, 9, 10, 1, 2, 8, 5, 11, 12, 4, 15],
    [13, 8, 11, 5, 6, 15, 0, 3, 4, 7, 2, 12, 1, 10, 14, 9],
    [10, 6, 9, 0, 12, 11, 7, 13, 15, 1, 3, 14, 5, 2, 8, 4],
    [3, 15, 0, 6, 10, 1, 13, 8, 9, 4, 5, 11, 12, 7, 2, 14]
  ];

  // Метод для шифрования
  static int encrypt(int block, int a, int b) {
    // Получаем биты a и b для определения строки
    int row = ((block >> (6 - a)) & 1) << 1 | ((block >> (6 - b)) & 1);

    // Получаем оставшиеся 4 бита для определения столбца
    int col = (block >> 2) & 0xF;

    // Возвращаем значение из S-блока
    return sBlock[row][col];
  }

  // Метод для расшифрования
  static int decrypt(int cipher, int a, int b) {
    // Поиск соответствующего 6-битного блока в S-блоке
    for (int row = 0; row < 4; row++) {
      for (int col = 0; col < 16; col++) {
        if (sBlock[row][col] == cipher) {
          // Возвращаем 6-битный блок
          return (row << 4) | col;
        }
      }
    }
    return -1; // Если не найдено
  }

  // Метод для шифрования файла
  static Future<void> encryptFile(
      String inputFilePath, String outputFilePath, int a, int b) async {
    // Чтение байтов из файла
    List<int> fileBytes = await File(inputFilePath).readAsBytes();

    // Результат шифрования
    List<int> encryptedBytes = [];

    // Обработка каждого байта
    for (int byte in fileBytes) {
      // Разделяем байт на два 6-битных блока (поскольку 1 байт = 8 бит)
      int block1 = (byte >> 2) & 0x3F; // Первые 6 бит
      int block2 = byte & 0x3F; // Последние 6 бит

      // Шифруем каждый блок
      int encryptedBlock1 = encrypt(block1, a, b);
      int encryptedBlock2 = encrypt(block2, a, b);

      // Собираем результат в байты
      encryptedBytes.add((encryptedBlock1 << 4) | (encryptedBlock2 & 0xF));
    }

    // Запись зашифрованных байтов в файл
    await File(outputFilePath).writeAsBytes(encryptedBytes);
  }

  // Метод для расшифрования файла
  static Future<void> decryptFile(
      String inputFilePath, String outputFilePath, int a, int b) async {
    // Чтение байтов из файла
    List<int> fileBytes = await File(inputFilePath).readAsBytes();

    // Результат расшифрования
    List<int> decryptedBytes = [];

    // Обработка каждого байта
    for (int byte in fileBytes) {
      // Разделяем байт на два 4-битных блока (поскольку шифр-текст = 4 бита)
      int block1 = (byte >> 4) & 0xF; // Первые 4 бита
      int block2 = byte & 0xF; // Последние 4 бита

      // Расшифровываем каждый блок
      int decryptedBlock1 = decrypt(block1, a, b);
      int decryptedBlock2 = decrypt(block2, a, b);

      // Собираем результат в байты
      decryptedBytes.add((decryptedBlock1 << 6) | (decryptedBlock2 & 0x3F));
    }

    // Запись расшифрованных байтов в файл
    await File(outputFilePath).writeAsBytes(decryptedBytes);
  }
}
