import 'dart:math';

class SimplePermutationCipher {
  static List<int> encryptBytes(List<int> bytes, List<int> key) {
    int blockSize = key.length;
    List<int> encryptedBytes = [];
    for (int i = 0; i < bytes.length; i += blockSize) {
      List<int> block = bytes.sublist(i, min(i + blockSize, bytes.length));
      List<int> permutedBlock =
          List.generate(blockSize, (index) => block[key[index] - 1]);
      encryptedBytes.addAll(permutedBlock);
    }
    return encryptedBytes;
  }

  static List<int> decryptBytes(List<int> bytes, List<int> key) {
    int blockSize = key.length;
    List<int> decryptedBytes = [];
    for (int i = 0; i < bytes.length; i += blockSize) {
      List<int> block = bytes.sublist(i, min(i + blockSize, bytes.length));
      List<int> inverseKey =
          List.generate(blockSize, (index) => key.indexOf(index + 1) + 1);
      List<int> permutedBlock =
          List.generate(blockSize, (index) => block[inverseKey[index] - 1]);
      decryptedBytes.addAll(permutedBlock);
    }
    return decryptedBytes;
  }
}
