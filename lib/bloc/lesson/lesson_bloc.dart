import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cryptography_methods/utils/ciphers/affine.dart';
import 'package:cryptography_methods/utils/ciphers/affine_decrypt.dart';
import 'package:cryptography_methods/utils/ciphers/block_cipher_s_boxes.dart';
import 'package:cryptography_methods/utils/ciphers/feistel_cipher.dart';
import 'package:cryptography_methods/utils/ciphers/simple_permutation.dart';
import 'package:cryptography_methods/constants/constants.dart';
import 'package:cryptography_methods/utils/text_entropy_calculator.dart';
import 'package:file_picker/file_picker.dart';

part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  LessonBloc() : super(LessonInitialState()) {
    on<LessonExitEvent>(_lessonExit);

    on<Lesson1LoadEncryptEvent>(_lesson1encrypt);
    on<Lesson1LoadDecryptEvent>(_lesson1decrypt);

    on<Lesson2LoadEncryptEvent>(_lesson2encrypt);
    on<Lesson2LoadDecryptEvent>(_lesson2decrypt);

    on<Lesson4LoadDecryptEvent>(_lesson4decrypt);

    on<Lesson5LoadEncryptEvent>(_lesson5encrypt);
    on<Lesson5LoadDecryptEvent>(_lesson5decrypt);

    on<Lesson6LoadEncryptEvent>(_lesson6encrypt);
    on<Lesson6LoadDecryptEvent>(_lesson6decrypt);

    on<Lesson7LoadEvent>(_lesson7);
  }

  Future<void> _lessonExit(
      LessonExitEvent event, Emitter<LessonState> emit) async {
    emit(LessonInitialState());
  }

  Future<void> _lesson1encrypt(
    Lesson1LoadEncryptEvent event,
    Emitter<LessonState> emit,
  ) async {
    emit(LessonLoadingState());
    try {
      List<int> fileBytes = await File(event.file.path!).readAsBytes();
      List<int> encryptedContent = AffineCipher.encryptBytes(
          fileBytes, Constants.affineKa, Constants.affineKb, Constants.affineM);
      String newFileName = '${event.file.path}.encrypted';
      await File('${event.file.path}.encrypted').writeAsBytes(encryptedContent);
      emit(LessonSuccessState(
          result: "Файл успешно зашифрован\nНовый файл: $newFileName"));
    } catch (e) {
      emit(LessonFailureState());
    }
  }

  Future<void> _lesson1decrypt(
    Lesson1LoadDecryptEvent event,
    Emitter<LessonState> emit,
  ) async {
    emit(LessonLoadingState());
    try {
      List<int> fileBytes = await File(event.file.path!).readAsBytes();
      List<int> encryptedContent = AffineCipher.decryptBytes(
          fileBytes, Constants.affineKa, Constants.affineKb, Constants.affineM);
      String newFileName = '${event.file.path}.decrypted';
      await File('${event.file.path}.decrypted').writeAsBytes(encryptedContent);
      emit(LessonSuccessState(result: "Файл успешно дешифрован\n$newFileName"));
    } catch (e) {
      emit(LessonFailureState());
    }
  }

  Future<void> _lesson2encrypt(
    Lesson2LoadEncryptEvent event,
    Emitter<LessonState> emit,
  ) async {
    emit(LessonLoadingState());
    try {
      List<int> fileBytes = await File(event.file.path!).readAsBytes();
      List<int> encryptedContent = SimplePermutationCipher.encryptBytes(
          fileBytes, Constants.simplePermutationKey);
      String newFileName = '${event.file.path}.encrypted';
      await File('${event.file.path}.encrypted').writeAsBytes(encryptedContent);
      emit(LessonSuccessState(
          result: "Файл успешно зашифрован\nНовый файл: $newFileName"));
    } catch (e) {
      emit(LessonFailureState());
    }
  }

  Future<void> _lesson2decrypt(
    Lesson2LoadDecryptEvent event,
    Emitter<LessonState> emit,
  ) async {
    emit(LessonLoadingState());
    try {
      List<int> fileBytes = await File(event.file.path!).readAsBytes();
      List<int> encryptedContent = SimplePermutationCipher.decryptBytes(
          fileBytes, Constants.simplePermutationKey);
      String newFileName = '${event.file.path}.decrypted';
      await File('newFileName').writeAsBytes(encryptedContent);
      emit(LessonSuccessState(result: "Файл успешно дешифрован\n$newFileName"));
    } catch (e) {
      emit(LessonFailureState());
    }
  }

  Future<void> _lesson4decrypt(
    Lesson4LoadDecryptEvent event,
    Emitter<LessonState> emit,
  ) async {
    emit(LessonLoadingState());
    try {
      String ciphertext = event.text;
      List<String> results =
          AffineCipherAnalyzer.bruteForceAffineDecrypt(ciphertext);
      if (results.isEmpty) {
        emit(LessonFailureState(error: 'не нашлось решений'));
      } else {
        emit(LessonSuccessState(result: results));
      }
    } catch (e) {
      emit(LessonFailureState());
    }
  }

  Future<void> _lesson5encrypt(
    Lesson5LoadEncryptEvent event,
    Emitter<LessonState> emit,
  ) async {
    emit(LessonLoadingState());

    try {
      String newFileName = '${event.file.path}.encrypted';
      await SBlockCipher.encryptFile(event.file.path!, newFileName,
          Constants.lesson5a, Constants.lesson5b);

      emit(LessonSuccessState(
          result: "Файл успешно зашифрован\nНовый файл: $newFileName"));
    } catch (e) {
      emit(LessonFailureState());
    }
  }

  Future<void> _lesson5decrypt(
    Lesson5LoadDecryptEvent event,
    Emitter<LessonState> emit,
  ) async {
    emit(LessonLoadingState());
    try {
      String newFileName = '${event.file.path}.decrypted';
      await SBlockCipher.decryptFile(event.file.path!, newFileName,
          Constants.lesson5a, Constants.lesson5b);
      emit(LessonSuccessState(
          result: "Файл успешно дешифрован\nНовый файл: $newFileName"));
    } catch (e) {
      emit(LessonFailureState());
    }
  }

  Future<void> _lesson6encrypt(
    Lesson6LoadEncryptEvent event,
    Emitter<LessonState> emit,
  ) async {
    emit(LessonLoadingState());

    try {
      List<int> fileBytes = await File(event.file.path!).readAsBytes();
      List<int> encryptedBytes = [];
      for (int byte in fileBytes) {
        int encryptedByte = FeistelCipher.encrypt(byte, 5);
        encryptedBytes.add(encryptedByte);
      }

      String newFileName = '${event.file.path}.encrypted';
      await File(newFileName).writeAsBytes(encryptedBytes);

      emit(LessonSuccessState(
          result: "Файл успешно зашифрован\nНовый файл: $newFileName"));
    } catch (e) {
      emit(LessonFailureState());
    }
  }

  Future<void> _lesson6decrypt(
    Lesson6LoadDecryptEvent event,
    Emitter<LessonState> emit,
  ) async {
    emit(LessonLoadingState());
    try {
      List<int> fileBytes = await File(event.file.path!).readAsBytes();
      List<int> decryptedBytes = [];
      for (int byte in fileBytes) {
        int encryptedByte = FeistelCipher.decrypt(byte, 5);
        decryptedBytes.add(encryptedByte);
      }

      String newFileName = '${event.file.path}.decrypted';
      await File(newFileName).writeAsBytes(decryptedBytes);

      emit(LessonSuccessState(
          result: "Файл успешно дешифрован\nНовый файл: $newFileName"));
    } catch (e) {
      emit(LessonFailureState());
    }
  }

  Future<void> _lesson7(
    Lesson7LoadEvent event,
    Emitter<LessonState> emit,
  ) async {
    emit(LessonLoadingState());
    try {
      String text = event.text;
      // Очистка текста
      String cleanedText = TextEntropyCalculator.cleanText(text);

      // Вычисление Hk/k для k от 1 до 5
      List<double> hkOverKList =
          TextEntropyCalculator.calculateHkOverK(cleanedText, 5);

      // Вывод результатов
      emit(LessonSuccessState(result: hkOverKList));
    } catch (e) {
      emit(LessonFailureState());
    }
  }
}
