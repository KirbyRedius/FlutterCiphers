import 'dart:collection';

const String alphabet = "абвгдежзийклмнопрстуфхцчшщьыъэюя";

const Map<String, double> letterFrequencies = {
  '-': 0.175,
  'о': 0.090,
  'е': 0.072,
  'а': 0.062,
  'и': 0.062,
  'т': 0.053,
  'н': 0.053,
  'с': 0.045,
  'р': 0.040,
  'в': 0.038,
  'л': 0.035,
  'к': 0.028,
  'м': 0.026,
  'д': 0.025,
  'п': 0.023,
  'у': 0.021,
  'я': 0.018,
  'ы': 0.016,
  'з': 0.016,
  'ь': 0.014,
  'б': 0.014,
  'г': 0.013,
  'ч': 0.012,
  'й': 0.010,
  'х': 0.009,
  'ж': 0.007,
  'ю': 0.006,
  'ш': 0.006,
  'ц': 0.004,
  'щ': 0.003,
  'э': 0.003,
  'ф': 0.002
};

int? modInverse(int a, int m) {
  for (int x = 1; x < m; x++) {
    if ((a * x) % m == 1) {
      return x;
    }
  }
  return null;
}

String? affineDecrypt(String ciphertext, int a, int b) {
  int m = alphabet.length;
  int? aInv = modInverse(a, m);

  if (aInv == null) return null;

  String decryptedText = "";
  for (var char in ciphertext.split('')) {
    int y = alphabet.indexOf(char);
    if (y != -1) {
      int x = (aInv * (y - b)) % m;
      if (x < 0) x += m;
      decryptedText += alphabet[x];
    } else {
      decryptedText += char;
    }
  }
  return decryptedText;
}

bool matchesCriteria(
    String decryptedText, String ciphertext, Map<String, String> criteria) {
  for (var key in criteria.keys) {
    if (ciphertext.contains(key)) {
      if (!decryptedText.split('').asMap().entries.any((entry) {
        int i = entry.key;
        String char = entry.value;
        return ciphertext[i] == key && criteria[key]!.contains(char);
      })) {
        return false;
      }
    }
  }
  return true;
}

void bruteForceAffineDecrypt(String ciphertext) {
  int m = alphabet.length;

  Map<String, int> alph = {};
  for (var symb in ciphertext.split('')) {
    alph[symb] = (alph[symb] ?? 0) + 1;
  }

  var sortedList =
      SplayTreeMap<String, int>.from(alph, (a, b) => alph[b]! - alph[a]!)
          .keys
          .toList();
  print(sortedList);
  sortedList = sortedList.take(2).toList();

  List<String> highLetters = letterFrequencies.keys
      .where((letter) => ciphertext.contains(letter))
      .take(2)
      .toList();
  String sootvLetters = highLetters.join();

  print(sootvLetters);

  Map<String, String> criteria = {sortedList[0]: 'еа', sortedList[1]: 'еа'};

  print(criteria);

  for (int a = 1; a < m; a++) {
    if (modInverse(a, m) != null) {
      for (int b = 0; b < m; b++) {
        String? decryptedText = affineDecrypt(ciphertext, a, b);
        if (decryptedText != null &&
            matchesCriteria(decryptedText, ciphertext, criteria)) {
          print("Ключи (a=$a, b=$b)\t->\t$decryptedText");
        }
      }
    }
  }
}
