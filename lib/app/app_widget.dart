import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const windowSize = Size(550, 650);
    DesktopWindow.setWindowSize(windowSize);
    DesktopWindow.setMinWindowSize(windowSize);
    DesktopWindow.setMaxWindowSize(windowSize);

    return MaterialApp(
      title: "SleepSync",
      theme: ThemeData(primaryColor: Colors.blue),
    ).modular();
  }
}
