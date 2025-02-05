import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cryptography_methods/utils/ciphers/affine.dart';
import 'package:cryptography_methods/utils/ciphers/simple_permutation.dart';
import 'package:cryptography_methods/constants/constants.dart';
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
      await File('${event.file.path}.decrypted').writeAsBytes(encryptedContent);
      emit(LessonSuccessState(result: "Файл успешно дешифрован\n$newFileName"));
    } catch (e) {
      emit(LessonFailureState());
    }
  }
}
