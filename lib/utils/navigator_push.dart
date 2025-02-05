import 'package:flutter/material.dart';

void navigatorPush(BuildContext context, Widget widget) {
  Navigator.of(context).push<void>(
    MaterialPageRoute<void>(
      builder: (BuildContext context) => widget,
    ),
  );
}
