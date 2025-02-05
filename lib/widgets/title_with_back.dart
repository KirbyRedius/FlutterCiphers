import 'package:cryptography_methods/bloc/lesson/lesson_bloc.dart';
import 'package:cryptography_methods/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class TitleWithBack extends StatefulWidget {
  final String title;
  final Function onBackButton;
  const TitleWithBack({
    super.key,
    required this.title,
    required this.onBackButton,
  });

  @override
  State<TitleWithBack> createState() => _TitleWithBackState();
}

class _TitleWithBackState extends State<TitleWithBack> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: 100.w,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                context.read<LessonBloc>().add(LessonExitEvent());
                Navigator.of(context).pop();
              },
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.white,
              ),
            ),
          ),
          Center(
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
