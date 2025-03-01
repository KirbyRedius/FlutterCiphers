part of 'lesson_bloc.dart';

abstract class LessonEvent {}

class LessonExitEvent extends LessonEvent {}

class Lesson1LoadEncryptEvent extends LessonEvent {
  final PlatformFile file;

  Lesson1LoadEncryptEvent({required this.file});
}

class Lesson1LoadDecryptEvent extends LessonEvent {
  final PlatformFile file;

  Lesson1LoadDecryptEvent({required this.file});
}

class Lesson2LoadEncryptEvent extends LessonEvent {
  final PlatformFile file;

  Lesson2LoadEncryptEvent({required this.file});
}

class Lesson2LoadDecryptEvent extends LessonEvent {
  final PlatformFile file;

  Lesson2LoadDecryptEvent({required this.file});
}

class Lesson4LoadDecryptEvent extends LessonEvent {
  final String text;

  Lesson4LoadDecryptEvent({required this.text});
}

class Lesson5LoadEncryptEvent extends LessonEvent {
  final PlatformFile file;

  Lesson5LoadEncryptEvent({required this.file});
}

class Lesson5LoadDecryptEvent extends LessonEvent {
  final PlatformFile file;

  Lesson5LoadDecryptEvent({required this.file});
}

class Lesson6LoadEncryptEvent extends LessonEvent {
  final PlatformFile file;

  Lesson6LoadEncryptEvent({required this.file});
}

class Lesson6LoadDecryptEvent extends LessonEvent {
  final PlatformFile file;

  Lesson6LoadDecryptEvent({required this.file});
}

class Lesson7LoadEvent extends LessonEvent {
  final String text;

  Lesson7LoadEvent({required this.text});
}
