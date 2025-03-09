import 'package:cryptography_methods/bloc/lesson/lesson_bloc.dart';
import 'package:cryptography_methods/constants/constants.dart';
import 'package:cryptography_methods/utils/linear_congruential_generator.dart';
import 'package:cryptography_methods/widgets/custom_text_field.dart';
import 'package:cryptography_methods/widgets/title_with_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class Term2Lesson1 extends StatefulWidget {
  // начиная с заданий второго семестра лучше делать без блока

  const Term2Lesson1({super.key});

  @override
  State<Term2Lesson1> createState() => _Lesson1ScreenState();
}

class _Lesson1ScreenState extends State<Term2Lesson1> {
  final TextEditingController _aController =
      TextEditingController(text: Constants.term2_lesson1_a.toString());
  final TextEditingController _cController =
      TextEditingController(text: Constants.term2_lesson1_c.toString());
  final TextEditingController _mController =
      TextEditingController(text: Constants.term2_lesson1_m.toString());
  final TextEditingController _x0Controller =
      TextEditingController(text: Constants.term2_lesson1_x0.toString());
  String _result = '';

  void _calculateResult() {
    int? a;
    int? c;
    int? m;
    int? x0;
    String errorText = 'ошибка';
    bool error = false;
    try {
      a = int.parse(_aController.text);
    } catch (e) {
      _aController.text = errorText;
      error = true;
    }

    try {
      c = int.parse(_cController.text);
    } catch (e) {
      _cController.text = errorText;
      error = true;
    }

    try {
      m = int.parse(_mController.text);
    } catch (e) {
      _mController.text = errorText;
      error = true;
    }

    try {
      x0 = int.parse(_x0Controller.text);
    } catch (e) {
      _x0Controller.text = errorText;
      error = true;
    }

    if (error) return;

    String result =
        LinearCongruentialGenerator.solve(a: a!, c: c!, m: m!, x0: x0!);

    setState(() {
      _result = result;
    });
  }

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
                    title:
                        "Задание 1\nГенераторы псевдослучайных последовательностей",
                    onBackButton: () {
                      context.read<LessonBloc>().add(LessonExitEvent());
                    },
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomTextField(
                    controller: _aController,
                    hintText: 'Введите a',
                    labelText: 'a',
                  ),
                  SizedBox(height: 2.h),
                  CustomTextField(
                    controller: _cController,
                    hintText: 'Введите c',
                    labelText: 'c',
                  ),
                  SizedBox(height: 2.h),
                  CustomTextField(
                    controller: _mController,
                    hintText: 'Введите m',
                    labelText: 'm',
                  ),
                  SizedBox(height: 2.h),
                  CustomTextField(
                    controller: _x0Controller,
                    hintText: 'Введите x0',
                    labelText: 'x0',
                  ),
                  SizedBox(height: 2.h),
                  ElevatedButton(
                    onPressed: _calculateResult,
                    child: Text(
                      'Рассчитать',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 15.dp,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    _result,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 15.dp,
                          color: Theme.of(context).colorScheme.surface,
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
