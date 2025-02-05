part of 'lesson_bloc.dart';

abstract class LessonState {}

class LessonInitialState extends LessonState {}

class LessonLoadingState extends LessonState {}

class LessonFailureState extends LessonState {}

class LessonSuccessState extends LessonState {
  final String result;
  LessonSuccessState({required this.result});
}
