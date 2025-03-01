import 'package:cryptography_methods/screens/lesson1_screen.dart';
import 'package:cryptography_methods/screens/lesson2_screen.dart';
import 'package:cryptography_methods/screens/lesson4_screen.dart';
import 'package:cryptography_methods/screens/lesson5_screen.dart';
import 'package:cryptography_methods/screens/lesson6_screen.dart';
import 'package:cryptography_methods/screens/lesson7_screen.dart';
import 'package:cryptography_methods/utils/navigator_push.dart';
import 'package:cryptography_methods/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    double heightSpacing = 5.h;

    return Scaffold(
      // appBar убран по причине странной полоски: https://github.com/flutter/flutter/issues/57881
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 3.h,
            ),
            Center(
              child: Text(
                "Криптография",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            SizedBox(
              height: heightSpacing,
            ),
            CustomButton(
              width: 45.w,
              height: 10.h,
              text: Text(
                "Задание 1",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              onTap: () => navigatorPush(context, const Lesson1Screen()),
            ),
            SizedBox(
              height: heightSpacing,
            ),
            CustomButton(
              width: 45.w,
              height: 10.h,
              text: Text(
                "Задание 2",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              onTap: () => navigatorPush(context, const Lesson2Screen()),
            ),
            SizedBox(
              height: heightSpacing,
            ),
            CustomButton(
              width: 45.w,
              height: 10.h,
              text: Text(
                "Задание 4",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              onTap: () => navigatorPush(context, const Lesson4Screen()),
            ),
            SizedBox(
              height: heightSpacing,
            ),
            CustomButton(
              width: 45.w,
              height: 10.h,
              text: Text(
                "Задание 5",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              onTap: () => navigatorPush(context, const Lesson5Screen()),
            ),
            SizedBox(
              height: heightSpacing,
            ),
            CustomButton(
              width: 45.w,
              height: 10.h,
              text: Text(
                "Задание 6",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              onTap: () => navigatorPush(context, const Lesson6Screen()),
            ),
            SizedBox(
              height: heightSpacing,
            ),
            CustomButton(
              width: 45.w,
              height: 10.h,
              text: Text(
                "Задание 7",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              onTap: () => navigatorPush(context, const Lesson7Screen()),
            ),
          ],
        ),
      ),
    );
  }
}
