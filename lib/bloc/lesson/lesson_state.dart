part of 'lesson_bloc.dart';

abstract class LessonState {}

class LessonInitialState extends LessonState {}

class LessonLoadingState extends LessonState {}

class LessonFailureState extends LessonState {
  final String? error;
  LessonFailureState({this.error});
}

class LessonSuccessState extends LessonState {
  final Object result;
  LessonSuccessState({required this.result});
}
