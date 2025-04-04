import 'package:cryptography_methods/bloc/lesson/lesson_bloc.dart';
import 'package:cryptography_methods/widgets/custom_button.dart';
import 'package:cryptography_methods/widgets/title_with_back.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class Lesson5Screen extends StatefulWidget {
  const Lesson5Screen({super.key});

  @override
  State<Lesson5Screen> createState() => _Lesson5ScreenState();
}

class _Lesson5ScreenState extends State<Lesson5Screen> {
  PlatformFile? choosedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: BlocConsumer<LessonBloc, LessonState>(
          builder: (BuildContext context, LessonState state) {
            return SizedBox(
              width: 100.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  TitleWithBack(
                    title: "Задание 5\nЭлементы блочных шифров. S-блоки",
                    onBackButton: () {
                      context.read<LessonBloc>().add(LessonExitEvent());
                    },
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "Выберите файл",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomButton(
                    width: 19.w,
                    height: 10.h,
                    text: state is! LessonLoadingState
                        ? Text(
                            "Выбрать",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  fontSize: 15.dp,
                                ),
                          )
                        : const CircularProgressIndicator(),
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.any,
                      );
                      if (result == null) return;
                      if (!context.mounted) return;
                      setState(
                        () {
                          choosedFile = result.files.single;
                        },
                      );
                    },
                  ),
                  if (choosedFile != null)
                    SizedBox(
                      height: 3.h,
                    ),
                  if (choosedFile != null)
                    Text(
                      'Выбранный файл:\n${choosedFile!.name}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 10.dp,
                          ),
                    ),
                  if (choosedFile != null)
                    SizedBox(
                      height: 10.h,
                    ),
                  if (choosedFile != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          text: Text(
                            'Зашифровать',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  fontSize: 15.dp,
                                ),
                          ),
                          width: 19.w,
                          height: 10.h,
                          onTap: () {
                            context.read<LessonBloc>().add(
                                  Lesson5LoadEncryptEvent(
                                    file: choosedFile!,
                                  ),
                                );
                          },
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        CustomButton(
                          text: Text(
                            'Дешифровать',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  fontSize: 15.dp,
                                ),
                          ),
                          width: 19.w,
                          height: 10.h,
                          onTap: () {
                            context.read<LessonBloc>().add(
                                  Lesson5LoadDecryptEvent(
                                    file: choosedFile!,
                                  ),
                                );
                          },
                        ),
                      ],
                    ),
                  if (state is LessonSuccessState)
                    SizedBox(
                      height: 4.h,
                    ),
                  if (state is LessonSuccessState)
                    Text(
                      state.result.toString(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 15.dp,
                          ),
                    ),
                ],
              ),
            );
          },
          listener: (BuildContext context, LessonState state) {},
        ),
      ),
    );
  }
}
