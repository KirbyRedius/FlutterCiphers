import 'package:cryptography_methods/bloc/lesson/lesson_bloc.dart';
import 'package:cryptography_methods/screens/menu_screen.dart';
import 'package:cryptography_methods/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  double widthNow = 1000;
  double heightNow = 800;

  double availableMinusResizeWidth = 0;
  double availableMinusResizeHeight = 100;

  WindowOptions windowOptions = WindowOptions(
    minimumSize: Size(widthNow - availableMinusResizeWidth,
        heightNow - availableMinusResizeHeight),
    maximumSize: Size(widthNow, heightNow),
    size: Size(widthNow, heightNow),
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    center: true,
    titleBarStyle: TitleBarStyle.normal,
    title: "Криптография",
    alwaysOnTop: false,
    windowButtonVisibility: false,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LessonBloc(),
        ),
      ],
      child: FlutterSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            theme: AppTheme.mainTheme,
            // с const размер виджетов не будет меняться при ресайзе
            // ignore: prefer_const_constructors
            home: MenuScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
