part of 'lesson_bloc.dart';

abstract class LessonEvent {}

class LessonExitEvent extends LessonEvent {}

class Lesson1LoadEncryptEvent extends LessonEvent {
  final PlatformFile file;
  // TODO если все задания связаны с файлами, то перенести в LessonEvent

  Lesson1LoadEncryptEvent({required this.file});
}

class Lesson1LoadDecryptEvent extends LessonEvent {
  final PlatformFile file;
  // TODO если все задания связаны с файлами, то перенести в LessonEvent

  Lesson1LoadDecryptEvent({required this.file});
}

class Lesson2LoadEncryptEvent extends LessonEvent {
  final PlatformFile file;
  // TODO если все задания связаны с файлами, то перенести в LessonEvent

  Lesson2LoadEncryptEvent({required this.file});
}

class Lesson2LoadDecryptEvent extends LessonEvent {
  final PlatformFile file;
  // TODO если все задания связаны с файлами, то перенести в LessonEvent

  Lesson2LoadDecryptEvent({required this.file});
}
