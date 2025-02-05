// В аффинном шифре шифрование происходит посимвольно с помощью
// преобразования:

// Ek(M)=a*M+b mod m,

// где a - число взаимно простое с m, b - любое целое, M - код символа. Ключом шифрования
// служит пара чисел k=(a,b).
// Расшифрование происходит с помощью преобразования
// Dk(C)=a-1(C-b) mod m.

class AffineCipher {
  static List<int> encryptBytes(List<int> bytes, int a, int b, int m) {
    return bytes.map((byte) {
      return ((a * byte + b) % m);
    }).toList();
  }

  static List<int> decryptBytes(List<int> bytes, int a, int b, int m) {
    int aInverse = modInverse(a, m);
    return bytes.map((byte) {
      return ((aInverse * (byte - b)) % m);
    }).toList();
  }

  // нахождение обратного элемента
  static int modInverse(int a, int m) {
    for (int x = 1; x < m; x++) {
      if ((a * x) % m == 1) {
        return x;
      }
    }
    return 1; // обратный элемент не найден
  }
}
