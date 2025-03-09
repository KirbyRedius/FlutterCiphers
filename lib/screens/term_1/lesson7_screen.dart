import 'package:cryptography_methods/bloc/lesson/lesson_bloc.dart';
import 'package:cryptography_methods/constants/constants.dart';
import 'package:cryptography_methods/widgets/custom_button.dart';
import 'package:cryptography_methods/widgets/entropy_chart.dart';
import 'package:cryptography_methods/widgets/title_with_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class Lesson7Screen extends StatefulWidget {
  const Lesson7Screen({super.key});

  @override
  State<Lesson7Screen> createState() => _Lesson7ScreenState();
}

class _Lesson7ScreenState extends State<Lesson7Screen> {
  final TextEditingController _controller =
      TextEditingController(text: Constants.lesson7text);
  String cipherText = "";

  @override
  Widget build(BuildContext context) {
    List<double> result = [];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: BlocConsumer<LessonBloc, LessonState>(
          builder: (BuildContext context, LessonState state) {
            if (state is LessonSuccessState) {
              result = state.result as List<double>;
            }
            return SizedBox(
              width: 100.w,
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  TitleWithBack(
                    title: "Задание 7\nМодель открытого текста",
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
                        hintText: 'Введите текст...',
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
                      'Рассчитать Hk/k',
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
                            Lesson7LoadEvent(
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
                      'Результаты Hk/k:',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 15.dp,
                          ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Column(
                      children: result.asMap().entries.map((entry) {
                        int index = entry.key + 1;
                        double value = entry.value;
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 2.w),
                          child: SelectableText(
                            'H$index/$index = $value',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      width: 70.w,
                      height: 40.h,
                      child: EntropyChartScreen(
                        hkOverKValues: result,
                      ),
                    ),
                  ],
                  SizedBox(
                    height: 10.h,
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
