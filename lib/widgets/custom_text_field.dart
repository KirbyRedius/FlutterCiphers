import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.w,
      child: TextField(
        controller: controller,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
            ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.onSurface,
          hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
          label: labelText != null
              ? Padding(
                  padding: EdgeInsets.only(left: 0.1.w, top: 2.5.h),
                  child: Text(
                    labelText!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withAlpha(100),
                          fontSize: 19.dp,
                        ),
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
