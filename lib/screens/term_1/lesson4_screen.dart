import 'package:cryptography_methods/bloc/lesson/lesson_bloc.dart';
import 'package:cryptography_methods/constants/constants.dart';
import 'package:cryptography_methods/widgets/custom_button.dart';
import 'package:cryptography_methods/widgets/title_with_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class Lesson4Screen extends StatefulWidget {
  const Lesson4Screen({super.key});

  @override
  State<Lesson4Screen> createState() => _Lesson4ScreenState();
}

class _Lesson4ScreenState extends State<Lesson4Screen> {
  final TextEditingController _controller =
      TextEditingController(text: Constants.lesson4text);
  String cipherText = "";

  @override
  Widget build(BuildContext context) {
    List<String>? result = [];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: BlocConsumer<LessonBloc, LessonState>(
          builder: (BuildContext context, LessonState state) {
            if (state is LessonSuccessState) {
              result = state.result as List<String>;
            }
            return SizedBox(
              width: 100.w,
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  TitleWithBack(
                    title: "Задание 4\nКриптоанализ аффинного шифра",
                    onBackButton: () {
                      context.read<LessonBloc>().add(LessonExitEvent());
                    },
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    width: 60.w,
                    child: TextField(
                      controller: _controller,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.tertiary),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.onSurface,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.tertiary),
                        hintText: 'Введите зашифрованный текст...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  CustomButton(
                    text: Text(
                      'Дешифровать',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 15.dp,
                          ),
                    ),
                    width: 20.w,
                    height: 10.h,
                    onTap: () {
                      context.read<LessonBloc>().add(
                            Lesson4LoadDecryptEvent(
                              text: _controller.text,
                            ),
                          );
                    },
                  ),
                  if (state is LessonSuccessState) ...[
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      'Возможные варианты дешифровки:',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 15.dp,
                          ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Column(
                      children: result!.map((text) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 2.w),
                          child: TextField(
                            controller: TextEditingController(text: text),
                            maxLines: null,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  Theme.of(context).colorScheme.onSurface,
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
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
