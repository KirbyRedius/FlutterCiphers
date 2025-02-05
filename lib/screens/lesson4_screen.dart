import 'package:cryptography_methods/bloc/lesson/lesson_bloc.dart';
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
  String cipherText = "";

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
                    width: 40.w,
                    height: 40.h,
                    child: TextField(
                      maxLines: 5, // Указываем, что можно вводить в 5 строк
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
                          borderRadius:
                              BorderRadius.circular(16.0), // Закругленные углы
                          borderSide: BorderSide.none, // Без границы
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
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
                    onTap: () {},
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
